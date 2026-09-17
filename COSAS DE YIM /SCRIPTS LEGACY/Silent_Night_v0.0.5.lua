--[[
    SilentNight Script - YimMenu Legacy Edition
    Instant Finish basado en SoloMissions.lua
]]

-- ==================== CONFIGURACIÓN ====================
local SilentNight = {
    VERSION = "1.11.4",
    TARGET_VERSION = "1.73-3889.0"
}

-- ==================== UTILIDADES ====================
local function notify(message)
    gui.show_message("SilentNight", message)
end

local function sleep(ms)
    script:sleep(ms)
end

-- ==================== ESTRUCTURA DE LOCALS (de SoloMissions) ====================
local scrLocals = {
    ["fm_mission_controller"] = {
        serverBitSet = 19808 + 1,      -- Para instant finish
        serverBitSet2 = 19808 + 2,      -- Para skip checkpoint
        nextMission = 19808 + 1062,     -- Para instant finish
        teamScore = 19808 + 1232 + 1,   -- Para instant finish
    },
    ["fm_mission_controller_2020"] = {
        serverBitSet = 56070 + 1,       -- Para instant finish
        serverBitSet2 = 56070 + 2,      -- Para skip checkpoint
        nextMission = 56070 + 1589,     -- Para instant finish
        teamScore = 56070 + 1776 + 1,   -- Para instant finish
    }
}

-- ==================== GLOBALS ====================
local scrGlobals = {
    nextContentID = 4718592 + 133252,
}

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

-- Función para setear bits (de SoloMissions)
local function set_bits(scriptName, index, ...)
    local value = locals.get_int(scriptName, index)
    for _, bit in ipairs({...}) do
        value = value | (1 << bit)
    end
    locals.set_int(scriptName, index, value)
end

-- ==================== INSTANT FINISH CORREGIDO ====================
local InstantFinish = {}

function InstantFinish.SkipCheckpoint()
    if not IsOnline() then
        notify("No estás en línea")
        return
    end
    
    local mscript = GetMissionScript()
    if not mscript then
        notify("No estás en un heist/misión")
        return
    end
    
    -- Setea el bit 17 en serverBitSet2 para skip checkpoint
    set_bits(mscript, scrLocals[mscript].serverBitSet2, 17)
    notify("[Skip Checkpoint] Checkpoint skipped")
end

function InstantFinish.Finish()
    if not IsOnline() then
        notify("No estás en línea")
        return
    end
    
    local mscript = GetMissionScript()
    if not mscript then
        notify("No estás en un heist/misión")
        return
    end
    
    -- Limpia el nextContentID (6 strings)
    for i = 0, 5 do
        globals.set_string(scrGlobals.nextContentID + 1 + i * 6, "", 0)
    end
    
    -- Setea nextMission a 5 (termina la misión)
    locals.set_int(mscript, scrLocals[mscript].nextMission, 5)
    
    -- Setea teamScore alto
    locals.set_int(mscript, scrLocals[mscript].teamScore, 999999)
    
    -- Setea bits 9 y 16 en serverBitSet
    set_bits(mscript, scrLocals[mscript].serverBitSet, 9, 16)
    
    notify("[Instant Finish] Heist/Misión terminada!")
end

function InstantFinish.ForceFail()
    if not IsOnline() then
        notify("No estás en línea")
        return
    end
    
    local mscript = GetMissionScript()
    if not mscript then
        notify("No estás en un heist/misión")
        return
    end
    
    -- Setea bits 16 y 20 para forzar fail
    set_bits(mscript, scrLocals[mscript].serverBitSet, 16, 20)
    notify("[Force Fail] Misión fallada")
end

-- ==================== SOLO MISSIONS (de SoloMissions.lua) ====================
local SoloMissions = {
    enabled = false
}

function SoloMissions.Enable()
    SoloMissions.enabled = true
    notify("[Solo Missions] Activado - Ahora puedes jugar heists solo")
end

function SoloMissions.Disable()
    SoloMissions.enabled = false
    notify("[Solo Missions] Desactivado")
end

