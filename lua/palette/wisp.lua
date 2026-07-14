-- Nightshade with faint washes behind data: strings, symbols, and ivars
-- sit on tinted panels instead of relying on ink color alone.
local nightshade = require("palette.nightshade")

return vim.tbl_extend("force", {}, nightshade, {
  name = "wisp",
  wash = {
    string = "#3a4231",
    symbol = "#333d48",
    member = "#35423e",
  },
})
