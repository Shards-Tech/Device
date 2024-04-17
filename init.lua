-- Services --
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

-- Constants --
local MAX_PHONE_SCREEN_SIZE_Y = 600

-- Module --
export type DeviceTypes = "Computer" | "Tablet" | "Phone" | "Console" | "VR"
type DeviceWhich = {
	[DeviceTypes]: () -> (),
}

local Device = {}

--[=[
    Returns the device type its currently on.

    For example:
    ```lua
    local DeviceType = Device.get() -- Computer
    ```
]=]
function Device.get()
	if GuiService:IsTenFootInterface() or UserInputService.GamepadEnabled then
		return "Console"
	elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
		local deviceSize = workspace.CurrentCamera.ViewportSize

		if deviceSize.Y > MAX_PHONE_SCREEN_SIZE_Y then
			return "Tablet"
		else
			return "Phone"
		end
	elseif UserInputService.VREnabled then
		return "VR"
	else
		return "Computer"
	end
end

--[=[
    Returns true or false if the given the DeviceType is matching.

    For example:
    ```lua
    local isComputer = Device.is("Computer") -- true
    ```
]=]
function Device.is(DeviceType: DeviceTypes)
	return Device.get() == DeviceType
end

--[=[
    Run the callback function when the given DeviceType match with the current
    DeviceType.

    For example:
    ```lua
    Device.on("Computer", function() 
        -- Stuff going on specifically for Computer Devices.
    end) 
    ```
]=]
function Device.on(DeviceType: DeviceTypes, Fn: () -> ())
	if Device.is(DeviceType) then
		Fn()
	end

	return false
end

--[=[

    For example:
    ```lua
    Device.which {
        Computer = function() 
            -- Do stuff on the computer end.
        end,

        Phone = function()
            -- Do stuff in the phone end.
        end,

        Tablet = function()
            -- Do stuff in the tablet end.
        end,
    }
    ```
]=]
function Device.which(Extension: DeviceWhich)
	for DeviceType, Fn in pairs(Extension) do
		if Device.is(DeviceType) then
			return Fn()
		end
	end
end

return Device
