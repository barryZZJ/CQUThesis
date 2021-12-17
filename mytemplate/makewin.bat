@echo off


rem 避免在管理员身份下的路径问题
cd /d "%~dp0" 

title CQUThesis自动化编译程序

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
  echo CQUThesis自动化编译程序（Windows）
  echo 重庆大学毕业设计LaTeX模板： https://github.com/nanmu42/CQUThesis
  echo (C) 2016-2017 李振楠 依据LPPL 1.3协议开源
  echo 本程序的灵感来源：Github：Liam0205/sduthesis，在此致谢。
  echo *************************************************************
  echo *
  echo 命令用法：
  echo        makewin [参数]
  echo 参数：
  echo   help      展示本帮助信息
  echo   thesis    通过latexmk智能，快速地编译论文（双击或无参数时默认运行）
  echo   thesisx   进行一次完整的论文编译（如果你的系统上没安装latexmk就用这一项，否则推荐用上面的）
  echo   clean     清理所有.aux文件
  echo   cleanpdf  清理所有.pdf文件
  echo   cleanall  清理所有.aux文件以及.pdf文件
  echo *
  echo ***********************Happy TeXing**************************
  echo ************************写作愉快！***************************
goto :EOF


:thesis
  echo 请确认您的系统已正确配置latexmk...
  echo 使用latexmk智能编译论文中...
  latexmk -xelatex %file%
  echo *                                       *
  echo *********太棒了！论文编译完成！**********
  echo *                                       *
  goto pauseIfDoubleClicked

:thesisx
  echo 论文编译中......
  xelatex %file%
  bibtex %file%
  xelatex %file%
  xelatex %file%
  xelatex %file%
  echo *                                                    *
  echo ***************太棒了！论文编译完成！*****************
  echo 提示：本方案速度较慢，推荐使用makewin thesis进行编译。
  echo *                                                    *
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
