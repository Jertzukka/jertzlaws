AddCSLuaFile()

ChosenAmount = 30

surface.CreateFont( "CustomFont", {
	font = "TargetID",
	size = 13,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BiggerFont", {
	font = "TargetID",
	size = 16,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "NoShadow", {
	font = "TargetID",
	size = 18,
	weight = 1400,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BiggerX", {
	font = "TargetID",
	size = 22,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BiggerTitle", {
	font = "TargetID",
	size = 18,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BiggerTitleNoShadow", {
	font = "TargetID",
	size = 18,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "TextFont", {
	font = "Arial",
	size = 16,
	weight = 500,
} )


local AddLawIcon = Material("materials/icon16/script_add.png")
local RemoveLawIcon = Material("materials/icon16/script_delete.png")
local ResetLawsIcon = Material("materials/icon16/script_go.png")

local function DrawAddIcon()
	surface.SetMaterial(AddLawIcon)
	surface.SetDrawColor(255,255,255,200)
	surface.DrawTexturedRect(ScrW()/2-270,Pos+5,16,16)
	--surface.DrawTexturedRect(ScrW()/2+253,Pos+4,16,16)
end

local function DrawRemoveIcon()
	surface.SetMaterial(RemoveLawIcon)
	surface.SetDrawColor(255,255,255,200)
	surface.DrawTexturedRect(ScrW()/2-270,Pos+5,16,16)
end

local function DrawResetIcon()
	surface.SetMaterial(ResetLawsIcon)
	surface.SetDrawColor(255,255,255,200)
	surface.DrawTexturedRect(ScrW()/2-270,Pos+5,16,16)
end

function DelayRefresh()
	timer.Create( "Refresh", 0.1, 1, function()
		RefreshLaws()
		PopUpLaws()
	end)
end

function ReColor(Applycolor, Applytolines)
	--chat.AddText("Changed shit to " .. tostring(Applycolor) .. " ApplyToLines = " .. tostring(Applytolines))
	if(IsValid(frame)) then
		frame.Paint = function(s, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(Applycolor.r-30,0), math.max(Applycolor.g-30,0), math.max(Applycolor.b-30,0), 255) )
			draw.RoundedBox( 0, 1, 1, w-2, h-2, Applycolor )
			draw.RoundedBox( 0, 24, 49, 452, table.Count(Laws)*27+2, Color(math.max(Applycolor.r-ChosenAmount+10, 0), math.max(Applycolor.g-ChosenAmount+10, 0) , math.max(Applycolor.b-ChosenAmount+10, 0) , 255 ) )
		end
		--SettingsLabel:SetColor(Color(math.min(Applycolor.r+50, 255), math.min(Applycolor.g+50, 255), math.min(Applycolor.b+50, 255), 255))
		DermaListView.Paint = function(s, w, h)
			if(Applytolines == 0) then
				for i=0, table.Count(Laws) do
					if(i%2 == 0) then
						draw.RoundedBox(0,0,0+i*27,w,27,Color(200,200,200))
					else
						draw.RoundedBox(0,0,0+i*27,w,27,Color(255,255,255))
					end
				end
			else
				for i=0, table.Count(Laws) do
					if(i%2 == 0) then
						draw.RoundedBox(0,0,0+i*27,w,27,Color(math.max(Applycolor.r-ChosenAmount+20, 0), math.max(Applycolor.g-ChosenAmount+20, 0) , math.max(Applycolor.b-ChosenAmount+20, 0) , 255 ))
					else
						draw.RoundedBox(0,0,0+i*27,w,27,Applycolor)
					end
				end
			end
		end

		buttonAddLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(math.max(Applycolor.r-ChosenAmount, 0), math.max(Applycolor.g-ChosenAmount, 0) , math.max(Applycolor.b-ChosenAmount, 0) , 255 ))
		end
		buttonRemoveLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(math.max(Applycolor.r-ChosenAmount, 0), math.max(Applycolor.g-ChosenAmount, 0) , math.max(Applycolor.b-ChosenAmount, 0) , 255 ))
		end
		buttonResetLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(math.max(Applycolor.r-ChosenAmount, 0), math.max(Applycolor.g-ChosenAmount, 0) , math.max(Applycolor.b-ChosenAmount, 0) , 255 ))
		end

		buttonAddLaw:SetColor(Color(math.min(Applycolor.r+50, 255), math.min(Applycolor.g+50, 255), math.min(Applycolor.b+50, 255), 255))
		buttonRemoveLaw:SetColor(Color(math.min(Applycolor.r+50, 255), math.min(Applycolor.g+50, 255), math.min(Applycolor.b+50, 255), 255))
		buttonResetLaw:SetColor(Color(math.min(Applycolor.r+50, 255), math.min(Applycolor.g+50, 255), math.min(Applycolor.b+50, 255), 255))

		TitleBackground:SetBackgroundColor(Color(math.max(Applycolor.r-ChosenAmount, 0), math.max(Applycolor.g-ChosenAmount, 0) , math.max(Applycolor.b-ChosenAmount, 0) , 255 ))
	end
