// Taken from https://training.nextflow.io/basic_training/processes/#output-values,
// with comments added for clarity

process FOO { // process name
    // input and output channels declare value of some variable "x"
    input:
    val x

    output:
    val x

    // 'script' chunk is declared as a shell script that outputs the value of
    // "x" to a file that will be called "x"
    script:
    """
    echo $x > file
    """
}
