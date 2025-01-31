import time
import datetime
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys

# Function to check if the scraping time is within the allowed range (UTC 6 AM to 10 PM)
def is_valid_scraping_time():
    current_utc_time = datetime.datetime.now(datetime.timezone.utc).time()
    start_time = datetime.time(6, 0)  # 6:00 AM UTC
    end_time = datetime.time(22, 0)  # 10:00 PM UTC
    return start_time <= current_utc_time <= end_time

# Function to scrape each page using Selenium
def scrape_page(page_url, config, driver):
    print(f"Scraping: {page_url}")
    driver.get(page_url)
    
    # Allow time for the page to fully load
    time.sleep(5)
    
    # Now that the page has loaded, get the page source
    page_source = driver.page_source
    
    # Parse the page source with BeautifulSoup
    soup = BeautifulSoup(page_source, 'html.parser')
    
    # Find all product elements using more precise selectors
    product_elements = soup.find_all('div', class_='product-grid-item list-mobile ng-star-inserted')
    
    if not product_elements:
        print("No products found on this page.")
        return False

    print(f"Found {len(product_elements)} products")
    
    for product in product_elements[:5]:  # Print the first 5 product elements for debugging
        print(product.prettify())  # Show the detailed structure of the product element
        
        try:
            product_name = product['data-cnstrc-item-name']
            product_price = product['data-cnstrc-item-price']
            product_id = product['data-cnstrc-item-id']
            product_image = product.select_one('img')['src']
            
            print(f"Product Name: {product_name}")
            print(f"Price: {product_price}")
            print(f"Product ID: {product_id}")
            print(f"Image URL: {product_image}")
            print("----")

            # Commented out: Push data to Firestore for testing
            # product_data = {
            #     'name': product_name,
            #     'price': float(product_price.replace('R', '').strip()),
            #     'id': product_id,
            #     'image_url': product_image,
            #     'scraped_at': datetime.datetime.now().isoformat(),
            # }

            # Firestore push (commented out for now)
            # db.collection(config['collection']).document(product_id).set(product_data)

        except Exception as e:
            print(f"Error processing product: {e}")
            continue

    return True

# Function to scrape all pages of the website
def scrape_all_pages(config):
    if not is_valid_scraping_time():
        print("Scraping is not allowed during this time.")
        return

    page_number = 0
    while True:
        page_url = config['base_url'].format(page=page_number)
        has_data = scrape_page(page_url, config, driver)

        if not has_data:
            print("No more pages to scrape.")
            break

        page_number += 1
        time.sleep(10)  # Delay between pages

# Store-specific configuration for Pick n Pay
pnp_config = {
    'base_url': 'https://www.pnp.co.za/c/pnpbase?currentPage={page}',  # URL for Pick n Pay
    'product_selector': 'div.product-grid-item',  # CSS selector for product items
    'name_attr': 'data-cnstrc-item-name',  # Attribute for product name
    'price_attr': 'data-cnstrc-item-price',  # Attribute for product price
    'id_attr': 'data-cnstrc-item-id',  # Attribute for product ID
    'image_selector': 'img',  # CSS selector for product image
    'collection': 'pnp_products',  # Firebase collection (commented out for now)
}

# Setup Selenium WebDriver
chrome_options = Options()
chrome_options.add_argument('--headless')  # Run in headless mode (without opening a browser window)
service = Service('path/to/chromedriver')  # Specify the path to ChromeDriver
driver = webdriver.Chrome(service=service, options=chrome_options)

# Main function to start scraping
if __name__ == "__main__":
    scrape_all_pages(pnp_config)

# Don't forget to close the WebDriver after use
driver.quit()
  