end

function RefreshLaws()
	Laws = DarkRP.getLaws()
	LawsString = ""

	for i=1, table.Count(Laws) do
		LawsString = LawsString .. i .. ". " .. Laws[i] .. "\n"
	end
end

function PopUpLaws()
	RefreshLaws()

	-- if(frame) then
	-- 	frame:SetVisible(true)
	-- 	frame:MakePopup()
	-- 	if(LocalPlayer():IsPlayer() and LocalPlayer():IsSuperAdmin() and !SettingsLabel) then
	-- 		SettingsLabel = vgui.Create("DLabel")
	-- 		SettingsLabel:SetText("SA Settings")
	-- 		SettingsLabel:SetParent(TitleBackground)
	-- 		SettingsLabel:SetPos(10,4)
	-- 		SettingsLabel:SetColor(Color(255,255,255,255))
	-- 		SettingsLabel.DoClick = function()
	-- 			SAMenu()
	-- 		end
	-- 	end
	-- else
	-- 	print("Had to recreate frame..")
	-- 	CreateLawFrame()
	-- 	frame:SetVisible(true)
	-- 	frame:MakePopup()
	-- end

	frame:SetVisible(true)
	frame:MakePopup()

	local Access = 0

	if(LocalPlayer():IsPlayer()) then
		for i=1, table.Count(AccessToSettings) do
			if(string.lower(LocalPlayer():GetUserGroup()) == string.lower(AccessToSettings[i])) then
				Access = 1
			end
		end
	end

	
	if(LocalPlayer():IsPlayer() and Access == 1) then
		
		SettingsButtonBackground = vgui.Create( "DPanel", TitleBackground )
		SettingsButtonBackground:SetSize(20,20)
		SettingsButtonBackground:SetPos(7, 5)
		SettingsButtonBackground.Paint = function(s, w, h)
			draw.RoundedBox(0,0,0,w,h,Color(math.max(ChosenColor.r,0), math.max(ChosenColor.g,0), math.max(ChosenColor.b,0), 255))
		end

		SettingsButton = vgui.Create( "DImageButton", frame )
		SettingsButton:SetPos( 7, 7 )											
		SettingsButton:SetImage( "materials/icon16/cog_go.png" )		
		SettingsButton:SizeToContents()							
		SettingsButton.DoClick = function()
			if !(IsValid(SAFrame)) then
				SAMenu()
			end
			SAFrame:MakePopup()
			SAFrame:SetVisible(true)
		end
	end



	DermaListView:SetSize(450, table.Count(Laws)*27)
	frame:SetSize(SizeW,SizeH-40-(27*(12-table.Count(Laws))))
	frame:Center()
	buttonAddLaw:SetPos( 50, 390-(27*(12-table.Count(Laws))) )
	buttonRemoveLaw:SetPos( 200, 390-(27*(12-table.Count(Laws))) )
	buttonResetLaw:SetPos( 350, 390-(27*(12-table.Count(Laws))) )

	if(table.HasValue({ TEAM_MAYOR }, LocalPlayer():Team())) then
		buttonAddLaw:SetDisabled(false)
		buttonRemoveLaw:SetDisabled(false)
		buttonResetLaw:SetDisabled(false)
		buttonAddLaw:SetVisible(true)
		buttonRemoveLaw:SetVisible(true)
		buttonResetLaw:SetVisible(true)
		frame:SetSize(SizeW,SizeH-4-(27*(12-table.Count(Laws))))

		buttonAddLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(math.max(ChosenColor.r-ChosenAmount, 0), math.max(ChosenColor.g-ChosenAmount, 0) , math.max(ChosenColor.b-ChosenAmount, 0) , 255 ))
		end
		buttonRemoveLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(math.max(ChosenColor.r-ChosenAmount, 0), math.max(ChosenColor.g-ChosenAmount, 0) , math.max(ChosenColor.b-ChosenAmount, 0) , 255 ))
		end
		buttonResetLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(math.max(ChosenColor.r-ChosenAmount, 0), math.max(ChosenColor.g-ChosenAmount, 0) , math.max(ChosenColor.b-ChosenAmount, 0) , 255 ))
		end
	else
		buttonAddLaw:SetDisabled(true)
		buttonRemoveLaw:SetDisabled(true)
		buttonResetLaw:SetDisabled(true)
		buttonAddLaw:SetVisible(false)
		buttonRemoveLaw:SetVisible(false)
		buttonResetLaw:SetVisible(false)
		frame:SetSize(SizeW,SizeH-55-(27*(12-table.Count(Laws))))

		buttonAddLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(80,80,80))
		end
		buttonRemoveLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(80,80,80))
		end
		buttonResetLaw.Paint = function(s, w, h)
			draw.RoundedBox(2,0,0,w,h,Color(80,80,80))
		end
	end

	DermaListView:Clear()
	for i=1, table.Count(Laws) do
    	DermaListView:AddLine(i, Laws[i]) -- Add lines
	end

	frame.Paint = function(s, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
		draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		draw.RoundedBox( 0, 24, 49, 452, table.Count(Laws)*27+2, Color(math.max(ChosenColor.r-ChosenAmount+10, 0), math.max(ChosenColor.g-ChosenAmount+10, 0) , math.max(ChosenColor.b-ChosenAmount+10, 0) , 255 ) )
	end

	DermaListView.Paint = function(s, w, h)
		--chat.AddText("ApplyLines : " .. ApplyLines .. " and ApplyToLines : " .. ApplyToLines)
		if(ApplyLines == 0) then
			for i=0, table.Count(Laws) do
				if(i%2 == 0) then
					draw.RoundedBox(0,0,0+i*27,w,27,Color(200,200,200))
				else
					draw.RoundedBox(0,0,0+i*27,w,27,Color(255,255,255))
				end
			end
		else
			for i=0, table.Count(Laws) do
				if(i%2 == 0) then
					draw.RoundedBox(0,0,0+i*27,w,27,Color(math.max(ChosenColor.r-ChosenAmount+20, 0), math.max(ChosenColor.g-ChosenAmount+20, 0) , math.max(ChosenColor.b-ChosenAmount+20, 0) , 255 ))
				else
					draw.RoundedBox(0,0,0+i*27,w,27,ChosenColor)
				end
			end
		end
	end
end

function Confirm()

	if !(IsValid(ConfirmMenu)) then
		ConfirmMenu = vgui.Create( "DFrame" )
		ConfirmMenu:SetTitle( ConfirmResetLawsText )
		ConfirmMenu:SetSize( 200, 70 )
		ConfirmMenu:Center()
		ConfirmMenu:MakePopup()
		ConfirmMenu:ShowCloseButton(false)
		ConfirmMenu:SetDeleteOnClose(false)
		ConfirmMenu.Paint = function( self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
			draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		end

		ConfirmTitleBackground = vgui.Create("DPanel")
		ConfirmTitleBackground:SetParent(ConfirmMenu)
		ConfirmTitleBackground:SetPos(-2,0)
		ConfirmTitleBackground:SetSize(SizeW+4, 30)
		ConfirmTitleBackground:SetBackgroundColor(Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255))
		ConfirmTitleBackground:SetAlpha(255)

		ConfirmHeadtitle = vgui.Create("DLabel")
		ConfirmHeadtitle:SetContentAlignment(5)
		ConfirmHeadtitle:SetParent(ConfirmTitleBackground)
		ConfirmHeadtitle:SetPos(200/2-100, 3)
		ConfirmHeadtitle:SetText(ConfirmResetLawsText)
		ConfirmHeadtitle:SetFont("CustomFont")
		ConfirmHeadtitle:SetColor(Color(255,255,255))
		ConfirmHeadtitle:SetSize(200,25)

		buttonYes = vgui.Create("DButton")
		buttonYes:SetParent( ConfirmMenu )
		buttonYes:SetText( YesText )
		buttonYes:SetColor(Color(60,60,60))
		buttonYes:SetPos( 20, 38 )
		buttonYes:SetSize( 72, 25 )
		buttonYes:SetFont("CustomFont")
		buttonYes:SetTextColor(Color(255,255,255))
		buttonYes.Paint = function( self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
			draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		end
		buttonYes.DoClick = function()
			RunConsoleCommand("say", "/resetlaws") 
			DelayRefresh()
			ConfirmMenu:SetVisible(false)
		end

		buttonNo = vgui.Create("DButton")
		buttonNo:SetParent( ConfirmMenu )
		buttonNo:SetText( NoText )
		buttonNo:SetColor(Color(60,60,60))
		buttonNo:SetPos( 108, 38 )
		buttonNo:SetSize( 70, 25 )
		buttonNo:SetFont("CustomFont")
		buttonNo:SetTextColor(Color(255,255,255))
		buttonNo.Paint = function( self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
			draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		end
		buttonNo.DoClick = function()
			ConfirmMenu:SetVisible(false)
		end
	else
		ConfirmMenu:MakePopup()
		ConfirmMenu:SetVisible(true)
	end

end

function AddLaw()

	if !(IsValid(AddLawMenu)) then
		AddLawMenu = vgui.Create( "DFrame" )
		AddLawMenu:SetTitle( "Confirm Reset Laws" )
		AddLawMenu:SetSize( 350, 125 )
		AddLawMenu:Center()
		AddLawMenu:MakePopup()
		AddLawMenu:ShowCloseButton(false)
		AddLawMenu:SetDeleteOnClose(false)
		AddLawMenu.Paint = function( self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
			draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		end

		InputText = vgui.Create("DTextEntry", AddLawMenu)
		InputText:SetText("")
		InputText:SetPos(25,40)
		InputText:SetSize(300, 20)
		InputText:RequestFocus()
		InputText.OnEnter = function(self) 
			Msg("Text Entered: " .. self:GetValue() .. "\n") 
		end

		AddLawMenuTitleBackground = vgui.Create("DPanel")
		AddLawMenuTitleBackground:SetParent(AddLawMenu)
		AddLawMenuTitleBackground:SetPos(-2,0)
		AddLawMenuTitleBackground:SetSize(SizeW+4, 30)
		AddLawMenuTitleBackground:SetBackgroundColor(Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255))
		AddLawMenuTitleBackground:SetAlpha(255)

		AddLawMenuHeadtitle = vgui.Create("DLabel")
		AddLawMenuHeadtitle:SetParent(AddLawMenuTitleBackground)
		AddLawMenuHeadtitle:SetPos(350/2-175, 3)
		AddLawMenuHeadtitle:SetText(AddanewlawText)
		AddLawMenuHeadtitle:SetContentAlignment(5)
		AddLawMenuHeadtitle:SetFont("CustomFont")
		AddLawMenuHeadtitle:SetColor(Color(255,255,255))
		AddLawMenuHeadtitle:SetSize(350,25)

		CharlimitLabel = vgui.Create("DLabel")
		CharlimitLabel:SetParent(AddLawMenu)
		CharlimitLabel:SetPos(350/2-175, 100)
		CharlimitLabel:SetText(CharacterLimitText)
		CharlimitLabel:SetContentAlignment(5)
		CharlimitLabel:SetFont("CustomFont")
		CharlimitLabel:SetColor(Color(255,0,0))
		CharlimitLabel:SetVisible(false)
		CharlimitLabel:SetSize(350,25)

		AddbuttonYes = vgui.Create("DButton")
		AddbuttonYes:SetParent( AddLawMenu )
		AddbuttonYes:SetText( "Add Law" )
		AddbuttonYes:SetColor(Color(60,60,60))
		AddbuttonYes:SetPos( 350/3-40, 70 )
		AddbuttonYes:SetSize( 80, 30 )
		AddbuttonYes:SetFont("CustomFont")
		AddbuttonYes:SetTextColor(Color(255,255,255))
		AddbuttonYes.Paint = function( self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
			draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		end
		AddbuttonYes.DoClick = function()
			if(InputText:GetValue() != "") then
				RunConsoleCommand("say", "/addlaw" .. " " .. InputText:GetValue()) 
				DelayRefresh()
				AddLawMenu:SetVisible(false)
			end
		end

		InputText.OnTextChanged = function(self)
			if(tonumber(string.len(InputText:GetValue())) > 118) then
				AddbuttonYes:SetDisabled(true)
				CharlimitLabel:SetVisible(true)
			else
				AddbuttonYes:SetDisabled(false)
				CharlimitLabel:SetVisible(false)
			end
		end

		AddbuttonNo = vgui.Create("DButton")
		AddbuttonNo:SetParent( AddLawMenu )
		AddbuttonNo:SetText( CancelText )
		AddbuttonNo:SetColor(Color(60,60,60))
		AddbuttonNo:SetPos( 350/3*2-40, 70 )
		AddbuttonNo:SetSize( 80, 30 )
		AddbuttonNo:SetFont("CustomFont")
		AddbuttonNo:SetTextColor(Color(255,255,255))
		AddbuttonNo.Paint = function( self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
			draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		end
		AddbuttonNo.DoClick = function()
			AddLawMenu:SetVisible(false)
		end
	else
		AddLawMenu:MakePopup()
		AddLawMenu:SetVisible(true)
	end

end

function SAMenu()

	ApplyToLines = 0

	SAFrame = vgui.Create( "DFrame" )
	SAFrame:SetTitle( "SA Settings" )
	SAFrame:SetSize( 300, 400 )
	SAFrame:SetPos(ScrW()/2+255, ScrH()/2-200)
	SAFrame:MakePopup()
	SAFrame:SetDeleteOnClose(false)
	SAFrame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255) )
		draw.RoundedBox( 0, 1, 1, w-2, h-2, ChosenColor )
		draw.RoundedBox( 4, 10, 30, 280, 110, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 255))
	end


	local warningLabel = vgui.Create("DLabel", SAFrame)
	warningLabel:SetText("   This menu is only available to specific ranks.\n Don't touch anything unless you're supposed to.")
	warningLabel:SetColor(Color(180,0,0))
	warningLabel:SetSize(350,40)
	warningLabel:SetPos(30, 30)

	local ColorPicker = vgui.Create( "DColorMixer", SAFrame )
	ColorPicker:SetSize( 200, 200 )
	ColorPicker:SetPos( 50, 150 )
	ColorPicker:SetPalette( true )
	ColorPicker:SetAlphaBar( false )
	ColorPicker:SetWangs( true )
	ColorPicker:SetColor(ChosenColor)

	CheckBoxThing = vgui.Create( "DCheckBoxLabel", SAFrame )
	CheckBoxThing:SetPos( 20,75 )
	CheckBoxThing:SetText( "Apply color to list aswell?" )
	CheckBoxThing:SizeToContents()
	CheckBoxThing:SetValue(ApplyLines)

	CheckBoxNotifications = vgui.Create( "DCheckBoxLabel", SAFrame )
	CheckBoxNotifications:SetPos( 20,95 )
	CheckBoxNotifications:SetText( "Display notifications when new law is added?" )
	CheckBoxNotifications:SizeToContents()
	CheckBoxNotifications:SetValue(Notifications)

	CheckBoxSounds = vgui.Create( "DCheckBoxLabel", SAFrame )
	CheckBoxSounds:SetPos( 20,115 )
	CheckBoxSounds:SetText( "Play a sound on notification?" )
	CheckBoxSounds:SizeToContents()
	CheckBoxSounds:SetValue(Sounds)

	local ConfirmColor = vgui.Create( "DButton", SAFrame )
	ConfirmColor:SetText( "Confirm" )
	ConfirmColor:SetSize( 90, 30 )
	ConfirmColor:SetPos( 100, SAFrame:GetTall() - 40 )
	ConfirmColor.DoClick = function()
		if(LocalPlayer():IsSuperAdmin()) then
			ChosenColor = ColorPicker:GetColor()

			if(CheckBoxThing:GetChecked()) then
				ApplyToLines = 1
			else
				ApplyToLines = 0
			end

			if(CheckBoxNotifications:GetChecked()) then
				Notifications = 1
			else
				Notifications = 0
			end

			if(CheckBoxSounds:GetChecked()) then
				Sounds = 1
			else
				Sounds = 0
			end

			local newChosenColor = Color(ChosenColor.r, ChosenColor.g, ChosenColor.b)
			local applyandnotifications = {ApplyToLines, Notifications, Sounds}

			ReColor(newChosenColor, ApplyToLines)

			net.Start( "receivecolor" )
				net.WriteColor(newChosenColor)
				net.WriteTable(applyandnotifications)
			net.SendToServer()
		else
			chat.AddText("No access.")
		end
	end

end

function CreateLawFrame()
	SizeW = 500
	SizeH = 450

	net.Receive( "sendcolortoallusers", function( len, ply )
		local Color2 = net.ReadColor()
		local ApplyToLines = net.ReadInt(3)

		CurrentColor = Color2
		ApplyTo = ApplyToLines
	end )

	frame = vgui.Create("DFrame")
	frame:SetSize(SizeW,SizeH)
	frame:Center()
	frame:SetTitle("")
	frame:SetVisible(false)
	frame:SetDeleteOnClose(false)
	frame:ShowCloseButton(false)
	frame:SetAlpha(240)
	frame:SetDraggable(true)
	frame:SetKeyboardInputEnabled(false)
	frame.DoClick = function()
		DermaListView:ClearSelection()
	end

	DermaListView = vgui.Create("DListView")
	DermaListView:SetParent(frame)
	DermaListView:SetPos(25, 50)
	DermaListView:SetHeaderHeight(0)
	Col1 = DermaListView:AddColumn( "Number" )
	Col2 = DermaListView:AddColumn( "Law" )
	Col1:SetMinWidth( 50 ) --***** Line/column width. Do not touch this. Bug found. See below.
	Col1:SetMaxWidth( 50 ) --***** Do not touch this.
	DermaListView:SetDataHeight( 27 )
	DermaListView:SetMultiSelect(false)
	DermaListView.OnRowRightClick = function()
		if(isnumber(DermaListView:GetSelectedLine())) then
			local MenuButtonOptions = DermaMenu()
			if(table.HasValue({ TEAM_MAYOR }, LocalPlayer():Team())) then
				MenuButtonOptions:AddOption(OptionRemoveLaw, function()
					if(DermaListView:GetSelectedLine() != nil) then 
						RunConsoleCommand("say", "/removelaw " .. DermaListView:GetSelectedLine()) DelayRefresh() 
						DermaListView:ClearSelection()
					end
				end)
			end
			MenuButtonOptions:AddOption(OptionCopyClipboard, function() 
				SetClipboardText(DermaListView:GetSelectedLine() .. ". " .. Laws[DermaListView:GetSelectedLine()])
				notification.AddLegacy( "Law copied to clipboard.", NOTIFY_GENERIC, 4 )
				DermaListView:ClearSelection()
			end)
			MenuButtonOptions:Open()
		end
	end

	TitleBackground = vgui.Create("DPanel")
	TitleBackground:SetParent(frame)
	TitleBackground:SetPos(-2,0)
	TitleBackground:SetSize(SizeW+4, 30)
	--TitleBackground:SetBackgroundColor(Color(math.max(ChosenColor.r-ChosenAmount, 0), math.max(ChosenColor.g-ChosenAmount, 0) , math.max(ChosenColor.b-ChosenAmount, 0) , 255 ))
	TitleBackground:SetBackgroundColor(Color( 255,255,255,255 ))
	TitleBackground:SetAlpha(255)

	Headtitle = vgui.Create("DLabel")
	Headtitle:SetParent(TitleBackground)
	Headtitle:SetPos(SizeW/2-250, 3)
	Headtitle:SetText(LawsTitle)
	Headtitle:SetContentAlignment(5)
	Headtitle:SetFont("NoShadow")
	Headtitle:SetColor(Color(0,0,0))
	Headtitle:SetSize(500,25)

	-- CloseButton = vgui.Create("DButton")
	-- CloseButton:SetSize(22,22)
	-- CloseButton:SetParent(TitleBackground)
	-- CloseButton:SetPos(SizeW-30, 4)
	-- CloseButton:SetText("")
	-- CloseButton:SetAlpha(255)
	-- CloseButton.DoClick = function()
	-- 	frame:SetVisible(false)
	-- end
	-- CloseButton.Paint = function(s, w, h)
	-- 	draw.RoundedBox(2,0,0,w,h,Color(180,0,0))
	-- 	draw.SimpleText( "X", "BiggerX", w/2, h/2, Color(0,0,0), 1, 1 )
	-- end

	CloseButtonBackground = vgui.Create( "DPanel", TitleBackground )
	CloseButtonBackground:SetSize(20,20)
	CloseButtonBackground:SetPos(SizeW-23, 5)
	CloseButtonBackground.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(math.max(ChosenColor.r,0), math.max(ChosenColor.g,0), math.max(ChosenColor.b,0), 255))
	end

	InfoButtonBackground = vgui.Create( "DPanel", TitleBackground )
	InfoButtonBackground:SetSize(20,20)
	InfoButtonBackground:SetPos(SizeW-47, 5)
	InfoButtonBackground.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(math.max(ChosenColor.r,0), math.max(ChosenColor.g,0), math.max(ChosenColor.b,0), 255))
	end

	InfoButton = vgui.Create( "DImageButton", frame )
	InfoButton:SetPos( SizeW-47, 7 )											
	InfoButton:SetImage( "materials/icon16/information.png" )		
	InfoButton:SizeToContents()							
	InfoButton.DoClick = function()
		gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=715049979")
	end

	CloseButton = vgui.Create( "DImageButton", TitleBackground )
	CloseButton:SetPos( SizeW-21, 7 )	
	CloseButton:SetSize(16,16)				
	CloseButton:SetColor(Color(20,20,20))					
	CloseButton:SetImage( "materials/icon16/cross.png" )								
	CloseButton.DoClick = function()
		frame:SetVisible(false)
	end


	buttonAddLaw = vgui.Create("DButton")
	buttonAddLaw:SetParent( frame )
	buttonAddLaw:SetText( AddLawText )
	buttonAddLaw:SetColor(Color(60,60,60))
	buttonAddLaw:SetPos( 50, 400 )
	buttonAddLaw:SetSize( 100, 40 )
	buttonAddLaw:SetFont("CustomFont")

	local Access = 0

	if(LocalPlayer():IsPlayer()) then
		for i=1, table.Count(AccessToSettings) do
			if(string.lower(LocalPlayer():GetUserGroup()) == string.lower(AccessToSettings[i])) then
				Access = 1
			end
		end
	end

	if(LocalPlayer():IsPlayer() and Access == 1) then
		
		SettingsButtonBackground = vgui.Create( "DPanel", TitleBackground )
		SettingsButtonBackground:SetSize(20,20)
		SettingsButtonBackground:SetPos(7, 5)
		SettingsButtonBackground.Paint = function(s, w, h)
			draw.RoundedBox(0,0,0,w,h,Color(math.max(ChosenColor.r,0), math.max(ChosenColor.g,0), math.max(ChosenColor.b,0), 255))
		end

		SettingsButton = vgui.Create( "DImageButton", frame )
		SettingsButton:SetPos( 7, 7 )											
		SettingsButton:SetImage( "materials/icon16/cog_go.png" )		
		SettingsButton:SizeToContents()							
		SettingsButton.DoClick = function()
			if !(IsValid(SAFrame)) then
				SAMenu()
			end
			SAFrame:MakePopup()
			SAFrame:SetVisible(true)
		end
	end

	buttonAddLaw.DoClick = function()
		AddLaw()
	end

	buttonRemoveLaw = vgui.Create("DButton")
	buttonRemoveLaw:SetParent( frame )
	buttonRemoveLaw:SetText( RemoveSelectedLawText )
	buttonRemoveLaw:SetColor(Color(60,60,60))
	buttonRemoveLaw:SetPos( 200, 400 )
	buttonRemoveLaw:SetSize( 100, 40 )
	buttonRemoveLaw.DoClick = function ()
		if(DermaListView:GetSelectedLine() != nil) then RunConsoleCommand("say", "/removelaw " .. DermaListView:GetSelectedLine()) DelayRefresh() end
	end

	buttonResetLaw = vgui.Create("DButton")
	buttonResetLaw:SetParent( frame )
	buttonResetLaw:SetColor(Color(60,60,60))
	buttonResetLaw:SetText( ResetLawsText )
	buttonResetLaw:SetPos( 350, 400 )
	buttonResetLaw:SetSize( 100, 40 )
	buttonResetLaw.DoClick = function() 
		Confirm()
	end


	buttonAddLaw:SetFont("CustomFont")
	buttonRemoveLaw:SetFont("CustomFont")
	buttonResetLaw:SetFont("CustomFont")
	buttonAddLaw:SetContentAlignment( 5 )
	buttonRemoveLaw:SetContentAlignment( 5 )
	buttonResetLaw:SetContentAlignment( 5 )

