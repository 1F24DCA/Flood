include('shared.lua')

function GM:SpawnMenuEnabled()
	return false
end

function GM:SpawnMenuOpen()
	return false
end

local PANEL = {}

function PANEL:Init()

	if Loaded == false || Loaded == nil || Loaded == NULL || Loaded == "" then
		AllTools = spawnmenu.GetTools()
		Msg("|================================|\n")
		Msg("|===Tables loaded successfully===|\n")
		Msg("|================================|\n")
		local Loaded = true
	end
	local tTables = AllTools
	
	MENU = self
	MENU:SetTitle("")
	MENU:ShowCloseButton(false)
	MENU:SetSize(ScrW() - 50, ScrH() - 50)
	MENU:SetPos(25, 25)
	MENU.Paint = function()
		surface.SetDrawColor(0, 0, 0, 0)
		surface.DrawRect(0, 0, MENU:GetWide(), MENU:GetTall())
	end


	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	self.PropPanel = vgui.Create("DPropertySheet")												--| Prop tab.
	self.PropPanel:SetParent(MENU)																--|
	self.PropPanel:SetSize(((MENU:GetWide()*.5 - 5)), MENU:GetTall())							--|
	self.PropPanel:SetPos(0, 0)																	--|
																								--|
	self.PropsBackground = vgui.Create("DPanelList")											--| Prop background.
	self.PropsBackground:EnableHorizontal(true)													--|
	self.PropsBackground:EnableVerticalScrollbar(true)											--|
	self.PropsBackground:SetPadding(5)															--|
	self.PropsBackground:SetSpacing(5)															--|
	self.PropsBackground:SetSize((self.PropPanel:GetWide() - 10), self.PropPanel:GetTall())		--|
	self.PropsBackground:SetPos(0, 0)															--|
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|


	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	self.ToolPanel = vgui.Create("DPropertySheet")												--| Tool tab.
	self.ToolPanel:SetParent(MENU)																--|
	self.ToolPanel:SetSize(((MENU:GetWide()*.5 - 5)), MENU:GetTall())							--|
	self.ToolPanel:SetPos(((MENU:GetWide()*.5 + 5)), 0)											--|
																								--|
	self.ToolsBackground = vgui.Create("DPanelList")											--| Tool background.
	self.ToolsBackground:EnableHorizontal(true)													--|
	self.ToolsBackground:EnableVerticalScrollbar(false)											--|
	self.ToolsBackground:SetAutoSize(false)														--|
	self.ToolsBackground:SetPadding(0)															--|
	self.ToolsBackground:SetSpacing(5)															--|
	self.ToolsBackground:SetSize(0, 0)															--|
	self.ToolsBackground:SetPos(0, 0)															--|
	self.ToolsBackground.Paint = function()														--|
		surface.SetDrawColor(170, 170, 170, 255)												--|
		surface.DrawRect(0, 0, self.ToolsBackground:GetWide(), self.ToolsBackground:GetTall())	--|
	end																							--|
																								--|
	self.ToolList = vgui.Create("DPanelList")													--| Tool list background.
	self.ToolsBackground:AddItem(self.ToolList)													--|
	self.ToolList:EnableVerticalScrollbar(true)													--|
	self.ToolList:SetSize(self.ToolPanel:GetWide()*.33, self.ToolPanel:GetTall() - 31)			--|
	self.ToolList:SetPos(0, 0)																	--|
	self.ToolList:SetAutoSize( false ) 															--|
	self.ToolList:SetSpacing( 1 ) 																--|
	self.ToolList:SetPadding( 0 ) 																--|
																								--|
	self.Content = vgui.Create("DPanelList")													--| Context background.
	self.ToolsBackground:AddItem(self.Content)													--|
	self.Content:SetSize(self.ToolPanel:GetWide()*.63, self.ToolPanel:GetTall() - 31)			--|
	self.Content:EnableVerticalScrollbar(false)													--|
	self.Content:SetSpacing(0)																	--|
	self.Content:SetPadding(5)																	--|
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|


	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	self.WeaponsBackground = vgui.Create("DPanelList")											--| Weapons background.
	self.WeaponsBackground:EnableHorizontal(true)		
	self.WeaponsBackground:EnableVerticalScrollbar(false) 										--|
	self.WeaponsBackground:SetSize((self.ToolPanel:GetWide() - 10), self.ToolPanel:GetTall())	--|
	self.WeaponsBackground:SetPos(0, 0)															--|
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|


	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------| Help background.
	self.HelpBackground = vgui.Create("DPanelList")												--|
	self.HelpBackground:EnableVerticalScrollbar(false) 											--|
	self.HelpBackground:SetSize((self.ToolPanel:GetWide() - 10), self.ToolPanel:GetTall())		--|
	self.HelpBackground:SetPos(0, 0)															--|
	self.HelpBackground.Paint = function()
		local Wide = self.HelpBackground:GetWide()
		local Height = self.HelpBackground:GetTall()
		local Title = "The 6 golden rules you must follow at all times:"
		local One = "Do not hold up a fight round, even if no one is dead."
		local Two = "Attatch/constraint/stick props to the map."
		local Three = "Spam mic/chat/props in any way."
		local Four = "Don't CONSTANTLY build sharks, you can, just dont push it."
		local Five = "Don't be disrespectful in any wat to other players."
		local Six = "Don't exploit any bugs/glitches/errors with the gamemode."
		local Seven = "If any of these rules are broken, you will be kicked/banned on your fault."
		surface.SetDrawColor(50, 50, 50, 255)													--|
		surface.DrawRect(0, 0, Wide, self.DonateBackground:GetTall())--|
		surface.SetTextColor(255, 255, 255, 255)												--|
		
		surface.SetFont("Trebuchet20")															--|
		local TitleW, TitleH = surface.GetTextSize(Title)
		surface.SetTextPos(((Wide*.5) - (TitleW*.5)), ((Height*.03) - (TitleH*.5)))																--|
		surface.DrawText(Title)						

		surface.SetFont("Default")																--|
		local OneW, OneH = surface.GetTextSize(One)
		surface.SetTextPos(((Wide*.5) - (OneW*.5)), ((Height*.09) - (OneH*.5)))		
		surface.DrawText(One)													--|
		
		surface.SetFont("Default")																--|
		local TwoW, TwoH = surface.GetTextSize(Two)
		surface.SetTextPos(((Wide*.5) - (TwoW*.5)), ((Height*.12) - (TwoH*.5)))		
		surface.DrawText(Two)													--|
		
		surface.SetFont("Default")																--|
		local ThreeW, ThreeH = surface.GetTextSize(Three)
		surface.SetTextPos(((Wide*.5) - (ThreeW*.5)), ((Height*.15) - (ThreeH*.5)))		
		surface.DrawText(Three)													--|
		
		surface.SetFont("Default")																--|
		local FourW, FourH = surface.GetTextSize(Four)
		surface.SetTextPos(((Wide*.5) - (FourW*.5)), ((Height*.18) - (FourH*.5)))		
		surface.DrawText(Four)													--|
		
		surface.SetFont("Default")																--|
		local FiveW, FiveH = surface.GetTextSize(Five)
		surface.SetTextPos(((Wide*.5) - (FiveW*.5)), ((Height*.21) - (FiveH*.5)))		
		surface.DrawText(Five)													--|
		
		surface.SetFont("Default")																--|
		local SixW, SixH = surface.GetTextSize(Six)
		surface.SetTextPos(((Wide*.5) - (SixW*.5)), ((Height*.24) - (SixH*.5)))		
		surface.DrawText(Six)													--|
		
		surface.SetTextColor(200, 25, 25, 255)
		surface.SetFont("Default")																--|
		local SevenW, SevenH = surface.GetTextSize(Seven)
		surface.SetTextPos(((Wide*.5) - (SevenW*.5)), ((Height*.27) - (SevenH*.5)))		
		surface.DrawText(Seven)													--|
		surface.SetTextColor(255, 255, 255, 255)
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|												--|
	
	--[[-----------------------------------------------------------------------------------------------------------------------------------------------------------------------| Admin background.
	self.AdminBackground = vgui.Create("DPanelList")												--|
	self.AdminBackground:EnableVerticalScrollbar(false) 											--|
	self.AdminBackground:SetSize((self.ToolPanel:GetWide() - 10), self.ToolPanel:GetTall())		--|
	self.AdminBackground:SetPos(0, 0)															--|
	self.AdminBackground.Paint = function()
		surface.SetDrawColor(50, 50, 50, 255)													--|
		surface.DrawRect(0, 0, self.AdminBackground:GetWide(), self.AdminBackground:GetTall())--|
		surface.SetTextColor(255, 255, 255, 255)												--|
		
		local Title = "Admin menu under construction."
		surface.SetFont("Trebuchet20")															--|
		local TitleW, TitleH = surface.GetTextSize(Title)
		surface.SetTextPos(((self.AdminBackground:GetWide()*.5) - (TitleW*.5)), ((self.AdminBackground:GetTall()*.02) - (TitleH*.5)))																--|
		surface.DrawText(Title)	
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	else--]]
	self.AdminBackground = vgui.Create("DPanelList")												--|
	self.AdminBackground:EnableVerticalScrollbar(false) 											--|
	self.AdminBackground:SetSize((self.ToolPanel:GetWide() - 10), self.ToolPanel:GetTall())		--|
	self.AdminBackground:SetPos(0, 0)															--|
	self.AdminBackground.Paint = function()
		surface.SetDrawColor(170, 170, 170, 255)												--|
		surface.DrawRect(0, 0, self.AdminBackground:GetWide(), self.AdminBackground:GetTall())--|
		--[[surface.SetTextColor(255, 255, 255, 255)												--|
		
		local Title = "You must donate and become an admin to view this menu. Click the donations tab on the left."
		surface.SetFont("Trebuchet20")															--|
		local TitleW, TitleH = surface.GetTextSize(Title)
		surface.SetTextPos(((self.AdminBackground:GetWide()*.5) - (TitleW*.5)), ((self.AdminBackground:GetTall()*.02) - (TitleH*.5)))																--|
		surface.DrawText(Title)	--]]
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------| Donate background.
	self.DonateBackground = vgui.Create("DPanelList")											--|
	self.DonateBackground:EnableVerticalScrollbar(false) 										--|
	self.DonateBackground:SetSize((self.ToolPanel:GetWide() - 10), self.ToolPanel:GetTall())	--|
	self.DonateBackground:SetPos(0, 0)															--|
	self.DonateBackground.Paint = function()													--|
		local Title = "Donations"
		local Two = "With just one donation, you can help keep the server running!"
		local Three = "Our server needs all the help it can get. So please, if you can, donate."
		local Four = "Below you can check what each package recieves."
		local Five = "If you would like to donate or have a question click the button below."
		local Six = "You will be contacted by the owner ASAP."
		surface.SetDrawColor(50, 50, 50, 255)													--|
		surface.DrawRect(0, 0, self.DonateBackground:GetWide(), self.DonateBackground:GetTall())--|
		surface.SetTextColor(255, 255, 255, 255)												--|
		
		surface.SetFont("Trebuchet20")															--|
		local TitleW, TitleH = surface.GetTextSize(Title)
		surface.SetTextPos(((self.DonateBackground:GetWide()*.5) - (TitleW*.5)), ((self.DonateBackground:GetTall()*.02) - (TitleH*.5)))																--|
		surface.DrawText(Title)						

		surface.SetFont("Default")																--|
		local TwoW, TwoH = surface.GetTextSize(Two)
		surface.SetTextPos(((self.DonateBackground:GetWide()*.5) - (TwoW*.5)), ((self.DonateBackground:GetTall()*.06) - (TwoH*.5)))		
		surface.DrawText(Two)													--|
		
		surface.SetFont("Default")																--|
		local ThreeW, ThreeH = surface.GetTextSize(Three)
		surface.SetTextPos(((self.DonateBackground:GetWide()*.5) - (ThreeW*.5)), ((self.DonateBackground:GetTall()*.08) - (ThreeH*.5)))		
		surface.DrawText(Three)													--|
		
		surface.SetFont("Default")																--|
		local FourW, FourH = surface.GetTextSize(Four)
		surface.SetTextPos(((self.DonateBackground:GetWide()*.5) - (FourW*.5)), ((self.DonateBackground:GetTall()*.12) - (FourH*.5)))		
		surface.DrawText(Four)													--|
		
		surface.SetFont("Default")																--|
		local FiveW, FiveH = surface.GetTextSize(Five)
		surface.SetTextPos(((self.DonateBackground:GetWide()*.5) - (FiveW*.5)), ((self.DonateBackground:GetTall()*.46) - (FiveH*.5)))		
		surface.DrawText(Five)													--|
		
		surface.SetFont("Default")																--|
		local SixW, SixH = surface.GetTextSize(Six)
		surface.SetTextPos(((self.DonateBackground:GetWide()*.5) - (SixW*.5)), ((self.DonateBackground:GetTall()*.48) - (SixH*.5)))		
		surface.DrawText(Six)													--|
	end																							--|
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	
	
    local Vip = vgui.Create("DButton")
    Vip:SetParent(self.DonateBackground)
    Vip:SetText( "Vip Package Info" )
    Vip:SetPos(((self.DonateBackground:GetWide()*.5) - (Vip:GetWide())), ((self.DonateBackground:GetTall()*.24) - (Vip:GetTall()*.5)))
    Vip:SetSize( 125, 25 )
    Vip.DoClick = function ( btn )
     VipOptions = DermaMenu()
	 VipOptions:AddOption("VIP cost: $5.00")
	 VipOptions:AddOption("Benefits:")
	 VipOptions:AddOption("VIP tag")
     VipOptions:AddOption("vote kick")
	 VipOptions:AddOption("$5000 cash")
	 VipOptions:AddOption("Nailer tool")
     VipOptions:AddOption("Coloring tool")
	 VipOptions:AddOption("Material tool")
	 VipOptions:AddOption("Thrusters tool")
	 VipOptions:AddOption("Noclip for build mode")
	 VipOptions:AddOption("Possibly more later on.")
     VipOptions:Open()
    end 
	
   --[[ local Mod = vgui.Create("DButton")
    Mod:SetParent(self.DonateBackground)
    Mod:SetText( "Mod Package Info" )
    Mod:SetPos(((self.DonateBackground:GetWide()*.5) - (Mod:GetWide())), ((self.DonateBackground:GetTall()*.24) - (Vip:GetTall()*.5)))
    Mod:SetSize( 125, 25 )
    Mod.DoClick = function ( btn )
     ModOptions = DermaMenu()
	 ModOptions:AddOption("Mod cost: $5.00")
	 ModOptions:AddOption("Benefits:")
	 ModOptions:AddOption("Mod tag")
	 ModOptions:AddOption("vote ban")
     ModOptions:AddOption("vote kick")
	 ModOptions:AddOption("$5000 cash")
	 ModOptions:AddOption("Coloring tool")
     ModOptions:AddOption("Material tool")
	 ModOptions:AddOption("Ballsocker_adv tool")
	 ModOptions:AddOption("Noclip for build mode")
	 ModOptions:AddOption("Possibly more later on.")
     ModOptions:Open()
    end --]]
	
    local Admin = vgui.Create("DButton")
    Admin:SetParent(self.DonateBackground)
    Admin:SetText( "Silver Package Info" )
    Admin:SetPos(((self.DonateBackground:GetWide()*.5) - (Admin:GetWide())), ((self.DonateBackground:GetTall()*.3) - (Admin:GetTall()*.5)))
    Admin:SetSize( 125, 25 )
    Admin.DoClick = function ( btn )
     AdminOptions = DermaMenu()
	 AdminOptions:AddOption("Silver Member cost: $10.00")
	 AdminOptions:AddOption("Benefits:")
	 AdminOptions:AddOption("SM tag")
	 AdminOptions:AddOption("ban Max 1 day")
     AdminOptions:AddOption("kick")
	 AdminOptions:AddOption("$10000 cash")
	 AdminOptions:AddOption("other commands")
	 AdminOptions:AddOption("Noclip for build mode")
     AdminOptions:AddOption("All tools except duplicator.")
	 AdminOptions:AddOption("Possibly more later on.")
     AdminOptions:Open()
    end 
	
    local SuperAdmin = vgui.Create("DButton")
    SuperAdmin:SetParent(self.DonateBackground)
    SuperAdmin:SetText( "Gold Package Info" )
    SuperAdmin:SetPos(((self.DonateBackground:GetWide()*.5) - (SuperAdmin:GetWide())), ((self.DonateBackground:GetTall()*.36) - (SuperAdmin:GetTall()*.5)))
    SuperAdmin:SetSize( 125, 25 )
    SuperAdmin.DoClick = function ( btn )
     SuperAdminOptions = DermaMenu()
	 SuperAdminOptions:AddOption("Gold Member cost: $15.00")
	 SuperAdminOptions:AddOption("Benefits:")
	 SuperAdminOptions:AddOption("GM tag")
	 SuperAdminOptions:AddOption("All tools")
	 SuperAdminOptions:AddOption("$15000 cash")
	 SuperAdminOptions:AddOption("All commands")
	 SuperAdminOptions:AddOption("Noclip for build mode")
	 SuperAdminOptions:AddOption("Possibly more later on.")
     SuperAdminOptions:Open()
    end 
	
    local Buty = vgui.Create("DButton")
    Buty:SetParent(self.DonateBackground)
    Buty:SetText( "Donate" )
    Buty:SetPos(((self.DonateBackground:GetWide()*.5) - (Buty:GetWide())), ((self.DonateBackground:GetTall()*.54) - (Buty:GetTall()*.5)))
    Buty:SetSize( 125, 25 )
    Buty.DoClick = function ( btn )
		RunConsoleCommand("DOScreen")
		MENU:SetVisible(false)
		RememberCursorPosition()
		gui.EnableScreenClicker(false)
    end 

	for k, v in pairs(WeaponInfo) do
		local Sweps = vgui.Create("SpawnIcon")
		Sweps:SetModel(v.MDL)
		Sweps:SetToolTip(v.Tip)
		Sweps.DoClick = function()
			RunConsoleCommand("Purchase", v.Weapon)
			MENU:SetVisible(false)
			RememberCursorPosition()
			gui.EnableScreenClicker(false)
		end
		self.WeaponsBackground:AddItem(Sweps)
	end
	
	if tTables then
		for k, v in pairs(tTables[1].Items) do 
			if ( type( v ) == "table" ) then 	 
				local Name = v.ItemName 
				local Label = v.Text 
				v.ItemName = nil 
				v.Text = nil 
				self:AddCategory( Name, Label, v ) 
			end
		end
	else
		LocalPlayer():ChatPrint("There has been an error loading your tools section, please rejoin the server or contact an administrator to fix this.")
	end


	if PList then
		for k, v in pairs(PList) do
			local Props = vgui.Create("SpawnIcon")
			Props:SetModel(v)
			Props:SetToolTip(k)
			Props.DoClick = function()
				local MDL = v
				RunConsoleCommand("RemoveIt", MDL)
			end
			self.PropsBackground:AddItem(Props)
		end
	else
		LocalPlayer():ChatPrint("There has been an error loading your props section, please rejoin the server or contact an administrator to fix this.")
	end
	
	self.PropPanel:AddSheet("Props", self.PropsBackground, "gui/silkicons/brick_add", true, false)
	self.PropPanel:AddSheet("Weapons", self.WeaponsBackground, "gui/silkicons/bomb", true, false)
	self.PropPanel:AddSheet("Donations", self.DonateBackground, "gui/silkicons/heart", true, false)
	self.ToolPanel:AddSheet("Tools", self.ToolsBackground, "gui/silkicons/wrench", false, false)
	self.ToolPanel:AddSheet("Help/Rules", self.HelpBackground, "gui/silkicons/exclamation", false, false)
	self.ToolPanel:AddSheet("Admin", self.AdminBackground, "gui/silkicons/shield", true, false)
