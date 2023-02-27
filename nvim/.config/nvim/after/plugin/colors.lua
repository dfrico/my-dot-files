function ColorMyPencils(color) -- unused
    color = color or "catppuccin-mocha"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", {
        bg = "none"
    })
    vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "none"
    })
end

-- ColorMyPencils()
-- Check lua/plugins/config/theme.lua for colortheme install/setup
