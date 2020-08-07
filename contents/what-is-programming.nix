(import ../newPost.nix)
  { name = "what-is-programming"; 
    tags = [ "draft" "functional-programming" "philosophy"];
    title = "What is Programming?";
  } (conix: [
"# "(conix.at ["posts" "what-is-programming" "meta" "title"])
''

## Definitions

What is programming 
-> FP makes dividing the problem and combining the solutions easier
-> Solutions to each problem can be expressed in its own language
-> Combining those languages makes it easy to combine the solutions.
-> Domain specific languages that can be combined together makes it easier to
   write total solutions to problems.
-> EAQL is one such language. 

A program is an encoding of a solution that can be later recalled
and executed.

The meaning of "encode", "solution", "recall", and "execute" all depend on the 
context of the problem.

Programming is the act of creating a program.

  * Cooking. The program is the recipe; the execution is the cooking.
  * Law. The program is the law; the execution are the sentences carried out by
    the law.
  * Doctors. The program are the textbooks on treatments; the execution is the
    diagnosis and treatment of patients.

''])