end

function PANEL:AddCategory( Name, Label, tItems )
	
	self.Category = vgui.Create( "DCollapsibleCategory") 
 	self.ToolList:AddItem( self.Category ) 
 	self.Category:SetLabel( Label ) 
 	self.Category:SetCookieName( "ToolMenu."..tostring(Name) ) 
 	 
 	self.CategoryContent = vgui.Create( "DPanelList" ) 
 	self.CategoryContent:SetAutoSize( true ) 
 	self.CategoryContent:SetDrawBackground( false ) 
 	self.CategoryContent:SetSpacing( 0 ) 
 	self.CategoryContent:SetPadding( 0 ) 
 	self.Category:SetContents( self.CategoryContent ) 
 	 
	local bAlt = true
	 
 	for k, v in pairs( tItems ) do 
 		local Item = vgui.Create( "ToolMenuButton", self ) 
 		Item:SetText( v.Text ) 
 		Item.OnSelect = function( button ) self:EnableControlPanel( button ) end 
 		concommand.Add( Format( "tool_%s", v.ItemName ), function() Item:OnSelect() end ) 
		
 		if ( v.SwitchConVar ) then 
 			Item:AddCheckBox( v.SwitchConVar ) 
 		end 

 		Item.ControlPanelBuildFunction = v.CPanelFunction 
 		Item.Command = v.Command 
 		Item.Name = v.ItemName 
 		Item.Controls = v.Controls 
 		Item.Text = v.Text 

 		Item:SetAlt( bAlt ) 
 		bAlt = !bAlt 

 		self.CategoryContent:AddItem( Item ) 
 	end
