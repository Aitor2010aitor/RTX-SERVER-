--[[
    SilentNight - YimMenu Legacy Edition
    Conversión del script de Cherax a YimMenu Legacy
    Funciones incluidas: Heist Tool, Business Tool, Money Tool básico
]]

-- ==================== CONFIGURACIÓN ====================
local SilentNight = {
    version = "1.0.0",
    author = "Converted for YimMenu Legacy"
}

-- ==================== UTILIDADES ====================
local function notify(message)
    gui.show_message("SilentNight", message)
end

local function sleep(ms)
    script:sleep(ms)
end

local function get_player_id()
    return network.get_local_player_index()
end

local function is_in_session()
    return network.is_session_started()
end

-- ==================== GLOBALS Y LOCALS ====================
-- Globals para heists (Legacy Edition)
local Globals = {
    -- Heist Generic
    Heist_Launch_Step1 = 4718592 + 3539,
    Heist_Launch_Step2 = 4718592 + 3540,
    Heist_Launch_Step3 = 4718592 + 3542 + 1,
    Heist_Difficulty = 4718592 + 3538,
    
    -- Apartment Heist
    Apartment_Cut_Player1 = 1935536 + 1 + 1,
    Apartment_Cut_Player2 = 1935536 + 1 + 2,
    Apartment_Cut_Player3 = 1935536 + 1 + 3,
    Apartment_Cut_Player4 = 1935536 + 1 + 4,
    Apartment_Ready_Player1 = 2658291 + 1 + (0 * 468) + 270,
    Apartment_Ready_Player2 = 2658291 + 1 + (1 * 468) + 270,
    Apartment_Ready_Player3 = 2658291 + 1 + (2 * 468) + 270,
    Apartment_Ready_Player4 = 2658291 + 1 + (3 * 468) + 270,
    
    -- Cayo Perico
    Cayo_Cut_Player1 = 1978756 + 831 + 56 + 1,
    Cayo_Cut_Player2 = 1978756 + 831 + 56 + 2,
    Cayo_Cut_Player3 = 1978756 + 831 + 56 + 3,
    Cayo_Cut_Player4 = 1978756 + 831 + 56 + 4,
    Cayo_Ready_Player1 = 1979868 + 1 + (0 * 27) + 7 + 1,
    Cayo_Ready_Player2 = 1979868 + 1 + (1 * 27) + 7 + 2,
    Cayo_Ready_Player3 = 1979868 + 1 + (2 * 27) + 7 + 3,
    Cayo_Ready_Player4 = 1979868 + 1 + (3 * 27) + 7 + 4,
    
    -- Diamond Casino
    Casino_Cut_Player1 = 1971952 + 1497 + 736 + 92 + 1,
    Casino_Cut_Player2 = 1971952 + 1497 + 736 + 92 + 2,
    Casino_Cut_Player3 = 1971952 + 1497 + 736 + 92 + 3,
    Casino_Cut_Player4 = 1971952 + 1497 + 736 + 92 + 4,
    Casino_Ready_Player1 = 1976315 + 1 + (0 * 68) + 7 + 1,
    Casino_Ready_Player2 = 1976315 + 1 + (1 * 68) + 7 + 2,
    Casino_Ready_Player3 = 1976315 + 1 + (2 * 68) + 7 + 3,
    Casino_Ready_Player4 = 1976315 + 1 + (3 * 68) + 7 + 4,
    
    -- Doomsday
    Doomsday_Cut_Player1 = 1967983 + 812 + 50 + 1,
    Doomsday_Cut_Player2 = 1967983 + 812 + 50 + 2,
    Doomsday_Cut_Player3 = 1967983 + 812 + 50 + 3,
    Doomsday_Cut_Player4 = 1967983 + 812 + 50 + 4,
    
    -- Bunker
    Bunker_Production_Trigger1 = 2708790 + 1 + 5 * 2,
    Bunker_Production_Trigger2 = 2708790 + 1 + 5 * 2 + 1,
    
    -- Session
    Session_Switch = 1574589,
    Session_Quit = 1574589 + 2,
}

-- Locals para heists
local Locals = {
    -- Apartment
    Apartment_Finish_Step1 = 19746,
    Apartment_Finish_Step2 = 19746 + 1,
    Apartment_Finish_Step3 = 19746 + 2,
    
    -- Cayo Perico
    Cayo_Finish_Step1 = 48519,
    Cayo_Finish_Step2 = 48519 + 1,
    
    -- Casino
    Casino_Finish_Step1 = 1308,
    Casino_Finish_Step2 = 1308 + 1,
    Casino_Finish_Step3 = 1308 + 2,
    Casino_Autograbber = 1308 + 3,
    
    -- Doomsday
    Doomsday_Finish_Step1 = 19746,
    Doomsday_Finish_Step2 = 19746 + 1,
    
    -- Salvage Yard
    Salvage_Finish = 4240,
}

