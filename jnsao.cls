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

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jnsao}[2026/10/24 v0.16 JNSAO article]

\DeclareOption{review}{\@reviewtrue}
\newif\if@review
\@reviewfalse

\ProcessOptions\relax

\LoadClass[
    a4paper,
    fontsize=11pt,
    oneside
]{scrartcl}
\KOMAoptions{DIV=12}

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
\frenchspacing
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

% title in small caps (requires lowercasing, label abstract
\RequirePackage[overload]{textcase}

% Prefix appendices with "Appendix"
\newcommand{\jnsao@appname}{\relax}
\newcommand*{\appendixmore}{%
    \renewcommand{\jnsao@appname}{Appendix~}
    \renewcommand{\thesection}{{\scshape\alph{section}}}
}

% section headers in small caps (requires lowercasing)
\renewcommand*\sectionformat{\MakeLowercase{\jnsao@appname\thesection}\enskip}
\renewcommand*\subsectionformat{\MakeLowercase{\jnsao@appname\thesubsection}\enskip}
\renewcommand*\subsectionformat{\MakeLowercase{\jnsao@appname\thesubsection}\enskip}
\renewcommand*\subsubsectionformat{\upshape\MakeLowercase{\jnsao@appname\thesubsubsection}\enskip}

\let\jnsao@old@section\section
\renewcommand*{\section}{%
    \@ifstar {\star@section}{\@dblarg\nonstar@section}%
}
\newcommand*{\star@section}[1]{%
    \jnsao@old@section*{\MakeLowercase{#1}}%
}
\newcommand*{\nonstar@section}[2][]{%
    \jnsao@old@section[{#1}]{\MakeLowercase{#2}}%
}
\let\jnsao@old@subsection\subsection
\renewcommand*{\subsection}{%
    \@ifstar {\star@subsection}{\@dblarg\nonstar@subsection}%
}
\newcommand*{\star@subsection}[1]{%
    \jnsao@old@subsection*{\MakeLowercase{#1}}%
}
\newcommand*{\nonstar@subsection}[2][]{%
    \jnsao@old@subsection[{#1}]{\MakeLowercase{#2}}%
}
\let\jnsao@old@subsubsection\subsubsection
\renewcommand*{\subsubsection}{%
    \@ifstar {\star@subsubsection}{\@dblarg\nonstar@subsubsection}%
}
\newcommand*{\star@subsubsection}[1]{%
    \jnsao@old@subsubsection*{\MakeLowercase{#1}}%
}
\newcommand*{\nonstar@subsubsection}[2][]{%
    \jnsao@old@subsubsection[{#1}]{\MakeLowercase{#2}}%
}

% Format (sub) figure labels
\RequirePackage[labelfont={color=structure,sf}]{caption}
\RequirePackage[labelfont={color=structure,sf}]{subcaption}

% Url
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
\zcRefTypeSetup{algocf}{
    Name-sg = Algorithm ,
    name-sg = algorithm ,
    Name-pl = Algorithms ,
    name-pl = algorithms ,
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
\def\thanks#1{\footnotemark
    \protected@xdef\@thanks{\@thanks
        \protect\jnsao@thankstext[\the\c@footnote]{\sffamily #1}}%
}
\def\jnsao@thankstext{\sffamily%
     \@ifnextchar [\@xfootnotenext
       {\protected@xdef\@thefnmark{\thempfn}%
    \@footnotetext}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vertical alignment. This hacks and wraps \@outputpage and
% and latex.ltx limitations to have different geometry for
% the first page
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

% \@outputpage hack to reset settings after first page
\let\jnsao@old@outputpage\@outputpage
\def\jnsao@output@firstpage{
    \jnsao@old@outputpage%
    \jnsao@geometry@otherpages%
    % This is needed for something to actually happen after the reset above,
    % as standard \@outputpage does the same thing at the end
    \global\@colht\textheight%
    % Reset page output routine
    \global\let\jnsao@output@page\jnsao@old@outputpage%
}

\def\@outputpage{\jnsao@output@page}
\let\jnsao@output@page\jnsao@output@firstpage

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Date
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{scrdate}
\date{\ISOToday}

% Over-ride \today with \ISOdate when we insert it. This is needed because Babel
% reset \date{\ISOToday} into a locale format.
\def\jnsao@insertdate{{\let\today\ISOToday\@date}}
%\def\date#1{\gdef\@date{\let\today\ISOToday#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Publication information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\jnsao@submitted\empty
\let\jnsao@accepted\empty
\let\jnsao@journal\empty
\let\jnsao@volume\empty
\let\jnsao@number\empty
\let\jnsao@year\empty
\let\jnsao@doi\empty
\let\jnsao@eprinttype\empty
\let\jnsao@eprint\empty
\let\jnsao@shortauthor\empty
\let\jnsao@shorttitle\empty
\let\jnsao@ack\empty
\def\jnsao@journal{Journal of Nonsmooth Analysis and Optimization}
\def\jnsao@journalabbrev{J.~Nonsmooth Anal.~Optim.}
\def\jnsao@license{CC-BY-SA 4.0}
\def\jnsao@copyright{{\copyright} the authors}
\def\jnsao@status{Manuscript}

\newcommand{\manuscriptsubmitted}[1]{\gdef\jnsao@submitted{#1}}
\newcommand{\manuscriptaccepted}[1]{\gdef\jnsao@accepted{#1}}
\newcommand{\manuscriptvolume}[1]{\gdef\jnsao@volume{#1}}
\newcommand{\manuscriptnumber}[1]{\gdef\jnsao@number{#1}}
\newcommand{\manuscriptjournal}[1]{\gdef\jnsao@journal{#1}}
\newcommand{\manuscriptlicense}[1]{\gdef\jnsao@license{#1}}
\newcommand{\manuscriptcopyright}[1]{\gdef\jnsao@copyright{#1}}
\newcommand{\manuscriptyear}[1]{\gdef\jnsao@year{#1}}
\newcommand{\manuscriptdoi}[1]{\gdef\jnsao@doi{#1}}
\newcommand{\manuscripteprinttype}[1]{\gdef\jnsao@eprinttype{#1}}
\newcommand{\manuscripteprint}[1]{\gdef\jnsao@eprint{#1}}
\newcommand{\manuscriptstatus}[1]{\gdef\jnsao@status{#1}}
\newcommand{\shortauthor}[1]{\gdef\jnsao@shortauthor{#1}}
\newcommand{\shorttitle}[1]{\gdef\jnsao@shorttitle{#1}}
\newcommand{\acknowledgements}[1]{\gdef\jnsao@ack{#1}}
\newcommand{\acknowledgments}[1]{\gdef\jnsao@ack{#1}}

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

\RequirePackage{lastpage}
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
        page~\thepage~of~\pageref*{LastPage}%
    }}
    \def\@oddfoot{\jnsao@ruledfoot{%
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
                \ifx\jnsao@date\empty{%
                     \ifx\jnsao@accepted\empty{\relax}\else{Accepted: \jnsao@accepted}\fi%
                }\else{%
                    Submitted: \jnsao@submitted\ifx\jnsao@accepted\empty{}\else, accepted: \jnsao@accepted\fi%
                }\fi%
                \\
            }\fi%
        }%
        \hfill%
        \parbox[b][\jnsao@firstpagehead][t]{0.25\textwidth}{%
            \hfill page~1~of~\pageref*{LastPage}\\%
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
% Abstract and article title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \maketitle customisations:
% - Locally convert \@title to lower case for ``all small caps'' to work right
% - Reset \@date to stop babel from messing things up with its silly enforced
%   date formats.
% - Include acknowledgements before \thanks footnotes
% This version \@maketitle is simply based on scrartcl.cls with unsupported
% features removed.

\def\jnsao@insert@ack{\insert\footins{%
    \reset@font\footnotesize%
    \interlinepenalty\interfootnotelinepenalty%
    \splittopskip\footnotesep%
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM%
    \hsize\columnwidth \@parboxrestore%
    \color@begingroup%
    \hb@xt@1.8em{\rule\z@\footnotesep\ignorespaces\parbox[t]{\textwidth}{\jnsao@ack}\@finalstrut\strutbox}%
    \color@endgroup}}

\renewcommand*{\@maketitle}{%
  \global\@topnum=\z@
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
  \null
  \vskip 2em%
  \if\jnsao@ack\empty\else\jnsao@insert@ack\fi%
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

% Set up abstract formatting
\renewenvironment{abstract}{%
    \vspace*{-0.75cm}
    \small%
    \quotation%
    \noindent%
    {\normalfont\sectfont\nobreak\abstractname\quad}%
    }{%
    \endquotation%
    \vskip 0.7cm
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Possibly missing commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providecommand{\arxiv}[1]{\mbox{\scshape\sffamily arxiv:}\,\href{https://arxiv.org/abs/#1}{#1}}
\providecommand{\hal}[1]{\href{https://hal.archives-ouvertes.fr/#1}{#1}}
\providecommand{\doi}[1]{\mbox{\scshape\sffamily doi:}\,\href{https://dx.doi.org/#1}{\detokenize{#1}}}
\providecommand{\orcid}[1]{\mbox{\scshape\sffamily orcid:}\,\href{https://orcid.org/#1}{\detokenize{#1}}}
\def\email#1{\href{mailto:#1}{\sffamily#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% review option: line numbers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@review
  \RequirePackage[mathlines]{lineno}
  \linenumbers
  \renewcommand{\linenumberfont}{\normalfont\scriptsize\sffamily\color{gray}}
  \renewcommand\thelinenumber{\tabularnumsf{\arabic{linenumber}}}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PDF metadata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{
    \begingroup
    % Override \and and \thanks to clean up author
    \def\and{ and }
    \def\thanks#1{\relax}
    \hypersetup{
        pdftitle = {\@title},
        pdfauthor = {\@author},
    }
    \endgroup
}
