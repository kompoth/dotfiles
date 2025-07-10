return {
    {
        "igorlfs/nvim-dap-view",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {},
        config = function() 
            local dap, dv = require("dap"), require("dap-view")
            dap.listeners.before.attach["dap-view-config"] = function()
                dv.open()
            end
            dap.listeners.before.launch["dap-view-config"] = function()
                dv.open()
            end
            dap.listeners.before.event_terminated["dap-view-config"] = function()
                dv.close()
            end
            dap.listeners.before.event_exited["dap-view-config"] = function()
                dv.close()
            end

            dv.setup({
                winbar = {
                    controls = { enabled = true }
                }
            })
        end
    },
}
