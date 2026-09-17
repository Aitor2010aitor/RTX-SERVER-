--[[
    SilentNight - YimMenu Legacy
    Versión funcional con botones visibles
]]

-- ==================== CONFIGURACIÓN ====================
local SilentNight = {
    VERSION = "1.0",
    solo_enabled = false
}

-- ==================== FUNCIONES BÁSICAS ====================
local function notify(msg)
    gui.show_message("SilentNight", msg)
end

local function sleep(ms)
    script:sleep(ms)
end

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

-- ==================== SET BITS ====================
local function set_bits(scriptName, index, ...)
    local value = locals.get_int(scriptName, index)
    for _, bit in ipairs({...}) do
        value = value | (1 << bit)
    end
    locals.set_int(scriptName, index, value)
end

-- ==================== INSTANT FINISH ====================
local InstantFinish = {}

function InstantFinish.SkipCheckpoint()
    local mscript = GetMissionScript()
    if not mscript then
        notify("No estás en un heist!")
        return
    end
    
    local bitset2 = (mscript == "fm_mission_controller") and 19810 or 56072
    set_bits(mscript, bitset2, 17)
    notify("Skip Checkpoint aplicado!")
end

function InstantFinish.Finish()
    local mscript = GetMissionScript()
    if not mscript then
        notify("No estás en un heist!")
        return
    end
    
    -- Limpiar nextContentID
    for i = 0, 5 do
        globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
    end
    
    -- Locals según el script
    local nextMission = (mscript == "fm_mission_controller") and 20870 or 57659
    local teamScore = (mscript == "fm_mission_controller") and 22041 or 58377
    local bitset = (mscript == "fm_mission_controller") and 19809 or 56071
    
    locals.set_int(mscript, nextMission, 5)
    locals.set_int(mscript, teamScore, 999999)
    set_bits(mscript, bitset, 9, 16)
    
    notify("INSTANT FINISH APLICADO!")
end

-- ==================== SOLO MISSIONS ====================
script.register_looped("SOLO_MISSIONS", function()
    if SilentNight.solo_enabled and IsOnline() then
        globals.set_int(4718592 + 3769, 1)
        globals.set_int(4718592 + 3772, 1)
        globals.set_int(4718592 + 3773, 1)
        globals.set_int(4718592 + 3776, 1)
        globals.set_int(4718592 + 190164, 0)
    end
end)

-- ==================== CORTES ====================
local cut_values = {100, 0, 0, 0}

local function ApplyCutsApartment()
    globals.set_int(1935536 + 2, cut_values[1])
    globals.set_int(1935536 + 3, cut_values[2])
    globals.set_int(1935536 + 4, cut_values[3])
    globals.set_int(1935536 + 5, cut_values[4])
    notify("Cuts Apartment aplicados!")
end

local function ApplyCutsCayo()
    globals.set_int(1978756 + 888, cut_values[1])
    globals.set_int(1978756 + 889, cut_values[2])
    globals.set_int(1978756 + 890, cut_values[3])
    globals.set_int(1978756 + 891, cut_values[4])
    notify("Cuts Cayo aplicados!")
end

local function ApplyCutsCasino()
    globals.set_int(1971952 + 2326, cut_values[1])
    globals.set_int(1971952 + 2327, cut_values[2])
    globals.set_int(1971952 + 2328, cut_values[3])
    globals.set_int(1971952 + 2329, cut_values[4])
    notify("Cuts Casino aplicados!")
end

-- ==================== TELEPORTS ====================
local function Teleport(x, y, z)
    local ped = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(ped, x, y, z)
    notify("Teletransportado!")
end

