
local Engine = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Services = {
	["Players"] = game:GetService("Players"),
	["InsertService"] = game:GetService("InsertService"),
	["Debris"] = game:GetService("Debris"),
	["TweenService"] = game:GetService("TweenService"),
	["RunService"] = game:GetService("RunService"),
	["Workspace"] = game:GetService("Workspace"),
}

local Players = game:GetService("Players")

local XIIX = game:GetObjects("rbxasset://XIIXPack.Rbxm")[1] --or getcustomasset("rbxasset://XIIXPack.Rbxm")

function SortTable(SelectedTable)
	table.sort(SelectedTable,function(a,b)
		return a < b
	end)
end

local FullHatSetNames = {};
local PlayersTable = {"LocalPlayer"}


----------------------------------------

for I,V in pairs(XIIX.GeodesHatting.XHat:GetChildren()) do
	table.insert(FullHatSetNames, V.Name)
end
SortTable(FullHatSetNames)


----------------------------------------

for I,V in pairs(Players:GetPlayers()) do
	table.insert(PlayersTable, V.Name)
end

SortTable(PlayersTable)

function AddPlayer(Player)
	table.insert(PlayersTable, Player.Name)
	SortTable(PlayersTable)
end

function RemovePlayer(Player)
	table.remove(PlayersTable, table.find(PlayersTable,Player.Name))
	SortTable(PlayersTable)
end

Players.PlayerAdded:Connect(AddPlayer)
Players.PlayerRemoving:Connect(RemovePlayer)


local ExtraValue2 = {
	"Normal",
	"UwU",	
	"Chaosify",
	"Rainbowify",
	"CustomColor",
}

_G.GeodeTable = {
ChosenHatPack = "Shork",
ChosenExtraValue1 = 1 ,
ChosenExtraValue2 = "Normal",
TargetPlayer = Players.LocalPlayer,
RespawnWithOutfit = false,
HexColor1 = "",
HexColor2 = "",
}

