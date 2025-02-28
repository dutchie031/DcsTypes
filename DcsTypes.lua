
--[[

    This file is intended to be used as reference and easy intellisense during lua development in DCS.
    By adding this file into your LUA directory the classes and functions should be recognised by any intellisense tool that supports lua annotations.
    https://luals.github.io/wiki/annotations

    Authored by: Dutchie

]]


---@class Vec2 
---@field x number
---@field y  number

---@class Vec3 
---@field x number
---@field y number
---@field z number


---@class env
---@field info fun(log:string, showMessageBox:boolean?) Prints passed log line with prefix 'info'
---@field warning fun(log:string, showMessageBox:boolean?) Prints passed log line with prefix 'warning'
---@field error fun(log:string, showMessageBox:boolean?) Prints passed log line with prefix 'error'
---@field setErrorMessageBoxEnabled fun(toggle:boolean?) Enables or disables the lua error box to show up on a lua error
---@field getValueDictByKey fun(value:string) : string Returns a string associated with the passed dictionary key value. 
env = env


---@class timer
---@field getTime fun() : number returns the time in the mission (in seconds. 3 decimals)
---@field getAbsTime fun() : number returns the real time in seconds. 0 for midnight, 43200 for noon
---@field getTime0 fun() : number returns the mission start time in seconds
---@field scheduleFunction fun(functionToCall: function, arguments: table|nil, modelTime: number) : number schedule the function to be run at 'modelTime' and returns the functionID
---@field removeFunction fun(functionID:number) removes a scheduled function from the scheduler
---@field setFunctionTime fun(functionID:number, modelTime:number) reschedules an scheduled function
timer = timer

---@class land
---@field getHeight fun(position:Vec2) : number returns the distance from the sea-level to the ground alt at point
---@field getSurfaceHeightWithSeabed fun(position:Vec2) : number, number  returns the surface height and the depth of the seabed respectively. 
---@field getSurfaceType fun(position: Vec2) : SurfaceType returns the surface type at a certain position
---@field isVisible fun(origin: Vec3, target: Vec3)
---@field getIP
---@field profile
---@field getClosestPointOnRoads
---@field findPathOnRoads
land = land

---@enum SurfaceType
land.SurfaceType = {
    LAND = 1,
    SHALLOW_WATER = 2,
    WATER = 3,
    ROAD = 4,
    RUNWAY = 5
}
