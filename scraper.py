import requests
from bs4 import BeautifulSoup
import time
import datetime

# Function to check if the current time is within allowed scraping hours
def is_valid_scraping_time():
    current_utc_time = datetime.datetime.utcnow().time()
    # Check if the time is between 04:00 and 08:45 UTC
    start_time = datetime.time(4, 0)
    end_time = datetime.time(12, 45)
    return start_time <= current_utc_time <= end_time

# Scraping function
def scrape():
    if not is_valid_scraping_time():
        print("Scraping outside of allowed time window.")
        return

    url = "https://www.checkers.co.za/c-2256/All-Departments"
    
    # Send a request with a delay
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    response = requests.get(url, headers=headers)

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

# Run the scraper
scrape()
