\def\fileversion{1.1}
\def\filedate{2019/10/03}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{DossierExMathIta}[\filedate\space Version \fileversion\space by
Fulvio Frapolli]

\RequirePackage{ifthen}  %%% if then is used all along
\RequirePackage{atveryend} %% TO REMOVE, NOT USED ?
\RequirePackage{filecontents} %% STORE BODY IN A SEPARATE FILE
\RequirePackage{xparse}
\DeclareOption*{%not working TODO
\PackageWarning{DossierExMathIta}{Unknown option ‘\CurrentOption’}%
}

\DeclareOption{finale}{%REMOVE DRAFT, SET FINAL VERSION
\PassOptionsToPackage{\CurrentOption}{FulvioCustomIta}
}

%%%  START: BOOLEAN VARIABLES%%%
\newif\if@onefile\@onefilefalse
\DeclareOption{oneFile}{%PRINT ONS SINGLE FILE: TOC, EXERCISES AND SOLUTIONS AT THE END
\@onefiletrue
}



\newif\if@ssectnum \@ssectnumfalse
\DeclareOption{ssectnum}{% boolean forthe question's numbering: here  with prepended section and subsection  number %%%
\@ssectnumtrue
}

\newif\if@sectnum \@sectnumfalse
\DeclareOption{sectnum}{% boolean forthe question's numbering: here  with prepended section number %%%
\@sectnumtrue
}


\newif\if@twocol \@twocolfalse
\DeclareOption{twocol}{ % PRINT EX ANS SOLUTIONS IN TWO COLUMNS FORMAT
\@twocoltrue
}

\newif\if@attivita\@attivitafalse
\DeclareOption{attivita}{ % PRINT EX ANS SOLUTIONS IN TWO COLUMNS FORMAT
\@attivitatrue
}



\newif\if@soltwocol\@soltwocolfalse
\DeclareOption{soltwocol}{%PRINT ONLY THE SOLUTIONS IN TWO COLUMNS FORMAT
\@soltwocoltrue
}
\newif\if@soltwocolnb\@soltwocolnbfalse
\DeclareOption{soltwocolnb}{%PRINT ONLY THE SOLUTIONS IN TWO COLUMNS FORMAT
\@soltwocolnbtrue
}
%%% END : BOOLEAN VARIABLES %%%

\DeclareOption*{%allows for non implemented options 
  \PassOptionsToClass{\CurrentOption}{exam}%
}

\ProcessOptions\relax

%% Load the exam class
\LoadClass[a4paper,11pt,addpoints]{exam}

