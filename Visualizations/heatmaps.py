# -*- coding: utf-8 -*-
"""Heatmaps.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1yK7fE37rk_-li4RQ5wU03d-42BEKscvb

# Create Dataframe
"""

import pandas as pd

df = pd.read_csv('clean_data.csv')

df = df.dropna()

df['EVT'] = df['Electric Vehicle Type'].apply(lambda x: 1 if x == 'BATTERY' else 0)

df['CAFV Eligibility'] = df['Clean Alternative Fuel Vehicle (CAFV) Eligibility'].apply(lambda x: 1 if x == 'ELIGIBLE' else 0)

df.head()

"""# Map Visualization"""

import folium
from folium.plugins import HeatMap
import pandas as pd

df[['Longitude', 'Latitude']] = df['Vehicle Location'].str.split(' ', expand=True)
df['Longitude'] = df['Longitude'].astype(float)
df['Latitude'] = df['Latitude'].astype(float)

#center map
m = folium.Map(location=[df['Latitude'].mean(), df['Longitude'].mean()], zoom_start=10)

#prep data
heat_data = [[row['Latitude'], row['Longitude']] for _, row in df.iterrows()]

#add heatmap
HeatMap(heat_data).add_to(m)

m.save("heatmap_with_coordinates.html")
print("Heatmap saved as 'heatmap_with_coordinates.html'. Open it in a browser to view.")

"""# Eligibility Heatmap"""

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


#count occurance
occurrences = df.groupby(['Electric Vehicle Type', 'CAFV Eligibility']).size().reset_index(name='Occurrences')

#mutate data
heat_data_pivot = occurrences.pivot(index='Electric Vehicle Type', columns='CAFV Eligibility', values='Occurrences').fillna(0)

#create heatmap
plt.figure(figsize=(10, 6))
sns.heatmap(heat_data_pivot, annot=True, cmap='YlGnBu', fmt='d')

#labels
plt.title('Heatmap: CAFV Eligibility vs Electric Vehicle Type')
plt.xlabel('CAFV Eligibility (0: No, 1: Yes)')
plt.ylabel('Electric Vehicle Type')

plt.show()

"""# District Heatmap vs vehicle type"""

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

#count
occurrences = df.groupby(['Legislative District', 'Electric Vehicle Type']).size().reset_index(name='Occurrences')

#find and filter to top 5
top_5_districts = occurrences.groupby('Legislative District')['Occurrences'].sum().nlargest(5).index

filtered_occurrences = occurrences[occurrences['Legislative District'].isin(top_5_districts)]

#mutate data
heat_data_pivot = filtered_occurrences.pivot_table(index='Legislative District', columns='Electric Vehicle Type', values='Occurrences', aggfunc='sum').fillna(0)

#create heatmap
plt.figure(figsize=(12, 8))
sns.heatmap(heat_data_pivot, annot=True, cmap='YlGnBu', fmt='d')

#labels
plt.title('Heatmap: Top 5 Legislative Districts vs Electric Vehicle Type')
plt.xlabel('Electric Vehicle Type')
plt.ylabel('Legislative District')

plt.show()