local	GeodeHatting = function()
	local Table
	if not _G.GeodeTable then
		return
	else
		Table = _G.GeodeTable
	end
	task.spawn(function()
		local HatPack = Table.ChosenHatPack
		local ExtraValue = Table.ChosenExtraValue1
		local ExtraValue2 = Table.ChosenExtraValue2
		local SaveOutfit = Table.RespawnWithOutfit
		local RX = XIIX.GeodesHatting
		local X = RX.XHat
		local Plr : Player = Table.TargetPlayer
		local HatPackage = X:WaitForChild(tostring(HatPack),50):Clone()
		local HiddenLimbs = RX.HiddenLimbs
		local Character = Plr.Character
		local HatsResized = {}
		local Connections = {}
		local AllConnect = {}
		local NewHats
		local FoodDemonTable = {29, 30, 31, 41, 42, 66, 67, 68, 69, 70, 71, 72, 73, 74, 76, 77}
		local PV = false
		local RBCEnabled = false
		local RainbowEnabled = false
		local LColor
		local LColor2

		local HB = Services["RunService"].Heartbeat

		local ColorablePartsTable1 = {}
		local ColorablePartsTable2 = {}
		local RecolorPart = function(v,Color)
			if v:IsA("BasePart") or v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
				v.Color = Color
			elseif v:IsA("Decal") then
				v.Color3 = Color
			elseif v:IsA("ImageLabel") then
				v.ImageColor3 = Color
			elseif v:IsA("Trail") or v:IsA("ParticleEmitter") or v:IsA("Beam") then
				v.Color = ColorSequence.new(Color,Color)
			end
		end

		local r = 255
		local g = 0
		local b = 0
		task.spawn(function()
			while task.wait() do
				for i = 0, 254/5 do
					task.wait()
					g = g + 5
				end
				for i = 0, 254/5 do
					task.wait()
					r = r - 5
				end
				for i = 0, 254/5 do
					task.wait()
					b = b + 5
				end
				for i = 0, 254/5 do
					task.wait()
					g = g - 5
				end
				for i = 0, 254/5 do
					task.wait()
					r = r + 5
				end
				for i = 0, 254/5 do
					task.wait()
					b = b - 5
				end
			end
		end)

		task.spawn(function()
			while task.wait() do
				if RBCEnabled == true  then
					LColor = BrickColor.Random()
					LColor2 = BrickColor.Random()
					for i,v in ColorablePartsTable1 do
						RecolorPart(v,LColor.Color)
					end
					for i,v in ColorablePartsTable2 do
						RecolorPart(v,LColor2.Color)
					end
				elseif RainbowEnabled == true  then
					LColor = Color3.fromRGB(r,g,b)
					LColor2 = Color3.fromRGB(r,g,b)
					for i,v in ColorablePartsTable1 do
						RecolorPart(v,LColor.Color)
					end
					for i,v in ColorablePartsTable2 do
						RecolorPart(v,LColor2.Color)
					end
				end
			end
		end)

		local CustomColor = function()
			task.spawn(function()
				RainbowEnabled = false
				RBCEnabled = false
				local Color
				local Color2
				Color = Color3.fromHex(Table.HexColor1)
				Color2 = Color3.fromHex(Table.HexColor2)
				for i,v in ColorablePartsTable1 do
					RecolorPart(v,Color)
				end
				for i,v in ColorablePartsTable2 do
					RecolorPart(v,Color2)
				end
			end)
		end

		local RandomBrickColor = function()
			RainbowEnabled = false
			RBCEnabled = true
		end

		-------- RAINBOW LEAVE IT TO ME

		local Rainbowify = function()
			RainbowEnabled = true
			RBCEnabled = false
		end


		------------------------------------------Below Is What Welds The Hats Together--------------------------------------------------------------

		local function weldAttachments(attach1, attach2)
			local weld = Instance.new("Weld")
			weld.Part0 = attach1.Parent
			weld.Part1 = attach2.Parent
			weld.C0 = attach1.CFrame
			weld.C1 = attach2.CFrame
			weld.Parent = attach1.Parent
			return weld
		end

		local function buildWeld(weldName, parent, part0, part1, c0, c1)
			local weld = Instance.new("Weld")
			weld.Name = weldName
			weld.Part0 = part0
			weld.Part1 = part1
			weld.C0 = c0
			weld.C1 = c1
			weld.Parent = parent
			return weld
		end

		local function findFirstMatchingAttachment(model, name)
			for _, child in pairs(model:GetChildren()) do
				if child:IsA("Attachment") and child.Name == name then
					return child
				elseif not child:IsA("Accoutrement") and not child:IsA("Tool") then -- Don't look in hats or tools in the character
					local foundAttachment = findFirstMatchingAttachment(child, name)
					if foundAttachment then
						return foundAttachment
					end
				end
			end
		end

		local function addAccoutrement(character, accoutrement)  
			accoutrement.Parent = character
			local handle = accoutrement:FindFirstChild("Handle")
			if handle then
				local accoutrementAttachment = handle:FindFirstChildOfClass("Attachment")
				if accoutrementAttachment then
					local characterAttachment = findFirstMatchingAttachment(character, accoutrementAttachment.Name)
					if characterAttachment then
						weldAttachments(characterAttachment, accoutrementAttachment)
					end
				else
					local head = character:FindFirstChild("Head")
					if head then
						local attachmentCFrame = CFrame.new(0, 0.5, 0)
						local hatCFrame = accoutrement.AttachmentPoint
						buildWeld("HeadWeld", head, head, handle, attachmentCFrame, hatCFrame)
					end
				end
			end
		end

		------------------------------------------Above Is What Welds The Hats Together--------------------------------------------------------------

		local function RemoveHatsAndRecolor() 
			if HatPack == "FoodDemons" then
				NewHats = HatPackage:WaitForChild(tostring(ExtraValue),50):Clone()
			elseif HatPack == "WolframNightstalker" then
				NewHats = HatPackage:WaitForChild("NewHats".. ExtraValue2,50):Clone()
			else
				NewHats = HatPackage:WaitForChild("NewHats",50):Clone()
			end

			if not HatPackage:HasTag("Addon") then
				if game.PlaceId == 10449761463 then
					for _, PlrHats in pairs(Character:WaitForChild("FakeHead",50):GetChildren()) do
						if  PlrHats:IsA("Accessory") or 
							PlrHats:IsA("Hat")
						then
							PlrHats:Destroy()
						end
					end
				end
				for _, Meshes in pairs(Character:GetDescendants()) do

					if  Meshes.Name == "GirlTorso" or 
						Meshes.Name == "HiddenTorso" or 
						Meshes.Name == "InvisibleHead" or 
						Meshes.Name == "LA" or 
						Meshes.Name == "LL" or 
						Meshes.Name == "RA" or 
						Meshes.Name == "RL"

					then
						Meshes:Destroy()
					end
				end

				for _, PlrHats in pairs(Character:GetChildren()) do

					if HatPackage:HasTag("AddonWithClothes") then
						if PlrHats:IsA("Pants") or 
							PlrHats:IsA("Shirt")
						then
							PlrHats:Destroy()
						end
					else
						if  PlrHats:IsA("Accessory") or 
							PlrHats:IsA("Hat") or 
							PlrHats:IsA("BodyColors") or 
							PlrHats:IsA("CharacterMesh") or 
							PlrHats:IsA("Pants") or 
							PlrHats:IsA("Shirt") or 
							PlrHats:IsA("ShirtGraphic")  
						then
							PlrHats:Destroy()
						end
					end
				end
			end

			for i,v in FoodDemonTable do
				if ExtraValue == v and HatPack == "FoodDemons" then
					PV = true
				end
			end

			if HatPackage:HasTag("Headless") or  PV == true  then --Invisible Head
				HiddenLimbs.InvisibleHead:Clone().Parent = Character["Head"]

			end
			if HatPackage:HasTag("FullBody") or PV == true then --Invisible Full Body
				HiddenLimbs.HiddenTorso:Clone().Parent = Character["Torso"]
				HiddenLimbs.LA:Clone().Parent = Character["Left Arm"]
				HiddenLimbs.LL:Clone().Parent = Character["Left Leg"]
				HiddenLimbs.RA:Clone().Parent = Character["Right Arm"]
				HiddenLimbs.RL:Clone().Parent = Character["Right Leg"]
			end
			if HatPackage:HasTag("HiddenTopBody") then --Invisible Full Body
				HiddenLimbs.HiddenTorso:Clone().Parent = Character["Torso"]
				HiddenLimbs.LA:Clone().Parent = Character["Left Arm"]
				HiddenLimbs.RA:Clone().Parent = Character["Right Arm"]
			end
			if HatPackage:HasTag("UniverseIsR63d") then --female
				HiddenLimbs.GirlTorso:Clone().Parent = Character["Torso"]
				HiddenLimbs.LL:Clone().Parent = Character["Left Leg"]
				HiddenLimbs.RL:Clone().Parent = Character["Right Leg"]
			end
			if HatPackage:HasTag("TorsoAndLegs") then --female
				HiddenLimbs.HiddenTorso:Clone().Parent = Character["Torso"]
				HiddenLimbs.LL:Clone().Parent = Character["Left Leg"]
				HiddenLimbs.RL:Clone().Parent = Character["Right Leg"]
			end
			for _, PossibleDecal in pairs(Character["Head"]:GetChildren()) do
				if  PossibleDecal:IsA("Decal") and PossibleDecal.Name == "face" and (not HatPackage:HasTag("Addon") or HatPackage:HasTag("AddonWithClothes")) then
					if HatPackage:HasTag("FaceIncluded") then
						PossibleDecal.Texture = HatPackage:GetAttribute("Face")
					else
						PossibleDecal.Transparency = 1
					end
					if HatPackage:HasTag("FaceAnimated") then
						HatPackage["AnimatedFace"]:Clone().Parent = PossibleDecal
					end
				end
			end



			if HatPackage:HasTag("HasColors") then --V1 Used Tags To Differ Them From Getting set Without one
				if  HatPack == "FoodDemons" and ExtraValue ~= "42" or ExtraValue ~= "41" or ExtraValue ~= "31" or ExtraValue ~= "30" or ExtraValue ~= "29" or ExtraValue ~= "66" or ExtraValue ~= "67" or ExtraValue ~= "68" or ExtraValue ~= "69" or ExtraValue ~= "70" or ExtraValue ~= "71" or ExtraValue ~= "72" or ExtraValue ~= "74" or ExtraValue ~= "73" then			---These Extra Values in question Have no Body Color And Use Hidden Limbs 
					--[[local BodyColor = NewHats:FindFirstChildOfClass("Body Colors")
					Character["Head"].Color = BodyColor.HeadColor3
					Character["Torso"].Color = BodyColor.TorsoColor3
					Character["Left Arm"].Color = BodyColor.LeftArmColor3
					Character["Left Leg"].Color = BodyColor.LeftLegColor3
					Character["Right Arm"].Color = BodyColor.RightArmColor3
					Character["Right Leg"].Color = BodyColor.RightLegColor3]]
				else
					local Color = Instance.new("BodyColors", Character)
					Color.HeadColor3 = HatPackage:GetAttribute("Color")
					Color.TorsoColor3 = HatPackage:GetAttribute("Color")
					Color.LeftArmColor3 = HatPackage:GetAttribute("Color")
					Color.LeftLegColor3 = HatPackage:GetAttribute("Color")
					Color.RightArmColor3 = HatPackage:GetAttribute("Color")
					Color.RightLegColor3 = HatPackage:GetAttribute("Color")
				end
			end
		end
		if HatPackage:HasTag("UseAttributesColors") then --V1 Used Tags To Differ Them From Getting set Without one
			local Color = Instance.new("BodyColors", Character)
			Color.HeadColor3 = HatPackage:GetAttribute("Color")
			Color.TorsoColor3 = HatPackage:GetAttribute("Color")
			Color.LeftArmColor3 = HatPackage:GetAttribute("Color")
			Color.LeftLegColor3 = HatPackage:GetAttribute("Color")
			Color.RightArmColor3 = HatPackage:GetAttribute("Color")
			Color.RightLegColor3 = HatPackage:GetAttribute("Color")
		end
		if HatPackage:HasTag("UseBodyColors") then --V1 Used Tags To Differ Them From Getting set Without one
			--[[local BodyColor = HatPackage.NewHats:FindFirstChildOfClass("Body Colors")
			Character["Head"].Color = BodyColor.HeadColor3
			Character["Torso"].Color = BodyColor.TorsoColor3
			Character["Left Arm"].Color = BodyColor.LeftArmColor3
			Character["Left Leg"].Color = BodyColor.LeftLegColor3
			Character["Right Arm"].Color = BodyColor.RightArmColor3
			Character["Right Leg"].Color = BodyColor.RightLegColor3]]
		end


		--------------------------------------------------------------------------------------------------------
		local Attachments = {"LeftGripAttachment","RightGripAttachment","RightShoulderAttachment","LeftShoulderAttachment"}
		local function AddNewHats()
			for i,v in NewHats:GetDescendants() do
				if v:HasTag("Colorable") and not table.find(ColorablePartsTable1,v) then
					table.insert(ColorablePartsTable1, v)
				elseif v:HasTag("Colorable2") and not table.find(ColorablePartsTable1,v) then
					table.insert(ColorablePartsTable2, v)
				end
				if v:HasTag("TorsoColor") then
					v.Color = Character:FindFirstChildOfClass("BodyColors").TorsoColor3 or Character:FindFirstChild("Torso").Color
				end
				if v:IsA("BasePart") and v.Transparency == 1 then
					HiddenLimbs.Invisible:Clone().Parent = v
				end
			end

			for _, Prt in NewHats:GetChildren() do
				Prt.Parent = Character
				if Prt:IsA("Accessory") or Prt:IsA("Hat") then
					addAccoutrement(Character, Prt)
					Prt.Handle.Anchored = false
					Prt.Handle.CanCollide = false
					Prt.Handle.Massless = true
				end

				if ExtraValue2 == "Rainbowify" then
					Rainbowify()
				elseif ExtraValue2 == "Chaosify" then
					RandomBrickColor()
				elseif ExtraValue2 == "CustomColor" then
					CustomColor()
				end
				if HatPackage:HasTag("HeadMesh") then --V1 Used Tags To Differ Them From Getting set Without one
					Character["Head"]:FindFirstChildOfClass("SpecialMesh"):Destroy()
					HatPackage:WaitForChild("HeadMesh", 50):Clone().Parent = Character["Head"]
				end
				local Face = HatPackage:FindFirstChildOfClass("Decal")
				if Face and Face.Name == "face" then
					Face.Parent = Character["Head"]
				end
				if HatPackage:HasTag("CanHaveExtraArms") then
					if Character:FindFirstChild("SetAssets") then
						if Character:FindFirstChild("SetAssets"):FindFirstChild("HeianArms") then
							local P
							if Character:FindFirstChild("SetAssets"):FindFirstChild("HeianArms"):FindFirstChild("HeianArmsModel") then
								P = Character:FindFirstChild("SetAssets"):FindFirstChild("HeianArms"):WaitForChild("HeianArmsModel", 50)
							else
								P = Character:FindFirstChild("SetAssets"):WaitForChild("HeianArms", 50)
							end
							if HatPackage:HasTag("HiddenTopBody") or HatPackage:HasTag("FullBody") then
								P:FindFirstChild("Left Arm").Transparency = 1
								P:FindFirstChild("Right Arm").Transparency = 1
							end
							for z,x in pairs(Prt:GetDescendants()) do
								for _,Grip in Attachments do
									if x.Name == Grip then
										local Copies = x.Parent.Parent:Clone()
										Copies.Parent = P
										addAccoutrement(P, Copies)
									end
								end
							end
						end
					end
				end
			end
		end

		local function processCharacterAccessories(character)
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				warn("Humanoid not found in character")
				return
			end

			local scale = character:GetScale() -- Assuming uniform scaling, adjust as needed

			local headHats = {}
			local waistAccessories = {}
			local otherAccessories = {}

			for _, accessory in character:GetChildren() do
				if accessory:IsA("Accessory") then
					local handle = accessory:FindFirstChild("Handle")
					if handle and handle:IsA("BasePart") then
						-- Scale the handle and its descendants
						handle.Size = handle.Size * scale
						for _, descendant in handle:GetDescendants() do
							if descendant:IsA("BasePart") then
								descendant.Size = descendant.Size * scale
							elseif descendant:IsA("SpecialMesh") then
								descendant.Scale = descendant.Scale * scale
							end
						end

						-- Separate head hats, waist accessories, and other accessories
						local hatAttachment = handle:FindFirstChild("HatAttachment")
						local waistAttachment = handle:FindFirstChild("WaistAttachment")
						if hatAttachment then
							table.insert(headHats, accessory)
						elseif waistAttachment then
							table.insert(waistAccessories, accessory)
							-- Adjust waist accessory position
							local waistPosition = waistAttachment.Position * scale
							handle.Position = waistPosition
						else
							table.insert(otherAccessories, accessory)
						end
					end
				end
			end
		end

		local function Execute()

			task.wait(0.115)
			RemoveHatsAndRecolor()
			wait(0.025)
			if Character:GetScale() ~= 1 then
				local SavedScale = Character:GetScale()
				Character:ScaleTo(1)
				if HatPackage:HasTag("AddonWithClothes") then
					if Character:FindFirstChildOfClass("Shirt") then
						Character:FindFirstChildOfClass("Shirt"):Destroy()
					end
					if Character:FindFirstChildOfClass("Pants") then
						Character:FindFirstChildOfClass("Pants"):Destroy()
					end
				end
				AddNewHats()
				wait(0.025)
				processCharacterAccessories(Character)
				task.wait(0.025)
				Character:ScaleTo(SavedScale)
			else
				if HatPackage:HasTag("AddonWithClothes") then
					if Character:FindFirstChildOfClass("Shirt") then
						Character:FindFirstChildOfClass("Shirt"):Destroy()
					end
					if Character:FindFirstChildOfClass("Pants") then
						Character:FindFirstChildOfClass("Pants"):Destroy()
					end
				end
				AddNewHats()
				wait(0.025)
				processCharacterAccessories(Character)
				wait(0.025)
				if HatPackage:HasTag("UniverseIsR63d") then
					local P1 = Character["Left LegAccessory"].Handle.L_Leg
					local P2 = Character["Right LegAccessory"].Handle.R_Leg
					local S = Character["TorsoAccessory"].Handle.B.Clothing
					local L1 = Character["Left LegAccessory"].Handle.Skin
					local L2 = Character["Right LegAccessory"].Handle.Clothes
					local T1 = Character["TorsoAccessory"].Handle.B.B1
					local T2 = Character["TorsoAccessory"].Handle.B.B2
					local Shirt = Character:FindFirstChildOfClass("Shirt")
					local Pants = Character:FindFirstChildOfClass("Pants")
					L1.Color = Character["Left Leg"].Color
					L2.Color = Character["Right Leg"].Color
					T1.Color = Character["Torso"].Color
					T2.Color = Character["Torso"].Color
					if Shirt then
						S.TextureID = Shirt.ShirtTemplate
					end
					if Pants then
						P1.TextureID = Pants.PantsTemplate
						P2.TextureID = Pants.PantsTemplate
					end
				end
			end
		end

		Execute()


		local HatPackageS = HatPackage
		local ExtraValueSave = ExtraValue
		local ExtraValue2Save = ExtraValue2
		local PlrS = Plr


		local CharacterConnect = PlrS.CharacterAdded:Connect(function()
			if  SaveOutfit == true then
				repeat task.wait(0.5) until PlrS.Character.Parent ~= nil
				task.wait(0.1)
				HatPackage = HatPackageS
				ExtraValue = ExtraValueSave
				ExtraValue2 = ExtraValue2Save
				Character = PlrS.Character

				Execute()
			end
		end)

		table.insert(AllConnect, CharacterConnect)

		task.spawn(function()
			if  SaveOutfit == true then
				local BreakerObject = Instance.new("Configuration",Services["InsertService"])
				BreakerObject.Name = Plr.Name.."DeleteValue"
				BreakerObject:SetAttribute("Outfit", Table.ChosenHatPack .. "," .. Table.ChosenExtraValue1 .. "," .. Table.ChosenExtraValue2)
				BreakerObject.Destroying:Connect(function()
					SaveOutfit = false
					for _, Connect in pairs(AllConnect) do
						Connect:Disconnect()
					end
					print(Plr.Name," :AutoOutfitter Disabled")
				end)
			end
		end)
	end)
