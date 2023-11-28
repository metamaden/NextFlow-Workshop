# Three ways to use R in a Nextflow process

Example 1: pipe using "R --slave"

```
shell:
"""
echo "2 + 2" | R --slave > newoutput.txt
"""
```

Example 2: declare shebang to run as an R script

```
shell:
"""
#!/usr/bin/env Rscript
obj <- "hello"
save(obj, file = "newfile.rmd")
"""
```

Example 3: call `Rscript` (or `R CMD BATCH`) from shell

```
script:
"""
Rscript $params.rscriptpath -f $filepath -v $value
"""
```
