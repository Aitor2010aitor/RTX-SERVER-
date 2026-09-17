--[[
    SilentNight - YimMenu Legacy
    Estructura exacta de SoloMissions
]]

local SilentNight<const> = gui.add_tab("SilentNight")

-- ==================== FUNCIONES BASE ====================
local function IsOnline()
    return network.is_session_started() and not script.is_active("maintransition")
end

local function GetMissionScript()
    if script.is_active("fm_mission_controller") then
        return "fm_mission_controller"
    end
    if script.is_active("fm_mission_controller_2020") then
        return "fm_mission_controller_2020"
    end
    return nil
end

local function set_bits(scriptName, index, ...)
    local value = locals.get_int(scriptName, index)
    for _, bit in ipairs({...}) do
        value = value | (1 << bit)
    end
    locals.set_int(scriptName, index, value)
end

-- ==================== INSTANT FINISH (LOGICA SOLOMISSIONS) ====================
local function InstantFinish()
    local mscript = GetMissionScript()
    if not mscript then
        gui.show_message("SilentNight", "No estas en un heist!")
        return
    end
    
    -- Limpiar content IDs (de SoloMissions)
    for i = 0, 5 do
        globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
    end
    
    -- Locals segun el script
    local nextMission, teamScore, serverBitSet
    
    if mscript == "fm_mission_controller" then
        -- Apartment / Casino / Doomsday
        nextMission = 20870      -- 19808 + 1062
        teamScore = 22041        -- 19808 + 1232 + 1
        serverBitSet = 19809     -- 19808 + 1
    else
        -- Cayo Perico 2020
        nextMission = 57659      -- 56070 + 1589
        teamScore = 58377        -- 56070 + 1776 + 1
        serverBitSet = 56071     -- 56070 + 1
    end
    
    locals.set_int(mscript, nextMission, 5)
    locals.set_int(mscript, teamScore, 999999)
    set_bits(mscript, serverBitSet, 9, 16)
    
    gui.show_message("SilentNight", "INSTANT FINISH APLICADO!")
end

local function SkipCheckpoint()
    local mscript = GetMissionScript()
    if not mscript then
        gui.show_message("SilentNight", "No estas en un heist!")
        return
    end
    
    local serverBitSet2 = (mscript == "fm_mission_controller") and 19810 or 56072
    set_bits(mscript, serverBitSet2, 17)
    gui.show_message("SilentNight", "Skip Checkpoint aplicado!")
end

-- ==================== CORTES ====================
local cut_values = {100, 0, 0, 0}

local function ApplyCutsApartment()
    globals.set_int(1935536 + 2, cut_values[1])
    globals.set_int(1935536 + 3, cut_values[2])
    globals.set_int(1935536 + 4, cut_values[3])
    globals.set_int(1935536 + 5, cut_values[4])
    gui.show_message("SilentNight", "Cuts Apartment aplicados!")
end

local function ApplyCutsCayo()
    globals.set_int(1978756 + 888, cut_values[1])
    globals.set_int(1978756 + 889, cut_values[2])
    globals.set_int(1978756 + 890, cut_values[3])
    globals.set_int(1978756 + 891, cut_values[4])
    gui.show_message("SilentNight", "Cuts Cayo aplicados!")
end

local function ApplyCutsCasino()
    globals.set_int(1971952 + 2326, cut_values[1])
    globals.set_int(1971952 + 2327, cut_values[2])
    globals.set_int(1971952 + 2328, cut_values[3])
    globals.set_int(1971952 + 2329, cut_values[4])
    gui.show_message("SilentNight", "Cuts Casino aplicados!")
end

-- ==================== TELEPORTS ====================
local function Teleport(x, y, z)
    local ped = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(ped, x, y, z)
    gui.show_message("SilentNight", "Teletransportado!")
end

-- ==================== BUSINESS ====================
local function BunkerInstantSell()
    if script.is_active("gb_gunrunning") then
        locals.set_int("gb_gunrunning", 1945, 0)
        gui.show_message("SilentNight", "Bunker Instant Sell!")
    else
        gui.show_message("SilentNight", "No estas en venta de Bunker")
    end
end

