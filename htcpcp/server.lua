--[[
    HTCPCP server module
--]]

local http_server = require("http.server")

local function default_onstream(server, stream)
    return
end

local function default_onerror()
    return
end

local function options_handler(options)
    local handled = {}
    handled.host = options.host
    handled.port = options.port
    handled.socket = options.socket
    handled.tls = options.tls
    handled.ctx = options.ctx
    handled.connection_setup_timeout = options.connection_setup_timeout
    handled.intra_stream_timeout = options.intra_stream_timeout
    handled.version = options.version
    handled.cq = options.cq
    handled.max_concurrent = options.max_concurrent
    handled.onerror = options.onerror or default_onerror
    handled.onstream = options.onstream or default_onstream
    return handled
end
local function new_instance(options)
    local server = http_server.new(options_handler(options))
    return server
end

return {
    new = new_instance
}
