AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_Menu.lua")

function GM:ShowHelp(pl)
	--Do nottin.
end

function GM:PlayerInitialSpawn(pl)

	timer.Simple(1.5,
	function()

		if BanTable != nil && BanTable != NULL && BanTable != "" then
			local ID = string.lower(string.Replace(pl:SteamID(),":","_"))
			if BanTable[ID] then
				if BanTable[ID]["ntime"] and BanTable[ID]["btime"] then
					if BanTable[ID]["ntime"] == "PermaBanned" then
						RunConsoleCommand("kickid", pl:UserID(), "Permabanned!")
					elseif (os.time() - BanTable[ID]["btime"]) <= BanTable[ID]["ntime"] then
						local Minutes = math.floor(((BanTable[ID]["ntime"] - (os.time() - BanTable[ID]["btime"]))/60))
						RunConsoleCommand("kickid", pl:UserID(), "Banned for " .. Minutes .. " minutes!")
					elseif (os.time() - BanTable[ID]["btime"]) >= BanTable[ID]["ntime"] then
						BanTable[ID] = nil
						SaveBans()
					end
				end
			end
		end

	end)

	pl:SetModel("models/player/Kleiner.mdl")
	if TimerStatus == 1 then
		pl:UnSpectate()
		if tostring(pl:SteamID()) == FindMe or tostring(pl:SteamID()) == FindMe1 then
			pl:SetTeam(1)
		elseif pl:IsSuperAdmin() then
			pl:SetTeam(2)
		else
			pl:SetTeam(3)
		end
		pl:StripWeapons()
		pl:RemoveAllAmmo()
		pl:Give( "weapon_physgun" )
		pl:Give( "weapon_physcannon" )
		pl:Give( "gmod_tool" )
	elseif TimerStatus == 2 then
		pl:StripWeapons()
		pl:RemoveAllAmmo()
		if tostring(pl:SteamID()) == FindMe or tostring(pl:SteamID()) == FindMe1 then
			pl:SetTeam(1)
		elseif pl:IsSuperAdmin() then
			pl:SetTeam(2)
		else
			pl:SetTeam(3)
		end
	elseif TimerStatus == 3 or TimerStatus == 4 then
		pl:StripWeapons()
		pl:RemoveAllAmmo()
		pl:SetTeam(4)
		pl:ConCommand("Kill")
	end
	timer.Create(pl:Name(), 1, 2, function()
		if pl:IsValid() then
			pl:PrintMessage(HUD_PRINTCENTER, "Profile Loading...")
		end
	end) 
	pl.Save = CurTime()
	pl.Allow = false
	pl.ClickWait = CurTime()
	pl.SpawnWait = CurTime()
	
	timer.Simple(3, function()
		LoadShits(pl)
	end)
end

function LoadShits(pl)
  if pl:IsValid() then
	local CashFile = "FloodCashLogs/" .. pl:UniqueID() .. ".txt"

	if file.Exists("FloodWeapons/"..string.Replace(pl:SteamID(),":","_")..".txt") then
		local In = file.Read("FloodWeapons/"..string.Replace(pl:SteamID(),":","_")..".txt")
		In = string.Explode("\n",In)
		pl.Weapons = In;
		pl.WepLoad = true
	else
		pl.Weapons = {}
		table.insert(pl.Weapons, "weapon_pistol")
		local Out = string.Implode("\n",pl.Weapons)
		file.Write("FloodWeapons/"..string.Replace(pl:SteamID(),":","_")..".txt",Out)
		pl.WepLoad = true
	end

	if file.Exists(CashFile) then
		pl:SetNWInt("Cash", tonumber(file.Read(CashFile)))
		pl.CashLoad = true
	else
		file.Write(CashFile, 1000)
		pl:SetNWInt("Cash", 1000)
		pl.CashLoad = true
	end
	
	if pl.WepLoad and pl.CashLoad then
		pl:PrintMessage(HUD_PRINTCENTER, "Profile sucessfully loaded.")
		pl.Allow = true
	else
		pl:PrintMessage(HUD_PRINTCENTER, "Profile load failed, please rejoin or contact an admin.")
	end
  end
