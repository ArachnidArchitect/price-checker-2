import requests
from bs4 import BeautifulSoup
import time
import datetime

# Function to check if the current time is within allowed scraping hours
def is_valid_scraping_time():
    current_utc_time = datetime.datetime.utcnow().time()
    # Check if the time is between 04:00 and 08:45 UTC
    start_time = datetime.time(4, 0)
    end_time = datetime.time(8, 45)
    return start_time <= current_utc_time <= end_time

# Function to scrape products from a given page URL
def scrape_page(page_url):
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    response = requests.get(page_url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')

        # Find all product frames
        product_frames = soup.find_all('div', class_='product-frame')

        # If no product frames are found, return False to stop pagination
        if not product_frames:
            return False

        # Extract and print product details
        for product in product_frames:
            name = product.find('h3', class_='item-product__name').get_text(strip=True)
            price = product.find('span', class_='now').get_text(strip=True)
            department = "All Departments"  # This is hardcoded for simplicity
            print(f"Name: {name}, Price: {price}, Department: {department}")
        
        return True
    else:
        print(f"Failed to retrieve data. HTTP status code: {response.status_code}")
        return False

# Function to handle pagination
def scrape_all_pages():
    base_url = "https://www.checkers.co.za/c-2256/All-Departments?q=%3Arelevance%3AbrowseAllStoresFacetOff%3AbrowseAllStoresFacetOff&page="
    page_number = 0

    while True:
        # Construct the URL for the current page
        page_url = f"{base_url}{page_number}"
        
        if not is_valid_scraping_time():
            print("Scraping outside of allowed time window.")
            return

        print(f"Scraping page {page_number}...")
        has_data = scrape_page(page_url)
        
        if not has_data:
            print("No more products found. Ending pagination.")
            break

        # Delay between pages
        time.sleep(10)
        page_number += 1

# Run the scraper
scrape_all_pages()