-- Loop para Solo Missions
script.register_looped("SOLO_MISSIONS_LOOP", function()
    if SoloMissions.enabled and IsOnline() then
        -- Para fmmc_launcher
        if script.is_active("fmmc_launcher") then
            local index = locals.get_int("fmmc_launcher", 20194 + 34) -- missionVariation
            if index > 0 then
                locals.set_int("fmmc_launcher", 20194 + 15, 1) -- minPlayers
                globals.set_int(794989 + 4 + 1 + index * 95 + 75, 1) -- MissionHeaderMinPlayers
            end
        end
        
        -- Globals para permitir solo missions
        globals.set_int(4718592 + 3769, 1)   -- minNumParticipants
        globals.set_int(4718592 + 3775 + 1, 1) -- numPlayersPerTeam
        globals.set_int(4718592 + 190163 + 1, 0) -- criticalMinimumForTeam
        globals.set_int(4718592 + 3772, 1)   -- numberOfTeams
        globals.set_int(4718592 + 3773, 1)   -- maxNumberOfTeams
    end
end)

-- ==================== HEIST SPECIFIC FUNCTIONS ====================
local HeistTool = {}

function HeistTool.ForceReadyAll()
    -- Apartment Ready (globals)
    for i = 0, 3 do
        globals.set_int(2658291 + 1 + (i * 468) + 270, 6)
    end
    notify("[Force Ready] Todos listos (Apartment)")
end

function HeistTool.SetCutsApartment(p1, p2, p3, p4)
    globals.set_int(1935536 + 1 + 1, p1)
    globals.set_int(1935536 + 1 + 2, p2)
    globals.set_int(1935536 + 1 + 3, p3)
    globals.set_int(1935536 + 1 + 4, p4)
    notify(string.format("[Cuts] Apartment: P1:%d%% P2:%d%% P3:%d%% P4:%d%%", p1, p2, p3, p4))
end

function HeistTool.SetCutsCayo(p1, p2, p3, p4)
    globals.set_int(1978756 + 831 + 56 + 1, p1)
    globals.set_int(1978756 + 831 + 56 + 2, p2)
    globals.set_int(1978756 + 831 + 56 + 3, p3)
    globals.set_int(1978756 + 831 + 56 + 4, p4)
    notify(string.format("[Cuts] Cayo: P1:%d%% P2:%d%% P3:%d%% P4:%d%%", p1, p2, p3, p4))
end

function HeistTool.SetCutsCasino(p1, p2, p3, p4)
    globals.set_int(1971952 + 1497 + 736 + 92 + 1, p1)
    globals.set_int(1971952 + 1497 + 736 + 92 + 2, p2)
    globals.set_int(1971952 + 1497 + 736 + 92 + 3, p3)
    globals.set_int(1971952 + 1497 + 736 + 92 + 4, p4)
    notify(string.format("[Cuts] Casino: P1:%d%% P2:%d%% P3:%d%% P4:%d%%", p1, p2, p3, p4))
end

-- ==================== BUSINESS TOOL ====================
local BusinessTool = {}

function BusinessTool.BunkerInstantSell()
    if script.is_active("gb_gunrunning") then
        locals.set_int("gb_gunrunning", 1945, 0)
        notify("[Bunker] Instant Sell aplicado")
    else
        notify("No estás en venta de Bunker")
    end
end

function BusinessTool.BunkerMaximizePrice()
    tunables.set_int("GR_SALE_VALUE_MULTIPLIER", 2500000)
    notify("[Bunker] Precio maximizado")
end

function BusinessTool.HangarInstantSell()
    if script.is_active("gb_smuggler") then
        local delivered = locals.get_int("gb_smuggler", 1987)
        locals.set_int("gb_smuggler", 1986, delivered)
        notify("[Hangar] Instant Sell aplicado")
    else
        notify("No estás en venta de Hangar")
    end
end

function BusinessTool.NightclubCollectSafe()
    globals.set_int(2708832, 1)
    notify("[Nightclub] Safe recolectado")
end

-- ==================== TELEPORTS ====================
local Teleports = {
    Facility = {x = 489.062, y = -1303.906, z = 29.306},
    Bunker = {x = 2110.976, y = 3320.326, z = 45.361},
    Hangar = {x = -1267.071, y = -3380.069, z = 14.007},
    Nightclub = {x = -1569.532, y = -3016.619, z = -74.406},
    Arcade = {x = 2737.962, y = -374.760, z = -47.993},
    Kosatka = {x = 1561.224, y = -486.318, z = -62.226},
    Agency = {x = -1011.083, y = -480.368, z = 39.073},
    Casino = {x = 935.073, y = 46.635, z = 81.095},
    MazeBank = {x = -75.015, y = -818.215, z = 326.176},
}

local function teleport_to(coords)
    local player_ped = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(player_ped, coords.x, coords.y, coords.z)
    notify("Teletransportado")
end

-- ==================== GUI ====================
local cut_values = {100, 100, 100, 100}

