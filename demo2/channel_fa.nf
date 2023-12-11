#!/usr/bin/env nextflow

pairFiles = Channel.fromPath('./data/ref{1,2}.fa')

pairFiles.view()

