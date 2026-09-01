-- Lualine theme generated from the nightshade palette: mode accents come
-- straight from palette/nightshade.lua; the grays are new, darker steps in
-- the same neutral hue (the palette's own floor is the #303030 editor bg,
-- and the statusline sits below it, iceberg-dark style).
local p = require("palette.nightshade")

local ink = "#1c1c1c" -- text on accent sections
local well = "#1e1e1e" -- section c: darkest, recedes furthest
local shelf = "#262626" -- section b: between well and editor bg

local function mode(accent)
	return {
		a = { fg = ink, bg = accent, gui = "bold" },
		b = { fg = p.foreground, bg = shelf },
		c = { fg = p.comment, bg = well },
	}
end

return {
	normal = mode(p.blue),
	insert = mode(p.green),
	visual = mode(p.purple),
	replace = mode(p.red),
	command = mode(p.yellow),
	terminal = mode(p.aqua),
	inactive = {
		a = { fg = p.window, bg = well },
		b = { fg = p.window, bg = well },
		c = { fg = p.window, bg = well },
	},
}
