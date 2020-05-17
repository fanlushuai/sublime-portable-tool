@echo OFF

title Sublime Text 便携版工具包

echo.

echo.               Sublime Text 便携版工具包 说  明 @loo2k @Auh

:read

echo -----------------------------------------------------------------------

echo   ！！！！！操作前阅读！！！！：

echo   1. 请将此脚本复制到 Sublime Text 的文件夹；

echo   2. 确保 Sublime Text 的可执行文件名为 sublime_text.exe；

echo   3. 请将需要绑定的扩展名保存到同目录 ext.txt 文件中；（每行一个扩展名）

echo   4. 请以管理员身份运行

echo -----------------------------------------------------------------------

Set /p y=已经阅读操作前提？（输入yes）：

If not "%y%" == "yes" Goto read

echo -----------------------------------------------------------------------

echo.

echo   操作序号：

echo   1: 添加 Sublime Text 到系统右键菜单;

echo   2: 卸载 Sublime Text 右键菜单;

echo   3: 注册扩展名; (扩展名列表请存放至同目录的 ext.txt 文件中)

echo   4: 卸载扩展名：

echo   5: 退出;

echo.

echo -----------------------------------------------------------------------

:begin

Set toolDir=%~dp0

Set /p u=输入操作序号并按 Enter 键：

If "%u%" == "1" Goto regMenu

If "%u%" == "2" Goto unregMenu

If "%u%" == "3" Goto sublimefile

If "%u%" == "4" Goto unsublimefile

If "%u%" == "5" exit

If "%u%" == ""  Goto begin


:regMenu

reg add "HKCR\*\shell\Sublime Text" /ve /d "Open With Sublime Text" /f

If ERRORLEVEL 1 ( 

    echo 注册失败 !!! 

    goto begin

)

reg add "HKCR\*\shell\Sublime Text\command" /ve /d "\"%toolDir%..\sublime_text.exe\" \"%%1\"" /f

If ERRORLEVEL 1 ( 

    echo 注册失败 !!! 

    goto begin

)

echo.

echo 已成功注册右键菜单

echo.

Goto begin



:unregMenu

reg delete "HKCR\*\shell\Sublime Text" /f

echo.

echo 已成功卸载右键菜单

echo.

Goto begin



:sublimefile

reg add "HKCR\sublimefile" /ve /d "文本文档" /f

If ERRORLEVEL 1 ( 

    echo  关联失败 !!! 

    goto begin

)

reg add "HKCR\sublimefile\DefaultIcon" /ve /d "%toolDir%..\sublime_text.exe" /f

reg add "HKCR\sublimefile\shell\open\command" /ve /d "\"%toolDir%..\sublime_text.exe\" \"%%1\"" /f

For /F "eol=;" %%e in (%toolDir%ext.txt) Do (

        (for /f "skip=2 tokens=1,2,* delims= " %%a in ('reg query "HKCR\.%%e" /ve') do (

            If not "%%c" == "sublimefile" (

                reg add "HKCR\.%%e" /v "sublime_backup" /d "%%c" /f

            )

        ))

        assoc .%%e=sublimefile

)

echo.

echo 已成功注册扩展名

echo.

Goto begin



:unsublimefile

reg delete "HKCR\sublimefile" /f

If ERRORLEVEL 1 ( 

    echo  解除关联失败 !!! 

    goto begin

)

For /F "eol=;" %%e in (%toolDir%ext.txt) Do (

        (for /f "skip=2 tokens=1,2,* delims= " %%a in ('reg query "HKCR\.%%e" /v "sublime_backup"') do (

            reg add "HKCR\.%%e" /ve /d "%%c" /f

            reg delete "HKCR\.%%e" /V "sublime_backup" /f

        ))

    )

echo.

echo 已成功卸载扩展名

echo.

Goto begin

