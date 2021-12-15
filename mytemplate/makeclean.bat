@echo off


rem �����ڹ���Ա����µ�·������
cd /d "%~dp0" 

title CQUThesis�Զ����������

set flag=%1
if %flag%x == x (
  set flag=clean
)
if %flag%x == cleanx (
  call:cleanaux
  goto :EOF
)
if %flag%x == pdfx (
  call:cleanpdf
  goto :EOF
)
if %flag%x == allx (
  call:cleanaux
  call:cleanpdf
  goto :EOF
)

:help
  echo �����÷���
  echo        makeclean [����]
  echo ������
  echo   help      չʾ��������Ϣ
  echo   clean     ��������.aux�ļ�
  echo   pdf  ��������.pdf�ļ�
  echo   all  ��������.aux�ļ��Լ�.pdf�ļ�
  echo *
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
