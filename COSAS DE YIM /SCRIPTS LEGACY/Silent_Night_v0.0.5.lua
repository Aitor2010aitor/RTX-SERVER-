--[[
    SilentNight v1.11.4 - YimMenu Legacy
    Completo con todas las funciones
    Instant Finish usa método SoloMissions (funcional)
]]

local SilentNight<const> = gui.add_tab("SilentNight")

-- ==================== UTILIDADES ====================
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
    if script.is_active("fm_mission_controller") then return "fm_mission_controller" end
    if script.is_active("fm_mission_controller_2020") then return "fm_mission_controller_2020" end
    return nil
end

local function set_bits(scriptName, index, ...)
    local value = locals.get_int(scriptName, index)
    for _, bit in ipairs({...}) do
        value = value | (1 << bit)
    end
    locals.set_int(scriptName, index, value)
end

-- ==================== INSTANT FINISH (MÉTODO SOLOMISSIONS - FUNCIONAL) ====================
local function InstantFinish()
    local mscript = GetMissionScript()
    if not mscript then
        notify("No estas en un heist!")
        return
    end
    
    -- Limpiar content IDs (método SoloMissions)
    for i = 0, 5 do
        globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
    end
    
    -- Locals según el script activo
    local nextMission, teamScore, serverBitSet
    
    if mscript == "fm_mission_controller" then
        -- Apartment / Casino / Doomsday
        nextMission = 20870      -- 19808 + 1062
        teamScore = 22041        -- 19808 + 1232 + 1
        serverBitSet = 19809     -- 19808 + 1
    else
        -- Cayo Perico (fm_mission_controller_2020)
        nextMission = 57659      -- 56070 + 1589
        teamScore = 58377        -- 56070 + 1776 + 1
        serverBitSet = 56071     -- 56070 + 1
    end
    
    locals.set_int(mscript, nextMission, 5)
    locals.set_int(mscript, teamScore, 999999)
    set_bits(mscript, serverBitSet, 9, 16)
    
    notify("INSTANT FINISH APLICADO!")
end

local function SkipCheckpoint()
    local mscript = GetMissionScript()
    if not mscript then
        notify("No estas en un heist!")
        return
    end
    
    local serverBitSet2 = (mscript == "fm_mission_controller") and 19810 or 56072
    set_bits(mscript, serverBitSet2, 17)
    notify("Skip Checkpoint aplicado!")
end

-- ==================== PREPS CAYO PERICO ====================
local cayo_difficulty = 0
local cayo_approach = 0
local cayo_loadout = 0
local cayo_target = 4  -- Panther por defecto

local function CompletePrepsCayo()
    local MPX = "MP" .. network.get_local_player_index() .. "_"
    
    stats.set_int(MPX .. "H4_PROGRESS", cayo_difficulty)           -- Dificultad
    stats.set_int(MPX .. "H4_MISSIONS", cayo_approach)              -- Approach
    stats.set_int(MPX .. "H4CNF_WEAPONS", cayo_loadout)             -- Loadout
    stats.set_int(MPX .. "H4CNF_TARGET", cayo_target)               -- Target (0-4)
    
    -- Desbloquear todo
    stats.set_int(MPX .. "H4CNF_BS_GEN", -1)                        -- All general
    stats.set_int(MPX .. "H4CNF_BS_ENTR", 63)                       -- All entrances
    stats.set_int(MPX .. "H4CNF_BS_ABIL", 63)                       -- All abilities
    stats.set_int(MPX .. "H4CNF_APPROACH", -1)                      -- All approaches
    
    -- Equipo
    stats.set_int(MPX .. "H4CNF_UNIFORM", -1)
    stats.set_int(MPX .. "H4CNF_GRAPPEL", -1)
    stats.set_int(MPX .. "H4CNF_TROJAN", 5)
    stats.set_int(MPX .. "H4CNF_WEP_DISRP", 3)
    stats.set_int(MPX .. "H4CNF_ARM_DISRP", 3)
    stats.set_int(MPX .. "H4CNF_HEL_DISRP", 3)
    
    -- Secundarios (llenar de oro)
    stats.set_int(MPX .. "H4LOOT_GOLD_C", 0)  -- Compound
    stats.set_int(MPX .. "H4LOOT_GOLD_C_SCOPED", 0)
    stats.set_int(MPX .. "H4LOOT_GOLD_I", 0)  -- Island
    stats.set_int(MPX .. "H4LOOT_GOLD_I_SCOPED", 0)
    
    -- Recargar pantalla
    if script.is_active("heist_island_planning") then
        locals.set_int("heist_island_planning", 1546, 2)
    end
    
    notify("Preps Cayo Perico completadas! Target: " .. (cayo_target == 4 and "Panther" or "Otro"))
end

