---@class Athens
---@field config AthensConfig
---@field palette AthensPalette
local Athens = {}

---@class ItalicConfig
---@field strings boolean
---@field comments boolean
---@field operators boolean
---@field folds boolean
---@field emphasis boolean

---@class HighlightDefinition
---@field fg string?
---@field bg string?
---@field sp string?
---@field blend integer?
---@field bold boolean?
---@field standout boolean?
---@field underline boolean?
---@field undercurl boolean?
---@field underdouble boolean?
---@field underdotted boolean?
---@field strikethrough boolean?
---@field italic boolean?
---@field reverse boolean?
---@field nocombine boolean?

---@class AthensConfig
---@field terminal_colors boolean?
---@field undercurl boolean?
---@field underline boolean?
---@field bold boolean?
---@field italic ItalicConfig?
---@field strikethrough boolean?
---@field invert_selection boolean?
---@field invert_signs boolean?
---@field invert_tabline boolean?
---@field invert_intend_guides boolean?
---@field inverse boolean?
---@field overrides table<string, HighlightDefinition>?
---@field palette_overrides table<string, string>?
Athens.config = {
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
}

-- main athens color palette
---@class AthensPalette
Athens.palette = {
      bg0 = "#090909", --[[manually darkened]]
      bg1 = "#1c1b19",
      bg2 = "#242320",
      bg3 = "#2c2b28",
      bg4 = "#353430",
      fg1 = "#958f88",
      fg2 = "#7b766f",
      fg3 = "#615d58",
      fg4 = "#494642",
      cursor = "#4f643c",
      modeline = "#272f30",
      active1 = "#303d3e",
      active2 = "#2c3637",
      inactive1 = "#232829",
      inactive2 = "#1e2122",
      clock12 = "#a28e59",
      clock01 = "#899659",
      clock02 = "#5a9f58",
      clock03 = "#5c9c84",
      clock04 = "#5e9a97",
      clock05 = "#6098a8",
      clock06 = "#6592ca",
      clock07 = "#9c82d3",
      clock08 = "#d067d2",
      clock09 = "#d86aa7",
      clock10 = "#dc6e79",
      clock11 = "#bf8259",
      bright_clock12 = "#ab8d00",
      bright_clock01 = "#849900",
      bright_clock02 = "#13a700",
      bright_clock03 = "#00a37c",
      bright_clock04 = "#00a09b",
      bright_clock05 = "#009db8",
      bright_clock06 = "#0095ef",
      bright_clock07 = "#a773ff",
      bright_clock08 = "#fb00fd",
      bright_clock09 = "#fe3ab6",
      bright_clock10 = "#fe4e68",
      bright_clock11 = "#d37900",
      dark_clock02 = "#0b7c00", --[[hsl=127, 100, 45]]
      dark_clock05 = "#007589", --[[hsl=217, 100, 45]]
      dark_clock10 = "#d5003b", --[[hsl= 71, 100, 45]]
      hi1 = "#b0b037",
      hi2 = "#3bbdac",
      err = "#c8575c",  --[[was error]]
      warning = "#817c55",
      success = "#00b953",
      var = "#958f88",
      func = "#b65a52",
      builtin = "#729599",
      keyword = "#729599",
      const = "#729599",
      comment = "#536e6f",
      str = "#6e9976",
      ltype = "#a28c6d", --[[ was type ]]
      preprocessor = "#5d9a91",
}

-- get a hex list of athens colors based on current bg and constrast config
local function get_colors()
  local p = Athens.palette
  local config = Athens.config

  for color, hex in pairs(config.palette_overrides) do
    p[color] = hex
  end

  local bg = vim.o.background

  local color_groups = {
    dark = {
      bg0 = p.bg0,
      bg1 = p.bg1,
      bg2 = p.bg2,
      bg3 = p.bg3,
      bg4 = p.bg4,
      fg0 = p.fg1,
      fg1 = p.fg1,
      fg2 = p.fg2,
      fg3 = p.fg3,
      fg4 = p.fg4,

      fake = "#ff00ff",

      cursor = p.cursor,
      modeline = p.modeline,
      active1 = p.active1,
      active2 = p.active2,
      inactive1 = p.inactive1,
      inactive2 = p.inactive2,
      hi1 = p.hi1,
      hi2 = p.hi2,
      err = p.err,
      warning = p.warning,
      success = p.success,
      var = p.var,
      func = p.func,
      builtin = p.builtin,
      keyword = p.keyword,
      const = p.const,
      comment = p.comment,
      str = p.str,
      ltype = p.ltype,
      preprocessor = p.preprocessor,

      red = p.bright_clock10,
      green = p.bright_clock02,
      yellow = p.bright_clock12,
      blue = p.bright_clock06,
      purple = p.bright_clock07,
      aqua = p.bright_clock05,
      orange = p.bright_clock11,
      neutral_red = p.clock10,
      neutral_green = p.clock02,
      neutral_yellow = p.clock12,
      neutral_blue = p.clock06,
      neutral_purple = p.clock07,
      neutral_aqua = p.clock05,
      neutral_orange = p.clock11,
      dark_red = p.dark_clock10,
      dark_green = p.dark_clock02,
      dark_aqua = p.dark_clock05,
      gray = p.fg1,
    },
    light = {
      bg0 = p.bg0,
      bg1 = p.bg1,
      bg2 = p.bg2,
      bg3 = p.bg3,
      bg4 = p.bg4,
      fg0 = p.fg1,
      fg1 = p.fg1,
      fg2 = p.fg2,
      fg3 = p.fg3,
      fg4 = p.fg4,

      fake = "#ff00ff",

      cursor = p.cursor,
      modeline = p.modeline,
      active1 = p.active1,
      active2 = p.active2,
      inactive1 = p.inactive1,
      inactive2 = p.inactive2,
      hi1 = p.hi1,
      hi2 = p.hi2,
      err = p.err,
      warning = p.warning,
      success = p.success,
      var = p.var,
      func = p.func,
      builtin = p.builtin,
      keyword = p.keyword,
      const = p.const,
      comment = p.comment,
      str = p.str,
      ltype = p.ltype,
      preprocessor = p.preprocessor,

      red = p.bright_clock10,
      green = p.bright_clock02,
      yellow = p.bright_clock12,
      blue = p.bright_clock06,
      purple = p.bright_clock07,
      aqua = p.bright_clock05,
      orange = p.bright_clock11,
      neutral_red = p.clock10,
      neutral_green = p.clock02,
      neutral_yellow = p.clock12,
      neutral_blue = p.clock06,
      neutral_purple = p.clock07,
      neutral_aqua = p.clock05,
      neutral_orange = p.clock11,
      dark_red = p.dark_clock10,
      dark_green = p.dark_clock02,
      dark_aqua = p.dark_clock05,
      gray = p.fg1,
    },
  }

  return color_groups[bg]
end

