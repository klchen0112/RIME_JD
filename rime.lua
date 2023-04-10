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

