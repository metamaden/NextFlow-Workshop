#!/usr/bin/env python3

import glob
import pandas as pd

filtered_paths = glob.glob('*.csv')

combined_summary = pd.concat([pd.read_csv(x) for x in filtered_paths])

print('Number of failed metrics by sample:')
combined_summary.groupby(['sample_id', 'result']).count()

combined_summary.to_csv('combined_summary.csv', index = False)
