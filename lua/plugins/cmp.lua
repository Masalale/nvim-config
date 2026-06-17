-- Override blink.cmp keymap to match LunarVim's autocomplete behavior:
--   <Tab>     → navigate down, then snippets/AI, then fallback
--   <S-Tab>   → navigate up, then snippets, then fallback
--   <CR>      → select and accept (won't insert a newline while menu is visible)
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = {
          "select_next",
          LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          "fallback",
        },
        ["<CR>"] = {
          "select_and_accept",
          "fallback",
        },
      },
    },
  },
}