end

 function PANEL:EnableControlPanel( button ) 
   
 	if ( self.LastSelected ) then 
 		self.LastSelected:SetSelected( false ) 
 	end 
 	 
 	button:SetSelected( true ) 
 	self.LastSelected = button 
   
 	local cp = controlpanel.Get( button.Name ) 
 	if ( !cp:GetInitialized() ) then 
 		cp:FillViaTable( button ) 
 	end 
 	 
 	self.Content:Clear() 
 	self.Content:AddItem( cp ) 
 	self.Content:Rebuild() 
   
 	g_ActiveControlPanel = cp 
 	 
 	if ( button.Command ) then 
 		LocalPlayer():ConCommand( button.Command ) 
 	end 
 		 
 end
 
function PANEL:Think()
	
end

function PANEL:Close()
 	MENU:Remove()
end

function PANEL:PerformLayout()

end

vgui.Register("menu", PANEL, "DFrame")


function ResetPList(PL)
	MENU.PlayerList:Clear()
	for k, v in pairs(player.GetAll()) do
		if PL ~= v:Nick() then
			MENU.PlayerList:AddItem(v:Nick())
		end
	end
end

local function AdminMenu()
MENU.PlayerList = vgui.Create( "DComboBox")
MENU.PlayerList:SetParent( MENU.AdminBackground )
MENU.PlayerList:SetPos( 0, 0 )
MENU.PlayerList:SetSize( MENU.AdminBackground:GetWide()*.333, 225 )
MENU.PlayerList:SetMultiple( false ) // Don't use this unless you know extensive knowledge about tables
ResetPList()

