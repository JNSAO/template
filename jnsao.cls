%% jnsao.cls
%% Copyright (c) Christian Clason and Tuomo Valkonen, 2019-2026.
%
% LaTeX class file for articles in the
%
%    Journal of Nonsmooth Analysis and Optimization
%
% Web: http://jnsao.episciences.org
% E-mail: jnsao@episciences.org
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in the file
%
%   http://www.latex-project.org/lppl.txt
%
% This file is part of the "JNSAO journal template" (The work in LPPL)
% and all files in that bundle must be distributed together.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[2025-06-01] % required by keytheorems
\ProvidesClass{jnsao}[2026/11/04 v0.20 JNSAO article]

\newif\if@review
\@reviewfalse
\DeclareOption{review}{\@reviewtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\LoadClass[
    a4paper,
    fontsize=11pt,
    oneside,
    DIV=12,
]{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[svgnames]{xcolor}
\definecolor{hrefcolor}{rgb}{0.0,0.4,0.7}
\definecolor{citecolor}{rgb}{0.0,0.35,0.2}
\definecolor{structure}{rgb}{0.09,0.09,0.44}
\definecolor{halfgray}{gray}{0.55}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load amsmath, amsthm, mathtools, hyperref (in this order!)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[leqno,tbtags]{amsmath}
\RequirePackage{amsthm}
\RequirePackage[centercolon]{mathtools}
\numberwithin{equation}{section}
\numberwithin{figure}{section}
\numberwithin{table}{section}

\RequirePackage[
    colorlinks=true,
    linkcolor=citecolor,
    citecolor=citecolor,
    filecolor=hrefcolor,
    urlcolor=hrefcolor,
    pdfencoding=auto,
    hypertexnames=false,
]{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load and set up fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[T1]{fontenc}
\RequirePackage[proportional]{libertine}
\RequirePackage[libertine,liby,vvarbb]{newtxmath}
\RequirePackage[scaled=0.95,varqu,varl]{inconsolata}
\useosf
\renewcommand{\UrlFont}{\normalfont\sffamily}
% use the monospaced text font also for \mathtt (in the current encoding)
\SetMathAlphabet{\mathtt}{normal}{\encodingdefault}{\ttdefault}{\mddefault}{\shapedefault}
\SetMathAlphabet{\mathtt}{bold}{\encodingdefault}{\ttdefault}{\bfdefault}{\shapedefault}
\frenchspacing
\let\normalsfcodes\frenchspacing % also in the output routines
\RequirePackage{microtype}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Format: title, sectioning in colored sans smallcaps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand*{\sectfont}{\color{structure}\sffamily}
\setkomafont{title}{\color{structure}\normalfont\sffamily\scshape}
\setkomafont{author}{\large\normalfont\sffamily}
\setkomafont{date}{\large\normalfont\sffamily}
\addtokomafont{section}{\scshape}
\addtokomafont{subsection}{\scshape}
\addtokomafont{subsubsection}{\scshape\itshape}

% Number appendices by small caps letters, prefix (only) sections by "appendix"
% (lowercase for small caps like the rest of the heading)
\newcommand*{\appendixmore}{%
    \renewcommand{\thesection}{\textsc{\alph{section}}}%
    \renewcommand*{\sectionformat}{appendix~\thesection\autodot\enskip}%
}

% section headers in small caps (requires lowercasing)
% do not lowercase arguments of reference commands (see below for zcref)
\AddToNoCaseChangeList{\ref \eqref \pageref \href \url \thanks}
\renewcommand*{\sectionlinesformat}[4]{\@hangfrom{\hskip #2#3}{\MakeLowercase{#4}}}

% Format (sub) figure labels
\RequirePackage[labelfont={color=structure,sf}]{caption}
\RequirePackage[labelfont={color=structure,sf}]{subcaption}

% URLs
\renewcommand{\UrlFont}{\normalfont\sffamily}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Format of theorem-like environments.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% provide zref-clever by default with cleveref compat shims
\RequirePackage{zref-clever}
\newcommand{\cref}{\zcref}
\newcommand{\Cref}[1]{\zcref[S]{#1}}
\newcommand{\crefrange}[2]{\zcref[range]{#1,#2}}
\newcommand{\Crefrange}[2]{\zcref[S,range]{#1,#2}}
% Protect zref-clever commands from lowercasing in section headers: the case
% change exclusion list only protects the first braced argument, so star and
% options (e.g., \zcref[S]{...}) would be lowercased. Instead, before the case
% change replace them by an expandable wrapper that hides the full command
% (including star and options, i.e., everything up to the braced argument)
% inside a single excluded argument. Since the reference text is then not
% lowercased, force lowercase reference names (overriding, e.g., S).
\protected\long\def\jnsao@nocase#1{#1}
\AddToNoCaseChangeList{\jnsao@nocase}
\def\jnsao@nocase@cmd#1#2#{\jnsao@nocase@cmd@{#1#2}}
\def\jnsao@nocase@cmd@#1#2{\jnsao@nocase{\jnsao@zcref@lc#1{#2}}}
\NewDocumentCommand\jnsao@zcref@lc{m s O{} m}{%
  \IfBooleanTF{#2}{#1*}{#1}[#3,cap=false,capfirst=false]{#4}%
}
\let\jnsao@zcref\zcref
\let\jnsao@zcpageref\zcpageref
\ExplSyntaxOn
\text_declare_expand_equivalent:Nn \zcref { \jnsao@nocase@cmd \jnsao@zcref }
\text_declare_expand_equivalent:Nn \zcpageref { \jnsao@nocase@cmd \jnsao@zcpageref }
\ExplSyntaxOff

\zcsetup{nameinlink}
\zcLanguageSetup{english}{cap=true} % language-specific so can be overridden
\zcRefTypeSetup{section}{cap=false}
\zcRefTypeSetup{subsection}{cap=false}
\zcRefTypeSetup{item}{
    Name-sg = ,
    name-sg = ,
    Name-pl = ,
    name-pl = ,
}
\zcRefTypeSetup{equation}{
    Name-sg = ,
    name-sg = ,
    Name-pl = ,
    name-pl = ,
}

% set up theorems (including zref hooks)
\RequirePackage[overload]{keytheorems}
\renewkeytheoremstyle{plain}{%
    headfont=\sffamily\color{structure},
    notefont=\sffamily\color{structure},
    bodyfont=\itshape,
}
\renewkeytheoremstyle{definition}{%
    headfont=\sffamily\color{structure},
    notefont=\sffamily\color{structure},
    bodyfont=\upshape
}
\newkeytheorem{theorem}[%
    parent=section,
]
\newkeytheorem{proposition}[%
    sibling=theorem,
]
\newkeytheorem{lemma}[%
    sibling=theorem,
]
\newkeytheorem{corollary}[%
    sibling=theorem,
]
\newkeytheorem{definition}[%
    sibling=theorem,
    style=definition
]
\newkeytheorem{assumption}[%
    sibling=theorem,
    Refname={Assumption,Assumptions},
    style=definition
]
\newkeytheorem{example}[%
    sibling=theorem,
    style=definition
]
\newkeytheorem{remark}[%
    sibling=theorem,
    style=definition
]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Footnotes: separation, special format for \thanks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Store length in base font size
\RequirePackage{calc}
\newlength{\jnsao@footnotesep}
\newlength{\jnsao@footnotetopsep}
\newlength{\jnsao@standardfootins}
\setlength{\jnsao@footnotesep}{0.5\baselineskip}
\setlength{\jnsao@footnotetopsep}{\jnsao@footnotesep}
\setlength{\jnsao@standardfootins}{\jnsao@footnotesep+\baselineskip}
\setlength{\footnotesep}{\baselineskip}

% Footnote rule for other pages than the first page
\def\jnsao@footnoterule{\relax%
    \vskip-\jnsao@footnotesep%
    {\color{gray}\hrule\@width 1cm}%
    \vskip\jnsao@footnotetopsep%
    }%

% Footnote rule for the first page
\def\jnsao@footnoterule@firstpage{\relax%
    \jnsao@headfootrule%
    %\vskip 2pt
    }

% Change font for \thanks
\protected\def\thanks#1{\footnotemark
    \protected@xdef\@thanks{\@thanks
        \protect\footnotetext[\the\c@footnote]{\sffamily #1}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vertical alignment: different first and other page layout
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Flush to bottom
\flushbottom

% Various lengths
\newlength{\jnsao@fullheight}
\newlength{\jnsao@headsep}
\newlength{\jnsao@firstpagehead}
\newlength{\jnsao@firstpageheadplus}
\newlength{\jnsao@headheight}
\newlength{\jnsao@headlineheight}

% Maximum available space for text, header, and footer
\setlength{\jnsao@fullheight}{\textheight+\footskip+\headheight+\headsep}
% Space between header and text
\setlength{\jnsao@headsep}{\baselineskip}
% Height of text lines in header/footer font
\setlength{\jnsao@headlineheight}{11pt}
% First page header height
\setlength{\jnsao@firstpagehead}{2\jnsao@headlineheight}
% ... plus extra for rule and separation
\setlength{\jnsao@firstpageheadplus}{\jnsao@firstpagehead+2.4pt}
% Other pages header (and footer) height plus extra for rule and separation
\setlength{\jnsao@headheight}{\jnsao@headlineheight+2.4pt}

% Recalculate header, footer, and text area heights from:
% #1: header material height
% #2: header separator white space
% #3: footer material height
% #4: footer separator white space
\def\jnsao@setheadfoot#1#2#3#4{%
    \global\headheight=#1%
    \global\headsep=#2%
    \global\footskip=#3%
    \global\advance\footskip by #4%
    \global\footheight=#3% KOMA-script seems to blow up things without this
    \global\textheight=\jnsao@fullheight%
    \global\advance\textheight by -\footskip%
    \global\advance\textheight by -\headheight%
    \global\advance\textheight by -\headsep%
}

% First page settings
\setlength{\skip\footins}{\jnsao@footnotesep+0.5\splittopskip}
\let\footnoterule\jnsao@footnoterule@firstpage
\jnsao@setheadfoot{\jnsao@firstpageheadplus}{\jnsao@headsep}{0em}{0em}

% Other pages' settings
\def\jnsao@geometry@otherpages{%
    % Set up geometry of following pages
    \global\skip\footins=\jnsao@standardfootins
    \global\let\footnoterule\jnsao@footnoterule
    \jnsao@setheadfoot{\jnsao@headheight}{\jnsao@headsep}{\jnsao@headheight}{\jnsao@headsep}
}

% Switch to the regular geometry once the first page has been built, using the
% output routine hook (kernel 2025-06-01) at the end of \@outputpage.
% Since the kernel has already initialized the column height for the next page
% from the old \textheight at this point, reset it to the new value.
\AddToHookNext{build/page/after}{%
    \jnsao@geometry@otherpages
    \global\@colht\textheight
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Date
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[style=iso]{datetime2}
\def\jnsao@insertdate{\@date}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Publication information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\jnsao@submitted\empty
\let\jnsao@accepted\empty
\let\jnsao@volume\empty
\let\jnsao@number\empty
\let\jnsao@year\empty
\let\jnsao@doi\empty
\let\jnsao@eprinttype\empty
\let\jnsao@eprint\empty
\let\jnsao@shortauthor\empty
\let\jnsao@shorttitle\empty
\let\jnsao@ack\empty
\def\jnsao@journalabbrev{J.~Nonsmooth Anal.~Optim.}
\def\jnsao@license{CC-BY-SA 4.0}
\def\jnsao@copyright{\textcopyright{} the authors}
\def\jnsao@status{Manuscript}

\newcommand{\manuscriptsubmitted}[1]{\gdef\jnsao@submitted{#1}}
\newcommand{\manuscriptaccepted}[1]{\gdef\jnsao@accepted{#1}}
\newcommand{\manuscriptvolume}[1]{\gdef\jnsao@volume{#1}}
\newcommand{\manuscriptnumber}[1]{\gdef\jnsao@number{#1}}
\newcommand{\manuscriptlicense}[1]{\gdef\jnsao@license{#1}}
\newcommand{\manuscriptcopyright}[1]{\gdef\jnsao@copyright{#1}}
\newcommand{\manuscriptyear}[1]{\gdef\jnsao@year{#1}}
\newcommand{\manuscriptdoi}[1]{\gdef\jnsao@doi{#1}}
\newcommand{\manuscripteprinttype}[1]{\gdef\jnsao@eprinttype{#1}}
\newcommand{\manuscripteprint}[1]{\gdef\jnsao@eprint{#1}}
\newcommand{\manuscriptstatus}[1]{\gdef\jnsao@status{#1}}
\newcommand{\shortauthor}[1]{\gdef\jnsao@shortauthor{#1}}
\newcommand{\shorttitle}[1]{\gdef\jnsao@shorttitle{#1}}
\newcommand{\funding}[1]{\gdef\jnsao@ack{#1}}

\def\jnsao@licenseurl#1#2{%
    \expandafter\def\csname jnsao@licenseurl@#1 \endcsname{#2}%
}

\RequirePackage{xstring}
\def\jnsao@printeprint{%
    % lowercase is not expandable, so we have to be tricky (https://tex.stackexchange.com/a/87130)
    \lowercase\expandafter{\expandafter\def\expandafter\@tempe\expandafter{\jnsao@eprinttype}}%
    \IfStrEqCase{\@tempe}{%
        {arxiv}{\arxiv{\jnsao@eprint}}%
        {hal}{\hal{\jnsao@eprint}}%
    }[{\sffamily \textsc{\MakeLowercase{\jnsao@eprinttype:}}\,\jnsao@eprint}]%
}
\jnsao@licenseurl{CC-BY}{https://creativecommons.org/licenses/by/4.0/}
\jnsao@licenseurl{CC-BY 4.0}{https://creativecommons.org/licenses/by/4.0/}
\jnsao@licenseurl{CC-BY-SA}{https://creativecommons.org/licenses/by-sa/4.0/}
\jnsao@licenseurl{CC-BY-SA 4.0}{https://creativecommons.org/licenses/by-sa/4.0/}
\jnsao@licenseurl{CC-BY-NC-SA}{https://creativecommons.org/licenses/by-nc-sa/4.0/}
\jnsao@licenseurl{CC-BY-NC-SA 4.0}{https://creativecommons.org/licenses/by-nc-sa/4.0/}
\jnsao@licenseurl{CC-BY-NC}{https://creativecommons.org/licenses/by-nc/4.0/}
\jnsao@licenseurl{CC-BY-NC 4.0}{https://creativecommons.org/licenses/by-nc/4.0/}
\jnsao@licenseurl{CC-BY-NC-ND}{https://creativecommons.org/licenses/by-nc-nd/4.0/}
\jnsao@licenseurl{CC-BY-NC-ND 4.0}{https://creativecommons.org/licenses/by-nc-nd/4.0/}

\def\jnsao@linklicense#1{%
    \ifcsname jnsao@licenseurl@#1 \endcsname%
        \expandafter\let\expandafter\@tempa\csname jnsao@licenseurl@#1 \endcsname%
        \href{\@tempa}{\scshape \MakeLowercase{#1}}%
    \else%
        #1%
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Headers and footers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[fit]{truncate}

\addtokomafont{pageheadfoot}{\normalfont\sffamily\footnotesize}

\def\jnsao@headfootrule{\hrule width \textwidth height 0.4pt}
\def\jnsao@ruledhead#1{\vbox to \headheight{\usekomafont{pageheadfoot}\hbox to \textwidth{#1}\vskip 2pt\jnsao@headfootrule\vfill}}
\def\jnsao@ruledfoot#1{\vbox to \footheight{\usekomafont{pageheadfoot}\vfill\jnsao@headfootrule\vskip 2pt\hbox to \textwidth{#1}}}

\def\ps@jnsao{%
    \def\@oddhead{\jnsao@ruledhead{%
        \ifx\jnsao@accepted\empty{%
            \ifx\jnsao@eprint\empty{%
            \jnsao@status, \jnsao@insertdate%
        }\else{%
            \jnsao@printeprint, \jnsao@insertdate%
        }\fi%
        }\else{%
            \jnsao@journalabbrev%
            \ifx\jnsao@volume\empty{\relax}\else{ \jnsao@volume}\fi%
            \ifx\jnsao@year\empty{\relax}\else{ (\jnsao@year)}\fi%
            \ifx\jnsao@number\empty{\relax}\else{, \jnsao@number}\fi%
        }\fi%
        \hfill%
        page~\thepage~of~\PreviousTotalPages%
    }}
    \def\@oddfoot{\jnsao@ruledfoot{%
        \let\thanks\@gobble% \@title may contain \thanks
        \truncate{0.5\textwidth}{\ifx\jnsao@shortauthor\empty{}\else{\jnsao@shortauthor}\fi}%
        \hfill%
        \truncate{0.5\textwidth}{\ifx\jnsao@shorttitle\empty{\@title}\else{\jnsao@shorttitle}\fi}%
    }}
}

\pagestyle{jnsao}

\def\ps@jnsaotitlepage{%
    \def\@oddhead{\jnsao@ruledhead{%
        \parbox[b][\jnsao@firstpagehead][t]{0.75\textwidth}{%
            \ifx\jnsao@accepted\empty{%
            \ifx\jnsao@eprint\empty{%
                \jnsao@status\\
                date: \jnsao@insertdate \\
            }\else{%
                \jnsao@printeprint\\
                date: \jnsao@insertdate \\
            }\fi%
            }\else{%
                \jnsao@journalabbrev%
                \ifx\jnsao@volume\empty{\relax}\else{ \jnsao@volume}\fi%
                \ifx\jnsao@year\empty{\relax}\else{ (\jnsao@year)}\fi%
                \ifx\jnsao@number\empty{\relax}\else{, \jnsao@number}\fi%
                \ifx\jnsao@doi\empty{\relax}\else{, \expandafter\doi\expandafter{\jnsao@doi}}\fi%
                \\%
                \ifx\jnsao@submitted\empty
                    Accepted: \jnsao@accepted
                \else
                    Submitted: \jnsao@submitted, accepted: \jnsao@accepted
                \fi
                \\
            }\fi%
        }%
        \hfill%
        \parbox[b][\jnsao@firstpagehead][t]{0.25\textwidth}{%
            \hfill page~\thepage~of~\PreviousTotalPages\\%
            \null\hfill\jnsao@copyright
            \ifx\jnsao@license\empty{\relax}
            \else{, \jnsao@linklicense{\jnsao@license}}
            \fi
        }%
    }}
    \def\@oddfoot{}
}

\renewcommand{\titlepagestyle}{jnsaotitlepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title matter: title block, acknowledgments, abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Typeset acknowledgements as an unmarked footnote
\def\jnsao@insert@ack{{%
    \let\@thefnmark\@empty
    \let\@finalstrut\@gobble
    \long\def\@makefntext##1{\noindent##1}%
    \@footnotetext{\parbox[t]{\columnwidth}{\jnsao@ack}}}}

\renewcommand*{\@maketitle}{%
  \global\@topnum=\z@
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
  \null
  \vskip 2em%
  \ifx\jnsao@ack\empty
  \else
  \jnsao@insert@ack
  \fi
  \begin{center}%
    {\usekomafont{title}{\huge \MakeLowercase{\@title} \par}}%
    \vskip .5em
    {\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
    \vskip 1em
    {%
      \usekomafont{author}{%
        \lineskip .5em%
        \begin{tabular}[t]{c}
          \@author
        \end{tabular}\par
      }%
    }%
    \vskip \z@ \@plus 2em
    \ifx\@dedication\@empty \else
      \vskip 2em
      {\usekomafont{dedication}{\@dedication \par}}%
    \fi
  \end{center}%
  \par
  \vskip 2em
}%

% Keywords and MSC codes: comma-separated lists, printed after the abstract
% separated by \cdot; MSC codes are linked to their MathSciNet description
\providecommand{\keywordsname}{Keywords}
\providecommand{\mscname}{MSC (2020)}
\newcommand*{\jnsao@msclink}[1]{%
    \href{https://mathscinet.ams.org/mathscinet/msc/msc2020.html?t=#1}%
        {\sffamily\scshape\MakeLowercase{#1}}%
}
\ExplSyntaxOn
\seq_new:N \g__jnsao_keywords_seq
\seq_new:N \g__jnsao_msc_seq
\NewDocumentCommand \keywords { m } { \seq_gset_from_clist:Nn \g__jnsao_keywords_seq {#1} }
\NewDocumentCommand \msc { m } { \seq_gset_from_clist:Nn \g__jnsao_msc_seq {#1} }
% #1: heading, #2: list, #3: function applied to each item
\cs_new_protected:Npn \__jnsao_print_list:nNN #1#2#3
  {
    \seq_if_empty:NF #2
      {
        \par \medskip \noindent
        { \normalfont \sectfont \nobreak #1 \quad }
        \seq_set_map:NNn \l_tmpa_seq #2 { #3 {##1} }
        \seq_use:Nn \l_tmpa_seq { \nobreakspace $\cdot$ \c_space_tl }
      }
  }
\cs_new_protected:Npn \jnsao@printkeywords
  {
    \__jnsao_print_list:nNN { \keywordsname } \g__jnsao_keywords_seq \use:n
    \__jnsao_print_list:nNN { \mscname } \g__jnsao_msc_seq \jnsao@msclink
  }
\ExplSyntaxOff

% Set up abstract formatting
\renewenvironment{abstract}{%
    \vspace*{-0.75cm}
    \small%
    \quotation%
    \noindent%
    {\normalfont\sectfont\nobreak\abstractname\quad}%
    }{%
    \jnsao@printkeywords
    \endquotation%
    \vskip 0.7cm
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Possibly missing commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providecommand{\arxiv}[1]{\mbox{\scshape\sffamily arxiv:}\,\href{https://arxiv.org/abs/#1}{#1}}
\providecommand{\hal}[1]{\href{https://hal.archives-ouvertes.fr/#1}{#1}}
\providecommand{\doi}[1]{\mbox{\scshape\sffamily doi:}\,\href{https://doi.org/#1}{\detokenize{#1}}}
\providecommand{\orcid}[1]{\mbox{\scshape\sffamily orcid:}\,\href{https://orcid.org/#1}{\detokenize{#1}}}
\providecommand{\email}[1]{\href{mailto:#1}{\sffamily#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% review option: line numbers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@review
  \RequirePackage[mathlines]{lineno}
  \linenumbers
  \renewcommand{\linenumberfont}{\normalfont\scriptsize\sffamily\color{gray}}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PDF metadata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clean up possible LaTeX code in the author and title
\pdfstringdefDisableCommands{%
  \def\thanks#1{}%
  \def\and{, }%
  \def\\{, }%
  \def\email#1{#1}%
  \def\orcid#1{ORCID #1}%
  \def\arxiv#1{arXiv:#1}%
  \def\hal#1{HAL:#1}%
  \def\doi#1{DOI:#1}%
  \def\textsc#1{#1}%
  \def\sffamily{}%
  \def\scshape{}%
}

% Set at begin document and again at \maketitle in case \title or \author
% are given (or changed) after \begin{document}
\def\jnsao@pdfmetadata{%
  \hypersetup{%
    pdftitle  = {\@title},%
    pdfauthor = {\@author},%
  }%
}
\AtBeginDocument{\jnsao@pdfmetadata}
\AddToHook{cmd/maketitle/before}{\jnsao@pdfmetadata}
