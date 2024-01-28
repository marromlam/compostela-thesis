\ProvidesClass{compostelathesis}
\NeedsTeXFormat{LaTeX2e}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Live typesetting with Texifier
% Sets the LiveTypeset=1 for live typesetting and 0 otherwise
\newcommand\LiveTypeset{0}
\DeclareOption{livetypeset}{\renewcommand\LiveTypeset{1}}
% NOTE: livetypeset-ing disables some features because the Texifier typesetter
%       cannot live compile with them enabled.
%       Namely this packages are disabled":
%        - microtype: some font rendering won't be as in full typeset
%        - lettrine: first letter of any chapter won't render as lettrine
%
% More:
% https://www.texifier.com/docs/tutorials/tex/typesetters/texpadtex/package-coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% the basics {{{

% Based on the memoir class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions
\LoadClass{memoir}

% Fixes
\RequirePackage{memhfixc}

% Internal variables
\newcommand{\@subtitle}{}
\newcommand{\@scm}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\scm}[1]{\renewcommand{\@scm}{#1}}

% }}}


% Fonts {{{

\RequirePackage[utf8]{inputenc}
\if\LiveTypeset0
    \input{lettrine}
\else
    \newcommand{\lettrine}[1]{#1}
\fi


%\usepackage[osf,scaled=.92]{heuristica}
\usepackage[T1]{fontenc}

% Other chars
\if\LiveTypeset0
    \newcommand\textcyr[1]{{\fontencoding{T2A}\selectfont #1}}
    \usepackage{CJKutf8}
    \newcommand{\zh}[1]{\begin{CJK}{UTF8}{gbsn}#1\end{CJK}}
\fi


\usepackage[oldstyle]{libertine}
\renewcommand*\libertine@figurestyle{LF}
\usepackage[libertine]{newtxmath}
\renewcommand*\libertine@figurestyle{OsF}
\usepackage[varqu,varl]{inconsolata} % typewriter
\usepackage[type1,scaled=.95]{cabin} % sans serif like Gill Sans

\usepackage[overload]{textcase}
\RequirePackage{microtype}

\newcommand{\ct@altfont}{}% \color{red}\sffamily
\newcommand{\ct@caps}{\ct@altfont\scshape} % typesetting smallcaps

% \renewcommand{\scdefault}{ssc}
%\newfont{\chapnum}{eurb10 scaled 10000}
\newcommand{\lowercaps}[1]{%
  \textsc{\MakeLowercase{#1}}%
}
\newcommand{\uppercaps}[1]{%
  \textsc{\MakeUppercase{#1}}%
}

%%%%%% \microtypesetup{protrusion=true,expansion=true}
\if\LiveTypeset0
\DeclareRobustCommand{\spacedallcaps}[1]{%
  \textls[160]{\ct@caps\MakeTextUppercase{#1}}
}
\DeclareRobustCommand{\spacedlowsmallcaps}[1]{%
  \textls[80]{\ct@caps\MakeTextLowercase{#1}}
}
\else
    \DeclareRobustCommand{\spacedallcaps}[1]{\MakeTextUppercase{#1}}
    \DeclareRobustCommand{\spacedlowsmallcaps}[1]{\MakeTextLowercase{#1}}
\fi

\newcommand*{\abbrev}[1]{%
  \textls[150]{\textsc{#1}}%
}

% Creates an fourier ornament. Args: fontsize, lineheight, char
\RequirePackage{fourier-orns}
\newcommand*{\fourierOrnament}[3]{%
  {\fontencoding{U}\fontfamily{futs}\fontsize{#1}{#2}\selectfont\char#3}%
}

% }}}


% Page layout {{{
% TODO: Include the dimensions file here

%\settypeblocksize{*}{28pc}{2}
%\setlrmargins{*}{*}{3}
%\setulmargins{*}{*}{2}
%\setmarginnotes{2pc}{12pc}{\baselineskip}
%\checkandfixthelayout

% No orphans
\clubpenalty = 500
\widowpenalty = 1000

% Add or remove lines from facing pages
\RequirePackage{addlines}

% Line breaking
% \RequirePackage[final=true,step=1]{microtype}
\RequirePackage{ragged2e}

% }}}


% Colors {{{
%

%\RequirePackage{xcolor}
\usepackage[table, usenames, dvipsnames, svgnames]{xcolor}

\definecolor{red}{HTML}{AD1737}
\definecolor{brown}{HTML}{990000}
\definecolor{bar}{HTML}{8D9965}
\definecolor{scqoldblue}{named}{RoyalBlue}
% \definecolor{scqoldgreen}{named}{PineGreen}
\definecolor{scqoldgreen}{named}{ForestGreen}
\definecolor{scqolred}{named}{OrangeRed}



\colorlet{scqcite}{scqolred}
\colorlet{scqlink}{scqoldgreen}
\colorlet{scqanchor}{scqoldgreen}
\colorlet{scqurl}{scqoldblue}

\colorlet{scqtitle}{scqoldblue}
\colorlet{scqpart}{scqoldblue}
\colorlet{scqchapter}{scqoldblue}
\colorlet{scqsection}{scqoldblue}
%\definecolor{scqtitle}{HTML}{AD1737}
%\definecolor{scqpart}{HTML}{AD1737}
%\definecolor{scqchapter}{HTML}{AD1737}
%\definecolor{scqsection}{HTML}{AD1737}

\definecolor{chapnum}{gray}{0.6}
\definecolor{largeornament}{gray}{0.85}
\definecolor{smallornament}{gray}{0.65}

\colorlet{title}{red}
\colorlet{partnum}{red}
\colorlet{urlcolor}{brown}
\colorlet{tocchapnum}{brown}

% }}}


% Graphics {{{
%

\RequirePackage{graphicx}
\usepackage[extendedchars]{grffile}
% \graphicspath{{../graphics/}} %Setting the graphicspath

\RequirePackage{tikz}

\RequirePackage{sparklines}
\colorlet{sparkspikecolor}{bar}
\setlength{\sparkspikewidth}{5pt}

% }}}


% Math {{{
%

\RequirePackage{amsmath}
% \usepackage{amsfonts, amsmath, bm}
\usepackage{bm}

% do not number unlabeled equations
\newif\ifrefeq@number
%\preto\equation{\refeq@numberfalse}
%\preto\endequation{\ifrefeq@number\else\notag\fi}
\if\LiveTypeset0
    \patchcmd\label@in@display{\@empty}{\@empty\refeq@numbertrue}{}{}
\fi

% select font
\DeclareMathAlphabet{\altmathcal}{OMS}{cmsy}{m}{n}

% }}}


% Styles {{{

% Part style {{{

\renewcommand{\partnamefont}{\raggedright\LARGE\scshape\MakeUppercase}
\renewcommand{\partnumfont}{\color{partnum}\LARGE\scshape\MakeUppercase}
\renewcommand{\parttitlefont}{\color{scqpart}\raggedright\LARGE\scshape}
\renewcommand{\printparttitle}[1]{\parttitlefont \MakeUppercase{#1}}

% }}}

% Chapter style {{{

\makechapterstyle{compostela}{%
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\chapnamefont}{\raggedright\Huge\color{scqchapter}\MakeLowercase}
  \setlength\midchapskip{17pt}
  %
  %   \renewcommand{\printchapternum}{%
  %    \marginpar{%
  %      \vspace{80pt}
  %      \color{chapnum}\chapnum \thechapter
  %      \vspace{20pt}
  %    }%
  %  }%
  \renewcommand\printchapternum{%
    \vspace{1.5cm}%
    %\enspace%
    \ifanappendix%
      %\large\textit{\appendixname}\space\thechapter\space\\[1em]%
      \spacedlowsmallcaps{\appendixname\space\thechapter}\space\\[1em]%
    \else%
      % \textls[160]{\ct@caps\textsc{\chaptername}}~$\thechapter$\space\\[1em]%
      %\large\textit{\chaptername}~$\thechapter$\space\\[1em]%
      \large\spacedlowsmallcaps{\chaptername~\thechapter}\space\\[1em]%
    \fi%
    \enspace%
  }
  %
  \renewcommand\printchapternonum{\par}
  %\renewcommand\chaptitlefont{\raggedright\Huge\color{scqchapter}}
  %  \renewcommand{\printchapternonum}{%
  %    \marginpar{%
  %      \vspace{1.5cm}
  %    }%
  %    \raggedright\Huge\color{scqchapter}\spacedallcaps{##1}%
  %  }%
  %
  \renewcommand\afterchapternum{\par\nobreak\vskip-5pt}
  %\renewcommand{\afterchapternum}{}
  \renewcommand{\printchaptertitle}[1]{%
    \raggedright\Huge\color{scqchapter}\spacedallcaps{##1}
  }%
}

% }}}

% Section style {{{
% \setsecheadstyle{\color{scqsection}\raggedright\LARGE\spacedlowsmallcaps}
\setsecheadstyle{%
  % \color{scqsection}\raggedright\Large\scshape\bfseries\MakeLowercase%
  \color{scqsection}\raggedright\Large\scshape\MakeLowercase%
  % \color{scqsection}\raggedright\Large\scshape\bfseries\spacedlowsmallcaps%
}
%\setsecheadstyle{raggedright\Large\scshape\MakeLowercase}
\setsechook{\hangsecnum}
% \renewcommand{\thesection}{\scshape\arabic{section}}


% Subsection style
\setsubsecheadstyle{\raggedright\Large\scshape\MakeLowercase}
%\setsubsecheadstyle{\raggedright\large\itshape}

% Subsubsection style
\setsubsubsecheadstyle{\raggedright\large\scshape\MakeLowercase}
%\setsubsubsecheadstyle{\raggedright\itshape}

% }}}

% Paragraph style {{{

\setparaheadstyle{\normalsize\scshape\MakeLowercase}
%\setafterparaskip{1ex}

% Paragraph break
\newcommand{\parabreak}{%
  \fancybreak{%
    \vspace{\baselineskip}
    \color{smallornament}\Large\decofourleft
    \vspace{\baselineskip}
  }
}

% }}}

% Header and footer {{{

\renewcommand*{%
  \memUChead}[1]{\textsc{\MakeTextLowercase{#1}}%
}

% Page style
\makepagestyle{compostela}
\makeevenfoot{compostela}{\thepage}{}{}
\makeoddfoot{compostela}{}{}{\thepage}
\makeevenhead{compostela}{\MakeLowercase{\leftmark}}{}{}
\makeoddhead{compostela}{}{}{\rightmark}

% Plain headers and footers
\makeevenfoot{plain}{\thepage}{}{}
\makeoddfoot{plain}{}{}{\thepage}

% Empty part page style
\aliaspagestyle{part}{empty}

% }}}

% }}}


% Table of Contents {{{

\maxtocdepth{section}
\usepackage{etoolbox}
\usepackage{titletoc}

\newcounter{numSubSection}
\setcounter{numSubSection}{0}

\gpreto{\subsection}{\refstepcounter{numSubSection}}

\titlecontents{chapter}[0pt]%
{%
  \addvspace{6pt}\scshape
  \makebox[18pt][r]{%
    \hyperlink{page.\thecontentspage}{\spacedlowsmallcaps{\thecontentspage}}%
    \hspace{6pt}%
  }%
}%
{%
  \makebox[30pt][r]{\thecontentslabel\hspace{12pt}}%
}%
{\makebox[30pt][r]{\null}}%
{}%

\titlecontents{appendix}[0pt]%
{%
  \addvspace{6pt}\scshape
  \makebox[18pt][r]{%
    \hyperlink{page.\thecontentspage}{\spacedlowsmallcaps{\thecontentspage}}%
    \hspace{6pt}%
  }%
}%
{%
  \makebox[30pt][r]{\thecontentslabel\hspace{12pt}}%
}%
{\makebox[30pt][r]{\null}}%
{}%

\renewcommand\cftappendixname{\appendixname~}
\renewcommand\chapternumberline[1]{\numberline{#1}} %not necessary when using the book class
%\renewcommand\appendixnumberline[1]{\numberline{#1}} %not necessary when using the book class

\newlength{\TOCleftSkip}
\setlength{\TOCleftSkip}{48pt}%66
\newlength{\TOCrightSkip}
\setlength{\TOCrightSkip}{40pt} % Length of subsubsection before line return 

\newtoggle{ifSub}
\togglefalse{ifSub}%
\newtoggle{ifSection}
\toggletrue{ifSection}%
\newtoggle{ifChapter}
\toggletrue{ifChapter}%

\newcounter{RefSubSection}%
\setcounter{RefSubSection}{0}%
\renewcommand*\theRefSubSection{\@arabic\c@RefSubSection}%

\renewcommand*{\tableofcontents}{%
  \chapter*{\contentsname}%
  %\addcontentsline{toc}{chapter}{\contentsname}%
  \toggletrue{ifSection}%
  \setcounter{RefSubSection}{0}%
  \@starttoc{toc}}%

\gpreto{\l@chapter}{%
  \nottoggle{ifSection}
  {\par%
    \addtolength{\leftskip}{-\TOCleftSkip}%
    \addtolength{\rightskip}{-\TOCrightSkip}%
    \togglefalse{ifSub}}{}%
  \toggletrue{ifSection}}%

\gpreto{\l@appendix}{%
  \nottoggle{ifSection}
  {\par%
    \addtolength{\leftskip}{-\TOCleftSkip}%
    \addtolength{\rightskip}{-\TOCrightSkip}%
    \togglefalse{ifSub}}{}%
  \toggletrue{ifSection}}%

\renewcommand*{\l@section}[2]{%
  \stepcounter{RefSubSection}%
  \toggletrue{ifSub}%
  \iftoggle{ifSection}
  {\togglefalse{ifSection}%
    \addtolength{\leftskip}{\TOCleftSkip}%
    \addtolength{\rightskip}{\TOCrightSkip}%
    \noindent}%
  {\unskip\begingroup\upshape\small\, \textbullet\,~\endgroup}%
  \begingroup%
  \upshape\small#1\ \hyperlink{numSubSection.\theRefSubSection}{\textsc{#2}}%
  \endgroup}%

\renewcommand*{\l@subsection}[2]{%
  \iftoggle{ifSection}
  {\togglefalse{ifSection}%
    \addtolength{\leftskip}{\TOCleftSkip}%
    \addtolength{\rightskip}{\TOCrightSkip}%
    \noindent}%
  {\iftoggle{ifSub}
    {\togglefalse{ifSub}\relax%
      \unskip\begingroup\upshape\small:\ \endgroup}%
    {\unskip\begingroup\itshape\small,\ \endgroup}}%
  \begingroup\itshape\small#1\endgroup}%

\renewcommand*{\numberline}[1]{}%

% }}}


% List of Figures/Tables {{{

\renewcommand{\cftfigureleader}{ }
\renewcommand{\cftfigureafterpnum}{\cftparfillskip}

\renewcommand{\cfttableleader}{ }
\renewcommand{\cfttableafterpnum}{\cftparfillskip}

% Enumeratable list
\newenvironment{enum}{%
  \begin{list}{\arabic{enumi}}{%
      \setlength{\topsep}{\onelineskip}
      \setlength{\partopsep}{0pt}
      \setlength{\parsep}{\parskip}
      \setlength{\itemsep}{\parskip}
      \setlength{\leftmargin}{0pt}
      \setlength{\itemindent}{0pt}
      \usecounter{enumi}
    }
    }{\end{list}}

% Itemized list
\newenvironment{items}{%
  \begin{list}{\textbullet}{%
      \setlength{\topsep}{\onelineskip}
      \setlength{\partopsep}{0pt}
      \setlength{\parsep}{\parskip}
      \setlength{\itemsep}{\parskip}
      \setlength{\leftmargin}{0pt}
      \setlength{\itemindent}{0pt}
    }
    }{\end{list}}

% Definitions in lists
\newcommand{\iterm}[1]{\item \term{#1}}

% In-paragraph lists
\usepackage{paralist}

% }}}


% Captions {{{

\RequirePackage{caption}
\captionsetup[figure]{font={footnotesize,rm},%
  justification=justified,
  singlelinecheck=true}
\captionsetup[table]{font={footnotesize,rm},%
  justification=justified,
  singlelinecheck=true,%
  position=bottom}
\captionsetup[sourcecode]{font={footnotesize,rm},%
  justification=justified,
  singlelinecheck=true,%
  position=bottom}

\newcommand{\reducecaption}[1]{%
  \strictpagechecktrue
  \checkoddpage
  \ifoddpage%
    \captionsetup{margin={0pc,#1pc}}
  \else%
    \captionsetup{margin={#1pc,0pc}}
  \fi%
}

% }}}


% Tables {{{

\RequirePackage{longtable}
\RequirePackage{pdflscape}
\RequirePackage{multirow}

% }}}


% Hyperlinks {{{

\RequirePackage[plainpages=false]{hyperref}

% break also on hyphens inside the \url command
\def\UrlBreaks{\do\.\do\@\do\\\do\/\do\!\do\_\do\|\do\;\do\>\do\]%
  \do\)\do\,\do\?\do\'\do+\do\=\do\#\do-} % \do- is new!

\urlstyle{sf}

\hypersetup{%
  colorlinks=false,
  linkcolor=scqlink,
  anchorcolor=scqanchor,
  citecolor=scqcite,
  urlcolor=scqurl,
  breaklinks,
  pdfborder=0 0 0,
}

% }}}


% Special environments {{{

% Centered environment
\newlength{\foreminusspine}\setlength{\foreminusspine}{\foremargin}
\addtolength{\foreminusspine}{-\spinemargin}

\newenvironment{centered}{%
  \begin{adjustwidth*}{0em}{-\foreminusspine}
    \centering
    }{%
  \end{adjustwidth*}
}

% }}}


% Colophon {{{

\newcommand{\makecolophon}{%
  \pagestyle{empty}
  \raggedright\small

  \null\vfil

  \begin{adjustwidth*}{\unitlength}{-\unitlength}

    % \newpage
    \noindent\textit{Advisors:}\\
    \myPromotor\\
    \myCopromotor\\[5mm]

    \noindent\textit{Promotor:}\\
    \myAdvisor\\[5mm]


    \noindent\textit{Committee:}\\
    Nazila Mahmoudi\\
    Tatsuya Nakada\\
    Xabier Cid Vidal


    \vfill

    \bigskip

    This thesis was typeset using the \LaTeX{} typesetting\\
    system originally developed by Leslie Lamport,\\
    based on \TeX{} created by Donald Knuth.\\

    \bigskip

    The body text is set 10pt on a 26pc measure with\\
    Libertine designed by Philipp H. Poll.\\
    This proportional serif typeface font was first issued\\
    in 2003 and have since been revised.\\
    Other fonts include Sans and Typewriter from\\
    Biolinum font family, belonging to the same project.\\

    \bigskip

    Typographical decisions were based on the\\
    recommendations given in \emph{The Elements of\\
      Typographic Style} by Robert Bringhurst.\\

    \bigskip

    This thesis has the main physics parameters blinded.\\
    An update will be uploaded to CERN Document Server\\
    where the measurements are unblinded.\\

    \bigskip

    \noindent\myVersion
  \end{adjustwidth*}

  \vfil
}

% }}}


% Titlepage {{{

\RequirePackage{pdfpages}
\renewcommand{\maketitle}{%
  \cleardoublepage
  \begin{titlingpage}
    \begin{centered}
      \null\vspace{3pc}

      {\Huge\color{scqtitle}\uppercaps{Measurement}} \\
      \vspace{1.5pc}
      {\Huge\textit{of the}} \\
      \vspace{1pc}
      {\Huge\color{scqtitle}\uppercaps{bottom-strange meson\\[0.5em] oscillations}} %\\
      %\vspace{1pc}
      {\Huge\,\,\textit{at}\,\,} %\\
      %\vspace{1pc}
      {\Huge\color{scqtitle}\uppercaps{LHC}b} \\

      \vspace{4pc}
      {\Large\aldineleft} \\

      \vspace{5pc}

      {\Large\spacedlowsmallcaps\myName} \\

      \vspace{2pc}

      {\normalsize \textit{\myTime}} \\

      \vspace{5pc}

      \textit{
        Submitted in partial fulfillment of the requirements \\
        for the degree of \myDegree \\
        \vspace{1pc}
        to the \\
        \vspace{1pc}
        \myDepartment \\
        \myFaculty \\
        \myUniversity \\
      }
      \vfill
      \@scm
    \end{centered}
    \clearpage
    \makecolophon
  \end{titlingpage}
}

% }}}


% vim: fdm=marker et ts=2 sw=2
