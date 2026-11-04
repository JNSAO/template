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
\ProvidesClass{jnsao}[2026/11/04 v0.30 JNSAO article]

\newif\if@review
\@reviewfalse
\DeclareOption{review}{\@reviewtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a4paper,11pt,oneside]{article}

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
\RequirePackage{iftex}
% centercolon is not compatible with unicode-math (used for LuaLaTeX)
\ifluatex
  \RequirePackage{mathtools}
\else
  \RequirePackage[centercolon]{mathtools}
\fi
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

\ifluatex
  \RequirePackage{lua-unicode-math} % before fontspec
  \RequirePackage[proportional,osf,nomath]{libertinus}
  \RequirePackage[scale=0.80]{noto-mono}
  % math alphabets (and operator names) from the text fonts, with lining
  % figures (base mode, since OpenType features are not applied in math in
  % node mode)
  \setmathrm{LibertinusSerif}[
    Renderer = Basic, Extension = .otf, Numbers = {Lining,Proportional},
    UprightFont = *-Regular, ItalicFont = *-Italic,
    BoldFont = *-Bold, BoldItalicFont = *-BoldItalic]
  \setboldmathrm{LibertinusSerif}[
    Renderer = Basic, Extension = .otf, Numbers = {Lining,Proportional},
    UprightFont = *-Bold, ItalicFont = *-BoldItalic,
    BoldFont = *-Bold, BoldItalicFont = *-BoldItalic]
  \setmathsf{LibertinusSans}[
    Renderer = Basic, Extension = .otf, Numbers = {Lining,Proportional},
    UprightFont = *-Regular, BoldFont = *-Bold]
  \setmathtt{NotoSansMono}[
    Renderer = Basic, Extension = .ttf, Scale = 0.80,
    UprightFont = *-Regular, BoldFont = *-Bold]
  % math font: Libertinus Math with slanted integrals (stylistic set 8)
  \setmathfont{LibertinusMath-Regular.otf}[StylisticSet = 8,
    BoldFont = LibertinusMath-Regular.otf, BoldFeatures = {FakeBold = 3}]
  % use the (narrower) colon instead of the ratio sign for ':' and \colon
  \Umathcode`\:="3 \symlummain "3A\relax
  % use the precomposed symbols (as with centercolon); mathtools defines its
  % versions at the start of the document
  \AtBeginDocument{%
    \def\coloneqq{\mathrel{≔}}%
    \def\eqqcolon{\mathrel{≕}}%
  }
% URLs in the sans font; since URLs are typeset in math mode, where LuaTeX
% does not apply OpenType features in node mode, use base mode for LuaLaTeX
  \newfontfamily\jnsao@urlfamily{LibertinusSans}[
    Renderer       = Basic,
    Extension      = .otf,
    UprightFont    = *-Regular,
    ItalicFont     = *-Italic,
    BoldFont       = *-Bold,
    Numbers        = {OldStyle,Proportional},
  ]
  \renewcommand{\UrlFont}{\normalfont\jnsao@urlfamily}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[proportional]{libertinus}
  \RequirePackage[libertinus,liby,vvarbb]{newtxmath}
  \RequirePackage[scale=0.80]{noto-mono}
  \useosf
  \renewcommand{\UrlFont}{\normalfont\sffamily}
  % use the monospaced text font also for \mathtt
  \SetMathAlphabet{\mathtt}{normal}{T1}{\ttdefault}{\mddefault}{\shapedefault}
  \SetMathAlphabet{\mathtt}{bold}{T1}{\ttdefault}{\bfdefault}{\shapedefault}
\fi
\frenchspacing
% also in the output routine (headers and footers); the kernel cannot detect
% this itself since amsmath redefines \frenchspacing
\let\normalsfcodes\frenchspacing
\RequirePackage{microtype}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tagging (\DocumentMetadata), supported with LuaLaTeX only
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifjnsao@tagging
\ifluatex
  \IfDocumentMetadataTF{%
    \jnsao@taggingtrue
  }{}
\else
  \IfDocumentMetadataTF{%
    \ClassWarningNoLine{jnsao}{%
      Tagging (\string\DocumentMetadata) is only supported\MessageBreak
      with LuaLaTeX}%
  }{}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paragraphs and lists
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\parindent}{1em}
% nested lists (where \parskip is \parsep of the enclosing list): no extra
% space around the list and between items, only between paragraphs (also
% \partopsep, which is otherwise added by the tagging code to nested blocks)
\newcommand*{\jnsao@listextra}{%
    \ifdim\parskip>\z@ \topsep\z@ \partopsep\z@ \parsep\parskip \itemsep\z@ \fi}
\g@addto@macro\@listii{\jnsao@listextra}
\g@addto@macro\@listiii{\jnsao@listextra}
\g@addto@macro\@listiv{\jnsao@listextra}
\g@addto@macro\@listv{\jnsao@listextra}
\g@addto@macro\@listvi{\jnsao@listextra}
\renewcommand*{\labelitemii}{\labelitemfont\textendash}
\renewcommand*{\labelenumii}{\theenumii)}
\renewcommand*{\descriptionlabel}[1]{\hspace\labelsep\normalfont\sffamily\bfseries #1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts for structural elements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\jnsao@sectfont}{\color{structure}\sffamily}
\newcommand*{\jnsao@titlefont}{\normalfont\jnsao@sectfont\scshape\huge}
\newcommand*{\jnsao@authorfont}{\normalfont\sffamily\large}
\newcommand*{\jnsao@headfootfont}{\normalfont\sffamily\footnotesize}
\newcommand*{\jnsao@labelfont}{\color{structure}\sffamily}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sectioning: colored sans small caps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\jnsao@section@font}{%
    \normalfont\raggedright\jnsao@sectfont\Large\scshape}
\newcommand*{\jnsao@subsection@font}{%
    \normalfont\raggedright\jnsao@sectfont\large\scshape}
\newcommand*{\jnsao@subsubsection@font}{%
    \normalfont\raggedright\jnsao@sectfont\normalsize\scshape\itshape}
\newcommand*{\jnsao@paragraph@font}{%
    \normalfont\jnsao@sectfont\normalsize}

% Vertical spacing of headings (as in the standard classes)
\newcommand*{\jnsao@section@before}{3.5ex \@plus 1ex \@minus .2ex}
\newcommand*{\jnsao@section@after}{2.3ex \@plus .2ex}
\newcommand*{\jnsao@subsection@before}{3.25ex \@plus 1ex \@minus .2ex}
\newcommand*{\jnsao@subsection@after}{1.5ex \@plus .2ex}

% Headings are typeset in small caps, which requires lowercasing the title.
% Do not lowercase arguments of reference commands (see below for \zcref).
\AddToNoCaseChangeList{\ref \eqref \pageref \href \url \thanks}

% Appendices are numbered by (lowercase) letters, sections are prefixed by
% "appendix" (lowercase for small caps like the rest of the heading)
\newcommand*{\jnsao@section@prefix}{}
\AddToHook{cmd/appendix/after}{%
    \gdef\thesection{\textsc{\@alph\c@section}}%
    \gdef\jnsao@section@prefix{appendix}%
}

% With tagging, the (tagging-aware) heading templates of the LaTeX kernel are
% active; configure the existing instances. Otherwise, define the standard
% headings with the same parameters via \@startsection, and lowercase only the
% title in the heading itself (not in the table of contents, bookmarks, or
% marks).
\ifjnsao@tagging
    \EditInstance{heading}{section}{%
        before-vspace = \jnsao@section@before,
        after-vspace  = \jnsao@section@after,
        heading-decls = \jnsao@section@font,
        title-format  = \MakeLowercase{#1}\par,
    }
    \EditInstance{heading}{subsection}{%
        before-vspace = \jnsao@subsection@before,
        after-vspace  = \jnsao@subsection@after,
        heading-decls = \jnsao@subsection@font,
        title-format  = \MakeLowercase{#1}\par,
    }
    \EditInstance{heading}{subsubsection}{%
        before-vspace = \jnsao@subsection@before,
        after-vspace  = \jnsao@subsection@after,
        heading-decls = \jnsao@subsubsection@font,
        title-format  = \MakeLowercase{#1}\par,
    }
    \EditInstance{heading}{paragraph}{%
        before-vspace = \jnsao@subsection@before,
        heading-decls = \jnsao@paragraph@font,
    }
    \EditInstance{heading}{subparagraph}{%
        before-vspace = \jnsao@subsection@before,
        heading-decls = \jnsao@paragraph@font,
    }
    \EditInstance{headformat}{section}{separator-b = \enskip}
    \EditInstance{headformat}{subsection}{separator-b = \enskip}
    \EditInstance{headformat}{subsubsection}{separator-b = \enskip}
    \AddToHook{cmd/appendix/after}{%
        \EditInstance{heading}{section}{text = \jnsao@section@prefix}%
    }
\else
    \NewDocumentCommand{\jnsao@lowercase@heading}{m s o m}{%
        \IfBooleanTF{#2}%
            {#1*{\MakeLowercase{#4}}}%
            {#1[{\IfNoValueTF{#3}{#4}{#3}}]{\MakeLowercase{#4}}}%
    }
    \pdfstringdefDisableCommands{\let\MakeLowercase\@firstofone}
    \newcommand{\jnsao@section}{\@startsection{section}{1}{\z@}%
        {-\glueexpr\jnsao@section@before\relax}{\jnsao@section@after}%
        {\jnsao@section@font}}
    \newcommand{\jnsao@subsection}{\@startsection{subsection}{2}{\z@}%
        {-\glueexpr\jnsao@subsection@before\relax}{\jnsao@subsection@after}%
        {\jnsao@subsection@font}}
    \newcommand{\jnsao@subsubsection}{\@startsection{subsubsection}{3}{\z@}%
        {-\glueexpr\jnsao@subsection@before\relax}{\jnsao@subsection@after}%
        {\jnsao@subsubsection@font}}
    \renewcommand{\section}{\jnsao@lowercase@heading\jnsao@section}
    \renewcommand{\subsection}{\jnsao@lowercase@heading\jnsao@subsection}
    \renewcommand{\subsubsection}{\jnsao@lowercase@heading\jnsao@subsubsection}
    \renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
        {\jnsao@subsection@before}{-1em}{\jnsao@paragraph@font}}
    \renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\parindent}%
        {\jnsao@subsection@before}{-1em}{\jnsao@paragraph@font}}
    \renewcommand*{\@seccntformat}[1]{%
        \ifcsname jnsao@#1@prefix\endcsname
            \ifx\jnsao@section@prefix\@empty\else
                \jnsao@section@prefix\nobreakspace
            \fi
        \fi
        \csname the#1\endcsname\enskip
    }
\fi

% Captions: colored sans labels (the caption text itself is left alone)
\renewcommand*{\fnum@figure}{{\jnsao@labelfont\figurename\nobreakspace\thefigure}}
\renewcommand*{\fnum@table}{{\jnsao@labelfont\tablename\nobreakspace\thetable}}

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
% Footnotes: separation, layout, special format for \thanks
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

% Footnote marks in the current font
\def\@makefnmark{\hbox{\@textsuperscript{\@thefnmark}}}

% Footnote text indented by 1.5em, with the mark hanging into the first line
% (\jnsao@footnotehook is used to switch off line numbers in footnotes)
\let\jnsao@footnotehook\relax
\long\def\@makefntext#1{%
    \jnsao@footnotehook
    \leftskip 1.5em\parindent 1em\noindent\hskip -.5em%
    \hb@xt@\z@{\hss\@makefnmark}#1}

% Footnote rule for other pages than the first page
\def\jnsao@footnoterule{\relax%
    \vskip-\jnsao@footnotesep%
    {\color{gray}\hrule\@width 1cm}%
    \vskip\jnsao@footnotetopsep%
    }%

% Footnote rule for the first page
\def\jnsao@footnoterule@firstpage{\relax%
    \hrule\@width\textwidth\@height 0.4pt%
    }

% Change font for \thanks; the mark does not take up space (as usual)
\protected\def\jnsao@thanks#1{\rlap{\footnotemark}%
    \protected@xdef\@thanks{\@thanks
        \protect\footnotetext[\the\c@footnote]{\sffamily #1}}%
}
\let\thanks\jnsao@thanks

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page layout: different first and other page header/footer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Flush to bottom
\flushbottom

% Header and footer: lines of 11pt (fancyhdr adds struts), separated by a rule
% (see the page styles below)
% First page: two-line header, no footer
\newlength{\jnsao@firstheadheight}
\newlength{\jnsao@firstheadsep}
\setlength{\jnsao@firstheadheight}{25.4pt}
\setlength{\jnsao@firstheadsep}{14pt}
% Other pages: one-line header and footer
\newlength{\jnsao@headheight}
\newlength{\jnsao@headsep}
\newlength{\jnsao@footskip}
\setlength{\jnsao@headheight}{11.8pt}
\setlength{\jnsao@headsep}{16.6pt}
\setlength{\jnsao@footskip}{27pt}

% A4 paper with a centered text block of width 157.5mm; header, text, and
% footer together start 31.6pt below the top edge and end 90.4pt above the
% bottom edge. Set up the first page; the other pages are set up below.
\RequirePackage{geometry}
\geometry{
    a4paper,
    hcentering,
    textwidth=157.5mm,
    includeheadfoot,
    top=31.6pt,
    bottom=90.4pt,
    headheight=\jnsao@firstheadheight,
    headsep=\jnsao@firstheadsep,
    footskip=0pt,
}
% Available space for header, text, and footer
\newlength{\jnsao@fullheight}
\setlength{\jnsao@fullheight}{\textheight+\footskip+\headheight+\headsep}

% First page settings
\setlength{\skip\footins}{\jnsao@footnotesep+0.5\splittopskip}
\let\footnoterule\jnsao@footnoterule@firstpage

% Other pages' settings
\def\jnsao@geometry@otherpages{%
    % Set up geometry of following pages
    \global\skip\footins=\jnsao@standardfootins
    \global\let\footnoterule\jnsao@footnoterule
    \global\headheight=\jnsao@headheight
    \global\headsep=\jnsao@headsep
    \global\footskip=\jnsao@footskip
    \global\textheight=\dimexpr\jnsao@fullheight-\headheight-\headsep-\footskip\relax
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
% keep the date for the header, since \maketitle clears \@date
\def\jnsao@insertdate{\jnsao@date}
\let\jnsao@date\@empty
\AtBeginDocument{\global\let\jnsao@date\@date}
\AddToHook{cmd/maketitle/before}{\global\let\jnsao@date\@date}

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

% Truncate the text stored in a macro (#2) at a word boundary (followed by
% \,\dots) to fit a given width (#1)
\ExplSyntaxOn
\box_new:N \l__jnsao_trunc_box
\seq_new:N \l__jnsao_trunc_seq
\tl_new:N \l__jnsao_trunc_tl
\tl_new:N \l__jnsao_trunc_try_tl
\dim_new:N \l__jnsao_trunc_dim
\cs_new_protected:Npn \jnsao@truncate #1#2
  {
    \dim_set:Nn \l__jnsao_trunc_dim {#1}
    \hbox_set:Nn \l__jnsao_trunc_box {#2}
    \dim_compare:nNnTF { \box_wd:N \l__jnsao_trunc_box } > \l__jnsao_trunc_dim
      {
        \seq_set_split:NnV \l__jnsao_trunc_seq { ~ } #2
        \tl_clear:N \l__jnsao_trunc_tl
        \seq_map_inline:Nn \l__jnsao_trunc_seq
          {
            \tl_set_eq:NN \l__jnsao_trunc_try_tl \l__jnsao_trunc_tl
            \tl_if_empty:NF \l__jnsao_trunc_try_tl
              { \tl_put_right:Nn \l__jnsao_trunc_try_tl { ~ } }
            \tl_put_right:Nn \l__jnsao_trunc_try_tl {##1}
            \hbox_set:Nn \l__jnsao_trunc_box
              { \l__jnsao_trunc_try_tl \jnsao@truncmarker }
            \dim_compare:nNnTF
              { \box_wd:N \l__jnsao_trunc_box } > \l__jnsao_trunc_dim
              { \seq_map_break: }
              { \tl_set_eq:NN \l__jnsao_trunc_tl \l__jnsao_trunc_try_tl }
          }
        \l__jnsao_trunc_tl \jnsao@truncmarker
      }
      { \box_use_drop:N \l__jnsao_trunc_box }
  }
\ExplSyntaxOff
\newcommand*{\jnsao@truncmarker}{\,\dots}

% The title is cleared by \maketitle, so keep a copy for the footer
\let\jnsao@title\@empty
\AtBeginDocument{\global\let\jnsao@title\@title}
\AddToHook{cmd/maketitle/before}{\global\let\jnsao@title\@title}

% Journal information or manuscript status (single line)
\def\jnsao@headinfo{%
    \ifx\jnsao@accepted\empty
        \ifx\jnsao@eprint\empty
            \jnsao@status
        \else
            \jnsao@printeprint
        \fi
    \else
        \jnsao@journalabbrev
        \ifx\jnsao@volume\empty\else\ \jnsao@volume\fi
        \ifx\jnsao@year\empty\else\ (\jnsao@year)\fi
        \ifx\jnsao@number\empty\else, \jnsao@number\fi
    \fi
}

\RequirePackage{fancyhdr}
\fancyhfinit{\jnsao@headfootfont}
\renewcommand*{\headrulewidth}{0.4pt}
\renewcommand*{\footrulewidth}{0.4pt}
\renewcommand*{\headruleskip}{0.8pt}
\renewcommand*{\footruleskip}{0.7pt}

% Regular pages: journal information and page number in the header, (short)
% author and title in the footer, each separated by a rule
\fancypagestyle{jnsao}{%
    \fancyhf{}%
    \fancyhead[L]{%
        \jnsao@headinfo
        \ifx\jnsao@accepted\empty, \jnsao@insertdate\fi
    }%
    \fancyhead[R]{page~\thepage~of~\PreviousTotalPages}%
    \fancyfoot[L]{%
        \jnsao@truncate{0.5\textwidth}\jnsao@shortauthor
    }%
    \fancyfoot[R]{%
        \let\thanks\@gobble % \@title may contain \thanks
        \def\\{ }%
        \ifx\jnsao@shorttitle\empty
            \jnsao@truncate{0.5\textwidth}\jnsao@title
        \else
            \jnsao@truncate{0.5\textwidth}\jnsao@shorttitle
        \fi
    }%
}

% Title page (used by \maketitle): two-line header with full journal
% information, copyright, and license; no footer
\fancypagestyle{plain}{%
    \fancyhf{}%
    \renewcommand*{\headruleskip}{3.4pt}%
    \renewcommand*{\footrulewidth}{0pt}%
    \renewcommand*{\footruleskip}{0pt}%
    \fancyhead[L]{%
        \parbox[b]{0.75\textwidth}{%
            \jnsao@headinfo
            \ifx\jnsao@accepted\empty
                \\date: \jnsao@insertdate
            \else
                \ifx\jnsao@doi\empty\else
                    , \expandafter\doi\expandafter{\jnsao@doi}%
                \fi
                \\%
                \ifx\jnsao@submitted\empty
                    Accepted: \jnsao@accepted
                \else
                    Submitted: \jnsao@submitted, accepted: \jnsao@accepted
                \fi
            \fi
        }%
    }%
    \fancyhead[R]{%
        page~\thepage~of~\PreviousTotalPages\\
        \jnsao@copyright
        \ifx\jnsao@license\empty\else
            , \jnsao@linklicense{\jnsao@license}%
        \fi
    }%
}

\pagestyle{jnsao}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title matter: title block, acknowledgments, abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Typeset acknowledgements as an unmarked footnote
\def\jnsao@insert@ack{{%
    \let\@thefnmark\@empty
    \let\@finalstrut\@gobble
    \long\def\@makefntext##1{\jnsao@footnotehook\noindent##1}%
    \@footnotetext{\parbox[t]{\columnwidth}{\jnsao@ack}}}}

% The footnote set-up in effect at the start of the document (possibly
% adapted for tagging), which \maketitle may change for the title
\AddToHook{begindocument/end}{%
    \let\jnsao@makefntext\@makefntext
    \let\jnsao@makefnmark\@makefnmark
}

% Tagging support for the title block
\ifjnsao@tagging
    \def\jnsao@titleblock{%
        \begin{center}[tagging-suppress-paras=true,
            tagging-recipe=standalone,
            tag-name=\UseStructureName{title/block},
            tag-attr-class=aria-banner]}%
    \def\jnsao@authorrole{\AssignStructureRole{para/textblock}{title-author}}%
    \def\jnsao@titlesocket{\UseTaggingSocket{title}{}}%
\else
    \def\jnsao@titleblock{\begin{center}}%
    \let\jnsao@authorrole\relax
    \let\jnsao@titlesocket\@firstofone
\fi

\renewcommand*{\@maketitle}{%
  % use the same footnote set-up as in the text for \thanks
  \let\thanks\jnsao@thanks
  \let\@makefntext\jnsao@makefntext
  \let\@makefnmark\jnsao@makefnmark
  \global\@topnum=\z@
  \setlength{\parindent}{\z@}%
  \setlength{\parskip}{\z@}%
  \setlength{\parfillskip}{\z@\@plus 1fil}%
  \null
  \vskip 2em%
  \ifx\jnsao@ack\empty
  \else
  \jnsao@insert@ack
  \fi
  \jnsao@titleblock
    {\jnsao@titlefont\jnsao@titlesocket{\MakeLowercase{\@title}}\par}%
    \vskip 1.5em
    {%
      \jnsao@authorfont\jnsao@authorrole
      \lineskip .5em%
      \begin{tabular}[t]{c}
        \@author
      \end{tabular}\par
    }%
    \vskip \z@ \@plus 2em
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
        { \normalfont \jnsao@sectfont \nobreak #1 \quad }
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
    {\normalfont\jnsao@sectfont\nobreak\abstractname\quad}%
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

\newcommand*{\jnsao@linenumberfont}{\normalfont\scriptsize\sffamily\color{gray}}
\if@review
  \ifluatex
    \RequirePackage{lualineno}
    \newcounter{linenumber}
    \lualineno{
      define = {
        name = jnsao
        toks = {\stepcounter{linenumber}}
        left = {\jnsao@linenumberfont\LibertinusSansTLF\thelinenumber\kern 10pt}
      }
      set = jnsao
    }
  \else
    \RequirePackage[mathlines]{lineno}
    \linenumbers
    \renewcommand{\linenumberfont}{\jnsao@linenumberfont}
    \renewcommand\thelinenumber{{\LibertinusSansTLF\arabic{linenumber}}}
  \fi
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