MENU.Kick = vgui.Create( "DButton" )
MENU.Kick:SetParent( MENU.AdminBackground ) // Set parent to our "DermaPanel"
MENU.Kick:SetText("Kick")
MENU.Kick:SetPos( ((MENU.AdminBackground:GetWide()*.333) + 5), 0 )
MENU.Kick:SetSize( ((MENU.AdminBackground:GetWide()*.333) - 5), 50 )
	MENU.Kick.DoClick = function ()
		local Value = MENU.PlayerList:GetSelectedItems()[1]
		if Value != nil && Value != NULL && Value != "" then
			RunConsoleCommand("FM_Kick", Value:GetValue())
			local PlayerLeft = Value:GetValue()
			ResetPList(PlayerLeft)
		else
			print("No player selected!")
		end
	end 
	
	MENU.BanTime = vgui.Create("DMultiChoice")
	MENU.BanTime:SetParent( MENU.AdminBackground )
	MENU.BanTime:SetPos( ((MENU.AdminBackground:GetWide()*.666) + 5), 0 )
	MENU.BanTime:SetSize( ((MENU.AdminBackground:GetWide()*.333) - 5), 20 )
	MENU.BanTime:SetEditable(false)
	MENU.BanTime:AddChoice("5 Minutes")
	MENU.BanTime:AddChoice("15 Minutes")
	MENU.BanTime:AddChoice("30 Minutes")
	MENU.BanTime:AddChoice("1 Hour")
	MENU.BanTime:AddChoice("2 Hours")
	MENU.BanTime:AddChoice("6 Hours")
	MENU.BanTime:AddChoice("1 Day")
	MENU.BanTime:AddChoice("2 Days")
	MENU.BanTime:AddChoice("7 Days")
	MENU.BanTime:AddChoice("1 Month")
	MENU.BanTime:AddChoice("6 Months")
	MENU.BanTime:AddChoice("1 Year")
	MENU.BanTime:AddChoice("Forever")
	MENU.BanTime:ChooseOptionID(1)
	MENU.BanTime:SetEnabled(true)
	
