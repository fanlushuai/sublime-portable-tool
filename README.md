# sublime-portable-tool

本脚本用于sublime便携版本关联打开文件和添加右键菜单open with sublime

## 使用

> windows10 测试可用

1. cd到sublime_text.exe所在目录 
2. git clone https://github.com/fanlushuai/sublime-portable-tool.git
3. cd sublime-portable-tool目录内
4. 右键 sublimeRegister.bat ，以管理员运行
5. 按照交互提示操作



## 注意

此脚本通过修改注册表完成功能。脚本在执行添加操作时，如果发现注册表已有相关项，会进行备份。执行卸载后，能从备份再恢复过来。不必担心此脚本产生数据丢失的影响

## 参考

参考修改自 [Sublime-Text-Portable-Tool](https://github.com/loo2k/Sublime-Text-Portable-Tool)

参考仓库，文件换行符有问题，基本处于不可用的状态，本人也改的有点多。就不进行pull request了。感谢原作者的付出。
