include('shared.lua')

usermessage.Hook( "TehTimerzAlive", function( um )
Start = um:ReadLong()
end )

usermessage.Hook( "BuildIt", function( um )
BuildT = um:ReadLong()
end )

usermessage.Hook( "FloodIt", function( um )
FloodT = um:ReadLong()
end )

usermessage.Hook( "FightIt", function( um )
FightT = um:ReadLong()
end )

usermessage.Hook( "ReflectIt", function( um )
ReflectT = um:ReadLong()
end )

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do 
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud) 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function GM:HUDPaint()
	if (Start == 1) then
		if BuildT == nil then return false end
		draw.RoundedBox(4, ScrW()/5 + 15, ScrH() - 111, 175, 25, Color(0,0,0,200))
		draw.SimpleText(BuildT, "Trebuchet24", ScrW()/5 + 15 + 138, ScrH() - 111, Color(255,255,255,255),0,0)
		draw.SimpleText("Build a boat.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 111, Color(0,0,205,255),0,0)
		draw.SimpleText("Get on your boat!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 87, Color(100,100,100,100),0,0)
		draw.SimpleText("Destory enemy boats!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 58, Color(100,100,100,100),0,0)
		draw.SimpleText("Restarting the round.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 29, Color(100,100,100,100),0,0)
	elseif (Start == 2) then
		if FloodT == nil then return false end
		draw.RoundedBox(4, ScrW()/5 + 15, ScrH() - 87, 220, 25, Color(0,0,0,200))
		draw.SimpleText(FloodT, "Trebuchet24", ScrW()/5 + 15 + 183, ScrH() - 87, Color(255,255,255,255),0,0)
		draw.SimpleText("Build a boat.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 111, Color(100,100,100,100),0,0)
		draw.SimpleText("Get on your boat!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 87, Color(0,0,205,255),0,0)
		draw.SimpleText("Destory enemy boats!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 58, Color(100,100,100,100),0,0)
		draw.SimpleText("Restarting the round.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 29, Color(100,100,100,100),0,0)
	elseif (Start == 3) then
		if FightT == nil then return false end
		draw.RoundedBox(4, ScrW()/5 + 15, ScrH() - 58, 255, 25, Color(0,0,0,200))
		draw.SimpleText(FightT, "Trebuchet24", ScrW()/5 + 15 + 218, ScrH() - 58, Color(255,255,255,255),0,0)
		draw.SimpleText("Build a boat.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 111, Color(100,100,100,100),0,0)
		draw.SimpleText("Get on your boat!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 87, Color(100,100,100,100),0,0)
		draw.SimpleText("Destory enemy boats!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 58, Color(0,0,205,255),0,0)
		draw.SimpleText("Restarting the round.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 29, Color(100,100,100,100),0,0)
	elseif (Start == 4) then
		if ReflectT == nil then return false end
		draw.RoundedBox(4, ScrW()/5 + 15, ScrH() - 29, 255, 25, Color(0,0,0,200))
		draw.SimpleText(ReflectT, "Trebuchet24", ScrW()/5 + 15 + 218, ScrH() - 29, Color(255,255,255,255),0,0)
		draw.SimpleText("Build a boat.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 111, Color(100,100,100,100),0,0)
		draw.SimpleText("Get on your boat!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 87, Color(100,100,100,100),0,0)
		draw.SimpleText("Destory enemy boats!", "Trebuchet24", ScrW()/5 + 19, ScrH() - 58, Color(100,100,100,100),0,0)
		draw.SimpleText("Restarting the round.", "Trebuchet24", ScrW()/5 + 19, ScrH() - 29, Color(0,0,205,255),0,0)
	end


	local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))

	if (tr.Entity:IsValid() and !tr.Entity:IsPlayer()) then
		if tr.Entity:GetNWInt("PropHealth") == "" or tr.Entity:GetNWInt("PropHealth") == nil or tr.Entity:GetNWInt("PropHealth") == NULL then
			local PH = "Fetching"
			draw.SimpleText(PH, "BudgetLabel", ScrW()/2, ScrH()/2 - 25, Color(205,0,0,255),1,1)
		else
			PH = "Health: " .. tr.Entity:GetNWInt("PropHealth")
			draw.SimpleText(PH, "BudgetLabel", ScrW()/2, ScrH()/2 - 25, Color(205,0,0,255),1,1)
		end

		local PO = tr.Entity:GetNetworkedEntity("Owner")
		if ValidEntity(PO) then
			local Text = "Owner: " .. PO:Nick()
			surface.SetFont("Default")
			local Width, Height = surface.GetTextSize(Text)
			Width = Width + 25
			draw.RoundedBox(4, ScrW() - (Width + 8), (ScrH()/2 - 200) - (8), Width + 8, Height + 8, Color(0, 0, 0, 150))
			draw.SimpleText(Text, "Default", ScrW() - (Width / 2) - 7, ScrH()/2 - 200, Color(255, 255, 255, 255), 1, 1)
		else
			local Text = "Owner: Fetching..."
			surface.SetFont("Default")
			local Width, Height = surface.GetTextSize(Text)
			Width = Width + 25
			draw.RoundedBox(4, ScrW() - (Width + 8), (ScrH()/2 - 200) - (8), Width + 8, Height + 8, Color(0, 0, 0, 150))
			draw.SimpleText(Text, "Default", ScrW() - (Width / 2) - 7, ScrH()/2 - 200, Color(255, 255, 255, 255), 1, 1)
		end
	end

	if (tr.Entity:IsValid() and tr.Entity:IsPlayer()) then
		PlayerName = "Name: " .. tr.Entity:GetName()
		PlayerHealth = "Health: " .. tr.Entity:Health()
		draw.SimpleText(PlayerName, "Default", ScrW()/2, ScrH()/2 - 75, Color(205,0,0,255),1,1)
		draw.SimpleText(PlayerHealth, "Default", ScrW()/2, ScrH()/2 - 60, Color(205,0,0,255),1,1)
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FMHUD = {}

FMHUD.Wide = ScrW()/5
FMHUD.Tall = 24
FMHUD.Space = 4

FMHUD.MinWide = 4
FMHUD.BlockWide = FMHUD.Space + FMHUD.Wide + FMHUD.Space
FMHUD.BlockTall = FMHUD.Space + FMHUD.Tall + FMHUD.Space

surface.CreateFont("coolvetica",FMHUD.Tall,400,true,false,"FMHUD_Font")

function FMHUD:Paint()
	if LocalPlayer():Alive() && LocalPlayer():IsValid() then
		draw.RoundedBox(4, 4, (ScrH() - (self.BlockTall*2) - self.Tall - self.Space), self.BlockWide, ((self.BlockTall*2) + self.Tall), Color(0,0,0,200))
	
		local HH = LocalPlayer():Health()
		local HF = math.Clamp(HH/100, 0, 1)
		local HW = (self.Wide - self.MinWide) * HF

		draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*3) - (self.Space*4)), self.MinWide + HW, self.Tall, Color(221,82,82,255))
		draw.SimpleText(math.Max(HH, 0).." HP","FMHUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall*2) - (self.Tall/2) - (self.Space*4)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)


		if ValidEntity(LocalPlayer():GetActiveWeapon()) then
			if LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 || LocalPlayer():GetActiveWeapon():Clip1() > 0 then
				local CH = (LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) + LocalPlayer():GetActiveWeapon():Clip1())
				local CF = math.Clamp(CH/100, 0, 1)
				local CW = ((self.Wide) - self.MinWide) * CF
				
				draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*2) - (self.Space*3)), self.MinWide + CW, self.Tall, Color(0,242,242,255))
				draw.SimpleText(CH.." Bullets","FMHUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - self.Tall - (self.Tall/2) - (self.Space*3)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*2) - (self.Space*3)), self.Wide, self.Tall, Color(0,242,242,255))
				draw.SimpleText("Ammo","FMHUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - self.Tall - (self.Tall/2) - (self.Space*3)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		else
			draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*2) - (self.Space*3)), self.Wide, self.Tall, Color(0,242,242,255))
			draw.SimpleText("Ammo","FMHUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - self.Tall - (self.Tall/2) - (self.Space*3)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end

		if LocalPlayer():GetNWInt("Cash") != nil && LocalPlayer():GetNWInt("Cash") != "" then
			local MH = LocalPlayer():GetNWInt("Cash")
			local MF = math.Clamp(MH / 5000, 0, self.Wide)
			local MW = (MF + 5)

			if MH < 750000 then
				draw.RoundedBox(4, (self.Space*2), ScrH() - self.Tall - (self.Space*2), MW, self.Tall, Color(0,221,55,255))
				draw.SimpleText("$"..MH,"FMHUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall/2) - (self.Space*2)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.RoundedBox(4, (self.Space*2), ScrH() - self.Tall - (self.Space*2), MW, self.Tall, Color(0,221,55,255))
				draw.SimpleText("$"..MH.." OMG!?!","FMHUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall/2) - (self.Space*2)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		else
				draw.RoundedBox(4, (self.Space*2), ScrH() - self.Tall - (self.Space*2), self.Wide, self.Tall, Color(0,221,55,255))
				draw.SimpleText("Profile Loading...","FMHUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall/2) - (self.Space*2)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end

	end
end
hook.Add("HUDPaint","FMHUD.Paint",function() FMHUD:Paint() end)