-- ==================== MENÚ PRINCIPAL ====================
local function RenderMenu()
    -- Verificar si está en línea
    if not IsOnline() then
        ImGui.TextColored(1.0, 0.0, 0.0, 1.0, "SOLO DISPONIBLE EN ONLINE")
        return
    end
    
    ImGui.Text("SilentNight v" .. SilentNight.VERSION)
    ImGui.Separator()
    
    -- ========== SOLO MISSIONS ==========
    local changed = false
    SilentNight.solo_enabled, changed = ImGui.Checkbox("Enable Solo Missions", SilentNight.solo_enabled)
    if changed then
        notify(SilentNight.solo_enabled and "Solo Missions ON" or "Solo Missions OFF")
    end
    
    ImGui.Separator()
    ImGui.Text("--- INSTANT FINISH ---")
    
    -- ========== BOTONES PRINCIPALES ==========
    if ImGui.Button("SKIP CHECKPOINT", 150, 30) then
        InstantFinish.SkipCheckpoint()
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("INSTANT FINISH", 150, 30) then
        InstantFinish.Finish()
    end
    
    ImGui.Separator()
    ImGui.Text("--- CORTES ---")
    
    -- Inputs de cortes
    cut_values[1] = ImGui.InputInt("P1 %", cut_values[1])
    cut_values[2] = ImGui.InputInt("P2 %", cut_values[2])
    cut_values[3] = ImGui.InputInt("P3 %", cut_values[3])
    cut_values[4] = ImGui.InputInt("P4 %", cut_values[4])
    
    -- Botones de aplicar cortes
    if ImGui.Button("Apartment", 100, 25) then
        ApplyCutsApartment()
    end
    ImGui.SameLine()
    if ImGui.Button("Cayo", 100, 25) then
        ApplyCutsCayo()
    end
    ImGui.SameLine()
    if ImGui.Button("Casino", 100, 25) then
        ApplyCutsCasino()
    end
    
    ImGui.Separator()
    ImGui.Text("--- TELEPORTS ---")
    
    -- Teleports en fila
    if ImGui.Button("Kosatka", 80, 25) then
        Teleport(1561.224, -486.318, -62.226)
    end
    ImGui.SameLine()
    if ImGui.Button("Arcade", 80, 25) then
        Teleport(2737.962, -374.760, -47.993)
    end
    ImGui.SameLine()
    if ImGui.Button("Bunker", 80, 25) then
        Teleport(2110.976, 3320.326, 45.361)
    end
    ImGui.SameLine()
    if ImGui.Button("Facility", 80, 25) then
        Teleport(489.062, -1303.906, 29.306)
    end
    
    -- Segunda fila
    if ImGui.Button("Agency", 80, 25) then
        Teleport(-1011.083, -480.368, 39.073)
    end
    ImGui.SameLine()
    if ImGui.Button("Casino", 80, 25) then
        Teleport(935.073, 46.635, 81.095)
    end
    ImGui.SameLine()
    if ImGui.Button("MazeBank", 80, 25) then
        Teleport(-75.015, -818.215, 326.176)
    end
    ImGui.SameLine()
    if ImGui.Button("Hangar", 80, 25) then
        Teleport(-1267.071, -3380.069, 14.007)
    end
    
    ImGui.Separator()
    ImGui.Text("--- BUSINESS ---")
    
    if ImGui.Button("Bunker Instant Sell", 150, 30) then
        if script.is_active("gb_gunrunning") then
            locals.set_int("gb_gunrunning", 1945, 0)
            notify("Bunker Instant Sell!")
        else
            notify("No estás en venta de Bunker")
        end
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("Hangar Instant Sell", 150, 30) then
        if script.is_active("gb_smuggler") then
            local delivered = locals.get_int("gb_smuggler", 1987)
            locals.set_int("gb_smuggler", 1986, delivered)
            notify("Hangar Instant Sell!")
        else
            notify("No estás en venta de Hangar")
        end
    end
end

-- ==================== REGISTRAR MENÚ ====================
gui.add_tab("SilentNight", RenderMenu)

notify("SilentNight cargado! Abre el menú para ver los botones.")
