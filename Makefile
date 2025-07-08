.PHONY: clean pdf purge watch
FILE := main
OUT  := build
PDF  := $(OUT)/main.pdf

pdf:
	# latexmk -interaction=nonstopmode -outdir=$(OUT) -pdf -halt-on-error $(FILE)
	pdflatex -interaction=nonstopmode -output-directory=$(OUT) $(FILE)
	bibtex $(OUT)/main
	# biber $(OUT)/main
	pdflatex -interaction=nonstopmode -output-directory=$(OUT) $(FILE)
	pdflatex -interaction=nonstopmode -output-directory=$(OUT) $(FILE)
	makeindex $(OUT)/main.glo -s main.ist -o $(OUT)/main.gls
	makeindex $(OUT)/main.nlo -s nomencl.ist -o $(OUT)/main.nls
	sleep 5s
	code build/$(PDF)

# watch:
# latexmk -interaction=nonstopmode -outdir=$(OUT) -pdf -pvc -halt-on-error $(FILE)
# while inotifywait -e modify,create,delete -r .; do \
# 	pdflatex -output-directory=$(OUT) $(FILE); \
# 	bibtex $(OUT)/main; \
# 	pdflatex -output-directory=$(OUT) $(FILE); \
# 	pdflatex -output-directory=$(OUT) $(FILE); \
# done

clean:
	rm -rf $(filter-out $(OUT)/$(FILE).pdf, $(wildcard $(OUT)/*))

purge:
	rm -rf $(OUT)

run:
	$(MAKE) clean
	$(MAKE) pdf
