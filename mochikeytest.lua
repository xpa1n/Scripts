--[[
	Mochi Key System for Roblox (v1.0)
	Ported from the web preview in "MOCHI UI/Key System".

	local MochiKey = loadstring(game:HttpGet("<url>"))()
	MochiKey:Init({
		Title = "Mochi Hub",
		Theme = "Mochi", -- Mochi, Sakura, Matcha, Ube, Hojicha or Yuzu
		KeyLink = "https://example.com/get-key",
		Discord = "discord.gg/example",
		Blur = 16,
		Validate = function(key) return { Valid = true, Premium = false, ExpiresIn = 3600 } end,
		OnSuccess = function(info) end,
		OnClose = function() end,
	})

	Validate gets the key in caps and returns { Valid, Premium, ExpiresIn, Reason }.
	Reason is "Expired" or "Invalid". ExpiresIn is the seconds left on a free key.
	A valid key is saved to "<Title>/key.txt" (spaces removed from the title). Next run
	it gets checked again, and if it's still good the screen is skipped and OnSuccess
	runs straight away. If the hub saves its theme name to "<Title>/theme.txt", this
	screen uses that theme.

	Everything is drawn with Frames, UICorner, UIStroke, UIGradient and TweenService.
	The game behind is blurred with a BlurEffect in Lighting. Nothing blurs GUI.
]]

local MochiKey = { Version = "1.5" }

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")

-- Executor functions. Any of them can be missing, so everything checks first.
local function fnOrNil(f)
	if typeof(f) == "function" then return f end
	return nil
end
local X = {
	gethui = fnOrNil(gethui),
	isfile = fnOrNil(isfile),
	isfolder = fnOrNil(isfolder),
	readfile = fnOrNil(readfile),
	writefile = fnOrNil(writefile),
	makefolder = fnOrNil(makefolder),
	delfile = fnOrNil(delfile),
	setclipboard = fnOrNil(setclipboard) or fnOrNil(toclipboard),
	-- Opening a browser: only some executors have this, under different names
	openurl = fnOrNil(openurl) or fnOrNil(open_url) or fnOrNil(OpenURL)
		or (type(syn) == "table" and fnOrNil(syn.open_url)) or nil,
}

------------------------------------------------------------------------
-- Text
------------------------------------------------------------------------

-- What the mochi says. {title} becomes the hub name.
local SAY = {
	hello = "Hiii~ I'm Mochi! Bring me a key and I'll open the script just for you!",
	get = "Go grab a key, okay? I'll wait right here~",
	empty = "Hehe, you forgot the key, silly!",
	checking = "Ooh, a key! Lemme take a peek…",
	invalid = "Aww, that key doesn't fit… wanna try again?",
	expired = "Oh no, this key fell asleep! Grab a fresh one~",
	ok = "Yaaay, it fits! Come on in~",
	help = "Don't worry! My friends on Discord will help you~",
}

local STEPS = {
	{ "Copy the key link", "Open it in your browser" },
	{ "Pass one checkpoint", "Your key shows up after" },
	{ "Paste your key", "Then press the arrow" },
}

local HINT = "Your key is saved, so you only enter it once."

------------------------------------------------------------------------
-- Themes (same tokens as mochi.css and keysystem.css)
------------------------------------------------------------------------

local THEMES = {
	Mochi = {
		bg = "#15111e", el = "#1f1a2c", elTop = "#251f34", elHover = "#2a2339", input = "#120e1a",
		ss = { 255, 255, 255, 0.11 },
		text = "#f7f1ff", sub = "#aca3c4", faint = "#6f6788",
		acc1 = "#ff8fcf", acc2 = "#a78bfa", knob = "#fff6fb", leaf = "#6ee7c8", glow = "#ff8fcf",
		ok = "#5fd3a0", warn = "#f5c15a", bad = "#ff6b86",
		btn1 = "#e4579f", btn2 = "#8f6ef0",
	},
	Sakura = {
		bg = "#fff7fa", el = "#ffffff", elTop = "#ffffff", elHover = "#fff5f9", input = "#fff2f7",
		ss = { 214, 90, 150, 0.22 },
		text = "#3b2333", sub = "#8a6578", faint = "#b996a9",
		acc1 = "#f0609f", acc2 = "#f78fc0", knob = "#ffffff", leaf = "#6fbf7f", glow = "#ff9fca",
		ok = "#1f9d6b", warn = "#c98a0b", bad = "#d6334f",
		btn1 = "#e04890", btn2 = "#ec6aa6", accText = "#d63e84", light = true,
	},
	Matcha = {
		bg = "#121813", el = "#1a231c", elTop = "#1f2a21", elHover = "#233026", input = "#0d120e",
		ss = { 210, 255, 210, 0.11 },
		text = "#eef6ea", sub = "#9db39a", faint = "#62775f",
		acc1 = "#a6dd9c", acc2 = "#e3f0a0", knob = "#f7fbef", leaf = "#a6dd9c", glow = "#a6dd9c",
		ok = "#7fe0a8", warn = "#f0cf6a", bad = "#ff7d8f",
		btn1 = "#4b9455", btn2 = "#74a03c",
	},
	Ube = {
		bg = "#170e25", el = "#22163a", elTop = "#281a43", elHover = "#2d1f4a", input = "#120a1e",
		ss = { 210, 180, 255, 0.13 },
		text = "#f3ecff", sub = "#b3a3cf", faint = "#776992",
		acc1 = "#d4b3ff", acc2 = "#9b7bff", knob = "#f8f2ff", leaf = "#d4b3ff", glow = "#9b7bff",
		ok = "#6fe0b0", warn = "#f5c76a", bad = "#ff7b96",
		btn1 = "#9a6cf0", btn2 = "#6e4fe0",
	},
	Hojicha = {
		bg = "#1a1411", el = "#241c17", elTop = "#2a211b", elHover = "#2e241e", input = "#130e0b",
		ss = { 255, 220, 190, 0.11 },
		text = "#f8eee6", sub = "#bba796", faint = "#7d6b5e",
		acc1 = "#f0b07c", acc2 = "#f8d9a8", knob = "#fff7ee", leaf = "#9bc48a", glow = "#f0b07c",
		ok = "#8fd6a0", warn = "#f5c86a", bad = "#ff8a80",
		btn1 = "#c06f38", btn2 = "#cf8a4c",
	},
	Yuzu = {
		bg = "#fffbef", el = "#ffffff", elTop = "#ffffff", elHover = "#fffaeb", input = "#fff8e6",
		ss = { 200, 150, 30, 0.27 },
		text = "#3a2f12", sub = "#85744a", faint = "#b5a67c",
		acc1 = "#f5b324", acc2 = "#ffd66b", knob = "#ffffff", leaf = "#8cc46a", glow = "#ffd66b",
		ok = "#1f9d6b", warn = "#b87700", bad = "#d6334f",
		btn1 = "#b87000", btn2 = "#cf8c00", accText = "#a86e00", light = true,
	},
}

local WHITE = Color3.new(1, 1, 1)
local BLACK = Color3.new(0, 0, 0)

local function hex(s)
	s = s:gsub("#", "")
	return Color3.fromRGB(tonumber(s:sub(1, 2), 16), tonumber(s:sub(3, 4), 16), tonumber(s:sub(5, 6), 16))
end

-- Same as CSS color-mix(in srgb, a p, b) for solid colours
local function mix(a, p, b)
	return b:Lerp(a, p)
end

-- color-mix of two see-through colours. Returns the colour and its opacity.
local function amix(c1, a1, p, c2, a2)
	local a = a1 * p + a2 * (1 - p)
	if a <= 0 then return c1, 0 end
	local w1, w2 = a1 * p / a, a2 * (1 - p) / a
	return Color3.new(c1.R * w1 + c2.R * w2, c1.G * w1 + c2.G * w2, c1.B * w1 + c2.B * w2), a
end

local function buildTheme(name)
	local d = THEMES[name] or THEMES.Mochi
	local T = {}
	for k, v in pairs(d) do
		if type(v) == "string" then T[k] = hex(v) end
	end
	T.ss = Color3.fromRGB(d.ss[1], d.ss[2], d.ss[3])
	T.ssA = d.ss[4]
	T.accText = d.accText and hex(d.accText) or T.acc1
	T.light = d.light == true
	T.okDeep = mix(T.ok, 0.7, hex("#0b4a35"))
	T.sayBg = mix(T.acc1, 0.13, T.elTop)
	return T
end

------------------------------------------------------------------------
-- Fonts. Fredoka One for headings, Nunito for body, Roboto Mono for keys.
------------------------------------------------------------------------

local F_HEAD = Font.new("rbxasset://fonts/families/FredokaOne.json")
local F_BODY = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold)
local F_BODY_X = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.ExtraBold)
local F_MONO = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold)
local F_MONO_SEMI = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Medium)

------------------------------------------------------------------------
-- Small helpers
------------------------------------------------------------------------

local C = Vector2.new(0.5, 0.5)
local SMOOTH = 0.02 -- degrees; a rotation this small can't be seen but stops pixel snapping
local FULL = UDim.new(1, 0)
local OUT = Enum.EasingDirection.Out
local INOUT = Enum.EasingDirection.InOut
local QUART = Enum.EasingStyle.Quart -- close to the preview's --ease curve
local BACK = Enum.EasingStyle.Back -- close to --spring
local SINE = Enum.EasingStyle.Sine
local LINEAR = Enum.EasingStyle.Linear
local LEFT = Enum.TextXAlignment.Left
local AUTO_X = Enum.AutomaticSize.X

local function trim(s)
	return (tostring(s or ""):match("^%s*(.-)%s*$"))
end

local function log(...)
	print("[MochiKey]", ...)
end

-- User callbacks run in their own thread with no pcall around them. Some executors'
-- pcall can't yield (HttpGet yields), and this way any error prints with a stack trace.
local function safeCall(f, ...)
	if type(f) == "function" then task.spawn(f, ...) end
end

-- Runs f in its own thread and waits for it to finish, so f can yield anywhere.
-- Returns ok, result. If f errors, Roblox prints the error and ok is false.
local function callAndWait(f, ...)
	local args = table.pack(...)
	local state = { done = false }
	local thread = task.spawn(function()
		state.result = f(table.unpack(args, 1, args.n))
		state.done = true
	end)
	while not state.done and coroutine.status(thread) ~= "dead" do
		task.wait()
	end
	return state.done, state.result
end

local function make(class, props)
	local o = Instance.new(class)
	if o:IsA("GuiObject") then o.BorderSizePixel = 0 end
	local parent = nil
	for k, v in pairs(props) do
		if k == "Parent" then parent = v else o[k] = v end
	end
	if parent then o.Parent = parent end
	return o
end

local function frame(parent, props)
	props = props or {}
	if props.BackgroundTransparency == nil then props.BackgroundTransparency = 1 end
	props.Parent = parent
	return make("Frame", props)
end

local function box(parent, color, props)
	props = props or {}
	props.BackgroundColor3 = color
	if props.BackgroundTransparency == nil then props.BackgroundTransparency = 0 end
	return frame(parent, props)
end

-- Nunito and Roboto Mono render about 15% smaller in Roblox than the same size in a
-- browser (Fredoka matches), so their sizes are scaled up. Sizes in the code are the CSS ones.
local BODY_K = 1.18
local function textSize(font, size)
	if font and font.Family:find("Fredoka") then return size end
	return size * BODY_K
end

local function label(parent, props)
	if props.BackgroundTransparency == nil then props.BackgroundTransparency = 1 end
	if props.FontFace == nil then props.FontFace = F_BODY end
	props.TextSize = textSize(props.FontFace, props.TextSize or 14)
	if props.Text == nil then props.Text = "" end
	props.Parent = parent
	return make("TextLabel", props)
end

local function button(parent, props)
	if props.BackgroundTransparency == nil then props.BackgroundTransparency = 1 end
	props.Text = props.Text or ""
	props.AutoButtonColor = false
	if props.TextSize then props.TextSize = textSize(props.FontFace or F_BODY, props.TextSize) end
	props.Parent = parent
	return make("TextButton", props)
end

local function corner(o, r)
	local u = r
	if typeof(r) ~= "UDim" then u = UDim.new(0, r or 0) end
	return make("UICorner", { CornerRadius = u, Parent = o })
end

local function stroke(o, color, alpha, thickness)
	return make("UIStroke", {
		Color = color,
		Transparency = 1 - (alpha or 1),
		Thickness = thickness or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Round,
		Parent = o,
	})
end

-- The CSS buttons use linear-gradient(135deg, btn1, btn2), which is Rotation 45 here
local function gradient(o, c1, c2, rot)
	return make("UIGradient", { Color = ColorSequence.new(c1, c2), Rotation = rot or 45, Parent = o })
end

local function tw(o, t, props, style, dir, delay)
	if not t or t <= 0 then
		for k, v in pairs(props) do o[k] = v end
		return nil
	end
	local tween = TweenService:Create(o, TweenInfo.new(t, style or QUART, dir or OUT, 0, false, delay or 0), props)
	tween:Play()
	return tween
end

-- Runs fn(eased 0..1) every frame for dur seconds. Set handle.stopped to stop it.
local function anim(dur, fn, style, dir, delay)
	local h = { stopped = false }
	task.spawn(function()
		if delay and delay > 0 then task.wait(delay) end
		if h.stopped then return end
		local start = os.clock()
		while not h.stopped do
			local p = math.clamp((os.clock() - start) / dur, 0, 1)
			fn(TweenService:GetValue(p, style or QUART, dir or OUT))
			if p >= 1 then break end
			RunService.RenderStepped:Wait()
		end
	end)
	return h
