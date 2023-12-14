library(tidyverse)

filtered_summary = read.csv(
        '*.txt', sep = '\t', col.names = c('result', 'metric', 'sample_id')
    ) |>
    as_tibble() |>
    mutate(sample_id = str_extract('^(sample[12])\\.fastq\\.gz$', group = 1)) |>
    filter(result == 'FAIL')

sample_id = unique(filtered_summary$sample_id)
stopifnot(length(sample_id) == 1)

filtered_summary.to_csv(paste0(sample_id, '.csv'))
