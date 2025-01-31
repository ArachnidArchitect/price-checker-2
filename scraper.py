import os
import requests
from bs4 import BeautifulSoup
import json
from datetime import datetime, timezone, time
from google.cloud import firestore
import time as sleep_time

# Set GOOGLE_APPLICATION_CREDENTIALS to point to the local service account key
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.path.join(os.path.dirname(__file__), "serviceAccountKey.json")

# Initialize Firestore client
db = firestore.Client()

FIRESTORE_COLLECTION = "checkers_products"

def save_to_firestore(products):
    collection_ref = db.collection(FIRESTORE_COLLECTION)
    for product in products:
        try:
            doc_ref = collection_ref.document(product["id"])
            doc_ref.set(product)
            print(f"Saved to Firestore: {product['name']} - {product['price']}")
        except Exception as e:
            print(f"Error saving to Firestore: {e}")

def scrape_page(page_url):
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    response = requests.get(page_url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        product_frames = soup.find_all('div', class_='product-frame')

        if not product_frames:
            return False

        products = []
        for product in product_frames:
            try:
                product_data = json.loads(product['data-product-ga'])
                name = product_data.get('name', 'Unknown Product')
                price = product_data.get('price', 'N/A')
                product_id = product_data.get('id', 'Unknown ID')

                products.append({
                    "id": product_id,
                    "name": name,
                    "price": price,
                    "scraped_at": datetime.now(timezone.utc).isoformat()
                })
            except (KeyError, json.JSONDecodeError) as e:
                print(f"Error parsing product: {e}")

        save_to_firestore(products)
        return True
    else:
        print(f"Failed to retrieve data. HTTP status code: {response.status_code}")
        return False

def scrape_all_pages():
    base_url = "https://www.checkers.co.za/c-2256/All-Departments?q=%3Arelevance%3AbrowseAllStoresFacetOff%3AbrowseAllStoresFacetOff&page="
    page_number = 541

    while True:
        current_utc_time = datetime.now(timezone.utc).time()
        if current_utc_time < time(00  , 0) or current_utc_time > time(23,59):
            print("Outside allowed scrape time (04:00-16:45 UTC). Exiting.")
            break

        page_url = base_url + str(page_number)
        print(f"Scraping page {page_number}...")

        has_data = scrape_page(page_url)

        if not has_data:
            print("No more data to scrape. Exiting.")
            break

        page_number += 1
        sleep_time.sleep(10)

if __name__ == "__main__":
    scrape_all_pages()
