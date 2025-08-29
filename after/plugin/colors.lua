function ColorMyPencils(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    color = color or "vscode"
    vim.cmd.colorscheme(color)
end

ColorMyPencils()
