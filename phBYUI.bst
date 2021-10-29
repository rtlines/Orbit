%%% Modification of BibTeX style file ./phBYU.bst
%%% ... by urlbst, version 0.8 (marked with "% urlbst")
%%% See <http://purl.org/nxg/dist/urlbst>
%%% Modifications Copyright 2002-03, 2005-12, 2014, 2019, Norman Gray,
%%% and distributed under the terms of the LPPL; see README for discussion.
%%%
%%% Added webpage entry type, and url and lastchecked fields.
%%% Added eprint support.
%%% Added DOI support.
%%% Added PUBMED support.
%%% Original headers follow...

% ******* Start of file phBYU.bst ******* 
%
%
%     PHBYU.BST was adapted from OSA.BST, which was written  
%     for use with RevTeX and the OSA journals.  It is the 
%     suggested format for BYU physics department theses.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    month
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
    eprint % urlbst
    doi % urlbst
    pubmed % urlbst
    url % urlbst
    lastchecked % urlbst
  }
  {}
  { label }


INTEGERS { vol.used i.temp }

STRINGS { s t }



FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'write$
  if$
}

% Note: nothing left on stack for future processing in bibitem.
FUNCTION {output.bibitem.original} % urlbst (renamed from output.bibitem, so it can be wrapped below)
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
}

