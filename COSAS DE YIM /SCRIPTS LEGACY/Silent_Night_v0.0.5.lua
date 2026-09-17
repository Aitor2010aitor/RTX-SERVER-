--[[
    SilentNight - YimMenu Legacy
    Versión con botones garantizados
]]

local solo_enabled = false

-- Función para verificar online
local function IsOnline()
    return network.is_session_started() and not script.is_active("maintransition")
end

-- Función para obtener el script de misión activo
local function GetMissionScript()
    if script.is_active("fm_mission_controller") then
        return "fm_mission_controller"
    end
    if script.is_active("fm_mission_controller_2020") then
        return "fm_mission_controller_2020"
    end
    return nil
end

-- Set bits
local function set_bits(scriptName, index, ...)
    local value = locals.get_int(scriptName, index)
    for _, bit in ipairs({...}) do
        value = value | (1 << bit)
    end
    locals.set_int(scriptName, index, value)
end

-- ==================== INSTANT FINISH (MÉTODO SOLOMISSIONS) ====================
local function InstantFinish()
    local mscript = GetMissionScript()
    if not mscript then
        gui.show_message("SilentNight", "No estás en un heist!")
        return
    end
    
    -- Limpiar content IDs
    for i = 0, 5 do
        globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
    end
    
    -- Locals correctos según el script
    local nextMission, teamScore, serverBitSet
    
    if mscript == "fm_mission_controller" then
        -- Apartment / Casino / Doomsday
        nextMission = 20870
        teamScore = 22041
        serverBitSet = 19809
    else
        -- Cayo Perico (fm_mission_controller_2020)
        nextMission = 57659
        teamScore = 58377
        serverBitSet = 56071
    end
    
    locals.set_int(mscript, nextMission, 5)
    locals.set_int(mscript, teamScore, 999999)
    set_bits(mscript, serverBitSet, 9, 16)
    
    gui.show_message("SilentNight", "INSTANT FINISH APLICADO!")
end

local function SkipCheckpoint()
    local mscript = GetMissionScript()
    if not mscript then
        gui.show_message("SilentNight", "No estás en un heist!")
        return
    end
    
    local serverBitSet2 = (mscript == "fm_mission_controller") and 19810 or 56072
    set_bits(mscript, serverBitSet2, 17)
    gui.show_message("SilentNight", "Skip Checkpoint aplicado!")
end

-- ==================== CORTES ====================
local cut_p1, cut_p2, cut_p3, cut_p4 = 100, 0, 0, 0

local function ApplyCutsApartment()
    globals.set_int(1935536 + 2, cut_p1)
    globals.set_int(1935536 + 3, cut_p2)
    globals.set_int(1935536 + 4, cut_p3)
    globals.set_int(1935536 + 5, cut_p4)
    gui.show_message("SilentNight", "Cuts Apartment: " .. cut_p1 .. "% / " .. cut_p2 .. "% / " .. cut_p3 .. "% / " .. cut_p4 .. "%")
end

local function ApplyCutsCayo()
    globals.set_int(1978756 + 888, cut_p1)
    globals.set_int(1978756 + 889, cut_p2)
    globals.set_int(1978756 + 890, cut_p3)
    globals.set_int(1978756 + 891, cut_p4)
    gui.show_message("SilentNight", "Cuts Cayo: " .. cut_p1 .. "% / " .. cut_p2 .. "% / " .. cut_p3 .. "% / " .. cut_p4 .. "%")
end

local function ApplyCutsCasino()
    globals.set_int(1971952 + 2326, cut_p1)
    globals.set_int(1971952 + 2327, cut_p2)
    globals.set_int(1971952 + 2328, cut_p3)
    globals.set_int(1971952 + 2329, cut_p4)
    gui.show_message("SilentNight", "Cuts Casino: " .. cut_p1 .. "% / " .. cut_p2 .. "% / " .. cut_p3 .. "% / " .. cut_p4 .. "%")
end

-- ==================== TELEPORTS ====================
local function Teleport(x, y, z)
    local ped = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(ped, x, y, z)
    gui.show_message("SilentNight", "Teletransportado!")
end

-- ==================== LOOP PARA SOLO MISSIONS ====================
script.register_looped("SOLO_MISSIONS", function()
    if solo_enabled and IsOnline() then
        globals.set_int(4718592 + 3769, 1)   -- minNumParticipants
        globals.set_int(4718592 + 3772, 1)   -- numberOfTeams
        globals.set_int(4718592 + 3773, 1)   -- maxNumberOfTeams
        globals.set_int(4718592 + 3776, 1)   -- numPlayersPerTeam
        globals.set_int(4718592 + 190164, 0) -- criticalMinimumForTeam
    end
end)

-- ==================== MENÚ - ESTA ES LA PARTE IMPORTANTE ====================
gui.add_tab("SilentNight", function()
    
    -- Título
    ImGui.Text("SilentNight - Heist Tool")
    ImGui.Separator()
    
    -- Solo Missions Toggle
    local changed = false
    solo_enabled, changed = ImGui.Checkbox("Enable Solo Missions", solo_enabled)
    if changed then
        gui.show_message("SilentNight", solo_enabled and "Solo Missions ACTIVADO" or "Solo Missions DESACTIVADO")
    end
    
    ImGui.Dummy(0, 10)
    ImGui.Separator()
    ImGui.TextColored(0.0, 1.0, 1.0, 1.0, "INSTANT FINISH")
    ImGui.Separator()
    
    -- BOTONES PRINCIPALES - Estos deben aparecer sí o sí
    if ImGui.Button("INSTANT FINISH", 200, 40) then
        InstantFinish()
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("SKIP CHECKPOINT", 200, 40) then
        SkipCheckpoint()
    end
    
    ImGui.Dummy(0, 10)
    ImGui.Separator()
    ImGui.TextColored(1.0, 1.0, 0.0, 1.0, "CORTES PARA HEISTS")
    ImGui.Separator()
    
    -- Inputs de cortes
    cut_p1 = ImGui.InputInt("Player 1 %", cut_p1)
    cut_p2 = ImGui.InputInt("Player 2 %", cut_p2)
    cut_p3 = ImGui.InputInt("Player 3 %", cut_p3)
    cut_p4 = ImGui.InputInt("Player 4 %", cut_p4)
    
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
    
    ImGui.Dummy(0, 10)
    ImGui.Separator()
    ImGui.TextColored(0.0, 1.0, 0.0, 1.0, "TELEPORTS")
    ImGui.Separator()
    
    -- Teleports
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
    
    ImGui.Dummy(0, 10)
    ImGui.Separator()
    ImGui.TextColored(1.0, 0.5, 0.0, 1.0, "BUSINESS")
    ImGui.Separator()
    
    if ImGui.Button("BUNKER INSTANT SELL", 180, 35) then
        if script.is_active("gb_gunrunning") then
            locals.set_int("gb_gunrunning", 1945, 0)
            gui.show_message("SilentNight", "Bunker vendido!")
        else
            gui.show_message("SilentNight", "No estás en venta de Bunker")
        end
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("HANGAR INSTANT SELL", 180, 35) then
        if script.is_active("gb_smuggler") then
            local delivered = locals.get_int("gb_smuggler", 1987)
            locals.set_int("gb_smuggler", 1986, delivered)
            gui.show_message("SilentNight", "Hangar vendido!")
        else
            gui.show_message("SilentNight", "No estás en venta de Hangar")
        end
    end
    
end)

gui.show_message("SilentNight", "Script cargado correctamente!")
