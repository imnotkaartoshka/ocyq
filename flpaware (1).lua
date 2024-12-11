pcall(function()
local espcolor = Color3.fromRGB(140, 69, 102)
local wallhack_esp_transparency = .4
local gui_hide_button = {Enum.KeyCode.LeftControl, "h"}
local plrs = game:GetService("Players")
local lplr = game:GetService("Players").LocalPlayer
local TeamBased = false ; 
local teambasedswitch = "o"
local presskeytoaim = true; 
local aimkey = "e"
local aimbothider = false; 
local aimbothiderspeed = .5
local Aim_Assist = false ; 
local Aim_Assist_Key = {Enum.KeyCode.LeftControl, "z"}
local espupdatetime = 5; 
local autoesp = false; 
local charmsesp = true
local movementcounting = true

local mouselock = true
local canaimat = true
local lockaim = true; 
local lockangle = 5
local ver = "dahood"
local cam = game.Workspace.CurrentCamera
local BetterDeathCount = true
local ballisticsboost = 0

local mouse = lplr:GetMouse()
local switch = false
local key = "k"
local aimatpart = nil
local lightesp = false

local abs = math.abs
--Properties:


local aimbotstatus = {"qc", "qr", "qe", "qd", "qi", "qt", "qs", "dd", "sp", "ql", "qa", "qd", "qs"}
local gotstring = 0
local function getrandomstring()
	gotstring = gotstring+666
	local str = ""
	local randomstring = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "g", "k", "l", "m", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
		 "а","б","в","г","д","е","ё","ж","з","и","й","к","л","м","о","п","р","с","т","у","ф","х","ч","щ","ъ","ы","ъ","э","ю","я", "`", "$", 
		"0","1","2","3","4","5","6","7","8","9", }
	local counting123 = 0
	for i, v in ipairs(randomstring) do
		counting123 = i
	end
	do
		math.randomseed(tick()+gotstring)
		for i = 3, math.random(1,100) do
				math.randomseed(i+tick()+gotstring)
				
				local oneortwo = math.random(1,2)
				if oneortwo == 2 then
					math.randomseed(i+tick()+gotstring)
					str = str..""..randomstring[math.random(1, counting123)]
				else
					math.randomseed(i+tick()+gotstring)
					str = str..""..string.upper(randomstring[math.random(1, counting123)])
				end
			
		end
	end
	return str
end
local mousedown = false
local isonmovething = false
local mouseoffset = Vector2.new()
local mousedown = false
local bspeed = 3584
local aimbotoffset = {dd = ":", sp = " ", qa = "a", qb = "b",qc = "c", qd = "d", qe = "e", qf = "f", qg = "g" , qh = "h" , qi = "i", qj = "j", qk = "k", ql = "l", qm = "m", qn = "n", qo = "o", qp = "p", qq = "q", qr = "r", qs = "s", qt = "t", qu = "u", qv = "w", qx = "x", qy = "y", qz = "z"}


-- Scripts:

local plrsforaim = {}
local f = {}
f.UpdateHeadUI = function(v)
	
		
			if v.Adornee and v.Adornee ~= nil then
				local destr = false
				if TeamBased then
					destr = true
					local plr = plrs:GetPlayerFromCharacter(v.Adornee.Parent)
					if plr and plr.Team and plr.Team.Name ~= lplr.Team.Name then
						destr = false
					end
				end
				if lightesp == true then
					v.Pdist.TextColor3 = Color3.new(1,1,1)
					v.PName.TextColor3 = Color3.new(1,1,1)
				else
					v.Pdist.TextColor3 = Color3.new(0,0,0)
					v.PName.TextColor3 = Color3.new(0,0,0)
				end
				local d = math.floor((cam.CFrame.p - v.Adornee.CFrame.p).magnitude)
				v.Pdist.Text = tostring(d)
				if d < 14 then
					v.Enabled = false
				else
					v.Enabled = true
				end
				v.StudsOffset = Vector3.new(0,.6+d/14,0)
				if destr then
					v:Destroy()
				end
			else
				v:Destroy()
			end
		
	
end

