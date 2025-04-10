W = {}
function W.is_wsl()
	local wsl_interop = os.getenv("WSL_INTEROP")
	local wsl_distro_name = os.getenv("WSL_DISTRO_NAME")
	return wsl_interop ~= nil or wsl_distro_name ~= nil
end
return W
