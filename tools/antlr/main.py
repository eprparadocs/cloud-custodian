import sys
from antlr4 import *
from ccLexer import ccLexer as Lexer
from ccParser import ccParser as Parser
 
def main(argv):
    input = FileStream(argv[1])
    lexer = Lexer(input)
    stream = CommonTokenStream(lexer)
    parser = Parser(stream)
    tree = parser.startRule()
 
if __name__ == '__main__':
    main(sys.argv)
