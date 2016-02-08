# Custom keybind
function fish_user_key_bindings
    fish_default_key_bindings
    fzf_key_bindings
    # bind \cr vf
    bind \cq fv
    bind \cg sourceMyFishConfig
end

