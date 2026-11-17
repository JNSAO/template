%% jnsao.bst
%% Copyright (c) Christian Clason and Tuomo Valkonen, 2019.
%
% BibTeX style corresponding to the LaTeX class for the
%
%    Journal of Nonsmooth Analysis and Optimization
%
% Web: https://jnsao.episciences.org
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
%
% Version 1.0 (2026-11-17).
% Based on BibTeX standard bibliography style `abbrv'.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ENTRY
{ address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
    doi          % only doi; https://doi.org/ is added (and stripped if given)
    eprinttype   % repository: currently, arxiv or hal are supported
    archiveprefix % alias for eprinttype (used by arXiv's BibTeX export)
    eprint       % eprint ID as in repository URL (e.g., hal-01234567)
    version      % eprint version, appended as, e.g., `v1` to URL;
                 % software version (if there is no eprint)
    url          % external URL if neither doi nor eprint is available
    urldate      % date visited (for web pages etc.)
    date         % futureproof: biblatex uses date over year
    journaltitle % futureproof: biblatex uses journaltitle over journal
}
{}
{ label }

INTEGERS { output.state before.all mid.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
    #1 'mid.sentence :=
    #2 'after.block :=
}

STRINGS { s t u v }

FUNCTION {output.nonnull}
{ 's :=
    output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
            newline$
            "\newblock " write$
        }
        'write$
        if$
        mid.sentence 'output.state :=
    }
    if$
    s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
    if$
}

FUNCTION {output.check}
{ 't :=
    duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
    if$
}

FUNCTION {output.bibitem}
{ newline$
    "\bibitem{" write$
    cite$ write$
    "}" write$
    newline$
    ""
    before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
    write$
    newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
    if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
    if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
    if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
    if$
}

FUNCTION {new.block.checkb}
{ empty$
    swap$ empty$
    and
    'skip$
    'new.block
    if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
    if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
    if$
}

INTEGERS { nameptr namesleft numnames }

% replace ties and spaces (between initials) by thin spaces
FUNCTION {thin.initials}
{ 'v :=
    ""
    { v empty$ not }
    { v #1 #1 substring$
        duplicate$ duplicate$ "~" = swap$ " " = or
        { pop$ "\," }
        'skip$
        if$
        *
        v #2 global.max$ substring$ 'v :=
    }
    while$
}

% initials separated by thin spaces (keeping hyphens, e.g., J.-P.), followed
% by an unbreakable space before the last name
FUNCTION {format.name}
{ 'u :=
    duplicate$ u swap$ "{f.}" format.name$ thin.initials
    duplicate$ empty$
    'skip$
    { "\nobreak\kern 0.33333em " * }
    if$
    swap$ u swap$ "{vv~}{ll}{, jj}" format.name$ *
}

FUNCTION {format.names}
{ 's :=
    #1 'nameptr :=
    s num.names$ 'numnames :=
    numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr s format.name 't :=
        nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { numnames #2 >
                { "," * }
                'skip$
                if$
                t "others" =
                { " et~al." * }
                { " and " * t * }
                if$
            }
            if$
        }
        't
        if$
        nameptr #1 + 'nameptr :=
        namesleft #1 - 'namesleft :=
    }
    while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
    if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
        editor num.names$ #1 >
        { " (eds.)" * }
        { " (ed.)" * }
        if$
    }
    if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title}
    if$
}

FUNCTION {n.dashify}
{ 't :=
    ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
                t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                    t #2 global.max$ substring$ 't :=
                }
                while$
            }
            if$
        }
        { t #1 #1 substring$ *
            t #2 global.max$ substring$ 't :=
        }
        if$
    }
    while$
}

% year, or the year part of date (yyyy-mm-dd), or empty
FUNCTION {year.or.date}
{ year empty$
    { date empty$
        { "" }
        { date #1 #4 substring$ }
        if$
    }
    'year
    if$
}

FUNCTION {format.journal}
{
    journal empty$
    {journaltitle}
    {journal}
    if$
    emphasize
}

FUNCTION {format.date}
{ year.or.date }

% "volume (year)", omitting empty parts
FUNCTION {format.vol.year}
{ volume field.or.null
    format.date duplicate$ empty$
    'pop$
    { "(" swap$ * ")" *
        swap$ duplicate$ empty$
        'pop$
        { " " * swap$ * }
        if$
    }
    if$
}

% append " (year)" to the string on the stack if there is a year
FUNCTION {add.paren.date}
{ format.date duplicate$ empty$
    'pop$
    { " (" swap$ * ")" * * }
    if$
}

% "Journal volume (year)" (journal empty: empty)
FUNCTION {format.journal.vol.year}
{ format.journal duplicate$ empty$
    'skip$
    { format.vol.year duplicate$ empty$
        'pop$
        { " " swap$ * * }
        if$
    }
    if$
}


FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
    if$
    swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
    if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
        series empty$
        'skip$
        { " of " * series * }
        if$
        "volume and number" number either.or.check
    }
    if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "number" }
            { "Number" }
            if$
            number tie.or.space.connect
            series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " in " * series * }
            if$
        }
        if$
    }
    { "" }
    if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " edition" * }
        { edition "t" change.case$ " edition" * }
        if$
    }
    if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages n.dashify }
    if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "chapter" }
        { type "l" change.case$ }
        if$
        chapter tie.or.space.connect
        pages empty$
        'skip$
        { ", " * format.pages * }
        if$
    }
    if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { "in " booktitle emphasize * }
        { "in " booktitle emphasize * ", " * format.editors * }
        if$
    }
    if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
    format.date empty$ note empty$
    and and and and
    key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
    if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
        type "t" change.case$
    }
    if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
    if$
    number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
    if$
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
    editor num.names$ duplicate$
    #2 >
    { pop$ " et~al." * }
    { #2 <
        'skip$
        { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { " et~al." * }
            { " and " * editor #2 "{vv~}{ll}" format.name$ * }
            if$
        }
        if$
    }
    if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
        "in "
    }
    { "Volume" volume tie.or.space.connect
        " of " *
    }
    if$
    editor empty$
    editor field.or.null author field.or.null =
    or
    { key empty$
        { series empty$
            { "need editor, key, or series for " cite$ * " to crossref " *
                crossref * warning$
                "" *
            }
            { "\emph{" * series * "\/}" * }
            if$
        }
        { key * }
        if$
    }
    { format.crossref.editor * }
    if$
    " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
    editor field.or.null author field.or.null =
    or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
                crossref * warning$
                ""
            }
            { "in \emph{" booktitle * "\/}" * }
            if$
        }
        { "in " key * }
        if$
    }
    { "in " format.crossref.editor * }
    if$
    " \cite{" * crossref * "}" *
}

FUNCTION {eprint.version}
{
    eprint empty$
    { "" }
    { version empty$
        { eprint }
        { eprint "v" * version * }
        if$
    }
    if$
}

% full HAL identifier, e.g., hal-01234567 (prefix hal- added to bare numbers)
FUNCTION {hal.id}
{ eprint.version
    eprint #1 #1 substring$ chr.to.int$
    duplicate$ #47 > swap$ #58 < and
    { "hal-" swap$ * }
    'skip$
    if$
}

FUNCTION {format.hal}
{ eprint empty$
    { "" }
    { "\href{https://hal.science/" hal.id * "}{\nolinkurl{" * hal.id * "}}" * }
    if$
}

FUNCTION {format.arxiv}
{ eprint empty$
    { "" }
    { "\href{https://arxiv.org/abs/" eprint.version *
        "}{\nolinkurl{arXiv:" * eprint.version * "}}" *
    }
    if$
}

% eprinttype, or archiveprefix, in lower case
FUNCTION {eprint.type}
{ eprinttype empty$
    { archiveprefix field.or.null }
    'eprinttype
    if$
    "l" change.case$
}

% eprint without type: arXiv (for compatibility); unknown type: plain text
FUNCTION {format.eprint}
{ eprint empty$
    { "" }
    { eprint.type duplicate$ "hal" =
        { pop$ format.hal }
        { duplicate$ "arxiv" = swap$ empty$ or
            { format.arxiv }
            { "unsupported eprinttype " eprint.type * " in " * cite$ * warning$
                "\nolinkurl{" eprint.type * ":" * eprint.version * "}" *
            }
            if$
        }
        if$
    }
    if$
}

% remove the prefix on the stack from u if present (ignoring case)
FUNCTION {chop.prefix}
{ 't :=
    u #1 t text.length$ substring$ "l" change.case$ t =
    { u t text.length$ #1 + global.max$ substring$ 'u := }
    'skip$
    if$
}

% DOI without resolver or doi: prefix, in lower case (DOIs are case-insensitive)
FUNCTION {clean.doi}
{ doi 'u :=
    "https://doi.org/" chop.prefix
    "http://doi.org/" chop.prefix
    "https://dx.doi.org/" chop.prefix
    "http://dx.doi.org/" chop.prefix
    "doi:" chop.prefix
    u "l" change.case$
}

FUNCTION {format.doi}
{ doi empty$
    { "" }
    { "\href{https://doi.org/" clean.doi * "}{\nolinkurl{doi:" * clean.doi * "}}" * }
    if$
}

% software version (version is the eprint version if there is an eprint)
FUNCTION {format.version}
{ version empty$ eprint empty$ not or
    { "" }
    { "version " version * }
    if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { urldate empty$
        { "\url{" url * "}" * }
        { "\url{" url * "} (visited " * urldate * ")" * }
        if$
    }
    if$
}

FUNCTION {article}
{ output.bibitem
    format.authors "author" output.check
    format.title "title" output.check
    format.journal.vol.year "journal" output.check
    format.pages output
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {book}
{ output.bibitem
    author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
        "author and editor" editor either.or.check 
    }
    if$
    format.btitle "title" output.check
    format.bvolume output
    format.number.series output
    publisher "publisher" output.check
    address output
    format.edition output
    format.date output
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {booklet}
{ output.bibitem
    format.authors output
    format.title "title" output.check
    howpublished address new.block.checkb
    howpublished output
    address output
    format.date output
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {inbook}
{ output.bibitem
    author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
        crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
        if$
    }
    if$
    format.title "title" output.check
    crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
        format.bvolume output
        format.number.series output
        publisher "publisher" output.check
        address output
    }
    { format.book.crossref output.nonnull }
    if$
    format.edition output
    format.date "year" output.check
    format.chapter.pages "chapter and pages" output.check
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {incollection}
{ output.bibitem
    format.authors "author" output.check
    format.title "title" output.check
    crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
        format.bvolume output
        format.number.series output
        publisher "publisher" output.check
        address output
        format.edition output
        format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull }
    if$
    format.chapter.pages output
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
    editor empty$
    { organization output }
    { format.editors output.nonnull }
    if$
    format.btitle "title" output.check
    format.bvolume output
    format.number.series output
    address empty$
    { editor empty$
        'skip$
        { organization output }
        if$
        publisher output
        format.date "year" output.check
    }
    { address output.nonnull
        format.date "year" output.check
        editor empty$
        'skip$
        { organization output }
        if$
        publisher output
    }
    if$
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
    format.authors "author" output.check
    format.title "title" output.check
    crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
        format.bvolume output
        format.number.series output
        publisher "publisher" output.check
        address output
        format.edition output
        format.date output
    }
    { format.incoll.inproc.crossref output.nonnull }
    if$
    format.pages output
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
    author empty$
    { organization empty$
        'skip$
        { organization output.nonnull }
        if$
    }
    { format.authors output.nonnull }
    if$
    format.btitle "title" output.check
    author empty$
        'skip$
        { organization output }
    if$
    address output
    format.edition output
    format.date output
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
    format.authors "author" output.check
    format.btitle "title" output.check
    "Master's thesis" format.thesis.type output.nonnull
    school "school" output.check
    address output
    format.date "year" output.check
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
    format.authors "author" output.check
    format.btitle "title" output.check
    "PhD thesis" format.thesis.type output.nonnull
    school "school" output.check
    address output
    format.date "year" output.check
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {techreport}
{ output.bibitem
    format.authors "author" output.check
    format.title "title" output.check
    format.tr.number output.nonnull
    institution "institution" output.check
    address output
    format.date "year" output.check
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
    format.authors "author" output.check
    format.title duplicate$ empty$
    'skip$
    'add.paren.date
    if$
    "title" output.check
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
}

FUNCTION {misc}
{ output.bibitem
    format.authors output
    format.title output
    howpublished output
    format.version output
    format.date output
    format.doi output
    format.eprint output
    format.url output
    new.block
    note output
    fin.entry
    empty.misc.check
}

FUNCTION {software} { misc }

FUNCTION {default.type} { misc }

MACRO {jan} {"Jan."}

MACRO {feb} {"Feb."}

MACRO {mar} {"Mar."}

MACRO {apr} {"Apr."}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"Aug."}

MACRO {sep} {"Sept."}

MACRO {oct} {"Oct."}

MACRO {nov} {"Nov."}

MACRO {dec} {"Dec."}

READ

FUNCTION {sortify}
{ purify$
    "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
    'len :=
    s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
    if$
}

FUNCTION {sort.format.names}
{ 's :=
    #1 'nameptr :=
    ""
    s num.names$ 'numnames :=
    numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
        if$
        s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
        nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
        if$
        nameptr #1 + 'nameptr :=
        namesleft #1 - 'namesleft :=
    }
    while$
}

FUNCTION {sort.format.title}
{ 't :=
    "A " #2
    "An " #3
    "The " #4 t chop.word
    chop.word
    chop.word
    sortify
    #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
            ""
        }
        { key sortify }
        if$
    }
    { author sort.format.names }
    if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
                ""
            }
            { key sortify }
            if$
        }
        { editor sort.format.names }
        if$
    }
    { author sort.format.names }
    if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
                ""
            }
            { key sortify }
            if$
        }
        { "The " #4 organization chop.word sortify }
        if$
    }
    { author sort.format.names }
    if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
                ""
            }
            { key sortify }
            if$
        }
        { "The " #4 organization chop.word sortify }
        if$
    }
    { editor sort.format.names }
    if$
}

FUNCTION {presort}
{ type$ "book" =
    type$ "inbook" =
    or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
            if$
        }
        if$
    }
    if$
    "    "
    *
    format.date sortify
    *
    "    "
    *
    title field.or.null
    sort.format.title
    *
    #1 entry.max$ substring$
    'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
    #1 'number.label :=
    #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
    number.label #1 + 'number.label :=
    label width$ longest.label.width >
    { label 'longest.label :=
        label width$ 'longest.label.width :=
    }
    'skip$
    if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
    if$
    "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
    "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
