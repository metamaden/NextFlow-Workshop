#!/usr/bin/env Rscript

library(tidyverse)

filtered_summary = list.files(pattern = '.*\\.txt$') |>
    read.csv(sep = '\t', col.names = c('result', 'metric', 'sample_id')) |>
    as_tibble() |>
    mutate(sample_id = str_extract(sample_id, '^(sample[12])\\.fastq\\.gz$', group = 1)) |>
    filter(result == 'FAIL')

sample_id = unique(filtered_summary$sample_id)
stopifnot(length(sample_id) == 1)

write_csv(filtered_summary, paste0(sample_id, '_filtered_summary.csv'))
