doc.pdf: doc.typ algo.hs result
	typst c doc.typ doc.pdf

doc.png: doc.typ algo.hs result
	typst c doc.typ doc.png

.PHONY: watch
watch:
	typst w doc.typ

result: algo
	./algo > result

algo: algo.hs
	ghc -Wno-tabs algo.hs

.PHONY: clean
clean:
	rm -f algo
	rm -f algo.hi
	rm -f algo.o
	rm -f doc.pdf
	rm -f result
	rm -f doc.png
