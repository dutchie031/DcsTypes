
--[[

    This file is intended to be used as reference and easy intellisense during lua development in DCS.
    By adding this file into your LUA directory the classes and functions should be recognised by any intellisense tool that supports lua annotations.
    https://luals.github.io/wiki/annotations

    Authored by: Dutchie

]]

---Vec2 is a 2D-vector for the ground plane as a reference plane. 
---@class Vec2 
---@field x number
---@field y  number

---Vec3 type is a 3D-vector. It is a table that has following format
---@class Vec3 
---@field x number directed to the north 
---@field y number directed to the east 
---@field z number directed up (away from ground)

---@class Array<T>: { [integer]: T } 


do -- env
    ---@class env
    ---@field info fun(log:string, showMessageBox:boolean?) Prints passed log line with prefix 'info'
    ---@field warning fun(log:string, showMessageBox:boolean?) Prints passed log line with prefix 'warning'
    ---@field error fun(log:string, showMessageBox:boolean?) Prints passed log line with prefix 'error'
    ---@field setErrorMessageBoxEnabled fun(toggle:boolean?) Enables or disables the lua error box to show up on a lua error
    ---@field getValueDictByKey fun(value:string) : string Returns a string associated with the passed dictionary key value. 
    env = env
end

do -- timer
    ---@class timer
    ---@field getTime fun() : number returns the time in the mission (in seconds. 3 decimals)
    ---@field getAbsTime fun() : number returns the real time in seconds. 0 for midnight, 43200 for noon
    ---@field getTime0 fun() : number returns the mission start time in seconds
    ---@field scheduleFunction fun(functionToCall: function, arguments: table|nil, modelTime: number) : number schedule the function to be run at 'modelTime' and returns the functionID
    ---@field removeFunction fun(functionID:number) removes a scheduled function from the scheduler
    ---@field setFunctionTime fun(functionID:number, modelTime:number) reschedules an scheduled function
    timer = timer
end


do -- land
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
    land.SurfaceType = {
        LAND = 1,
        SHALLOW_WATER = 2,
        WATER = 3,
        ROAD = 4,
        RUNWAY = 5
    }

    ---@alias RoadType
    ---| "roads"
    ---| "railroads"
end

do -- atmosphere

    ---@class atmosphere
    ---@field getWind fun(point:Vec3): Vec3 returns a velocity vector for the wind at a point
    ---@field getWindWithTurbulence fun(point:Vec3): Vec3 return a velocity vector for the wind including turbulent air 
    ---@field getTemperatureAndPressure fun(point:Vec3) : temp: number, pressure: number returns temperature and pressure. Kelvins and Pascals.
    atmosphere = atmosphere

end

do -- world
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
    ---@field setFogAnimation fun(dataTable: Array<Array<number>>) {relative time (seconds), visibility (meters), thickness (meters)}  eg. {5, 1000, 500},
    ---@field weather table TODO: describe weather
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


end

do -- coalition

    ---@class coalition
    ---@field addGroup fun(countryID: CountryID, groupCategory: GroupCategory, groupData: MissionGroupTable) : Group Spawn a group. If the name of the group or unit is already present the unit will be replaced. 
    ---@field addStaticObject fun(countryID: CountryID, data: MissionStaticObjectTable) : StaticObject Dynamically adds a static object to the mission. Name needs to be unique. UnitID and groupID can be ommitted and will be created automatically
    ---@field getGroups fun(coalitionID : CoalitionSide, category: GroupCategory?) : Array<Group> returns group objects of a specific category (or all if no category is specified) 
    ---@field getStaticObjects fun(coalitionID: CoalitionSide) : Array<StaticObject> returns static objects in a coalition
    ---@field getAirbases fun(coalitionID: CoalitionSide) : Array<Airbase> returns airbases belonging to a coalition
    ---@field getPlayers fun(coalitionID: CoalitionSide) : Array<Unit> returns units currently occupied by players
    ---@field getServiceProviders fun(coalitionID: CoalitionSide, serviceType: CoalitionService) : Array<Unit> Returns all units that provide a specific service. (AWACS, Tankers etc.)
    ---@field addRefPoint fun(coalitionID: CoalitionSide, refPoint: RefPoint) adds a new reference point to the coalition
    ---@field getRefPoints fun(coalitionID: CoalitionSide) : table TODO: Ref point return table
    ---@field getMainRefPoint fun(coalitionID: CoalitionSide) : Vec3 returns bullseye location for coalition
    ---@field getCountryCoalition fun(countryID: CountryID) : CoalitionSide returns coalitionID for a specific countryID 
    coalition = coalition


    --[[
        TODO: Check ref points
    ]]

    ---@class RefPoint
    ---@field callsign number
    ---@field type number
    ---@field point Vec3


    do -- group tables
        --[[
            TODO: Group Tables
        ]]


        ---@class MissionGroupTable
    end

    do -- static object tables
        
        ---@class MissionStaticObjectTable
        ---@field heading number
        ---@field groupId integer
        ---@field shape_name string
        ---@field type string
        ---@field unitId integer
        ---@field rate integer
        ---@field name string
        ---@field category string
        ---@field x number
        ---@field y number
        ---@field dead boolean

    end

    ---@enum CoalitionSide
    coalition.side = {
        NEUTRAL = 0,
        RED = 1,
        BLUE = 2,
    }

    ---@enum CoalitionService
    coalition.service = {
        ATC = 0,
        AWACS = 1,
        TANKER = 2,
        FAC = 3
    }

