--[[
    status of the HTCPCP
]]

local status = {}

-- status codes
status.status_codes = {
    200, -- OK
    404, -- Not Found
    406, -- Not Acceptable
    418, -- I'm a teapot
    500, -- Internal Server Error
}

-- status lines
status.status_lines = {
    [200] = "200 OK",
    [404] = "404 Not Found",
    [406] = "406 Not Acceptable",
    [418] = "418 I am a teapot",
    [500] = "500 Internal Server Error",
}

return status
