# linux命令行使用基础

## 实验环境

- ubuntu-18.04.1-server-amd64.iso
- 双网卡
  - NAT
  - Host-Only

安装asciinema

```bash
#在命令行执行此代码下载asciinema
sudo apt-get install asciinema

##在asciinema的官网注册一个账号
#账号注册后会给你一个关联的链接，直接使用命令行输入此链接，关联成功
asciinema auth

##录制视频
asciinema rec 文件路径以及文件名（xxx.cast）

##录制终止
exit
CTRL+D

##将视频上传至你的账号
asciinema upload 文件路径以及文件名（xxx.cast）
```

##  实验步骤

##### vimtutor录像

###### Lesson 1

[![asciicast](https://asciinema.org/a/234395.svg)](https://asciinema.org/a/234395)

###### Lesson 2

[![asciicast](https://asciinema.org/a/234449.svg)](https://asciinema.org/a/234449)

###### Lesson 3

[![asciicast](https://asciinema.org/a/234456.svg)](https://asciinema.org/a/234456)

###### Lesson 4

[![asciicast](https://asciinema.org/a/234506.svg)](https://asciinema.org/a/234506)

###### Lesson 5

[![asciicast](https://asciinema.org/a/235249.svg)](https://asciinema.org/a/235249)

###### Lesson 6

[![asciicast](https://asciinema.org/a/235255.svg)](https://asciinema.org/a/235255)

###### Lesson 7

[![asciicast](https://asciinema.org/a/235258.svg)](https://asciinema.org/a/235258)

## 课后问题

1.你了解vim有哪几种工作模式？

- nomal
- Insert
- Visual

2.Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？

- 向下移动10行：10j
- 移动到文件开始：gg
- 移动到结束行：G
- 快速跳转到文件第N行：NG

3.Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

- 删除单个字符：x

- 删除单个单词：dw
- 从光标位置删除到行尾：d$
- 删除单行：dd
- 当前行开始向下数N行：Ndd

4.如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

- 插入N个空行：NO
- 插入80个-：80i- ESC

5.如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？

- 撤销最近一次编辑：u
- 重做最近一次编辑：Ctrl+R

6.vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？

- 剪切粘贴单个字符：xp
- 单个单词：dwp
- 单行ddp
- 相似的复制粘贴：
  - 移动到要复制粘贴的开头
  - 按v进入visual模式
  - 移动光标选择你要复制粘贴的所有内容
  - 按y复制
  - 按p进行粘贴

7.为了编辑一段文本你能想到哪几种操作方式（按键序列）？

- vim  文件名字
- 按i进行编辑
- 按A进行编辑
- 按a进行编辑

8.查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？

- 查看当前正在编辑的文件名：Ctrl+G
- 查看当前光标所在行的行号：Ctrl+G

9.在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？

- 文件中进行关键词搜索：-

  - /关键字<ENTRY>

  - ?关键字<ENTRY>

- 设置忽略大小写:   :set ic

- 进行高亮显示：set hls is

- 对匹配到的关键词进行批量替换::%s/old/new/g

10.在文件中最近编辑过的位置来回快速跳转的方法？

- ``
- `.

11.如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }

- %

12.在不退出vim的情况下执行一个外部程序的方法？

- :!ls
- :!dir
- w TEST
- !rm TEST

13.如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？

- 使用vim的内置帮助系统来查询一个内置默认快捷键: :help +快捷键
- 两个不同的分屏窗口中移动光标：Ctrl+W