local function render_main_tab()
    if ImGui.BeginTabItem("Main") then
        
        -- Solo Missions Toggle
        local solo_changed = false
        SoloMissions.enabled, solo_changed = ImGui.Checkbox("Enable Solo Missions", SoloMissions.enabled)
        if solo_changed then
            if SoloMissions.enabled then
                SoloMissions.Enable()
            else
                SoloMissions.Disable()
            end
        end
        
        ImGui.Separator()
        ImGui.Text("--- Instant Finish (Método SoloMissions) ---")
        
        if ImGui.Button("Skip Checkpoint") then
            InstantFinish.SkipCheckpoint()
        end
        ImGui.SameLine()
        
        if ImGui.Button("INSTANT FINISH") then
            InstantFinish.Finish()
        end
        ImGui.SameLine()
        
        if ImGui.Button("Force Fail") then
            InstantFinish.ForceFail()
        end
        
        ImGui.Separator()
        ImGui.Text("--- Cuts ---")
        
        cut_values[1] = ImGui.InputInt("Player 1 %", cut_values[1])
        cut_values[2] = ImGui.InputInt("Player 2 %", cut_values[2])
        cut_values[3] = ImGui.InputInt("Player 3 %", cut_values[3])
        cut_values[4] = ImGui.InputInt("Player 4 %", cut_values[4])
        
        if ImGui.Button("Apply Apartment Cuts") then
            HeistTool.SetCutsApartment(cut_values[1], cut_values[2], cut_values[3], cut_values[4])
        end
        ImGui.SameLine()
        if ImGui.Button("Apply Cayo Cuts") then
            HeistTool.SetCutsCayo(cut_values[1], cut_values[2], cut_values[3], cut_values[4])
        end
        ImGui.SameLine()
        if ImGui.Button("Apply Casino Cuts") then
            HeistTool.SetCutsCasino(cut_values[1], cut_values[2], cut_values[3], cut_values[4])
        end
        
        ImGui.EndTabItem()
    end
end

local function render_business_tab()
    if ImGui.BeginTabItem("Business") then
        
        ImGui.Text("--- Bunker ---")
        if ImGui.Button("Instant Sell") then
            BusinessTool.BunkerInstantSell()
        end
        ImGui.SameLine()
        if ImGui.Button("Max Price") then
            BusinessTool.BunkerMaximizePrice()
        end
        
        ImGui.Separator()
        ImGui.Text("--- Hangar ---")
        if ImGui.Button("Hangar Instant Sell") then
            BusinessTool.HangarInstantSell()
        end
        
        ImGui.Separator()
        ImGui.Text("--- Nightclub ---")
        if ImGui.Button("Collect Safe") then
            BusinessTool.NightclubCollectSafe()
        end
        
        ImGui.EndTabItem()
    end
end

local function render_teleport_tab()
    if ImGui.BeginTabItem("Teleports") then
        
        if ImGui.Button("Facility") then
            teleport_to(Teleports.Facility)
        end
        ImGui.SameLine()
        if ImGui.Button("Bunker") then
            teleport_to(Teleports.Bunker)
        end
        ImGui.SameLine()
        if ImGui.Button("Hangar") then
            teleport_to(Teleports.Hangar)
        end
        
        if ImGui.Button("Nightclub") then
            teleport_to(Teleports.Nightclub)
        end
        ImGui.SameLine()
        if ImGui.Button("Arcade") then
            teleport_to(Teleports.Arcade)
        end
        ImGui.SameLine()
        if ImGui.Button("Kosatka") then
            teleport_to(Teleports.Kosatka)
        end
        
        if ImGui.Button("Agency") then
            teleport_to(Teleports.Agency)
        end
        ImGui.SameLine()
        if ImGui.Button("Casino") then
            teleport_to(Teleports.Casino)
        end
        ImGui.SameLine()
        if ImGui.Button("Maze Bank") then
            teleport_to(Teleports.MazeBank)
        end
        
        ImGui.EndTabItem()
    end
end

-- ==================== RENDER PRINCIPAL ====================
local function render_menu()
    if not IsOnline() then
        ImGui.Text("Unavailable in Single Player")
        return
    end
    
    ImGui.Text("Game Version: " .. SilentNight.TARGET_VERSION)
    ImGui.Dummy(1, 10)
    
    if ImGui.BeginTabBar("SilentNightTabs") then
        render_main_tab()
        render_business_tab()
        render_teleport_tab()
        ImGui.EndTabBar()
    end
end

-- ==================== REGISTRO ====================
gui.add_tab("SilentNight", render_menu)
notify("SilentNight v" .. SilentNight.VERSION .. " loaded!")
