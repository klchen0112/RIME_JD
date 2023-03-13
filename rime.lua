--[[
librime-lua 样例
```
  engine:
    translators:
      - lua_translator@lua_function3
      - lua_translator@lua_function4
    filters:
      - lua_filter@lua_function1
      - lua_filter@lua_function2
```
其中各 `lua_function` 为在本文件所定义变量名。
--]]

--[[
本文件的后面是若干个例子，按照由简单到复杂的顺序示例了 librime-lua 的用法。
每个例子都被组织在 `lua` 目录下的单独文件中，打开对应文件可看到实现和注解。

各例可使用 `require` 引入。
```
  foo = require("bar")
```
可认为是载入 `lua/bar.lua` 中的例子，并起名为 `foo`。
配方文件中的引用方法为：`...@foo`。
--]]


-- single_char_filter: 候选项重排序，使单字优先
-- 详见 `lua/single_char.lua`
-- single_char_filter = require("single_char")


---------------------
-- 键道·我流逻辑块 --
---------------------

-- 顶功处理器
topup_processor = require("for_topup")

-- 选择处理器
keydo_select_processor = require("keydo.processors.select")

-- 日期与时间转换器
keydo_date_time_translator = require("keydo.translators.date_time")

-- 数字转换器：将阿拉伯数字转换为对应汉字（由`=`引导）
number_translator = require("xnumber")

-- 候选过滤器
keydo_cand_filter = require("keydo.filters.cand")






-- easy_en_enhance_filter: 连续输入增强
-- 详见 `lua/easy_en.lua`
local easy_en = require("easy_en")
easy_en_enhance_filter = easy_en.enhance_filter

-- melt pinyin
local M= require("melt")
get_date = M.getdate
jpcharset_filter = M.jpcharsetfilter
long_word_filter = M.longwordfilter
autocap_filter =M.autocapfilter
oo_processor = M.ooprocessor
oo_filter =M.oofilter