end

hook.Add( "Initialize", "CreateFrame", CreateLawFrame)

net.Receive( "getcolorsonjoin", function( len, ply )
	CreateLawFrame()
	RefreshLaws()
	PopUpLaws()
	local Color = net.ReadColor()
	local sendtable = net.ReadTable()
	ApplyLines = tonumber(sendtable[1])
	Notifications = tonumber(sendtable[2])
	Sounds = tonumber(sendtable[3])
	ChosenColor = Color
	ReColor(Color, ApplyLines)
end )

net.Receive( "getcolorsonnotification", function( len, ply )
	RefreshLaws()
	local Color = net.ReadColor()
	local sendtable = net.ReadTable()
	ApplyLines = tonumber(sendtable[1])
	Notifications = tonumber(sendtable[2])
	Sounds = tonumber(sendtable[3])
	ChosenColor = Color
	ReColor(Color, ApplyLines)
end )

function CutString( inputstring, charlimit )
	--print("input string: " .. inputstring)
	local explodedtable = string.Explode(" ",inputstring)
	local linetable = {}
	local stringtoadd = ""
	local charcount = 0
	local linecount = 1
	for i=1, table.Count(explodedtable) do
		if(#explodedtable[i] + charcount <= charlimit) then
			charcount = charcount + #explodedtable[i]
			stringtoadd = stringtoadd .. " " .. explodedtable[i]
		else
			--print("Charcount " .. charcount .. " over the limit " .. charlimit .. " so adding string with " .. string.len(stringtoadd) .. " characters to the linetable with " .. table.Count(linetable) .. " entries.")
			linecount = linecount + 1
			charcount = 0
			table.insert(linetable, stringtoadd)
			stringtoadd = ""
			charcount = charcount + #explodedtable[i]
			stringtoadd = stringtoadd .. " " .. explodedtable[i]
		end
	end
	if(strintoadd != "") then
		table.insert(linetable, stringtoadd)
	end
	return linetable
end

net.Receive( "broadcastnotification", function( len, ply )
	--print("Displayed notification.")
	DelayRefresh()
	local string = net.ReadString()
	local entity = net.ReadEntity()
	local status = net.ReadInt(3)
	local sounds = net.ReadInt(3)
	--print("Notification Status: " .. status .. " and Sounds " .. sounds)

	if(status == 1) then
		if(tonumber(string) > 3) then
			cuttable = CutString(string, 50)
			if(Sounds == 1) then
				surface.PlaySound( SoundPath )
			end
		end
	else
		cuttable = CutString(string, 50)
		if(Sounds == 1) then
			surface.PlaySound( SoundPath )
		end
	end

	Pos = -(table.Count(cuttable)*30)
	Removing = 0

	function DrawNotification()
		if(Pos < 0 and Removing == 0) then
			Pos = Pos+1
		elseif(Pos > -(table.Count(cuttable)*30) and Removing == 1) then
			Pos = Pos-1
		end --team.GetColor(LocalPlayer():Team())

		--local NotificationAddLawParsed = markup.Parse( "<font=BiggerTitle><colour=255, 255, 255, 255>" .. NotificationAddLaw[1] .. "<font=BiggerTitleNoShadow><colour=150, 20, 20, 255>" .. entity:Name() .. "<font=BiggerTitle><colour=255, 255, 255, 255>" .. NotificationAddLaw[2])

		if(status == 0) then -- ADD LAW
			draw.RoundedBoxEx(5, ScrW() / 2-275, Pos, 550, 25, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 200), false, false, false, false)
			if NotificationIcons then
				draw.RoundedBoxEx(8, ScrW() / 2-275 + 1, Pos+1, 23, 23, Color(255,255,255,30), true, true, true, true)
				DrawAddIcon()
				draw.SimpleText(NotificationAddLaw[1] .. entity:Name() .. NotificationAddLaw[2], "BiggerTitle", ScrW() / 2+12, Pos+4, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(NotificationAddLaw[1] .. entity:Name() .. NotificationAddLaw[2], "BiggerTitle", ScrW() / 2, Pos+4, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			end
			--NotificationAddLawParsed:Draw( ScrW() / 2, Pos+4, TEXT_ALIGN_CENTER )
			for i=1, table.Count(cuttable) do
				local lastrow
				if(i == table.Count(cuttable)) then
					lastrow = true
				else
					lastrow = false
				end
				local newstring = cuttable[i]
				draw.RoundedBoxEx(5, ScrW() / 2-275, Pos+25*i, 550, 25, Color(ChosenColor.r, ChosenColor.g, ChosenColor.b, 200), false, false, lastrow, lastrow)
				draw.SimpleText(newstring, "BiggerFont", ScrW() / 2, Pos+30+25*(i-1), Color(255,255,255,255), TEXT_ALIGN_CENTER)
			end
		elseif(status == 1) then -- REMOVE LAW
			draw.RoundedBoxEx(5, ScrW() / 2-275, Pos, 550, 25, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 200), false, false, true, true)
			if NotificationIcons then
				draw.RoundedBoxEx(8, ScrW() / 2-275 + 1, Pos+1, 23, 23, Color(255,255,255,30), true, true, true, true)
				DrawRemoveIcon()
				draw.SimpleText(NotificationRemoveLaw[1] .. entity:Name() .. NotificationRemoveLaw[2] .. string .. "!", "BiggerTitle", ScrW() / 2+12, Pos+4, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(NotificationRemoveLaw[1] .. entity:Name() .. NotificationRemoveLaw[2] .. string .. "!", "BiggerTitle", ScrW() / 2, Pos+4, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			end
		elseif(status == 2) then -- RESET LAWS
			draw.RoundedBoxEx(5, ScrW() / 2-275, Pos, 550, 25, Color(math.max(ChosenColor.r-30,0), math.max(ChosenColor.g-30,0), math.max(ChosenColor.b-30,0), 200), false, false, true, true)
			if NotificationIcons then
				draw.RoundedBoxEx(8, ScrW() / 2-275 + 1, Pos+1, 23, 23, Color(255,255,255,30), true, true, true, true)
				DrawResetIcon()
				draw.SimpleText(NotificationResetLaws[1] .. entity:Name() .. NotificationResetLaws[2], "BiggerTitle", ScrW() / 2+12, Pos+4, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(NotificationResetLaws[1] .. entity:Name() .. NotificationResetLaws[2], "BiggerTitle", ScrW() / 2, Pos+4, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			end
		end

		if(Pos <= -(table.Count(cuttable)*30)) then
			hook.Remove("HUDPaint", "DrawNotification")
			--print("Hook removed")
		end
	end

	hook.Add("HUDPaint", "DrawNotification", DrawNotification);

	timer.Destroy("HideNotification")
	timer.Create("HideNotification", 10, 1,function()
		Removing = 1
	end)
end )

