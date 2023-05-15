-- Rime Lua 扩展 https://github.com/hchunhui/librime-lua
-- 文档 https://github.com/hchunhui/librime-lua/wiki/Scripting

-- 以词定字
select_character = require("select_character")
-- 日期时间
date_translator = require("date_translator")
-- Unicode
unicode = require("unicode")
-- 为用户词典中（输入过）的内容结尾加上一个星号
is_in_user_dict = require("is_in_user_dict")
-- v 模式 symbols 优先
v_filter = require("v_filter")
-- 降低部分英语单词在候选项的位置
reduce_english_filter = require("reduce_english_filter")
-- 长词优先
long_word_filter = require("long_word_filter")
-- 词条隐藏、降频
cold_word_drop_processor = require("cold_word_drop.processor")
cold_word_drop_filter = require("cold_word_drop.filter")
-- 九宫格
t9_preedit = require("t9_preedit")
-- 人民币大写
number_translator = require("number_translator")


------------------
-- Rime全局函数 --
------------------

-- `ReverseDb = (path: string) => void`
-- - 根据路径获取编译后的词库
-- - https://github.com/rime/librime/blob/master/src/rime/dict/reverse_lookup_dictionary.h#L41

-- `Candidate = (type: string, start: string, end: string, text: string, comment: string) => Candidate`
-- - 构建一个候选项
-- - https://github.com/rime/librime/blob/master/src/rime/candidate.h#L63

-- `yield = (cand: Candidate) => void`
-- - 生成一个候选项至候选区（每次只能生成一个候选项，但可以多次使用）

-- `processor = (key_event: KeyEvent, env) => void`
-- - 处理器 -> 响应按键并按照预设的规则依次进行编码处理
-- - https://github.com/rime/librime/blob/master/src/rime/processor.h

-- `translator = (input: string, seg: Segment, env) => void`
-- - 转换器 -> 将划分好的编码段转换为对应候选项
-- - https://github.com/rime/librime/blob/master/src/rime/translator.h

-- `filter = (cand_list: vector<of<Candidate>>, env) => void`
-- - 过滤器 -> 将转换好的候选项进行过滤（增删改查）
-- - https://github.com/rime/librime/blob/master/src/rime/filter.h


---------------------
-- Easy English --
---------------------
-- easy_en_enhance_filter: 连续输入增强
-- 详见 `lua/easy_en.lua`
local easy_en = require("easy_en")
easy_en_enhance_filter = easy_en.enhance_filter

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

date_time_translator = require("date_time")


-- single_char_filter: 候选项重排序，使单字优先
-- 详见 `lua/single_char.lua`
-- single_char_filter = require("single_char")


-- xkjd6_filter: 单字模式 & 630 即 ss 词组提示
--- 修改自 @懒散 TsFreddie https://github.com/TsFreddie/jdc_lambda/blob/master/rime/lua/xkjdc_sbb_hint.lua
-- 可由 schema 的 danzi_mode 与 wxw_hint 开关控制
-- 详见 `lua/xkjd6_filter.lua`
xkjd6_filter = require("xkjd6_filter")


-- number_translator: 将 `=` + 阿拉伯数字 翻译为大小写汉字
-- 详见 `lua/number.lua`
number_translator = require("xnumber")


