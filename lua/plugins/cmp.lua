-- Override blink.cmp keymap to match LunarVim's autocomplete behavior:
--   <Tab>     → navigate down, then snippets/AI, then fallback
--   <S-Tab>   → navigate up, then snippets, then fallback
--   <CR>      → accept (items are auto-selected, so 'accept' works cleanly)
--
-- Note: auto_brackets is disabled because its async bracket insertion
-- can fragment the undo history, making 'u' behave unexpectedly.
return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
      },
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
          "accept",
          "fallback",
        },
      },
    },
  },
}
