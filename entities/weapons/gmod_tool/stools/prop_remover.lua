TOOL.Category		= "Construction"
TOOL.Name			= "#Prop Remover"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if CLIENT then
	language.Add( "Tool_prop_remover_name", "Prop Remover" )
	language.Add( "Tool_prop_remover_desc", "Remove props and refund some money." )
	language.Add( "Tool_prop_remover_0", "Primary: Remove prop" )
end

function TOOL:LeftClick(tr)
	if !tr.Entity:IsValid() or tr.Entity:IsPlayer() or tr.Entity:IsWorld() then return false end
	RunConsoleCommand("RAIt")
end

function TOOL.BuildCPanel( cp )
	cp:AddControl( "Header", { Text = "#Tool_prop_remover_name", Description	= "#Tool_prop_remover_desc" }  )
end