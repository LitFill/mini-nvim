local post_install = function(plugin)
    print "Building cornelis plugin..."
    local command = string.format("cd %s && stack install", plugin.path)
    local handle  = io.popen(command)
    if handle then
        -- local result = handle:read "*a"
        local _ = handle:read "*a"
        handle:close()
        print "Cornelis build finished."
        -- print(result)
    else
        print "Error: Failed to run build command for cornelis."
    end
end

return {
    source = "isovector/cornelis",
    name   = "cornelis",
    depends = {
        "kana/vim-textobj-user",
        "neovimhaskell/nvim-hs.vim"
    },

    -- Gunakan hooks.post_install untuk menjalankan perintah build setelah instalasi
    hooks = { post_install = post_install }
}