-- ==================== FUNCIONES DE HEIST ====================
local HeistTool = {}

function HeistTool.InstantFinishApartment()
    if script.is_active("fm_mission_controller") then
        local script_local = script.get_local("fm_mission_controller", Locals.Apartment_Finish_Step1)
        if script_local then
            script_local:set_int(12)
            script.get_local("fm_mission_controller", Locals.Apartment_Finish_Step2):set_int(99999)
            script.get_local("fm_mission_controller", Locals.Apartment_Finish_Step3):set_int(99999)
            notify("Apartment Heist - Instant Finish aplicado")
        end
    else
        notify("No estás en un heist de Apartment")
    end
end

function HeistTool.InstantFinishCayo()
    if script.is_active("fm_mission_controller_2020") then
        script.get_local("fm_mission_controller_2020", Locals.Cayo_Finish_Step1):set_int(9)
        script.get_local("fm_mission_controller_2020", Locals.Cayo_Finish_Step2):set_int(50)
        notify("Cayo Perico - Instant Finish aplicado")
    else
        notify("No estás en Cayo Perico")
    end
end

function HeistTool.InstantFinishCasino()
    if script.is_active("fm_mission_controller") then
        script.get_local("fm_mission_controller", Locals.Casino_Finish_Step1):set_int(5)
        script.get_local("fm_mission_controller", Locals.Casino_Finish_Step2):set_int(80)
        script.get_local("fm_mission_controller", Locals.Casino_Finish_Step3):set_int(10000000)
        notify("Diamond Casino - Instant Finish aplicado")
    else
        notify("No estás en Diamond Casino")
    end
end

function HeistTool.InstantFinishDoomsday()
    if script.is_active("fm_mission_controller") then
        script.get_local("fm_mission_controller", Locals.Doomsday_Finish_Step1):set_int(12)
        script.get_local("fm_mission_controller", Locals.Doomsday_Finish_Step2):set_int(150)
        notify("Doomsday - Instant Finish aplicado")
    else
        notify("No estás en Doomsday")
    end
end

function HeistTool.SetCutsApartment(p1, p2, p3, p4)
    globals.set_int(Globals.Apartment_Cut_Player1, p1)
    globals.set_int(Globals.Apartment_Cut_Player2, p2)
    globals.set_int(Globals.Apartment_Cut_Player3, p3)
    globals.set_int(Globals.Apartment_Cut_Player4, p4)
    notify("Apartment Cuts aplicados: " .. p1 .. "% / " .. p2 .. "% / " .. p3 .. "% / " .. p4 .. "%")
end

function HeistTool.SetCutsCayo(p1, p2, p3, p4)
    globals.set_int(Globals.Cayo_Cut_Player1, p1)
    globals.set_int(Globals.Cayo_Cut_Player2, p2)
    globals.set_int(Globals.Cayo_Cut_Player3, p3)
    globals.set_int(Globals.Cayo_Cut_Player4, p4)
    notify("Cayo Perico Cuts aplicados: " .. p1 .. "% / " .. p2 .. "% / " .. p3 .. "% / " .. p4 .. "%")
end

function HeistTool.SetCutsCasino(p1, p2, p3, p4)
    globals.set_int(Globals.Casino_Cut_Player1, p1)
    globals.set_int(Globals.Casino_Cut_Player2, p2)
    globals.set_int(Globals.Casino_Cut_Player3, p3)
    globals.set_int(Globals.Casino_Cut_Player4, p4)
    notify("Casino Cuts aplicados: " .. p1 .. "% / " .. p2 .. "% / " .. p3 .. "% / " .. p4 .. "%")
end

function HeistTool.ForceReadyApartment()
    globals.set_int(Globals.Apartment_Ready_Player1, 6)
    globals.set_int(Globals.Apartment_Ready_Player2, 6)
    globals.set_int(Globals.Apartment_Ready_Player3, 6)
    globals.set_int(Globals.Apartment_Ready_Player4, 6)
    notify("Apartment - Force Ready aplicado")
end

function HeistTool.ForceReadyCayo()
    globals.set_int(Globals.Cayo_Ready_Player1, 1)
    globals.set_int(Globals.Cayo_Ready_Player2, 1)
    globals.set_int(Globals.Cayo_Ready_Player3, 1)
    globals.set_int(Globals.Cayo_Ready_Player4, 1)
    notify("Cayo Perico - Force Ready aplicado")
