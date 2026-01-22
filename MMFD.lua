local X = game:GetObjects("rbxasset://MarshmellowDemon.Rbxm")[1]:Clone()
local Plr = game:GetService("Players").LocalPlayer
local Player = Plr.Character
for _, Prt in pairs(Player:GetChildren()) do
	if  Prt:IsA("Accessory") or Prt:IsA("Hat") or Prt:IsA("BodyColors") or Prt:IsA("CharacterMesh")or Prt:IsA("Pants") or Prt:IsA("Shirt") or Prt:IsA("ShirtGraphic")  then
		Prt:Destroy()
	end
	Player.Head.face.Transparency = 1
	Player["Head"].Color = Color3.fromRGB(248, 248, 248)
	Player["Torso"].Color = Color3.fromRGB(248, 248, 248)
	Player["Left Arm"].Color = Color3.fromRGB(248, 248, 248)
	Player["Left Leg"].Color = Color3.fromRGB(248, 248, 248)
	Player["Right Arm"].Color = Color3.fromRGB(248, 248, 248)
	Player["Right Leg"].Color = Color3.fromRGB(248, 248, 248)
	for _, Prt in pairs(X:GetChildren()) do
		Prt.Parent = Player
		if Prt.Name == "MarshBack" then
			Prt.Handle.BackWeld.Part0 = Player["Torso"]
		end
		if Prt.Name == "MarshHead" then
			Prt.Handle.HeadWeld.Part0 = Player["Head"]
			end
	end
end
