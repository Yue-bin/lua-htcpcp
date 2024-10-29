--[[
    URL parsing and manipulation functions.
--]]

local url = {}

--[[
coffee-scheme = ( "koffie"                      ; Afrikaans, Dutch
                  | "q%C3%A6hv%C3%A6"          ; Azerbaijani
                  | "%D9%82%D9%87%D9%88%D8%A9" ; Arabic
               | "akeita"                   ; Basque
               | "koffee"                   ; Bengali
               | "kahva"                    ; Bosnian
               | "kafe"                     ; Bulgarian, Czech
               | "caf%C3%E8"                ; Catalan, French, Galician
                  | "%E5%92%96%E5%95%A1"       ; Chinese
                  | "kava"                     ; Croatian
               | "k%C3%A1va                 ; Czech
               | "kaffe"                    ; Danish, Norwegian, Swedish
               | "coffee"                   ; English
               | "kafo"                     ; Esperanto
                  | "kohv"                     ; Estonian
               | "kahvi"                    ; Finnish
               | "%4Baffee"                 ; German
               | "%CE%BA%CE%B1%CF%86%CE%AD" ; Greek
               | "%E0%A4%95%E0%A5%8C%E0%A4%AB%E0%A5%80" ; Hindi
               | "%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC" ; Japanese
               | "%EC%BB%A4%ED%94%BC"       ; Korean
               | "%D0%BA%D0%BE%D1%84%D0%B5" ; Russian
               | "%E0%B8%81%E0%B8%B2%E0%B9%81%E0%B8%9F" ; Thai
               )
]]
local coffee_scheme = {
    ["Afrikaans"] = "koffie",
    ["Dutch"] = "koffie",
    ["Azerbaijani"] = "q%C3%A6hv%C3%A6",
    ["Arabic"] = "%D9%82%D9%87%D9%88%D8%A9",
    ["Basque"] = "akeita",
    ["Bengali"] = "koffee",
    ["Bosnian"] = "kahva",
    ["Bulgarian"] = "kafe",
    ["Czech"] = "kafe",
    ["Catalan"] = "caf%C3%E8",
    ["French"] = "caf%C3%E8",
    ["Galician"] = "caf%C3%E8",
    ["Chinese"] = "%E5%92%96%E5%95%A1",
    ["Croatian"] = "kava",
    ["Danish"] = "kaffe",
    ["Norwegian"] = "kaffe",
    ["Swedish"] = "kaffe",
    ["English"] = "coffee",
    ["Esperanto"] = "kafo",
    ["Estonian"] = "kohv",
    ["Finnish"] = "kahvi",
    ["German"] = "%4Baffee",
    ["Greek"] = "%CE%BA%CE%B1%CF%86%CE%AD",
    ["Hindi"] = "%E0%A4%95%E0%A5%8C%E0%A4%AB%E0%A5%80",
    ["Japanese"] = "%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC",
    ["Korean"] = "%EC%BB%A4%ED%94%BC",
    ["Russian"] = "%D0%BA%D0%BE%D1%84%D0%B5",
    ["Thai"] = "%E0%B8%81%E0%B8%B2%E0%B9%81%E0%B8%9F",
}

-- wheather the coffee scheme for a given language is valid
local function is_valid_lang(lang)
    return coffee_scheme[lang] ~= nil
end

-- wheather the given coffee scheme is valid
local function is_valid_scheme(scheme)
    for _, v in pairs(coffee_scheme) do
        if v == scheme then
            return true
        end
    end
    return false
end

-- get the coffee scheme for a given language, english by default
local function get_coffee_scheme(lang)
    lang = lang or "English"
    if is_valid_lang(lang) then
        return coffee_scheme[lang]
    end
    return coffee_scheme["English"]
end

--[[
coffee-url  =  coffee-scheme ":" [ "//" host ]
                ["/" pot-designator ] ["?" additions-list ]

pot-designator = "pot-" integer  ; for machines with multiple pots
    additions-list = #( addition )
]]

-- check if the given string is a valid pot-designator
local function is_valid_pd(pd_str)
    return pd_str:match("^pot%-%d+$") ~= nil
end

-- Parse a URL string into its components.
-- if the URL is not valid, return nil and a string for reason
-- yes the host is optional, im totally confused by this
function url.parse(coffee_url)
    if type(coffee_url) ~= "string" or not (coffee_url:match("^[^:/?]-:$") or coffee_url:match("^[^:/?]-://[^:/?]-/?[^:/?]-%??[^:/?]-$")) then
        return nil, "Invalid URL"
    end

    local parsed = {}
    local scheme, host, pot_designator, additions_list = nil, nil, nil, nil
    scheme = coffee_url:match("^([^:/?]-):")
    if not scheme or not is_valid_scheme(scheme) then
        return nil, "Invalid scheme"
    end
    parsed.scheme = scheme
    host = coffee_url:match("^[^:/?]-://([^:/?]+)/?")
    if host then
        parsed.host = host
    end
    pot_designator = coffee_url:match("^[^:/?]-://[^:/?]-/([^:/?]+)")
    if pot_designator then
        if is_valid_pd(pot_designator) then
            parsed.pot_designator = pot_designator
        else
            return nil, "Invalid pot designator"
        end
    end
    additions_list = coffee_url:match("^.-%?(.+)")
    if additions_list then
        parsed.additions_list = additions_list
    end
    return parsed
end

-- Build a URL string from its components.
-- lang is default to English
function url.build(host, pot_designator, additions_list, lang)
    local scheme = get_coffee_scheme(lang)
    local coffee_url = scheme .. ":"
    if host then
        coffee_url = coffee_url .. "//" .. host
    end
    if pot_designator then
        coffee_url = coffee_url .. "/" .. pot_designator
    end
    if additions_list then
        coffee_url = coffee_url .. "?" .. additions_list
    end
    return coffee_url
end

return url
