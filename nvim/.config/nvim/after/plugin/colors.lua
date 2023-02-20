function ColorMyPencils(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", {
        bg = "none"
    })
    vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "none"
    })
end

ColorMyPencils()
-- TODO: add gruvbox or onedark
-- let g:gruvbox_contrast_dark = "hard"
-- hi Normal ctermbg=None
