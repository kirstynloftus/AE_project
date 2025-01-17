#for creating dataframe
import pandas as pd

#creating dataframe
ae_reaction_df = pd.read_csv(
    'C:/Users/kirst/Downloads/ae_df_id_reaction.csv',
    header = None,
    names = ['safetyreportid', 'reaction_data'],
    dtype = {'safetyreportid': str},
    quotechar = '"',
    skipinitialspace = True
)

print(ae_reaction_df.head())

#for parsing data
import ast

#parsing the data to a dictionary
ae_reaction_df['parsed_reaction_data'] = ae_reaction_df['reaction_data'].apply(ast.literal_eval)

print(ae_reaction_df[['safetyreportid', 'parsed_reaction_data']].head())

#separating elements of dictionary into separate columns 
expanded_data = []

for _, row in ae_reaction_df.iterrows():
    safety_id = row['safetyreportid']
    reactions = row['parsed_reaction_data']
    
    for reaction in reactions:
        expanded_data.append({
            'safetyreportid': safety_id,
            'reactionmeddraversionpt': reaction.get('reactionmeddraversionpt'),
            'reactionmeddrapt': reaction.get('reactionmeddrapt'),
            'reactionoutcome': reaction.get('reactionoutcome')
        })
        
expanded_df = pd.DataFrame(expanded_data)

print(expanded_df.head())

#saving to computer for further SQL pre-processing
expanded_df.to_csv('C:/Users/kirst/Downloads/expanded_ae_data.csv', index=False)