local uis = game:GetService("UserInputService")
local bringall = false
local hided2 = false
local upping = false
local downing = false
mouse.KeyDown:Connect(function(a)
	if a == key then
		if switch == false then
			switch = true
		else
			switch = false
			if aimatpart ~= nil then
				aimatpart = nil
			end
		end
	elseif a == "b" and uis:IsKeyDown(Enum.KeyCode.LeftControl) and not uis:IsKeyDown(Enum.KeyCode.R) then
		if movementcounting then
			movementcounting = false
		else
			movementcounting = true
		end
	elseif a == teambasedswitch then
		if TeamBased == true then
			TeamBased = false
		else
			TeamBased = true
		end
	elseif a == "b" and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.R) then
		ballisticsboost = 0
	elseif a == aimkey then
		if not aimatpart then
			local maxangle = math.rad(20)
			for i, plr in pairs(plrs:GetChildren()) do
				if plr.Name ~= lplr.Name and plr.Character and plr.Character.Head and plr.Character.Humanoid and plr.Character.Humanoid.Health > 1 then
					if TeamBased == true then
						if plr.Team.Name ~= lplr.Team.Name then
							local an = checkfov(plr.Character.HumanoidRootPart)
							if an < maxangle then
								maxangle = an
								aimatpart = plr.Character.Head
							end
						end
					else
						local an = checkfov(plr.Character.HumanoidRootPart)
							if an < maxangle then
								maxangle = an
								aimatpart = plr.Character.Head
							end
							--print(plr)
					end
					local old = aimatpart
					plr.Character.Humanoid.Died:Connect(function()
						--print("died")
						if aimatpart and aimatpart == old then
							aimatpart = nil
						end
					end)
					
				end
			end
		else
			aimatpart = nil
			canaimat = false
			delay(1.1, function()
				canaimat = true
			end)
		end
	end
end)

function getfovxyz (p0, p1, deg)
	local x1, y1, z1 = p0:ToOrientation()
	local cf = CFrame.new(p0.p, p1.p)
	local x2, y2, z2 = cf:ToOrientation()
	local d = math.deg
	if deg then
		return Vector3.new(d(x1-x2), d(y1-y2), d(z1-z2))
	else
		return Vector3.new((x1-x2), (y1-y2), (z1-z2))
	end
end


function aimat(part)
	if part then
		--print(part)
		local d = (cam.CFrame.p - part.CFrame.p).magnitude
		local calculatedrop
		local timetoaim = 0
		local pos2 = Vector3.new()
		if movementcounting == true then
			timetoaim = d/bspeed
			pos2 = part.Velocity * timetoaim
		end
		local minuseddrop = (ballisticsboost+50)/50
		if ballisticsboost ~= 0 then
			calculatedrop = d - (d/minuseddrop)
			
		else
			calculatedrop = 0
		end
		--print(calculatedrop)
		local addative = Vector3.new()
		if movementcounting then
			addative = pos2
		end
		local cf = CFrame.new(cam.CFrame.p, (addative + part.CFrame.p+ Vector3.new(0, calculatedrop, 0)))
		if aimbothider == true or Aim_Assist == true then
			cam.CFrame = cam.CFrame:Lerp(cf, aimbothiderspeed)
		else
			
			cam.CFrame = cf
		end
		--print(cf)
	end
end
function checkfov (part)
	local fov = getfovxyz(game.Workspace.CurrentCamera.CFrame, part.CFrame)
	local angle = math.abs(fov.X) + math.abs(fov.Y)
	return angle
