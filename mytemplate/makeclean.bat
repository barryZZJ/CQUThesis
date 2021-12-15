@echo off


rem 避免在管理员身份下的路径问题
cd /d "%~dp0" 

title CQUThesis自动化清理程序

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
  echo 命令用法：
  echo        makeclean [参数]
  echo 参数：
  echo   help      展示本帮助信息
  echo   clean     清理所有.aux文件
  echo   pdf  清理所有.pdf文件
  echo   all  清理所有.aux文件以及.pdf文件
  echo *
goto :EOF

:cleanaux
  echo 清理所有.aux文件中...
  for %%i in (*.fls *.fdb_latexmk *.xdv *.aux *.bbl *.equ *.glo *.gls *.hd *.idx *.ilg *.ind *.lof *.lot *.out *.blg *.log *.thm *.toc *.synctex.gz *.lofEN *.lotEN *.equEN) do (
    del %%i
  )
  del contents\*.aux
  echo .aux文件清理完成。
goto :EOF

:cleanpdf
  echo 清理所有.pdf文件中...
  for %%i in (*.pdf) do (
    del %%i
  )
  echo .pdf文件清理完成。
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