end


local	StopAutoOutfit = function()
	task.spawn(function()
		Services["InsertService"][_G.GeodeTable.TargetPlayer.Name.."DeleteValue"]:Destroy()
	end)
end



local MTitle = "X Gui: Client Edition"

local window1 = Engine:CreateWindow({
	Title = "X Gui: Client Edition",
	SubTitle = "by 『Ｘ』",
	TabWidth = 150,
	Size = UDim2.fromOffset(500, 400),
	Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
	Theme = "Solarized Dark",
	MinimizeKey = Enum.KeyCode.RightControl, -- Used when theres no MinimizeKeybind
	Version = "4.0 - Lite"
})


local Tabs = {
	MainTab = window1:AddTab({ Title = "Main", Icon = "box" }),
	Settings = window1:AddTab({ Title = "Settings", Icon = "settings" })
}

do

	-------------------------------------------------------------------------------------------------------------------MainTab

	local GH = Tabs.MainTab:AddSection("GeodesHatting")
	GH:AddButton({
		Title = "Execute",
		Description = "Executes The Selected Hat Set",
		Callback = function()
			Engine:Notify({
				Title = MTitle,
				Content = "GeodesHatting Executed: ".. tostring(_G.GeodeTable.ChosenHatPack),
				Duration = 3
			})
			GeodeHatting()
		end
	})

	GH:AddButton({
		Title = "Stop AutoOutfitter",
		Description = "Deletes A Value In Replicated Storage To Stop The AutoOutfitting",
		Callback = function()
			Engine:Notify({
				Title = MTitle,
				Content = "Attempted To Stop AutoOutfitter For ".. tostring(_G.GeodeTable.TargetPlayer),
				Duration = 3
			})
			StopAutoOutfit(_G.GeodeTable.TargetPlayer)
		end
	})

	-- AUTO-UPDATE: Use ValuesProvider for FullHatSetNames
	GH:AddDropdown("Dropdown", {
		Title = "Hat Set",
		Values = FullHatSetNames,
		ValuesProvider = function() return FullHatSetNames end,
		Multi = false,
		Default = 1,
		Callback = function(Value)
			Engine:Notify({
				Title = MTitle,
				Content = "Hat Set: " .. tostring(Value),
				Duration = 3
			})
			_G.GeodeTable.ChosenHatPack = Value
		end,
	})

	-- AUTO-UPDATE: Use ValuesProvider for PlayersTable
	GH:AddDropdown("Dropdown", {
		Title = "Player",
		Values = PlayersTable,
		ValuesProvider = function() return PlayersTable end,
		Multi = false,
		Default = "LocalPlayer",
		Callback = function(Value)
			Engine:Notify({
				Title = MTitle,
				Content = "Selected Player: " .. tostring(Value),
				Duration = 3
			})
			_G.GeodeTable.TargetPlayer = Players[Value]
		end,
	})

	GH:AddToggle("AutoOutfit", {Title = "ReOutfit On Respawn", Default = false,
		Callback = function(Value)
			_G.GeodeTable.RespawnWithOutfit = Value
			Engine:Notify({
				Title = MTitle,
				Content = "AutoOutfit Value: " .. tostring(Value),
				Duration = 3
			})
		end,	

	})

	GH:Slider("Slider", {
		Title = "Extra Value 1",
		Description = "Food Demon Number",
		Default = 1,
		Min = 1,
		Max = 77,
		Rounding = 0,
		Callback = function(Value)
			_G.GeodeTable.ChosenExtraValue1 = Value 
		end,
	})

	GH:AddDropdown("Dropdown", {
		Title = "Extra Value 2",
		Values = ExtraValue2,
		Multi = false,
		Default = 1,
		Callback = function(Value)
			Engine:Notify({
				Title = MTitle,
				Content = "Extra Value 2: " .. tostring(Value),
				Duration = 3
			})
			_G.GeodeTable.ChosenExtraValue2 = Value
		end,
	})

	GH:AddColorpicker("Colorpicker", {
		Title = "Color",
		Description = "Color for Colorable",
		Default = Color3.fromRGB(255, 255, 255),
		Callback = function(Value)
			Engine:Notify({
				Title = MTitle,
				Content = "Color changed: ("..Value:ToHex()..")",
				Duration = 3
			})
			_G.GeodeTable.HexColor1 = Value:ToHex() 
		end,
	})

	GH:AddColorpicker("Colorpicker", {
		Title = "Color",
		Description = "Color for Colorable2",
		Default = Color3.fromRGB(255, 255, 255),
		Callback = function(Value)
			Engine:Notify({
				Title = MTitle,
				Content = "Color changed: ("..Value:ToHex()..")",
				Duration = 3
			})
			_G.GeodeTable.HexColor2 = Value:ToHex() 
		end,
	})

	window1:SelectTab(1)
	SaveManager:SetLibrary(Engine)
	InterfaceManager:SetLibrary(Engine)

	SaveManager:IgnoreThemeSettings()

	SaveManager:SetIgnoreIndexes({})
	InterfaceManager:SetFolder("XGuiLite")
	SaveManager:SetFolder("XGuiLite/specific-game")

	InterfaceManager:BuildInterfaceSection(Tabs.Settings)
	SaveManager:BuildConfigSection(Tabs.Settings)
end


	do
		Engine:Notify({
			Title = "X Gui",
			Content = "X loaded.",
			Duration = 5
		})

		SaveManager:LoadAutoloadConfig()

	end