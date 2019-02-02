import sys
from antlr4 import *
from ccLexer import ccLexer
from ccParser import ccParser
 
def main(argv):
    input = FileStream(argv[1])
    lexer = ccLexer(input)
    stream = CommonTokenStream(lexer)
    parser = ccParser(stream)
    tree = parser.startRule()
 
if __name__ == '__main__':
    main(sys.argv)