local function KillCooldownCayo()
    local MPX = "MP" .. network.get_local_player_index() .. "_"
    stats.set_int(MPX .. "H4_TARGET_POSIX", 1659643454)
    stats.set_int(MPX .. "H4_COOLDOWN", 0)
    stats.set_int(MPX .. "H4_COOLDOWN_HARD", 0)
    notify("Cooldown Cayo eliminado!")
end

-- ==================== PREPS CASINO ====================
local casino_difficulty = 0
local casino_approach = 0
local casino_gunman = 0
local casino_driver = 0
local casino_hacker = 0
local casino_target = 3  -- Diamantes por defecto

local function CompletePrepsCasino()
    local MPX = "MP" .. network.get_local_player_index() .. "_"
    
    stats.set_int(MPX .. "H3_LAST_APPROACH", 0)
    stats.set_int(MPX .. "H3_HARD_APPROACH", (casino_difficulty == 0) and 0 or casino_approach)
    stats.set_int(MPX .. "H3OPT_APPROACH", casino_approach)
    stats.set_int(MPX .. "H3OPT_CREWWEAP", casino_gunman)
    stats.set_int(MPX .. "H3OPT_WEAPS", 0)
    stats.set_int(MPX .. "H3OPT_CREWDRIVER", casino_driver)
    stats.set_int(MPX .. "H3OPT_VEHS", 0)
    stats.set_int(MPX .. "H3OPT_CREWHACKER", casino_hacker)
    stats.set_int(MPX .. "H3OPT_TARGET", casino_target)
    stats.set_int(MPX .. "H3OPT_MASKS", 0)
    stats.set_int(MPX .. "H3OPT_DISRUPTSHIP", 3)  -- Guards
    stats.set_int(MPX .. "H3OPT_KEYLEVELS", 2)     -- Keycards
    stats.set_int(MPX .. "H3OPT_BODYARMORLVL", -1)
    stats.set_int(MPX .. "H3OPT_BITSET0", -1)
    stats.set_int(MPX .. "H3OPT_BITSET1", -1)
    stats.set_int(MPX .. "H3OPT_COMPLETEDPOSIX", -1)
    
    -- Recargar tablero
    if script.is_active("gb_casino_heist_planning") then
        locals.set_int("gb_casino_heist_planning", 1308, 2)
    end
    
    notify("Preps Casino completadas! Target: " .. (casino_target == 3 and "Diamantes" or "Otro"))
end

local function KillCooldownCasino()
    local MPX = "MP" .. network.get_local_player_index() .. "_"
    stats.set_int(MPX .. "H3_COMPLETEDPOSIX", -1)
    stats.set_int("MPPLY_H3_COOLDOWN", -1)
    notify("Cooldown Casino eliminado!")
end

-- ==================== PREPS DOOMSDAY ====================
local doomsday_act = 0

local function CompletePrepsDoomsday()
    local MPX = "MP" .. network.get_local_player_index() .. "_"
    local acts = {
        [0] = {503, -229383},      -- Act I
        [1] = {240, -229378},      -- Act II
        [2] = {16368, -229380}     -- Act III
    }
    
    stats.set_int(MPX .. "GANGOPS_FLOW_MISSION_PROG", acts[doomsday_act][1])
    stats.set_int(MPX .. "GANGOPS_HEIST_STATUS", acts[doomsday_act][2])
    stats.set_int(MPX .. "GANGOPS_FLOW_NOTIFICATIONS", 1557)
    
    -- Recargar pantalla
    if script.is_active("gb_gangops_planning") then
        locals.set_int("gb_gangops_planning", 19746, 6)
    end
    
    notify("Preps Doomsday Act " .. (doomsday_act + 1) .. " completadas!")
end

-- ==================== CORTES ====================
local cut_values = {100, 0, 0, 0}

local function ApplyCutsApartment()
    globals.set_int(1935536 + 2, cut_values[1])
    globals.set_int(1935536 + 3, cut_values[2])
    globals.set_int(1935536 + 4, cut_values[3])
    globals.set_int(1935536 + 5, cut_values[4])
    notify("Cuts Apartment: " .. cut_values[1] .. "% / " .. cut_values[2] .. "% / " .. cut_values[3] .. "% / " .. cut_values[4] .. "%")
end

local function ApplyCutsCayo()
    globals.set_int(1978756 + 888, cut_values[1])
    globals.set_int(1978756 + 889, cut_values[2])
    globals.set_int(1978756 + 890, cut_values[3])
    globals.set_int(1978756 + 891, cut_values[4])
    notify("Cuts Cayo: " .. cut_values[1] .. "% / " .. cut_values[2] .. "% / " .. cut_values[3] .. "% / " .. cut_values[4] .. "%")
end