MENU.Ban = vgui.Create( "DButton" )
MENU.Ban:SetParent( MENU.AdminBackground ) // Set parent to our "DermaPanel"
MENU.Ban:SetText("Ban")
MENU.Ban:SetPos( ((MENU.AdminBackground:GetWide()*.666) + 5), 25 )
MENU.Ban:SetSize( ((MENU.AdminBackground:GetWide()*.333) - 5), 25 )
	MENU.Ban.DoClick = function ()
		local Value = MENU.PlayerList:GetSelectedItems()[1]
		local Time = MENU.BanTime.TextEntry
		if Value != nil && Value != NULL && Value != "" then
			if Time != nil && Time != NULL && Time != "" then
				RunConsoleCommand("FM_Ban", Value:GetValue(), Time:GetValue())
				local PlayerLeft = Value:GetValue()
				ResetPList(PlayerLeft)
			else
				print("No time Specified")
			end
		else
			print("No player selected!")
		end
	end 
	
MENU.Slay = vgui.Create( "DButton" )
MENU.Slay:SetParent( MENU.AdminBackground ) // Set parent to our "DermaPanel"
MENU.Slay:SetText("Slay")
MENU.Slay:SetPos( ((MENU.AdminBackground:GetWide()*.333) + 5), 55 )
MENU.Slay:SetSize( ((MENU.AdminBackground:GetWide()*.333) - 5), 50 )
	MENU.Slay.DoClick = function ()
		local Value = MENU.PlayerList:GetSelectedItems()[1]
		if Value != nil && Value != NULL && Value != "" then
				RunConsoleCommand("FM_Slay", Value:GetValue())
		else
			print("No player Specified")
		end
	end 
