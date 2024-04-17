# ✨ Device

Simple way to know which device type player currently on.

Install using wally: 

```toml
Device = "Shards-Tech/Device@0.1.0"
```

## 📃 Documentation

Types:
```lua
type DeviceTypes = "Computer" | "Tablet" | "Phone" | "Console" | "VR"
type DeviceWhich = {
	[DeviceTypes]: () -> (),
}
```

1. Using `Device.get()` returns a `DeviceTypes`

For example:

```lua
-- Player environment: Computer

local DeviceType = Device.get() -- Returns Computer 
```

2. Using `Device.is(DeviceType: DeviceTypes)` returns a `boolean`

For example:

```lua
-- Player environment: Phone

local isComputer = Device.is("Computer") -- Returns false.
```

3. Using `Device.on(DeviceType: DeviceTypes, Fn: () -> ())` returns `()`

For example:

```lua
-- Player environment: Computer

Device.on("Computer", function()
    -- Do stuff.
end)
```

3. Using `Device.which(Extension: DeviceWhich)` returns `()`

For example:

```lua
-- Player environment: Computer

Device.which({
    Computer = function()
        -- Do computer related stuff.
    end,

    Phone = function()
        -- Do phone related stuff, but its unreachable on Computer environment.
    end,
})
```