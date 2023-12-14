import glob
import pandas as pd

filtered_paths = glob.glob('*.csv')

combined_summary = pd.concat([pd.read_csv(filtered_paths)])

print('Number of failed metrics by sample:')
combined_summary.groupby('sample_id').value_counts()

combined_summary.to_csv('combined_summary.csv')