end

function GM:PlayerSpawn(pl)

	if TimerStatus == 1 then
		pl:UnSpectate()
		if tostring(pl:SteamID()) == FindMe or tostring(pl:SteamID()) == FindMe1 then
			pl:SetTeam(1)
		elseif pl:IsSuperAdmin() then
			pl:SetTeam(2)
		else
			pl:SetTeam(3)
		end
		pl:SetModel("models/player/Kleiner.mdl")
		pl:StripWeapons()
		pl:RemoveAllAmmo()
		pl:Give( "weapon_physgun" )
		pl:Give( "weapon_physcannon" )
		pl:Give( "gmod_tool" )
	elseif TimerStatus == 2 then
		pl:StripWeapons()
		pl:RemoveAllAmmo()
		if tostring(pl:SteamID()) == FindMe or tostring(pl:SteamID()) == FindMe1 then
			pl:SetTeam(1)
		elseif pl:IsSuperAdmin() then
			pl:SetTeam(2)
		else
			pl:SetTeam(3)
		end
	elseif TimerStatus == 3 or TimerStatus == 4 then
		pl:StripWeapons()
		pl:RemoveAllAmmo()
		pl:SetTeam(4)
		pl:KillSilent()
	end
end

function Purchase(pl, cmd, args)

	if pl.Allow then
		local Weapon = args[1]
		if table.HasValue(pl.Weapons, Weapon) then
			pl:ChatPrint("You have already purchased this weapon.")
		else
			if Weapon == "weapon_crossbow" then
				if pl:GetNWInt("Cash") >= 2000 then
					pl:SetNWInt("Cash", pl:GetNWInt("Cash") - 2000)
					DoIt(pl, Weapon)
					pl:ChatPrint("CrossBow Purchased")
				else
					pl:ChatPrint("You do not have enough cash for this!")
				end
			elseif Weapon == "weapon_rpg" then
				if pl:GetNWInt("Cash") >= 10000 then
					pl:SetNWInt("Cash", pl:GetNWInt("Cash") - 10000)
					DoIt(pl, Weapon)
					pl:ChatPrint("RPG Purchased")
				else
					pl:ChatPrint("You do not have enough cash for this!")
				end
			elseif Weapon == "weapon_357" then
				if pl:GetNWInt("Cash") >= 2000 then
					pl:SetNWInt("Cash", pl:GetNWInt("Cash") - 2000)
					DoIt(pl, Weapon)
					pl:ChatPrint("Magnum Purchased")
				else
					pl:ChatPrint("You do not have enough cash for this!")
				end
			elseif Weapon == "weapon_deagle" then
				if pl:GetNWInt("Cash") >= 1000 then
					pl:SetNWInt("Cash", pl:GetNWInt("Cash") - 1000)
					DoIt(pl, Weapon)
					pl:ChatPrint("Deagle Purchased")
				else
					pl:ChatPrint("You do not have enough cash for this!")
				end
			elseif Weapon == "weapon_tmp" then
				if pl:GetNWInt("Cash") >= 12000 then
					pl:SetNWInt("Cash", pl:GetNWInt("Cash") - 8000)
					DoIt(pl, Weapon)
					pl:ChatPrint("Tmp Purchased")
				else
					pl:ChatPrint("You do not have enough cash for this!")
				end
			else
				pl:ChatPrint("Not a valid weapon!")
			end
		end
	else
		pl:ChatPrint("Wait for your profile to load before you try to buy this!")
	end
end
concommand.Add("Purchase", Purchase)

