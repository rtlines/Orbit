% Revision: 07-25-2007
% Revision History
%   07-10-2008 : Corrected Alignment of signature boxes on Masters/PhD Approval page
%   07-25-2007 : Corrected some spelling errors
%   05-16-2006 : Added etd option and moved most packages from class file to template
%   05-15-2006 : Initial version.
%
% Known bugs
%   Having a tiny bit of the abstract spill to second page defeats page number removal.
%   Workaround: make the abstract a little longer or a little shorter.
%
% The BYUPhys class is for producing theses and dissertations 
% in the BYU department of physics and astronomy.  You can supply 
% the following optional arguments in the square brackets to 
% specify the thesis type:
%
%   senior  : Produces the senior thesis preliminary pages (default)
%   honors  : Produces the honors thesis preliminary pages
%   masters : Produces the masters thesis preliminary pages
%   phd     : Produces the PhD dissertation preliminary pages
%
% The default format is appropriate for printing, with blank pages 
% inserted after the preliminary pages in twoside mode so you can 
% send it directly to a two-sided printer. However, for ETD 
% submission the blank pages need to be removed from the final output.
% The following option does this:
%
%   etd     : Produces an electronic copy with no blank pages in the preliminary section
%
% The rest of the class options are the same as the regular book class.  
% A few to remember:
%
%   oneside : Produces single sided print layout (recommended for theses less than 50 pages)
%   twoside : Produces single sided print layout (the default if you remove oneside)
%
% The BYUPhys class provides the following macros:
%
%   \makepreliminarypages : Makes the preliminary pages
%   \clearemptydoublepage : same as \cleardoublepage but doesn't put page numbers
%                           on blank intervening pages
%   \singlespace          : switch to single spaced lines
%   \doublespace          : switch to double spaced lines
%
% ------------------------------------------------------------------------------------------------------
%
\NeedsTeXFormat{LaTeX2e} \ProvidesClass{BYUPhys}

% ---------------------------- declarations -------------------------
%
% These macros are used to declare arguments needed for the
% construction of the preliminary pages  

