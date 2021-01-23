TOOL.Category		= "Construction"
TOOL.Name			= "#Prop Healer"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if CLIENT then
	language.Add( "Tool_prop_healer_name", "Prop Healer" )
	language.Add( "Tool_prop_healer_desc", "heal props for a small fee." )
	language.Add( "Tool_prop_healer_0", "Primary: heal prop" )
end

function TOOL:LeftClick(tr)
	if !tr.Entity:IsValid() or tr.Entity:IsPlayer() or tr.Entity:IsWorld() then return false end
	RunConsoleCommand("HAIt")
end

function TOOL.BuildCPanel( cp )
	cp:AddControl( "Header", { Text = "#Tool_prop_healer_name", Description	= "#Tool_prop_healer_desc" }  )
end