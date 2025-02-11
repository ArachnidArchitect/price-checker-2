import asyncio
import json
from selenium_driverless.types.by import By
from selenium_driverless import webdriver  # Changed import statement
from bs4 import BeautifulSoup

# Function to scrape products from a single page
async def scrape_page(url, page_number):
    full_url = f"{url}{page_number}"  # Append the page number directly to the URL
    try:
        options = webdriver.ChromeOptions()  # Create Chrome options

        async with webdriver.Chrome(options=options) as driver:  # Pass options to the Chrome driver
            await driver.get(full_url, wait_load=True, timeout=120)  # Load the page with wait_load and timeout
            
            # Add a sleep of 10 seconds
            await asyncio.sleep(10)  # Wait for 10 seconds

            # Store the page source in a variable
            page_source = await driver.page_source  # Accessing page_source as a property
            soup = BeautifulSoup(page_source, 'html.parser')

            # Create a variable to hold all product grid items
            product_container = soup.find_all('div', class_='product-grid-item')  # Find all divs with class 'product-grid-item'

            # Extract product details
            products = []
            for product in product_container:
                name = product.get('data-cnstrc-item-name', 'N/A')  # Get name from data attribute
                price = product.get('data-cnstrc-item-price', 'N/A')  # Get price from data attribute
                img = product.find('img', class_='ng-star-inserted')  # Find the image element

                # Append product details to the list
                products.append({
                    'name': name,
                    'price': price,
                    'image_url': img['src'] if img else 'N/A'  # Use img['src'] if img exists
                })

            return products
    except Exception as e:
        print(f"Error scraping {full_url}: {e}")
        return []

# Function to save data to a JSON file
def save_to_json(data, filename='scripts/pnp_data.json'):
    with open(filename, 'a') as f:  # Append mode
        json.dump(data, f, indent=4)
        f.write('\n')  # Newline for readability

# Function to scrape products from all pages of a given URL
async def scrape_all_pages(url):
    page_number = 0  # Start from page 0
    all_products = []

    while True:
        print(f'Scraping {url} - Page {page_number}...')
        products = await scrape_page(url, page_number)

        if not products:  # Stop if no products are found
            print(f'No more products found on {url} - Page {page_number}. Stopping.')
            break

        all_products.extend(products)
        save_to_json(products)
        print(f'Scraped {len(products)} products from {url} - Page {page_number}.')
        page_number += 1

    return all_products

# Main function to scrape multiple URLs
async def main(urls):
    for url in urls:
        print(f'Starting to scrape {url}...')
        await scrape_all_pages(url)
        # Reset page number to 0 for the next URL
        print(f'Resetting page number for the next URL.')

# List of URLs to scrape (without currentPage=)
urls = [
    'https://www.pnp.co.za/c/food-cupboard-423144840?currentPage=', 
    'https://www.pnp.co.za/c/cleaning2036785845?currentPage='  # Adjust the base URL as needed
    # Add more URLs as needed
]

# Run the main function
if __name__ == '__main__':
    asyncio.run(main(urls))