local function HangarInstantSell()
    if script.is_active("gb_smuggler") then
        local delivered = locals.get_int("gb_smuggler", 1987)
        locals.set_int("gb_smuggler", 1986, delivered)
        gui.show_message("SilentNight", "Hangar Instant Sell!")
    else
        gui.show_message("SilentNight", "No estas en venta de Hangar")
    end
end

-- ==================== SOLO MISSIONS LOOP ====================
local soloEnabled = false

script.register_looped("SILENTNIGHT_SOLO", function()
    if soloEnabled and IsOnline() then
        globals.set_int(4718592 + 3769, 1)
        globals.set_int(4718592 + 3772, 1)
        globals.set_int(4718592 + 3773, 1)
        globals.set_int(4718592 + 3776, 1)
        globals.set_int(4718592 + 190164, 0)
    end
end)

-- ==================== RENDER (ESTRUCTURA SOLOMISSIONS) ====================
SilentNight:add_imgui(function()
    
    if not IsOnline() then
        ImGui.TextColored(1.0, 0.0, 0.0, 1.0, "SOLO DISPONIBLE EN ONLINE")
        return
    end
    
    ImGui.Text("SilentNight Heist Tool")
    ImGui.Separator()
    
    -- Solo Missions
    local clicked = false
    soloEnabled, clicked = ImGui.Checkbox("Enable Solo Missions", soloEnabled)
    
    ImGui.Dummy(1, 10)
    ImGui.SeparatorText("INSTANT FINISH")
    
    -- BOTONES PRINCIPALES (misma fila)
    if ImGui.Button("INSTANT FINISH", 180, 35) then
        InstantFinish()
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("SKIP CHECKPOINT", 180, 35) then
        SkipCheckpoint()
    end
    
    ImGui.Dummy(1, 10)
    ImGui.SeparatorText("CORTES PARA HEISTS")
    
    -- Inputs de cortes
    cut_values[1] = ImGui.InputInt("Player 1 %", cut_values[1])
    cut_values[2] = ImGui.InputInt("Player 2 %", cut_values[2])
    cut_values[3] = ImGui.InputInt("Player 3 %", cut_values[3])
    cut_values[4] = ImGui.InputInt("Player 4 %", cut_values[4])
    
    -- Botones de cortes
    if ImGui.Button("APARTMENT", 120, 30) then
        ApplyCutsApartment()
    end
    ImGui.SameLine()
    if ImGui.Button("CAYO", 120, 30) then
        ApplyCutsCayo()
    end
    ImGui.SameLine()
    if ImGui.Button("CASINO", 120, 30) then
        ApplyCutsCasino()
    end
    
    ImGui.Dummy(1, 10)
    ImGui.SeparatorText("TELEPORTS")
    
    -- Primera fila de teleports
    if ImGui.Button("KOSATKA", 100, 30) then
        Teleport(1561.224, -486.318, -62.226)
    end
    ImGui.SameLine()
    if ImGui.Button("ARCADE", 100, 30) then
        Teleport(2737.962, -374.760, -47.993)
    end
    ImGui.SameLine()
    if ImGui.Button("BUNKER", 100, 30) then
        Teleport(2110.976, 3320.326, 45.361)
    end
    ImGui.SameLine()
    if ImGui.Button("FACILITY", 100, 30) then
        Teleport(489.062, -1303.906, 29.306)
    end
    
    -- Segunda fila
    if ImGui.Button("AGENCY", 100, 30) then
        Teleport(-1011.083, -480.368, 39.073)
    end
    ImGui.SameLine()
    if ImGui.Button("CASINO", 100, 30) then
        Teleport(935.073, 46.635, 81.095)
    end
    ImGui.SameLine()
    if ImGui.Button("MAZEBANK", 100, 30) then
        Teleport(-75.015, -818.215, 326.176)
    end
    ImGui.SameLine()
    if ImGui.Button("HANGAR", 100, 30) then
        Teleport(-1267.071, -3380.069, 14.007)
    end
    
    ImGui.Dummy(1, 10)
    ImGui.SeparatorText("BUSINESS")
    
    if ImGui.Button("BUNKER INSTANT SELL", 180, 35) then
        BunkerInstantSell()
    end
    ImGui.SameLine()
    if ImGui.Button("HANGAR INSTANT SELL", 180, 35) then
        HangarInstantSell()
    end
    
end)

gui.show_message("SilentNight", "Script cargado correctamente!")
