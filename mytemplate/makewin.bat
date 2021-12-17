@echo off


rem �����ڹ���Ա����µ�·������
cd /d "%~dp0" 

title CQUThesis�Զ����������

set flag=%1
set file=%2
if %flag%x == x (
  set flag=thesis
)
if %file%x == x (
  set file=template.tex
)

if %flag%x == thesisx (
  call:thesis
  goto :EOF
)
if %flag%x == thesisxx (
  call:thesisx
  goto :EOF
)
if %flag%x == cleanx (
  call:cleanaux
  goto :EOF
)
if %flag%x == cleanpdfx (
  call:cleanpdf
  goto :EOF
)
if %flag%x == cleanallx (
  call:cleanaux
  call:cleanpdf
  goto :EOF
)

:help
  echo *************************************************************
  echo CQUThesis�Զ����������Windows��
  echo �����ѧ��ҵ���LaTeXģ�壺 https://github.com/nanmu42/CQUThesis
  echo (C) 2016-2017 ����� ����LPPL 1.3Э�鿪Դ
  echo ������������Դ��Github��Liam0205/sduthesis���ڴ���л��
  echo *************************************************************
  echo *
  echo �����÷���
  echo        makewin [����]
  echo ������
  echo   help      չʾ��������Ϣ
  echo   thesis    ͨ��latexmk���ܣ����ٵر������ģ�˫�����޲���ʱĬ�����У�
  echo   thesisx   ����һ�����������ı��루������ϵͳ��û��װlatexmk������һ������Ƽ�������ģ�
  echo   clean     ��������.aux�ļ�
  echo   cleanpdf  ��������.pdf�ļ�
  echo   cleanall  ��������.aux�ļ��Լ�.pdf�ļ�
  echo *
  echo ***********************Happy TeXing**************************
  echo ************************д����죡***************************
goto :EOF


:thesis
  echo ��ȷ������ϵͳ����ȷ����latexmk...
  echo ʹ��latexmk���ܱ���������...
  latexmk -xelatex %file%
  echo *                                       *
  echo *********̫���ˣ����ı�����ɣ�**********
  echo *                                       *
  goto pauseIfDoubleClicked

:thesisx
  echo ���ı�����......
  xelatex %file%
  bibtex %file%
  xelatex %file%
  xelatex %file%
  xelatex %file%
  echo *                                                    *
  echo ***************̫���ˣ����ı�����ɣ�*****************
  echo ��ʾ���������ٶȽ������Ƽ�ʹ��makewin thesis���б��롣
  echo *                                                    *
goto :EOF

:cleanaux
  echo ��������.aux�ļ���...
  for %%i in (*.fls *.fdb_latexmk *.xdv *.aux *.bbl *.equ *.glo *.gls *.hd *.idx *.ilg *.ind *.lof *.lot *.out *.blg *.log *.thm *.toc *.synctex.gz *.lofEN *.lotEN *.equEN) do (
    del %%i
  )
  del contents\*.aux
  echo .aux�ļ�������ɡ�
goto :EOF

:cleanpdf
  echo ��������.pdf�ļ���...
  for %%i in (*.pdf) do (
    del %%i
  )
  echo .pdf�ļ�������ɡ�
goto :EOF

:clean_all
  call:cleanaux
  call:cleanpdf
goto :EOF

:pauseIfDoubleClicked
  setlocal enabledelayedexpansion
  set testl=%cmdcmdline:"=%
  set testr=!testl:%~nx0=!
  if not "%testl%" == "%testr%" pause                           *
goto :EOF
