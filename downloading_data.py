#importing packages
import requests; import json; import pandas as pd

#Making it easier to query FDA FAERS API
drug_name = "atorvastatin"
base_url = "https://api.fda.gov/drug/event.json"
limit = 100
max_records = 6000
skip = 0
results = []

#Getting data from the API
while len(results) < max_records:
    print(f"Fetching records {skip} to {skip + limit}...")
    
    query = f"{base_url}?search=patient.drug.medicinalproduct:{drug_name}&limit={limit}&skip={skip}"
    
    response = requests.get(query)
    
    if response.status_code != 200:
        print(f"Error: {response.status_code}, {response.text}")
        break
    
    data = response.json()
    fetched_results = data.get("results",[])
    results.extend(fetched_results)
    
    if len(fetched_results) < limit:
        break
    
    skip += limit

#saving data to a JSON file
with open(f"{drug_name}_data.json", "w") as file:
    json.dump(results[:max_records],file)

print(f"Downloaded {len(results[:max_records])} records and saved to '{drug_name}_data.json'.")

#Converting JSON data to a flat table
with open(f"{drug_name}_data.json", "r") as file:
    data = json.load(file)

ae_df = pd.json_normalize(data)

#saving to my directory so I can use SQL Server now
ae_df.to_csv(r'C:\Users\kirst\Downloads\ae_df.csv', index = False)

print(f"Downloaded {len(results[:max_records])} records and saved to ae_df.csv.")