end

function HeistTool.ForceReadyCasino()
    globals.set_int(Globals.Casino_Ready_Player1, 1)
    globals.set_int(Globals.Casino_Ready_Player2, 1)
    globals.set_int(Globals.Casino_Ready_Player3, 1)
    globals.set_int(Globals.Casino_Ready_Player4, 1)
    notify("Casino - Force Ready aplicado")
end

function HeistTool.SkipCutscene()
    if script.is_active("fm_mission_controller") or script.is_active("fm_mission_controller_2020") then
        script.get_local("fm_mission_controller", 19746):set_int(7)
        notify("Skip Cutscene aplicado")
    end
end

-- ==================== FUNCIONES DE NEGOCIOS ====================
local BusinessTool = {}

function BusinessTool.BunkerInstantSell()
    if script.is_active("gb_gunrunning") then
        script.get_local("gb_gunrunning", 1945):set_int(0)
        notify("Bunker - Instant Sell aplicado")
    else
        notify("No estás en una venta de Bunker")
    end
end

function BusinessTool.BunkerMaximizePrice()
    tunables.set_int("GR_SALE_VALUE_MULTIPLIER", 2500000)
    notify("Bunker - Precio maximizado")
end

function BusinessTool.BunkerResetPrice()
    tunables.set_int("GR_SALE_VALUE_MULTIPLIER", 1)
    notify("Bunker - Precio reseteado")
end

function BusinessTool.BunkerGetSupplies()
    globals.set_int(Globals.Bunker_Production_Trigger1, 0)
    globals.set_bool(Globals.Bunker_Production_Trigger2, true)
    notify("Bunker - Suministros obtenidos")
end

function BusinessTool.HangarInstantSell()
    if script.is_active("gb_smuggler") then
        local delivered = script.get_local("gb_smuggler", 1987):get_int()
        script.get_local("gb_smuggler", 1986):set_int(delivered)
        notify("Hangar - Instant Sell aplicado")
    else
        notify("No estás en una venta de Hangar")
    end
end

function BusinessTool.NightclubMaximizePopularity()
    stats.set_int("MPX_CLUB_POPULARITY", 100)
    notify("Nightclub - Popularidad maximizada")
end

function BusinessTool.NightclubCollectSafe()
    globals.set_int(2708832, 1)
    notify("Nightclub - Safe recolectado")
end

-- ==================== FUNCIONES DE DINERO ====================
local MoneyTool = {}

function MoneyTool.Loop300k()
    -- Usando el método de transacciones
    script:sleep(1000)
    network.earn_from_betting(300000)
    notify("300k Loop - Transacción aplicada")
end

function MoneyTool.Loop680k()
    script:sleep(1000)
    network.earn_from_betting(680000)
    notify("680k Loop - Transacción aplicada")
end

function MoneyTool.RemoveCooldowns()
    -- Cayo Perico cooldowns
    stats.set_int("MPX_H4_TARGET_POSIX", 1659643454)
    stats.set_int("MPX_H4_COOLDOWN", 0)
    stats.set_int("MPX_H4_COOLDOWN_HARD", 0)
    
    -- Casino cooldown
    stats.set_int("MPX_H3_COMPLETEDPOSIX", -1)
    stats.set_int("MPPLY_H3_COOLDOWN", -1)
    
    -- Doomsday cooldown
    stats.set_int("MPX_GANGOPS_HEIST_STATUS", -229380)
    
    notify("Todos los cooldowns eliminados")
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
    SalvageYard = {x = -1639.323, y = -181.432, z = 57.575},
    MazeBank = {x = -75.015, y = -818.215, z = 326.176},
}

local function teleport_to(coords)
    local player_ped = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(player_ped, coords.x, coords.y, coords.z)
    notify("Teletransportado")
end