% The year and month the degree is awarded
\newcommand{\Year}[1]{\gdef\@Year{#1}}
\newcommand{\Month}[1]{\gdef\@Month{#1}}

% The full name of the degree
\newcommand{\degree}[1]{\gdef\@degree{#1}}

% The name of this document (thesis/dissertation)
\newcommand{\docname}[1]{\gdef\@docname{#1}}

% First line of title
\newcommand{\TitleTop}[1]{\gdef\@TitleTop{\mbox{\uppercase{#1}}}}

% Middle line of title
\newcommand{\TitleMiddle}[1]{\gdef\@TitleMiddle{\mbox{\uppercase{#1}}}}

% Second line of title
\newcommand{\TitleBottom}[1]{\gdef\@TitleBottom{\mbox{\uppercase{#1}}}}

% Abstract text
\newcommand{\Abstract}[1]{\gdef\@Abstract{#1}}

% Acknowledgments text
\newcommand{\Acknowledgments}[1]{\gdef\@Acknowledgments{#1}}

% The author's name
\newcommand{\Author}[1]{\gdef\@Author{#1}}

% The name of the advisor
\newcommand{\Advisor}[1]{\gdef\@Advisor{#1}}

% The name of the committee member 2
\newcommand{\MemberA}[1]{\gdef\@MemberA{#1}}

% The name of the committee member 3
\newcommand{\MemberB}[1]{\gdef\@MemberB{#1}}

% The name of the committee member 4
\newcommand{\MemberC}[1]{\gdef\@MemberC{#1}}

% The name of the committee member 5
\newcommand{\MemberD}[1]{\gdef\@MemberD{#1}}

% The name of the thesis coordinator
\newcommand{\ThesisCoordinator}[1]{\gdef\@ThesisCoordinator{#1}}

% The name of the department chair
\newcommand{\DepRep}[1]{\gdef\@DepRep{#1}}

% The title of the department chair (allow for associate chair, etc.)
\newcommand{\DepRepTitle}[1]{\gdef\@DepRepTitle{#1}}

% The name of the department undergraduate coordinator
\newcommand{\UgradCoord}[1]{\gdef\@UgradCoord{#1}}

% The name of the dean
\newcommand{\Dean}[1]{\gdef\@Dean{#1}}

% The title of the dean
\newcommand{\DeanTitle}[1]{\gdef\@DeanTitle{#1}}

% The name of the honors dean
\newcommand{\HonorsDean}[1]{\gdef\@HonorsDean{#1}}

% Set default values for fields
  \Year{1905}
  \Month{January}
  \Author{Author}
  \TitleTop{First line of title}
  \TitleMiddle{ } % default is empty
  \TitleBottom{ } % default is empty
  \Abstract{Abstract text goes here.}
  \Acknowledgments{Acknowledgment text goes here.}
  \degree{Bachelor of Science}
  \docname{senior thesis}
  \Advisor{Advisor}
  \MemberA{Committee Member A}
  \MemberB{Committee Member B}
  \MemberC{Committee Member C}
  \MemberD{Committee Member D}
  \ThesisCoordinator{Thesis Coordinator}
  \DepRep{Department Chair}
  \DepRepTitle{Chair}
  \Dean{Dean Name}
  \DeanTitle{Associate Dean}
  \HonorsDean{Honors Dean Name}
  \UgradCoord{Department Ugrad Coordinator }
  
% ---------------------------- options ------------------------------

% A command to switch to single spaced lines
\newcommand{\singlespace}{\renewcommand{\baselinestretch}{1}\small\normalsize}

% A command to switch to double spaced lines
\newcommand{\doublespace}{\renewcommand{\baselinestretch}{1.66}\small\normalsize}

% A command pirated from chngpage.sty
\DeclareRobustCommand{\ch@ngetext}{%
  \setlength{\@colht}{\textheight}\setlength{\@colroom}{\textheight}%
  \setlength{\vsize}{\textheight}\setlength{\columnwidth}{\textwidth}%
  \if@twocolumn%
    \advance\columnwidth-\columnsep \divide\columnwidth\tw@%
    \@firstcolumntrue%
  \fi%
  \setlength{\hsize}{\columnwidth}%
  \setlength{\linewidth}{\hsize}%
}

% A command to make margins right for the initial single sided business.
\newcommand{\preliminarymargins}{%
    \addtolength{\textwidth}{-0.5in}%
    \addtolength{\evensidemargin}{0.5in}%
    \ch@ngetext%
    }

% A command to fix the margins after the initial single sided business.
\newcommand{\fixmargins}{%
    \addtolength{\textwidth}{0.5in}
    \addtolength{\evensidemargin}{-0.5in}
    \ch@ngetext%
}

% Define the preliminary section for a senior thesis.  
% The senior option is essentially ignored since it is the default 
  \newcommand{\makepreliminarypages}{
    \preliminarymargins 
    \titlepage 
    \copyrightpage 
    \seniorapprovalpage 
    \abstractpage 
    \acknowledgmentspage 
    \fixmargins
    \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
  }

% Define the honors thesis preliminary section if the 'honors' option is specified
\DeclareOption{honors}{
  \renewcommand{\makepreliminarypages}{
    \preliminarymargins
    \honorstitlepage 
    \copyrightpage 
    \seniorapprovalpage 
    \abstractpage 
    \acknowledgmentspage 
    \fixmargins
    \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
  }
}

% Changes to masters thesis preliminary section if the 'masters' option is specified
\DeclareOption{masters}{
  \degree{Master of Science}
  \docname{thesis}
  \renewcommand{\makepreliminarypages}{
    \preliminarymargins
    \titlepage 
    \copyrightpage 
    \masterapprovalpage 
    \acceptancepage 
    \abstractpage 
    \acknowledgmentspage 
    \fixmargins
    \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
  }
}

% Changes to PhD preliminary section if the 'phd' option is specified
\DeclareOption{phd}{
  \degree{Doctor of Philosophy}
  \docname{dissertation}
  \renewcommand{\makepreliminarypages}{ 
    \preliminarymargins
    \titlepage 
    \copyrightpage 
    \phdapprovalpage 
    \acceptancepage 
    \abstractpage 
    \acknowledgmentspage 
    \fixmargins
    \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
  }
}

% --------------------- Some commands to handle the single sided preliminary pages ------------------

% Define the '\clearemptydoublepage' command to clear pages but not number any blank pages inserted.
% This is taken from the BYUThesis.cls file
\let\cle@rdoublep@ge\cleardoublepage
\newcommand{\cle@remptydoublep@ge}{
  \clearpage
  \if@twoside
  \ifodd\c@page\else
  \fi\fi
  {\pagestyle{empty}\cle@rdoublep@ge}}
\newcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}


% Create an abstract environment which is single sided, even in a double sided book.
% again, this was taken from BYUThesis.cls
\def\skip@bstr@ctp@ges{\relax}
\def\@@skip@bstr@ctp@ges{%
  \if@twoside
   \ifodd\c@page\else
    \vbox{\vbox to \vsize{}}
    \clearpage\fi
   \else
  \fi
  \afterpage{\skip@bstr@ctp@ges}
}
\newenvironment{abstractenv}{
   \def\skip@bstr@ctp@ges{\@@skip@bstr@ctp@ges}
   \afterpage{\skip@bstr@ctp@ges \thispagestyle{empty}}
   \pagestyle{empty}
}

% Redefine above commands if etd option is specified.  The blank pages make printing nice,
% but they don't want them in the submitted PDF
\DeclareOption{etd}{
    \renewcommand{\clearemptydoublepage}{ \clearpage }
    \renewenvironment{abstractenv}{\afterpage{\thispagestyle{empty}}\pagestyle{empty}}{} 
  }

% ------------------------ Load the class and needed packages ---------------------------------

% Load the book class  
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}} 
\ProcessOptions\relax 
\LoadClass[letterpaper,12pt]{book}

% The afterpage package is required to make single sided formal pages 
% in a double sided environment
\RequirePackage{afterpage}

% Note: the hyperref package is required to make an appropriate ETD.
% However, we don't require it here since it is supposed to be the last
% package loaded and students may want to load other packages in the 
% main tex file.  So that this class file doesn't crash if the student
% forgets to load hyperref, we have used the following commands below:
%
%   \providecommand\phantomsection{}
%   \providecommand\pdfbookmark[3][]{}
%
% These commands provide dummy versions of the macros, but won't
% bother the real versions if the hyperref package is loaded in the 
% tex file.


% ---------------------------- main code ----------------------------

% Set the margins to BYU specifications for the single sided preliminary
% pages.  At the end of the \makepreliminarypages command we fix the margins
% to be appropriate alternating values for double sided printing (if selected).
% If the \makepreliminarypages macro is not run, this never gets fixed. 
  \setlength{\marginparwidth}{0pt}
  \setlength{\marginparsep}{0pt}
  \setlength{\oddsidemargin}{0.5in}
  \setlength{\evensidemargin}{0in}
  \setlength{\textwidth}{6in}
  \setlength{\topmargin}{0in}
  \setlength{\headheight}{0.125in}
  \setlength{\headsep}{0.25in}
  \setlength{\textheight}{8.625in}
  \setlength{\footskip}{0.25in}
  \raggedbottom

% Redefine the Table of Contents to deal with some blank page 
% and bookmarking issues relating to ETD submission
\let\TEMPtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
  \clearemptydoublepage
  \providecommand\phantomsection{} \phantomsection
  \addcontentsline{toc}{chapter}{Table of Contents}
  \TEMPtableofcontents
}
 
% Redefine the List of Figures to deal with some blank page 
% and bookmarking issues
\let\TEMPlistoffigures\listoffigures
\renewcommand{\listoffigures}{
  \providecommand\phantomsection{} \phantomsection
  \addcontentsline{toc}{chapter}{List of Figures}
  \TEMPlistoffigures
}

% Redefine the Bibliography to deal with a bookmarking issues
\let\TEMPbibliography\bibliography
\renewcommand{\bibliography}{
  \providecommand\phantomsection{} \phantomsection
  \addcontentsline{toc}{chapter}{Bibliography}
  \TEMPbibliography
}

%---------------------------- The Preliminary Page Definitions --------------------------
 
% ============================== Title Page ===============================
\renewcommand{\titlepage}{
    \thispagestyle{empty}
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Title Page}{bm:Title}    
    \vspace*{0.385in}
    \@TitleTop\\[\baselineskip]
	\@TitleMiddle\\[\baselineskip]
    \@TitleBottom\\
    \vfill
    by\\[\baselineskip]
    \@Author
    \vfill
    A \@docname~submitted to the faculty of\\[\baselineskip]
    Brigham Young University - Idaho\\[\baselineskip]
    in partial fulfillment of the requirements for the degree of\\[\baselineskip]
    \vskip0.667in
    \@degree \\
    \vfill
    Department of Physics\\[\baselineskip]
    Brigham Young University - Idaho\\[\baselineskip]
    \@Month~\@Year \\[\baselineskip]
    \end{center}
    \clearemptydoublepage
  }

% ============================== Honors Title Page ========================
\newcommand{\honorstitlepage}{
    \thispagestyle{empty}
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Title Page}{bm:Title}    
    \vspace*{0.375in}
    \@TitleTop\\[\baselineskip]
    \@TitleBottom\\
    \vfill
    by\\[\baselineskip]
    \@Author
    \vfill
    Submitted to Brigham Young University in partial fulfillment\\[\baselineskip]
    of graduation requirements for University Honors\\[2\baselineskip]
    Department of Physics and Astronomy\\[\baselineskip]
    \@Month~\@Year
    \vfill
    \end{center}
    \parbox[t]{2.75in}{
        Advisor: \@Advisor \\[.5\baselineskip]
        Signature: \hrulefill}
    \hfill
    \parbox[t]{2.75in}{
        Honors Dean: \@HonorsDean \\[.5\baselineskip]
        Signature: \hrulefill}
    \clearemptydoublepage
  }

% ======================== Copyright page ===============================
\newcommand{\copyrightpage}{
    \thispagestyle{empty}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Copyright}{bm:Copyright}    
    \vspace*{\fill}
    \begin{center}
    Copyright \copyright\ \@Year~\@Author\\[\baselineskip]
    All Rights Reserved\\[5\baselineskip]
    \end{center}
    \vspace{1in}
    \vfill
    \clearemptydoublepage
  }

% =============================== Approval page =======================
\newcommand{\datebox}{
    \parbox[t]{1.5in}{
        \ \\[2\baselineskip]
        \rule{1.5in}{0.4pt}\\
        Date
    }
} 

\newcommand{\signaturebox}[1]{
    \parbox[t]{3.6in}{
        \ \\[2\baselineskip]
        \rule{3.6in}{0.4pt}\\
        #1
    }
}

\newcommand{\phdapprovalpage}{
    \thispagestyle{empty}
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Graduate Committee Approval}{bm:ComAp}    
    \vspace*{0.375in}
    BRIGHAM YOUNG UNIVERSITY - IDAHO\\[3\baselineskip]
    GRADUATE COMMITTEE APPROVAL\\[5\baselineskip]
    of a \@docname~submitted by\\[\baselineskip]
    \@Author\\[2\baselineskip]
    \end{center}
    \noindent
    This dissertation has been read by each member of the following graduate committee 
    and by majority vote has been found to be satisfactory.\\[\baselineskip]
    \datebox\hfill\signaturebox{\@Advisor, Chair}\\
    \datebox\hfill\signaturebox{\@MemberA}\\
    \datebox\hfill\signaturebox{\@MemberB}\\
    \datebox\hfill\signaturebox{\@MemberC}\\
    \datebox\hfill\signaturebox{\@MemberD}
    \vfill
    \clearemptydoublepage
  }

\newcommand{\masterapprovalpage}{
    \thispagestyle{empty}
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Graduate Committee Approval}{bm:ComAp}    
    \vspace*{0.375in}
    BRIGHAM YOUNG UNIVERSITY - IDAHO\\[3\baselineskip]
    GRADUATE COMMITTEE APPROVAL\\[5\baselineskip]
    of a \@docname~submitted by\\[\baselineskip]
    \@Author\\[2\baselineskip]
    \end{center}
    \noindent
    This thesis has been read by each member of the following graduate committee 
    and by majority vote has been found to be satisfactory.\\[\baselineskip]
    \datebox\hfill\signaturebox{\@Advisor, Chair}\\
    \datebox\hfill\signaturebox{\@MemberA}\\
    \datebox\hfill\signaturebox{\@MemberB}\\
    \vfill
    \clearemptydoublepage
  }

\newcommand{\seniorapprovalpage}{
    \thispagestyle{empty}
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Department Approval}{bm:DepAp}    
    \vspace*{0.375in}
    BRIGHAM YOUNG UNIVERSITY - IDAHO\\[3\baselineskip]
    DEPARTMENT APPROVAL\\[5\baselineskip]
    of a \@docname~submitted by\\[\baselineskip]
    \@Author\\[2\baselineskip]
    \end{center}
    \noindent
    This thesis has been reviewed by the research advisor, 
    research coordinator, and department chair and has been 
    found to be satisfactory.\\[\baselineskip]
    \datebox\hfill\signaturebox{\@Advisor, Advisor}\\
    \datebox\hfill\signaturebox{\@MemberA, Committee Member}\\
    \datebox\hfill\signaturebox{\@MemberB, Committee Member}\\
    \datebox\hfill\signaturebox{\@ThesisCoordinator, Thesis Coordinator}\\
    \datebox\hfill\signaturebox{\@DepRep, Department Chair}\\
    \vfill
    \clearemptydoublepage
  }

% ======================= Acceptance Page ============================
\newcommand{\acceptancepage}{
    \thispagestyle{empty}%
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Acceptance Page}{bm:Accept}    
    \vspace*{0.375in}
    BRIGHAM YOUNG UNIVERSITY\\[3\baselineskip]
    \end{center}%
    \noindent%
    As chair of the candidate's graduate committee, I have read the
    \@docname\ of \@Author \ in its final form and have found
    that (1) its format, citations, and bibliographical style are
    consistent and acceptable and fulfill university and department
    style requirements; (2) its illustrative materials including
    figures, tables, and charts are in place; and (3) the final
    manuscript is satisfactory to the graduate committee
    and is ready for submission to the university library.\\[2\baselineskip]
    \datebox\hfill\signaturebox{\@Advisor\\Chair, Graduate Committee}
    \vskip 0pt plus 2fill
    \noindent Accepted for the Department\par\hfill%
    \signaturebox{\@DepRep, \@DepRepTitle\\Department of Physics and
    Astronomy }{} \vfill \noindent Accepted for the College\par\hfill
    \signaturebox{\@Dean, \@DeanTitle \\
    College of Physical and Mathematical Sciences}
    \clearemptydoublepage
  }

% ========================= Abstract ===================================

\newcommand{\abstractpage}{
    \thispagestyle{empty}
    \begin{abstractenv}
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Abstract}{bm:Abstract}    
    \vspace*{0.375in}
    ABSTRACT\\[3\baselineskip]
    \@TitleTop\\[\baselineskip]
    \@TitleBottom\\[3\baselineskip]
    \@Author\\[\baselineskip]
    Department of Physics and Astronomy\\[\baselineskip]
    \@degree\\[3\baselineskip]
    \end{center}   
    \renewcommand{\baselinestretch}{1.66}\small\normalsize
    \@Abstract
    
    \end{abstractenv}
    \clearemptydoublepage
  }

% ========================= Acknowledgments ==============================
\newcommand{\acknowledgmentspage}{
    \renewcommand{\baselinestretch}{1}\small\normalsize
    \thispagestyle{empty}
    \begin{center}
    \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Acknowledgments}{bm:Acknowledge}    
    \vspace*{0.375in}
    ACKNOWLEDGMENTS\\[3\baselineskip]
    \end{center}
    
    \renewcommand{\baselinestretch}{1.66} \small\normalsize%
    \@Acknowledgments  
    \clearemptydoublepage
  }


