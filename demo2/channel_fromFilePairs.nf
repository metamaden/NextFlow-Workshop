#!/usr/bin/env nextflow

Channel
    .fromFilePairs('./data/ggal_liver_{1,2}.fq')
    .view()

