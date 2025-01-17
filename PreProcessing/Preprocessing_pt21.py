import pandas as pd

#reading in data
ae_df = pd.read_csv(
    'C:/Users/kirst/Downloads/ae_data_2.csv',
    quotechar = '"',
    skipinitialspace = True
)

ae_df.info()

import ast

non_null_df = ae_df[ae_df['reportduplicate'].notnull()]
print(non_null_df) #should be 13 rows, all with non-null reportduplicate values

#More info about the data
for column in non_null_df.columns:
    has_duplicates = non_null_df[column].duplicated().any()
    print(f"Column '{column}' has duplicates: {has_duplicates}")

#To parse the data, first, I will duplicate the dataset and parse that, then merge it with the first dataset
non_null_copy = non_null_df.copy(deep = True)

#Since reportduplicate is an object variable, I need to convert it to a string
non_null_copy['reportduplicate'] = non_null_copy['reportduplicate'].apply(json.dumps)

non_null_copy.info()

#parsing the data to a dictionary
non_null_copy['parsed_report_data'] = non_null_copy['reportduplicate'].apply(ast.literal_eval)

print(non_null_copy.head())

#separating elements of dictionaries into separate columns 
expanded_data = []

for _, row in non_null_copy.iterrows():
    safetyreportid = row['safetyreportid']
    reactionmeddrapt = row['reactionmeddrapt']
    safetyreportversion = row['safetyreportversion']
    primarysourcecountry = row['primarysourcecountry']
    occurcountry = row['occurcountry']
    reporttype = row['reporttype']
    serious = row['serious']    
    companynumb = row['companynumb']
    duplicate = row['duplicate']
    reportduplicate_duplicatesource = row['reportduplicate_duplicatesource']
    reportduplicate_duplicatenumb = row['reportduplicate_duplicatenumb']
    patient_patientsex = row['patient_patientsex']
    patient_patientonsetage = row['patient_patientonsetage']
    authoritynumb = row['authoritynumb']
    reportdata = row['parsed_report_data']
    
    for reportdata in reportdata:
        expanded_data.append({
            'safetyreportid': safetyreportid,
            'reactionmeddrapt': reactionmeddrapt,
            'safetyreportversion': safetyreportversion,
            'primarysourcecountry': primarysourcecountry,
            'occurcountry':occurcountry,
            'reporttype':reporttype,    
            'serious':serious,    
            'companynumb':companynumb,
            'duplicate':duplicate,
            'reportduplicate_duplicatesource':reportduplicate_duplicatesource,
            'reportduplicate_duplicatenumb': reportduplicate_duplicatenumb,
            'patient_patientsex':patient_patientsex,
            'patient_patientonsetage': patient_patientonsetage,
            'authoritynumb':authoritynumb,
            'duplicatesource': reportdata.get('duplicatesource'),
            'duplicatenumb': reportdata.get('duplicatenumb')
        })
        
expanded_df = pd.DataFrame(expanded_data)

print(expanded_df.head())

#There are now 80 rows in this dataframe, and 13 were originally from the ae_df. that means there are 67 new rows, 
#so when we add those to ae_df, it should have 18399 rows. I will join these tables together in SQL Server.

#Downloading data for further use
expanded_df.to_csv('C:/Users/kirst/Downloads/expanded_ae_data.csv', index=False)



