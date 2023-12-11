#!/usr/bin/env python3
# Use python3 from user environment

import sys
# Import sys module to access command line arguments

# Get first argument passed in command line 
# This will be value from Nextflow channel
message = sys.argv[1]   

# Print out message  
# Use f-string formatting to include the variable value
print(message)

# This script will run in Nextflow process
# And receive/print values sent through a channel
