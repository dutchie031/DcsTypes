
--[[

    This file is intended to be used as reference and easy intellisense during lua development in DCS.
    By adding this file into your LUA directory the classes and functions should be recognised by any intellisense tool that supports lua annotations.
    https://luals.github.io/wiki/annotations

    Authored by: Dutchie

]]

Docs = {}

---@class Vec2 
---@field x number
---@field y  number

---@class Vec3 
---@field x number
---@field y number
---@field z number

---@class Array<T>: { [integer]: T }

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
---@field getSurfaceHeightWithSeabed fun(position:Vec2) : sufaceHeight: number, depth: number  returns the surface height and the depth of the seabed respectively. 
---@field getSurfaceType fun(position: Vec2) : SurfaceType returns the surface type at a certain position
---@field isVisible fun(origin: Vec3, target: Vec3) returns whether or not there's line between the two points that's not interrupted by terrain.
---@field getIP fun(origin:Vec3, direction:number, distance:number) TODO: Describe
---@field profile fun(start:Vec3, end:Vec3) : Array<Vec3> Returns a list of terrain points between two points. Amount is not directly known.
---@field getClosestPointOnRoads fun(roadType: RoadType, x : number, y : number) : x: number, y: number return x and y coordinate of the closest point on a road type.
---@field findPathOnRoads fun(roadType: RoadType, startX: number, startY: number, endX: number, endY: number) : Array<Vec2> Returns a list of Vec2 points of a road. Can be quite long!
land = land

---@enum SurfaceType
Docs.land.SurfaceType = {
    LAND = 1,
    SHALLOW_WATER = 2,
    WATER = 3,
    ROAD = 4,
    RUNWAY = 5
}

---@alias RoadType
---| "roads"
---| "railroads"


---@class atmosphere
---@field getWind fun(point:Vec3): Vec3 returns a velocity vector for the wind at a point
---@field getWindWithTurbulence fun(point:Vec3): Vec3 return a velocity vector for the wind including turbulent air 
---@field getTemperatureAndPressure fun(point:Vec3) : temp: number, pressure: number returns temperature and pressure. Kelvins and Pascals.
atmosphere = atmosphere

---@class Event
---@field id EventType
---@field time number

---@class EventHandler
---@field onEvent fun(event: Event)

---@class world
---@field addEventHandler fun(handler: EventHandler) Adds an event handler that will be called on DCS events.
---@field removeEventHandler fun(handler: EventHandler) Removes an event handler from the "to call table"
---@field getPlayer fun() : Unit returns the unit object that is specified as "Player" in the mission editor
---@field getAirbases  fun(side: CoalitionSide?) : Array<Airbase> returns airbases (ships, bases, farps) of a side, or all if side is not passed
---@field searchObjects fun(category: ObjectCategory, searchVolume: Volume, handler: fun(item:Object, value : any?), value: any?) : table searches a volume or space for objects of a specific type and can call the handler function on each found object
---@field getMarkPanels fun() : table TODO: describe
---@field removeJunk fun(searchVolume: Volume) : number searches a volume for any wrecks, craters or debris and removes it
---@field getFogThickness fun() : number returns the global fog thickness. 0 if no fog is present
---@field setFogThickness fun(thickness: number) sets the fog thickness. 100 to 5000. 0 to remove fog
---@field getFogVisibilityDistance fun() : number returns the visibility distance in mist
---@field setFogVisibilityDistance fun(visibility:number) sets the visibility distance. 100 to 100000. If 0 the fog will be removed.
---@field setFogAnimation
---@field weather
world= world


