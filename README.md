[pandoc-mdmb](http://mikebader.github.com/pandoc-mdmb)

Mike Bader, American University

Keywords:       pandoc, LaTeX, workflow

# Summary

Pandoc template files that I use to typeset various forms of materials

Currently includes:

*   Manuscript format to be used with custom `baderart` class that typesets articles in a custom format using LaTeX

The files depend on [pandoc][] and TeX distribution capable of typsetting LaTeX being installed.

[pandoc]: https://pandoc.org/


# Usage 

To use template files, include `--template` option with the path to the intended file, e.g.,

```
pandoc my-manuscript.md -o my-manuscript.pdf --template ~/pandoc-templates/manuscript.latex
```

# Documentation

## manuscript.latex

Requires that `baderart.cls` has been installed on the TeX path (available [here](https://github.com/mikebader/latex-baderart)).

Designed for use of the [pandoc-xnos][] suite of filters created by [Thomas Duck][tomduck]. The `baderart.cls` comes capable of typesetting tables using the [huxtable][] package in R created by David Hugh Jones.

[pandoc-xnos]: https://github.com/tomduck/pandoc-xnos
[tomduck]: http://tomduck.ca/
[huxtable]: https://hughjonesd.github.io/huxtable/


Custom options that you may include in YAML preamble:

* `shorttitle` (string) provides a short title to use as the running header
* `author` provides either a single line of text or a list where each option has a `name` attribute and a `affiliation` attribute:

    ```
    ---
    author:
      - name: Mike Bader
        affiliation: American University
      - name: Mike Wazowski 
        affiliation: Monsters University
    ---
    ```

* `keywords` (list) provides list of keywords that will appear after abstract
* `jel` (list) provides list of [JEL codes](https://www.aeaweb.org/econlit/jelCodes.php) that will appear after abstract
* `unpub` (boolean) adds a disclaimer at top that the manuscript is unpublished
* `doublespace` (boolean) uses double-spacing for manuscript text
* `nodate` (boolean, default = false) suppresses date (the current date will print if `nodate` is false and no date is specified)
* `date` (string) provides date for manuscript (will only appear if `nodate` is false)