end

function PlayerMenu()
MENU.HAHA = vgui.Create( "DButton" )
MENU.HAHA:SetParent( MENU.AdminBackground ) // Set parent to our "DermaPanel"
MENU.HAHA:SetText("Big button O' doom says you are not admin and can't view this page!")
MENU.HAHA:SetPos( 0, 0 )
MENU.HAHA:SetSize( MENU.AdminBackground:GetWide(), MENU.AdminBackground:GetTall() )
	MENU.HAHA.DoClick = function ()
		LocalPlayer():ConCommand("say I like penis in my butt :D!")
	end
end

function GM:OnSpawnMenuOpen()
	if MENU == nil or not MENU:IsValid() then
		vgui.Create("menu")
		if LocalPlayer():IsAdmin() then
			AdminMenu()
		else
			PlayerMenu()
		end
	else
		MENU:SetVisible(true)
		if LocalPlayer():IsAdmin() then
			AdminMenu()
		else
			PlayerMenu()
		end
	end
	gui.EnableScreenClicker(true)
	RestoreCursorPosition()
end

function GM:OnSpawnMenuClose()
	if MENU and MENU:IsValid() and MENU:IsVisible() then
		MENU:SetVisible(false)
	end
	RememberCursorPosition()
	gui.EnableScreenClicker(false)