end
pcall(function()
	delay(0, function()
		while wait(.32) do
			if Aim_Assist and not aimatpart and canaimat and lplr.Character and lplr.Character.Humanoid and lplr.Character.Humanoid.Health > 0 then
				for i, plr in pairs(plrs:GetChildren()) do
					
					
						local minangle = math.rad(5.5)
						local lastpart = nil
						local function gg(plr)
							pcall(function()
							if plr.Name ~= lplr.Name and plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 and plr.Character.Head then
								local raycasted = false
								local cf1 = CFrame.new(cam.CFrame.p, plr.Character.Head.CFrame.p) * CFrame.new(0, 0, -4)
								local r1 = Ray.new(cf1.p, cf1.LookVector * 9000)
								local obj, pos = game.Workspace:FindPartOnRayWithIgnoreList(r1,  {lplr.Character.Head})
								local dist = (plr.Character.Head.CFrame.p- pos).magnitude
								if dist < 4 then
									raycasted = true
								end
								if raycasted == true then
									local an1 = getfovxyz(cam.CFrame, plr.Character.Head.CFrame)
									local an = abs(an1.X) + abs(an1.Y)
									if an < minangle then
										minangle = an
										lastpart = plr.Character.Head
									end
								end
							end
							end)
						end
						if TeamBased then
							if plr.Team.Name ~= lplr.Team.Name then
								gg(plr)
							end
						else
							gg(plr)
						end
						--print(math.deg(minangle))
						if lastpart then
							aimatpart = lastpart
							aimatpart.Parent.Humanoid.Died:Connect(function()
								if aimatpart == lastpart then
									aimatpart = nil
								end
							end)
						
					end
				end
			end
		end
	end)
end)
local oldheadpos
local lastaimapart
game:GetService("RunService").RenderStepped:Connect(function(dt)
	if uis:IsKeyDown(Enum.KeyCode.RightBracket) or uis:IsKeyDown(Enum.KeyCode.LeftBracket) then
		if upping then
			ballisticsboost = ballisticsboost + dt/1.9
		elseif downing then
			ballisticsboost = ballisticsboost - dt/1.9
		end
	end
	if movementcounting then
        --print("printer")
	else
		--print("printer")
	end
	
	if aimatpart and lplr.Character and lplr.Character.Head then
		if BetterDeathCount and lastaimapart and lastaimapart == aimatpart then
			local dist = (oldheadpos - aimatpart.CFrame.p).magnitude
			if dist > 40 then
				aimatpart = nil
			end
		end
		lastaimapart = aimatpart
		oldheadpos = lastaimapart.CFrame.p
		do 
			if aimatpart.Parent == plrs.LocalPlayer.Character then
				aimatpart = nil
			end
			aimat(aimatpart)
			pcall(function()
				if Aim_Assist == true then
					local cf1 = CFrame.new(cam.CFrame.p, aimatpart.CFrame.p) * CFrame.new(0, 0, -4)
					local r1 = Ray.new(cf1.p, cf1.LookVector * 1000)
					local obj, pos = game.Workspace:FindPartOnRayWithIgnoreList(r1,  {lplr.Character.Head})
					local dist = (aimatpart.CFrame.p- pos).magnitude
					if obj then
						--print(obj:GetFullName())
					end
					if not obj or dist > 6 then
						aimatpart = nil
						--print("ooof")
					end
					canaimat = false
					delay(.5, function()
						canaimat = true
					end)
				end
			end)
		end
		
		
		
	end
end)


delay(0, function()
	while wait(espupdatetime) do
		if autoesp == true then
			pcall(function()
			end)
		end
	end
end)

warn("     FloppaWare Is Best Lock?         ")
print("     FloppaWare Is Best Lock?         ")
warn("     FloppaWare Is Best Lock?         ")
print("    .--,.-,")
print("   /.-',\:.\  .===.    ,;;,;;,")
print("  /;    \\:.\/    _)  ;;;;;;;;;")
print("  |'     \\:(  _,`'>   ';;;;;'")
print("  |;      \\(_/ ._=      ';'")
print("  |;       ;/ /`|\ ")
print("  /,      _/  |-' `\ ")
print(" /;    __//(  \_,;;,;;,")
print("|;  __/  /  \  /);;;;;;)")
print("| _/|/  /    \/`';;;;;'    ,;;,;;,")
print("|/     /      (   ';'     ;;;;;;;;;")
print("      (    .-, \           ';;;;;'")
print("       )  /`\ ) \            ';'")
print("      '._/|/| |.'")
print("        _//  \|")
print("       | /   ||")
print("       |/   / |")
print("            `\|")
print("              '")
warn("     FloppaWare Is Back?         ")
print("     FloppaWare Is Back?         ")
warn("     FloppaWare Is Back?         ")
end)