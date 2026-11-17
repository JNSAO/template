# JNSAO LaTeX class

LaTeX class and BibTeX style for submissions to the
[Journal of Nonsmooth Analysis and Optimization](https://jnsao.episciences.org) (JNSAO).

## Contents

| File | Purpose |
| --- | --- |
| `jnsao.cls` | document class (based on KOMA-Script `scrartcl`) |
| `jnsao.bst` | BibTeX bibliography style |
| `jnsao_template.tex`, `jnsao_template.bib` | template and documentation of the class |
| `00README.json` | configuration file for submissions to arXiv (see below) |

The latest version can be downloaded as `jnsao.zip` from the
[releases page](https://github.com/clason/jnsao/releases).

## Requirements

A recent TeX distribution (TeX Live 2025 or newer, LaTeX kernel 2025-06-01 or
newer) and pdfLaTeX. Besides the KOMA-Script bundle, the class uses (among others)
`amsmath`, `mathtools`, `hyperref`, `caption`/`subcaption`, `zref-clever`,
`keytheorems`, `datetime2`, `libertine`, `newtx`, `inconsolata`, `microtype`,
`truncate`, and `xstring`; see `.github/tlpackages` for the full list of TeX Live
packages needed.

## Usage

Start from `jnsao_template.tex`, which also documents all features. In short:

```latex
\documentclass[review]{jnsao}

\title{Title of the article}
\shorttitle{Short title}             % for running heads
\author{Anne Author\thanks{Affiliation, \email{anne@example.org}, \orcid{0000-0000-0000-0000}}}
\shortauthor{A.~Author}              % for running heads
\funding{Funding information.}       % first-page footnote
\keywords{first, second}             % optional
\msc{49J52, 90C25}                   % optional

\begin{document}
\maketitle
\begin{abstract}
    The abstract goes here.
\end{abstract}
...
\section*{Acknowledgments}           % other acknowledgments (optional)
...
\appendix
...
\bibliographystyle{jnsao}
\bibliography{references}
\end{document}
```

### Class options

- `review`: add line numbers for easier reference in review reports.

All other options are passed to `scrartcl`; note that paper size, font size, and
type area are fixed by the class.

### Keywords and MSC codes

The optional commands `\keywords{...}` and `\msc{...}` (Mathematics Subject
Classification) take comma-separated lists, which are printed at the end of the
abstract if not empty.

### Acknowledgments

Funding information (grants, funding agencies) and similar formal acknowledgments
are given with `\funding{...}` in the preamble and typeset as an unmarked footnote on
the first page. All other acknowledgments (e.g., thanking colleagues, declaring the
use of AI tools) belong in an unnumbered section `\section*{Acknowledgments}` after
the main text and before the appendix.

### Publication information

The following commands set the information shown in the page headers. Most
of them are only to be filled in once the article has been accepted.

| Command | Description |
| --- | --- |
| `\date{yyyy-mm-dd}` | date shown in the header before acceptance (default: current date) |
| `\manuscriptsubmitted{yyyy-mm-dd}` | submission date (shown on the first page after acceptance) |
| `\manuscriptaccepted{yyyy-mm-dd}` | acceptance date |
| `\manuscriptvolume{...}`, `\manuscriptnumber{...}`, `\manuscriptyear{...}` | volume, article number, and year |
| `\manuscriptdoi{...}` | DOI of the published article |
| `\manuscripteprinttype{arXiv\|HAL}`, `\manuscripteprint{...}` | eprint identifier shown in the header of preprints |
| `\manuscriptcopyright{...}`, `\manuscriptlicense{...}` | copyright holder and license (default: CC-BY-SA 4.0) |

### Theorems and references

The environments `theorem`, `proposition`, `lemma`, `corollary`, `definition`,
`assumption`, `example`, and `remark` are predefined (using `keytheorems`).

References are handled by `zref-clever` (use `\zcref`); for compatibility with
`cleveref`, the commands `\cref`, `\Cref`, `\crefrange`, and `\Crefrange` are
provided. Do not load `cleveref` yourself. The reference format should not be
changed; for labels of additional counters, define the reference names with
`\zcRefTypeSetup` (see the template).

### Bibliography

Use BibTeX with the provided `jnsao.bst`. Note that the case of titles is *not*
adjusted, so use Title Case for journal, book, and thesis titles and Sentence case
for articles and chapters. Preprints on arXiv and HAL are supported via the
`eprinttype` (or `archiveprefix`) and `eprint` fields; see the template for
details.

## Submitting to arXiv

When submitting a preprint using this class to arXiv, include the provided
`00README.json` together with the class and style files.

## License

This work may be distributed and/or modified under the conditions of the
[LaTeX Project Public License](https://www.latex-project.org/lppl.txt), either
version 1.3c of this license or (at your option) any later version. All files in
this bundle must be distributed together.

## Contact

Questions about the journal and submissions: jnsao@episciences.org.
Issues with the class can be reported on
[GitHub](https://github.com/clason/jnsao/issues).
