.PHONY: gen

gen:
	bash -i -c 'antlr4 -Dlanguage=Python3 cc.g4'

ccLexer.py:
	bash -i -c 'antlr4 -Dlanguage=Python3 cc.g4'

run:	ccLexer.py ccParser.py
	python3 main.py test.cc

clean:
	rm -f *.java *.class
	rm -f *.tokens *.interp
	rm -f ccParser.py ccLexer.py ccListener.py
	rm -rf __pycache__