end

do -- trigger

    ---@class Trigger
    ---@field action TriggerActions
    ---@field misc TriggerMisc
    trigger = trigger

    ---@class TriggerMisc
    ---@field getUserFlag fun(flagName: string) : number returns the value of a user flag.
    ---@field getZone fun(zoneName: string) : Array<TriggerZone> returns triggerzones. Only works for cilinders really. For more detailed zone data see: env.mission.triggers.zones
    trigger.misc = trigger.misc

    ---@class TriggerActions : OutText, OutSound, OtherCommands, MarkCommands
    ---@field ctfColorTag fun(unitName: string, smokeColor: SmokePlumeColor, minAlt: number?) Created a smoke plume behind a specified aircraft
    ---@field setUserFlag fun(flagName: string, userFlagValue: boolean|number) Sets a user flag to a specified value
    ---@field explosion fun(point: Vec3, power: number) Creates an explosion at a given point at the specified power. 
    ---@field smoke fun(point: Vec3, color: SmokeColor) Creates colored smoke marker at a given point
    ---@field effectSmokeBig fun(point: Vec3, effect: SmokeEffect, density: number, name: string?) Creates a large smoke effect on a vec3 point of a specified type and density. 
    ---@field effectSmokeStop fun(name: string) Stop a smoke effect effect of the passsed name
    ---@field illuminationBomb fun(point: Vec3, power: number) Creates an ilumination bomb that will burn for 300 seconds
    ---@field signalFlare fun(point: Vec3, flareColor: FlareColor, azimuth: number) Creates a signal flare at the given point in the specified color. The flare will be launched in the direction of the azimuth variable. 
    ---@field radioTransmission fun(fileName: string, point:Vec3, modulation: Modulation, loop: boolean, frequency: number, power: number, name: string?) Transmits an audio file to be broadcast over a specific frequency eneminating from the specified point. 
    ---@field stopRadioTransmission fun(name: string) Stops a radio transmission of the passed name
    ---@field setUnitInternalCargo fun(unitName: string, mass: number) Sets the internal cargo for the specified unit at the specified mass
    trigger.action = trigger.action

    ---@class OutSound
    ---@field outSound fun(fileName: string) Plays a sound file to all players.
    ---@field outSoundForCoalition fun(coalitionSide: CoalitionSide, soundFile: string) Plays a sound file to all players on the specified coalition. 
    ---@field outSoundForCountry fun(country: CountryID, soundfile: string) Plays a sound file to all players on the specified country.
    ---@field outSoundForGroup fun(groupId: integer, soundFile: string) Plays a sound file to all players in the specified group.
    ---@field outSoundForUnit fun(unitId: integer, soundFile: string) Plays a sound file to all players in the specified unit.

    ---@class OutText
    ---@field outText fun(text: string, displayTime: number, clearview: boolean?) Displays the passed string of text for the specified time to all players.
    ---@field outTextForCoalition fun(coalitionId: CoalitionSide, text: string, displayTime: number, clearview: boolean?) Displays the passed string of text for the specified time to all players belonging to the specified coalition.
    ---@field outTextForCountry fun(country: CountryID, text: string, displayTime: number, clearview: boolean?) Displays the passed string of text for the specified time to all players belonging to the specified country.
    ---@field outTextForGroup fun(groupId: integer, text: string, displayTime: number, clearView: boolean?) Displays the passed string of text for the specified time to all players in the specified group.
    ---@field outTextForUnit fun(unitId: integer, text: string, displayTime: number, clearView: boolean?) Displays the passed string of text for the specified time to all players in the specified unit.

    ---@class OtherCommands
    ---@field addOtherCommand fun(name: string, userFlagName: string, userFlagValue: string) Adds a command to the "F10 Other" radio menu allowing players to call commands and set flags within the mission.
    ---@field removeOtherCommand fun(name: string) Removes the command that matches the specified name input variable from the "F10 Other" radio menu. 
    ---@field addOtherCommandForCoalition fun(coalitionId: CoalitionSide, name: string, userFlagName: string, userFlagValue: number) Adds a command to the "F10 Other" radio menu allowing players to call commands and set flags within the mission.
    ---@field removeOtherCommandForCoalition fun(coalitionId: CoalitionSide, name: string) Removes the command that matches the specified name input variable from the "F10 Other" radio menu if the command was added for coalition.
    ---@field addOtherCommandForGroup  fun(groupId: integer, name: string, userFlagName: string, userFlagValue: number) Adds a command to the "F10 Other" radio menu allowing players to call commands and set flags within the mission.
    ---@field removeOtherCommandForGroup fun(groupId: integer, name: string) Removes the command that matches the specified name input variable from the "F10 Other" radio menu if the command exists for the specified group. 

    ---@class MarkCommands 
    ---@field markToAll fun(id: integer, text:string, point:Vec3, readOnly: boolean?, message: string?) Adds a mark point to all on the F10 map with attached text. 
    ---@field markToCoalition fun(id: integer, text: string, point: Vec3, coalitionID: CoalitionSide, readOnly: boolean?, message: string) Adds a mark point to a coalition on the F10 map with attached text. 
    ---@field markToGroup fun(id: integer, text: string, point: Vec3, groupID: integer, readOnly: boolean?, message: string) Adds a mark point to a group on the F10 map with attached text. 
    ---@field removeMark fun(id: integer) Removes a mark panel from the f10 map 
    ---@field markupToAll fun(shapeID: ShapeId, coalition: DrawCoalition, id: integer, ... : Vec3, lineColor: table, fillColor: table, lineType: )
    ---@field lineToAll
    ---@field circleToAll
    ---@field rectToAll
    ---@field quadToAll
    ---@field textToAll
    ---@field arrowToAll
    ---@field setMarkupRadius
    ---@field setMarkupText
    ---@field setMarkupFontSize
    ---@field setMarkupColor
    ---@field setMarkupColorFill
    ---@field setMarkupTypeLine
    ---@field setMarkupPositionEnd
    ---@field setMarkupPositionStart 

    trigger.action.markupToAll()

    ---@enum SmokeColor
    trigger.smokeColor = {
        Green = 0,
        Red = 1, 
        White = 2,
        Orange = 3,
        Blue = 4
    }

    ---@enum FlareColor 
    trigger.flareColor = {
        Green = 0,
        Red = 1,
        White = 2,
        Yellow = 3
    }

    ---@alias SmokePlumeColor
    ---| 0 Disabled
    ---| 1 Green 
    ---| 2 Red
    ---| 3 White
    ---| 4 Orange
    ---| 5 Blue

    ---@alias SmokeEffect
    ---| 1 small smoke and fire
    ---| 2 medium smoke and fire
    ---| 3 large smoke and fire
    ---| 4 huge smoke and fire
    ---| 5 small smoke
    ---| 6 medium smoke 
    ---| 7 large smoke
    ---| 8 huge smoke

    ---@alias Modulation
    ---| 0 AM
    ---| 1 FM

    ---@alias ShapeId
    ---| 1 Line
    ---| 2 Circle
    ---| 3 Rect
    ---| 4 Arrow
    ---| 5 Text
    ---| 6 Quad
    ---| 7 Freeform

    ---@alias LineType
    ---| 0  No Line
    ---| 1  Solid
    ---| 2  Dashed
    ---| 3  Dotted
    ---| 4  Dot Dash
    ---| 5  Long Dash
    ---| 6  Two Dash

    ---@alias DrawCoalition
    ---| -1 All
    ---| 0 Neutral
    ---| 1 Red
    ---| 2 Blue

    ---@class TriggerZone
    ---@field point Vec3
    ---@field radius number

end

---@class Object
---@field getName fun(self) : string
Object = Object

---@class CoalitionObject

---@class StaticObject : Object

---@class Unit : Object



---@enum ObjectCategory
Object.Category = {
    UNIT = 1,
    WEAPON = 2,
    STATIC = 3,
    BASE = 4,
    SCENERY = 5,
    Cargo = 6
}


country = country
---@enum CountryID
country.id = {
    RUSSIA = 1,
    UKRAINE = 2,
    USA = 3,
    TURKEY = 4,
    UK = 5,
    FRANCE = 6,
    GERMANY = 7,
    CANADA = 8,
    SPAIN = 9,
    THE_NETHERLANDS = 10,
    BELGIUM = 11,
    NORWAY = 12,
    DENMARK = 13,
    ISRAEL = 14,
    GEORGIA = 15,
    INSURGENTS = 16,
    ABKHAZIA = 17,
    SOUTH_OSETIA = 18,
    ITALY = 19
  }




---@class Airbase : Object, CoalitionObject


---@class Group
Group = Group

---@enum GroupCategory
Group.Category = {
    AIRPLANE      = 0,
    HELICOPTER    = 1,
    GROUND        = 2,
    SHIP          = 3,
    TRAIN         = 4,
}