end

function GM:Think()
	for k, v in pairs(player.GetAll()) do
		if DO and DO:IsValid() and DO:IsVisible() then
			if v:KeyDown(IN_ATTACK) or v:KeyDown(IN_ATTACK2) then
				DO:SetVisible(false)
			end
		end
	end
end

function DOScreen()
	DO = vgui.Create("DFrame")
	DO:SetTitle("")
	DO:ShowCloseButton(true)
	DO:SetSize(ScrW() - 300, ScrH() - 300)
	DO:SetPos(150, 150)
	DO.Paint = function()
		local One = "If you would like to donate, please visit the website below and click the donate button."
		local Two = "www.FloodMod.blogspot.com"
		local Three = "After you donate you will recieve the package you have donated for."
		local Four = "A donation is a donation, no refunds. Packages are just an add for your kindness"
		local Five = ""
		local Six = ""
		local Seven = "Left or right click to close this screen."
		
		surface.SetDrawColor(50, 50, 50, 255)													--|
		surface.DrawRect(0, 0, DO:GetWide(), DO:GetTall())--|
		surface.SetTextColor(255, 255, 255, 255)												--|
		
		surface.SetFont("Default")															--|
		local OneW, OneH = surface.GetTextSize(One)
		surface.SetTextPos(((DO:GetWide()*.5) - (OneW*.5)), ((DO:GetTall()*.04) - (OneH*.5)))																--|
		surface.DrawText(One)		
	
		surface.SetFont("Default")															--|
		local TwoW, TwoH = surface.GetTextSize(Two)
		surface.SetTextPos(((DO:GetWide()*.5) - (TwoW*.5)), ((DO:GetTall()*.12) - (TwoH*.5)))																--|
		surface.DrawText(Two)		
		
		surface.SetFont("Default")															--|
		local ThreeW, ThreeH = surface.GetTextSize(Three)
		surface.SetTextPos(((DO:GetWide()*.5) - (ThreeW*.5)), ((DO:GetTall()*.2) - (ThreeH*.5)))																--|
		surface.DrawText(Three)
		
		surface.SetDrawColor(255, 255, 255, 255)													--|
		surface.DrawRect(0, (DO:GetTall()*.28) - 1, DO:GetWide(), 2)--|
		
		surface.SetFont("Default")															--|
		local FourW, FourH = surface.GetTextSize(Four)
		surface.SetTextPos(((DO:GetWide()*.5) - (FourW*.5)), ((DO:GetTall()*.36) - (FourH*.5)))																--|
		surface.DrawText(Four)
		
		surface.SetFont("Default")															--|
		local FiveW, FiveH = surface.GetTextSize(Five)
		surface.SetTextPos(((DO:GetWide()*.5) - (FiveW*.5)), ((DO:GetTall()*.41) - (FiveH*.5)))																--|
		surface.DrawText(Five)
		
		surface.SetFont("Default")															--|
		local SixW, SixH = surface.GetTextSize(Six)
		surface.SetTextPos(((DO:GetWide()*.5) - (SixW*.5)), ((DO:GetTall()*.5) - (SixH*.5)))																--|
		surface.DrawText(Six)
		
		surface.SetDrawColor(255, 255, 255, 255)													--|
		surface.DrawRect(0, (DO:GetTall()*.58) - 1, DO:GetWide(), 2)--|
		
		surface.SetFont("Default")															--|
		local SevenW, SevenH = surface.GetTextSize(Seven)
		surface.SetTextPos(((DO:GetWide()*.5) - (SevenW*.5)), ((DO:GetTall()*.66) - (SevenH*.5)))																--|
		surface.DrawText(Seven)
	end
end
concommand.Add("DOScreen", DOScreen)

