local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local meteorsFolder = workspace.Map:WaitForChild("Meteors")
local espColor = Color3.fromRGB(255, 100, 0)
local triggerRadius = 30
local activeESP = {}

local removeESP, createESP do
    removeESP = function(part)
        if activeESP[part] then
            for _, obj in ipairs(activeESP[part]) do
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end
            activeESP[part] = nil
        end
    end

    createESP = function(part)
        if activeESP[part] then return end
        activeESP[part] = {}
    
        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 1
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = espColor
        highlight.Name = "MeteorCoreESP"
        highlight.Parent = part
        table.insert(activeESP[part], highlight)
    
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.AlwaysOnTop = true
        billboard.Name = "MeteorCoreESP"
    
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "Meteor Core"
        label.TextColor3 = espColor
        label.TextStrokeTransparency = 0.5
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Parent = billboard
    
        billboard.Parent = part
        table.insert(activeESP[part], billboard)
    end
end

local Window = Library:CreateWindow({
	Title = "logans penis game",
	Footer = "version: v1",
	Icon = 95816097006870,
	NotifySide = "Right",
	ShowCustomCursor = false,
})
local Tabs = {
	Main = Window:AddTab("Main", "user"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}
local main = Tabs.Main:AddLeftGroupbox("Main", "boxes")
local misc = Tabs.Main:AddRightGroupbox("Misc", "boxes")


main:AddToggle("MyToggle", {
	Text = "Meteor ESP",
	Tooltip = nil,
	DisabledTooltip = "I am disabled!",

	Default = false,
	Disabled = false,
	Visible = true,
	Risky = false,

	Callback = function(Value)
		getgenv().meteor_esp = Value
	end,
})
main:AddToggle("MyToggle", {
	Text = "Auto Collect Meteor",
	Tooltip = nil,
	DisabledTooltip = "I am disabled!",

	Default = false,
	Disabled = false,
	Visible = true,
	Risky = false,

	Callback = function(Value)
		getgenv().collect_meteor = Value
        while collect_meteor do task.wait()
            for _, meteor in ipairs(meteorsFolder:GetChildren()) do
                local core = meteor:FindFirstChild("Core")
                if core and core:IsA("BasePart") then
                    local prompt = core:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        local dist = (hrp.Position - core.Position).Magnitude
                        if dist < triggerRadius then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end
	end,
})
local MyButton = misc:AddButton({
	Text = "Teleport to Meteor (Might get kicked)",
	Func = function()
        for _, meteor in ipairs(meteorsFolder:GetChildren()) do
            local core = meteor:FindFirstChild("Core")
            if core and core:IsA("BasePart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = core.CFrame
            end
        end
	end,
	DoubleClick = false,

	Tooltip = nil,
	DisabledTooltip = "I am disabled!",

	Disabled = false,
	Visible = true,
	Risky = true,
})

local PlaceId = game.PlaceId

local MyButton = misc:AddButton({
	Text = "Serverhop",
	Func = function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
        local body = HttpService:JSONDecode(req)
    
        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end
    
        if #servers > 0 then
            queue
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
        else
            return warn("Serverhop: Couldn't find a server.")
        end
	end,
	DoubleClick = false,

	Tooltip = nil,
	DisabledTooltip = "I am disabled!",

	Disabled = false,
	Visible = true,
	Risky = true,
})


task.spawn(function()
    while true do task.wait(0.1)

        for part, _ in pairs(activeESP) do
            if not meteor_esp then
                removeESP(part)
            end
        end

        if meteor_esp then
            for _, meteor in ipairs(meteorsFolder:GetChildren()) do
                local core = meteor:FindFirstChild("Core")
                if core and core:IsA("BasePart") then
                    createESP(core)
                end
            end
        end
    end
end)

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
        local mainGame = 16228276182
        wait(1)
        game:GetService("TeleportService"):Teleport(mainGame, game.Players.LocalPlayer)
    end
end)