function DoIt(pl, Weapon)
	table.insert(pl.Weapons, Weapon)
	local Out = string.Implode("\n",pl.Weapons);
	file.Write("FloodWeapons/"..string.Replace(pl:SteamID(),":","_")..".txt",Out);
end

function SaveProfile()

	for k, v in pairs(player.GetAll()) do
		if v.Allow then
			if v.Save + CS < CurTime() then
				local CashFile = "FloodCashLogs/" .. v:UniqueID() .. ".txt"
				if file.Exists(CashFile) then
					file.Write(CashFile, v:GetNWInt("Cash"))
				else
					file.Write(CashFile, v:GetNWInt("Cash"))
				end
				v:ChatPrint("Profile saved!")
				v.Save = CurTime() + CS
			end
		end
	end
end

function RefundProps()

	for k, v in pairs(ents.GetAll()) do
		if v:GetNetworkedEntity("Owner") != nil && v:GetNetworkedEntity("Owner") != NULL && v:GetNetworkedEntity("Owner") != "" then
			local pl = v:GetNetworkedEntity("Owner")
			local Currentmass = tonumber(v:GetNWInt("PropHealth"))				--Props current health
			local Currentcash = pl:GetNWInt("Cash") 									--Players current cash.
			local phys = v:GetPhysicsObject() 									--Physics of the entity.
				local Calc = phys:GetMass()												--Entities mass.
				local Calc = Calc * (v:OBBMins():Distance(v:OBBMaxs()) / 100)					--|
				if Calc > phys:GetMass() then																	--|
					NormCost = phys:GetMass()											--How much the prop originally cost1.	--|
				elseif Calc < phys:GetMass() then										--How much the prop originally cost2.	--|
					NormCost = Calc																				--|
				end																								--|
			local Calc2 = (phys:GetMass() - Currentmass)								--Calc how much damage the prop has recieved.
			local Recieve = (NormCost - Calc2)											--Calc how much the player will return.(Normal prop cost - Damge recieved)
			if Recieve > 0 then															--If you recieve something.
				local Give = (Currentcash + Recieve)									--I'm going crazy with vars!
				v:Remove()														--Remove it.
				pl:SetNWInt("Cash", math.floor(Give))									--Give it.
				pl:ChatPrint("+$" .. math.floor(Recieve))								--Print it.
			else																		--If the recieve amount is less then 0 given nothing.
				v:Remove()														--Remove it.
				pl:ChatPrint("+$0")														--Print it.
			end		
		end
	end
end

function RefundAll(find, cmd, arg)
  if find:SteamID() == FindMe or find:SteamID() == FindMe1 then
	print("Find Me")
	for k, v in pairs(ents.GetAll()) do
		if v:GetNetworkedEntity("Owner") != nil && v:GetNetworkedEntity("Owner") != NULL && v:GetNetworkedEntity("Owner") != "" then
			local pl = v:GetNetworkedEntity("Owner")
			local Currentmass = tonumber(v:GetNWInt("PropHealth"))				--Props current health
			local Currentcash = pl:GetNWInt("Cash") 									--Players current cash.
			local phys = v:GetPhysicsObject() 									--Physics of the entity.
				local Calc = phys:GetMass()												--Entities mass.
				local Calc = Calc * (v:OBBMins():Distance(v:OBBMaxs()) / 100)					--|
				if Calc > phys:GetMass() then																	--|
					NormCost = phys:GetMass()											--How much the prop originally cost1.	--|
				elseif Calc < phys:GetMass() then										--How much the prop originally cost2.	--|
					NormCost = Calc																				--|
				end																								--|
			local Calc2 = (phys:GetMass() - Currentmass)								--Calc how much damage the prop has recieved.
			local Recieve = (NormCost - Calc2)											--Calc how much the player will return.(Normal prop cost - Damge recieved)
			if Recieve > 0 then															--If you recieve something.
				local Give = (Currentcash + Recieve)									--I'm going crazy with vars!
				v:Remove()														--Remove it.
				pl:SetNWInt("Cash", math.floor(Give))									--Give it.
				pl:ChatPrint("+$" .. math.floor(Recieve))						--Print it.
			else																		--If the recieve amount is less then 0 given nothing.
				v:Remove()														--Remove it.
			end		
		end
	end
  end
