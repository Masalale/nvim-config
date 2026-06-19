-- monokai: the classic VS Code Monokai palette, built as a real colorscheme.
--
-- It loads Neovim's built-in unokai (a faithful Monokai port) as the base, then
-- repaints every group that failed WCAG contrast against the #282923 background
-- and styles all floats/popups to match — keeping the Monokai character while
-- staying legible. Because it lives in colors/, it shows up in the colorscheme
-- picker (<leader>uC), is previewable/selectable, and re-sources on every
-- colorscheme switch, so no ColorScheme autocmd is needed.
--
-- ── Problems fixed ──────────────────────────────────────────────────
--   Comment / @markup.raw        #74705d   2.95:1  →  #9e9278  5.0:1  AA
--   Statement/PreProc/keywords   #f92672   3.96:1  →  #ff5c8a  4.9:1  AA
--   LineNr / NonText / Conceal   #8a8a8a   4.25:1  →  #9e9e9e  5.8:1  AA
--   VertSplit                    fg=bg     (invis) →  #949494  4.9:1  AA
--   DiffDelete                   #af5f5f   3.23:1  →  #cc8888  5.3:1  AA
--   DiffChange                   #5f87af   3.89:1  →  #70a0c4  5.2:1  AA
--   PmenuSel                     fg=NONE   (invis) →  #f8f8f2 13.8:1  fn
--   Pmenu sel-fg on sel-bg       mixed     1.6-1.9 →  explicit fg
--   StatusLineNC / TabLine       #282923/#74705d  3.0:1  →  #f8f8f2/#555550  8.7:1
--   DiagnosticError              #ff0000   3.67:1  →  #ff5f5f  5.4:1  AA
--   @comment.error               #ff0000   3.67:1  →  #ff5f5f  5.4:1  AA

-- Load the base scheme (this does its own `hi clear` / `syntax reset`).
vim.cmd.colorscheme("unokai")