do -- Event Types
    ---@enum EventType
    world.event = {
        S_EVENT_INVALID = 0,
        S_EVENT_SHOT = 1,
        S_EVENT_HIT = 2,
        S_EVENT_TAKEOFF = 3,
        S_EVENT_LAND = 4,
        S_EVENT_CRASH = 5,
        S_EVENT_EJECTION = 6,
        S_EVENT_REFUELING = 7,
        S_EVENT_DEAD = 8,
        S_EVENT_PILOT_DEAD = 9,
        S_EVENT_BASE_CAPTURED = 10,
        S_EVENT_MISSION_START = 11,
        S_EVENT_MISSION_END = 12,
        S_EVENT_TOOK_CONTROL = 13,
        S_EVENT_REFUELING_STOP = 14,
        S_EVENT_BIRTH = 15,
        S_EVENT_HUMAN_FAILURE = 16,
        S_EVENT_DETAILED_FAILURE = 17,
        S_EVENT_ENGINE_STARTUP = 18,
        S_EVENT_ENGINE_SHUTDOWN = 19,
        S_EVENT_PLAYER_ENTER_UNIT = 20,
        S_EVENT_PLAYER_LEAVE_UNIT = 21,
        S_EVENT_PLAYER_COMMENT = 22,
        S_EVENT_SHOOTING_START = 23,
        S_EVENT_SHOOTING_END = 24,
        S_EVENT_MARK_ADDED  = 25, 
        S_EVENT_MARK_CHANGE = 26,
        S_EVENT_MARK_REMOVED = 27,
        S_EVENT_KILL = 28,
        S_EVENT_SCORE = 29,
        S_EVENT_UNIT_LOST = 30,
        S_EVENT_LANDING_AFTER_EJECTION = 31,
        S_EVENT_PARATROOPER_LENDING = 32,
        S_EVENT_DISCARD_CHAIR_AFTER_EJECTION = 33, 
        S_EVENT_WEAPON_ADD = 34,
        S_EVENT_TRIGGER_ZONE = 35,
        S_EVENT_LANDING_QUALITY_MARK = 36,
        S_EVENT_BDA = 37, 
        S_EVENT_AI_ABORT_MISSION = 38, 
        S_EVENT_DAYNIGHT = 39, 
        S_EVENT_FLIGHT_TIME = 40, 
        S_EVENT_PLAYER_SELF_KILL_PILOT = 41, 
        S_EVENT_PLAYER_CAPTURE_AIRFIELD = 42, 
        S_EVENT_EMERGENCY_LANDING = 43,
        S_EVENT_UNIT_CREATE_TASK = 44,
        S_EVENT_UNIT_DELETE_TASK = 45,
        S_EVENT_SIMULATION_START = 46,
        S_EVENT_WEAPON_REARM = 47,
        S_EVENT_WEAPON_DROP = 48,
        S_EVENT_UNIT_TASK_COMPLETE = 49,
        S_EVENT_UNIT_TASK_STAGE = 50,
        S_EVENT_MAC_EXTRA_SCORE= 51, 
        S_EVENT_MISSION_RESTART= 52,
        S_EVENT_MISSION_WINNER = 53,
        S_EVENT_RUNWAY_TAKEOFF= 54, 
        S_EVENT_RUNWAY_TOUCH= 55, 
        S_EVENT_MAC_LMS_RESTART= 56,
        S_EVENT_SIMULATION_FREEZE = 57, 
        S_EVENT_SIMULATION_UNFREEZE = 58, 
        S_EVENT_HUMAN_AIRCRAFT_REPAIR_START = 59, 
        S_EVENT_HUMAN_AIRCRAFT_REPAIR_FINISH = 60,   
        S_EVENT_MAX = 61,
  }
end

---@enum BirthPlace
world.BirthPlace = {
    wsBirthPlace_Air = 1,
    wsBirthPlace_RunWay = 2,
    wsBirthPlace_Park = 3,
    wsBirthPlace_Heliport_Hot = 4,
    wsBirthPlace_Heliport_Cold = 5,
}

do --Volumes
    ---@class Volume
    ---@field id VolumeType

    ---@class Segment
    ---@field params SegmentParams

    ---@class SegmentParams
    ---@field from Vec3
    ---@field to Vec3

    ---@class Box : Volume
    ---@field params BoxParams

    ---@class BoxParams 
    ---@field min Vec3
    ---@field max Vec3
    
    ---@class Sphere
    ---@field params SphereParams

    ---@class SphereParams
    ---@field point Vec3
    ---@field radius number

    ---@class VolumePyramid
    ---@field params VolumePyramidParams

    ---@class VolumePyramidParams
    ---@field pos Vec3
    ---@field length number
    ---@field halfAngleHor number
    ---@field halfAngleVer number

end

---@enum VolumeType
world.VolumeType = {
    SEGMENT = 1,
    BOX = 2,
    SPHERE = 3,
    PYRAMID = 4
}


---@class coalition
coalition = coalition

---@enum CoalitionSide
coalition.side = {
    NEUTRAL = 0,
    RED = 1,
    BLUE = 2,
}

---@class Unit : Object

---@class Object
---@field getName fun(self) : string

---@enum ObjectCategory
Object.Category = {
    UNIT = 1,
    WEAPON = 2,
    STATIC = 3,
    BASE = 4,
    SCENERY = 5,
    Cargo = 6
}


---@class CoalitionObject

---@class Airbase : Object, CoalitionObject