local function ApplyCutsCasino()
    globals.set_int(1971952 + 2326, cut_values[1])
    globals.set_int(1971952 + 2327, cut_values[2])
    globals.set_int(1971952 + 2328, cut_values[3])
    globals.set_int(1971952 + 2329, cut_values[4])
    notify("Cuts Casino: " .. cut_values[1] .. "% / " .. cut_values[2] .. "% / " .. cut_values[3] .. "% / " .. cut_values[4] .. "%")
end

local function ApplyCutsDoomsday()
    globals.set_int(1967983 + 863, cut_values[1])
    globals.set_int(1967983 + 864, cut_values[2])
    globals.set_int(1967983 + 865, cut_values[3])
    globals.set_int(1967983 + 866, cut_values[4])
    notify("Cuts Doomsday: " .. cut_values[1] .. "% / " .. cut_values[2] .. "% / " .. cut_values[3] .. "% / " .. cut_values[4] .. "%")
end

-- ==================== TELEPORTS ====================
local function Teleport(x, y, z)
    local ped = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(ped, x, y, z)
    notify("Teletransportado!")
end

-- ==================== BUSINESS ====================
local function BunkerInstantSell()
    if script.is_active("gb_gunrunning") then
        locals.set_int("gb_gunrunning", 1945, 0)
        notify("Bunker vendido instantaneamente!")
    else
        notify("No estas en venta de Bunker")
    end
end

local function HangarInstantSell()
    if script.is_active("gb_smuggler") then
        local delivered = locals.get_int("gb_smuggler", 1987)
        locals.set_int("gb_smuggler", 1986, delivered)
        notify("Hangar vendido instantaneamente!")
    else
        notify("No estas en venta de Hangar")
    end
end

local function NightclubCollectSafe()
    globals.set_int(2708832, 1)
    notify("Dinero del Nightclub recolectado!")
end

-- ==================== SOLO MISSIONS ====================
local soloEnabled = false

script.register_looped("SILENTNIGHT_SOLO", function()
    if soloEnabled and IsOnline() then
        globals.set_int(4718592 + 3769, 1)   -- minNumParticipants
        globals.set_int(4718592 + 3772, 1)   -- numberOfTeams
        globals.set_int(4718592 + 3773, 1)   -- maxNumberOfTeams
        globals.set_int(4718592 + 3776, 1)   -- numPlayersPerTeam
        globals.set_int(4718592 + 190164, 0) -- criticalMinimumForTeam
    end
end)