-- ==================== MENU GUI ====================
local function render_heist_tab()
    if ImGui.BeginTabItem("Heist Tool") then
        ImGui.Text("--- Apartment Heist ---")
        if ImGui.Button("Instant Finish") then
            HeistTool.InstantFinishApartment()
        end
        ImGui.SameLine()
        if ImGui.Button("Force Ready") then
            HeistTool.ForceReadyApartment()
        end
        
        local cut1 = ImGui.InputInt("Player 1 %", 100)
        local cut2 = ImGui.InputInt("Player 2 %", 100)
        local cut3 = ImGui.InputInt("Player 3 %", 100)
        local cut4 = ImGui.InputInt("Player 4 %", 100)
        
        if ImGui.Button("Apply Apartment Cuts") then
            HeistTool.SetCutsApartment(cut1, cut2, cut3, cut4)
        end
        
        ImGui.Separator()
        ImGui.Text("--- Cayo Perico ---")
        if ImGui.Button("Instant Finish Cayo") then
            HeistTool.InstantFinishCayo()
        end
        ImGui.SameLine()
        if ImGui.Button("Force Ready Cayo") then
            HeistTool.ForceReadyCayo()
        end
        
        if ImGui.Button("Apply Cayo Cuts (100% P1)") then
            HeistTool.SetCutsCayo(100, 0, 0, 0)
        end
        
        ImGui.Separator()
        ImGui.Text("--- Diamond Casino ---")
        if ImGui.Button("Instant Finish Casino") then
            HeistTool.InstantFinishCasino()
        end
        ImGui.SameLine()
        if ImGui.Button("Force Ready Casino") then
            HeistTool.ForceReadyCasino()
        end
        
        if ImGui.Button("Apply Casino Cuts (100% P1)") then
            HeistTool.SetCutsCasino(100, 0, 0, 0)
        end
        
        ImGui.Separator()
        ImGui.Text("--- Doomsday ---")
        if ImGui.Button("Instant Finish Doomsday") then
            HeistTool.InstantFinishDoomsday()
        end
        
        ImGui.EndTabItem()
    end
end

local function render_business_tab()
    if ImGui.BeginTabItem("Business Tool") then
        ImGui.Text("--- Bunker ---")
        if ImGui.Button("Bunker Instant Sell") then
            BusinessTool.BunkerInstantSell()
        end
        ImGui.SameLine()
        if ImGui.Button("Maximize Price") then
            BusinessTool.BunkerMaximizePrice()
        end
        ImGui.SameLine()
        if ImGui.Button("Reset Price") then
            BusinessTool.BunkerResetPrice()
        end
        
        if ImGui.Button("Get Supplies") then
            BusinessTool.BunkerGetSupplies()
        end
        
        ImGui.Separator()
        ImGui.Text("--- Hangar ---")
        if ImGui.Button("Hangar Instant Sell") then
            BusinessTool.HangarInstantSell()
        end
        
        ImGui.Separator()
        ImGui.Text("--- Nightclub ---")
        if ImGui.Button("Max Popularity") then
            BusinessTool.NightclubMaximizePopularity()
        end
        ImGui.SameLine()
        if ImGui.Button("Collect Safe") then
            BusinessTool.NightclubCollectSafe()
        end
        
        ImGui.EndTabItem()
    end
end

local function render_money_tab()
    if ImGui.BeginTabItem("Money Tool") then
        ImGui.Text("--- Money Loops ---")
        if ImGui.Button("300k Loop (1x)") then
            MoneyTool.Loop300k()
        end
        ImGui.SameLine()
        if ImGui.Button("680k Loop (1x)") then
            MoneyTool.Loop680k()
        end
        
        ImGui.Separator()
        ImGui.Text("--- Cooldowns ---")
        if ImGui.Button("Remove All Cooldowns") then
            MoneyTool.RemoveCooldowns()
        end
        
        ImGui.EndTabItem()
    end
end

local function render_teleport_tab()
    if ImGui.BeginTabItem("Teleports") then
        ImGui.Text("--- Properties ---")
        
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
        if ImGui.Button("Salvage Yard") then
            teleport_to(Teleports.SalvageYard)
        end
        ImGui.SameLine()
        if ImGui.Button("Maze Bank") then
            teleport_to(Teleports.MazeBank)
        end
        
        ImGui.EndTabItem()
    end
end

-- ==================== MAIN LOOP ====================
local function main_loop()
    -- Auto-registro como CEO si está habilitado (puedes agregar toggle)
    --[[
    if is_in_session() then
        local player_id = get_player_id()
        if globals.get_int(1892653 + 1 + (player_id * 615) + 10) == -1 then
            globals.set_int(1892653 + 1 + (player_id * 615) + 10, 1)
        end
    end
    --]]
end

-- ==================== RENDER PRINCIPAL ====================
local function render_menu()
    if ImGui.Begin("SilentNight - YimMenu Legacy") then
        if ImGui.BeginTabBar("SilentNightTabs") then
            render_heist_tab()
            render_business_tab()
            render_money_tab()
            render_teleport_tab()
            ImGui.EndTabBar()
        end
    end
    ImGui.End()
end

-- ==================== REGISTRO ====================
gui.add_tab("SilentNight", render_menu)

-- Loop principal
while true do
    main_loop()
    sleep(1000) -- 1 segundo
end
