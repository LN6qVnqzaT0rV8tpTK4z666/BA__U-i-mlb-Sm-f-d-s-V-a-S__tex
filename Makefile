.PHONY: clean pdf purge watch
FILE := main
OUT  := build

pdf:
	# latexmk -interaction=nonstopmode -outdir=$(OUT) -pdf -halt-on-error $(FILE)
	pdflatex -output-directory=build main.tex
	bibtex build/main
	pdflatex -output-directory=build main.tex
	pdflatex -output-directory=build main.tex

watch:
	latexmk -interaction=nonstopmode -outdir=$(OUT) -pdf -pvc -halt-on-error $(FILE)

clean:
	rm -rf $(filter-out $(OUT)/$(FILE).pdf, $(wildcard $(OUT)/*))

purge:
	rm -rf $(OUT)