end

-- Keyframes: a list of { time, props, style, dir } played one after another.
-- A new sequence with the same key on the same object cancels the old one.
local seqTokens = setmetatable({}, { __mode = "k" })
local function seq(o, steps, key)
	key = key or "main"
	local slot = seqTokens[o]
	if not slot then
		slot = {}
		seqTokens[o] = slot
	end
	local token = {}
	slot[key] = token
	task.spawn(function()
		for _, s in ipairs(steps) do
			if slot[key] ~= token then return end
			if next(s[2]) ~= nil then tw(o, s[1], s[2], s[3] or SINE, s[4] or INOUT) end
			task.wait(s[1])
		end
		if slot[key] == token then slot[key] = nil end
	end)
end

-- Fading a group: remember every transparency under root, then scale them by alpha
local function capture(root, includeRoot)
	local list = {}
	local function add(o)
		if o:IsA("GuiObject") then
			list[#list + 1] = { o, "BackgroundTransparency", o.BackgroundTransparency }
			if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
				list[#list + 1] = { o, "TextTransparency", o.TextTransparency }
			elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then
				list[#list + 1] = { o, "ImageTransparency", o.ImageTransparency }
			end
		elseif o:IsA("UIStroke") then
			list[#list + 1] = { o, "Transparency", o.Transparency }
		end
	end
	if includeRoot ~= false then add(root) end
	for _, d in ipairs(root:GetDescendants()) do add(d) end
	return list
end

local function applyAlpha(list, a)
	for _, e in ipairs(list) do
		if e[3] < 1 then e[1][e[2]] = 1 - (1 - e[3]) * a end
	end
end

-- Text size in pixels. Uses the sync GetTextSize with the matching legacy font, so
-- building the screen never yields. Nunito's legacy enum is the regular weight, so
-- bold text is measured a bit wider (and wrapped a bit narrower) to stay safe.
local function legacyFont(name, fallback)
	local ok, v = pcall(function() return Enum.Font[name] end)
	if ok and v then return v end
	return fallback
end
local E_FREDOKA = legacyFont("FredokaOne", Enum.Font.GothamBold)
local E_NUNITO = legacyFont("Nunito", Enum.Font.GothamMedium)
local E_MONO = legacyFont("RobotoMono", Enum.Font.Code)

local measureCache = {}
local function measure(text, font, size, width)
	width = width or 10000
	local key = text .. "|" .. font.Family .. "|" .. tostring(font.Weight) .. "|" .. size .. "|" .. width
	local hit = measureCache[key]
	if hit then return hit end
	local enum, k = E_NUNITO, 1
	if font.Family:find("Fredoka") then
		enum = E_FREDOKA
	elseif font.Family:find("Mono") then
		enum = E_MONO
	elseif font.Weight == Enum.FontWeight.ExtraBold then
		k = 1.09
	elseif font.Weight == Enum.FontWeight.Bold then
		k = 1.05
	end
	local real = textSize(font, size) -- the size the label really uses
	local ok, v = pcall(function()
		return TextService:GetTextSize(text, math.ceil(real), enum, Vector2.new(width / k, 10000))
	end)
	if not ok then v = Vector2.new(#text * real * 0.6, real * 1.3) end
	v = Vector2.new(math.ceil(v.X * k), v.Y)
	measureCache[key] = v
	return v
end

-- Number of lines and a height for wrapped text. lh is the TextLabel.LineHeight used.
local function textBlock(text, font, size, width, lh)
	local single = measure("Ag", font, size).Y
	local b = measure(text, font, size, width)
	local lines = math.max(1, math.floor(b.Y / single + 0.5))
	return lines, math.ceil(lines * single * (lh or 1)) + 2, b.X
end

local function wave(now, period, shift)
	return 0.5 - 0.5 * math.cos(2 * math.pi * ((now + (shift or 0)) / period))
end

------------------------------------------------------------------------
-- Shapes. Icons and the mascot are drawn from Frames.
-- Coordinates are in "units" (24 for icons, 64x58 for the mascot) and
-- turn into Scale positions, so a shape follows its holder's size.
--   line  x1 y1 x2 y2 width         rounded line
--   dot   cx cy rx ry               filled oval
--   ring  cx cy r width             circle outline
--   rect  x y w h radius rot        filled rounded rect ("full" radius = pill)
--   box   x y w h radius width rot  rounded rect outline
--   arc   x1 x2 y sag width dir     curved line through (x1,y) and (x2,y), dir "up" or "down"
--   cap   x1 x2 y sag dir           filled version of arc
--   text  cx cy size string
------------------------------------------------------------------------

local function draw(holder, bx, px, shapes, color, alpha)
	alpha = alpha or 1
	local ox, oy, W, H = bx[1], bx[2], bx[3], bx[4]
	local parts = {}
	local function P(x, y)
		return UDim2.fromScale((x - ox) / W, (y - oy) / H)
	end
	local function S(w, h)
		return UDim2.fromScale(w / W, h / H)
	end
	local function thick(w)
		return math.max(w * px, 1.4)
	end
	local function solid(props, radius)
		props.BackgroundColor3 = color
		props.BackgroundTransparency = 1 - alpha
		local f = frame(holder, props)
		corner(f, radius)
		parts[#parts + 1] = { f, "BackgroundColor3" }
		return f
	end
	local function outline(props, radius, sw)
		local f = frame(holder, props)
		corner(f, radius)
		local s = stroke(f, color, alpha, thick(sw))
		parts[#parts + 1] = { s, "Color" }
		return f
	end
	for _, s in ipairs(shapes) do
		local k = s[1]
		if k == "line" then
			local x1, y1, x2, y2 = s[2], s[3], s[4], s[5]
			local w = thick(s[6]) / px
			local dx, dy = x2 - x1, y2 - y1
			local len = math.sqrt(dx * dx + dy * dy)
			solid({
				AnchorPoint = C,
				Position = P((x1 + x2) / 2, (y1 + y2) / 2),
				Size = S(len + w, w),
				Rotation = math.deg(math.atan2(dy, dx)),
			}, FULL)
		elseif k == "dot" then
			solid({ AnchorPoint = C, Position = P(s[2], s[3]), Size = S(s[4] * 2, s[5] * 2) }, FULL)
		elseif k == "ring" then
			local sw = thick(s[5]) / px
			local d = math.max(s[4] * 2 - sw, 0.1)
			outline({ AnchorPoint = C, Position = P(s[2], s[3]), Size = S(d, d) }, FULL, s[5])
		elseif k == "rect" then
			local x, y, w, h, r, rot = s[2], s[3], s[4], s[5], s[6], s[7]
			local rad = FULL
			if r ~= "full" then rad = UDim.new(0, (r or 0) * px) end
			solid({ AnchorPoint = C, Position = P(x + w / 2, y + h / 2), Size = S(w, h), Rotation = rot or 0 }, rad)
		elseif k == "box" then
			local x, y, w, h, r, sw0, rot = s[2], s[3], s[4], s[5], s[6], s[7], s[8]
			local sw = thick(sw0) / px
			outline({
				AnchorPoint = C,
				Position = P(x + w / 2, y + h / 2),
				Size = S(w - sw, h - sw),
				Rotation = rot or 0,
			}, UDim.new(0, math.max(r - sw / 2, 0) * px), sw0)
		elseif k == "arc" or k == "cap" then
			-- Part of a circle cut off at a chord. The clip frame hides the rest.
			local x1, x2, y, sag = s[2], s[3], s[4], s[5]
			local sw, dir = 0, s[6]
			if k == "arc" then
				sw = thick(s[6]) / px
				dir = s[7]
			end
			local c = x2 - x1
			local R = (c * c / 4 + sag * sag) / (2 * sag)
			local cx = (x1 + x2) / 2
			local cy, top, bottom
			if dir == "up" then
				cy, top, bottom = y - sag + R, y - sag - sw / 2, y
			else
				cy, top, bottom = y + sag - R, y, y + sag + sw / 2
			end
			local cb = { x1 - sw, top, c + sw * 2, bottom - top }
			local clip = frame(holder, { Position = P(cb[1], cb[2]), Size = S(cb[3], cb[4]), ClipsDescendants = true })
			local inner
			if k == "arc" then
				inner = draw(clip, cb, px, { { "ring", cx, cy, R, s[6] } }, color, alpha)
				-- round ends
				local ends = draw(holder, bx, px, { { "dot", x1, y, sw / 2, sw / 2 }, { "dot", x2, y, sw / 2, sw / 2 } }, color, alpha)
				for _, p in ipairs(ends) do parts[#parts + 1] = p end
			else
				inner = draw(clip, cb, px, { { "dot", cx, cy, R, R } }, color, alpha)
			end
			for _, p in ipairs(inner) do parts[#parts + 1] = p end
		elseif k == "dome" then
			-- Circle cut off flat at y = cut (only the part above shows)
			local cx, cy, r, cut = s[2], s[3], s[4], s[5]
			local cb = { cx - r, cy - r, r * 2, cut - (cy - r) }
			local clip = frame(holder, { Position = P(cb[1], cb[2]), Size = S(cb[3], cb[4]), ClipsDescendants = true })
			for _, p in ipairs(draw(clip, cb, px, { { "dot", cx, cy, r, r } }, color, alpha)) do
				parts[#parts + 1] = p
			end
		elseif k == "text" then
			local t = label(holder, {
				AnchorPoint = C,
				Position = P(s[2], s[3]),
				Size = S(s[4] * 1.3, s[4] * 1.3),
				Text = s[5],
				FontFace = F_BODY_X,
				TextSize = s[4] * px,
				TextColor3 = color,
				TextTransparency = 1 - alpha,
			})
			t.TextSize = s[4] * px -- icon glyph: exact size, no body-text scaling
			parts[#parts + 1] = { t, "TextColor3" }
		end
	end
	return parts
end

-- Lucide shapes from the preview, rebuilt as lines and circles on a 24 grid
local ICONS = {
	key = {
		{ "ring", 7.5, 15.5, 5.5, 2 },
		{ "line", 21, 2, 11.4, 11.6, 2 },
		{ "line", 15.5, 7.5, 18.5, 10.5, 2 },
		{ "line", 18.5, 10.5, 22, 7, 2 },
		{ "line", 22, 7, 19, 4, 2 },
	},
	keyFill = {
		{ "ring", 7.5, 15.5, 4.1, 3.8 },
		{ "line", 11.6, 11.4, 21, 2, 2.6 },
		{ "line", 15.5, 7.5, 18.5, 10.5, 2.6 },
		{ "line", 18.5, 4.5, 21, 7, 2.6 },
	},
	x = { { "line", 18, 6, 6, 18, 2 }, { "line", 6, 6, 18, 18, 2 } },
	check = { { "line", 20, 6, 9, 17, 2 }, { "line", 9, 17, 4, 12, 2 } },
	checkFill = { { "line", 20, 6, 9, 17, 3 }, { "line", 9, 17, 4, 12, 3 } },
	arrow = { { "line", 4.5, 12, 18.5, 12, 2.8 }, { "line", 12, 5, 19, 12, 2.8 }, { "line", 19, 12, 12, 19, 2.8 } },
	alert = {
		{ "line", 12, 3.2, 2.6, 19.6, 2 },
		{ "line", 2.6, 19.6, 21.4, 19.6, 2 },
		{ "line", 21.4, 19.6, 12, 3.2, 2 },
		{ "line", 12, 9, 12, 13, 2 },
		{ "dot", 12, 16.8, 1.15, 1.15 },
	},
	xCircle = { { "ring", 12, 12, 10, 2 }, { "line", 15, 9, 9, 15, 2 }, { "line", 9, 9, 15, 15, 2 } },
	checkCircle = { { "ring", 12, 12, 10, 2 }, { "line", 9, 12, 11, 14, 2 }, { "line", 11, 14, 15, 10, 2 } },
	clock = { { "ring", 12, 12, 10, 2 }, { "line", 12, 6, 12, 12, 2 }, { "line", 12, 12, 16, 14, 2 } },
	help = { { "ring", 12, 12, 10, 2 }, { "text", 12, 12, 13, "?" } },
	chevronLeft = { { "line", 15, 18, 9, 12, 2 }, { "line", 9, 12, 15, 6, 2 } },
	chevronRight = { { "line", 9, 18, 15, 12, 2 }, { "line", 15, 12, 9, 6, 2 } },
	clipboard = { { "box", 4, 4, 16, 18, 2, 2 }, { "box", 8, 2, 8, 4, 1, 2 } },
	clipboardFill = { { "rect", 3.5, 4, 17, 18, 2.5 }, { "rect", 8.5, 1.5, 7, 4.5, 1.2 } },
	link = { { "box", 11.5, 2.5, 7, 13, 3.5, 2.6, 45 }, { "box", 5.5, 8.5, 7, 13, 3.5, 2.6, 45 } },
	message = { { "rect", 3, 3, 18, 14, 2.5 }, { "rect", 3, 11, 5, 10, 1.5 } },
	heart = { { "dot", 7.7, 9.6, 4.7, 4.7 }, { "dot", 16.3, 9.6, 4.7, 4.7 }, { "rect", 7.1, 9.4, 9.8, 9.8, 1.5, 45 } },
}

local function Icon(parent, name, size, color, alpha)
	local f = frame(parent, { Size = UDim2.fromOffset(size, size) })
	local parts = draw(f, { 0, 0, 24, 24 }, size / 24, ICONS[name], color, alpha or 1)
	local I = { Frame = f }
	function I.SetColor(c, t)
		for _, p in ipairs(parts) do
			if t and t > 0 then
				tw(p[1], t, { [p[2]] = c })
			else
				p[1][p[2]] = c
			end
		end
	end
	return I
end

local function center(o, x, y)
	o.AnchorPoint = C
	o.Position = UDim2.new(x or 0.5, 0, y or 0.5, 0)
	return o
end

------------------------------------------------------------------------
-- The mascot (same shapes as the hub's SVG, viewBox 64x58)
------------------------------------------------------------------------

local BOX = { 0, 0, 64, 58 }
local EYE = hex("#2b1b2b")
local MOUTH_FILL = hex("#7a2b4a")
local BLUSH = hex("#ff8fbf")
local DROP = hex("#8fd0ff")

local function newMascot(parent, w, T, mood)
	local h = math.floor(w * 58 / 64 + 0.5)
	local px = w / 64
	local M = { looking = false, talking = false, mood = nil }
	local root = frame(parent, { Size = UDim2.fromOffset(w, h) })
	-- Body is anchored at the bottom so squash and stretch keep the feet planted
	local body = frame(root, { AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
	M.Root, M.Body = root, body

	draw(body, BOX, px, { { "line", 32.5, 11, 39.5, 4.5, 5.5 } }, T.leaf)
	-- The mochi shape, with no clipping so it can move smoothly (see the float in
	-- buildScreen): a wide flat pill for the squashed bottom, a big circle for the dome
	-- and two "shoulder" circles that widen the dome like the SVG's curve.
	-- Outline first (a little bigger), then the fill on top, so the shapes read as one.
	local function bodyShapes(e)
		return {
			{ "rect", 6 - e, 23 - e, 52 + e * 2, 32 + e * 2, "full" },
			{ "dot", 32, 33.25, 21.25 + e, 21.25 + e },
			{ "dot", 20, 33, 14 + e, 14 + e },
			{ "dot", 44, 33, 14 + e, 14 + e },
		}
	end
	local e = (T.light and 1.6 or 1) / 2
	draw(body, BOX, px, bodyShapes(e), T.light and T.acc1 or BLACK, T.light and 0.4 or 0.12)
	draw(body, BOX, px, bodyShapes(0), T.knob)
	draw(body, BOX, px, { { "dot", 16.5, 41.5, 4.2, 2.4 }, { "dot", 47.5, 41.5, 4.2, 2.4 } }, BLUSH, 0.75)

	local face
	local function mouthBox(b)
		local f = frame(face, {
			AnchorPoint = C,
			Position = UDim2.fromScale((b[1] + b[3] / 2) / 64, (b[2] + b[4] / 2) / 58),
			Size = UDim2.fromScale(b[3] / 64, b[4] / 58),
		})
		M.mouth, M.mouthSize = f, f.Size
		return f
	end
	local function build(m)
		if face then face:Destroy() end
		face = frame(body, { Size = UDim2.fromScale(1, 1) })
		M.eyes, M.mouth, M.look, M.blinkK = nil, nil, nil, 1
		if m == "normal" then
			local look = frame(face, { Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0, M.looking and 3 / 58 or 0) })
			M.look = look
			local eyes = draw(look, BOX, px, { { "dot", 23, 35, 2.6, 3.2 }, { "dot", 41, 35, 2.6, 3.2 } }, EYE)
			M.eyes = {}
			for _, p in ipairs(eyes) do
				M.eyes[#M.eyes + 1] = { f = p[1], size = p[1].Size }
			end
			local b = { 27, 38.5, 10, 4.5 }
			-- Curves are short lines with round ends (no clipping, see above)
			draw(mouthBox(b), b, px, {
				{ "line", 28.5, 40.5, 30.25, 41.7, 2 },
				{ "line", 30.25, 41.7, 32, 40.5, 2 },
				{ "line", 32, 40.5, 33.75, 41.7, 2 },
				{ "line", 33.75, 41.7, 35.5, 40.5, 2 },
			}, EYE)
		elseif m == "happy" then
			draw(face, BOX, px, {
				{ "line", 19.5, 36, 23, 33.6, 2 },
				{ "line", 23, 33.6, 26.5, 36, 2 },
				{ "line", 37.5, 36, 41, 33.6, 2 },
				{ "line", 41, 33.6, 44.5, 36, 2 },
			}, EYE)
			local b = { 27, 39, 10, 5 }
			-- D-shaped open smile: a pill plus a square-cornered top half
			draw(mouthBox(b), b, px, { { "rect", 28.3, 39.8, 7.4, 3.6, "full" }, { "rect", 28.3, 39.8, 7.4, 1.8, 0.4 } }, MOUTH_FILL)
		elseif m == "worried" then
			draw(face, BOX, px, {
				{ "dot", 23, 35.5, 2.4, 3 },
				{ "dot", 41, 35.5, 2.4, 3 },
				{ "line", 19, 29.5, 25.5, 27.3, 2 },
				{ "line", 45, 29.5, 38.5, 27.3, 2 },
			}, EYE)
			local b = { 29, 39.5, 6, 6 }
			draw(mouthBox(b), b, px, { { "dot", 32, 42.5, 1.9, 2.2 } }, EYE)
			draw(face, BOX, px, { { "dot", 51, 25.2, 2.3, 2.3 }, { "rect", 49.7, 20.9, 2.6, 2.6, 0.4, 45 } }, DROP)
		else -- sad
			draw(face, BOX, px, { { "dot", 23, 36, 2.4, 2.8 }, { "dot", 41, 36, 2.4, 2.8 } }, EYE)
			local b = { 27, 41, 10, 4.5 }
			draw(mouthBox(b), b, px, {
				{ "line", 28.5, 44, 30.4, 42.8, 2 },
				{ "line", 30.4, 42.8, 33.6, 42.8, 2 },
				{ "line", 33.6, 42.8, 35.5, 44, 2 },
			}, EYE)
			draw(face, BOX, px, { { "dot", 21, 44.4, 1.4, 1.4 }, { "rect", 20, 40.6, 2, 2, 0.3, 45 } }, DROP)
		end
	end

	-- mascotPop from the preview: squash, stretch, settle
	function M.Pop()
		seq(body, {
			{ 0.15, { Size = UDim2.fromScale(1.2, 0.82), Position = UDim2.fromScale(0.5, 1) } },
			{ 0.15, { Size = UDim2.fromScale(0.94, 1.08), Position = UDim2.new(0.5, 0, 1, -4) } },
			{ 0.2, { Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0.5, 1) } },
		}, "pop")
	end
	function M.SetMood(m, instant)
		if M.mood == m then return end
		M.mood = m
		build(m)
		if M.talking and M.mouth then M.talkT = os.clock() end
		if not instant then M.Pop() end
	end
	-- Eyes look down at the key box while typing
	function M.Look(on)
		M.looking = on
		if M.look then tw(M.look, 0.35, { Position = UDim2.fromScale(0, on and 3 / 58 or 0) }, BACK) end
	end
	-- Mouth moves while the bubble types
	function M.Talk(on)
		M.talking = on
		M.talkT = os.clock()
		if not on and M.mouth then M.mouth.Size = M.mouthSize end
	end
	-- Called every frame: blink every 4.6s and the talking mouth
	function M.Step(now)
		if M.eyes then
			local p = (now % 4.6) / 4.6
			local k = 1
			if p > 0.93 and p < 0.955 then
				k = 1 - 0.9 * (p - 0.93) / 0.025
			elseif p >= 0.955 then
				k = 0.1 + 0.9 * (p - 0.955) / 0.045
			end
			if k ~= M.blinkK then
				M.blinkK = k
				for _, e in ipairs(M.eyes) do
					e.f.Size = UDim2.fromScale(e.size.X.Scale, e.size.Y.Scale * k)
				end
			end
		end
		if M.talking and M.mouth then
			local k = 0.5 - 0.5 * math.cos(math.pi * (os.clock() - M.talkT) / 0.16)
			local s = M.mouthSize
			M.mouth.Size = UDim2.fromScale(s.X.Scale * (1 + 0.15 * k), s.Y.Scale * (1 + 0.9 * k))
		end
	end
	M.SetMood(mood or "normal", true)
	return M
end

-- The "drop" keyframes: falls in, squashes, bounces, settles
local function dropIn(M, delay)
	local list = capture(M.Root)
	applyAlpha(list, 0)
	local b = M.Body
	b.Size = UDim2.fromScale(0.9, 1.1)
	b.Position = UDim2.new(0.5, 0, 1, -160)
	task.delay(delay or 0, function()
		anim(0.45, function(a) applyAlpha(list, a) end, QUART)
		seq(b, {
			{ 0.45, { Size = UDim2.fromScale(1.25, 0.72), Position = UDim2.fromScale(0.5, 1) }, QUART, OUT },
			{ 0.2, { Size = UDim2.fromScale(0.92, 1.08), Position = UDim2.new(0.5, 0, 1, -14) }, QUART, OUT },
			{ 0.2, { Size = UDim2.fromScale(1.05, 0.95), Position = UDim2.fromScale(0.5, 1) }, QUART, OUT },
			{ 0.15, { Size = UDim2.fromScale(1, 1) }, QUART, OUT },
		}, "pop")
	end)
end

-- shadowIn keyframes, written into a state table the frame loop reads
local function shadowIn(st, delay)
	st.scale, st.alpha = 0.3, 0
	task.delay(delay or 0, function()
		anim(0.45, function(a)
			st.scale = 0.3 + 0.9 * a
			st.alpha = a
		end, QUART)
		task.delay(0.45, function()
			anim(0.55, function(a) st.scale = 1.2 - 0.2 * a end, QUART)
		end)
	end)
end

-- Per-ring opacities so a stack of growing circles fades linearly from maxA to 0
local function radialAlphas(n, maxA)
	local O = {}
	for j = 1, n do O[j] = maxA * (1 - (j - 0.5) / n) end
	O[n + 1] = 0
	local a = {}
	for j = 1, n do a[j] = 1 - (1 - O[j]) / (1 - O[j + 1]) end
	return a
end

------------------------------------------------------------------------
-- Files
------------------------------------------------------------------------

local function fileRead(path)
	if not (X.isfile and X.readfile) then return nil end
	local ok, res = pcall(function()
		if X.isfile(path) then return X.readfile(path) end
		return nil
	end)
	if ok and type(res) == "string" then return res end
	return nil
end

local function fileWrite(path, data)
	if not X.writefile then return false end
	return (pcall(function()
		local dir = path:match("^(.*)/[^/]+$")
		if dir and X.makefolder and not (X.isfolder and X.isfolder(dir)) then X.makefolder(dir) end
		X.writefile(path, data)
	end))
end

local function fileDelete(path)
	pcall(function()
		if X.isfile and X.isfile(path) then
			if X.delfile then X.delfile(path) elseif X.writefile then X.writefile(path, "") end
		end
	end)
end

local function clip(text)
	if not X.setclipboard then return false end
	return (pcall(X.setclipboard, text))
end

-- Tries to open a link in the player's browser. True means some way of opening it
-- ran without an error, which doesn't promise a browser actually opened.
local function openUrl(url)
	if X.openurl and pcall(X.openurl, url) then return true end
	if pcall(function() GuiService:OpenBrowserWindow(url) end) then return true end
	return false
end

local function guiParent()
	if X.gethui then
		local ok, h = pcall(X.gethui)
		if ok and typeof(h) == "Instance" then return h end
	end
	local ok, cg = pcall(function() return game:GetService("CoreGui") end)
	if ok and cg then
		local can = pcall(function()
			local f = Instance.new("Folder")
			f.Parent = cg
			f:Destroy()
		end)
		if can then return cg end
	end
	local lp = Players.LocalPlayer
	return lp and lp:WaitForChild("PlayerGui")
end

-- Calls the user's Validate and tidies what comes back. errored = it threw.
local function validate(opt, key)
	local ok, r = callAndWait(opt.Validate, key)
	if not ok then
		warn("[MochiKey] Validate errored (the error is printed above), so the key counts as wrong")
		return { Valid = false, Reason = "Invalid" }, true
	end
	if type(r) ~= "table" then r = { Valid = r == true } end
	r.Valid = r.Valid == true
	r.Premium = r.Premium == true
	r.ExpiresIn = tonumber(r.ExpiresIn)
	if not r.Valid and r.Reason ~= "Expired" then r.Reason = "Invalid" end
	return r, false
end

------------------------------------------------------------------------
-- The screen
------------------------------------------------------------------------

local COL_W = 392 -- the preview's centre column width
local SAY_MAX = 290 -- bubble max-width 330 minus 20px padding on each side

local function buildScreen(opt, K, T, keyPath)
	local reduced = false
	pcall(function() reduced = GuiService.ReducedMotionEnabled == true end)
	local touchOnly = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	local alive, leaving = true, false
	local conns, ticks, scales = {}, {}, {}
	local fg = { alpha = 1 } -- multiplier for things the frame loop paints (shadows)
	local back = { alpha = 0 } -- multiplier for the glow and the drifting dots
	local t0 = os.clock()
	K.view, K.busy, K.done, K.lastSay = "key", false, false, "hello"

	local show, say, check, success, leave, notify, toast, setMsg, setField, stepDone, copyDiscord

	-- Remove an older copy (running the script twice)
	local parent = guiParent()
	if parent then
		local old = parent:FindFirstChild("MochiKey")
		if old then old:Destroy() end
	end
	local oldBlur = Lighting:FindFirstChild("MochiKeyBlur")
	if oldBlur then oldBlur:Destroy() end

	local gui = make("ScreenGui", {
		Name = "MochiKey",
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 1000,
	})
	local blur = make("BlurEffect", { Name = "MochiKeyBlur", Size = 0, Parent = Lighting })

	local function addScale(o)
		local u = make("UIScale", { Parent = o })
		scales[#scales + 1] = u
		return u
	end

	-- Full-screen button that eats clicks so they don't reach the game.
	-- Modal frees the mouse in first-person games.
	local root = button(gui, { Name = "Root", Size = UDim2.fromScale(1, 1), Modal = true, Selectable = false })

	---------------- Backdrop over the blurred world ----------------
	local backdrop = frame(root, { Name = "Backdrop", Size = UDim2.fromScale(1, 1) })
	local tint = frame(backdrop, { Size = UDim2.fromScale(1, 1) })
	box(tint, T.bg, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.38 })
	-- radial-gradient(ellipse 60% 55% at 50% 46%, bg 88%, transparent), made from two
	-- smooth fades multiplied together: a CanvasGroup with a left-right fade holding a
	-- frame with a top-bottom fade. No rings, and only two layers.
	local tintGroup = make("CanvasGroup", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = tint })
	make("UIGradient", {
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.833),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 0.833),
		}),
		Parent = tintGroup,
	})
	local tintV = box(tintGroup, T.bg, { Size = UDim2.fromScale(1, 1) })
	make("UIGradient", {
		Rotation = 90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.856),
			NumberSequenceKeypoint.new(0.46, 0.12),
			NumberSequenceKeypoint.new(1, 0.984),
		}),
		Parent = tintV,
	})

	-- Glow: 760px circle of --glow at 20%, breathing
	local glow = frame(backdrop, { AnchorPoint = C, Position = UDim2.fromScale(0.5, 0.44), Size = UDim2.fromOffset(760, 760) })
	local GLOW_N = 8
	local glowA = radialAlphas(GLOW_N, 0.2)
	local glowRings = {}
	for j = GLOW_N, 1, -1 do
		local k = j / GLOW_N
		local f = box(glow, T.glow, { AnchorPoint = C, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(k, k), BackgroundTransparency = 1 })
		corner(f, FULL)
		glowRings[j] = f
	end
	local glowSize = 760

	-- Drifting dots
	local MOTES = {
		{ 0.12, 10, 19, 2 }, { 0.24, 6, 23, 11 }, { 0.37, 12, 26, 6 }, { 0.55, 7, 21, 15 },
		{ 0.66, 11, 24, 3 }, { 0.78, 6, 20, 9 }, { 0.88, 9, 27, 18 }, { 0.46, 5, 22, 13 },
	}
	local motes = {}
	for i, m in ipairs(MOTES) do
		local f = box(backdrop, i == 8 and T.acc2 or T.acc1, { Size = UDim2.fromOffset(m[2], m[2]), BackgroundTransparency = 1 })
		corner(f, FULL)
		motes[i] = { f = f, left = m[1], size = m[2], d = m[3], shift = m[4] }
	end

	ticks[#ticks + 1] = function(now)
		if reduced then
			for j = 1, GLOW_N do glowRings[j].BackgroundTransparency = 1 - glowA[j] * back.alpha end
			for _, m in ipairs(motes) do m.f.BackgroundTransparency = 1 end
			return
		end
		local k = wave(now, 7)
		local gs = glowSize * (1 + 0.08 * k)
		glow.Size = UDim2.fromOffset(gs, gs)
		local mult = (1 + 0.3 * k) * back.alpha
		for j = 1, GLOW_N do glowRings[j].BackgroundTransparency = 1 - glowA[j] * mult end
		for _, m in ipairs(motes) do
			local p = ((now + m.shift) % m.d) / m.d
			local a
			if p < 0.12 then
				a = 0.32 * p / 0.12
			elseif p < 0.85 then
				a = 0.32 - 0.1 * (p - 0.12) / 0.73
			else
				a = 0.22 * (1 - p) / 0.15
			end
			local dx
			if p < 0.5 then dx = 18 * p / 0.5 else dx = 18 - 24 * (p - 0.5) / 0.5 end
			m.f.Position = UDim2.new(m.left, dx, 1 - 1.1 * p, 20 - m.size)
			m.f.BackgroundTransparency = 1 - a * back.alpha
		end
	end

	local layer = frame(root, { Name = "Content", Size = UDim2.fromScale(1, 1) })

	---------------- Close button ----------------
	local closeHolder = frame(layer, { AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -20, 0, 20), Size = UDim2.fromOffset(40, 40), ZIndex = 3 })
	addScale(closeHolder)
	local closeBtn = button(closeHolder, { Size = UDim2.fromScale(1, 1), BackgroundColor3 = T.bg, BackgroundTransparency = 0.3 })
	center(closeBtn)
	corner(closeBtn, 14)
	stroke(closeBtn, T.ss, T.ssA, 1)
	local closeIcon = Icon(closeBtn, "x", 17, T.sub)
	center(closeIcon.Frame)

	---------------- Footer ----------------
	local footer = label(layer, {
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -18),
		Size = UDim2.fromOffset(300, 16),
		Text = opt.Title .. " · v1.0",
		TextSize = 12,
		TextColor3 = T.faint,
		ZIndex = 2,
	})
	addScale(footer)

	---------------- Centre column ----------------
	local column = frame(layer, { AnchorPoint = C, Position = UDim2.new(0.5, 0, 0.5, -6), Size = UDim2.fromOffset(COL_W, 400) })
	local colScale = addScale(column)

	-- Mascot, floating
	-- Roblox snaps GUI to whole pixels, so a slow 5px float moves in visible jumps.
	-- A tiny Rotation turns the snapping off. It also turns clipping off, which is why
	-- the mascot is drawn without any ClipsDescendants.
	local heroFloat = frame(column, { AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(88, 80), Rotation = SMOOTH })
	local hero = newMascot(heroFloat, 88, T, "normal")
	local heroShadow = box(column, T.text, { AnchorPoint = C, Position = UDim2.fromOffset(COL_W / 2, 88), Size = UDim2.fromOffset(56, 8), BackgroundTransparency = 1, Rotation = SMOOTH })
	corner(heroShadow, FULL)
	local heroShadowState = { scale = 1, alpha = 1 }

	-- Speech bubble
	local bubbleHolder = frame(column, { AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 108), Size = UDim2.fromOffset(240, 57) })
	local bubble = frame(bubbleHolder, { AnchorPoint = C, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
	corner(bubble, 24)
	stroke(bubble, T.acc1, 0.42, 2)
	local bubbleScale = make("UIScale", { Parent = bubble })
	local bubbleBg = box(bubble, WHITE, { Size = UDim2.fromScale(1, 1), ZIndex = 1 })
	corner(bubbleBg, 24)
	make("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, mix(WHITE, 0.06, T.sayBg)),
			ColorSequenceKeypoint.new(0.6, T.sayBg),
			ColorSequenceKeypoint.new(1, T.sayBg),
		}),
		Parent = bubbleBg,
	})
	-- Tail: a rotated square with the same outline. A patch hides its lower half.
	local tail = box(bubble, mix(WHITE, 0.06, T.sayBg), { AnchorPoint = C, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(12, 12), Rotation = 45, ZIndex = 2 })
	corner(tail, 3)
	stroke(tail, T.acc1, 0.42, 2)
	box(bubble, mix(WHITE, 0.055, T.sayBg), { AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(28, 11), ZIndex = 3 })
	local sayLabel = label(bubble, {
		Position = UDim2.fromOffset(20, 17),
		Size = UDim2.new(1, -40, 1, -32),
		FontFace = F_HEAD,
		TextSize = 18,
		TextColor3 = T.text,
		TextWrapped = true,
		LineHeight = 1.1,
		ZIndex = 4,
	})
	-- Name tag with a beating heart
	local tagTextW = measure("Mochi", F_HEAD, 11.5).X
	local tag = box(bubble, WHITE, { Position = UDim2.fromOffset(16, -12), Size = UDim2.fromOffset(7 + 11 + 4 + tagTextW + 9, 22), Rotation = -4, ZIndex = 6 })
	corner(tag, FULL)
	gradient(tag, T.btn1, T.btn2)
	local heart = Icon(tag, "heart", 11, WHITE)
	heart.Frame.AnchorPoint = C
	heart.Frame.Position = UDim2.new(0, 12.5, 0.5, 0)
	local heartScale = make("UIScale", { Parent = heart.Frame })
	label(tag, {
		Position = UDim2.fromOffset(22, 0),
		Size = UDim2.new(0, tagTextW + 4, 1, 0),
		Text = "Mochi",
		FontFace = F_HEAD,
		TextSize = 11.5,
		TextColor3 = WHITE,
		TextXAlignment = LEFT,
	})
	-- Two little dots that bob next to the bubble
	local dotA = box(bubble, T.acc1, { Position = UDim2.new(1, -2, 0, 10), Size = UDim2.fromOffset(9, 9), BackgroundTransparency = 0.45, Rotation = SMOOTH })
	corner(dotA, FULL)
	local dotB = box(bubble, T.acc2, { Position = UDim2.new(1, 9, 0, 24), Size = UDim2.fromOffset(5, 5), BackgroundTransparency = 0.45, Rotation = SMOOTH })
	corner(dotB, FULL)

	ticks[#ticks + 1] = function(now)
		local k = wave(now, 4)
		heroFloat.Position = UDim2.new(0.5, 0, 0, -5 * k)
		local s = heroShadowState.scale
		heroShadow.Size = UDim2.fromOffset(56 * (1 - 0.18 * k) * s, 8 * s)
		heroShadow.BackgroundTransparency = 1 - 0.16 * (1 - 0.3 * k) * heroShadowState.alpha * fg.alpha
		hero.Step(now)
		dotA.Position = UDim2.new(1, -2, 0, 10 - 4 * wave(now, 2.6))
		dotB.Position = UDim2.new(1, 9, 0, 24 - 4 * wave(now, 2.6, 1.3))
		-- ksBeat: 15% 1.3, 30% 0.95, 60% 1
		local p = (now % 1.4) / 1.4
		local b = 1
		if p < 0.15 then
			b = 1 + 0.3 * p / 0.15
		elseif p < 0.3 then
			b = 1.3 - 0.35 * (p - 0.15) / 0.15
		elseif p < 0.6 then
			b = 0.95 + 0.05 * (p - 0.3) / 0.3
		end
		heartScale.Scale = b
	end

	---------------- Views ----------------
	local viewsFrame = frame(column, { Position = UDim2.fromOffset(0, 189), Size = UDim2.fromOffset(COL_W, 202) })
	local KEY_H = 202
	local keyView = frame(viewsFrame, { Size = UDim2.new(1, 0, 0, KEY_H) })
	local getView = frame(viewsFrame, { Size = UDim2.new(1, 0, 0, 400), Visible = false })
	local views = { key = { frame = keyView, h = KEY_H }, get = { frame = getView, h = 400 } }
	local bubH = 57

	local function relayout(t)
		local vy = 108 + bubH + 24
		local vh = views[K.view].h
		tw(viewsFrame, t, { Position = UDim2.fromOffset(0, vy), Size = UDim2.fromOffset(COL_W, vh) }, QUART)
		tw(column, t, { Size = UDim2.fromOffset(COL_W, vy + vh) }, QUART)
	end

	-- Bubble size for a line: shrink-to-fit up to SAY_MAX, with balanced lines like text-wrap: balance
	local function bubbleSize(str)
		local single = measure("Ag", F_HEAD, 18).Y
		local full = measure(str, F_HEAD, 18, SAY_MAX)
		local lines = math.max(1, math.floor(full.Y / single + 0.5))
		local w = full.X + 4
		if lines > 1 then
			local lo, hi = 60, SAY_MAX
			while hi - lo > 3 do
				local mid = (lo + hi) / 2
				local m = measure(str, F_HEAD, 18, mid)
				if math.floor(m.Y / single + 0.5) > lines then lo = mid else hi = mid end
			end
			w = hi + 4
		end
		local textH = math.max(lines * single * 1.1, 24)
		return math.ceil(w) + 40, math.ceil(textH) + 32
	end

	local function setBubble(w, h, t)
		bubH = h
		tw(bubbleHolder, t, { Size = UDim2.fromOffset(w, h) }, QUART)
		relayout(t)
	end

	---------------- Key view ----------------
	local fieldHolder = frame(keyView, { Size = UDim2.new(1, 0, 0, 54) })
	local field = button(fieldHolder, { Size = UDim2.fromScale(1, 1), BackgroundColor3 = T.input, BackgroundTransparency = 0 })
	corner(field, 17)
	local fieldStroke = stroke(field, T.ss, T.ssA, 1)
	local keyIcon = Icon(field, "key", 18, T.faint)
	keyIcon.Frame.AnchorPoint = Vector2.new(0, 0.5)
	keyIcon.Frame.Position = UDim2.new(0, 16, 0.5, 0)

	-- No Paste button (most executors can't read the clipboard). Ctrl+V works in the box.
	-- The box runs from the key icon to 10px before the arrow.
	local inputW = 345 - 10 - 44
	local input = make("TextBox", {
		Position = UDim2.fromOffset(44, 0),
		Size = UDim2.new(0, inputW, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		PlaceholderText = "Paste your key here",
		PlaceholderColor3 = T.faint,
		TextColor3 = T.text,
		FontFace = F_BODY,
		TextSize = textSize(F_BODY, 14),
		TextXAlignment = LEFT,
		ClearTextOnFocus = false,
		ClipsDescendants = true,
		Parent = field,
	})

	-- The arrow: checks the key
	local go = button(field, { Size = UDim2.fromOffset(40, 40), BackgroundColor3 = WHITE, BackgroundTransparency = 0 })
	go.AnchorPoint = C
	go.Position = UDim2.new(1, -27, 0.5, 0)
	corner(go, 12)
	gradient(go, T.btn1, T.btn2)
	local goOk = box(go, T.okDeep, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 1 })
	corner(goOk, 12)
	local goArrow = Icon(go, "arrow", 18, WHITE)
	center(goArrow.Frame).ZIndex = 2
	local goCheck = Icon(go, "checkFill", 18, WHITE)
	center(goCheck.Frame).ZIndex = 2
	goCheck.Frame.Visible = false
	local goCheckScale = make("UIScale", { Parent = goCheck.Frame })

	local function makeDots(parent, size, gap, color)
		local holder = frame(parent, { AnchorPoint = C, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(size * 3 + gap * 2, size + 8), Visible = false, ZIndex = 2 })
		local list = {}
		for i = 1, 3 do
			local d = box(holder, color, { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, (i - 1) * (size + gap), 0.5, 0), Size = UDim2.fromOffset(size, size) })
			corner(d, FULL)
			list[i] = d
		end
		ticks[#ticks + 1] = function(now)
			if not holder.Visible then return end
			for i, d in ipairs(list) do
				local p = ((now - (i - 1) * 0.12) % 0.9) / 0.9
				local y = 0
				if p < 0.3 then
					y = -4 * math.sin(p / 0.3 * math.pi / 2)
				elseif p < 0.6 then
					y = -4 * math.cos((p - 0.3) / 0.3 * math.pi / 2)
				end
				d.Position = UDim2.new(0, (i - 1) * (size + gap), 0.5, y)
			end
		end
		return holder
	end
	local goDots = makeDots(go, 4, 3, WHITE)
	-- Dim layer in the field colour: the arrow is at 45% while the box is empty
	local goDim = box(go, T.input, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.55, ZIndex = 5 })
	corner(goDim, 12)
	local goScale = make("UIScale", { Parent = go })
	local goEmpty = true

	-- Message line
	local msgHolder = frame(keyView, { Position = UDim2.fromOffset(0, 65), Size = UDim2.new(1, 0, 0, 20) })
	local msgRow = frame(msgHolder, { Size = UDim2.fromScale(1, 1) })
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = msgRow,
	})

	-- Get key button
	local getHolder = frame(keyView, { Position = UDim2.fromOffset(0, 101), Size = UDim2.new(1, 0, 0, 52) })
	local getBtn = button(getHolder, { Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BackgroundTransparency = 0 })
	center(getBtn)
	corner(getBtn, 16)
	gradient(getBtn, T.btn1, T.btn2)
	local getScale = make("UIScale", { Parent = getBtn })
	-- Sheen that sweeps across on hover (UIGradient Offset tween)
	local sheen = box(getBtn, WHITE, { Size = UDim2.fromScale(1, 1), ZIndex = 2 })
	corner(sheen, 16)
	local sheenG = make("UIGradient", {
		Rotation = 15,
		Offset = Vector2.new(-1, 0),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.35, 1),
			NumberSequenceKeypoint.new(0.5, 0.78),
			NumberSequenceKeypoint.new(0.65, 1),
			NumberSequenceKeypoint.new(1, 1),
		}),
		Parent = sheen,
	})
	local getTextW = measure("Get key", F_BODY_X, 15).X
	local getX = (COL_W - (18 + 9 + getTextW)) / 2
	local getIcon = Icon(getBtn, "keyFill", 18, WHITE)
	getIcon.Frame.AnchorPoint = C
	getIcon.Frame.Position = UDim2.new(0, getX + 9, 0.5, 0)
	getIcon.Frame.ZIndex = 3
	local getIconScale = make("UIScale", { Parent = getIcon.Frame })
	label(getBtn, {
		Position = UDim2.fromOffset(getX + 27, 0),
		Size = UDim2.new(0, getTextW + 4, 1, 0),
		Text = "Get key",
		FontFace = F_BODY_X,
		TextSize = 15,
		TextColor3 = WHITE,
		TextXAlignment = LEFT,
		ZIndex = 3,
	})

	-- Quiet text buttons ("Having trouble?" and "Back to my key")
	local function switchButton(parent, y, iconName, text, padL, padR, gap)
		local holder = frame(parent, { Position = UDim2.fromOffset(0, y), Size = UDim2.new(1, 0, 0, 27) })
		local tw_ = measure(text, F_BODY_X, 13).X
		local w = math.ceil(padL + 15 + gap + tw_ + padR)
		local b = button(holder, { Size = UDim2.fromOffset(w, 27), BackgroundColor3 = T.acc1, BackgroundTransparency = 1 })
		center(b)
		corner(b, 10)
		local ic = Icon(b, iconName, 15, T.sub)
		ic.Frame.AnchorPoint = C
		ic.Frame.Position = UDim2.new(0, padL + 7.5, 0.5, 0)
		local l = label(b, {
			Position = UDim2.fromOffset(padL + 15 + gap, 0),
			Size = UDim2.new(0, tw_ + 4, 1, 0),
			Text = text,
			FontFace = F_BODY_X,
			TextSize = 13,
			TextColor3 = T.sub,
			TextXAlignment = LEFT,
		})
		return holder, b, ic, l, padL
	end

	local helpHolder, helpBtn, helpIcon, helpText = switchButton(keyView, 175, "help", "Having trouble?", 11, 11, 6)

	---------------- Get view ----------------
	label(getView, { Size = UDim2.new(1, 0, 0, 33), Text = "Get a key", FontFace = F_HEAD, TextSize = 30, TextColor3 = T.text })
	label(getView, { Position = UDim2.fromOffset(0, 39), Size = UDim2.new(1, 0, 0, 20), Text = "Three quick steps, about a minute.", TextSize = 14, TextColor3 = T.sub })

	local stepsY = 85
	local colW = (COL_W - 16) / 3
	local line = box(getView, T.ss, { Position = UDim2.new(0.166, 0, 0, stepsY + 16), Size = UDim2.new(0.668, 0, 0, 2), BackgroundTransparency = 1 - T.ssA })
	corner(line, 2)
	local steps = {}
	local stepsH = 0
	for i, st in ipairs(STEPS) do
		local x = (i - 1) * (colW + 8)
		local chip = box(getView, mix(T.acc1, 0.16, T.bg), { AnchorPoint = C, Position = UDim2.fromOffset(x + colW / 2, stepsY + 17), Size = UDim2.fromOffset(34, 34), ZIndex = 2 })
		corner(chip, 12)
		local chipStroke = stroke(chip, T.acc1, 0.26, 1)
		local fill = box(chip, WHITE, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 })
		corner(fill, 12)
		gradient(fill, T.btn1, T.btn2)
		local num = label(chip, { Size = UDim2.fromScale(1, 1), Text = tostring(i), FontFace = F_HEAD, TextSize = 15, TextColor3 = T.accText, ZIndex = 2 })
		local chk = Icon(chip, "checkFill", 15, WHITE)
		center(chk.Frame).ZIndex = 3
		chk.Frame.Visible = false
		local chkScale = make("UIScale", { Parent = chk.Frame })
		local _, th = textBlock(st[1], F_BODY_X, 13, colW, 1)
		local _, sh = textBlock(st[2], F_BODY, 11.5, colW, 1)
		label(getView, {
			Position = UDim2.fromOffset(x, stepsY + 42),
			Size = UDim2.fromOffset(colW, th),
			Text = st[1],
			FontFace = F_BODY_X,
			TextSize = 13,
			TextColor3 = T.text,
			TextWrapped = true,
			TextYAlignment = Enum.TextYAlignment.Top,
		})
		label(getView, {
			Position = UDim2.fromOffset(x, stepsY + 42 + th + 2),
			Size = UDim2.fromOffset(colW, sh),
			Text = st[2],
			TextSize = 11.5,
			TextColor3 = T.sub,
			TextTransparency = 0.18,
			TextWrapped = true,
			TextYAlignment = Enum.TextYAlignment.Top,
		})
		stepsH = math.max(stepsH, th + 2 + sh)
		steps[i] = { chip = chip, stroke = chipStroke, fill = fill, num = num, check = chk, checkScale = chkScale, done = false }
	end

	-- Copy key link: the main button with an icon chip, a label and the link under it
	local linkY = stepsY + 42 + stepsH + 26
	local linkHolder = frame(getView, { Position = UDim2.fromOffset(0, linkY), Size = UDim2.new(1, 0, 0, 60) })
	local linkBtn = button(linkHolder, { Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BackgroundTransparency = 0 })
	center(linkBtn)
	corner(linkBtn, 16)
	gradient(linkBtn, T.btn1, T.btn2)
	local linkScale = make("UIScale", { Parent = linkBtn })
	local linkOk = box(linkBtn, T.okDeep, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 })
	corner(linkOk, 16)
	local linkFlash = box(linkBtn, WHITE, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 2 })
	corner(linkFlash, 16)
	local linkChip = box(linkBtn, WHITE, { AnchorPoint = C, Position = UDim2.new(0, 30, 0.5, 0), Size = UDim2.fromOffset(42, 42), BackgroundTransparency = 0.8, ZIndex = 3 })
	corner(linkChip, 12)
	local linkIcon = Icon(linkChip, "link", 18, WHITE)
	center(linkIcon.Frame)
	local linkCheck = Icon(linkChip, "checkFill", 18, WHITE)
	center(linkCheck.Frame)
	linkCheck.Frame.Visible = false
	local linkCheckScale = make("UIScale", { Parent = linkCheck.Frame })
	local linkTitle = label(linkBtn, {
		Position = UDim2.fromOffset(63, 10),
		Size = UDim2.new(1, -107, 0, 20),
		Text = "Copy key link",
		FontFace = F_BODY_X,
		TextSize = 14.5,
		TextColor3 = WHITE,
		TextXAlignment = LEFT,
		ZIndex = 3,
	})
	label(linkBtn, {
		Position = UDim2.fromOffset(63, 31),
		Size = UDim2.new(1, -107, 0, 17),
		Text = (opt.KeyLink:gsub("^https?://", "")),
		FontFace = F_MONO_SEMI,
		TextSize = 11.5,
		TextColor3 = WHITE,
		TextTransparency = 0.22,
		TextXAlignment = LEFT,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = 3,
	})
	local linkChevron = Icon(linkBtn, "chevronRight", 18, WHITE, 0.85)
	linkChevron.Frame.AnchorPoint = Vector2.new(1, 0.5)
	linkChevron.Frame.Position = UDim2.new(1, -14, 0.5, 0)
	linkChevron.Frame.ZIndex = 3

	-- Discord row: same shape, tinted, with a "Copy invite" pill
	local discordHolder = frame(getView, { Position = UDim2.fromOffset(0, linkY + 70), Size = UDim2.new(1, 0, 0, 60) })
	local discordBtn = button(discordHolder, { Size = UDim2.fromScale(1, 1), BackgroundColor3 = mix(T.acc1, 0.09, T.bg), BackgroundTransparency = 0 })
	center(discordBtn)
	corner(discordBtn, 16)
	stroke(discordBtn, T.acc1, 0.22, 1)
	local discordScale = make("UIScale", { Parent = discordBtn })
	local discordChip = box(discordBtn, mix(T.acc1, 0.2, T.bg), { AnchorPoint = C, Position = UDim2.new(0, 30, 0.5, 0), Size = UDim2.fromOffset(42, 42) })
	corner(discordChip, 12)
	local discordChipScale = make("UIScale", { Parent = discordChip })
	center(Icon(discordChip, "message", 18, T.accText).Frame)
	local pillTextW = measure("Copy invite", F_BODY_X, 12).X
	local pillW = math.ceil(pillTextW + 24)
	local pill = box(discordBtn, mix(T.acc1, 0.18, T.bg), { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(pillW, 32), ZIndex = 2 })
	corner(pill, 10)
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = pill,
	})
	local pillCheck = Icon(pill, "checkFill", 12, WHITE)
	pillCheck.Frame.LayoutOrder = 1
	pillCheck.Frame.Visible = false
	local pillCheckScale = make("UIScale", { Parent = pillCheck.Frame })
	local pillText = label(pill, { AutomaticSize = AUTO_X, Size = UDim2.fromOffset(0, 32), Text = "Copy invite", FontFace = F_BODY_X, TextSize = 12, TextColor3 = T.accText, LayoutOrder = 2 })
	local discordTextW = COL_W - 63 - pillW - 9 - 12
	label(discordBtn, {
		Position = UDim2.fromOffset(63, 10),
		Size = UDim2.fromOffset(discordTextW, 20),
		Text = "Join the Discord",
		FontFace = F_BODY_X,
		TextSize = 14.5,
		TextColor3 = T.text,
		TextXAlignment = LEFT,
	})
	label(discordBtn, {
		Position = UDim2.fromOffset(63, 31),
		Size = UDim2.fromOffset(discordTextW, 17),
		Text = opt.Discord,
		FontFace = F_MONO_SEMI,
		TextSize = 11.5,
		TextColor3 = T.faint,
		TextXAlignment = LEFT,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})

	local backY = linkY + 70 + 60 + 22
	local backHolder, backBtn, backIcon, backText = switchButton(getView, backY, "chevronLeft", "Back to my key", 6, 10, 2)
	views.get.h = backY + 27
	getView.Size = UDim2.new(1, 0, 0, views.get.h)

	---------------- "You're in!" screen ----------------
	local done = frame(layer, { AnchorPoint = C, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(460, 264), Visible = false })
	local doneScale = addScale(done)
	local doneMascotHolder = frame(done, { AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(104, 94), Rotation = SMOOTH })
	local doneMascot = newMascot(doneMascotHolder, 104, T, "happy")
	local doneShadow = box(done, T.text, { AnchorPoint = C, Position = UDim2.new(0.5, 0, 0, 100.5), Size = UDim2.fromOffset(70, 9), BackgroundTransparency = 1, Rotation = SMOOTH })
	corner(doneShadow, FULL)
	local doneShadowState = { scale = 0.3, alpha = 0 }
	local doneBob = { on = false, t = 0 }
	local doneTitle = label(done, { Position = UDim2.fromOffset(0, 121), Size = UDim2.new(1, 0, 0, 36), Text = "You're in!", FontFace = F_HEAD, TextSize = 32, TextColor3 = T.text })
	local doneSub = frame(done, { Position = UDim2.fromOffset(0, 165), Size = UDim2.new(1, 0, 0, 22) })
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = doneSub,
	})
	local doneNote = label(done, { Position = UDim2.fromOffset(0, 192), Size = UDim2.new(1, 0, 0, 17), Text = "", TextSize = 12.5, TextColor3 = T.faint })
	local barTrack = box(done, T.text, { AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 231), Size = UDim2.fromOffset(200, 6), BackgroundTransparency = 0.9 })
	corner(barTrack, 9)
	local barFill = box(barTrack, WHITE, { Size = UDim2.fromScale(0, 1) })
	corner(barFill, 9)
	gradient(barFill, T.btn1, T.btn2, 0)
	local doneLaunch = label(done, { Position = UDim2.fromOffset(0, 246), Size = UDim2.new(1, 0, 0, 17), Text = "Launching " .. opt.Title .. "…", FontFace = F_BODY_X, TextSize = 12.5, TextColor3 = T.sub })

	ticks[#ticks + 1] = function(now)
		if not done.Visible then return end
		if doneBob.on then
			-- bob: translateY(-1.5px) scale(1.04, 0.96) every 1.6s
			local k = wave(now - doneBob.t, 1.6)
			doneMascot.Body.Size = UDim2.fromScale(1 + 0.04 * k, 1 - 0.04 * k)
			doneMascot.Body.Position = UDim2.new(0.5, 0, 1, -1.5 * k)
		end
		local s = doneShadowState.scale
		doneShadow.Size = UDim2.fromOffset(70 * s, 9 * s)
		doneShadow.BackgroundTransparency = 1 - 0.18 * doneShadowState.alpha * fg.alpha
	end

	---------------- Toast ----------------
	local toastHolder = frame(layer, { AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -58), Size = UDim2.fromOffset(240, 37), ZIndex = 4 })
	addScale(toastHolder)
	local toastBox = box(toastHolder, T.elTop, { Size = UDim2.fromScale(1, 1), Visible = false })
	center(toastBox)
	corner(toastBox, FULL)
	local toastStroke = stroke(toastBox, T.ss, T.ssA, 1)
	local toastScale = make("UIScale", { Parent = toastBox })
	local toastToken, toastAnim = 0, nil

	toast = function(text, iconName)
		toastToken = toastToken + 1
		local my = toastToken
		if toastAnim then toastAnim.stopped = true end
		for _, c in ipairs(toastBox:GetChildren()) do
			if c:IsA("GuiObject") then c:Destroy() end
		end
		local textW = measure(text, F_BODY_X, 12.5).X
		toastHolder.Size = UDim2.fromOffset(math.ceil(16 + 15 + 7 + textW + 16), 37)
		local ic = Icon(toastBox, iconName, 15, T.accText)
		ic.Frame.AnchorPoint = Vector2.new(0, 0.5)
		ic.Frame.Position = UDim2.new(0, 16, 0.5, 0)
		label(toastBox, {
			Position = UDim2.fromOffset(38, 0),
			Size = UDim2.new(0, textW + 4, 1, 0),
			Text = text,
			FontFace = F_BODY_X,
			TextSize = 12.5,
			TextColor3 = T.text,
			TextXAlignment = LEFT,
		})
		toastBox.BackgroundTransparency = 0
		toastStroke.Transparency = 1 - T.ssA
		local list = capture(toastBox)
		applyAlpha(list, 0)
		toastBox.Visible = true
		toastBox.Position = UDim2.new(0.5, 0, 0.5, 20)
		toastScale.Scale = 0.9
		tw(toastBox, 0.45, { Position = UDim2.fromScale(0.5, 0.5) }, BACK)
		tw(toastScale, 0.45, { Scale = 1 }, BACK)
		toastAnim = anim(0.2, function(a) applyAlpha(list, a) end, QUART)
		task.delay(2.2, function()
			if my ~= toastToken or not alive then return end
			toastAnim = anim(0.2, function(a) applyAlpha(list, 1 - a) end, QUART)
			tw(toastBox, 0.45, { Position = UDim2.new(0.5, 0, 0.5, 20) }, BACK)
			tw(toastScale, 0.45, { Scale = 0.9 }, BACK)
			task.delay(0.45, function()
				if my == toastToken then toastBox.Visible = false end
			end)
		end)
	end

	---------------- Notifications (the hub's style) ----------------
	local stack = frame(layer, { AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -16), Size = UDim2.fromOffset(320, 10), ZIndex = 5 })
	addScale(stack)
	local notifs = {}

	local function layoutNotifs()
		local y = 0
		for i = #notifs, 1, -1 do
			local n = notifs[i]
			tw(n.holder, 0.35, { Position = UDim2.new(0, n.x, 1, -y) }, QUART)
			y = y + n.h + 8
		end
	end

	notify = function(o)
		local dur = o.Duration or 8
		local W = 320
		local bodyW = W - 12 - 38 - 10 - 24 - 10
		local _, contentH = textBlock(o.Content or "", F_BODY, 12.5, bodyW, 1.15)
		local actionW = 0
		if o.Action then actionW = math.ceil(12 + 13 + 6 + measure(o.Action.Title, F_BODY_X, 12).X + 12) end
		local H = 12 + 1 + 18 + 2 + contentH + (o.Action and 39 or 0) + 15
		local n = { h = H, x = 0 }
		local holder = frame(stack, { AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, W * 1.1, 1, 0), Size = UDim2.fromOffset(W, H) })
		n.holder = holder
		local card = box(holder, T.bg, { Size = UDim2.fromScale(1, 1) })
		center(card)
		corner(card, 17)
		stroke(card, T.ss, T.ssA, 1)
		local cardScale = make("UIScale", { Scale = 0.9, Parent = card })
		-- Type sets the colour like the hub's .mn-success / .mn-warning / .mn-error
		local accent = T.warn
		if o.Type == "success" then
			accent = T.ok
		elseif o.Type == "error" then
			accent = T.bad
		elseif o.Type == "info" then
			accent = T.acc1
		end
		local face = box(card, accent, { Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(38, 38), BackgroundTransparency = 0.84 })
		corner(face, 12)
		local nm = newMascot(face, 28, T, o.Mood or "normal")
		nm.Root.AnchorPoint = C
		nm.Root.Position = UDim2.fromScale(0.5, 0.5)
		label(card, {
			Position = UDim2.fromOffset(60, 13),
			Size = UDim2.fromOffset(bodyW, 18),
			Text = o.Title or "",
			FontFace = F_HEAD,
			TextSize = 14.5,
			TextColor3 = T.text,
			TextXAlignment = LEFT,
		})
		label(card, {
			Position = UDim2.fromOffset(60, 33),
			Size = UDim2.fromOffset(bodyW, contentH),
			Text = o.Content or "",
			TextSize = 12.5,
			TextColor3 = T.text,
			TextXAlignment = LEFT,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			LineHeight = 1.15,
		})
		local closed = false
		local function close()
			if closed then return end
			closed = true
			for i, v in ipairs(notifs) do
				if v == n then
					table.remove(notifs, i)
					break
				end
			end
			local list = capture(holder)
			anim(0.3, function(a) applyAlpha(list, 1 - a) end, QUART)
			tw(cardScale, 0.3, { Scale = 0.95 }, QUART)
			layoutNotifs()
			task.delay(0.5, function() holder:Destroy() end)
		end
		if o.Action then
			local ab = button(card, {
				Position = UDim2.fromOffset(60, 33 + contentH + 9),
				Size = UDim2.fromOffset(actionW, 30),
				BackgroundColor3 = WHITE,
				BackgroundTransparency = 0,
			})
			corner(ab, 10)
			gradient(ab, T.btn1, T.btn2)
			local ai = Icon(ab, o.Action.Icon or "message", 13, WHITE)
			ai.Frame.AnchorPoint = Vector2.new(0, 0.5)
			ai.Frame.Position = UDim2.new(0, 12, 0.5, 0)
			label(ab, {
				Position = UDim2.fromOffset(31, 0),
				Size = UDim2.new(1, -31, 1, 0),
				Text = o.Action.Title,
				FontFace = F_BODY_X,
				TextSize = 12,
				TextColor3 = WHITE,
				TextXAlignment = LEFT,
			})
			ab.Activated:Connect(function()
				safeCall(o.Action.Callback)
				close()
			end)
		end
		local xb = button(card, { Position = UDim2.fromOffset(W - 10 - 24, 12), Size = UDim2.fromOffset(24, 24), BackgroundColor3 = T.elHover })
		corner(xb, 8)
		local xi = Icon(xb, "x", 13, T.faint)
		center(xi.Frame)
		xb.MouseEnter:Connect(function()
			xb.BackgroundTransparency = 0
			xi.SetColor(T.text)
		end)
		xb.MouseLeave:Connect(function()
			xb.BackgroundTransparency = 1
			xi.SetColor(T.faint)
		end)
		xb.Activated:Connect(close)
		-- Timer bar. Inset from the rounded corners because Frames can't clip to them.
		local track = box(card, accent, { AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -1), Size = UDim2.new(1, -24, 0, 3), BackgroundTransparency = 0.85 })
		corner(track, 2)
		local barN = box(track, accent, { Size = UDim2.fromScale(1, 1) })
		corner(barN, 2)

		local list = capture(holder)
		applyAlpha(list, 0)
		notifs[#notifs + 1] = n
		layoutNotifs()
		-- the new one slides in from the right with a little overshoot
		tw(holder, 0.55, { Position = UDim2.new(0, 0, 1, 0) }, BACK)
		tw(cardScale, 0.55, { Scale = 1 }, BACK)
		anim(0.3, function(a) applyAlpha(list, a) end, QUART)
		tw(barN, dur, { Size = UDim2.fromScale(0, 1) }, LINEAR)
		task.delay(dur, close)
		return close
	end

	---------------- Screen scale ----------------
	local function updateScale()
		local vs = gui.AbsoluteSize
		if vs.X < 2 or vs.Y < 2 then return end
		local s = math.clamp(math.min(vs.X / 432, vs.Y / 700), 0.5, 1)
		K.scale = s
		for _, u in ipairs(scales) do u.Scale = s end
		if K.done then colScale.Scale = s * 0.98 end
		glowSize = 760 * s
		if reduced then glow.Size = UDim2.fromOffset(glowSize, glowSize) end
	end

	---------------- Behaviour ----------------
	local fieldState = nil -- nil, "error", "warn", "ok"
	local focused = false
	local sayId, sayToken, typeTween = nil, 0, nil

	local function paintField()
		local bg, sc, sa, ic
		if fieldState == "error" then
			bg, sc, sa, ic = mix(T.bad, 0.05, T.input), T.bad, 0.45, T.bad
		elseif fieldState == "warn" then
			bg, sc, sa, ic = mix(T.warn, 0.05, T.input), T.warn, 0.45, T.warn
		elseif fieldState == "ok" then
			bg, sc, sa, ic = mix(T.ok, 0.05, T.input), T.ok, 0.45, T.ok
		elseif focused then
			bg = mix(T.acc1, 0.04, T.input)
			sc, sa = amix(T.acc1, 1, 0.32, T.ss, T.ssA)
			ic = T.accText
		else
			bg, sc, sa, ic = T.input, T.ss, T.ssA, T.faint
		end
		tw(field, 0.25, { BackgroundColor3 = bg })
		tw(fieldStroke, 0.25, { Color = sc, Transparency = 1 - sa })
		keyIcon.SetColor(ic, 0.25)
	end

	local function shake()
		seq(field, {
			{ 0.08, { Position = UDim2.fromOffset(-4, 0) } },
			{ 0.08, { Position = UDim2.fromOffset(4, 0) } },
			{ 0.08, { Position = UDim2.fromOffset(-4, 0) } },
			{ 0.08, { Position = UDim2.fromOffset(4, 0) } },
			{ 0.08, { Position = UDim2.fromOffset(0, 0) } },
		}, "shake")
	end

	setField = function(state)
		fieldState = state
		paintField()
		if state == "error" or state == "warn" then shake() end
	end

	-- rise keyframes: fade in and slide up. Base positions are remembered so repeats don't drift.
	local basePos = {}
	local function rise(o, delay, dur, dist)
		dur = dur or 0.6
		local base = basePos[o]
		if not base then
			base = o.Position
			basePos[o] = base
		end
		local list = capture(o)
		applyAlpha(list, 0)
		o.Position = base + UDim2.fromOffset(0, dist or 8)
		tw(o, dur, { Position = base }, QUART, OUT, delay)
		return anim(dur, function(a) applyAlpha(list, a) end, QUART, OUT, delay)
	end

	local msgKids, msgAnim = {}, nil
	setMsg = function(kind, text, iconName, linkText, linkFn, quiet)
		if msgAnim then msgAnim.stopped = true end
		for _, c in ipairs(msgKids) do c:Destroy() end
		msgKids = {}
		local color = T.faint
		if kind == "error" then
			color = T.bad
		elseif kind == "warn" then
			color = T.warn
		elseif kind == "ok" then
			color = T.ok
		end
		if iconName then
			local ic = Icon(msgRow, iconName, 15, color)
			ic.Frame.LayoutOrder = 1
			msgKids[#msgKids + 1] = ic.Frame
		end
		msgKids[#msgKids + 1] = label(msgRow, {
			AutomaticSize = AUTO_X,
			Size = UDim2.fromOffset(0, 20),
			Text = text,
			TextSize = 12.5,
			TextColor3 = color,
			LayoutOrder = 2,
		})
		if linkText then
			local b = button(msgRow, {
				AutomaticSize = AUTO_X,
				Size = UDim2.fromOffset(0, 20),
				RichText = true,
				Text = "<u>" .. linkText .. "</u>",
				FontFace = F_BODY_X,
				TextSize = 12.5,
				TextColor3 = T.accText,
				LayoutOrder = 3,
			})
			b.Activated:Connect(linkFn)
			msgKids[#msgKids + 1] = b
		end
		if not quiet then msgAnim = rise(msgRow, 0, 0.3, 6) end
	end
	local function resetMsg()
		setMsg(nil, HINT, nil, nil, nil, true)
	end

	stepDone = function(n, on)
		local s = steps[n]
		if s.done == on then return end
		s.done = on
		tw(s.fill, 0.35, { BackgroundTransparency = on and 0 or 1 })
		tw(s.stroke, 0.35, { Transparency = on and 1 or 0.74 })
		tw(s.chip, 0.5, { Rotation = on and -8 or 0 }, BACK)
		s.num.Visible = not on
		s.check.Frame.Visible = on
		if on then
			s.checkScale.Scale = 1
			seq(s.checkScale, { { 0.16, { Scale = 1.22 } }, { 0.24, { Scale = 1 } } }, "pop")
		end
	end

	local function setGoEmpty(empty)
		if goEmpty == empty then return end
		goEmpty = empty
		tw(goDim, 0.25, { BackgroundTransparency = empty and 0.55 or 1 })
	end

	-- The mochi talks: the bubble types its line out and the mouth moves until it's done
	say = function(id)
		if id ~= "get" then K.lastSay = id end
		if sayId == id then return end
		sayId = id
		sayToken = sayToken + 1
		local my = sayToken
		local str = (SAY[id] or tostring(id)):gsub("{title}", function() return opt.Title end)
		if typeTween then typeTween:Cancel() end
		-- ksSay pop
		bubbleScale.Scale = 0.9
		bubble.Rotation = -1.5
		seq(bubbleScale, { { 0.25, { Scale = 1.03 }, QUART, OUT }, { 0.25, { Scale = 1 }, SINE, INOUT } }, "swap")
		seq(bubble, { { 0.25, { Rotation = 0.5 }, QUART, OUT }, { 0.25, { Rotation = 0 }, SINE, INOUT } }, "swap")
		task.spawn(function()
			local w, h = bubbleSize(str)
			if my ~= sayToken or not alive then return end
			sayLabel.Text = str
			setBubble(w, h, 0.35)
			if reduced then
				sayLabel.MaxVisibleGraphemes = -1
				return
			end
			local count = utf8.len(str) or #str
			local function finished()
				if my == sayToken then
					hero.Talk(false)
					sayLabel.MaxVisibleGraphemes = -1
				end
			end
			sayLabel.MaxVisibleGraphemes = 0
			hero.Talk(true)
			-- 24ms per letter, like the preview
			local ok, tween = pcall(function()
				return TweenService:Create(sayLabel, TweenInfo.new(count * 0.024, LINEAR), { MaxVisibleGraphemes = count })
			end)
			if ok and tween then
				typeTween = tween
				tween.Completed:Connect(finished)
				tween:Play()
			else
				-- Fallback if this client won't tween the property
				typeTween = nil
				task.spawn(function()
					for i = 1, count do
						if my ~= sayToken then return end
						sayLabel.MaxVisibleGraphemes = i
						task.wait(0.024)
					end
					finished()
				end)
			end
		end)
	end

	-- Views: the old one fades out first, then the new one rises in
	local function stopFade(v)
		if v.anim then
			v.anim.stopped = true
			v.anim = nil
		end
		if v.list then
			applyAlpha(v.list, 1)
			v.list = nil
		end
	end
	local function hideView(v)
		stopFade(v)
		v.token = (v.token or 0) + 1
		local my = v.token
		local list = capture(v.frame, false)
		v.list = list
		v.anim = anim(0.18, function(a) applyAlpha(list, 1 - a) end, QUART)
		tw(v.frame, 0.4, { Position = UDim2.fromOffset(0, 10) })
		task.delay(0.2, function()
			if v.token ~= my then return end
			v.frame.Visible = false
			stopFade(v)
		end)
	end
	local function showView(v)
		stopFade(v)
		v.token = (v.token or 0) + 1
		local my = v.token
		v.frame.Visible = true
		local list = capture(v.frame, false)
		v.list = list
		applyAlpha(list, 0)
		v.frame.Position = UDim2.fromOffset(0, 10)
		tw(v.frame, 0.55, { Position = UDim2.fromOffset(0, 0) }, QUART, OUT, 0.12)
		v.anim = anim(0.4, function(a) applyAlpha(list, a) end, QUART, OUT, 0.16)
		task.delay(0.6, function()
			if v.token == my then
				v.list = nil
				v.anim = nil
			end
		end)
	end

	show = function(name, focus)
		if K.view == name or not views[name] then return end
		local old = K.view
		K.view = name
		hideView(views[old])
		showView(views[name])
		relayout(0.5)
		if name == "get" and hero.mood ~= "happy" then hero.SetMood("normal") end
		if not K.done then
			if name == "get" then
				say("get")
			elseif fieldState == "error" or fieldState == "warn" then
				say(K.lastSay)
			else
				say("hello")
			end
		end
		if focus ~= false and name == "key" and not touchOnly then
			task.delay(0.3, function()
				if alive and K.view == "key" and not leaving then input:CaptureFocus() end
			end)
		end
	end

	-- Typing: caps, max 64 characters, mono font once there's text, mascot watches
	local settingText = false
	local function fitInput()
		local t = input.Text
		if t == "" then
			input.FontFace = F_BODY
			input.TextSize = textSize(F_BODY, 14)
			return
		end
		input.FontFace = F_MONO
		input.TextSize = math.clamp(math.floor(inputW / (#t * 0.62)), 10, textSize(F_MONO, 15))
	end
	local function onInput()
		if K.done then return end
		if K.view ~= "key" then show("key", false) end
		if fieldState then
			setField(nil)
			hero.SetMood("normal")
			hero.Look(true)
			resetMsg()
			say("hello")
		end
		local has = trim(input.Text) ~= ""
		stepDone(3, has)
		setGoEmpty(not has)
	end
	conns[#conns + 1] = input:GetPropertyChangedSignal("Text"):Connect(function()
		if settingText then return end
		local raw = input.Text
		local fixed = string.upper(raw)
		if #fixed > 64 then fixed = string.sub(fixed, 1, 64) end
		if fixed ~= raw then
			settingText = true
			local cp = input.CursorPosition
			input.Text = fixed
			if cp > 0 then input.CursorPosition = math.min(cp, #fixed + 1) end
			settingText = false
		end
		fitInput()
		onInput()
	end)
	input.Focused:Connect(function()
		focused = true
		paintField()
		if hero.mood ~= "happy" then hero.Look(true) end
	end)
	input.FocusLost:Connect(function(enter)
		focused = false
		paintField()
		hero.Look(false)
		if enter then check() end
	end)
	field.Activated:Connect(function()
		if not K.done then input:CaptureFocus() end
	end)

	-- Checking a key
	local function goIcon(which)
		goArrow.Frame.Visible = which == "arrow"
		goCheck.Frame.Visible = which == "check"
		goDots.Visible = which == "dots"
	end

	check = function()
		if K.busy or K.done or leaving then return end
		local key = string.upper(trim(input.Text))
		if key == "" then
			setField("warn")
			hero.SetMood("worried")
			say("empty")
			setMsg("warn", "Paste your key first.", "alert")
			if not touchOnly then input:CaptureFocus() end
			return
		end
		K.busy = true
		goIcon("dots")
		input.TextTransparency = 0.45
		setField(nil)
		hero.SetMood("normal")
		say("checking")
		setMsg(nil, "Checking your key…", "clock")
		task.spawn(function()
			local started = os.clock()
			local r = validate(opt, key)
			local left = 1.2 - (os.clock() - started)
			if left > 0 then task.wait(left) end
			if not alive or leaving then return end
			K.busy = false
			input.TextTransparency = 0
			if r.Valid then
				r.Key = key
				success(r)
				return
			end
			goIcon("arrow")
			stepDone(3, false)
			if r.Reason == "Expired" then
				setField("warn")
				hero.SetMood("worried")
				say("expired")
				setMsg("warn", "This key ran out.", "clock", "Get a fresh one", function()
					show("get")
					task.delay(0.35, function()
						if not alive then return end
						-- ksFlash: brighter and lifted for a moment
						seq(linkFlash, { { 0.24, { BackgroundTransparency = 0.88 } }, { 0.48, {} }, { 0.88, { BackgroundTransparency = 1 } } }, "flash")
						seq(linkBtn, { { 0.24, { Position = UDim2.new(0.5, 0, 0.5, -2) } }, { 0.48, {} }, { 0.88, { Position = UDim2.fromScale(0.5, 0.5) } } }, "flash")
					end)
				end)
			else
				setField("error")
				hero.SetMood("sad")
				say("invalid")
				setMsg("error", "That key doesn't work. Check it for typos.", "xCircle")
			end
		end)
	end
	go.Activated:Connect(check)

	local function showDone(r)
		-- Badge and time left
		local prem = r.Premium == true
		local bt = prem and "PREMIUM" or "FREE"
		local bw = math.ceil(measure(bt, F_BODY_X, 10.5).X + 18)
		local badge = box(doneSub, prem and WHITE or mix(T.acc1, 0.18, T.bg), { Size = UDim2.fromOffset(bw, 19), LayoutOrder = 1 })
		corner(badge, FULL)
		if prem then gradient(badge, T.btn1, T.btn2) end
		label(badge, { Size = UDim2.fromScale(1, 1), Text = bt, FontFace = F_BODY_X, TextSize = 10.5, TextColor3 = prem and WHITE or T.accText })
		local txt = ""
		if prem then
			txt = "Never expires"
		elseif r.ExpiresIn then
			txt = string.format("Valid for %dh %dm", math.floor(r.ExpiresIn / 3600), math.floor(r.ExpiresIn / 60) % 60)
		end
		if txt ~= "" then
			label(doneSub, { AutomaticSize = AUTO_X, Size = UDim2.fromOffset(0, 22), Text = txt, TextSize = 14, TextColor3 = T.sub, LayoutOrder = 2 })
		end
		doneNote.Text = "Key saved. You won't see this screen until it runs out."

		-- The column fades and lifts away, the splash rises in
		local list = capture(column)
		anim(0.45, function(a)
			applyAlpha(list, 1 - a)
			heroShadowState.alpha = 1 - a
		end, QUART)
		tw(column, 0.6, { Position = UDim2.new(0.5, 0, 0.5, -18) })
		tw(colScale, 0.6, { Scale = (K.scale or 1) * 0.98 })
		task.delay(0.6, function()
			if alive and not leaving then column.Visible = false end
		end)
		done.Visible = true
		dropIn(doneMascot, 0.2)
		shadowIn(doneShadowState, 0.2)
		task.delay(1.2, function()
			doneBob.on = true
			doneBob.t = os.clock() - t0
		end)
		rise(doneTitle, 0.55, 0.5)
		rise(doneSub, 0.65, 0.5)
		rise(doneNote, 0.7, 0.5)
		rise(barTrack, 0.75, 0.5)
		rise(doneLaunch, 0.75, 0.5)
		tw(barFill, 2, { Size = UDim2.fromScale(1, 1) }, QUART, OUT, 0.6)
	end

	success = function(r)
		K.done = true
		input.TextEditable = false
		pcall(function() input:ReleaseFocus() end)
		setField("ok")
		hero.SetMood("happy")
		stepDone(3, true)
		say("ok")
		setMsg("ok", "Key accepted!", "checkCircle")
		goIcon("check")
		tw(goOk, 0.3, { BackgroundTransparency = 0 })
		goCheckScale.Scale = 1
		seq(goCheckScale, { { 0.16, { Scale = 1.22 } }, { 0.24, { Scale = 1 } } }, "pop")
		fileWrite(keyPath, r.Key)
		task.delay(0.65, function()
			if alive and not leaving then showDone(r) end
		end)
		task.delay(3.5, function()
			if not alive or leaving then return end
			leave()
			task.spawn(safeCall, opt.OnSuccess, r)
		end)
	end

	-- Leaving: everything fades, the blur goes back to 0, then it's all destroyed
	local function cleanup()
		alive = false
		for _, c in ipairs(conns) do c:Disconnect() end
		gui:Destroy()
		blur:Destroy()
	end
	leave = function(after)
		if leaving then return end
		leaving = true
		root.Modal = false
		pcall(function() input:ReleaseFocus() end)
		tw(blur, 0.9, { Size = 0 })
		local fgList = capture(layer)
		local bgList = capture(tint)
		anim(0.45, function(a)
			applyAlpha(fgList, 1 - a)
			fg.alpha = 1 - a
		end, LINEAR)
		anim(0.8, function(a)
			applyAlpha(bgList, 1 - a)
			back.alpha = 1 - a
		end, QUART)
		for _, o in ipairs({ column, done }) do
			tw(o, 0.6, { Position = o.Position + UDim2.fromOffset(0, 14) })
		end
		task.delay(0.9, function()
			cleanup()
			if after then after() end
		end)
	end

	K.Close = function()
		if leaving or not alive then return end
		leave(function() safeCall(opt.OnClose) end)
	end
	K.Say = function(id) say(id) end
	K.Show = function(name) show(name) end
	K.Notify = function(o) return notify(o) end

	---------------- Buttons ----------------
	local function press(btn, sc, to)
		btn.MouseButton1Down:Connect(function() tw(sc, 0.12, { Scale = to }, Enum.EasingStyle.Quad) end)
		local function up() tw(sc, 0.3, { Scale = 1 }, BACK) end
		btn.MouseButton1Up:Connect(up)
		btn.MouseLeave:Connect(up)
	end
	local function pressPulse(sc, to)
		seq(sc, { { 0.12, { Scale = to }, QUART, OUT }, { 0.18, { Scale = 1 }, QUART, OUT } }, "press")
	end

	-- Close
	local closeScale = make("UIScale", { Parent = closeBtn })
	press(closeBtn, closeScale, 0.92)
	closeBtn.MouseEnter:Connect(function()
		tw(closeBtn, 0.2, { BackgroundColor3 = mix(T.bad, 0.12, T.bg), BackgroundTransparency = 0 })
		closeIcon.SetColor(T.bad, 0.2)
	end)
	closeBtn.MouseLeave:Connect(function()
		tw(closeBtn, 0.2, { BackgroundColor3 = T.bg, BackgroundTransparency = 0.3 })
		closeIcon.SetColor(T.sub, 0.2)
	end)
	closeBtn.Activated:Connect(function() K.Close() end)

	-- Arrow
	press(go, goScale, 0.9)
	go.MouseEnter:Connect(function()
		if goEmpty then
			tw(goDim, 0.2, { BackgroundTransparency = 0.4 })
		else
			tw(goArrow.Frame, 0.3, { Position = UDim2.new(0.5, 2, 0.5, 0) }, BACK)
		end
	end)
	go.MouseLeave:Connect(function()
		tw(goDim, 0.2, { BackgroundTransparency = goEmpty and 0.55 or 1 })
		tw(goArrow.Frame, 0.3, { Position = UDim2.fromScale(0.5, 0.5) }, BACK)
	end)

	-- Get key
	press(getBtn, getScale, 0.97)
	getBtn.MouseEnter:Connect(function()
		sheenG.Offset = Vector2.new(-1, 0)
		tw(sheenG, 0.8, { Offset = Vector2.new(1, 0) })
		tw(getBtn, 0.25, { Position = UDim2.new(0.5, 0, 0.5, -1) }, BACK)
		tw(getIcon.Frame, 0.5, { Rotation = -14 }, BACK)
		tw(getIconScale, 0.5, { Scale = 1.1 }, BACK)
	end)
	getBtn.MouseLeave:Connect(function()
		sheenG.Offset = Vector2.new(-1, 0)
		tw(getBtn, 0.25, { Position = UDim2.fromScale(0.5, 0.5) }, BACK)
		tw(getIcon.Frame, 0.5, { Rotation = 0 }, BACK)
		tw(getIconScale, 0.5, { Scale = 1 }, BACK)
	end)
	-- Opens the key page, copies the link as a backup, and says what happened
	local function openKeyPage()
		local opened = openUrl(opt.KeyLink)
		local copied = clip(opt.KeyLink)
		local content
		if opened and copied then
			content = "Your browser should be on the key page now. If it didn't open, the link is copied, so paste it in your browser."
		elseif opened then
			content = "Your browser should be on the key page now. If it didn't open, go to " .. opt.KeyLink
		elseif copied then
			content = "The key link is copied. Paste it in your browser to get your key."
		else
			content = "Open this link in your browser: " .. opt.KeyLink
		end
		notify({
			Type = "success",
			Title = opened and "Opening the key page" or "Get your key",
			Content = content,
			Mood = "happy",
			Duration = 10,
		})
		stepDone(1, true)
		task.delay(0.9, function()
			if alive then stepDone(2, true) end
		end)
		return opened or copied
	end
	-- Same as the design: "Get key" opens the steps view. Its "Copy key link" button
	-- opens the page, copies the link and shows the notification.
	getBtn.Activated:Connect(function()
		if K.done then return end
		show("get")
	end)

	-- Switch buttons
	local function switchHover(b, ic, l, hoverColor, onEnterIcon)
		local icBase = ic.Frame.Position
		b.MouseEnter:Connect(function()
			tw(b, 0.15, { BackgroundTransparency = 0.85 })
			tw(l, 0.15, { TextColor3 = hoverColor })
			ic.SetColor(hoverColor, 0.15)
			onEnterIcon(ic.Frame, icBase)
		end)
		b.MouseLeave:Connect(function()
			tw(b, 0.15, { BackgroundTransparency = 1 })
			tw(l, 0.15, { TextColor3 = T.sub })
			ic.SetColor(T.sub, 0.15)
			tw(ic.Frame, 0.3, { Rotation = 0, Position = icBase }, BACK)
		end)
	end
	switchHover(helpBtn, helpIcon, helpText, T.accText, function(f) tw(f, 0.3, { Rotation = -12 }, BACK) end)
	switchHover(backBtn, backIcon, backText, T.text, function(f, base) tw(f, 0.3, { Position = base + UDim2.fromOffset(-2, 0) }, BACK) end)
	backBtn.Activated:Connect(function() show("key") end)

	helpBtn.Activated:Connect(function()
		if K.done then return end
		hero.SetMood("worried")
		say("help")
		notify({
			Title = "Having trouble?",
			Content = "Join our Discord and open a ticket. We'll help you get your key.",
			Mood = "worried",
			Action = { Title = "Copy Discord invite", Icon = "message", Callback = function() copyDiscord() end },
		})
	end)

	-- Copy key link
	local linkTok = 0
	linkBtn.Activated:Connect(function()
		openKeyPage()
		linkTok = linkTok + 1
		local my = linkTok
		tw(linkOk, 0.3, { BackgroundTransparency = 0 })
		linkTitle.Text = "Link copied"
		linkIcon.Frame.Visible = false
		linkCheck.Frame.Visible = true
		linkCheckScale.Scale = 1
		seq(linkCheckScale, { { 0.16, { Scale = 1.22 } }, { 0.24, { Scale = 1 } } }, "pop")
		linkChevron.Frame.Visible = false
		pressPulse(linkScale, 0.97)
		task.delay(2.4, function()
			if my ~= linkTok or not alive then return end
			tw(linkOk, 0.3, { BackgroundTransparency = 1 })
			linkTitle.Text = "Copy key link"
			linkIcon.Frame.Visible = true
			linkCheck.Frame.Visible = false
			linkChevron.Frame.Visible = true
		end)
	end)
	local linkChipScale = make("UIScale", { Parent = linkChip })
	linkBtn.MouseEnter:Connect(function()
		tw(linkChip, 0.4, { Rotation = -8 }, BACK)
		tw(linkChipScale, 0.4, { Scale = 1.05 }, BACK)
		tw(linkChevron.Frame, 0.3, { Position = UDim2.new(1, -11, 0.5, 0) }, BACK)
	end)
	linkBtn.MouseLeave:Connect(function()
		tw(linkChip, 0.4, { Rotation = 0 }, BACK)
		tw(linkChipScale, 0.4, { Scale = 1 }, BACK)
		tw(linkChevron.Frame, 0.3, { Position = UDim2.new(1, -14, 0.5, 0) }, BACK)
	end)

	-- Discord
	local pillTok, pillDone, discordHover = 0, false, false
	local function paintPill()
		local bg = mix(T.acc1, discordHover and 0.26 or 0.18, T.bg)
		if pillDone then bg = T.okDeep end
		tw(pill, 0.2, { BackgroundColor3 = bg })
		tw(pillText, 0.2, { TextColor3 = pillDone and WHITE or T.accText })
	end
	copyDiscord = function()
		clip(opt.Discord)
		pillTok = pillTok + 1
		local my = pillTok
		pillDone = true
		pillText.Text = "Copied"
		pillCheck.Frame.Visible = true
		pillCheckScale.Scale = 1
		seq(pillCheckScale, { { 0.16, { Scale = 1.22 } }, { 0.24, { Scale = 1 } } }, "pop")
		tw(pill, 0.2, { Size = UDim2.fromOffset(math.ceil(measure("Copied", F_BODY_X, 12).X + 12 + 5 + 24), 32) })
		paintPill()
		pressPulse(discordScale, 0.97)
		task.delay(1.8, function()
			if my ~= pillTok or not alive then return end
			pillDone = false
			pillText.Text = "Copy invite"
			pillCheck.Frame.Visible = false
			tw(pill, 0.2, { Size = UDim2.fromOffset(pillW, 32) })
			paintPill()
		end)
	end
	discordBtn.Activated:Connect(copyDiscord)
	discordBtn.MouseEnter:Connect(function()
		discordHover = true
		tw(discordBtn, 0.2, { BackgroundColor3 = mix(T.acc1, 0.13, T.bg) })
		tw(discordChip, 0.4, { Rotation = -8 }, BACK)
		tw(discordChipScale, 0.4, { Scale = 1.05 }, BACK)
		paintPill()
	end)
	discordBtn.MouseLeave:Connect(function()
		discordHover = false
		tw(discordBtn, 0.2, { BackgroundColor3 = mix(T.acc1, 0.09, T.bg) })
		tw(discordChip, 0.4, { Rotation = 0 }, BACK)
		tw(discordChipScale, 0.4, { Scale = 1 }, BACK)
		paintPill()
	end)

	---------------- Start ----------------
	resetMsg()
	local hw, hh = bubbleSize(SAY.hello)
	bubbleHolder.Size = UDim2.fromOffset(hw, hh)
	bubH = hh
	relayout(0)

	gui.Parent = parent
	updateScale()
	conns[#conns + 1] = gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScale)
	conns[#conns + 1] = RunService.RenderStepped:Connect(function()
		local now = os.clock() - t0
		for _, f in ipairs(ticks) do f(now) end
	end)

	-- Open: blur and backdrop fade in, the mochi drops, the rest rises in turn
	local tintList = capture(tint)
	applyAlpha(tintList, 0)
	anim(0.8, function(a)
		applyAlpha(tintList, a)
		back.alpha = a
	end, QUART)
	tw(blur, 0.9, { Size = opt.Blur })
	dropIn(hero, 0.2)
	shadowIn(heroShadowState, 0.2)
	rise(bubbleHolder, 0.5)
	rise(fieldHolder, 0.6)
	rise(msgHolder, 0.6)
	rise(getHolder, 0.7)
	rise(helpHolder, 0.85)
	rise(closeHolder, 0.85)
	rise(footer, 0.85)
	task.delay(0.65, function()
		if alive and not leaving then say("hello") end
	end)
	if not touchOnly then
		task.delay(1.1, function()
			if alive and not leaving and K.view == "key" and not K.done then input:CaptureFocus() end
		end)
	end
	if K._closeRequested then K.Close() end
end

------------------------------------------------------------------------
-- Init
------------------------------------------------------------------------

-- Folder for saved files: the title without spaces or symbols ("Mochi Hub" gives "MochiHub")
local function saveDir(title)
	local dir = tostring(title or "Mochi Hub"):gsub("[^%w_%-]", "")
	if dir == "" then dir = "MochiHub" end
	return dir
end

local function run(opt, K)
	local dir = saveDir(opt.Title)
	local keyPath = dir .. "/key.txt"

	-- The hub's saved theme wins when there is one
	local savedTheme = trim(fileRead(dir .. "/theme.txt") or "")
	if THEMES[savedTheme] then opt.Theme = savedTheme end

	-- A saved key that's still valid skips the screen
	local saved = string.upper(trim(fileRead(keyPath) or ""))
	if saved ~= "" then
		log("Found a saved key, checking it")
		local r, errored = validate(opt, saved)
		if r.Valid then
			r.Key = saved
			K.Skipped = true
			K.done = true
			log("Saved key is still valid, so the key screen is skipped. MochiKey:ResetKey(\"" .. opt.Title .. "\") shows it again.")
			safeCall(opt.OnSuccess, r)
			return
		elseif not errored then
			log("Saved key is " .. string.lower(r.Reason) .. ", deleting it")
			fileDelete(keyPath)
		end
	end

	buildScreen(opt, K, buildTheme(opt.Theme), keyPath)
	log("Key screen open (theme " .. opt.Theme .. ")")
end

-- Deletes the saved key so the screen shows next time. Handy while testing.
function MochiKey:ResetKey(title)
	if type(self) == "string" and title == nil then title = self end -- MochiKey.ResetKey("...")
	fileDelete(saveDir(title) .. "/key.txt")
end

function MochiKey:Init(o)
	-- Works as MochiKey:Init{...} and MochiKey.Init{...}
	if o == nil and type(self) == "table" and self ~= MochiKey then o = self end
	o = o or {}
	local opt = {
		Title = tostring(o.Title or "Mochi Hub"),
		Theme = THEMES[o.Theme] and o.Theme or "Mochi",
		KeyLink = tostring(o.KeyLink or "https://example.com/get-key"),
		Discord = tostring(o.Discord or "discord.gg/example"),
		Blur = tonumber(o.Blur) or 16,
		Validate = o.Validate or function() return { Valid = false, Reason = "Invalid" } end,
		OnSuccess = o.OnSuccess,
		OnClose = o.OnClose,
	}
	local K = {}
	K.Close = function() K._closeRequested = true end
	-- No pcall here on purpose: if something breaks, the executor console shows the real error
	task.spawn(run, opt, K)
	return K
end

return MochiKey
