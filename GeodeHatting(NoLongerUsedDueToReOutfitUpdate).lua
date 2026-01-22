if not _G.HattingLoaded then
	_G.HattingLoaded = true
else
	return
end

local Players = game:GetService("Players")
local XIIX = game:GetObjects("rbxasset://XIIXPack.Rbxm")[1]
_G.GeodeHatting = function()
	
	
	task.spawn(function()
		local HatPack = _G.K1
		local ExtraValue = _G.K2
		local ExtraValue2 = _G.K3
		local SaveOutfit = _G.K5
		local RX = XIIX.GeodesHatting
		local X = RX.XHat
		local Plr = _G.K4
		local HatPackage = X:WaitForChild(tostring(HatPack),50):Clone()
		print(tostring(HatPackage))
		local HiddenLimbs = RX.HiddenLimbs
		local Player = Plr.Character
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

		local HB = game:GetService("RunService").Heartbeat
		
		local ColorablePartsTable1 = {}
		local ColorablePartsTable2 = {}
		local RecolorPart = function(v,Color)
			if v:IsA("BasePart") then
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
				Color = Color3.fromHex(_G.K6)
				Color2 = Color3.fromHex(_G.K7)
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
					for _, PlrHats in pairs(Player:WaitForChild("FakeHead",50):GetChildren()) do
						if  PlrHats:IsA("Accessory") or 
							PlrHats:IsA("Hat")
						then
							PlrHats:Destroy()
						end
					end
				end
				for _, Meshes in pairs(Player:GetDescendants()) do

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

				for _, PlrHats in pairs(Player:GetChildren()) do

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

			for i,v in FoodDemonTable do
				if ExtraValue == v and HatPack == "FoodDemons" then
					PV = true
				end
			end

			if HatPackage:HasTag("Headless") or  PV == true  then --Invisible Head
				HiddenLimbs.InvisibleHead:Clone().Parent = Player["Head"]

			end
			if HatPackage:HasTag("FullBody") or PV == true then --Invisible Full Body
				HiddenLimbs.HiddenTorso:Clone().Parent = Player["Torso"]
				HiddenLimbs.LA:Clone().Parent = Player["Left Arm"]
				HiddenLimbs.LL:Clone().Parent = Player["Left Leg"]
				HiddenLimbs.RA:Clone().Parent = Player["Right Arm"]
				HiddenLimbs.RL:Clone().Parent = Player["Right Leg"]
			end
			if HatPackage:HasTag("HiddenTopBody") then --Invisible Full Body
				HiddenLimbs.HiddenTorso:Clone().Parent = Player["Torso"]
				HiddenLimbs.LA:Clone().Parent = Player["Left Arm"]
				HiddenLimbs.RA:Clone().Parent = Player["Right Arm"]
			end
			if HatPackage:HasTag("UniverseIsR63d") then --female
				HiddenLimbs.GirlTorso:Clone().Parent = Player["Torso"]
				HiddenLimbs.LL:Clone().Parent = Player["Left Leg"]
				HiddenLimbs.RL:Clone().Parent = Player["Right Leg"]
			end
			for _, PossibleDecal in pairs(Player["Head"]:GetChildren()) do
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
					Player["Head"].Color = BodyColor.HeadColor3
					Player["Torso"].Color = BodyColor.TorsoColor3
					Player["Left Arm"].Color = BodyColor.LeftArmColor3
					Player["Left Leg"].Color = BodyColor.LeftLegColor3
					Player["Right Arm"].Color = BodyColor.RightArmColor3
					Player["Right Leg"].Color = BodyColor.RightLegColor3]]
				else
					local Color = Instance.new("BodyColors", Player)
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
			local Color = Instance.new("BodyColors", Player)
			Color.HeadColor3 = HatPackage:GetAttribute("Color")
			Color.TorsoColor3 = HatPackage:GetAttribute("Color")
			Color.LeftArmColor3 = HatPackage:GetAttribute("Color")
			Color.LeftLegColor3 = HatPackage:GetAttribute("Color")
			Color.RightArmColor3 = HatPackage:GetAttribute("Color")
			Color.RightLegColor3 = HatPackage:GetAttribute("Color")
		end
		if HatPackage:HasTag("UseBodyColors") then --V1 Used Tags To Differ Them From Getting set Without one
			--[[local BodyColor = HatPackage.NewHats:FindFirstChildOfClass("Body Colors")
			Player["Head"].Color = BodyColor.HeadColor3
			Player["Torso"].Color = BodyColor.TorsoColor3
			Player["Left Arm"].Color = BodyColor.LeftArmColor3
			Player["Left Leg"].Color = BodyColor.LeftLegColor3
			Player["Right Arm"].Color = BodyColor.RightArmColor3
			Player["Right Leg"].Color = BodyColor.RightLegColor3]]
		end


		--------------------------------------------------------------------------------------------------------
		local Attachments = {"LeftGripAttachment","RightGripAttachment","RightShoulderAttachment","LeftShoulderAttachment"}
		local function AddNewHats()
			for _, Prt in NewHats:GetChildren() do
				Prt.Parent = Player
				if Prt:IsA("Accessory") or Prt:IsA("Hat") then
					addAccoutrement(Player, Prt)
					Prt.Handle.Anchored = false
					Prt.Handle.CanCollide = false
					Prt.Handle.Massless = true
				end

				for i,v in Player:GetDescendants() do
					if v:HasTag("Colorable") and not table.find(ColorablePartsTable1,v) then
						table.insert(ColorablePartsTable1, v)
					elseif v:HasTag("Colorable2") and not table.find(ColorablePartsTable1,v) then
						table.insert(ColorablePartsTable2, v)
					end
				end

				if ExtraValue2 == "Rainbowify" then
					Rainbowify()
				elseif ExtraValue2 == "Chaosify" then
					RandomBrickColor()
				elseif ExtraValue2 == "CustomColor" then
					CustomColor()
				end
				print(ColorablePartsTable1,ColorablePartsTable2)
				if HatPackage:HasTag("HeadMesh") then --V1 Used Tags To Differ Them From Getting set Without one
					Player["Head"]:FindFirstChildOfClass("SpecialMesh"):Destroy()
					HatPackage:WaitForChild("HeadMesh", 50):Clone().Parent = Player["Head"]
				end
				if HatPackage:HasTag("CanHaveExtraArms") then
					
						if Player:FindFirstChild("SetAssets") then
							if Player:FindFirstChild("SetAssets"):FindFirstChild("HeianArms") then
								local P
								if Player:FindFirstChild("SetAssets"):FindFirstChild("HeianArms"):FindFirstChild("HeianArmsModel") then
									P = Player:FindFirstChild("SetAssets"):FindFirstChild("HeianArms"):WaitForChild("HeianArmsModel", 50)
								else
									P = Player:FindFirstChild("SetAssets"):WaitForChild("HeianArms", 50)
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
			if Player:GetScale() ~= 1 then
				local SavedScale = Player:GetScale()
				Player:ScaleTo(1)
				if HatPackage:HasTag("AddonWithClothes") then
					if Player:FindFirstChildOfClass("Shirt") then
						Player:FindFirstChildOfClass("Shirt"):Destroy()
					end
					if Player:FindFirstChildOfClass("Pants") then
						Player:FindFirstChildOfClass("Pants"):Destroy()
					end
				end
				AddNewHats()
				wait(0.025)
				processCharacterAccessories(Player)
				task.wait(0.025)
				Player:ScaleTo(SavedScale)
			else
				if HatPackage:HasTag("AddonWithClothes") then
					if Player:FindFirstChildOfClass("Shirt") then
						Player:FindFirstChildOfClass("Shirt"):Destroy()
					end
					if Player:FindFirstChildOfClass("Pants") then
						Player:FindFirstChildOfClass("Pants"):Destroy()
					end
				end
				AddNewHats()
				wait(0.025)
				processCharacterAccessories(Player)
				wait(0.025)
				if HatPackage:HasTag("UniverseIsR63d") then
					local P1 = Player["Left LegAccessory"].Handle.L_Leg
					local P2 = Player["Right LegAccessory"].Handle.R_Leg
					local S = Player["TorsoAccessory"].Handle.B.Clothing
					local L1 = Player["Left LegAccessory"].Handle.Skin
					local L2 = Player["Right LegAccessory"].Handle.Clothes
					local T1 = Player["TorsoAccessory"].Handle.B.B1
					local T2 = Player["TorsoAccessory"].Handle.B.B2
					local Shirt = Player:FindFirstChildOfClass("Shirt")
					local Pants = Player:FindFirstChildOfClass("Pants")
					L1.Color = Player["Left Leg"].Color
					L2.Color = Player["Right Leg"].Color
					T1.Color = Player["Torso"].Color
					T2.Color = Player["Torso"].Color
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
				Player = PlrS.Character

				Execute()
			end
		end)

		table.insert(AllConnect, CharacterConnect)

		task.spawn(function()
			if  SaveOutfit == true then
				local BreakerObject = Instance.new("Configuration",game:GetService("InsertService"))
				BreakerObject.Name = Plr.Name.."DeleteValue"
				BreakerObject:SetAttribute("Outfit", _G.K1 .. "," .. _G.K2 .. "," .. _G.K3)
				BreakerObject.Destroying:Connect(function()
					SaveOutfit = false
					for _, Connect in pairs(AllConnect) do
						Connect:Disconnect()
					end
					print(Plr,"AutoOutfitter Disabled")
				end)
			end
		end)
	end)
end
_G.StopAutoOutfit = function()
	spawn(function()
		game:GetService("InsertService")[_G.K4.Name.."DeleteValue"]:Destroy()
	end)
end