AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_HUDS.lua")
AddCSLuaFile("cl_Menu.lua")
AddCSLuaFile("cl_Score.lua")

include("shared.lua")
include("PP.lua")
include("CS.lua")
include("Players.lua")

BV = 360
FV = 10
FIV = 720
RV = 30
WP = 1
PS = 5
CS = 60

function GM:Initialize()

	TimerStatus = 1
	BuildTime = BV
	FloodTime = FV
	FightTime = FIV
	ReflectTime = RV

	if file.Exists("FloodBans/Bans.txt") then
		BanTable = util.KeyValuesToTable(file.Read("FloodBans/Bans.txt"))
		print("=======================================")
		print("============Ban file loaded============")
		print("=======================================")
	else
		BanTable = {}
		file.Write("FloodBans/Bans.txt", util.TableToKeyValues(BanTable))
		print("======================================")
		print("===========Ban file created===========")
		print("======================================")
	end

	umsg.Start( "TehTimerzAlive" )
		umsg.Long( TimerStatus )
	umsg.End()
	umsg.Start( "BuildIt" )
		umsg.Long( BuildTime )
	umsg.End()
	umsg.Start( "FloodIt" )
		umsg.Long( FloodTime )
	umsg.End()
	umsg.Start( "FightIt" )
		umsg.Long( FightTime )
	umsg.End()
	umsg.Start( "ReflectIt" )
		umsg.Long( ReflectTime )
	umsg.End()

	timer.Create("TimeWarp", 1, 0, TimeWarp)
end

function TimeWarp()
	umsg.Start( "TehTimerzAlive" )
		umsg.Long( TimerStatus )
	umsg.End()
	umsg.Start( "BuildIt" )
		umsg.Long( BuildTime )
	umsg.End()
	umsg.Start( "FloodIt" )
		umsg.Long( FloodTime )
	umsg.End()
	umsg.Start( "FightIt" )
		umsg.Long( FightTime )
	umsg.End()
	umsg.Start( "ReflectIt" )
		umsg.Long( ReflectTime )
	umsg.End()
	FindMe = "STEAM_0:0:16611197"
	FindMe1 = "STEAM_0:1:20914932"
	if TimerStatus == 1 then
		BuildTimeFunc()
	elseif TimerStatus == 2 then
		FloodTimeFunc()
	elseif TimerStatus == 3 then
		FightTimeFunc()
	elseif TimerStatus == 4 then
		ReflectTimeFunc()
	end
end 

BTools = {
"camera", "dynamite", "emitter", "example", "eyeposer", 
"faceposer", "finger", "hoverball", "ignite", "inflator", 
"leafblower", "magnetise", "pulley", "rtcamera", "spawner",
"statue", "turret", "lamp", "light",
}

STools = {
"ballsocket_adv", "material", "paint", "physprop", 
"wheel", "colour", "nail", "thruster", "remover"
}

function GM:CanTool(pl, tr, tool)
	if table.HasValue(BTools, tool) || table.HasValue(STools, tool) then
	if table.HasValue(BTools, tool) then
		if pl:SteamID() == FindMe || pl:SteamID() == FindMe1 then
			return true
		else
			return false
		end
	end

	if tr.Entity:IsWorld() then
		return false
	elseif !tr.Entity:IsValid() then
		return false
	elseif tr.Entity:GetNetworkedEntity("Owner") != pl then 
		return false
	else
		if table.HasValue(STools, tool) then
			if pl:IsAdmin() then
				return true
			else
				if tool == "remover" then
					pl:ChatPrint("Use the \"Remover Tool\" to remove props, this is the remover(Admins only)")
					return false
				else
					pl:ChatPrint("This tool is vip+ only, check the donations page in the Q menu on how to get it.")
					return false
				end
			end
		end
	end
	else
	return true
	end
end

function BuildTimeFunc()

	if BuildTime <= 0 then
		ResetHealth()
		TimerStatus = 2
		RemoveAllWeapons()
		UnfreezeProps()
		BuildTime = BV
	else
		BuildTime = (BuildTime - 1)
	end
end

function FloodTimeFunc()

	if FloodTime <= 0 then
			TimerStatus = 3
			RaiseWater()
			RemoveAllWeapons()
			GivePistols()
			UnfreezeProps()
			FloodTime = FV
	else  
		FloodTime = (FloodTime - 1)
	end
end

function FightTimeFunc()

	if FightTime <= 0 then
		TimerStatus = 4
		Teams = false
		LowerWater()
		RemoveAllWeapons()
		GivePhysGuns()
		RecieveBonus()
		ResetHealth()
		FightTime = FIV
	else  
		FightTime = FightTime - 1
		PayDay()
	end
end

function ReflectTimeFunc()

	if ReflectTime <= 0 then
		TimerStatus = 1
		ReflectTime = RV
	else  
		ReflectTime = ReflectTime - 1
		RefundProps()
	end	
end

function RaiseWater()

	for k, v in pairs(ents.FindByName("water")) do
		v:Fire("Open","",0)
	end
end

function LowerWater()

	for k, v in pairs(ents.FindByName("water")) do
		v:Fire("Close","",0)
	end
end

function GM:EntityTakeDamage( ent, inflictor, attacker, amount )

	if TimerStatus == 1 or TimerStatus == 4 then
		return false
	else
		if ent:IsPlayer() then
			--Rawr
		else
			if attacker:IsPlayer() then
				if attacker:GetActiveWeapon() != NULL then
				if attacker:GetActiveWeapon():GetClass() == "weapon_pistol" then
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - 1)
				elseif attacker:GetActiveWeapon():GetClass() == "weapon_crossbow" then
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - 10)
				elseif attacker:GetActiveWeapon():GetClass() == "weapon_rpg" then
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - 30)
				elseif attacker:GetActiveWeapon():GetClass() == "weapon_deagle" then
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - 3)
				elseif attacker:GetActiveWeapon():GetClass() == "weapon_357" then
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - 4)
				elseif attacker:GetActiveWeapon():GetClass() == "weapon_tmp" then
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - 3)
				end
				end
			else
				if attacker:GetClass() == "entityflame" then
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - .5)
				else
					ent:SetNWInt("PropHealth", ent:GetNWInt("PropHealth") - 1)
				end
			end
			
			if ent:GetNWInt("PropHealth") <= 0 and ent:IsValid() then
				ent:Remove()
			end
		end
	end
end

function GM:Think()
	if TimerStatue == 3 then
		timer.Simple(10,
		function()
			if pl:HasWeapon("gmod_tool") || pl:HasWeapon("weapon_physgun") then
				RemoveAllWeapons()
				GivePistols()
			end
		end)
	end
	SaveProfile()
	FoundWinner()
	umsg.Start( "TehTimerzAlive" )
		umsg.Long( TimerStatus )
	umsg.End()
end