-- ── Semantic palette (all ≥4.5:1 against #282923) ─────────────────────
local C = {
  -- text / syntax
  normal       = "#f8f8f2",    -- 13.76:1 AAA  (keep)
  comment      = "#9e9278",    --  5.0:1  AA   ↑ was #74705d
  pink         = "#ff5c8a",    --  4.9:1  AA   ↑ was #f92672
  orange       = "#fd971f",    --  6.7:1  AA   (keep)
  yellow       = "#e6db74",    -- 10.3:1  AAA  (keep)
  green        = "#a6e22e",    --  9.5:1  AAA  (keep)
  cyan         = "#66d9ef",    --  8.9:1  AAA  classic VS Code Monokai cyan
  purple       = "#ae81ff",    --  5.2:1  AA   (keep)
  teal         = "#80beb5",    --  6.9:1  AA   (keep)
  light_teal   = "#a1efe4",    -- 11.2:1  AAA  (keep)
  line_nr      = "#9e9e9e",    --  5.8:1  AA   ↑ was #8a8a8a
  vert_split   = "#949494",    --  4.9:1  AA   (was invisible)
  non_text     = "#9e9e9e",    --  5.8:1  AA
  folded_fg    = "#c8c8c8",    --  8.6:1  AAA  ↑
  folded_bg    = "#414141",    -- (keep)
  cursor_line  = "#3a392f",    -- (keep)
  color_col    = "#585858",    -- (keep)

  -- status / tabline
  stl_bg       = "#bababa",    -- (keep)
  stl_fg       = "#282923",    -- (keep)
  stlnc_bg     = "#555550",    -- ↑ was #74705d
  stlnc_fg     = "#f8f8f2",    -- ↑ was #282923

  -- popup menu
  pmenu_thmb   = "#74705d",    -- scrollbar thumb (keep)

  -- diff
  diff_add     = "#5faf5f",    --  5.4:1  AA   (keep)
  diff_change  = "#70a0c4",    --  5.2:1  AA   ↑ was #5f87af
  diff_delete  = "#cc8888",    --  5.3:1  AA   ↑ was #af5f5f
  diff_text    = "#c7a5c7",    --  5.5:1  AA   ↑ was #af87af

  -- diagnostics
  diag_error   = "#ff5f5f",    --  5.4:1  AA   ↑ was #ff0000
  diag_warn    = "#ffa500",    --  7.4:1  AAA  (keep)
  diag_info    = "#add8e6",    --  9.6:1  AAA  (keep)
  diag_hint    = "#d3d3d3",    --  9.8:1  AAA  (keep)
}

local hl = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

local bg = "#282923"
local sel = "#49483e"    -- VS Code Monokai selectionBackground (popup selection)
local border = "#75715e" -- classic Monokai UI grey (popup borders & separators)

-- ── Apply all overrides ────────────────────────────────────────────────
-- Core syntax
hl("Normal",        { fg = C.normal, bg = bg })
hl("Comment",       { fg = C.comment })
hl("Statement",     { fg = C.pink, bold = true })
hl("PreProc",       { fg = C.pink })
hl("WarningMsg",    { fg = C.pink })
hl("Error",         { fg = C.pink, bg = "#000000" })
hl("ErrorMsg",      { fg = C.pink, bg = "#000000" })
hl("debugBreakpoint", { fg = bg, bg = C.pink })

hl("LineNr",        { fg = C.line_nr })
hl("LineNrAbove",   { fg = C.line_nr })
hl("LineNrBelow",   { fg = C.line_nr })
hl("CursorLineNr",  { fg = "#dadada", bold = true })
hl("NonText",       { fg = C.non_text })
hl("EndOfBuffer",   { fg = C.non_text })
hl("SpecialKey",    { fg = C.non_text })
hl("Conceal",       { fg = C.non_text })

-- UI chrome
hl("VertSplit",     { fg = C.vert_split, bg = bg })
hl("SignColumn",    { fg = C.normal, bg = bg })
hl("CursorColumn",  { bg = C.cursor_line })
hl("CursorLine",    { bg = C.cursor_line })
hl("ColorColumn",   { bg = C.color_col })
hl("Folded",        { fg = C.folded_fg, bg = C.folded_bg })
hl("FoldColumn",    { fg = C.non_text })
hl("MatchParen",    { fg = C.orange, bold = true })

-- Status / Tab line
hl("StatusLine",    { fg = C.stl_fg, bg = C.stl_bg })
hl("StatusLineNC",  { fg = C.stlnc_fg, bg = C.stlnc_bg })
hl("TabLine",       { fg = C.stlnc_fg, bg = C.stlnc_bg })
hl("TabLineFill",   { fg = C.stlnc_fg, bg = C.stlnc_bg })
hl("TabLineSel",    { fg = C.stl_fg, bg = C.stl_bg, bold = true })

-- Popup / completion menu — dark like the editor with a warm VS Code Monokai
-- selection (#49483e). The rounded, themed border (below) gives it a crisp edge
-- on the dark background.
hl("Pmenu",         { fg = C.normal, bg = bg })
hl("PmenuSel",      { fg = C.normal, bg = sel, bold = true })
hl("PmenuExtra",    { fg = "#d4d4d4", bg = bg })
hl("PmenuExtraSel", { fg = "#d4d4d4", bg = sel })
hl("PmenuKind",     { fg = C.teal, bg = bg })
hl("PmenuKindSel",  { fg = C.teal, bg = sel })
hl("PmenuMatch",    { fg = "#ffaf5f", bg = bg })
hl("PmenuMatchSel", { fg = "#ffaf5f", bg = sel })
hl("PmenuThumb",    { bg = C.pmenu_thmb })
hl("PmenuSbar",     {})

-- Floating windows / popups. unokai leaves NormalFloat/FloatBorder unset, so
-- they fell back to Neovim defaults. Paint them dark like the editor (VS Code
-- style) with a crisp Monokai-grey rounded border (vim.o.winborder in
-- options.lua). Every popup — LSP hover & signature, diagnostics, blink
-- completion docs, snacks pickers & notifications, which-key, lazy/mason —
-- links to these groups, so they all match.
hl("NormalFloat",   { fg = C.normal, bg = bg })
hl("FloatBorder",   { fg = border, bg = bg })
hl("FloatTitle",    { fg = C.green, bg = bg, bold = true })
hl("FloatFooter",   { fg = C.comment, bg = bg })
-- Modern split separator (VertSplit is the legacy alias; set both).
hl("WinSeparator",  { fg = border, bg = bg })

-- blink.cmp links its menu/doc borders to Pmenu/NormalFloat (no visible line);
-- give them the themed border so the completion popups are delineated too.
hl("BlinkCmpMenuBorder",          { fg = border, bg = bg })
hl("BlinkCmpDocBorder",           { fg = border, bg = bg })
hl("BlinkCmpSignatureHelpBorder", { fg = border, bg = bg })

-- Diff
hl("DiffAdd",       { fg = C.diff_add, reverse = true })
hl("DiffChange",    { fg = C.diff_change, reverse = true })
hl("DiffDelete",    { fg = C.diff_delete, reverse = true })
hl("DiffText",      { fg = C.diff_text, reverse = true })

-- Search / Visual
hl("Search",        { fg = bg, bg = C.cyan })
hl("CurSearch",     { fg = bg, bg = "#ffaf5f" })
hl("IncSearch",     { fg = bg, bg = "#ffaf5f" })
hl("Visual",        { fg = C.light_teal, bg = bg, reverse = true })
hl("VisualNOS",     { fg = bg, bg = C.teal })

-- Treesitter semantic highlights
hl("@comment",              { fg = C.comment })
hl("@comment.error",        { fg = C.diag_error })
hl("@comment.warning",      { fg = C.diag_warn })
hl("@comment.todo",         { fg = "#dadada" })
hl("@markup.raw",           { fg = C.comment })

hl("@keyword",              { fg = C.pink })
hl("@keyword.function",     { fg = C.pink })
hl("@keyword.return",       { fg = C.pink })
hl("@attribute",            { fg = C.pink })
hl("@operator",             { fg = C.pink })
hl("@function.macro",       { fg = C.pink })

hl("@constant",             { fg = C.purple })
hl("@constant.builtin",     { fg = C.teal })
hl("@variable",             { fg = C.cyan })
hl("@variable.builtin",     { fg = C.teal })
hl("@property",             { fg = C.cyan })
hl("@function",             { fg = C.green })
hl("@type",                 { fg = C.orange })
hl("@type.builtin",         { fg = C.teal })
hl("@type.definition",      { fg = C.orange })

hl("@markup.heading",       { fg = C.normal, bold = true })
hl("@markup.heading.1",     { fg = C.pink, bold = true })
hl("@markup.heading.2",     { fg = C.yellow, bold = true })
hl("@markup.heading.3",     { fg = C.orange, bold = true })
hl("@markup.heading.4",     { fg = C.cyan, bold = true })
hl("@markup.heading.5",     { fg = "#51aebe", bold = true })
hl("@markup.heading.6",     { fg = C.green, bold = true })

hl("@markup.link",          { fg = C.cyan })
hl("@markup.link.label",    { fg = C.cyan })
hl("@markup.link.url",      { fg = C.cyan, underline = true })
hl("@markup.list",          { fg = C.teal })
hl("@markup.list.checked",  { fg = C.teal })
hl("@markup.list.unchecked", { fg = C.teal })
hl("@markup.quote",         { fg = C.teal })
hl("@markup.math",          { fg = C.teal })
hl("@markup.bold",          { fg = C.teal })
hl("@markup.underline",     { fg = C.cyan, underline = true })

-- Diagnostics
hl("DiagnosticError",       { fg = C.diag_error })
hl("DiagnosticWarn",        { fg = C.diag_warn })
hl("DiagnosticInfo",        { fg = C.diag_info })
hl("DiagnosticHint",        { fg = C.diag_hint })

-- LSP
hl("LspReferenceText",      { fg = C.light_teal, bg = bg, reverse = true })
hl("LspReferenceRead",      { fg = C.light_teal, bg = bg, reverse = true })
hl("LspReferenceWrite",     { fg = C.light_teal, bg = bg, reverse = true })
hl("LspSignatureActiveParameter", { fg = C.orange, bold = true })

-- LSP semantic tokens
hl("@lsp.type.keyword",     { fg = C.pink })
hl("@lsp.type.type",        { fg = C.orange })
hl("@lsp.type.class",       { fg = C.orange })
hl("@lsp.type.enum",        { fg = C.orange })
hl("@lsp.type.interface",   { fg = C.orange })
hl("@lsp.type.namespace",   { fg = C.teal })
hl("@lsp.type.parameter",   { fg = C.teal })
hl("@lsp.type.variable",    { fg = C.cyan })
hl("@lsp.type.property",    { fg = C.cyan })
hl("@lsp.type.function",    { fg = C.green })
hl("@lsp.type.method",      { fg = C.green })
hl("@lsp.type.string",      { fg = C.yellow })
hl("@lsp.type.number",      { fg = C.purple })
hl("@lsp.type.boolean",     { fg = C.purple })

-- OmniSharp tags C# punctuation with a semantic token (@lsp.type.punctuation,
-- priority 125) that outranks treesitter and inherits @lsp's stark blue
-- default — turning every delimiter ( . ; , () {} ) blue. Defer to the normal
-- punctuation highlight so C# matches every other language.
hl("@lsp.type.punctuation",    { link = "@punctuation.delimiter" })
hl("@lsp.type.punctuation.cs", { link = "@punctuation.delimiter" })

-- Git signs
hl("GitSignsAdd",           { fg = C.diff_add })
hl("GitSignsChange",        { fg = C.diff_change })
hl("GitSignsDelete",        { fg = C.diff_delete })

-- Render-markdown (reinforce the render-markdown.nvim config fix)
local rp = "RenderMarkdown"
hl(rp .. "H1",  { fg = C.pink,   bold = true })
hl(rp .. "H2",  { fg = C.yellow, bold = true })
hl(rp .. "H3",  { fg = C.orange, bold = true })
hl(rp .. "H4",  { fg = C.cyan,   bold = true })
hl(rp .. "H5",  { fg = "#51aebe", bold = true })
hl(rp .. "H6",  { fg = C.green,  bold = true })
hl(rp .. "HtmlComment",       { fg = C.comment })
hl(rp .. "Todo",              { fg = C.comment })
hl(rp .. "CodeInline",        { fg = C.normal, bg = C.color_col })
hl(rp .. "InlineHighlight",   { link = rp .. "CodeInline" })
hl(rp .. "CodeBorder",        { fg = C.line_nr, bg = C.color_col })

-- Claim the name last, after the base scheme set it to "unokai".
vim.g.colors_name = "monokai"
