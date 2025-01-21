import requests
from bs4 import BeautifulSoup
import time
import datetime

# Function to check if the current time is within allowed scraping hours
def is_valid_scraping_time():
    current_utc_time = datetime.datetime.utcnow().time()
    # Check if the time is between 04:00 and 08:45 UTC
    start_time = datetime.time(4, 0)
    end_time = datetime.time(15, 45)
    return start_time <= current_utc_time <= end_time

# Function to scrape products from a given page URL
def scrape_page(page_url):
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    response = requests.get(page_url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')

        # Find all product frames
        product_frames = soup.find_all('div', class_='product-frame')

        for product in product_frames:
            name = product.find('h3', class_='item-product__name').get_text(strip=True)
            price = product.find('span', class_='now').get_text(strip=True)
            department = "All Departments"  # This is hardcoded for simplicity

            print(f"Name: {name}, Price: {price}, Department: {department}")
            time.sleep(10)  # Respect crawl delay
    else:
        print(f"Failed to retrieve data. HTTP status code: {response.status_code}")

# Function to handle pagination
def scrape_all_pages():
    base_url = "https://www.checkers.co.za/c-2256/All-Departments"
    page_number = 1
    while True:
        # Construct the URL for the current page
        page_url = f"{base_url}?page={page_number}"
        
        if not is_valid_scraping_time():
            print("Scraping outside of allowed time window.")
            return

        print(f"Scraping page {page_number}...")
        scrape_page(page_url)

        # Check if there is a next page (you might need to inspect the HTML to identify this)
        soup = BeautifulSoup(requests.get(page_url).content, 'html.parser')
        next_button = soup.find('a', {'rel': 'next'})  # This is a typical way to identify the "next" button
        
        if next_button:
            page_number += 1
        else:
            break

# Run the scraper
scrape_all_pages()
