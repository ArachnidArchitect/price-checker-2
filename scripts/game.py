import asyncio
import json
from selenium_driverless import webdriver
from selenium_driverless.types.by import By
from bs4 import BeautifulSoup
import time

async def scrape_products(url):
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    # Add any necessary options here, e.g., headless mode
    async with webdriver.Chrome(options=options) as driver:

        try:
            await driver.get(url, wait_load=True, timeout=120)

            # Scrolling Logic
            scrollable_div = await driver.execute_script("return document.querySelector('.r-1rnoaur');")
            if scrollable_div:
                for _ in range(50):
                    previous_height = await driver.execute_script("return arguments[0].scrollHeight;", scrollable_div)
                    await driver.execute_script("arguments[0].scrollTop = arguments[0].scrollHeight;", scrollable_div)
                    time.sleep(2)  # Pause for content to load
                    new_height = await driver.execute_script("return arguments[0].scrollHeight;", scrollable_div)
                    if new_height == previous_height:
                        break
            else:
                print("Scrollable div not found. Exiting.")
                return []

            # Extract Product Data
            page_source = await driver.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            product_containers = soup.find_all("div", class_="css-1dbjc4n r-1ap4h1l r-xllap1")
            
            stock = []
            for container in product_containers:
                try:
                    name = container.find("div", class_="css-901oao css-cens5h r-1tvphgr r-ukjfwf r-1b43r93 r-14yzgew r-14gqq1x r-17j37da")
                    product_name = name.get_text() if name else "Unknown"

                    price = container.find("div", class_="css-901oao r-g3a1by r-19aw4kv r-1i10wst r-vw2c0b r-knv0ih")
                    product_price = price.get_text() if price else "N/A"

                    image = container.find("img")
                    image_url = image['src'] if image else "No image"

                    stock.append({
                        "name": product_name,
                        "price": product_price,
                        "image": image_url
                    })
                except Exception as e:
                    print(f"Error fetching product details: {e}")

            return stock

        except Exception as e:
            print(f"Error during scraping: {e}")
            return []
        finally:
            await driver.quit()

async def main():
    urlList = [
    'https://www.game.co.za/Groceries-Beverages/Pantry/l/c/G2064', 
    'https://www.game.co.za/Groceries-Beverages/Baby-Food/l/c/G2008', 
    'https://www.game.co.za/Groceries-Beverages/Baking-Supplies/l/c/G2012',
    'https://www.game.co.za/Groceries-Beverages/Breakfast-Cereals/l/c/G2019', 
    'https://www.game.co.za/Groceries-Beverages/Pet-Food/l/c/G2069', 
    'https://www.game.co.za/Groceries-Beverages/Snacks/l/c/G2077'
        # Add more URLs as needed
    ]

    bigList = []
    for url in urlList:
        products = await scrape_products(url)
        bigList.extend(products)

    # Save Data
    with open('scripts/game_data.json', 'w', encoding='utf-8') as f:
        json.dump(bigList, f, ensure_ascii=False, indent=4)

    print(f"Data saved to game_data.json with {len(bigList)} products.")

if __name__ == "__main__":
    asyncio.run(main()) 