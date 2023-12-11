#!/usr/bin/env nextflow
// Specifies nextflow as the interpreter

nextflow.enable.dsl=2 
// Enables DSL2 syntax

process getInput {
// Process definition

  input:
  val(x)
  // Input parameter x 
  
  output: 
  stdout
  // Capture stdout as output

  """
  HelloWorld_script.py ${x}
  """
  // Call python script, pass x param
}

workflow {

  Channel
    .from("Hello", "World!")
    .set { input_ch }
  // Create Channel with input strings
  
  
  getInput(input_ch)
  //Call getInput process, pass Channel 
   
  .view { it }
  // View output of process

} 
// Close workflow definition