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



---------------------
-- Easy English --
---------------------
-- easy_en_enhance_filter: 连续输入增强
-- 详见 `lua/easy_en.lua`
local easy_en = require("easy_en")
easy_en_enhance_filter = easy_en.enhance_filter



-- xkjd6_filter: 单字模式 & 630 即 ss 词组提示
--- 修改自 @懒散 TsFreddie https://github.com/TsFreddie/jdc_lambda/blob/master/rime/lua/xkjdc_sbb_hint.lua
-- 可由 schema 的 danzi_mode 与 wxw_hint 开关控制
-- 详见 `lua/xkjd6_filter.lua`
xkjd6_filter = require("xkjd6_filter")



