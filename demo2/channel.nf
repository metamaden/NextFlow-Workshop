#!/usr/bin/env nextflow

ch_vl = Channel.value('GRCh38')
ch_vl.view()

ch_qu = Channel.of('chr1', 'chr2', 'chr3')
ch_qu.view { "Processing data for ${it}" }