FUNCTION {fin.entry.original} % urlbst (renamed from fin.entry, so it can be wrapped below)
{ add.period$
  write$
  newline$
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

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {embolden}
{ duplicate$ empty$
    { pop$ "" }
    { "{\bf " swap$ * "}" * }
  if$
}

FUNCTION {paren}
{ duplicate$ empty$
    { pop$ "" }
    { "(" swap$ * ")" * }
  if$
}

INTEGERS { nameptr namesleft numnames }
INTEGERS { etal }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames #10 >
  s numnames "{ll}" format.name$ "others" = numnames #1 > and
  or 'etal :=
  etal
    { #1 #1 + 'namesleft := }
    { numnames 'namesleft := }
  if$
    { namesleft #0 > }
    { s nameptr "{f. }{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { nameptr #2 >
                { "," * }
                'skip$
              if$
              t "others" =
              etal or
                { " {\it et~al.}" * }
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

FUNCTION {format.edited}
{ editor empty$
    { "" }
%    { "edited by " editor format.names * }
    { editor format.names
      editor num.names$ #1 >
        { ", eds.," * }
        { ", ed.," * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
%    'title
    { "``" title * ",''" * }
  if$
}

FUNCTION {lc.first.letter}
{ 't :=
  ""
  t #1 #1 substring$
  "l" change.case$ *
  t #2 global.max$ substring$
  *
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


FUNCTION {first.page}
{ 't :=
  ""
    {  t empty$ not t #1 #1 substring$ "-" = not and }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { "" }
    'year
  if$
}

FUNCTION {format.btitle}
{ title emphasize }

FUNCTION {format.in.btitle}
{ "In " booktitle  emphasize  *}

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

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}


FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { "\ pp.\ " pages n.dashify * }
        { "\ p.\ " pages * }
      if$
    }
  if$
}

FUNCTION {format.pages.a}
{ pages empty$
    { "" }
    { "page" pages first.page tie.or.space.connect }
  if$
}

%FUNCTION {format.vol.num.pages}
%{ volume field.or.null embolden
%  " " swap$ * *
%  pages empty$
%    'skip$
%    { duplicate$ empty$
%        { pop$ format.pages.a }
%        { ", " * pages first.page * }
%      if$
%    }
%  if$
%}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
%  number empty$
%    'skip$
%    { "(" number * ")" * *
%      volume empty$
%        { "there's a number but no volume in " cite$ * warning$ }
%        'skip$
%      if$
%    }
%  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { "," * embolden " " * pages n.dashify * }
      if$
    }
  if$
}


FUNCTION {if.comma}
{   { ", " * }
    'skip$
  if$
}

% pushes "" if value passed is empty$
FUNCTION {push.string}
{ 'i.temp :=
  duplicate$ empty$
    { pop$ "" }
    { i.temp if.comma }
  if$
}

% pushes "" if value passed is empty$
FUNCTION {push.string.check}
{ 'i.temp :=
  duplicate$ empty$
    { pop$ "Warning: " swap$ * " missing in entry " cite$ "." * * * warning$
      ""
     }
    { swap$ pop$ i.temp if.comma }
  if$
}

% adds nothing if value passed is empty$
FUNCTION {add.string}
{ 'i.temp :=
  duplicate$ empty$
    { pop$ }
    { * i.temp if.comma }
  if$
}

% adds nothing if value passed is empty$
FUNCTION {add.string.check}
{ 'i.temp :=
  duplicate$ empty$
    { pop$ "Warning: " swap$ * " missing in entry " cite$ "." * * * warning$ 
}
    { swap$ pop$ *
      i.temp if.comma
    }
  if$
}

FUNCTION {format.vol.page}
{ "volume" volume embolden #1 push.string.check
  " " *
  "pages" pages field.or.null first.page #0 add.string.check
  " " *
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  year empty$ note empty$ and and and and
    { "All relevant fields are empty in " cite$ * warning$ }
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
    { type empty$
        { " No.~" * }
        { " " * }
      if$
      number *
    }
  if$
}


FUNCTION {format.etc}
{ vol.used
    'skip$
    { number empty$
        { volume empty$
            'skip$
            { "Vol.~" volume * *
              chapter empty$ pages empty$ note empty$ and and
                  'skip$
                  { ", " * }
              if$
            }
          if$
        }
        { "No.~" number * *
          chapter empty$ pages empty$ note empty$ and and
              'skip$
              { ", " * }
          if$
        }
      if$
    }
  if$
  chapter empty$
    'skip$
    { type empty$
        { "Chap.~" chapter * * }
        { type "u" change.case$ "l" change.case$ " " chapter * * * }
      if$
      pages empty$ note empty$ and
        'skip$
        { ", " * }
      if$
    }
  if$
  pages empty$
    'skip$
    { format.pages *
      note empty$
        'skip$
        { ", " * }
      if$
    }
  if$
  note empty$
    'skip$
    { note lc.first.letter * }
  if$
}


FUNCTION {format.pub.add.year.etc}
{ " ("
  publisher empty$
    'skip$
    { publisher ", " * *}
  if$

  address empty$
    'skip$
    { address  ", " * * }
  if$

  year empty$
   'skip$
   'year
  if$
  ")" * *
  volume empty$ not number empty$ not or title empty$ series empty$ or and
  chapter empty$ not or
  pages empty$ not or type empty$ not or note empty$ not or
    { ", " *
      format.etc
    }
    'skip$
  if$
}

FUNCTION {format.pub.addr}
{ " ("
  publisher empty$
    'skip$ 
    { publisher ", " * *}
  if$
  
  address empty$
    'skip$ 
    { address  ", " * * }
  if$
  
  year empty$
   'skip$
   'year
  if$
  ")" * *
 }


FUNCTION {format.bedition}
{ edition empty$
    { "" }
    { edition "l" change.case$
      duplicate$ "first" =
        { pop$ "1st " }
        { duplicate$ "second" =
            { pop$ "2nd " }
            { duplicate$ "third" =
                { pop$ "3rd " }
                'skip$
              if$
            }
          if$
        }
      if$
      " ed." *
    }
  if$
}

FUNCTION {format.title.and.series.and.org}
{ #0 'vol.used :=
  ""
  duplicate$ 's :=
  title empty$
    'skip$
    { title 's := }
  if$
  booktitle empty$
    'skip$
    { booktitle 's := }
  if$
  s empty$
    'skip$
    { type$ "inproceedings" = type$ "proceedings" = or type$ "incollection" = 
or
       type$ "inbook" = or
        { " in " * }
        { author empty$ not editor empty$ not and
            { " in " * }
            'skip$
          if$
        }
      if$
      s emphasize
        series empty$ editor empty$ edition empty$ and and not
        type$ "inproceedings" =   organization empty$ not    and
        type$ "proceedings"   =   organization empty$ not    and or     or
          add.string
    }
  if$
  series empty$
    'skip$
    { s empty$
         'skip$
         { number empty$
             { volume empty$
                 'skip$
                 { "Vol.~" volume " of " * * * #1 'vol.used := }
               if$
             }
             { "No.~" number " in " * * * #1 'vol.used := }
           if$
         }
      if$
      series emphasize
        edition empty$ not
        editor empty$ not
        type$ "inproceedings" =   organization empty$ not    and
        type$ "proceedings" =   organization empty$ not      and
        or   or   or
          add.string
    }
  if$
  type$ "inproceedings" =    type$ "proceedings" =    or
    { organization empty$
        'skip$
        { organization editor empty$ edition empty$ and not add.string }
      if$
    }
    'skip$
  if$
}


% urlbst...
FUNCTION {new.block} % dummy new.block function
{
  % empty
}

% Functions for making hypertext links.
% In all cases, the stack has (link-text href-url)
%
% make 'null' specials
FUNCTION {make.href.null}
{
  pop$
}
% make hypertex specials
FUNCTION {make.href.hypertex}
{ 
  "\special {html:<a href=" quote$ *
  swap$ * quote$ * "> }" * swap$ *
  "\special {html:</a>}" *
}
% make hyperref specials
FUNCTION {make.href.hyperref}
{ 
  "\href {" swap$ * "} {\path{" * swap$ * "}}" *
}
FUNCTION {make.href}
{ hrefform #2 =
    'make.href.hyperref      % hrefform = 2
    { hrefform #1 =
        'make.href.hypertex  % hrefform = 1
        'make.href.null      % hrefform = 0 (or anything else)
      if$
    }
  if$
}

% If inlinelinks is true, then format.url should be a no-op, since it's
% (a) redundant, and (b) could end up as a link-within-a-link.
FUNCTION {format.url}
{ inlinelinks #1 = url empty$ or
   { "" }
   { hrefform #1 =
       { % special case -- add HyperTeX specials
         urlintro "\url{" url * "}" * url make.href.hypertex * }
       { urlintro "\url{" * url * "}" * }
     if$
   }
  if$
}
FUNCTION {format.eprint}
{ eprint empty$
    { "" }
    { eprintprefix eprint * eprinturl eprint * make.href }
  if$
}

FUNCTION {format.doi}
{ doi empty$
    { "" }
    { doiprefix doi * doiurl doi * make.href }
  if$
}

FUNCTION {format.pubmed}
{ pubmed empty$
    { "" }
    { pubmedprefix pubmed * pubmedurl pubmed * make.href }
  if$
}

% Output a URL.  We can't use the more normal idiom (something like
% `format.url output'), because the `inbrackets' within
% format.lastchecked applies to everything between calls to `output',
% so that `format.url format.lastchecked * output' ends up with both
% the URL and the lastchecked in brackets.
FUNCTION {output.url}
{ url empty$
    'skip$ 
    { new.block 
      format.url output
      format.lastchecked output 
    }
  if$
}

FUNCTION {output.web.refs}
{
  new.block
  inlinelinks
    'skip$ % links were inline -- don't repeat them
    { % If the generated DOI will be the same as the URL,
      % then don't print the URL (thanks to Joseph Wright for this code,
      % at http://tex.stackexchange.com/questions/5660)
      adddoiresolver 
          doiurl doi empty$ { "X" } { doi } if$ * % DOI URL to be generated
          url empty$ { "Y" } { url } if$          % the URL, or "Y" if empty
          =                                       % are the strings equal?
          and
        'skip$
        { output.url }
      if$
      addeprints eprint empty$ not and
        { format.eprint output.nonnull }
        'skip$
      if$
      adddoiresolver doi empty$ not and
        { format.doi output.nonnull }
        'skip$
      if$
      addpubmedresolver pubmed empty$ not and
        { format.pubmed output.nonnull }
        'skip$
      if$
    }
  if$
}

% Wrapper for output.bibitem.original.
% If the URL field is not empty, set makeinlinelink to be true,
% so that an inline link will be started at the next opportunity
FUNCTION {output.bibitem}
{ outside.brackets 'bracket.state :=
  output.bibitem.original
  inlinelinks url empty$ not doi empty$ not or pubmed empty$ not or eprint empty$ not or and
    { #1 'makeinlinelink := }
    { #0 'makeinlinelink := }
  if$
}

% Wrapper for fin.entry.original
FUNCTION {fin.entry}
{ output.web.refs  % urlbst
  makeinlinelink       % ooops, it appears we didn't have a title for inlinelink
    { possibly.setup.inlinelink % add some artificial link text here, as a fallback
      linktextstring output.nonnull }
    'skip$
  if$
  bracket.state close.brackets = % urlbst
    { "]" * }
    'skip$
  if$
  fin.entry.original
}

% Webpage entry type.
% Title and url fields required;
% author, note, year, month, and lastchecked fields optional
% See references 
%   ISO 690-2 http://www.nlc-bnc.ca/iso/tc46sc9/standard/690-2e.htm
%   http://www.classroom.net/classroom/CitingNetResources.html
%   http://neal.ctstateu.edu/history/cite.html
%   http://www.cas.usf.edu/english/walker/mla.html
% for citation formats for web pages.
FUNCTION {webpage}
{ output.bibitem
  author empty$
    { editor empty$
        'skip$  % author and editor both optional
        { format.editors output.nonnull }
      if$
    }
    { editor empty$
        { format.authors output.nonnull }
        { "can't use both author and editor fields in " cite$ * warning$ }
      if$
    }
  if$
  new.block
  title empty$ 'skip$ 'possibly.setup.inlinelink if$
  format.title "title" output.check
  inbrackets onlinestring output
  new.block
  year empty$
    'skip$
    { format.date "year" output.check }
  if$
  % We don't need to output the URL details ('lastchecked' and 'url'),
  % because fin.entry does that for us, using output.web.refs.  The only
  % reason we would want to put them here is if we were to decide that
  % they should go in front of the rather miscellaneous information in 'note'.
  new.block
  note output
  fin.entry
}
% ...urlbst to here


FUNCTION {article}
{ output.bibitem
  "author" format.authors #1 push.string.check
  "title" format.title #0 add.string.check " " *
  "journal" journal #0 add.string.check " " *
  output
%  format.vol.page #0 push.string
  possibly.setup.inlinelink format.vol.num.pages #0 push.string% urlbst
  " " *
  "date" format.date paren #0 add.string.check
  note empty$
    'skip$
    { ", " * note lc.first.letter * }
  if$
  fin.entry
  crossref empty$
    'skip$
    { "See Ref.\ \cite{" crossref "}." * * write$ newline$ }
  if$
}

FUNCTION {book}
{ output.bibitem
  format.authors #1 push.string
  "title" format.title.and.series.and.org #0 add.string.check
  format.bedition editor empty$ not add.string
  output
  format.edited #0 push.string
  format.pub.add.year.etc #0 add.string
  fin.entry
  crossref empty$
    'skip$
    { "See Ref.\ \cite{" crossref "}." * * write$ newline$ }
  if$
}

FUNCTION {booklet}
{ output.bibitem
  format.authors #1 push.string
  "title" format.title #0 add.string.check
  howpublished empty$
    'skip$
    { ", " howpublished * * }
  if$
  address empty$
    'skip$
    { ", " address * * }
  if$
  year empty$
    'skip$
    { " (" year ")" * * * }
  if$
  note empty$
    'skip$
    { ", " note  lc.first.letter * * }
  if$
  fin.entry
}

FUNCTION {inbook} { book }

FUNCTION {incollection} 
{ output.bibitem
  format.authors #1 push.string
  "title" format.title #0 add.string.check " " *
  "booktitle" format.title.and.series.and.org #0 add.string.check
  format.bedition editor empty$ not add.string

  output
  format.edited #0 push.string
  format.pub.add.year.etc #0 add.string
  fin.entry
  crossref empty$
    'skip$
    { "See Ref.\ \cite{" crossref "}." * * write$ newline$ }
  if$
}

FUNCTION {myseries}
{
  series empty$
   {" "}
   {"\ "  series * "\ " *}
  if$
}
FUNCTION {inproceedings}
{ output.bibitem
  format.authors #1 push.string
  "title" format.title #0 add.string.check " " *
%  "booktitle" format.title.and.series.and.org #0 add.string.check
  "booktitle" format.in.btitle #0 add.string.check ", " *
  format.bedition editor empty$ not add.string
  output
  format.edited #0 push.string
%  format.pub.add.year.etc #0 add.string
   "series" myseries #0 add.string.check
%  "series" "\ in " * series * ", " * #0 add.string.check  
%  "series" "\ " series * ", " * #0 add.string
  possibly.setup.inlinelink format.vol.num.pages #0 add.string% urlbst
  " " *
  format.pub.addr #0 add.string  
  note empty$
    'skip$
    { ", " * note lc.first.letter * }
  if$

  fin.entry
  crossref empty$
    'skip$
    { "See Ref.\ \cite{" crossref "}." * * write$ newline$ }
  if$
}



FUNCTION {proceedings} { book }

FUNCTION {conference} { book }



FUNCTION {manual}
{ output.bibitem
  ""
  author empty$
    'skip$
    { format.authors #1 add.string }
  if$
  title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
  format.btitle
    edition empty$ address empty$ organization empty$ year empty$ note empty$
                           and and and and not
      add.string
  edition empty$
    'skip$
    { format.bedition
        organization empty$ address empty$ year empty$ note empty$
                           and and and not
          add.string
    }
  if$
  organization empty$
    'skip$
    { organization
        address empty$ year empty$ note empty$ and and not
          add.string
    }
  if$
  address empty$
    'skip$
    { address   year empty$ note empty$ and not   add.string }
  if$
  year empty$
    'skip$
    { year   note empty$ not   add.string }
  if$
  note empty$
    'skip$
    { note lc.first.letter #0 add.string }
  if$
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  "author" format.authors #1 push.string.check
  title empty$
    'skip$
    { "We don't use thesis titles in Phys. Rev, see \cite{"
      cite$ "}" * * warning$
    }
  if$
  "Master's thesis" format.thesis.type   #1   add.string
  "school"   school   #1   add.string.check
  address #1 add.string
  "year" format.date   note empty$ not   add.string.check
  note empty$
    'skip$
    { note lc.first.letter * }
  if$
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  "author" format.authors #1 push.string.check
  title empty$
    'skip$
    { "We don't use thesis titles in Phys. Rev, see \cite{"
      cite$ "}" * * warning$
    }
  if$
  "Ph.D. thesis" format.thesis.type   #1   add.string
  "school"   school   #1   add.string.check
  address #1 add.string
  "year" format.date   note empty$ not   add.string.check
  note empty$
    'skip$
    { note lc.first.letter * }
  if$
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors
    title empty$ howpublished empty$
      year empty$ note empty$ and and and not push.string
  title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
  format.title
    howpublished empty$ year empty$ note empty$
      and and not add.string
  howpublished
    year empty$ note empty$ and not add.string
  format.date note empty$ not add.string
  note empty$
    'skip$
    { note
      author empty$ title empty$ howpublished empty$
      year empty$ and and and
        'skip$
        'lc.first.letter
      if$
      #0 add.string
    }
  if$
  fin.entry
  empty.misc.check
}


FUNCTION {techreport}
{ output.bibitem
  "author" format.authors #1 push.string.check
  title empty$
    'skip$
%    { "We chuck the title of techreports in Phys. Rev.---\cite{"
%       cite$ "}." * * warning$
%    }
     { "title" format.title #0 add.string.check " " *
     }
  if$
  format.tr.number
    institution empty$ address empty$ note empty$ and and not add.string
  "institution"  institution  address empty$ note empty$ and not
    add.string.check
  address #0 add.string
  " (" year * ") " * note empty$ not add.string
  note empty$
    'skip$
    { note lc.first.letter * }
  if$
  fin.entry
}



FUNCTION {unpublished}
{ output.bibitem
  "author" format.authors   note empty$ not   push.string.check
  note empty$
    'skip$
    { note lc.first.letter #0 add.string }
  if$
  " (unpublished)" *
  fin.entry
}

FUNCTION {default.type} { misc }




MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}






MACRO {acmcs} {"ACM Comput. Surv."}
MACRO {acta} {"Acta Inf."}
MACRO {applopt} {"Appl. Opt."}
MACRO {cacm} {"Commun. ACM"}
MACRO {ibmjrd} {"IBM J. Res. Dev."}
MACRO {ibmsj} {"IBM Syst.~J."}
MACRO {ieeese} {"IEEE Trans. Softw. Eng."}
MACRO {ieeetc} {"IEEE Trans. Comput."}
MACRO {ieeetcad}
 {"IEEE Trans. Comput.-Aided Design Integrated Circuits"}
MACRO {ipl} {"Inf. Process. Lett."}
MACRO {jacm} {"J.~ACM"}
MACRO {jcss} {"J.~Comput. Syst. Sci."}
MACRO {scp} {"Sci. Comput. Programming"}
MACRO {sicomp} {"SIAM J. Comput."}
MACRO {tocs} {"ACM Trans. Comput. Syst."}
MACRO {tods} {"ACM Trans. Database Syst."}
MACRO {tog} {"ACM Trans. Gr."}
MACRO {toms} {"ACM Trans. Math. Softw."}
MACRO {toois} {"ACM Trans. Office Inf. Syst."}
MACRO {toplas} {"ACM Trans. Prog. Lang. Syst."}
MACRO {tcs} {"Theor. Comput. Sci."}
MACRO {anp} {"Adv. Nucl. Phys."}
MACRO {ap} {"Ann. Phys."}
MACRO {arnpc} {"Annu. Rev. Nucl. Part. Sci."}
MACRO {baps} {"Bull. Am. Phys. Soc."}
MACRO {cp} {"Computers Phys."}
MACRO {jp} {"J. Phys."}
MACRO {josa} {"J. Opt. Soc. Am."}
MACRO {josaa} {"J. Opt. Soc. Am. A"}
MACRO {josab} {"J. Opt. Soc. Am. B"}
MACRO {nim} {"Nucl. Instrum. Meth."}
MACRO {np} {"Nucl. Phys."}
MACRO {rmp} {"Rev. Mod. Phys."}
MACRO {physica} {"Physica"}
MACRO {pl} {"Phys. Lett."}
MACRO {plb} {"Phys. Lett. B"}
MACRO {pr} {"Phys. Rev."}
MACRO {pra} {"Phys. Rev. A"}
MACRO {prb} {"Phys. Rev. B"}
MACRO {prc} {"Phys. Rev. C"}
MACRO {prd} {"Phys. Rev. D"}
MACRO {pre} {"Phys. Rev. E"}
MACRO {prl} {"Phys. Rev. Lett."}
MACRO {prep} {"Phys. Rep."}
MACRO {ps} {"Phys. Scr."}
MACRO {rpp} {"Rep. Prog. Phys."}
MACRO {sjnp} {"Sov. J. Nucl. Phys."}
MACRO {springmp} {"Springer Tracts in Modern Physics"}
MACRO {yadfiz} {"Yad. Fiz."}
MACRO {zp} {"Z. Phys."}



READ

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

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}
EXECUTE {end.bib}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             end prsty.bst             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