local function get_groups()
  local colors = get_colors()
  local config = Athens.config

  if config.terminal_colors then
    local term_colors = {
      colors.bg0,
      colors.neutral_red,
      colors.neutral_green,
      colors.neutral_yellow,
      colors.neutral_blue,
      colors.neutral_purple,
      colors.neutral_aqua,
      colors.fg4,
      colors.gray,
      colors.red,
      colors.green,
      colors.yellow,
      colors.blue,
      colors.purple,
      colors.aqua,
      colors.fg1,
    }
    for index, value in ipairs(term_colors) do
      vim.g["terminal_color_" .. index - 1] = value
    end
  end

  local groups = {
    AthensCursor = { fg = colors.cursor },
    AthensConstant = { fg = colors.const },
    AthensError = { fg = colors.err },
    AthensFunction = { fg = colors.func },
    AthensKeyword = { fg = colors.keyword },
    AthensPreProcessor = { fg = colors.preprocessor },
    AthensText = { fg = colors.fg1 },
    AthensType = { fg = colors.ltype },
    AthensVar = { fg = colors.var },
    AthensFg0 = { fg = colors.fg0 }, --[[fix]]
    AthensFg1 = { fg = colors.fg1 },
    AthensFg2 = { fg = colors.fg2 },
    AthensFg3 = { fg = colors.fg3 },
    AthensFg4 = { fg = colors.fg4 },
    AthensGray = { fg = colors.gray }, --[[fix]]
    AthensBg0 = { fg = colors.bg0 },
    AthensBg1 = { fg = colors.bg1 },
    AthensBg2 = { fg = colors.bg2 },
    AthensBg3 = { fg = colors.bg3 },
    AthensBg4 = { fg = colors.bg4 },
    AthensRed = { fg = colors.red }, --[[fix]]
    AthensRedBold = { fg = colors.red, bold = config.bold }, --[[fix]]
    AthensGreen = { fg = colors.green }, --[[fix]]
    AthensGreenBold = { fg = colors.green, bold = config.bold }, --[[fix]]
    AthensYellow = { fg = colors.yellow }, --[[fix]]
    AthensYellowBold = { fg = colors.yellow, bold = config.bold }, --[[fix]]
    AthensBlue = { fg = colors.blue }, --[[fix]]
    AthensBlueBold = { fg = colors.blue, bold = config.bold }, --[[fix]]
    AthensPurple = { fg = colors.purple }, --[[fix]]
    AthensPurpleBold = { fg = colors.purple, bold = config.bold }, --[[fix]]
    AthensAqua = { fg = colors.aqua }, --[[fix]]
    AthensAquaBold = { fg = colors.aqua, bold = config.bold }, --[[fix]]
    AthensOrangeNeutral = { fg = colors.neutral_orange },
    AthensOrange = { fg = colors.orange }, --[[fix]]
    AthensOrangeBold = { fg = colors.orange, bold = config.bold }, --[[fix]]
    AthensRedSign = config.transparent_mode and { fg = colors.red, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.red, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensGreenSign = config.transparent_mode and { fg = colors.green, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.green, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensYellowSign = config.transparent_mode and { fg = colors.yellow, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.yellow, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensBlueSign = config.transparent_mode and { fg = colors.blue, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.blue, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensPurpleSign = config.transparent_mode and { fg = colors.purple, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.purple, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensAquaSign = config.transparent_mode and { fg = colors.aqua, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.aqua, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensOrangeSign = config.transparent_mode and { fg = colors.orange, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.orange, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensOrangeNeutralSign = config.transparent_mode and { fg = colors.neutral_orange, reverse = config.invert_signs } --[[fix]]
      or { fg = colors.neutral_orange, bg = colors.bg1, reverse = config.invert_signs }, --[[fix]]
    AthensRedUnderline = { undercurl = config.undercurl, sp = colors.red }, --[[fix]]
    AthensGreenUnderline = { undercurl = config.undercurl, sp = colors.green }, --[[fix]]
    AthensYellowUnderline = { undercurl = config.undercurl, sp = colors.yellow }, --[[fix]]
    AthensBlueUnderline = { undercurl = config.undercurl, sp = colors.blue }, --[[fix]]
    AthensPurpleUnderline = { undercurl = config.undercurl, sp = colors.purple }, --[[fix]]
    AthensAquaUnderline = { undercurl = config.undercurl, sp = colors.aqua }, --[[fix]]
    AthensOrangeUnderline = { undercurl = config.undercurl, sp = colors.orange }, --[[fix]]
    Normal = config.transparent_mode and { fg = colors.fg1, bg = nil } or { fg = colors.fg1, bg = colors.bg0 }, --[[fix]]
    NormalFloat = config.transparent_mode and { fg = colors.fg1, bg = nil } or { fg = colors.fg1, bg = colors.bg1 }, --[[fix]]
    NormalNC = config.dim_inactive and { fg = colors.fg0, bg = colors.bg1 } or { link = "Normal" }, --[[fix]]
    CursorLine = { bg = colors.bg1 }, --[[fix]]
    CursorColumn = { link = "CursorLine" }, --[[fix]]
    TabLineFill = { fg = colors.bg4, bg = colors.bg1, reverse = config.invert_tabline }, --[[fix]]
    TabLineSel = { fg = colors.green, bg = colors.bg1, reverse = config.invert_tabline }, --[[fix]]
    TabLine = { link = "TabLineFill" }, --[[fix]]
    MatchParen = { bg = colors.bg3, bold = config.bold }, --[[fix]]
    ColorColumn = { bg = colors.bg1 }, --[[fix]]
    Conceal = { fg = colors.blue }, --[[fix]]
    CursorLineNr = { fg = colors.yellow, bg = colors.bg1 }, --[[fix]]
    NonText = { link = "AthensBg2" }, --[[fix]]
    SpecialKey = { link = "AthensFg4" }, --[[fix]]
    Visual = { bg = colors.bg3, reverse = config.invert_selection }, --[[fix]]
    VisualNOS = { link = "Visual" }, --[[fix]]
    Search = { fg = colors.yellow, bg = colors.bg0, reverse = config.inverse }, --[[fix]]
    IncSearch = { fg = colors.orange, bg = colors.bg0, reverse = config.inverse }, --[[fix]]
    CurSearch = { link = "IncSearch" }, --[[fix]]
    QuickFixLine = { link = "AthensPurple" }, --[[fix]]
    Underlined = { fg = colors.blue, underline = config.underline }, --[[fix]]
    StatusLine = { fg = colors.bg1, bg = colors.fg1, reverse = config.inverse }, --[[fix]]
    StatusLineNC = { fg = colors.bg1, bg = colors.fg4, reverse = config.inverse }, --[[fix]]
    WinBar = { fg = colors.fg4, bg = colors.bg0 }, --[[fix]]
    WinBarNC = { fg = colors.fg3, bg = colors.bg1 }, --[[fix]]
    WinSeparator = config.transparent_mode and { fg = colors.bg3, bg = nil } or { fg = colors.bg3, bg = colors.bg0 }, --[[fix]]
    WildMenu = { fg = colors.blue, bg = colors.bg2, bold = config.bold }, --[[fix]]
    Directory = { link = "AthensGreenBold" }, --[[fix]]
    Title = { link = "AthensGreenBold" }, --[[fix]]
    ErrorMsg = { fg = colors.bg0, bg = colors.red, bold = config.bold }, --[[fix]]
    MoreMsg = { link = "AthensYellowBold" }, --[[fix]]
    ModeMsg = { link = "AthensYellowBold" }, --[[fix]]
    Question = { link = "AthensOrangeBold" }, --[[fix]]
    WarningMsg = { link = "AthensRedBold" }, --[[fix]]
    LineNr = { fg = colors.bg4 }, --[[fix]]
    SignColumn = config.transparent_mode and { bg = nil } or { bg = colors.bg1 }, --[[fix]]
    Folded = { fg = colors.gray, bg = colors.bg1, italic = config.italic.folds }, --[[fix]]
    FoldColumn = config.transparent_mode and { fg = colors.gray, bg = nil } or { fg = colors.gray, bg = colors.bg1 }, --[[fix]]
    Cursor = { link = "AthensCursor" },
    vCursor = { link = "Cursor" }, --[[fix]]
    iCursor = { link = "Cursor" }, --[[fix]]
    lCursor = { link = "Cursor" }, --[[fix]]
    Special = { link = "AthensKeyword" },
    Comment = { fg = colors.comment, italic = config.italic.comments },
    Todo = { fg = colors.bg0, bg = colors.yellow, bold = config.bold, italic = config.italic.comments }, --[[fix]]
    Done = { fg = colors.orange, bold = config.bold, italic = config.italic.comments }, --[[fix]]
    Error = { fg = colors.err, bold = config.bold, reverse = config.inverse },
    Statement = { link = "AthensText" },
    Conditional = { link = "AthensKeyword" },
    Repeat = { link = "AthensKeyword" },
    Label = { link = "AthensConstant" },
    Exception = { link = "AthensError" },
    Operator = { fg = colors.fg1, italic = config.italic.operators }, --[[fix]]
    Keyword = { link = "AthensKeyword" },
    Identifier = { link = "AthensVar" },
    Function = { link = "AthensFunction" },
    PreProc = { link = "AthensPreProcessor" },
    Include = { link = "AthensPreProcessor" },
    Define = { link = "AthensPreProcessor" },
    Macro = { link = "AthensPreProcessor" },
    PreCondit = { link = "AthensPreProcessor" },
    Constant = { link = "AthensConstant" },
    Character = { link = "AthensText" },
    String = { fg = colors.str, italic = config.italic.strings },
    Fake = { fg = colors.fake, italic = config.italic.strings },
    Boolean = { link = "AthensText" },
    Number = { link = "AthensText" },
    Float = { link = "AthensText" },
    Type = { link = "AthensType" },
    StorageClass = { link = "AthensKeyword" },
    Structure = { link = "AthensKeyword" },
    Typedef = { link = "AthensKeyword" },
    Pmenu = { fg = colors.fg1, bg = colors.bg2 }, --[[fix]]
    PmenuSel = { fg = colors.bg2, bg = colors.blue, bold = config.bold }, --[[fix]]
    PmenuSbar = { bg = colors.bg2 }, --[[fix]]
    PmenuThumb = { bg = colors.bg4 }, --[[fix]]
    DiffDelete = { bg = colors.dark_red }, --[[fix]]
    DiffAdd = { bg = colors.dark_green }, --[[fix]]
    DiffChange = { bg = colors.dark_aqua }, --[[fix]]
    DiffText = { bg = colors.yellow, fg = colors.bg0 }, --[[fix]]
    SpellCap = { link = "AthensBlueUnderline" }, --[[fix]]
    SpellBad = { link = "AthensRedUnderline" }, --[[fix]]
    SpellLocal = { link = "AthensAquaUnderline" }, --[[fix]]
    SpellRare = { link = "AthensPurpleUnderline" }, --[[fix]]
    Whitespace = { fg = colors.bg2 }, --[[fix]]
    Delimiter = { link = "AthensText" },
    EndOfBuffer = { link = "NonText" }, --[[fix]]
    DiagnosticError = { link = "AthensRed" }, --[[fix]]
    DiagnosticSignError = { link = "AthensRedSign" }, --[[fix]]
    DiagnosticUnderlineError = { link = "AthensRedUnderline" }, --[[fix]]
    DiagnosticWarn = { link = "AthensYellow" }, --[[fix]]
    DiagnosticSignWarn = { link = "AthensYellowSign" }, --[[fix]]
    DiagnosticUnderlineWarn = { link = "AthensYellowUnderline" }, --[[fix]]
    DiagnosticInfo = { link = "AthensBlue" }, --[[fix]]
    DiagnosticSignInfo = { link = "AthensOrangeNeutralSign" },
    DiagnosticUnderlineInfo = { link = "AthensBlueUnderline" }, --[[fix]]
    DiagnosticHint = { link = "AthensAqua" }, --[[fix]]
    DiagnosticSignHint = { link = "AthensAquaSign" }, --[[fix]]
    DiagnosticUnderlineHint = { link = "AthensAquaUnderline" }, --[[fix]]
    DiagnosticFloatingError = { link = "AthensRed" }, --[[fix]]
    DiagnosticFloatingWarn = { link = "AthensOrange" }, --[[fix]]
    DiagnosticFloatingInfo = { link = "AthensBlue" }, --[[fix]]
    DiagnosticFloatingHint = { link = "AthensAqua" }, --[[fix]]
    DiagnosticVirtualTextError = { link = "AthensRed" }, --[[fix]]
    DiagnosticVirtualTextWarn = { link = "AthensYellow" }, --[[fix]]
    DiagnosticVirtualTextInfo = { link = "AthensBlue" }, --[[fix]]
    DiagnosticVirtualTextHint = { link = "AthensAqua" }, --[[fix]]
    DiagnosticOk = { link = "AthensGreenSign" }, --[[fix]]
    LspReferenceRead = { link = "AthensYellowBold" }, --[[fix]]
    LspReferenceText = { link = "AthensYellowBold" }, --[[fix]]
    LspReferenceWrite = { link = "AthensOrangeBold" }, --[[fix]]
    LspCodeLens = { link = "AthensGray" }, --[[fix]]
    LspSignatureActiveParameter = { link = "Search" }, --[[fix]]
    gitcommitSelectedFile = { link = "AthensGreen" }, --[[fix]]
    gitcommitDiscardedFile = { link = "AthensRed" }, --[[fix]]
    GitSignsAdd = { link = "AthensGreen" }, --[[fix]]
    GitSignsChange = { link = "AthensOrange" }, --[[fix]]
    GitSignsDelete = { link = "AthensRed" }, --[[fix]]
    NvimTreeSymlink = { fg = colors.neutral_aqua }, --[[fix]]
    NvimTreeRootFolder = { fg = colors.neutral_purple, bold = true }, --[[fix]]
    NvimTreeFolderIcon = { fg = colors.neutral_blue, bold = true }, --[[fix]]
    NvimTreeFileIcon = { fg = colors.fg2 },
    NvimTreeExecFile = { fg = colors.neutral_green, bold = true }, --[[fix]]
    NvimTreeOpenedFile = { fg = colors.bright_red, bold = true }, --[[fix]]
    NvimTreeSpecialFile = { fg = colors.neutral_yellow, bold = true, underline = true }, --[[fix]]
    NvimTreeImageFile = { fg = colors.neutral_purple }, --[[fix]]
    NvimTreeIndentMarker = { fg = colors.bg3 },
    NvimTreeGitDirty = { fg = colors.neutral_yellow }, --[[fix]]
    NvimTreeGitStaged = { fg = colors.neutral_yellow }, --[[fix]]
    NvimTreeGitMerge = { fg = colors.neutral_purple }, --[[fix]]
    NvimTreeGitRenamed = { fg = colors.neutral_purple }, --[[fix]]
    NvimTreeGitNew = { fg = colors.neutral_yellow }, --[[fix]]
    NvimTreeGitDeleted = { fg = colors.neutral_red }, --[[fix]]
    NvimTreeWindowPicker = { bg = colors.aqua }, --[[fix]]
    debugPC = { link = "DiffAdd" }, --[[fix]]
    debugBreakpoint = { link = "AthensRedSign" }, --[[fix]]
    StartifyBracket = { link = "AthensFg3" }, --[[fix]]
    StartifyFile = { link = "AthensFg1" }, --[[fix]]
    StartifyNumber = { link = "AthensBlue" }, --[[fix]]
    StartifyPath = { link = "AthensGray" }, --[[fix]]
    StartifySlash = { link = "AthensGray" }, --[[fix]]
    StartifySection = { link = "AthensYellow" }, --[[fix]]
    StartifySpecial = { link = "AthensBg2" }, --[[fix]]
    StartifyHeader = { link = "AthensOrange" }, --[[fix]]
    StartifyFooter = { link = "AthensBg2" }, --[[fix]]
    StartifyVar = { link = "StartifyPath" }, --[[fix]]
    StartifySelect = { link = "Title" }, --[[fix]]
    DirvishPathTail = { link = "AthensAqua" }, --[[fix]]
    DirvishArg = { link = "AthensYellow" }, --[[fix]]
    netrwDir = { link = "AthensAqua" }, --[[fix]]
    netrwClassify = { link = "AthensAqua" }, --[[fix]]
    netrwLink = { link = "AthensGray" }, --[[fix]]
    netrwSymLink = { link = "AthensFg1" }, --[[fix]]
    netrwExe = { link = "AthensYellow" }, --[[fix]]
    netrwComment = { link = "AthensGray" }, --[[fix]]
    netrwList = { link = "AthensBlue" }, --[[fix]]
    netrwHelpCmd = { link = "AthensAqua" }, --[[fix]]
    netrwCmdSep = { link = "AthensFg3" }, --[[fix]]
    netrwVersion = { link = "AthensGreen" }, --[[fix]]
    NERDTreeDir = { link = "AthensAqua" }, --[[fix]]
    NERDTreeDirSlash = { link = "AthensAqua" }, --[[fix]]
    NERDTreeOpenable = { link = "AthensOrange" }, --[[fix]]
    NERDTreeClosable = { link = "AthensOrange" }, --[[fix]]
    NERDTreeFile = { link = "AthensFg1" }, --[[fix]]
    NERDTreeExecFile = { link = "AthensYellow" }, --[[fix]]
    NERDTreeUp = { link = "AthensGray" }, --[[fix]]
    NERDTreeCWD = { link = "AthensGreen" }, --[[fix]]
    NERDTreeHelp = { link = "AthensFg1" }, --[[fix]]
    NERDTreeToggleOn = { link = "AthensGreen" }, --[[fix]]
    NERDTreeToggleOff = { link = "AthensRed" }, --[[fix]]
    CocErrorSign = { link = "AthensRedSign" }, --[[fix]]
    CocWarningSign = { link = "AthensOrangeSign" }, --[[fix]]
    CocInfoSign = { link = "AthensBlueSign" }, --[[fix]]
    CocHintSign = { link = "AthensAquaSign" }, --[[fix]]
    CocErrorFloat = { link = "AthensRed" }, --[[fix]]
    CocWarningFloat = { link = "AthensOrange" }, --[[fix]]
    CocInfoFloat = { link = "AthensBlue" }, --[[fix]]
    CocHintFloat = { link = "AthensAqua" }, --[[fix]]
    CocDiagnosticsError = { link = "AthensRed" }, --[[fix]]
    CocDiagnosticsWarning = { link = "AthensOrange" }, --[[fix]]
    CocDiagnosticsInfo = { link = "AthensBlue" }, --[[fix]]
    CocDiagnosticsHint = { link = "AthensAqua" }, --[[fix]]
    CocSelectedText = { link = "AthensRed" }, --[[fix]]
    CocMenuSel = { link = "PmenuSel" }, --[[fix]]
    CocCodeLens = { link = "AthensGray" }, --[[fix]]
    CocErrorHighlight = { link = "AthensRedUnderline" }, --[[fix]]
    CocWarningHighlight = { link = "AthensOrangeUnderline" }, --[[fix]]
    CocInfoHighlight = { link = "AthensBlueUnderline" }, --[[fix]]
    CocHintHighlight = { link = "AthensAquaUnderline" }, --[[fix]]
    TelescopeNormal = { link = "AthensFg1" }, --[[fix]]
    TelescopeSelection = { link = "AthensOrangeBold" }, --[[fix]]
    TelescopeSelectionCaret = { link = "AthensRed" }, --[[fix]]
    TelescopeMultiSelection = { link = "AthensGray" }, --[[fix]]
    TelescopeBorder = { link = "TelescopeNormal" }, --[[fix]]
    TelescopePromptBorder = { link = "TelescopeNormal" }, --[[fix]]
    TelescopeResultsBorder = { link = "TelescopeNormal" }, --[[fix]]
    TelescopePreviewBorder = { link = "TelescopeNormal" }, --[[fix]]
    TelescopeMatching = { link = "AthensBlue" }, --[[fix]]
    TelescopePromptPrefix = { link = "AthensRed" }, --[[fix]]
    TelescopePrompt = { link = "TelescopeNormal" }, --[[fix]]
    CmpItemAbbr = { link = "AthensFg0" }, --[[fix]]
    CmpItemAbbrDeprecated = { link = "AthensFg1" }, --[[fix]]
    CmpItemAbbrMatch = { link = "AthensBlueBold" }, --[[fix]]
    CmpItemAbbrMatchFuzzy = { link = "AthensBlueUnderline" }, --[[fix]]
    CmpItemMenu = { link = "AthensGray" }, --[[fix]]
    CmpItemKindText = { link = "AthensOrange" }, --[[fix]]
    CmpItemKindVariable = { link = "AthensOrange" }, --[[fix]]
    CmpItemKindMethod = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindFunction = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindConstructor = { link = "AthensYellow" }, --[[fix]]
    CmpItemKindUnit = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindField = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindClass = { link = "AthensYellow" }, --[[fix]]
    CmpItemKindInterface = { link = "AthensYellow" }, --[[fix]]
    CmpItemKindModule = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindProperty = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindValue = { link = "AthensOrange" }, --[[fix]]
    CmpItemKindEnum = { link = "AthensYellow" }, --[[fix]]
    CmpItemKindOperator = { link = "AthensYellow" }, --[[fix]]
    CmpItemKindKeyword = { link = "AthensPurple" }, --[[fix]]
    CmpItemKindEvent = { link = "AthensPurple" }, --[[fix]]
    CmpItemKindReference = { link = "AthensPurple" }, --[[fix]]
    CmpItemKindColor = { link = "AthensPurple" }, --[[fix]]
    CmpItemKindSnippet = { link = "AthensGreen" }, --[[fix]]
    CmpItemKindFile = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindFolder = { link = "AthensBlue" }, --[[fix]]
    CmpItemKindEnumMember = { link = "AthensAqua" }, --[[fix]]
    CmpItemKindConstant = { link = "AthensOrange" }, --[[fix]]
    CmpItemKindStruct = { link = "AthensYellow" }, --[[fix]]
    CmpItemKindTypeParameter = { link = "AthensYellow" }, --[[fix]]
    diffAdded = { link = "DiffAdd" }, --[[fix]]
    diffRemoved = { link = "DiffDelete" }, --[[fix]]
    diffChanged = { link = "DiffChange" }, --[[fix]]
    diffFile = { link = "AthensOrange" }, --[[fix]]
    diffNewFile = { link = "AthensYellow" }, --[[fix]]
    diffOldFile = { link = "AthensOrange" }, --[[fix]]
    diffLine = { link = "AthensBlue" }, --[[fix]]
    diffIndexLine = { link = "diffChanged" }, --[[fix]]
    NavicIconsFile = { link = "AthensBlue" }, --[[fix]]
    NavicIconsModule = { link = "AthensOrange" }, --[[fix]]
    NavicIconsNamespace = { link = "AthensBlue" }, --[[fix]]
    NavicIconsPackage = { link = "AthensAqua" }, --[[fix]]
    NavicIconsClass = { link = "AthensYellow" }, --[[fix]]
    NavicIconsMethod = { link = "AthensBlue" }, --[[fix]]
    NavicIconsProperty = { link = "AthensAqua" }, --[[fix]]
    NavicIconsField = { link = "AthensPurple" }, --[[fix]]
    NavicIconsConstructor = { link = "AthensBlue" }, --[[fix]]
    NavicIconsEnum = { link = "AthensPurple" }, --[[fix]]
    NavicIconsInterface = { link = "AthensGreen" }, --[[fix]]
    NavicIconsFunction = { link = "AthensBlue" }, --[[fix]]
    NavicIconsVariable = { link = "AthensPurple" }, --[[fix]]
    NavicIconsConstant = { link = "AthensOrange" }, --[[fix]]
    NavicIconsString = { link = "AthensGreen" }, --[[fix]]
    NavicIconsNumber = { link = "AthensOrange" }, --[[fix]]
    NavicIconsBoolean = { link = "AthensOrange" }, --[[fix]]
    NavicIconsArray = { link = "AthensOrange" }, --[[fix]]
    NavicIconsObject = { link = "AthensOrange" }, --[[fix]]
    NavicIconsKey = { link = "AthensAqua" }, --[[fix]]
    NavicIconsNull = { link = "AthensOrange" }, --[[fix]]
    NavicIconsEnumMember = { link = "AthensYellow" }, --[[fix]]
    NavicIconsStruct = { link = "AthensPurple" }, --[[fix]]
    NavicIconsEvent = { link = "AthensYellow" }, --[[fix]]
    NavicIconsOperator = { link = "AthensRed" }, --[[fix]]
    NavicIconsTypeParameter = { link = "AthensRed" }, --[[fix]]
    NavicText = { link = "AthensWhite" }, --[[fix]]
    NavicSeparator = { link = "AthensWhite" }, --[[fix]]
    htmlTag = { link = "AthensAquaBold" }, --[[fix]]
    htmlEndTag = { link = "AthensAquaBold" }, --[[fix]]
    htmlTagName = { link = "AthensBlue" }, --[[fix]]
    htmlArg = { link = "AthensOrange" }, --[[fix]]
    htmlTagN = { link = "AthensFg1" }, --[[fix]]
    htmlSpecialTagName = { link = "AthensBlue" }, --[[fix]]
    htmlLink = { fg = colors.fg4, underline = config.underline },
    htmlSpecialChar = { link = "AthensRed" }, --[[fix]]
    htmlBold = { fg = colors.fg0, bg = colors.bg0, bold = config.bold },
    htmlBoldUnderline = { fg = colors.fg0, bg = colors.bg0, bold = config.bold, underline = config.underline },
    htmlBoldItalic = { fg = colors.fg0, bg = colors.bg0, bold = config.bold, italic = true },
    htmlBoldUnderlineItalic = {
      fg = colors.fg0,
      bg = colors.bg0,
      bold = config.bold,
      italic = true,
      underline = config.underline,
    },
    htmlUnderline = { fg = colors.fg0, bg = colors.bg0, underline = config.underline },
    htmlUnderlineItalic = {
      fg = colors.fg0,
      bg = colors.bg0,
      italic = true,
      underline = config.underline,
    },
    htmlItalic = { fg = colors.fg0, bg = colors.bg0, italic = true },
    xmlTag = { link = "AthensAquaBold" }, --[[fix]]
    xmlEndTag = { link = "AthensAquaBold" }, --[[fix]]
    xmlTagName = { link = "AthensBlue" }, --[[fix]]
    xmlEqual = { link = "AthensBlue" }, --[[fix]]
    docbkKeyword = { link = "AthensAquaBold" }, --[[fix]]
    xmlDocTypeDecl = { link = "AthensGray" }, --[[fix]]
    xmlDocTypeKeyword = { link = "AthensPurple" }, --[[fix]]
    xmlCdataStart = { link = "AthensGray" }, --[[fix]]
    xmlCdataCdata = { link = "AthensPurple" }, --[[fix]]
    dtdFunction = { link = "AthensGray" }, --[[fix]]
    dtdTagName = { link = "AthensPurple" }, --[[fix]]
    xmlAttrib = { link = "AthensOrange" }, --[[fix]]
    xmlProcessingDelim = { link = "AthensGray" }, --[[fix]]
    dtdParamEntityPunct = { link = "AthensGray" }, --[[fix]]
    dtdParamEntityDPunct = { link = "AthensGray" }, --[[fix]]
    xmlAttribPunct = { link = "AthensGray" }, --[[fix]]
    xmlEntity = { link = "AthensRed" }, --[[fix]]
    xmlEntityPunct = { link = "AthensRed" }, --[[fix]]
    clojureKeyword = { link = "AthensBlue" }, --[[fix]]
    clojureCond = { link = "AthensOrange" }, --[[fix]]
    clojureSpecial = { link = "AthensOrange" }, --[[fix]]
    clojureDefine = { link = "AthensOrange" }, --[[fix]]
    clojureFunc = { link = "AthensYellow" }, --[[fix]]
    clojureRepeat = { link = "AthensYellow" }, --[[fix]]
    clojureCharacter = { link = "AthensAqua" }, --[[fix]]
    clojureStringEscape = { link = "AthensAqua" }, --[[fix]]
    clojureException = { link = "AthensRed" }, --[[fix]]
    clojureRegexp = { link = "AthensAqua" }, --[[fix]]
    clojureRegexpEscape = { link = "AthensAqua" }, --[[fix]]
    clojureRegexpCharClass = { fg = colors.fg3, bold = config.bold }, --[[fix]]
    clojureRegexpMod = { link = "clojureRegexpCharClass" }, --[[fix]]
    clojureRegexpQuantifier = { link = "clojureRegexpCharClass" }, --[[fix]]
    clojureParen = { link = "AthensFg3" }, --[[fix]]
    clojureAnonArg = { link = "AthensYellow" }, --[[fix]]
    clojureVariable = { link = "AthensBlue" }, --[[fix]]
    clojureMacro = { link = "AthensOrange" }, --[[fix]]
    clojureMeta = { link = "AthensYellow" }, --[[fix]]
    clojureDeref = { link = "AthensYellow" }, --[[fix]]
    clojureQuote = { link = "AthensYellow" }, --[[fix]]
    clojureUnquote = { link = "AthensYellow" }, --[[fix]]
    cOperator = { link = "AthensKeyword" },
    cppOperator = { link = "AthensKeyword" },
    cStructure = { link = "AthensKeyword" },
    pythonBuiltin = { link = "AthensOrange" }, --[[fix]]
    pythonBuiltinObj = { link = "AthensOrange" }, --[[fix]]
    pythonBuiltinFunc = { link = "AthensOrange" }, --[[fix]]
    pythonFunction = { link = "AthensFunction" },
    pythonDecorator = { link = "AthensRed" }, --[[fix]]
    pythonInclude = { link = "AthensBlue" }, --[[fix]]
    pythonImport = { link = "AthensBlue" }, --[[fix]]
    pythonRun = { link = "AthensBlue" }, --[[fix]]
    pythonCoding = { link = "AthensBlue" }, --[[fix]]
    pythonOperator = { link = "AthensRed" }, --[[fix]]
    pythonException = { link = "AthensRed" }, --[[fix]]
    pythonExceptions = { link = "AthensPurple" }, --[[fix]]
    pythonBoolean = { link = "AthensPurple" }, --[[fix]]
    pythonDot = { link = "AthensFg3" }, --[[fix]]
    pythonConditional = { link = "AthensRed" }, --[[fix]]
    pythonRepeat = { link = "AthensRed" }, --[[fix]]
    pythonDottedName = { link = "AthensGreenBold" }, --[[fix]]
    cssBraces = { link = "AthensBlue" }, --[[fix]]
    cssFunctionName = { link = "AthensFunction" },
    cssIdentifier = { link = "AthensOrange" }, --[[fix]]
    cssClassName = { link = "AthensGreen" }, --[[fix]]
    cssColor = { link = "AthensBlue" }, --[[fix]]
    cssSelectorOp = { link = "AthensBlue" }, --[[fix]]
    cssSelectorOp2 = { link = "AthensBlue" }, --[[fix]]
    cssImportant = { link = "AthensGreen" }, --[[fix]]
    cssVendor = { link = "AthensFg1" }, --[[fix]]
    cssTextProp = { link = "AthensAqua" }, --[[fix]]
    cssAnimationProp = { link = "AthensAqua" }, --[[fix]]
    cssUIProp = { link = "AthensYellow" }, --[[fix]]
    cssTransformProp = { link = "AthensAqua" }, --[[fix]]
    cssTransitionProp = { link = "AthensAqua" }, --[[fix]]
    cssPrintProp = { link = "AthensAqua" }, --[[fix]]
    cssPositioningProp = { link = "AthensYellow" }, --[[fix]]
    cssBoxProp = { link = "AthensAqua" }, --[[fix]]
    cssFontDescriptorProp = { link = "AthensAqua" }, --[[fix]]
    cssFlexibleBoxProp = { link = "AthensAqua" }, --[[fix]]
    cssBorderOutlineProp = { link = "AthensAqua" }, --[[fix]]
    cssBackgroundProp = { link = "AthensAqua" }, --[[fix]]
    cssMarginProp = { link = "AthensAqua" }, --[[fix]]
    cssListProp = { link = "AthensAqua" }, --[[fix]]
    cssTableProp = { link = "AthensAqua" }, --[[fix]]
    cssFontProp = { link = "AthensAqua" }, --[[fix]]
    cssPaddingProp = { link = "AthensAqua" }, --[[fix]]
    cssDimensionProp = { link = "AthensAqua" }, --[[fix]]
    cssRenderProp = { link = "AthensAqua" }, --[[fix]]
    cssColorProp = { link = "AthensAqua" }, --[[fix]]
    cssGeneratedContentProp = { link = "AthensAqua" }, --[[fix]]
    javaScriptBraces = { link = "AthensFg1" }, --[[fix]]
    javaScriptFunction = { link = "AthensFunction" },
    javaScriptIdentifier = { link = "AthensRed" }, --[[fix]]
    javaScriptMember = { link = "AthensBlue" }, --[[fix]]
    javaScriptNumber = { link = "AthensPurple" }, --[[fix]]
    javaScriptNull = { link = "AthensPurple" }, --[[fix]]
    javaScriptParens = { link = "AthensFg3" }, --[[fix]]
    typescriptReserved = { link = "AthensAqua" }, --[[fix]]
    typescriptLabel = { link = "AthensAqua" }, --[[fix]]
    typescriptFuncKeyword = { link = "AthensAqua" }, --[[fix]]
    typescriptIdentifier = { link = "AthensOrange" }, --[[fix]]
    typescriptBraces = { link = "AthensFg1" }, --[[fix]]
    typescriptEndColons = { link = "AthensFg1" }, --[[fix]]
    typescriptDOMObjects = { link = "AthensFg1" }, --[[fix]]
    typescriptAjaxMethods = { link = "AthensFg1" }, --[[fix]]
    typescriptLogicSymbols = { link = "AthensFg1" }, --[[fix]]
    typescriptDocSeeTag = { link = "Comment" }, --[[fix]]
    typescriptDocParam = { link = "Comment" }, --[[fix]]
    typescriptDocTags = { link = "vimCommentTitle" }, --[[fix]]
    typescriptGlobalObjects = { link = "AthensFg1" }, --[[fix]]
    typescriptParens = { link = "AthensFg3" }, --[[fix]]
    typescriptOpSymbols = { link = "AthensFg3" }, --[[fix]]
    typescriptHtmlElemProperties = { link = "AthensFg1" }, --[[fix]]
    typescriptNull = { link = "AthensPurple" }, --[[fix]]
    typescriptInterpolationDelimiter = { link = "AthensAqua" }, --[[fix]]
    coffeeExtendedOp = { link = "AthensFg3" }, --[[fix]]
    coffeeSpecialOp = { link = "AthensFg3" }, --[[fix]]
    coffeeCurly = { link = "AthensOrange" }, --[[fix]]
    coffeeParen = { link = "AthensFg3" }, --[[fix]]
    coffeeBracket = { link = "AthensOrange" }, --[[fix]]
    rubyStringDelimiter = { link = "AthensGreen" }, --[[fix]]
    rubyInterpolationDelimiter = { link = "AthensAqua" }, --[[fix]]
    rubyDefinedOperator = { link = "rubyKeyword" }, --[[fix]]
    objcTypeModifier = { link = "AthensRed" }, --[[fix]]
    objcDirective = { link = "AthensBlue" }, --[[fix]]
    goDirective = { link = "AthensAqua" }, --[[fix]]
    goConstants = { link = "AthensPurple" }, --[[fix]]
    goDeclaration = { link = "AthensRed" }, --[[fix]]
    goDeclType = { link = "AthensBlue" }, --[[fix]]
    goBuiltins = { link = "AthensOrange" }, --[[fix]]
    luaIn = { link = "AthensRed" }, --[[fix]]
    luaFunction = { link = "AthensFunction" },
    luaTable = { link = "AthensOrange" }, --[[fix]]
    moonSpecialOp = { link = "AthensFg3" }, --[[fix]]
    moonExtendedOp = { link = "AthensFg3" }, --[[fix]]
    moonFunction = { link = "AthensFunction" },
    moonObject = { link = "AthensYellow" }, --[[fix]]
    javaAnnotation = { link = "AthensBlue" }, --[[fix]]
    javaDocTags = { link = "AthensAqua" }, --[[fix]]
    javaCommentTitle = { link = "vimCommentTitle" }, --[[fix]]
    javaParen = { link = "AthensFg3" }, --[[fix]]
    javaParen1 = { link = "AthensFg3" }, --[[fix]]
    javaParen2 = { link = "AthensFg3" }, --[[fix]]
    javaParen3 = { link = "AthensFg3" }, --[[fix]]
    javaParen4 = { link = "AthensFg3" }, --[[fix]]
    javaParen5 = { link = "AthensFg3" }, --[[fix]]
    javaOperator = { link = "AthensOrange" }, --[[fix]]
    javaVarArg = { link = "AthensGreen" }, --[[fix]]
    elixirDocString = { link = "Comment" }, --[[fix]]
    elixirStringDelimiter = { link = "AthensGreen" }, --[[fix]]
    elixirInterpolationDelimiter = { link = "AthensAqua" }, --[[fix]]
    elixirModuleDeclaration = { link = "AthensYellow" }, --[[fix]]
    markdownItalic = { fg = colors.fg3, italic = true },
    markdownBold = { fg = colors.fg3, bold = config.bold },
    markdownBoldItalic = { fg = colors.fg3, bold = config.bold, italic = true },
    markdownH1 = { link = "AthensGreenBold" }, --[[fix]]
    markdownH2 = { link = "AthensGreenBold" }, --[[fix]]
    markdownH3 = { link = "AthensYellowBold" }, --[[fix]]
    markdownH4 = { link = "AthensYellowBold" }, --[[fix]]
    markdownH5 = { link = "AthensYellow" }, --[[fix]]
    markdownH6 = { link = "AthensYellow" }, --[[fix]]
    markdownCode = { link = "AthensAqua" }, --[[fix]]
    markdownCodeBlock = { link = "AthensAqua" }, --[[fix]]
    markdownCodeDelimiter = { link = "AthensAqua" }, --[[fix]]
    markdownBlockquote = { link = "AthensGray" }, --[[fix]]
    markdownListMarker = { link = "AthensGray" }, --[[fix]]
    markdownOrderedListMarker = { link = "AthensGray" }, --[[fix]]
    markdownRule = { link = "AthensGray" }, --[[fix]]
    markdownHeadingRule = { link = "AthensGray" }, --[[fix]]
    markdownUrlDelimiter = { link = "AthensFg3" }, --[[fix]]
    markdownLinkDelimiter = { link = "AthensFg3" }, --[[fix]]
    markdownLinkTextDelimiter = { link = "AthensFg3" }, --[[fix]]
    markdownHeadingDelimiter = { link = "AthensOrange" }, --[[fix]]
    markdownUrl = { link = "AthensPurple" }, --[[fix]]
    markdownUrlTitleDelimiter = { link = "AthensGreen" }, --[[fix]]
    markdownLinkText = { fg = colors.gray, underline = config.underline }, --[[fix]]
    markdownIdDeclaration = { link = "markdownLinkText" }, --[[fix]]
    haskellType = { link = "AthensBlue" }, --[[fix]]
    haskellIdentifier = { link = "AthensAqua" }, --[[fix]]
    haskellSeparator = { link = "AthensFg4" }, --[[fix]]
    haskellDelimiter = { link = "AthensOrange" }, --[[fix]]
    haskellOperators = { link = "AthensPurple" }, --[[fix]]
    haskellBacktick = { link = "AthensOrange" }, --[[fix]]
    haskellStatement = { link = "AthensPurple" }, --[[fix]]
    haskellConditional = { link = "AthensPurple" }, --[[fix]]
    haskellLet = { link = "AthensRed" }, --[[fix]]
    haskellDefault = { link = "AthensRed" }, --[[fix]]
    haskellWhere = { link = "AthensRed" }, --[[fix]]
    haskellBottom = { link = "AthensRedBold" }, --[[fix]]
    haskellImportKeywords = { link = "AthensPurpleBold" }, --[[fix]]
    haskellDeclKeyword = { link = "AthensOrange" }, --[[fix]]
    haskellDecl = { link = "AthensOrange" }, --[[fix]]
    haskellDeriving = { link = "AthensPurple" }, --[[fix]]
    haskellAssocType = { link = "AthensAqua" }, --[[fix]]
    haskellNumber = { link = "AthensAqua" }, --[[fix]]
    haskellPragma = { link = "AthensRedBold" }, --[[fix]]
    haskellTH = { link = "AthensAquaBold" }, --[[fix]]
    haskellForeignKeywords = { link = "AthensGreen" }, --[[fix]]
    haskellKeyword = { link = "AthensRed" }, --[[fix]]
    haskellFloat = { link = "AthensAqua" }, --[[fix]]
    haskellInfix = { link = "AthensPurple" }, --[[fix]]
    haskellQuote = { link = "AthensGreenBold" }, --[[fix]]
    haskellShebang = { link = "AthensYellowBold" }, --[[fix]]
    haskellLiquid = { link = "AthensPurpleBold" }, --[[fix]]
    haskellQuasiQuoted = { link = "AthensBlueBold" }, --[[fix]]
    haskellRecursiveDo = { link = "AthensPurple" }, --[[fix]]
    haskellQuotedType = { link = "AthensRed" }, --[[fix]]
    haskellPreProc = { link = "AthensFg4" }, --[[fix]]
    haskellTypeRoles = { link = "AthensRedBold" }, --[[fix]]
    haskellTypeForall = { link = "AthensRed" }, --[[fix]]
    haskellPatternKeyword = { link = "AthensBlue" }, --[[fix]]
    jsonKeyword = { link = "AthensGreen" }, --[[fix]]
    jsonQuote = { link = "AthensGreen" }, --[[fix]]
    jsonBraces = { link = "AthensFg1" }, --[[fix]]
    jsonString = { link = "AthensFg1" }, --[[fix]]
    mailQuoted1 = { link = "AthensAqua" }, --[[fix]]
    mailQuoted2 = { link = "AthensPurple" }, --[[fix]]
    mailQuoted3 = { link = "AthensYellow" }, --[[fix]]
    mailQuoted4 = { link = "AthensGreen" }, --[[fix]]
    mailQuoted5 = { link = "AthensRed" }, --[[fix]]
    mailQuoted6 = { link = "AthensOrange" }, --[[fix]]
    mailSignature = { link = "Comment" }, --[[fix]]
    csBraces = { link = "AthensFg1" }, --[[fix]]
    csEndColon = { link = "AthensFg1" }, --[[fix]]
    csLogicSymbols = { link = "AthensFg1" }, --[[fix]]
    csParens = { link = "AthensFg3" }, --[[fix]]
    csOpSymbols = { link = "AthensFg3" }, --[[fix]]
    csInterpolationDelimiter = { link = "AthensFg3" }, --[[fix]]
    csInterpolationAlignDel = { link = "AthensAquaBold" }, --[[fix]]
    csInterpolationFormat = { link = "AthensAqua" }, --[[fix]]
    csInterpolationFormatDel = { link = "AthensAquaBold" }, --[[fix]]
    rustSigil = { link = "AthensText" },
    rustEscape = { link = "AthensAqua" }, --[[fix]]
    rustStringContinuation = { link = "AthensAqua" }, --[[fix]]
    rustEnum = { link = "AthensAqua" }, --[[fix]]
    rustStructure = { link = "AthensAqua" }, --[[fix]]
    rustModPathSep = { link = "AthensFg2" }, --[[fix]]
    rustCommentLineDoc = { link = "Comment" }, --[[fix]]
    rustDefault = { link = "AthensAqua" }, --[[fix]]
    ocamlOperator = { link = "AthensFg1" }, --[[fix]]
    ocamlKeyChar = { link = "AthensOrange" }, --[[fix]]
    ocamlArrow = { link = "AthensOrange" }, --[[fix]]
    ocamlInfixOpKeyword = { link = "AthensRed" }, --[[fix]]
    ocamlConstructor = { link = "AthensOrange" }, --[[fix]]
    LspSagaCodeActionTitle = { link = "Title" }, --[[fix]]
    LspSagaCodeActionBorder = { link = "AthensFg1" }, --[[fix]]
    LspSagaCodeActionContent = { fg = colors.green, bold = config.bold },
    LspSagaLspFinderBorder = { link = "AthensFg1" }, --[[fix]]
    LspSagaAutoPreview = { link = "AthensOrange" }, --[[fix]]
    TargetWord = { fg = colors.blue, bold = config.bold },
    FinderSeparator = { link = "AthensAqua" }, --[[fix]]
    LspSagaDefPreviewBorder = { link = "AthensBlue" }, --[[fix]]
    LspSagaHoverBorder = { link = "AthensOrange" }, --[[fix]]
    LspSagaRenameBorder = { link = "AthensBlue" }, --[[fix]]
    LspSagaDiagnosticSource = { link = "AthensOrange" }, --[[fix]]
    LspSagaDiagnosticBorder = { link = "AthensPurple" }, --[[fix]]
    LspSagaDiagnosticHeader = { link = "AthensGreen" }, --[[fix]]
    LspSagaSignatureHelpBorder = { link = "AthensGreen" }, --[[fix]]
    SagaShadow = { link = "AthensBg0" }, --[[fix]]
    DashboardShortCut = { link = "AthensOrange" }, --[[fix]]
    DashboardHeader = { link = "AthensAqua" }, --[[fix]]
    DashboardCenter = { link = "AthensYellow" }, --[[fix]]
    DashboardFooter = { fg = colors.purple, italic = true }, --[[fix]]
    MasonHighlight = { link = "AthensAqua" }, --[[fix]]
    MasonHighlightBlock = { fg = colors.bg0, bg = colors.blue },
    MasonHighlightBlockBold = { fg = colors.bg0, bg = colors.blue, bold = true },
    MasonHighlightSecondary = { fg = colors.yellow },
    MasonHighlightBlockSecondary = { fg = colors.bg0, bg = colors.yellow },
    MasonHighlightBlockBoldSecondary = { fg = colors.bg0, bg = colors.yellow, bold = true },
    MasonHeader = { link = "MasonHighlightBlockBoldSecondary" }, --[[fix]]
    MasonHeaderSecondary = { link = "MasonHighlightBlockBold" }, --[[fix]]
    MasonMuted = { fg = colors.fg4 },
    MasonMutedBlock = { fg = colors.bg0, bg = colors.fg4 },
    MasonMutedBlockBold = { fg = colors.bg0, bg = colors.fg4, bold = true },
    LspInlayHint = { link = "comment" }, --[[fix]]
    CarbonFile = { link = "AthensFg1" }, --[[fix]]
    CarbonExe = { link = "AthensYellow" }, --[[fix]]
    CarbonSymlink = { link = "AthensAqua" }, --[[fix]]
    CarbonBrokenSymlink = { link = "AthensRed" }, --[[fix]]
    CarbonIndicator = { link = "AthensGray" }, --[[fix]]
    CarbonDanger = { link = "AthensRed" }, --[[fix]]
    CarbonPending = { link = "AthensYellow" }, --[[fix]]
    NoiceCursor = { link = "TermCursor" }, --[[fix]]
    NotifyDEBUGBorder = { link = "AthensBlue" }, --[[fix]]
    NotifyDEBUGIcon = { link = "AthensBlue" }, --[[fix]]
    NotifyDEBUGTitle = { link = "AthensBlue" }, --[[fix]]
    NotifyERRORBorder = { link = "AthensRed" }, --[[fix]]
    NotifyERRORIcon = { link = "AthensRed" }, --[[fix]]
    NotifyERRORTitle = { link = "AthensRed" }, --[[fix]]
    NotifyINFOBorder = { link = "AthensAqua" }, --[[fix]]
    NotifyINFOIcon = { link = "AthensAqua" }, --[[fix]]
    NotifyINFOTitle = { link = "AthensAqua" }, --[[fix]]
    NotifyTRACEBorder = { link = "AthensGreen" }, --[[fix]]
    NotifyTRACEIcon = { link = "AthensGreen" }, --[[fix]]
    NotifyTRACETitle = { link = "AthensGreen" }, --[[fix]]
    NotifyWARNBorder = { link = "AthensYellow" }, --[[fix]]
    NotifyWARNIcon = { link = "AthensYellow" }, --[[fix]]
    NotifyWARNTitle = { link = "AthensYellow" }, --[[fix]]
    IlluminatedWordText = { link = "LspReferenceText" }, --[[fix]]
    IlluminatedWordRead = { link = "LspReferenceRead" }, --[[fix]]
    IlluminatedWordWrite = { link = "LspReferenceWrite" }, --[[fix]]
    TSRainbowRed = { fg = colors.red }, --[[fix]]
    TSRainbowOrange = { fg = colors.orange }, --[[fix]]
    TSRainbowYellow = { fg = colors.yellow }, --[[fix]]
    TSRainbowGreen = { fg = colors.green }, --[[fix]]
    TSRainbowBlue = { fg = colors.blue }, --[[fix]]
    TSRainbowViolet = { fg = colors.purple }, --[[fix]]
    TSRainbowCyan = { fg = colors.aqua }, --[[fix]]
    RainbowDelimiterRed = { fg = colors.red }, --[[fix]]
    RainbowDelimiterOrange = { fg = colors.orange }, --[[fix]]
    RainbowDelimiterYellow = { fg = colors.yellow }, --[[fix]]
    RainbowDelimiterGreen = { fg = colors.green }, --[[fix]]
    RainbowDelimiterBlue = { fg = colors.blue }, --[[fix]]
    RainbowDelimiterViolet = { fg = colors.purple }, --[[fix]]
    RainbowDelimiterCyan = { fg = colors.aqua }, --[[fix]]
    DapBreakpointSymbol = { fg = colors.red, bg = colors.bg1 }, --[[fix]]
    DapStoppedSymbol = { fg = colors.green, bg = colors.bg1 }, --[[fix]]
    DapUIBreakpointsCurrentLine = { link = "AthensYellow" }, --[[fix]]
    DapUIBreakpointsDisabledLine = { link = "AthensGray" }, --[[fix]]
    DapUIBreakpointsInfo = { link = "AthensAqua" }, --[[fix]]
    DapUIBreakpointsLine = { link = "AthensYellow" }, --[[fix]]
    DapUIBreakpointsPath = { link = "AthensBlue" }, --[[fix]]
    DapUICurrentFrameName = { link = "AthensPurple" }, --[[fix]]
    DapUIDecoration = { link = "AthensPurple" }, --[[fix]]
    DapUIEndofBuffer = { link = "EndOfBuffer" }, --[[fix]]
    DapUIFloatBorder = { link = "AthensAqua" }, --[[fix]]
    DapUILineNumber = { link = "AthensYellow" }, --[[fix]]
    DapUIModifiedValue = { link = "AthensRed" }, --[[fix]]
    DapUIPlayPause = { fg = colors.green, bg = colors.bg1 }, --[[fix]]
    DapUIRestart = { fg = colors.green, bg = colors.bg1 }, --[[fix]]
    DapUIScope = { link = "AthensBlue" }, --[[fix]]
    DapUISource = { link = "AthensFg1" }, --[[fix]]
    DapUIStepBack = { fg = colors.blue, bg = colors.bg1 }, --[[fix]]
    DapUIStepInto = { fg = colors.blue, bg = colors.bg1 }, --[[fix]]
    DapUIStepOut = { fg = colors.blue, bg = colors.bg1 }, --[[fix]]
    DapUIStepOver = { fg = colors.blue, bg = colors.bg1 }, --[[fix]]
    DapUIStop = { fg = colors.red, bg = colors.bg1 }, --[[fix]]
    DapUIStoppedThread = { link = "AthensBlue" }, --[[fix]]
    DapUIThread = { link = "AthensBlue" }, --[[fix]]
    DapUIType = { link = "AthensOrange" }, --[[fix]]
    DapUIUnavailable = { link = "AthensGray" }, --[[fix]]
    DapUIWatchesEmpty = { link = "AthensGray" }, --[[fix]]
    DapUIWatchesError = { link = "AthensRed" }, --[[fix]]
    DapUIWatchesValue = { link = "AthensYellow" }, --[[fix]]
    DapUIWinSelect = { link = "AthensYellow" }, --[[fix]]
    NeogitDiffDelete = { link = "DiffDelete" }, --[[fix]]
    NeogitDiffAdd = { link = "DiffAdd" }, --[[fix]]
    NeogitHunkHeader = { link = "WinBar" }, --[[fix]]
    NeogitHunkHeaderHighlight = { link = "WinBarNC" }, --[[fix]]
    DiffviewStatusModified = { link = "AthensGreenBold" }, --[[fix]]
    DiffviewFilePanelInsertions = { link = "AthensGreenBold" }, --[[fix]]
    DiffviewFilePanelDeletions = { link = "AthensRedBold" }, --[[fix]]
    MiniAnimateCursor = { reverse = true, nocombine = true }, --[[fix]]
    MiniAnimateNormalFloat = { fg = colors.fg1, bg = colors.bg1 }, --[[fix]]
    MiniClueBorder = { link = "FloatBorder" }, --[[fix]]
    MiniClueDescGroup = { link = "DiagnosticFloatingWarn" }, --[[fix]]
    MiniClueDescSingle = { link = "NormalFloat" }, --[[fix]]
    MiniClueNextKey = { link = "DiagnosticFloatingHint" }, --[[fix]]
    MiniClueNextKeyWithPostkeys = { link = "DiagnosticFloatingError" }, --[[fix]]
    MiniClueSeparator = { link = "DiagnosticFloatingInfo" }, --[[fix]]
    MiniClueTitle = { link = "FloatTitle" }, --[[fix]]
    MiniCompletionActiveParameter = { underline = true }, --[[fix]]
    MiniCursorword = { underline = true }, --[[fix]]
    MiniCursorwordCurrent = { underline = true }, --[[fix]]
    MiniDepsChangeAdded = { link = "AthensGreen" }, --[[fix]]
    MiniDepsChangeRemoved = { link = "AthensRed" }, --[[fix]]
    MiniDepsHint = { link = "DiagnosticHint" }, --[[fix]]
    MiniDepsInfo = { link = "DiagnosticInfo" }, --[[fix]]
    MiniDepsMsgBreaking = { link = "DiagnosticWarn" }, --[[fix]]
    MiniDepsPlaceholder = { link = "Comment" }, --[[fix]]
    MiniDepsTitle = { link = "Title" }, --[[fix]]
    MiniDepsTitleError = { link = "DiffDelete" }, --[[fix]]
    MiniDepsTitleSame = { link = "DiffChange" }, --[[fix]]
    MiniDepsTitleUpdate = { link = "DiffAdd" }, --[[fix]]
    MiniDiffOverAdd = { link = "DiffAdd" }, --[[fix]]
    MiniDiffOverChange = { link = "DiffText" }, --[[fix]]
    MiniDiffOverContext = { link = "DiffChange" }, --[[fix]]
    MiniDiffOverDelete = { link = "DiffDelete" }, --[[fix]]
    MiniDiffSignAdd = { link = "AthensGreen" }, --[[fix]]
    MiniDiffSignChange = { link = "AthensAqua" }, --[[fix]]
    MiniDiffSignDelete = { link = "AthensRed" }, --[[fix]]
    MiniFilesBorder = { link = "FloatBorder" }, --[[fix]]
    MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" }, --[[fix]]
    MiniFilesCursorLine = { bg = colors.bg2 }, --[[fix]]
    MiniFilesDirectory = { link = "Directory" }, --[[fix]]
    MiniFilesFile = { link = "AthensFg1" }, --[[fix]]
    MiniFilesNormal = { link = "NormalFloat" }, --[[fix]]
    MiniFilesTitle = { link = "FloatTitle" }, --[[fix]]
    MiniFilesTitleFocused = { link = "AthensOrangeBold" }, --[[fix]]
    MiniHipatternsFixme = { fg = colors.bg0, bg = colors.red, bold = config.bold }, --[[fix]]
    MiniHipatternsHack = { fg = colors.bg0, bg = colors.yellow, bold = config.bold }, --[[fix]]
    MiniHipatternsNote = { fg = colors.bg0, bg = colors.blue, bold = config.bold }, --[[fix]]
    MiniHipatternsTodo = { fg = colors.bg0, bg = colors.aqua, bold = config.bold }, --[[fix]]
    MiniIconsAzure = { link = "AthensBlue" }, --[[fix]]
    MiniIconsBlue = { link = "AthensBlue" }, --[[fix]]
    MiniIconsCyan = { link = "AthensAqua" }, --[[fix]]
    MiniIconsGreen = { link = "AthensGreen" }, --[[fix]]
    MiniIconsGrey = { link = "AthensFg0" }, --[[fix]]
    MiniIconsOrange = { link = "AthensOrange" }, --[[fix]]
    MiniIconsPurple = { link = "AthensPurple" }, --[[fix]]
    MiniIconsRed = { link = "AthensRed" }, --[[fix]]
    MiniIconsYellow = { link = "AthensYellow" }, --[[fix]]
    MiniIndentscopeSymbol = { link = "AthensGray" }, --[[fix]]
    MiniIndentscopeSymbolOff = { link = "AthensYellow" }, --[[fix]]
    MiniJump = { link = "AthensOrangeUnderline" }, --[[fix]]
    MiniJump2dDim = { link = "AthensGray" }, --[[fix]]
    MiniJump2dSpot = { fg = colors.orange, bold = config.bold, nocombine = true }, --[[fix]]
    MiniJump2dSpotAhead = { fg = colors.aqua, bg = colors.bg0, nocombine = true }, --[[fix]]
    MiniJump2dSpotUnique = { fg = colors.yellow, bold = config.bold, nocombine = true }, --[[fix]]
    MiniMapNormal = { link = "NormalFloat" }, --[[fix]]
    MiniMapSymbolCount = { link = "Special" }, --[[fix]]
    MiniMapSymbolLine = { link = "Title" }, --[[fix]]
    MiniMapSymbolView = { link = "Delimiter" }, --[[fix]]
    MiniNotifyBorder = { link = "FloatBorder" }, --[[fix]]
    MiniNotifyNormal = { link = "NormalFloat" }, --[[fix]]
    MiniNotifyTitle = { link = "FloatTitle" }, --[[fix]]
    MiniOperatorsExchangeFrom = { link = "IncSearch" }, --[[fix]]
    MiniPickBorder = { link = "FloatBorder" }, --[[fix]]
    MiniPickBorderBusy = { link = "DiagnosticFloatingWarn" }, --[[fix]]
    MiniPickBorderText = { link = "FloatTitle" }, --[[fix]]
    MiniPickIconDirectory = { link = "Directory" }, --[[fix]]
    MiniPickIconFile = { link = "MiniPickNormal" }, --[[fix]]
    MiniPickHeader = { link = "DiagnosticFloatingHint" }, --[[fix]]
    MiniPickMatchCurrent = { bg = colors.bg2 }, --[[fix]]
    MiniPickMatchMarked = { link = "Visual" }, --[[fix]]
    MiniPickMatchRanges = { link = "DiagnosticFloatingHint" }, --[[fix]]
    MiniPickNormal = { link = "NormalFloat" }, --[[fix]]
    MiniPickPreviewLine = { link = "CursorLine" }, --[[fix]]
    MiniPickPreviewRegion = { link = "IncSearch" }, --[[fix]]
    MiniPickPrompt = { link = "DiagnosticFloatingInfo" }, --[[fix]]
    MiniStarterCurrent = { nocombine = true }, --[[fix]]
    MiniStarterFooter = { link = "AthensGray" }, --[[fix]]
    MiniStarterHeader = { link = "Title" }, --[[fix]]
    MiniStarterInactive = { link = "Comment" }, --[[fix]]
    MiniStarterItem = { link = "Normal" }, --[[fix]]
    MiniStarterItemBullet = { link = "Delimiter" }, --[[fix]]
    MiniStarterItemPrefix = { link = "WarningMsg" }, --[[fix]]
    MiniStarterSection = { link = "Delimiter" }, --[[fix]]
    MiniStarterQuery = { link = "MoreMsg" }, --[[fix]]
    MiniStatuslineDevinfo = { link = "StatusLine" }, --[[fix]]
    MiniStatuslineFileinfo = { link = "StatusLine" }, --[[fix]]
    MiniStatuslineFilename = { link = "StatusLineNC" }, --[[fix]]
    MiniStatuslineInactive = { link = "StatusLineNC" }, --[[fix]]
    MiniStatuslineModeCommand = { fg = colors.bg0, bg = colors.yellow, bold = config.bold }, --[[fix]]
    MiniStatuslineModeInsert = { fg = colors.bg0, bg = colors.blue, bold = config.bold }, --[[fix]]
    MiniStatuslineModeNormal = { fg = colors.bg0, bg = colors.fg1, bold = config.bold }, --[[fix]]
    MiniStatuslineModeOther = { fg = colors.bg0, bg = colors.aqua, bold = config.bold }, --[[fix]]
    MiniStatuslineModeReplace = { fg = colors.bg0, bg = colors.red, bold = config.bold }, --[[fix]]
    MiniStatuslineModeVisual = { fg = colors.bg0, bg = colors.green, bold = config.bold }, --[[fix]]
    MiniSurround = { link = "IncSearch" }, --[[fix]]
    MiniTablineCurrent = { fg = colors.green, bg = colors.bg1, bold = config.bold, reverse = config.invert_tabline }, --[[fix]]
    MiniTablineFill = { link = "TabLineFill" }, --[[fix]]
    MiniTablineHidden = { fg = colors.bg4, bg = colors.bg1, reverse = config.invert_tabline }, --[[fix]]
    MiniTablineModifiedCurrent = { --[[fix]]
      fg = colors.bg1, --[[fix]]
      bg = colors.green, --[[fix]]
      bold = config.bold, --[[fix]]
      reverse = config.invert_tabline, --[[fix]]
    }, --[[fix]]
    MiniTablineModifiedHidden = { fg = colors.bg1, bg = colors.bg4, reverse = config.invert_tabline }, --[[fix]]
    MiniTablineModifiedVisible = { fg = colors.bg1, bg = colors.fg1, reverse = config.invert_tabline }, --[[fix]]
    MiniTablineTabpagesection = { link = "Search" }, --[[fix]]
    MiniTablineVisible = { fg = colors.fg1, bg = colors.bg1, reverse = config.invert_tabline }, --[[fix]]
    MiniTestEmphasis = { bold = config.bold }, --[[fix]]
    MiniTestFail = { link = "AthensRedBold" }, --[[fix]]
    MiniTestPass = { link = "AthensGreenBold" }, --[[fix]]
    MiniTrailspace = { bg = colors.red }, --[[fix]]
    ["@comment"] = { link = "Comment" }, --[[fix]]
    ["@none"] = { bg = "NONE", fg = "NONE" }, --[[fix]]
    ["@preproc"] = { link = "PreProc" }, --[[fix]]
    ["@define"] = { link = "Define" }, --[[fix]]
    ["@operator"] = { link = "Operator" }, --[[fix]]
    ["@punctuation.delimiter"] = { link = "Delimiter" }, --[[fix]]
    ["@punctuation.bracket"] = { link = "Delimiter" }, --[[fix]]
    ["@punctuation.special"] = { link = "Delimiter" }, --[[fix]]
    ["@string"] = { link = "String" },
    ["@string.regex"] = { link = "String" },
    ["@string.regexp"] = { link = "String" },
    ["@string.escape"] = { link = "String" },
    ["@string.special"] = { link = "SpecialChar" }, --[[fix]]
    ["@string.special.path"] = { link = "Underlined" }, --[[fix]]
    ["@string.special.symbol"] = { link = "Identifier" }, --[[fix]]
    ["@string.special.url"] = { link = "Underlined" }, --[[fix]]
    ["@character"] = { link = "Character" }, --[[fix]]
    ["@character.special"] = { link = "SpecialChar" }, --[[fix]]
    ["@boolean"] = { link = "Boolean" }, --[[fix]]
    ["@number"] = { link = "Number" }, --[[fix]]
    ["@number.float"] = { link = "Float" }, --[[fix]]
    ["@float"] = { link = "Float" }, --[[fix]]
    ["@function"] = { link = "Function" }, --[[fix]]
    ["@function.builtin"] = { link = "Special" }, --[[fix]]
    ["@function.call"] = { link = "AthensText" },
    ["@function.macro"] = { link = "Macro" }, --[[fix]]
    ["@function.method"] = { link = "AthensText" },
    ["@method"] = { link = "Function" }, --[[fix]]
    ["@method.call"] = { link = "AthensText" },
    ["@constructor"] = { link = "AthensText" },
    ["@parameter"] = { link = "Identifier" }, --[[fix]]
    ["@keyword"] = { link = "AthensKeyword" }, --[[fix]]
    ["@keyword.conditional"] = { link = "Conditional" }, --[[fix]]
    ["@keyword.debug"] = { link = "Debug" }, --[[fix]]
    ["@keyword.directive"] = { link = "PreProc" }, --[[fix]]
    ["@keyword.directive.define"] = { link = "Define" }, --[[fix]]
    ["@keyword.exception"] = { link = "Exception" }, --[[fix]]
    ["@keyword.function"] = { link = "AthensKeyword" }, --[[fix]]
    ["@keyword.import"] = { link = "Include" }, --[[fix]]
    ["@keyword.operator"] = { link = "AthensKeyword" },
    ["@keyword.repeat"] = { link = "AthensKeyword" },
    ["@keyword.return"] = { link = "AthensKeyword" },
    ["@keyword.storage"] = { link = "StorageClass" }, --[[fix]]
    ["@conditional"] = { link = "Conditional" }, --[[fix]]
    ["@repeat"] = { link = "Repeat" }, --[[fix]]
    ["@debug"] = { link = "Debug" }, --[[fix]]
    ["@label"] = { link = "Label" }, --[[fix]]
    ["@include"] = { link = "Include" }, --[[fix]]
    ["@exception"] = { link = "Exception" }, --[[fix]]
    ["@type"] = { link = "Type" }, --[[fix]]
    ["@type.builtin"] = { link = "Type" }, --[[fix]]
    ["@type.definition"] = { link = "Typedef" }, --[[fix]]
    ["@type.qualifier"] = { link = "Type" }, --[[fix]]
    ["@storageclass"] = { link = "StorageClass" }, --[[fix]]
    ["@attribute"] = { link = "PreProc" }, --[[fix]]
    ["@field"] = { link = "Identifier" }, --[[fix]]
    ["@property"] = { link = "AthensText" },
    ["@variable"] = { link = "AthensFg1" }, --[[fix]]
    ["@variable.builtin"] = { link = "Special" }, --[[fix]]
    ["@variable.member"] = { link = "Identifier" }, --[[fix]]
    ["@variable.parameter"] = { link = "Identifier" }, --[[fix]]
    ["@constant"] = { link = "Constant" }, --[[fix]]
    ["@constant.builtin"] = { link = "AthensConstant" },
    ["@constant.macro"] = { link = "Define" }, --[[fix]]
    ["@markup"] = { link = "AthensFg1" }, --[[fix]]
    ["@markup.strong"] = { bold = config.bold }, --[[fix]]
    ["@markup.italic"] = { link = "@text.emphasis" }, --[[fix]]
    ["@markup.underline"] = { underline = config.underline }, --[[fix]]
    ["@markup.strikethrough"] = { strikethrough = config.strikethrough }, --[[fix]]
    ["@markup.heading"] = { link = "Title" }, --[[fix]]
    ["@markup.raw"] = { link = "String" }, --[[fix]]
    ["@markup.math"] = { link = "Special" }, --[[fix]]
    ["@markup.environment"] = { link = "Macro" }, --[[fix]]
    ["@markup.environment.name"] = { link = "Type" }, --[[fix]]
    ["@markup.link"] = { link = "Underlined" }, --[[fix]]
    ["@markup.link.label"] = { link = "SpecialChar" }, --[[fix]]
    ["@markup.list"] = { link = "Delimiter" }, --[[fix]]
    ["@markup.list.checked"] = { link = "AthensGreen" }, --[[fix]]
    ["@markup.list.unchecked"] = { link = "AthensGray" }, --[[fix]]
    ["@comment.todo"] = { link = "Todo" }, --[[fix]]
    ["@comment.note"] = { link = "SpecialComment" }, --[[fix]]
    ["@comment.warning"] = { link = "WarningMsg" }, --[[fix]]
    ["@comment.error"] = { link = "ErrorMsg" }, --[[fix]]
    ["@diff.plus"] = { link = "diffAdded" }, --[[fix]]
    ["@diff.minus"] = { link = "diffRemoved" }, --[[fix]]
    ["@diff.delta"] = { link = "diffChanged" }, --[[fix]]
    ["@module"] = { link = "AthensFg1" }, --[[fix]]
    ["@namespace"] = { link = "AthensFg1" }, --[[fix]]
    ["@symbol"] = { link = "Identifier" }, --[[fix]]
    ["@text"] = { link = "AthensFg1" }, --[[fix]]
    ["@text.strong"] = { bold = config.bold }, --[[fix]]
    ["@text.emphasis"] = { italic = config.italic.emphasis }, --[[fix]]
    ["@text.underline"] = { underline = config.underline }, --[[fix]]
    ["@text.strike"] = { strikethrough = config.strikethrough }, --[[fix]]
    ["@text.title"] = { link = "Title" }, --[[fix]]
    ["@text.literal"] = { link = "String" }, --[[fix]]
    ["@text.uri"] = { link = "Underlined" }, --[[fix]]
    ["@text.math"] = { link = "Special" }, --[[fix]]
    ["@text.environment"] = { link = "Macro" }, --[[fix]]
    ["@text.environment.name"] = { link = "Type" }, --[[fix]]
    ["@text.reference"] = { link = "Constant" }, --[[fix]]
    ["@text.todo"] = { link = "Todo" }, --[[fix]]
    ["@text.todo.checked"] = { link = "AthensGreen" }, --[[fix]]
    ["@text.todo.unchecked"] = { link = "AthensGray" }, --[[fix]]
    ["@text.note"] = { link = "SpecialComment" }, --[[fix]]
    ["@text.note.comment"] = { fg = colors.purple, bold = config.bold }, --[[fix]]
    ["@text.warning"] = { link = "WarningMsg" }, --[[fix]]
    ["@text.danger"] = { link = "ErrorMsg" }, --[[fix]]
    ["@text.danger.comment"] = { fg = colors.fg0, bg = colors.red, bold = config.bold }, --[[fix]]
    ["@text.diff.add"] = { link = "diffAdded" }, --[[fix]]
    ["@text.diff.delete"] = { link = "diffRemoved" }, --[[fix]]
    ["@tag"] = { link = "Tag" }, --[[fix]]
    ["@tag.attribute"] = { link = "Identifier" }, --[[fix]]
    ["@tag.delimiter"] = { link = "Delimiter" }, --[[fix]]
    ["@punctuation"] = { link = "Delimiter" }, --[[fix]]
    ["@macro"] = { link = "Macro" }, --[[fix]]
    ["@Structure"] = { link = "Structure" }, --[[fix]]
    ["@lsp.type.class"] = { link = "@type" }, --[[fix]]
    ["@lsp.type.comment"] = { link = "@comment" }, --[[fix]]
    ["@lsp.type.decorator"] = { link = "@macro" }, --[[fix]]
    ["@lsp.type.enum"] = { link = "@type" }, --[[fix]]
    ["@lsp.type.enumMember"] = { link = "@constant" }, --[[fix]]
    ["@lsp.type.function"] = { link = "@function" }, --[[fix]]
    ["@lsp.type.interface"] = { link = "@constructor" }, --[[fix]]
    ["@lsp.type.macro"] = { link = "@macro" }, --[[fix]]
    ["@lsp.type.method"] = { link = "@method" }, --[[fix]]
    ["@lsp.type.namespace"] = { link = "@namespace" }, --[[fix]]
    ["@lsp.type.parameter"] = { link = "@parameter" }, --[[fix]]
    ["@lsp.type.property"] = { link = "@property" }, --[[fix]]
    ["@lsp.type.struct"] = { link = "@type" }, --[[fix]]
    ["@lsp.type.type"] = { link = "@type" }, --[[fix]]
    ["@lsp.type.typeParameter"] = { link = "@type.definition" }, --[[fix]]
    ["@lsp.type.variable"] = { link = "@variable" }, --[[fix]]
  }

  for group, hl in pairs(config.overrides) do
    if groups[group] then
      -- "link" should not mix with other configs (:h hi-link)
      groups[group].link = nil
    end

    groups[group] = vim.tbl_extend("force", groups[group] or {}, hl)
  end

  return groups
end

---@param config AthensConfig?
Athens.setup = function(config)
  Athens.config = vim.tbl_deep_extend("force", Athens.config, config or {})
end

--- main load function
Athens.load = function()
  if vim.version().minor < 8 then
    vim.notify_once("athens.nvim: you must use neovim 0.8 or higher")
    return
  end

  -- reset colors
  if vim.g.colors_name then
    vim.cmd.hi("clear")
  end
  vim.g.colors_name = "athens"
  vim.o.termguicolors = true

  local groups = get_groups()

  -- add highlights
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return Athens
