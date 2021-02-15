if SERVER then

	print("Jertz's Laws INIT LOADED.")

	AddCSLuaFile()
	AddCSLuaFile("jl_settings.lua")
	AddCSLuaFile("client/cl_laws.lua")
	include("jl_settings.lua")
	include("server/laws.lua")
else
	include("client/cl_laws.lua")
	include("jl_settings.lua")
end