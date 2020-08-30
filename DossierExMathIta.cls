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

\RequirePackage{FulvioCustomIta}
\RequirePackage{subfiles}
\RequirePackage{xfrac}
\RequirePackage{chngcntr}
\RequirePackage{pdfpages}
\RequirePackage{titlesec}



%% GEOMETRY OF THE PAGE
\newgeometry{left=2cm, right=2cm,top=2cm,bottom=2cm}



%%% START: Sections underlined %%%
\titleformat{\section}
{\normalfont\Large\bfseries}{\thesection}{1em}{}[{\titlerule[0.8pt]}]
%\titleformat{\subsection}{\normalfont\Large\bfseries}{\thesubsection}{1em}{}[{\titlerule[0.8pt]}]
%%% END %%%

%%% START: title for exercices and solution page %%%

\newcommand{\titolo}[2][]{
\ifthenelse{\equal{#1}{}}{\renewcommand{\indice}{}}{}
\pagestyle{headandfoot}
%\runningheadrule
\firstpageheader{\ifprintanswers \textsc{Soluzioni}  \else  \textsc{Esercizi} \fi}{\textsc{#2}}{CPT \the\year{}}
\runningheader{\ifprintanswers \textsc{Soluzioni}   \else  \textsc{Esercizi} \fi}{\textsc{#2}}{CPT \the\year{}}
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







%%% END %%%

%%% START: Numbering of questions according to sections %%%
% numbering of the questions: without or with prepended section number 

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



%%%%% DO NOT USE %%%%
%\apptocmd{\indice}{
%\begin{filecontents}{\jobname-body.txt}
%}{}{}




%%%% Can only be used with
% \begin{filecontents}{file name} BODY \end{fiecontents}
% \processbody{ file name}
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

%\def\endenv{\expandafter\end\expandafter{\@currenvir}}
%%%%%%%%%%%%%%%%%% NOT WORKING %%%%%%%%%%%%%%%%%%%%%%%%%%%
%\if@onefile %not working
%\@onefilefalse
%%\AtBeginDocument {\begin{exandsol}}
%%\BeforeClearDocument{\end{exandsol}}
%
%%\AfterPreamble{\begin{exandsol}}
%
%
%%\AtEndDocument{\end{filecontents}} 
%
%%\AtBeginEnvironment{document} {\begin{exandsol}}
%\apptocmd{\indice}{\begin{exandsol}}{}{}
%%\BeforeEndEnvironment{document}{\end{exandsol}} 
%\appto{\@enddocumenthook}{\end{exandsol}}
%%\apptocmd{\indice}{\begin{filecontents}{excerpt1.tex}}{}{}
%%\AtEndDocument{\end{filecontents}} 
%%\patchcmd{ENDOFDOC}{END}{\end{filecontents}}{}{}
%%\AfterEndEnvironment{questions}{\end{filecontents}}
%
%%\patchcmd{\ENDDOC}{\ENDDOC}{\end{filecontents}}
%
%
%
%
%\fi
