AddCSLuaFile()
-- ///////////////////////////////////////////////
-- //											//
-- //				Jertz's Laws 				//
-- //											//
-- ///////////////////////////////////////////////

print("Jertz's Laws SETTINGS LOADED.")

-- The headtitle of the Law Menu
LawsTitle = "Laws of the Land"

-- Which ranks are allowed to change settings within the Law Menu? Not case-sensitive.
AccessToSettings = {"superadmin", "owner"}

-- Which commands open the Law Menu. Not case-sensitive.
OpenLawsCommands = {"/laws", "/law"}

-- The notification sound path
SoundPath = "buttons/lever1.wav"

-- Icons on the left on notifications?
NotificationIcons = true

-- ///////////////////////////////////////////////////
-- //												//
-- //  The text on the menus. Change these if you 	//
-- //	 want to translate into other language. 	//
-- //			Use \n for next line.				//
-- //												//
-- ///////////////////////////////////////////////////

-- MENUS --

 -- Default "Add Law"
AddLawText = "Add Law"
 -- Default "    Remove\nSelected Law"
RemoveSelectedLawText = "    Remove\nSelected Law"
-- Default "Reset Laws"
ResetLawsText = "Reset Laws"
-- Default "Confirm Reset Laws"
ConfirmResetLawsText = "Confirm Reset Laws"
-- Default "Yes"
YesText = "Yes"
-- Default "No"
NoText = "No"
-- Default "Add a new law"
AddanewlawText = "Add a new law"
-- Default "Cancel"
CancelText = "Cancel"
-- Default "Character limit over 118"
CharacterLimitText = "Character limit over 118"
-- Default "Remove selected law"
OptionRemoveLaw = "Remove selected law"
-- Default "Copy to clipboard"
OptionCopyClipboard = "Copy to clipboard"

-- NOTIFICATIONS -- 

-- Default {"The Mayor "," has added a new law!"}
NotificationAddLaw = {"The Mayor "," has added a new law!"}
-- Default {"The Mayor "," has removed the law #"}
NotificationRemoveLaw = {"The Mayor "," has removed the law #"}
-- Default {"The Mayor "," has reset the laws!"}
NotificationResetLaws = {"The Mayor "," has reset the laws!"}