PList = {}
PList["Cost: $39\nHealth: 45"] = "models/props_c17/FurnitureTable002a.mdl"
PList["Cost: $30\nHealth: 30"] = "models/props_c17/gravestone_coffinpiece002a.mdl"
PList["Cost: $18\nHealth: 30"] = "models/props_c17/oildrum001.mdl"
PList["Cost: $90\nHealth: 90"] = "models/props_c17/shelfunit01a.mdl"
PList["Cost: $75\nHealth: 75"] = "models/props_c17/concrete_barrier001a.mdl"
PList["Cost: $5\nHealth: 25"] = "models/props_borealis/door_wheel001a.mdl"
PList["Cost: $131\nHealth: 131"] = "models/props_c17/display_cooler01a.mdl"
PList["Cost: $70\nHealth: 90"] = "models/props_c17/canister_propane01a.mdl"
PList["Cost: $17\nHealth: 20"] = "models/props_c17/bench01a.mdl"
PList["Cost: $286\nHealth: 300"] = "models/props_c17/FurnitureCouch001a.mdl"
PList["Cost: $19\nHealth: 35"] = "models/Combine_Helicopter/helicopter_bomb01.mdl"
PList["Cost: $399\nHealth: 399"] = "models/props_c17/FurnitureShelf001a.mdl"
PList["Cost: $17\nHealth: 30"] = "models/props_c17/gravestone003a.mdl"
PList["Cost: $1769\nHealth: 1999"] = "models/props_c17/Lockers001a.mdl"
PList["Cost: $30\nHealth: 37"] = "models/props_debris/metal_panel02a.mdl"
PList["Cost: $150\nHealth: 150"] = "models/props_debris/metal_panel01a.mdl"
PList["Cost: $36\nHealth: 60"] = "models/props_c17/canister01a.mdl"
PList["Cost: $126\nHealth: 126"] = "models/props_doors/door03_slotted_left.mdl"
PList["Cost: $465\nHealth: 465"] = "models/props_docks/dock03_pole01a_256.mdl"
PList["Cost: $304\nHealth: 304"] = "models/props_docks/dock01_pole01a_128.mdl"
PList["Cost: $199\nHealth: 200"] = "models/props_interiors/BathTub01a.mdl"
PList["Cost: $86\nHealth: 100"] = "models/props_interiors/Furniture_Desk01a.mdl"
PList["Cost: $13\nHealth: 20"] = "models/props_borealis/mooring_cleat01.mdl"
PList["Cost: $251\nHealth: 251"] = "models/props_interiors/Furniture_shelf01a.mdl"
PList["Cost: $356\nHealth: 399"] = "models/props_interiors/refrigerator01a.mdl"
PList["Cost: $26\nHealth: 40"] = "models/props_interiors/refrigeratorDoor01a.mdl"
PList["Cost: $600\nHealth: 600"] = "models/props_interiors/VendingMachineSoda01a.mdl"
PList["Cost: $200\nHealth: 200"] = "models/props_interiors/VendingMachineSoda01a_door.mdl"
PList["Cost: $20\nHealth: 20"] = "models/props_building_details/Storefront_Template001a_Bars.mdl"
PList["Cost: $39\nHealth: 59"] = "models/props_borealis/bluebarrel001.mdl"
 
WeaponInfo = {}
WeaponInfo[1] = {
	MDL = "models/weapons/W_crossbow.mdl",
	Weapon = "weapon_crossbow",
	Tip = "Name: CrossBow\nCost: $3000\nDamage: 10\nAmmo: Infinite\nInfo: Spawns with you every round."
}
WeaponInfo[2] = {
	MDL = "models/w_rpg.mdl",
	Weapon = "weapon_rpg",
	Tip = "Name: RocketLauncher\nCost: $10000\nDamage: 0-100 multiple props\nAmmo: 3\nInfo: Spawns with you every round."
}
WeaponInfo[3] = {
	MDL = "models/weapons/w_smg_tmp.mdl",
	Weapon = "weapon_tmp",
	Tip = "Name: Tmp\nCost: $12000\nDamage: 3\nAmmo: 180\nInfo: Spawns with you every round."
}
WeaponInfo[4] = {
	MDL = "models/weapons/w_pist_deagle.mdl",
	Weapon = "weapon_deagle",
	Tip = "Name: Deagle\nCost: $1000\nDamage: 3\nAmmo: Infinite\nInfo: Spawns with you every round."
}
WeaponInfo[5] = {
	MDL = "models/weapons/W_357.mdl",
	Weapon = "weapon_357",
	Tip = "Name: Magnum\nCost: $2000\nDamage: 4\nAmmo: Infinite\nInfo: Spawns with you every round."
}