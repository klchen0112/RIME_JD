local function startswith(str, start)
    return string.sub(str, 1, string.len(start)) == start
end

local function hint(cand, context, reverse)
    if utf8.len(cand.text) < 2 then
        return false
    end

    local lookup = " " .. reverse:lookup(cand.text) .. " "
    local short = string.match(lookup, " ([bcdefghjklmnpqrstwxyz][auiov]+) ") or
                  string.match(lookup, " ([bcdefghjklmnpqrstwxyz][bcdefghjklmnpqrstwxyz]) ")
    local input = context.input
    if short and utf8.len(input) > utf8.len(short) and not startswith(short, input) then
        cand:get_genuine().comment = cand.comment .. "〔" .. short .. "〕"
        return true
    end

    return false
end

local function can_topup(input_text,env)
    for char in string.gmatch(env.s,'.') do
        if env.mem:dict_lookup(input_text .. char,true , 1) then
            return false
        end
    end
    return true
end

local function danzi(cand)
    if utf8.len(cand.text) < 2 then
        return true
    end
    return false
end

local function commit_hint(cand)
    cand:get_genuine().comment = '🚫' .. cand.comment
end

local function memoryCallback(memory, commit)
	for i,dictentry in ipairs(commit:get())
	do
		memory:update_userdict(dictentry,0,"") -- do nothing to userdict
		-- memory:update_userdict(dictentry,1,"") -- update entry to userdict
		-- memory:update_userdict(dictentry,1,"") -- delete entry to userdict
	end
	return true
end

local function filter(input, env)
    local is_danzi = env.engine.context:get_option('danzi_mode')
    local is_on = env.engine.context:get_option('sbb_hint')
    local topup_hint_on = env.engine.context:get_option('topup_hint')
    local first = true
    local input_text = env.engine.context.input
    local no_commit = topup_hint_on and  input_text:match("^[" .. env.s .. "]+$") and (not can_topup(input_text,env))
    for cand in input:iter() do
        if first and no_commit and cand.type ~= 'completion' then
            commit_hint(cand)
        end
        first = false
        if not is_danzi or danzi(cand) then
            if is_on then
            hint(cand, env.engine.context, env.reverse)
            end
            yield(cand)
        end
    end
end

local function init(env)
    env.mem = Memory(env.engine,env.engine.schema)
    env.mem:memorize(function(commit) memoryCallback(env.mem, commit) end)
    local config = env.engine.schema.config
    local dict_name = config:get_string("translator/dictionary")
    env.reverse = ReverseDb("build/" .. dict_name .. ".reverse.bin")

    env.b = config:get_string("topup/topup_with")
    env.s = config:get_string("topup/topup_this")
end

return { init = init, func = filter }
