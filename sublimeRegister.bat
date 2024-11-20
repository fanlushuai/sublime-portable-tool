@echo OFF

title Sublime Text ��Я�湤�߰�

echo.

echo.               Sublime Text ��Я�湤�߰� ˵  �� @loo2k @Auh

:read

echo -----------------------------------------------------------------------

echo   ��������������ǰ�Ķ�����������

echo   1. ȷ��bat�ű���λ���ڡ�sublimeDir/xxx/this.bat (���ں�sublime_text.exe����Ŀ¼����Ŀ¼λ��)

echo   2. ȷ�� Sublime Text �Ŀ�ִ���ļ���Ϊ sublime_text.exe��

echo   3. �뽫��Ҫ�󶨵���չ�����浽ͬĿ¼ ext.txt �ļ��У���ÿ��һ����չ����

echo   4. ���Թ���Ա�������

echo -----------------------------------------------------------------------

Set /p y=�Ѿ��Ķ�����ǰ�᣿������yes����

If not "%y%" == "yes" Goto read

echo -----------------------------------------------------------------------

echo.

echo   ������ţ�

echo   1: ��� Sublime Text ��ϵͳ�Ҽ��˵�;

echo   2: ж�� Sublime Text �Ҽ��˵�;

echo   3: ע����չ��; (��չ���б�������ͬĿ¼�� ext.txt �ļ���)

echo   4: ж����չ����

echo   5: �˳�;

echo.

echo -----------------------------------------------------------------------

:begin

Set toolDir=%~dp0

Set /p u=���������Ų��� Enter ����

If "%u%" == "1" Goto regMenu

If "%u%" == "2" Goto unregMenu

If "%u%" == "3" Goto sublimefile

If "%u%" == "4" Goto unsublimefile

If "%u%" == "5" exit

If "%u%" == ""  Goto begin


:regMenu

reg add "HKCR\*\shell\Sublime Text" /ve /d "Open With Sublime Text" /f

If ERRORLEVEL 1 ( 

    echo ע��ʧ�� !!! 

    goto begin

)

reg add "HKCR\*\shell\Sublime Text\command" /ve /d "\"%toolDir%..\sublime_text.exe\" \"%%1\"" /f

If ERRORLEVEL 1 ( 

    echo ע��ʧ�� !!! 

    goto begin

)

echo.

echo �ѳɹ�ע���Ҽ��˵�

echo.

Goto begin



:unregMenu

reg delete "HKCR\*\shell\Sublime Text" /f

echo.

echo �ѳɹ�ж���Ҽ��˵�

echo.

Goto begin



:sublimefile

reg add "HKCR\sublimefile" /ve /d "�ı��ĵ�" /f

If ERRORLEVEL 1 ( 

    echo  ����ʧ�� !!! 

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

echo �ѳɹ�ע����չ��

echo.

Goto begin



:unsublimefile

reg delete "HKCR\sublimefile" /f

If ERRORLEVEL 1 ( 

    echo  �������ʧ�� !!! 

    goto begin

)

For /F "eol=;" %%e in (%toolDir%ext.txt) Do (

        (for /f "skip=2 tokens=1,2,* delims= " %%a in ('reg query "HKCR\.%%e" /v "sublime_backup"') do (

            reg add "HKCR\.%%e" /ve /d "%%c" /f

            reg delete "HKCR\.%%e" /V "sublime_backup" /f

        ))

    )

echo.

echo �ѳɹ�ж����չ��

echo.

Goto begin

