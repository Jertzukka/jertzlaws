if SERVER then

	local Default = "191 155 117 255 1 1 1"

	if(file.Exists("jertzlaws/panelcolor.txt", "DATA")) then
		local readfile = file.Read( "jertzlaws/panelcolor.txt", "DATA" )
		if(table.Count(string.Explode(" ",readfile)) != (table.Count(string.Explode(" ",Default)))) then
			print("Missmatch in length of the files. Reset to default.")
			file.Write("jertzlaws/panelcolor.txt", Default)
		else
			print("Settings found for Jertz's laws. Currently set to: " .. readfile)
		end
	else
		print("Settings not found, first time using the addon? Created the directory and default settings.")
		file.CreateDir("jertzlaws")
		file.Write("jertzlaws/panelcolor.txt", Default)
	end

	util.AddNetworkString( "receivecolor" )
	util.AddNetworkString( "getcolorsonjoin" )
	util.AddNetworkString( "notification" )
	util.AddNetworkString( "broadcastnotification" )
	util.AddNetworkString( "getcolorsonnotification" )

	function ReadColor()
		local testifile = file.Read( "jertzlaws/panelcolor.txt", "DATA" )
		local filetable = string.Split(testifile," ")

		ServerColor = Color(filetable[1], filetable[2], filetable[3])
		ApplyLines = tonumber(filetable[5])
		Notifications = tonumber(filetable[6])
		Sounds = tonumber(filetable[7])
	end

	function SendColors( ply )
		local sendtable = {ApplyLines, Notifications, Sounds}
		net.Start( "getcolorsonjoin" )
			net.WriteColor(ServerColor)
			net.WriteTable(sendtable)
		net.Send(ply)
		return nil
	end

	function SendColorsToAll()
		local sendtable = {ApplyLines, Notifications, Sounds}
		net.Start( "getcolorsonnotification" )
			net.WriteColor(ServerColor)
			net.WriteTable(sendtable)
		net.Broadcast()
		return nil
	end

	ReadColor()

	net.Receive( "receivecolor", function( len, ply )

		Access = 0

		for i=1, table.Count(AccessToSettings) do
			if(string.lower(ply:GetUserGroup()) == string.lower(AccessToSettings[i])) then
				Access = 1
			end
		end

		if(Access == 1) then
			local Color = net.ReadColor()
			local applyandnotifications = net.ReadTable()
			local ApplyToLines = applyandnotifications[1]
			local Notifications = applyandnotifications[2]
			Sounds = applyandnotifications[3]
			ServerColor = Color
			ApplyLines = ApplyToLines
			local string = tostring(Color) .. " " .. ApplyToLines .. " " .. Notifications .. " " .. Sounds
			print("[JERTZLAWS]  " .. ply:Name() .. " changed the window color to " .. tostring(Color) .. " with ApplyToLines = " .. ApplyToLines .. " and Notifications = " .. Notifications .. " and Sounds = " .. Sounds)

			file.CreateDir("jertzlaws")
			file.Write("jertzlaws/panelcolor.txt", string)
		else
			print("HACKING ATTEMPT. " .. ply:Name() .. "(" .. ply:SteamID() .. ") Attempted to change settings in Jertz's Law menu without having the access.")
		end
	end )

	hook.Add( "PlayerSay", "getscolors", function( ply, text, team )
		local texttable = string.Split(text," ")
		for i=1, table.Count(OpenLawsCommands) do
			if( string.lower(texttable[1]) == string.lower(OpenLawsCommands[i]) ) then
				SendColors(ply)
				return ""
			end
		end

		if ( table.HasValue({ TEAM_MAYOR }, ply:Team()) and texttable[1] == "/addlaw" and table.Count(DarkRP.getLaws()) < 12 and string.len(string.Replace(text,"/addlaw ","")) >= 3 ) then
			SendColorsToAll()
			local lawtobeadded = string.Replace(text,"/addlaw ","")
			net.Start( "broadcastnotification" )
					net.WriteString(lawtobeadded)
					net.WriteEntity(ply)
					net.WriteInt(0,3)
					net.WriteInt(Sounds, 3)
			net.Broadcast()
		elseif ( table.HasValue({ TEAM_MAYOR }, ply:Team()) and texttable[1] == "/removelaw" and table.Count(texttable) == 2 and tonumber(texttable[2]) > table.Count(GAMEMODE.Config.DefaultLaws)) and tonumber(texttable[2]) <= table.Count(DarkRP.getLaws()) then
			SendColorsToAll()
			net.Start( "broadcastnotification" )
					net.WriteString(texttable[2])
					net.WriteEntity(ply)
					net.WriteInt(1,3)
					net.WriteInt(Sounds, 3)
			net.Broadcast()
		elseif ( table.HasValue({ TEAM_MAYOR }, ply:Team()) and texttable[1] == "/resetlaws" and table.Count(DarkRP.getLaws()) > table.Count(GAMEMODE.Config.DefaultLaws) ) then
			SendColorsToAll()
			net.Start( "broadcastnotification" )
					net.WriteString("")
					net.WriteEntity(ply)
					net.WriteInt(2,3)
					net.WriteInt(Sounds, 3)
			net.Broadcast()
		end
	end )
end