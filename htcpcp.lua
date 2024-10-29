--[[
    lua-htcpcp - A simple implementation of the HTCPCP protocol in Lua
    Author: Moncak

    HTCPCP - Hyper Text Coffee Pot Control Protocol
    Version 1.0
    RFC 2324
    https://tools.ietf.org/html/rfc2324
--]]

local htcpcp = {}

-- module version
htcpcp._VERSION = "1.0"

-- HTCPCP version
htcpcp._HTCPCP_VERSION = "HTCPCP/1.0"

-- status codes
htcpcp.status_codes = {
    200, -- OK
    404, -- Not Found
    406, -- Not Acceptable
    418, -- I'm a teapot
    500, -- Internal Server Error
}

-- status lines
htcpcp.status_lines = {
    [200] = "200 OK",
    [404] = "404 Not Found",
    [406] = "406 Not Acceptable",
    [418] = "418 I am a teapot",
    [500] = "500 Internal Server Error",
}

return htcpcp
