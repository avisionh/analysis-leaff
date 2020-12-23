# Summary
This project is an ongoing one to analyse the survey results gathered from the **London East Asia Festival (LEAFF)**.

# Aim
It seeks to gauge how successful the festival was to audience memebers who attended the festival and participated in filling out the survey.

# To Note
Due to data sensitivity and confidentiality, we have masked the data from this repository.

There are two versions of the report:
1. report.Rmd - the PDF version
1. index.Rmd - the HTML version.

These two are slightly different with respect to the PDF version only having the following at the top:
```yaml
output:
  tufte::tufte_handout: default
```
Whereas the HTML version has the following at the top:
```yaml
output:
  tufte::tufte_html: default
  tufte::tufte_book:
    citation_package: natbib
    latex_engine: xelatex
link-citations: yes
```

It also has a very small adjustment in Figure 2 where we can use the `%` symbol for the HTML version but not the PDF version. This is potentially due to TeX renderer that's used to generate the PDF version.
