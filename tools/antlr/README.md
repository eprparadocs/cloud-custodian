Thia is a tool that can scan policy files. It has encoded the policy file as an Antlr grammar (see cc.g4).
It is in its infancy, so don't expect a great deal right now. Ultimately it will take one or more polcy files, 
process them and store information in a database.

I also am planning on extending the tool to do more indepth syntactic and semantic analysis of policies. You
will be able to run the tool and have it detail error information about the policies. Think what a compiler 
does for its input. 

In the future I'm thinking about turning a policy into a directed piece of code (but that is the future). CC 
is a nice tool but it has an expensive overhead because it is always interpreted. I can even see the idea
of a byte-code specific VM. But that is just my thinking.

Files in the directory:

cc.g4 - Antlr grammar for cloud custodian policy files
test.cc - Test policy (primitive today but will get more complete)
REAMDE.md - this file
main.py - main program if python is used

To try it out do the following for JAVA

1) Install java and javac for your environment
2) Install antlr (including the definitions of antlr4 and grun)
3) Generate code:  antlr4 cc.g4
4) Compile the java:  javac *.jave
5) Run the test case:  grun cc start -tokens <test.cc

This will print out some stuff about how the parsing is going.

If you want to use Python3 use this:

1) Generate code:  antlr4 -Dlanguage=Python3 cc.g4
2) Run it this way: python main.py test.cc
 

Any questions please contact me at chuckwegrzyn@yahoo.com