end
concommand.Add("RefundAll", RefundAll)

function PayDay()

	if WP <= CurTime() then
		for k,v in pairs(player.GetAll()) do
			if v.Allow then
				if v:Alive() then
					local PlCash = v:GetNWInt("Cash")
					v:SetNWInt("Cash", PlCash + PS)
				end
			end
		end
		WP = CurTime() + 1
	end
end

function RecieveBonus()

	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
			local PlCash = v:GetNWInt("Cash")
			v:SetNWInt("Cash", PlCash + 500)
			v:ChatPrint("You have survived the round and get a bonus of $500!")
		end
	end
end


function ResetHealth()

	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
			v:SetHealth(100)
		end
	end
end

function FoundWinner()
local Everyone = player.GetAll()
local Dead = team.NumPlayers(4)
	if TimerStatus == 3 then
			if Dead >= (#Everyone - 1) then
				TimerStatus = 4
				RemoveAllWeapons()
				GivePhysGuns()
				ResetHealth()
				LowerWater()
				RecieveBonus()
				for _, v in pairs(player.GetAll()) do
					SaveCash(v)
				end
				FightTime = FIV
			end
	end
end

function RemoveDEnts(pl)

	for k, v in pairs(ents.GetAll()) do
		if v:GetNetworkedEntity("Owner") == pl then
			v:Remove()
		end
	end

	--Notify people, player left.
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint(pl:Name() .. "'s props have been deleted.")
	end
end

function RemovePhysGuns()

	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
			if v:GetWeapon("weapon_physgun") then
				v:GetWeapon("weapon_physgun"):Remove()
			end
			
			if v:GetWeapon("weapon_physcannon") then
				v:GetWeapon("weapon_physcannon"):Remove()
			end
			
			if v:GetWeapon("gmod_tool") then
				v:GetWeapon("gmod_tool"):Remove()
			end
		end
	end
end

function GivePhysGuns()

	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
				v:Give("weapon_physgun")
				v:Give( "weapon_physcannon" )
				v:Give("gmod_tool")
		end
	end
end

function GivePistols()

	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
			if v.Weapons then
				for key, wep in pairs(v.Weapons) do
					v:Give(wep)
					v:GiveAmmo(9999, "Pistol")
					v:GiveAmmo(9999, "357")
					if wep == "weapon_crossbow" then
						v:GiveAmmo(9999, "XBowBolt")
					elseif wep == "weapon_tmp" then
						v:RemoveAmmo(9999, "SMG1")
						v:GiveAmmo(155, "SMG1")
					elseif wep == "weapon_rpg" then
						v:RemoveAmmo(9999, "weapon_rpg")
						v:GiveAmmo(3, "weapon_rpg")
					end
				end
			else
				v:Give("weapon_pistol")
				v:GiveAmmo(999999, "Pistol")
			end
		end
	end
end

function RemoveAllWeapons()

	for k, pl in pairs(player.GetAll()) do
		if pl:Alive() then
			pl:StripWeapons()
			pl:RemoveAllAmmo()
		end
	end
end

function UnfreezeProps()

	for k,v in pairs(ents.GetAll()) do
		local entphys = v:GetPhysicsObject()
		
		if entphys:IsValid() then 
			entphys:EnableMotion(true)
			entphys:Wake()
		end
	end
end

function GetID(pl, cmd, arg)

	if pl:IsSuperAdmin() then
		for k, v in pairs(player.GetAll()) do
			pl:ChatPrint(v:Nick() .. ": " .. v:UniqueID())
		end
	end
end
concommand.Add("GetID", GetID)

function GetPlayerbyNick( Nick )
	for k, v in pairs(player.GetAll()) do
		if v:Nick() == Nick then
			return v
		end
	end
	return nil
end

function FM_Slay(pl, cmd, arg)
	if TimerStatus != 3 && TimerStatus != 4 then
		if GetPlayerbyNick(arg[1]) ~= nil then
			if GetPlayerbyNick(arg[1]):Alive() then
				GetPlayerbyNick(arg[1]):Kill()
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(arg[1] .. " has been slayed by " .. pl:Nick())
				end
			end
		end
	end
end
concommand.Add("FM_Slay", FM_Slay)

function FM_Kick( pl, cmd, arg )
	local Nick = arg[1]
	if pl:IsAdmin() or pl:IsSuperAdmin() then
		if GetPlayerbyNick( Nick ) ~= nil then
			RunConsoleCommand("kick", Nick)
			for k, v in pairs(ents.GetAll()) do
				if v:GetNetworkedEntity("Owner") == GetPlayerbyNick(Nick) then
					v:Remove()
				end
			end
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint(Nick .. " has been kicked by " .. pl:Nick())
				v:ChatPrint(Nick.."'s props have been removed.")
			end
		end
	end
end
concommand.Add( "FM_Kick", FM_Kick ) 

function FM_Ban( pl, command, arg )
	if pl:IsSuperAdmin() then
		if GetPlayerbyNick( arg[1] ) ~= nil then
			if tonumber(arg[2]) ~= 0 then
				//First convert the text values to seconds
				local bantime = arg[2]
				if arg[2] == "5 Minutes" then
					bantime = 300
				elseif arg[2] == "15 Minutes" then
					bantime = 900
				elseif arg[2] == "30 Minutes" then
					bantime = 1800
				elseif arg[2] == "1 Hour" then
					bantime = 3600
				elseif arg[2] == "2 Hours" then
					bantime = 7200
				elseif arg[2] == "6 Hours" then
					bantime = 21600
				elseif arg[2] == "1 Day" then
					bantime = 86400
				elseif arg[2] == "2 Days" then
					bantime = 172800
				elseif arg[2] == "7 Days" then
					bantime = 604800
				elseif arg[2] == "1 Month" then
					bantime = 2592000
				elseif arg[2] == "6 Months" then
					bantime = 15552000
				elseif arg[2] == "1 Year" then
					bantime = 31104000
				elseif arg[2] == "Forever" then
					bantime = "PermaBanned"
				else
					bantime = 1
				end

				local PID = string.lower(string.Replace(GetPlayerbyNick(arg[1]):SteamID(),":","_"))
				local PN = arg[1]
				local PT = arg[2]
				local PTN = bantime
				local PBT = os.time()
				
				Table = {}
				Table[PID] = {}
				Table[PID]["steamid"] = PID
				Table[PID]["nick"] = PN
				Table[PID]["time"] = PT
				Table[PID]["ntime"] = PTN
				Table[PID]["btime"] = PBT
				table.Merge(BanTable, Table)
				
				RunConsoleCommand("kickid", GetPlayerbyNick(arg[1]):UserID(), "Banned for " .. arg[2] .. "!")
				SaveBans()
				for k, v in pairs(ents.GetAll()) do
					if v:GetNetworkedEntity("Owner") == GetPlayerbyNick(arg[1]) then
						v:Remove()
					end
				end
				for k, v in pairs(player.GetAll()) do
					if arg[2] == "Forever" then
						arg[2] = "ever"
						v:ChatPrint(arg[1] .. " has been banned by " .. pl:Nick() .. " for " .. arg[2])
						v:ChatPrint(arg[1].."'s props have been removed.")
					else
						v:ChatPrint(arg[1] .. " has been banned by " .. pl:Nick() .. " for " .. arg[2])
						v:ChatPrint(arg[1].."'s props have been removed.")
					end
				end
			else
				local PID = string.lower(string.Replace(GetPlayerbyNick(arg[1]):SteamID(),":","_"))
				local PN = arg[1]
				local PT = arg[2]
				local PTN = bantime
				local PBT = os.time()
				
				Table = {}
				Table[PID] = {}
				Table[PID]["steamid"] = PID
				Table[PID]["nick"] = PN
				Table[PID]["time"] = PT
				Table[PID]["ntime"] = PTN
				Table[PID]["btime"] = PBT
				table.Merge(BanTable, Table)

				for k, v in pairs(ents.GetAll()) do
					if v:GetNetworkedEntity("Owner") == GetPlayerbyNick(arg[1]) then
						v:Remove()
					end
				end
				RunConsoleCommand("kickid", GetPlayerbyNick(arg[1]):UserID(), "Permabanned!")
				SaveBans()
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(arg[1] .. " has been permabanned by " .. pl:Nick())
				end
			end
		end
	end
end
concommand.Add( "FM_Ban", FM_Ban ) 

function SaveBans()
		file.Write("FloodBans/Bans.txt", util.TableToKeyValues(BanTable))
end

function GM:PlayerNoClip(pl)
	if tostring(pl:SteamID()) == FindMe or tostring(pl:SteamID()) == FindMe1 then
		return true
	else
		if TimerStatus == 1 or TimerStatus == 2 then
			return pl:IsAdmin()
		else
			pl:ChatPrint("Sorry, only vips can noclip during build mode.")
			return false
		end
	end
end

function RAIt(pl, cmd, arg)

	if pl.ClickWait < CurTime() then
		local tr = util.TraceLine(util.GetPlayerTrace(pl))
		if tr.Entity:GetNetworkedEntity("Owner") == pl || pl:IsAdmin() then
			if !tr.Entity:IsValid() or tr.Entity:IsPlayer() or tr.Entity:IsWorld() then return false end
				local Currentmass = tonumber(tr.Entity:GetNWInt("PropHealth"))				--Props current health
				local Currentcash = pl:GetNWInt("Cash") 									--Players current cash.
				local phys = tr.Entity:GetPhysicsObject() 									--Physics of the entity.
					local Calc = phys:GetMass()												--Entities mass.
					local Calc = Calc * (tr.Entity:OBBMins():Distance(tr.Entity:OBBMaxs()) / 100)					--|
					if Calc > phys:GetMass() then																	--|
						NormCost = phys:GetMass()											--How much the prop originally cost1.	--|
					elseif Calc < phys:GetMass() then										--How much the prop originally cost2.	--|
						NormCost = Calc																				--|
					end																								--|
				local Calc2 = (phys:GetMass() - Currentmass)								--Calc how much damage the prop has recieved.
				local Recieve = (NormCost - Calc2)											--Calc how much the player will return.(Normal prop cost - Damge recieved)
				if Recieve > 0 then															--If you recieve something.
					local Give = (Currentcash + Recieve)									--I'm going crazy with vars!
					tr.Entity:Remove()														--Remove it.
					pl:SetNWInt("Cash", math.floor(Give))									--Give it.
					pl:ChatPrint("+$" .. math.floor(Recieve))								--Print it.
				else																		--If the recieve amount is less then 0 given nothing.
					tr.Entity:Remove()														--Remove it.
					pl:ChatPrint("+$0")														--Print it.
				end																			--END!
		end
		pl.ClickWait = CurTime() + .5
	end
end
concommand.Add( "RAIt", RAIt )

function RemoveIt(pl, cmd, arg)

	if TimerStatus == 1 then
		if pl.SpawnWait < CurTime() then
			local tr = util.TraceLine(util.GetPlayerTrace(pl))
			local ent = ents.Create( "prop_physics" )
			if ( !ent:IsValid() ) then return end
	
			ent:SetModel(arg[1])
			local Raise = ent:OBBCenter():Distance(ent:OBBMins())
			ent:SetPos(tr.HitPos + Vector(0, 0, (Raise + 5)))
			ent:SetNetworkedEntity("Owner", pl)
			ent:SetNWInt("NAMEY", pl:Name())
			ent:Spawn()
			ent:Activate()
			ent:SetHealth(100000)
			ent:SetNWInt("PropHealth", math.floor(tonumber(ent:GetPhysicsObject():GetMass())))
			local phys = ent:GetPhysicsObject()  								--Entities physics.
			local Calc = phys:GetMass()										--Entities mass.
			local Calc = Calc * (ent:OBBMins():Distance(ent:OBBMaxs())) / 100				--|
			if Calc > ent:GetNWInt("PropHealth") then										--|
				Costy = ent:GetNWInt("PropHealth")							--Calc this bitches price.	--|
			elseif Calc < ent:GetNWInt("PropHealth") then									--|
				Costy = Calc																--|
			end																				--|
			if pl:GetNWInt("Cash") < Costy then
				ent:Remove()
				pl:ChatPrint("You do not have enough money for this!")
			else
				pl:SetNWInt("Cash", math.floor(pl:GetNWInt("Cash") - Costy))
			end
		pl.SpawnWait = CurTime() + .2
		end
	end
end
concommand.Add( "RemoveIt", RemoveIt )

function GM:PlayerShouldTakeDamage(victim, attacker)	

	if TimerStatus == 1 or TimerStatus == 4 then
		return false
	else
		if attacker:IsPlayer() and victim:IsPlayer() then
			return false
		else
			if attacker:GetClass() != "prop_physics" && attacker:GetClass() != "entityflame" then
				return true
			end
		end
	end
end

function GM:PlayerDeath( pl, wep, killer )

	if pl:Team() != 4 then
		pl:SetTeam(4)
	end
	pl.specid = 1
	pl.Specatemode = OBS_MODE_CHASE
end

function GM:PlayerDeathThink(pl)
	
	local Owner = team.GetPlayers(1)
	local Admin = team.GetPlayers(2)
	local Three = team.GetPlayers(3)
	table.Add(Three, Owner)
	table.Add(Three, Admin)
	players = table.Copy(Three)
	
	if TimerStatus == 1 or TimerStatus == 2 then
		pl:UnSpectate()
		pl:Spawn()
	else
		if pl:KeyPressed( IN_JUMP ) then
				if pl.Specatemode == OBS_MODE_CHASE then
					pl.Specatemode = OBS_MODE_IN_EYE
					pl:SetPos(players[pl.specid]:GetPos())
					pl:UnSpectate()
					pl:Spectate(pl.Specatemode)
					pl:SpectateEntity( players[pl.specid] )
				elseif pl.Specatemode == OBS_MODE_IN_EYE then
					pl.Specatemode = OBS_MODE_CHASE
					pl:SetPos(players[pl.specid]:GetPos())
					pl:UnSpectate()
					pl:Spectate(pl.Specatemode)
					pl:SpectateEntity( players[pl.specid] )
				end
		elseif pl:KeyPressed( IN_ATTACK ) then
				if !pl.specid then
					pl.specid = 1
				end
				pl.specid = pl.specid + 1
			
				if pl.specid > #players then
					pl.specid = 1
				end

				pl:SetPos(players[pl.specid]:GetPos())
				pl:UnSpectate()
				pl:Spectate(pl.Specatemode)
				pl:SpectateEntity( players[pl.specid] )
		elseif pl:KeyPressed( IN_ATTACK2 ) then
				if !pl.specid then
					pl.specid = 1
				end
				pl.specid = pl.specid - 1

				if pl.specid <= 0 then
					pl.specid = #players
				end

				pl:SetPos(players[pl.specid]:GetPos())
				pl:UnSpectate()
				pl:Spectate(pl.Specatemode)
				pl:SpectateEntity( players[pl.specid] )
		end
	end
end