local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local Window = Rayfield:CreateWindow({
   Name = "NextByte",
   Icon = 0,
   LoadingTitle = "Loading Utils...",
   LoadingSubtitle = "by Luacide",
   ShowText = "NextByte",
   Theme = "Default",
   ToggleUIKeybind = "E",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

-- =====================
--       MISC TAB
-- =====================
local MiscTab = Window:CreateTab("Misc", "layout-dashboard")

-- Speed/Jump Section
local SpeedJumpSection = MiscTab:CreateSection("Speed/Jump")
SpeedJumpSection:Set("Speed/Jump")

local speedValue = 16 -- default walkspeed
local jumpValue = 50  -- default jumppower

local SpeedSlider = MiscTab:CreateSlider({
   Name = "Speed",
   Range = {1, 300},
   Increment = 1,
   Suffix = "WS",
   CurrentValue = speedValue,
   Flag = "SpeedValue",
   Callback = function(Value)
      speedValue = Value
      if character and humanoid then
         humanoid.WalkSpeed = Value
      end
   end,
})

local JumpSlider = MiscTab:CreateSlider({
   Name = "Jump",
   Range = {1, 300},
   Increment = 1,
   Suffix = "JP",
   CurrentValue = jumpValue,
   Flag = "JumpValue",
   Callback = function(Value)
      jumpValue = Value
      if character and humanoid then
         humanoid.JumpPower = Value
      end
   end,
})

-- Gravity Section
local GravitySection = MiscTab:CreateSection("Gravity")
GravitySection:Set("Gravity")

local gravityEnabled = true

local GravityToggle = MiscTab:CreateToggle({
   Name = "Gravity",
   CurrentValue = true,
   Flag = "GravityOnorOff",
   Callback = function(Value)
      gravityEnabled = Value
      Workspace.Gravity = Value and 196.2 or 0
   end,
})

local DestroyGravitySelf = MiscTab:CreateButton({
   Name = "Permanently Destroy Gravity For Self",
   Callback = function()
      if character and rootPart then
         local bg = Instance.new("BodyForce")
         bg.Force = Vector3.new(0, Workspace.Gravity * humanoid:GetMass() * 100, 0)
         bg.Parent = rootPart
      end
   end,
})

local DestroyGravityAll = MiscTab:CreateButton({
   Name = "Destroy Gravity For All",
   Callback = function()
      Workspace.Gravity = 0
   end,
})

-- Health Section
local HealthSection = MiscTab:CreateSection("Health")
HealthSection:Set("Health")

local MiscTab_InfHealth = MiscTab:CreateToggle({
   Name = "Infinite Health",
   CurrentValue = false,
   Flag = "InfHealth",
   Callback = function(Value)
      if Value then
         humanoid.MaxHealth = math.huge
         humanoid.Health = math.huge
      else
         humanoid.MaxHealth = 100
         humanoid.Health = 100
      end
   end,
})

-- ========================
--     TELEPORT TAB
-- ========================
local TeleportTab = Window:CreateTab("Teleport", "map-pin")

local TeleportSection = TeleportTab:CreateSection("Teleport")
TeleportSection:Set("Teleport")

-- Teleport to random place on baseplate
local RandomTeleportButton = TeleportTab:CreateButton({
   Name = "Teleport to Random Place on Baseplate",
   Callback = function()
      if rootPart then
         local randomX = math.random(-500, 500)
         local randomZ = math.random(-500, 500)
         rootPart.CFrame = CFrame.new(randomX, 5, randomZ)
      end
   end,
})

-- Teleport to a player (dropdown + button)
local selectedTarget = nil

local function getPlayerNames()
   local names = {}
   for _, p in ipairs(Players:GetPlayers()) do
      if p ~= player then
         table.insert(names, p.Name)
      end
   end
   return names
end

local TeleportToDropdown = TeleportTab:CreateDropdown({
   Name = "Select Player to Teleport To",
   Options = getPlayerNames(),
   CurrentOption = {""},
   Flag = "TeleportToTarget",
   Callback = function(Value)
      selectedTarget = Value[1]
   end,
})

local TeleportToPlayerButton = TeleportTab:CreateButton({
   Name = "Teleport to Selected Player",
   Callback = function()
      if selectedTarget and selectedTarget ~= "" then
         local target = Players:FindFirstChild(selectedTarget)
         if target and target.Character then
            rootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(3, 0, 0)
         end
      end
   end,
})

-- Teleport selected player to you
local TeleportHereDropdown = TeleportTab:CreateDropdown({
   Name = "Select Player to Bring Here",
   Options = getPlayerNames(),
   CurrentOption = {""},
   Flag = "TeleportHereTarget",
   Callback = function(Value)
      selectedTarget = Value[1]
   end,
})

local TeleportHereButton = TeleportTab:CreateButton({
   Name = "Teleport Selected Player to Me",
   Callback = function()
      if selectedTarget and selectedTarget ~= "" then
         local target = Players:FindFirstChild(selectedTarget)
         if target and target.Character then
            target.Character.HumanoidRootPart.CFrame = rootPart.CFrame + Vector3.new(3, 0, 0)
         end
      end
   end,
})

-- Teleport all players to you
local TeleportAllButton = TeleportTab:CreateButton({
   Name = "Teleport All Players to Me",
   Callback = function()
      for _, p in ipairs(Players:GetPlayers()) do
         if p ~= player and p.Character then
            p.Character.HumanoidRootPart.CFrame = rootPart.CFrame + Vector3.new(3, 0, 0)
         end
      end
   end,
})

local Tab = Window:CreateTab("Script Hubs", "boxes")

local TeleportSection = TeleportTab:CreateSection("Script Hubs")
TeleportSection:Set("Script Hubs")

local Button = Tab:CreateButton({
   Name = "Btools",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))();
   end,
})

local Button = Tab:CreateButton({
   Name = "Dex-Explorer",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))();
   end,
})

local Tab = Window:CreateTab("Source", "braces")

local TeleportSection = TeleportTab:CreateSection("Source Code Link")
TeleportSection:Set("Source Code Link")

local Button = Tab:CreateButton({
   Name = "Copy Src Link",
   Callback = function()
    setclipboard("https://raw.githubusercontent.com/Luacide/Random_Lua_Cheatpanel/refs/heads/main/Main.lua")
   end,
})