-- ==================== RENDER PRINCIPAL ====================
SilentNight:add_imgui(function()
    
    if not IsOnline() then
        ImGui.TextColored(1.0, 0.0, 0.0, 1.0, "SOLO DISPONIBLE EN GTA ONLINE")
        return
    end
    
    ImGui.Text("SilentNight v1.11.4 - YimMenu Legacy")
    ImGui.Separator()
    
    -- Solo Missions
    local clicked = false
    soloEnabled, clicked = ImGui.Checkbox("Enable Solo Missions (Jugar heists solo)", soloEnabled)
    if clicked then
        notify(soloEnabled and "Solo Missions ACTIVADO" or "Solo Missions DESACTIVADO")
    end
    
    ImGui.Dummy(0, 5)
    ImGui.SeparatorText("INSTANT FINISH (FUNCIONAL)")
    
    -- BOTONES INSTANT FINISH
    if ImGui.Button("INSTANT FINISH", 180, 40) then
        InstantFinish()
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("SKIP CHECKPOINT", 180, 40) then
        SkipCheckpoint()
    end
    
    ImGui.Dummy(0, 5)
    ImGui.SeparatorText("CAYO PERICO - PREPS")
    
    -- Cayo Preps
    cayo_difficulty = ImGui.Combo("Dificultad", cayo_difficulty, {"Normal", "Hard"}, 2)
    cayo_approach = ImGui.Combo("Approach", cayo_approach, {"Kosatka", "Alkonost", "Velum", "Annihilator", "Patrol Boat", "Longfin"}, 6)
    cayo_loadout = ImGui.Combo("Loadout", cayo_loadout, {"Aggressor", "Conspirator", "Crackshot", "Saboteur", "Marksman"}, 5)
    cayo_target = ImGui.Combo("Target Principal", cayo_target, {"Tequila", "Ruby Necklace", "Bearer Bonds", "Pink Diamond", "Panther Statue"}, 5)
    
    if ImGui.Button("COMPLETAR PREPS CAYO", 200, 30) then
        CompletePrepsCayo()
    end
    ImGui.SameLine()
    if ImGui.Button("KILL COOLDOWN CAYO", 150, 30) then
        KillCooldownCayo()
    end
    
    ImGui.Dummy(0, 5)
    ImGui.SeparatorText("DIAMOND CASINO - PREPS")
    
    -- Casino Preps
    casino_difficulty = ImGui.Combo("Dificultad##Casino", casino_difficulty, {"Normal", "Hard"}, 2)
    casino_approach = ImGui.Combo("Approach##Casino", casino_approach, {"Stealth (Silencioso)", "Big Con (Engaño)", "Aggressive (Agresivo)"}, 3)
    casino_gunman = ImGui.Combo("Gunman", casino_gunman, {"Karl Abolaji", "Gustavo Mota", "Charlie Reed", "Chester McCoy", "Patrick McReary"}, 5)
    casino_driver = ImGui.Combo("Driver", casino_driver, {"Karim Denz", "Taliana Martinez", "Eddie Toh", "Zach Nelson", "Chester McCoy"}, 5)
    casino_hacker = ImGui.Combo("Hacker", casino_hacker, {"Rickie Lukens", "Yohan Blair", "Christian Feltz", "Paige Harris", "Avi Schwartzman"}, 5)
    casino_target = ImGui.Combo("Target##Casino", casino_target, {"Cash", "Artwork", "Gold", "Diamonds"}, 4)
    
    if ImGui.Button("COMPLETAR PREPS CASINO", 200, 30) then
        CompletePrepsCasino()
    end
    ImGui.SameLine()
    if ImGui.Button("KILL COOLDOWN CASINO", 150, 30) then
        KillCooldownCasino()
    end
    
    ImGui.Dummy(0, 5)
    ImGui.SeparatorText("DOOMSDAY - PREPS")
    
    -- Doomsday Preps
    doomsday_act = ImGui.Combo("Acto", doomsday_act, {"Act I - Data Breaches", "Act II - Bogdan Problem", "Act III - Doomsday Scenario"}, 3)
    
    if ImGui.Button("COMPLETAR PREPS DOOMSDAY", 250, 30) then
        CompletePrepsDoomsday()
    end
    
    ImGui.Dummy(0, 5)
    ImGui.SeparatorText("CORTES PARA TODOS LOS HEISTS")
    
    -- Cortes
    cut_values[1] = ImGui.InputInt("Player 1 %", cut_values[1])
    cut_values[2] = ImGui.InputInt("Player 2 %", cut_values[2])
    cut_values[3] = ImGui.InputInt("Player 3 %", cut_values[3])
    cut_values[4] = ImGui.InputInt("Player 4 %", cut_values[4])
    
    if ImGui.Button("APARTMENT", 100, 30) then
        ApplyCutsApartment()
    end
    ImGui.SameLine()
    if ImGui.Button("CAYO", 100, 30) then
        ApplyCutsCayo()
    end
    ImGui.SameLine()
    if ImGui.Button("CASINO", 100, 30) then
        ApplyCutsCasino()
    end
    ImGui.SameLine()
    if ImGui.Button("DOOMSDAY", 100, 30) then
        ApplyCutsDoomsday()
    end
    
    ImGui.Dummy(0, 5)
    ImGui.SeparatorText("TELEPORTS")
    
    -- Teleports fila 1
    if ImGui.Button("KOSATKA", 90, 30) then
        Teleport(1561.224, -486.318, -62.226)
    end
    ImGui.SameLine()
    if ImGui.Button("ARCADE", 90, 30) then
        Teleport(2737.962, -374.760, -47.993)
    end
    ImGui.SameLine()
    if ImGui.Button("BUNKER", 90, 30) then
        Teleport(2110.976, 3320.326, 45.361)
    end
    ImGui.SameLine()
    if ImGui.Button("FACILITY", 90, 30) then
        Teleport(489.062, -1303.906, 29.306)
    end
    
    -- Teleports fila 2
    if ImGui.Button("AGENCY", 90, 30) then
        Teleport(-1011.083, -480.368, 39.073)
    end
    ImGui.SameLine()
    if ImGui.Button("CASINO", 90, 30) then
        Teleport(935.073, 46.635, 81.095)
    end
    ImGui.SameLine()
    if ImGui.Button("MAZEBANK", 90, 30) then
        Teleport(-75.015, -818.215, 326.176)
    end
    ImGui.SameLine()
    if ImGui.Button("HANGAR", 90, 30) then
        Teleport(-1267.071, -3380.069, 14.007)
    end
    
    ImGui.Dummy(0, 5)
    ImGui.SeparatorText("BUSINESS TOOL")
    
    -- Business
    if ImGui.Button("BUNKER INSTANT SELL", 150, 35) then
        BunkerInstantSell()
    end
    ImGui.SameLine()
    if ImGui.Button("HANGAR INSTANT SELL", 150, 35) then
        HangarInstantSell()
    end
    ImGui.SameLine()
    if ImGui.Button("NIGHTCLUB SAFE", 150, 35) then
        NightclubCollectSafe()
    end
    
end)

notify("SilentNight v1.11.4 cargado correctamente!")