\NeedsTeXFormat{LaTeX2e}[1999/01/01]
\ProvidesPackage{FulvioCustomIta}[2019/08/19]
%%%CHANGELOG 13.11.2018
%% removed babel , frenchb and ngerman, pain in the ass for nothing l.14, l144, l.153, l.157
%% readded for table of content french, ngerman l 16 and \updatelang macro
% French documents
\RequirePackage[utf8] {inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{ifthen}
\RequirePackage[table]{xcolor}
\RequirePackage{currfile}
\RequirePackage{xstring}
% Common typical packages
\RequirePackage{amsmath,amsthm,amssymb}
\RequirePackage{enumerate}
\RequirePackage{siunitx}

%%%%\RequirePackage[frenchb,ngerman] {babel}  % ou french ????? 
\RequirePackage[italian] {babel}
\RequirePackage{xfrac}
%\pagestyle{empty} % sans numérotation de page
\RequirePackage{graphicx}
\RequirePackage{tabularx}
\RequirePackage{wrapfig}%pour intégrer des images dans le texte
\RequirePackage{multicol}
\RequirePackage{setspace} % permet d'augm l'interligne
\RequirePackage{lastpage} % compte le nombre de page
\RequirePackage{environ}
\RequirePackage{float}
\RequirePackage{cancel}
\RequirePackage{array}
\RequirePackage{pgf}
\RequirePackage{tikz}
\usetikzlibrary{shapes,arrows,angles,quotes,intersections,babel}
\RequirePackage{pgfplots}
\RequirePackage{calc}
\RequirePackage{tkz-euclide}
\RequirePackage{lmodern}


\RequirePackage{pgfpages}
\RequirePackage{atbegshi}

\RequirePackage{pgfplotstable}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage{caption}
\RequirePackage{gensymb}

\RequirePackage{adjustbox}
\RequirePackage{tikz-dimline,datetime}
\RequirePackage[useregional]{datetime2}
\RequirePackage{needspace}
\RequirePackage{commath} % \dif differenziale, \norm norma vettori ecc.
\RequirePackage{fontawesome} % \FaPlane ecc
\RequirePackage{polynom}
\RequirePackage{empheq}
\RequirePackage{marginnote}
\RequirePackage{helvet}


%%%%% 
\newif\if@draftexam \@draftexamtrue
\DeclareOption{finale}{%if the option draft is used set it 
    \@draftexamfalse
}

\newif\if@exam \@examfalse
\DeclareOption{exam}{
    \@examtrue
}

\newif\if@dsa \@dsafalse
\DeclareOption{dsa}{
    \@dsatrue
}



\DeclareOption{soluzioni}{% Pour imprimer les solutions
    \printanswers
}

\newif\if@prof \@proffalse
\DeclareOption{prof}{% Pour imprimer les solutions
    \@proftrue
    \printanswers
}

\newif\if@student\@studentfalse
\DeclareOption{student}{% Pour imprimer les solutions en short
    \@studenttrue
}




\newif\if@todo  \@todofalse
\DeclareOption{todo}{
    \@todotrue
}






\ProcessOptions\relax

\AtBeginDocument{
    % \updatelang

}

%%% Arial font
\if@dsa
    
    \renewcommand{\familydefault}{\sfdefault}
    \renewcommand{\baselinestretch}{1.3}

\fi

% % Draft / Final
\if@draftexam %%% if the option draft is set then put the watermark in the document
    \RequirePackage{draftwatermark}
    \SetWatermarkScale{1}
\fi

 %  ACCEPT isSol OPTION VIA SHELL-ESCAPE
 \ifdefined\isSol
     \printanswers
 \fi

% %  ACCEPT isProf OPTION VIA SHELL-ESCAPE
\ifdefined\isProf
    \@proftrue
    \printanswers
\fi


\ifdefined\isStud
    \@studenttrue
\fi



\DeclareMathOperator{\sgn}{sgn}
%%%%% TODO
\newcommand{\done}[1]{\todo[color=green!40]{#1}}
\if@todo

    \usepackage{todonotes}
    \presetkeys{todonotes}{inline}{}

\else
    \usepackage[disable]{todonotes}
\fi

%%%%% Parameters and commands

% DEFAULT LANGUAGE is FRENCH
\selectlanguage{italian} %ou french TODO!!!!
% SIUNITX
\DeclareSIUnit\CHF{CHF}
%\sisetup{locale = FR} % Tolto dopo discussione con Reto, meglio il . come separatore decimale

%    % For multilanguage prupose (CHANGE LANGUAGE)
%    \newcommand{\updatelang}{
%    \if@french
%   % \RequirePackage[french] {babel}
%   \selectlanguage{french}
%    \sisetup{locale = FR}
%    \else
%    %%\RequirePackage[ngerman] {babel}
%   \selectlanguage{ngerman}
%    \sisetup{locale = DE}
%    \fi}

%HYperref
\hypersetup{
    colorlinks,
    citecolor=black,
    filecolor=black,
    linkcolor=black,
    urlcolor=black
}



% TIKZ


\tikzstyle{decision} = [diamond, draw, text width=4.5em,
text badly centered, node distance=2cm,
inner sep=0pt]
\tikzstyle{block} = [rectangle, draw, text width=6em,
text centered, rounded corners,
minimum height=3em, node distance=4cm]

\tikzstyle{bigblock} = [rectangle, draw, text width=6em,
text centered, rounded corners,
minimum height=6cm, node distance=4cm]
\tikzstyle{line} = [draw, -latex']
\tikzstyle{cloud} = [draw, ellipse, node distance=2.5cm, minimum height=2em]
\tikzstyle{blank} = [node distance=1cm]

\tikzstyle{isometric}=[x={(0.710cm,-0.410cm)},y={(0cm,0.820cm)},z={(-0.710cm,-0.410cm)}]
\tikzstyle{manual}   =[x={(1cm,0cm)},y={(0cm,1cm)},z={(0.4cm,0.7cm)}]
\tikzstyle{dimetric} =[x={(0.935cm,-0.118cm)},y={(0cm,0.943cm)},z={(-0.354cm,-0.312cm)}]
\tikzstyle{std}   =[y={(1cm,0cm)},z={(0cm,1cm)},x={(-0.71cm,-0.71cm)}]

\newcommand{\human}[3][1]{
    \node[scale=#1] (#2) at (#3) {
        \begin{tikzpicture}
            \node[circle,fill,minimum size=5mm] (head) {};
            \node[rounded corners=2pt,minimum height=1.3cm,minimum width=0.4cm,fill,below = 1pt of head] (body) {};
            \draw[line width=1mm,round cap-round cap] ([shift={(2pt,-1pt)}]body.north east) --++(-90:6mm);
            \draw[line width=1mm,round cap-round cap] ([shift={(-2pt,-1pt)}]body.north west)--++(-90:6mm);
            \draw[thick,white,-round cap] (body.south) --++(90:5.5mm);
        \end{tikzpicture}};
}


% PAGE , PARAGRAPH STYLE

\setlength{\parindent}{0cm} % fixe à 0 l'indentation (la supprime)

\pgfmathsetmacro{\PI}{3.141592654}% define precision of \pi % this is set here to the value of \pgfmathpi

\pgfmathdeclarefunction{gauss}{3}{%
    \pgfmathparse{1/(#3*sqrt(2*pi))*exp(-((#1-#2)^2)/(2*#3^2))}%
}



% PGF and TIKZ
%\pgfplotsset{compat=1.13} 
\pgfplotsset{compat=1.16}
\usepgfplotslibrary{statistics}
\usepgflibrary{shapes.geometric}
\usetikzlibrary{arrows}
\usetikzlibrary{intersections}
\usepgfplotslibrary{fillbetween}


\tikzset{declare function={cbrt(\x) =\x / abs(\x) *abs(\x)^(1/3);}}

\tikzset{
    cross/.style={
            thick,
            draw=gray,
            cross out,
            inner sep=0pt,
            minimum width=4pt,
            minimum height=4pt,
        },
}

\pgfplotsset{
    AxisDefaults/.style={
            axis lines=middle,
            xlabel=$x$, xlabel style={at=(current axis.right of origin), anchor=west},
            ylabel=$y$, ylabel style={at=(current axis.above origin), anchor=south},
            no markers,
            samples=101,
            every axis plot/.append style={
                    thick,
                    smooth,
                },
            ytick distance={1},
            xtick distance={1},
            grid=both,
        }
}

\pgfplotsset{
    TinyAxisLabels/.style={
            yticklabel style={font=\tiny,xshift=0.5ex},
            xticklabel style={font=\tiny,yshift=0.5ex},
        }
}

\pgfplotsset{
    SmallAxisLabels/.style={
            yticklabel style={font=\small,xshift=0.5ex},
            xticklabel style={font=\small,yshift=0.5ex},
        }
}


\pgfplotsset{
    TrigDefaults/.style={
            trig format plots=rad,
            % scale x axis values by \pi and
            % remove the corresponding label
            scaled x ticks={real:\PI},
            xtick scale label code/.code={},
            % in case you want to set an explicit tick distance
            xtick distance=\PI/2,
            % add code here for formatting the `xlabels'
            % I configured exceptions for \pm\pi where no number in front
            % of these are shown and for fractional values these should be
            % shown as fractions
            xticklabel={%
                    \ifdim \tick pt = 1 pt
                        \strut$\pi$%
                    \else\ifdim \tick pt = -1 pt
                            \strut$-\pi$%
                        \else
                            % to avoid some mess with TeX precision, first
                            % round the \tick value to one digit after the comma
                            \pgfmathparse{round(10*\tick)/10}
                            % depending on whether the resulting number is an integer
                            % show it as integer only, otherwise use the style given
                            % in `xticklabel style'
                            \pgfmathifisint{\pgfmathresult}{%
                                \strut$\pgfmathprintnumber[int detect]{\pgfmathresult}\pi$%
                            }{%
                                \strut$\pgfmathprintnumber{\pgfmathresult}\pi$%
                            }
                        \fi\fi
                },
            % set number plotting to frac style
            xticklabel style={
                    /pgf/number format/frac,
                    /pgf/number format/frac whole=false,
                },
        }
}


% tikz circle with center and radius% [draw options] (center) (initial angle:final angle:radius)
%\def\arccenter[#1](#2)(#3:#4:#5){\draw[#1]($(#2)+({#5*cos(#3)},{#5*sin(#3)})$) arc (#3:#4:#5); } 
%\def\arccenter[#1](#2)(#3:#4:#5){\gdef\@arccenter{#1}{#2}{#3}{#4}{#5}}
%
%\def\@title{\@latex@error{No \noexpand\title given}\@ehc}
%\def\arccenter[#1](#2)(#3:#4:#5)%
%{\draw[#1]($(#2)+({#5*cos(#3)},{#5*sin(#3)})$) arc (#3:#4:#5); } 

% TKZ-EUCLIDE
%\usetkzobj{all}  
\usetikzlibrary{calc,decorations.pathmorphing,patterns}



% IMAGES and INPUT PATH

\DeclareGraphicsExtensions{.pdf,.png,.jpg}
\def\input@path{{../DB/}{./DB/}{./}{../ch/}{./ex/}{./temi}{../temi}}  %pour les exercices
\graphicspath{{../DB/images/}{./images/}{./}{./img/}{../img/}{./temi/img/}{./tikz}{../tikz}} % pour le logo et les images des exercices





\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}



% New version, circle too long to type
\newcommand{\pts}[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=2pt] (char) {#1};}}


\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\ED}{\mathbb{ED}}
\newcommand{\DD}{\mathbb{D}}
\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}
\newcolumntype{N}{@{}m{0pt}@{}}

% Norme, length of a vector
%\newcommand\norm[1]{\left\lVert#1\right\rVert} %% Già definito nel pacchetto commath

%
%\def\@centerarc[#1](#2)(#3:#4:#5){ % Syntax: [draw options] (center) (initial angle:final angle:radius)
%\draw[#1] ($(#2)+({#5*cos(#3)},{#5*sin(#3)})$) arc (#3:#4:#5); }


\newenvironment{Tabular}[2][1]
{\def\arraystretch{#1}\tabular{#2}}
{\endtabular}

\newenvironment{qblock}
{
\begin{minipage}{\textwidth}
}
{
    \end{minipage}
    \bigskip
}
% Solutions

\newcommand{\sol}[1]{ %print only if solutions
    \ifprintanswers
        \if@student
        \else
            #1
        \fi
    \fi
}


\newcommand{\ssol}[1]{ %short solutions 'ssol'  only  solution without explanations (Students compact form)
    \ifprintanswers
        \if@student
            #1
        \else
        \fi
    \fi
}



%%% START: print only if exercices or only if solution %%%
\newcommand{\exonly}[1]{
    \ifprintanswers
    \else
        #1
    \fi
}



\newcommand{\solonly}[1]{
    \ifprintanswers
        #1
    \fi
}

\newcommand{\solnewpage}{
    \ifprintanswers
        \newpage
    \fi
}

\newcommand{\solcbreak}{
    \ifprintanswers
        \columnbreak
    \fi
}

\newcommand{\exnewpage}{
    \ifprintanswers
    \else
        \newpage
    \fi

}

\newcommand{\excbreak}{
    \ifprintanswers
    \else
        \columnbreak
    \fi

}



%%% END %%%


\newcommand{\rsol}[1]{
    \ifprintanswers \color{red} #1 \color{black}\fi
}

\NewEnviron{prof}[1][]  % environnemt pour la version prof (sans paramètre -> rouge inline, ou avec cm d'espace à laisser )
{\ifthenelse{\equal{#1}{}}
    {
        \ifprintanswers \color{red}  \else \color{white}  \fi
        \BODY
        \color{black}
    }
    {
        \parbox[t][#1][t]{0.95\linewidth}{
            \ifprintanswers \color{red} \else \color{white} \fi
            \BODY
            \color{black} }
    }}

\NewEnviron{profonly}
{
    \if@prof \color{red}
        \BODY
        \color{black}
    \fi
}


%%% Ensemble des solutions

\newcommand{\es}[1]{%
    S=\left\lbrace  #1\checknextarg}
\newcommand{\checknextarg}{\@ifnextchar\bgroup{\gobblenextarg}{ \right\rbrace }}
\newcommand{\gobblenextarg}[1]{;#1\@ifnextchar\bgroup{\gobblenextarg}{ \right\rbrace }}


%%%% Veteurs , matrices parenthèses rondes

%\newcommand\vvec[1]{\begin{pmatrix}#1\end{pmatrix}} 

\NewDocumentCommand{\vvec}{ >{\SplitArgument{2}{,}} m }{\printvec#1}
\NewDocumentCommand{\printvec}{mmm}{\begin{pmatrix}#1 \\ #2 \IfValueT{#3}{\\#3} \end{pmatrix}
}

%%BACK COMPATIBILITY .. USE VVEC (ABOVE!!)
\newcommand\vecII[2]{\begin{pmatrix}#1 \\ #2 \end{pmatrix}}
\newcommand\vecIII[3]{\begin{pmatrix}#1 \\ #2 \\#3\end{pmatrix}}

%%% TRUE False questions use: \tf[SOL: V or F]
\newcommand{\tf}[1][{}]{%
    \fillin[#1][0.25in]
}




\NewEnviron{solline} { % laisse l'espace souligné pour sol élève ou sol prof en rouge
    \ifprintanswers \color{red} \BODY \else \underline{ \color{white} \BODY}\fi \color{black} }

%%%%% COMANDI RETO %%%%
\providecommand{\dif}{\mathop{}\!\mathrm{d}}
\providecommand{\ii}{\mathop{}\!\mathrm{i}}
\providecommand{\dom}[1]{\mathop{}\!\mathrm{Dom}_{#1}}
\providecommand{\cod}[1]{\mathop{}\!\mathrm{Cod}_{#1}}
\providecommand{\immagine}[1]{\mathop{}\!\mathrm{Im}_{#1}}
\providecommand{\e}[1]{\times 10^{#1}}
\providecommand{\mcm}[1]{\mathop{}\!\mathrm{mcm}({#1})}
\providecommand{\MCD}[1]{\mathop{}\!\mathrm{MCD}({#1})}
%\providecommand{\ex}[1]{\mathop{}\!\mathrm{e}^{#1}}
\providecommand{\vd}[2]{\begin{bmatrix} {#1} \\ {#2} \end{bmatrix}}
\providecommand{\vt}[3]{\begin{bmatrix} {#1} \\ {#2} \\ {#3} \end{bmatrix}}

\newcommand\updatesectfromfile{
    \StrBefore*{\currfilebase}{-E-}[\secct]
    \setcounter{section}{\secct}
    \addtocounter{section}{-1}}


\RequirePackage{subfiles}
\RequirePackage{xfrac}
\RequirePackage{chngcntr}
\RequirePackage{pdfpages}
\RequirePackage{titlesec}



%% GEOMETRY OF THE PAGE
% \newgeometry{left=2cm, right=2cm,top=2cm,bottom=2cm}



%%% START: Sections underlined %%%
\titleformat{\section}
{\normalfont\Large\bfseries}{\thesection}{1em}{}[{\titlerule[0.8pt]}]
%%% END %%%

%%% START: title for exercices and solution page %%%

\newcommand{\titolo}[2][]{
\ifthenelse{\equal{#1}{}}{\renewcommand{\indice}{}}{}
\pagestyle{headandfoot}
%\runningheadrule
\firstpageheader{\ifprintanswers \textsc{Soluzioni}  \else  \textsc{Esercizi} \fi}{\textsc{#2}}{\@author \the\year{}}
\runningheader{\ifprintanswers \textsc{Soluzioni}   \else  \textsc{Esercizi} \fi}{\textsc{#2}}{\@author \the\year{}}
\title{
\Huge 
\textsc{#2}\\ \ifprintanswers Soluzioni  \else  Esercizi  \fi 
}
}

%%% START: put table of contents only in the exercices and not in the solutions%%%
\newcommand{\indice}{
\maketitle
%\exonly{\tableofcontents}
 \tableofcontents
%\exonly{\newpage}
\newpage
}


\if@sectnum
\qformat{\textbf{Esercizio \thesection.\arabic{question}}\hfill }
%\qformat{\textbf{\thesection.\arabic{question}}\hfill }
%V1%\renewcommand{\thequestion}{\thesection.\arabic{question}} % Section . Question
%V1%\patchcmd{\questions}{10.}{\thequestion.}{}{}
\AtEndPreamble{\setlength{\columnsep}{0.3cm}}

\else

\if@ssectnum
\qformat{\textbf{Esercizio \thesubsection.\arabic{question}}\hfill }
\AtEndPreamble{\setlength{\columnsep}{0.3cm}}

\else

\qformat{\textbf{Esercizio \arabic{question}}\hfill }
\fi
\fi
%%% END:   Numbering of questions according to sections %%% 


%%% END: put table of contents only in the exercices and not in the solutions%%%

%%% START: Set and reset target ex (starred) %%%
\newcommand{\setobj}{\renewcommand\questionlabel{\textbf{\thequestion.}\makebox[0pt]{$^{\star}$}}}
\newcommand{\resetobj}{\renewcommand\questionlabel{\textbf{\thequestion.}}}

% CHOICE ENVIRONMENT
\checkboxchar{$\Box$}
\checkedchar{$\blacksquare$}

%%% END: Questions appearance %%%

%%% START: HEADERS AND FOOTER APPEARANCE %%%
\firstpageheader{}{}{}
\firstpagefooter{}{ \thepage  \ / \numpages}{}
\runningfooter{}{ \thepage  \ / \numpages}{}

\pagestyle{headandfoot}
%%% END: HEADERS AND FOOTER APPEARANCE %%%





\colorgrids %%%%% Set the grid to gray
\definecolor{GridColor}{gray}{0.5}


\renewcommand{\questionshook}{%
\setlength{\leftmargin}{0pt}%
\setlength{\labelwidth}{-\labelsep}%
}


%%% CLASS SPECIFIC COMMANDS %%%
\if@soltwocol
\ifprintanswers
\BeforeBeginEnvironment{questions}{\begin{multicols}{2}}
\AfterEndEnvironment{questions}{\end{multicols}}
\fi
\else
\if@soltwocolnb
\BeforeBeginEnvironment{questions}{\begin{multicols*}{2}}
\AfterEndEnvironment{questions}{\end{multicols*}}
\else
\fi
\if@twocol
\else
\renewcommand{\solcbreak}{}
\fi
\fi

\if@twocol
\BeforeBeginEnvironment{questions}{\begin{multicols}{2}}
\AfterEndEnvironment{questions}{\end{multicols}}
\else
\renewcommand{\excbreak}{}
\fi



\NewDocumentEnvironment { exandsol } %%% DO NOT USE, USE ONEFILE INSTEAD with docbody
{ +b }
{
#1 
\printanswers
\newpage
%\section*{Solutions}
\begin{center}\huge \textbf{Soluzioni} \end{center}
\label{sec:sol}
\addcontentsline{toc}{section}{Soluzioni}
\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
\setcounter{section}{0}
#1
} {}

\NewDocumentEnvironment { docbody } %% PUT EXERCISES WITHIN A DOCBODY TO ALLOW ONEFILE PRINT
{ +b }
{
#1 
\if@onefile 
\printanswers
\newpage
\begin{center}\huge \textbf{Soluzioni} \end{center}
\label{sec:sol}
\addcontentsline{toc}{section}{Soluzioni}
\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
\setcounter{section}{0}
\if@soltwocol
\ifprintanswers
\BeforeBeginEnvironment{questions}{\begin{multicols}{2}}
\AfterEndEnvironment{questions}{\end{multicols}}
\fi
\else
\if@twocol
\else
\renewcommand{\solcbreak}{}
\fi
\fi
#1
\fi
} {}


\newcommand{\processbody}[1] %% DO NOT USE
{

\input{#1}
\if@onefile 
\printanswers
\if@soltwocol
\ifprintanswers
\BeforeBeginEnvironment{questions}{\begin{multicols}{2}}
\AfterEndEnvironment{questions}{\end{multicols}}
\fi
\fi

\newpage
\begin{center}\huge \textbf{Soluzioni} \end{center}
\label{sec:sol}
\addcontentsline{toc}{section}{Soluzioni}
\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
\setcounter{section}{0}
\input{#1}
\fi

}



\NewDocumentEnvironment { twice }
{ +b }
{#1 \newpage \printanswers #1} {}

\if@attivita
\newtheorem{attivita}{Attività}

\renewcommand{\exonly}[1]{
	#1
}

\renewcommand{\solonly}[1]{
	\ifprintanswers \color{red} #1 \color{black}\fi
}

\newcommand{\esref}[1]{Es.\thesection.#1}

\fi

