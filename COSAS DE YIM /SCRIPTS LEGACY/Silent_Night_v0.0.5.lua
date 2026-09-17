--[[
    SilentNight Script - YimMenu Legacy Edition
    Conversión directa del script de Cherax
    Versión: 1.11.4
]]

-- ==================== SISTEMA BASE ====================
local SilentNight = {
    VERSION = "1.11.4",
    CONFIG = {
        timeout_duration = 10,
        instant_finish = {
            apartment = 0,
            cayo_perico = 0,
            diamond_casino = 0,
            doomsday = 0,
            agency = 0,
            auto_shop = 0
        }
    }
}

-- Utilidades de conversión Cherax -> Legacy
local function J(hash_string)
    -- Conversión de joaat
    return gameplay.get_hash_key(hash_string)
end

local function F(format_str, ...)
    -- Formato de strings
    return string.format(format_str, ...)
end

local function U(table_coords)
    -- Unpack coords para teleport
    return table_coords.x, table_coords.y, table_coords.z
end

local function notify(message)
    gui.show_message("SilentNight", message)
end

local function sleep(ms)
    script:sleep(ms)
end

local function get_player_index()
    return network.get_local_player_index()
end

-- ==================== TABLAS GLOBALES (eGlobal) ====================
eGlobal = {
    HAS_PARSED = false,
    
    Heist = {
        Generic = {
            Launch = {
                Step1 = { type = "int", global = 4718592 + 3539 },
                Step2 = { type = "int", global = 4718592 + 3540 },
                Step3 = { type = "int", global = 4718592 + 3542 + 1 },
                Step4 = { type = "int", global = 4718592 + 185951 + 1 },
                Step5 = { type = "int", global = 4718592 + 3536 }
            },
            Cut = { type = "int", global = 2686090 + 6772 },
            Difficulty = { type = "int", global = 4718592 + 3538 },
        },
        
        Apartment = {
            Cut = {
                Player1 = { type = "int", global = 1935536 + 1 + 1 },
                Player2 = { type = "int", global = 1935536 + 1 + 2 },
                Player3 = { type = "int", global = 1935536 + 1 + 3 },
                Player4 = { type = "int", global = 1935536 + 1 + 4 },
            },
            Ready = {
                Player1 = { type = "int", global = 2658291 + 1 + (0 * 468) + 270 },
                Player2 = { type = "int", global = 2658291 + 1 + (1 * 468) + 270 },
                Player3 = { type = "int", global = 2658291 + 1 + (2 * 468) + 270 },
                Player4 = { type = "int", global = 2658291 + 1 + (3 * 468) + 270 },
            },
            Cooldown = {
                Step1 = { type = "int", global = 1877158 + 1 + (get_player_index() * 77) + 76 },
                Step2 = { type = "int", global = 2635125 + 1 },
            }
        },
        
        CayoPerico = {
            Cut = {
                Player1 = { type = "int", global = 1978756 + 831 + 56 + 1 },
                Player2 = { type = "int", global = 1978756 + 831 + 56 + 2 },
                Player3 = { type = "int", global = 1978756 + 831 + 56 + 3 },
                Player4 = { type = "int", global = 1978756 + 831 + 56 + 4 },
            },
            Ready = {
                Player1 = { type = "int", global = 1979868 + 1 + (0 * 27) + 7 + 1 },
                Player2 = { type = "int", global = 1979868 + 1 + (1 * 27) + 7 + 2 },
                Player3 = { type = "int", global = 1979868 + 1 + (2 * 27) + 7 + 3 },
                Player4 = { type = "int", global = 1979868 + 1 + (3 * 27) + 7 + 4 },
            }
        },
        
        DiamondCasino = {
            Cut = {
                Player1 = { type = "int", global = 1971952 + 1497 + 736 + 92 + 1 },
                Player2 = { type = "int", global = 1971952 + 1497 + 736 + 92 + 2 },
                Player3 = { type = "int", global = 1971952 + 1497 + 736 + 92 + 3 },
                Player4 = { type = "int", global = 1971952 + 1497 + 736 + 92 + 4 },
            },
            Ready = {
                Player1 = { type = "int", global = 1976315 + 1 + (0 * 68) + 7 + 1 },
                Player2 = { type = "int", global = 1976315 + 1 + (1 * 68) + 7 + 2 },
                Player3 = { type = "int", global = 1976315 + 1 + (2 * 68) + 7 + 3 },
                Player4 = { type = "int", global = 1976315 + 1 + (3 * 68) + 7 + 4 },
            },
            Data = {
                Target = { type = "int", global = 1971918 + 1 },
                Cameras = { type = "bool", global = 1971918 + 2 },
                Patrol = { type = "bool", global = 1971918 + 3 },
                Guards = { type = "int", global = 1971918 + 4 },
                Buyer = { type = "int", global = 1971918 + 8 },
                HardMode = { type = "bool", global = 1971918 + 27 }
            }
        },
        
        Doomsday = {
            Cut = {
                Player1 = { type = "int", global = 1967983 + 812 + 50 + 1 },
                Player2 = { type = "int", global = 1967983 + 812 + 50 + 2 },
                Player3 = { type = "int", global = 1967983 + 812 + 50 + 3 },
                Player4 = { type = "int", global = 1967983 + 812 + 50 + 4 },
            },
            Ready = {
                Player1 = { type = "int", global = 1882572 + 1 + (0 * 315) + 43 + 11 + 1 },
                Player2 = { type = "int", global = 1882572 + 1 + (1 * 315) + 43 + 11 + 2 },
                Player3 = { type = "int", global = 1882572 + 1 + (2 * 315) + 43 + 11 + 3 },
                Player4 = { type = "int", global = 1882572 + 1 + (3 * 315) + 43 + 11 + 4 },
            }
        }
    },
    
    Business = {
        Bunker = {
            Production = {
                Trigger1 = { type = "int", global = 2708790 + 1 + 5 * 2 },
                Trigger2 = { type = "bool", global = 2708790 + 1 + 5 * 2 + 1 },
            }
        },
        Nightclub = {
            Safe = {
                Collect = { type = "bool", global = 2708832 },
            }
        },
        Arcade = {
            Safe = {
                Collect = { type = "bool", global = 2708841 },
            }
        }
    },
    
    Session = {
        Type = { type = "int", global = 1575042 },
        Switch = { type = "int", global = 1574589 },
        Quit = { type = "int", global = 1574589 + 2 }
    }
}

-- ==================== STATS (eStat) ====================
eStat = {
    -- Apartment
    MPX_HEIST_PLANNING_STAGE = function() return "MP" .. get_player_index() .. "_HEIST_PLANNING_STAGE" end,
    MPX_HEIST_SESSION_ID_MACADDR = function() return "MP" .. get_player_index() .. "_HEIST_SESSION_ID_MACADDR" end,
    MPX_HEIST_LEADER_APART_ID = function() return "MP" .. get_player_index() .. "_HEIST_LEADER_APART_ID" end,
    MPPLY_HEIST_PROGRESS_HASH = "MPPLY_HEIST_PROGRESS_HASH",
    
    -- Cayo Perico
    MPX_H4_PROGRESS = function() return "MP" .. get_player_index() .. "_H4_PROGRESS" end,
    MPX_H4_MISSIONS = function() return "MP" .. get_player_index() .. "_H4_MISSIONS" end,
    MPX_H4CNF_WEAPONS = function() return "MP" .. get_player_index() .. "_H4CNF_WEAPONS" end,
    MPX_H4CNF_TARGET = function() return "MP" .. get_player_index() .. "_H4CNF_TARGET" end,
    MPX_H4_TARGET_POSIX = function() return "MP" .. get_player_index() .. "_H4_TARGET_POSIX" end,
    MPX_H4_COOLDOWN = function() return "MP" .. get_player_index() .. "_H4_COOLDOWN" end,
    MPX_H4_COOLDOWN_HARD = function() return "MP" .. get_player_index() .. "_H4_COOLDOWN_HARD" end,
    
    -- Diamond Casino
    MPX_H3OPT_APPROACH = function() return "MP" .. get_player_index() .. "_H3OPT_APPROACH" end,
    MPX_H3OPT_CREWWEAP = function() return "MP" .. get_player_index() .. "_H3OPT_CREWWEAP" end,
    MPX_H3OPT_WEAPS = function() return "MP" .. get_player_index() .. "_H3OPT_WEAPS" end,
    MPX_H3OPT_CREWDRIVER = function() return "MP" .. get_player_index() .. "_H3OPT_CREWDRIVER" end,
    MPX_H3OPT_VEHS = function() return "MP" .. get_player_index() .. "_H3OPT_VEHS" end,
    MPX_H3OPT_CREWHACKER = function() return "MP" .. get_player_index() .. "_H3OPT_CREWHACKER" end,
    MPX_H3OPT_TARGET = function() return "MP" .. get_player_index() .. "_H3OPT_TARGET" end,
    MPX_H3OPT_MASKS = function() return "MP" .. get_player_index() .. "_H3OPT_MASKS" end,
    MPX_H3OPT_DISRUPTSHIP = function() return "MP" .. get_player_index() .. "_H3OPT_DISRUPTSHIP" end,
    MPX_H3OPT_KEYLEVELS = function() return "MP" .. get_player_index() .. "_H3OPT_KEYLEVELS" end,
    MPX_H3OPT_BITSET0 = function() return "MP" .. get_player_index() .. "_H3OPT_BITSET0" end,
    MPX_H3OPT_BITSET1 = function() return "MP" .. get_player_index() .. "_H3OPT_BITSET1" end,
    MPX_H3_COMPLETEDPOSIX = function() return "MP" .. get_player_index() .. "_H3_COMPLETEDPOSIX" end,
    MPPLY_H3_COOLDOWN = "MPPLY_H3_COOLDOWN",
    
    -- Doomsday
    MPX_GANGOPS_FLOW_MISSION_PROG = function() return "MP" .. get_player_index() .. "_GANGOPS_FLOW_MISSION_PROG" end,
    MPX_GANGOPS_HEIST_STATUS = function() return "MP" .. get_player_index() .. "_GANGOPS_HEIST_STATUS" end,
    MPX_GANGOPS_FLOW_NOTIFICATIONS = function() return "MP" .. get_player_index() .. "_GANGOPS_FLOW_NOTIFICATIONS" end,
    
    -- Bunker
    MPX_PRODTOTALFORFACTORY5 = function() return "MP" .. get_player_index() .. "_PRODTOTALFORFACTORY5" end,
    
    -- Nightclub
    MPX_CLUB_POPULARITY = function() return "MP" .. get_player_index() .. "_CLUB_POPULARITY" end,
}

-- Wrapper para stats
local function get_stat_name(stat)
    if type(stat) == "function" then
        return stat()
    end
    return stat
end

-- ==================== FUNCIONES HELPER ====================
local Helper = {}

function Helper.SetInt(global_entry, value)
    if type(global_entry) == "table" and global_entry.global then
        if global_entry.type == "bool" then
            globals.set_bool(global_entry.global, value)
        else
            globals.set_int(global_entry.global, value)
        end
    else
        globals.set_int(global_entry, value)
    end
end

function Helper.GetInt(global_entry)
    if type(global_entry) == "table" and global_entry.global then
        if global_entry.type == "bool" then
            return globals.get_bool(global_entry.global) and 1 or 0
        end
        return globals.get_int(global_entry.global)
    end
    return globals.get_int(global_entry)
end

function Helper.SetStatInt(stat, value)
    stats.set_int(get_stat_name(stat), value)
end

function Helper.GetStatInt(stat)
    return stats.get_int(get_stat_name(stat))
end

function Helper.TeleportToXYZ(x, y, z)
    local player_ped = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(player_ped, x, y, z)
end

function Helper.IsScriptRunning(script_name)
    return script.is_active(script_name)
end

function Helper.ForceScriptHost(script_name)
    if script.is_active(script_name) then
        network.force_script_host(script_name)
    end
end

-- ==================== HEIST TOOL ====================
local HeistTool = {}

function HeistTool.SkipCutscene()
    native.call(0xD220BDDD8F874B8D) -- STOP_CUTSCENE_IMMEDIATELY
    notify("[Skip Cutscene] Cutscene skipped")
end

function HeistTool.InstantFinishApartment()
    if Helper.IsScriptRunning("fm_mission_controller") then
        -- Forzar script host
        Helper.ForceScriptHost("fm_mission_controller")
        sleep(1000)
        
        -- Locals para instant finish
        script.get_local("fm_mission_controller", 19746):set_int(12)
        script.get_local("fm_mission_controller", 19746 + 4):set_int(99999)
        script.get_local("fm_mission_controller", 19746 + 5):set_int(99999)
        script.get_local("fm_mission_controller", 19746 + 6):set_int(99999)
        
        notify("[Instant Finish] Apartment heist finished")
    else
        notify("No estás en un heist de Apartment")
    end
end

function HeistTool.InstantFinishCayo()
    if Helper.IsScriptRunning("fm_mission_controller_2020") then
        Helper.ForceScriptHost("fm_mission_controller_2020")
        sleep(1000)
        
        script.get_local("fm_mission_controller_2020", 48519):set_int(9)
        script.get_local("fm_mission_controller_2020", 48519 + 1):set_int(50)
        
        notify("[Instant Finish] Cayo Perico heist finished")
    else
        notify("No estás en Cayo Perico")
    end
end

function HeistTool.InstantFinishCasino()
    if Helper.IsScriptRunning("fm_mission_controller") then
        Helper.ForceScriptHost("fm_mission_controller")
        sleep(1000)
        
        local approach = Helper.GetStatInt(eStat.MPX_H3OPT_APPROACH)
        
        if approach == 3 then -- Aggressive
            script.get_local("fm_mission_controller", 1308):set_int(12)
        else
            script.get_local("fm_mission_controller", 1308):set_int(5)
        end
        
        script.get_local("fm_mission_controller", 1308 + 2):set_int(80)
        script.get_local("fm_mission_controller", 1308 + 4):set_int(10000000)
        script.get_local("fm_mission_controller", 1308 + 5):set_int(99999)
        script.get_local("fm_mission_controller", 1308 + 6):set_int(99999)
        
        notify("[Instant Finish] Diamond Casino heist finished")
    else
        notify("No estás en Diamond Casino")
    end
end

function HeistTool.InstantFinishDoomsday()
    if Helper.IsScriptRunning("fm_mission_controller") then
        Helper.ForceScriptHost("fm_mission_controller")
        sleep(1000)
        
        script.get_local("fm_mission_controller", 19746):set_int(12)
        script.get_local("fm_mission_controller", 19746 + 1):set_int(150)
        script.get_local("fm_mission_controller", 19746 + 2):set_int(99999)
        script.get_local("fm_mission_controller", 19746 + 3):set_int(99999)
        script.get_local("fm_mission_controller", 19746 + 4):set_int(80)
        
        notify("[Instant Finish] Doomsday heist finished")
    else
        notify("No estás en Doomsday")
    end
end

function HeistTool.ForceReadyApartment()
    Helper.SetInt(eGlobal.Heist.Apartment.Ready.Player1, 6)
    Helper.SetInt(eGlobal.Heist.Apartment.Ready.Player2, 6)
    Helper.SetInt(eGlobal.Heist.Apartment.Ready.Player3, 6)
    Helper.SetInt(eGlobal.Heist.Apartment.Ready.Player4, 6)
    notify("[Force Ready] Apartment - Everyone ready")
end

function HeistTool.ForceReadyCayo()
    Helper.SetInt(eGlobal.Heist.CayoPerico.Ready.Player1, 1)
    Helper.SetInt(eGlobal.Heist.CayoPerico.Ready.Player2, 1)
    Helper.SetInt(eGlobal.Heist.CayoPerico.Ready.Player3, 1)
    Helper.SetInt(eGlobal.Heist.CayoPerico.Ready.Player4, 1)
    notify("[Force Ready] Cayo Perico - Everyone ready")
end

function HeistTool.ForceReadyCasino()
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Ready.Player1, 1)
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Ready.Player2, 1)
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Ready.Player3, 1)
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Ready.Player4, 1)
    notify("[Force Ready] Casino - Everyone ready")
end

function HeistTool.ApplyCutsApartment(p1, p2, p3, p4)
    Helper.SetInt(eGlobal.Heist.Apartment.Cut.Player1, p1)
    Helper.SetInt(eGlobal.Heist.Apartment.Cut.Player2, p2)
    Helper.SetInt(eGlobal.Heist.Apartment.Cut.Player3, p3)
    Helper.SetInt(eGlobal.Heist.Apartment.Cut.Player4, p4)
    notify(F("[Apply Cuts] Apartment: P1:%d%% P2:%d%% P3:%d%% P4:%d%%", p1, p2, p3, p4))
end

function HeistTool.ApplyCutsCayo(p1, p2, p3, p4)
    Helper.SetInt(eGlobal.Heist.CayoPerico.Cut.Player1, p1)
    Helper.SetInt(eGlobal.Heist.CayoPerico.Cut.Player2, p2)
    Helper.SetInt(eGlobal.Heist.CayoPerico.Cut.Player3, p3)
    Helper.SetInt(eGlobal.Heist.CayoPerico.Cut.Player4, p4)
    notify(F("[Apply Cuts] Cayo: P1:%d%% P2:%d%% P3:%d%% P4:%d%%", p1, p2, p3, p4))
end

function HeistTool.ApplyCutsCasino(p1, p2, p3, p4)
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Cut.Player1, p1)
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Cut.Player2, p2)
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Cut.Player3, p3)
    Helper.SetInt(eGlobal.Heist.DiamondCasino.Cut.Player4, p4)
    notify(F("[Apply Cuts] Casino: P1:%d%% P2:%d%% P3:%d%% P4:%d%%", p1, p2, p3, p4))
end

function HeistTool.ApplyCutsDoomsday(p1, p2, p3, p4)
    Helper.SetInt(eGlobal.Heist.Doomsday.Cut.Player1, p1)
    Helper.SetInt(eGlobal.Heist.Doomsday.Cut.Player2, p2)
    Helper.SetInt(eGlobal.Heist.Doomsday.Cut.Player3, p3)
    Helper.SetInt(eGlobal.Heist.Doomsday.Cut.Player4, p4)
    notify(F("[Apply Cuts] Doomsday: P1:%d%% P2:%d%% P3:%d%% P4:%d%%", p1, p2, p3, p4))
end

function HeistTool.CompletePrepsCayo(difficulty, approach, loadout, target)
    Helper.SetStatInt(eStat.MPX_H4_PROGRESS, difficulty)
    Helper.SetStatInt(eStat.MPX_H4_MISSIONS, approach)
    Helper.SetStatInt(eStat.MPX_H4CNF_WEAPONS, loadout)
    Helper.SetStatInt(eStat.MPX_H4CNF_TARGET, target)
    Helper.SetStatInt(eStat.MPX_H4CNF_BS_GEN, -1)
    Helper.SetStatInt(eStat.MPX_H4CNF_BS_ENTR, 63)
    Helper.SetStatInt(eStat.MPX_H4CNF_BS_ABIL, 63)
    Helper.SetStatInt(eStat.MPX_H4CNF_APPROACH, -1)
    Helper.SetStatInt(eStat.MPX_H4_PLAYTHROUGH_STATUS, 10)
    
    notify("[Complete Preps] Cayo Perico preps completed")
end

function HeistTool.CompletePrepsCasino(difficulty, approach, gunman, driver, hacker, target, loadout, vehicles, masks, guards, keycards)
    Helper.SetStatInt(eStat.MPX_H3_LAST_APPROACH, 0)
    Helper.SetStatInt(eStat.MPX_H3_HARD_APPROACH, (difficulty == 0) and 0 or approach)
    Helper.SetStatInt(eStat.MPX_H3OPT_APPROACH, approach)
    Helper.SetStatInt(eStat.MPX_H3OPT_CREWWEAP, gunman)
    Helper.SetStatInt(eStat.MPX_H3OPT_WEAPS, loadout)
    Helper.SetStatInt(eStat.MPX_H3OPT_CREWDRIVER, driver)
    Helper.SetStatInt(eStat.MPX_H3OPT_VEHS, vehicles)
    Helper.SetStatInt(eStat.MPX_H3OPT_CREWHACKER, hacker)
    Helper.SetStatInt(eStat.MPX_H3OPT_TARGET, target)
    Helper.SetStatInt(eStat.MPX_H3OPT_MASKS, masks)
    Helper.SetStatInt(eStat.MPX_H3OPT_DISRUPTSHIP, guards)
    Helper.SetStatInt(eStat.MPX_H3OPT_KEYLEVELS, keycards)
    Helper.SetStatInt(eStat.MPX_H3OPT_BODYARMORLVL, -1)
    Helper.SetStatInt(eStat.MPX_H3OPT_BITSET0, -1)
    Helper.SetStatInt(eStat.MPX_H3OPT_BITSET1, -1)
    Helper.SetStatInt(eStat.MPX_H3OPT_COMPLETEDPOSIX, -1)
    
    notify("[Complete Preps] Diamond Casino preps completed")
end

function HeistTool.CompletePrepsDoomsday(act)
    local acts = {
        [1] = {503, -229383},
        [2] = {240, -229378},
        [3] = {16368, -229380}
    }
    
    Helper.SetStatInt(eStat.MPX_GANGOPS_FLOW_MISSION_PROG, acts[act][1])
    Helper.SetStatInt(eStat.MPX_GANGOPS_HEIST_STATUS, acts[act][2])
    Helper.SetStatInt(eStat.MPX_GANGOPS_FLOW_NOTIFICATIONS, 1557)
    
    notify("[Complete Preps] Doomsday Act " .. act .. " preps completed")
end

function HeistTool.KillCooldownCayo()
    Helper.SetStatInt(eStat.MPX_H4_TARGET_POSIX, 1659643454)
    Helper.SetStatInt(eStat.MPX_H4_COOLDOWN, 0)
    Helper.SetStatInt(eStat.MPX_H4_COOLDOWN_HARD, 0)
    notify("[Kill Cooldown] Cayo Perico cooldowns skipped")
end

function HeistTool.KillCooldownCasino()
    Helper.SetStatInt(eStat.MPX_H3_COMPLETEDPOSIX, -1)
    Helper.SetStatInt(eStat.MPPLY_H3_COOLDOWN, -1)
    notify("[Kill Cooldown] Casino cooldowns skipped")
end

function HeistTool.KillCooldownApartment()
    Helper.SetInt(eGlobal.Heist.Apartment.Cooldown.Step1, -1)
    Helper.SetInt(eGlobal.Heist.Apartment.Cooldown.Step2, 0)
    notify("[Kill Cooldown] Apartment cooldowns skipped")
end

-- ==================== BUSINESS TOOL ====================
local BusinessTool = {}

function BusinessTool.BunkerMaximizePrice()
    local total = Helper.GetStatInt(eStat.MPX_PRODTOTALFORFACTORY5)
    if total > 0 then
        local price = math.floor((2500000 / 1.5) / total)
        tunables.set_int("GR_SALE_VALUE_MULTIPLIER", price)
        tunables.set_int("GR_RESEARCH_VALUE_MULTIPLIER", 0)
        tunables.set_int("GR_STAFF_UPGRADE_VALUE_MULTIPLIER", 0)
        tunables.set_int("GR_EQUIPMENT_UPGRADE_VALUE_MULTIPLIER", 0)
        notify("[Maximize Price] Bunker price maximized")
    else
        notify("[Maximize Price] Get supplies first")
    end
end

function BusinessTool.BunkerResetPrice()
    tunables.set_int("GR_SALE_VALUE_MULTIPLIER", 1)
    tunables.set_int("GR_RESEARCH_VALUE_MULTIPLIER", 1)
    tunables.set_int("GR_STAFF_UPGRADE_VALUE_MULTIPLIER", 1)
    tunables.set_int("GR_EQUIPMENT_UPGRADE_VALUE_MULTIPLIER", 1)
    notify("[Maximize Price] Bunker price reset")
end

function BusinessTool.BunkerInstantSell()
    if Helper.IsScriptRunning("gb_gunrunning") then
        script.get_local("gb_gunrunning", 1945):set_int(0)
        notify("[Instant Sell] Bunker sell mission finished")
    else
        notify("No estás en una venta de Bunker")
    end
end

function BusinessTool.BunkerGetSupplies()
    Helper.SetInt(eGlobal.Business.Bunker.Production.Trigger1, 0)
    Helper.SetInt(eGlobal.Business.Bunker.Production.Trigger2, true)
    notify("[Get Supplies] Bunker supplies obtained")
end

function BusinessTool.HangarInstantSell()
    if Helper.IsScriptRunning("gb_smuggler") then
        local delivered = script.get_local("gb_smuggler", 1987):get_int()
        script.get_local("gb_smuggler", 1986):set_int(delivered)
        notify("[Instant Sell] Hangar sell mission finished")
    else
        notify("No estás en una venta de Hangar")
    end
end

function BusinessTool.NightclubMaxPopularity()
    Helper.SetStatInt(eStat.MPX_CLUB_POPULARITY, 100)
    notify("[Max Popularity] Nightclub popularity maximized")
end

function BusinessTool.NightclubCollectSafe()
    Helper.SetInt(eGlobal.Business.Nightclub.Safe.Collect, true)
    notify("[Collect Safe] Nightclub safe collected")
end

function BusinessTool.ArcadeCollectSafe()
    Helper.SetInt(eGlobal.Business.Arcade.Safe.Collect, true)
    notify("[Collect Safe] Arcade safe collected")
end

-- ==================== TELEPORTS ====================
local Teleports = {
    Apartment = {x = -781.656, y = 334.293, z = 187.859},
    Facility = {x = 489.062, y = -1303.906, z = 29.306},
    Bunker = {x = 2110.976, y = 3320.326, z = 45.361},
    Hangar = {x = -1267.071, y = -3380.069, z = 14.007},
    Nightclub = {x = -1569.532, y = -3016.619, z = -74.406},
    Arcade = {x = 2737.962, y = -374.760, z = -47.993},
    Kosatka = {x = 1561.224, y = -486.318, z = -62.226},
    Agency = {x = -1011.083, y = -480.368, z = 39.073},
    SalvageYard = {x = -1639.323, y = -181.432, z = 57.575},
    MazeBank = {x = -75.015, y = -818.215, z = 326.176},
    Casino = {x = 935.073, y = 46.635, z = 81.095},
}

-- ==================== MONEY TOOL ====================
local MoneyTool = {}

function MoneyTool.Loop300k()
    network.earn_from_betting(300000)
    notify("[300k Loop] +$300,000 added")
end

function MoneyTool.Loop680k()
    network.earn_from_betting(680000)
    notify("[680k Loop] +$680,000 added")
end

function MoneyTool.RemoveCash(amount)
    local current = stats.get_int("MP" .. get_player_index() .. "_WALLET_BALANCE")
    if current >= amount then
        network.buy_item(-amount)
        notify("[Remove Cash] $" .. amount .. " removed")
    end
end

-- ==================== GUI RENDER ====================
local cut_values = {
    apartment = {100, 100, 100, 100},
    cayo = {100, 0, 0, 0},
    casino = {100, 0, 0, 0},
    doomsday = {100, 0, 0, 0}
}

local cayo_preps = {
    difficulty = 0,
    approach = 0,
    loadout = 0,
    target = 0
}

local casino_preps = {
    difficulty = 0,
    approach = 0,
    gunman = 0,
    driver = 0,
    hacker = 0,
    target = 0,
    loadout = 0,
    vehicles = 0,
    masks = 0,
    guards = 0,
    keycards = 0
}

local function render_heist_tab()
    if ImGui.BeginTabItem("Heist Tool") then
        
        -- Apartment
        ImGui.Text("--- Apartment Heist ---")
        if ImGui.Button("Instant Finish##Apartment") then
            HeistTool.InstantFinishApartment()
        end
        ImGui.SameLine()
        if ImGui.Button("Force Ready##Apartment") then
            HeistTool.ForceReadyApartment()
        end
        ImGui.SameLine()
        if ImGui.Button("Kill Cooldown##Apartment") then
            HeistTool.KillCooldownApartment()
        end
        
        ImGui.Text("Cuts:")
        cut_values.apartment[1] = ImGui.InputInt("P1##Apartment", cut_values.apartment[1])
        cut_values.apartment[2] = ImGui.InputInt("P2##Apartment", cut_values.apartment[2])
        cut_values.apartment[3] = ImGui.InputInt("P3##Apartment", cut_values.apartment[3])
        cut_values.apartment[4] = ImGui.InputInt("P4##Apartment", cut_values.apartment[4])
        
        if ImGui.Button("Apply Cuts##Apartment") then
            HeistTool.ApplyCutsApartment(cut_values.apartment[1], cut_values.apartment[2], 
                                         cut_values.apartment[3], cut_values.apartment[4])
        end
        
        ImGui.Separator()
        
        -- Cayo Perico
        ImGui.Text("--- Cayo Perico ---")
        if ImGui.Button("Instant Finish##Cayo") then
            HeistTool.InstantFinishCayo()
        end
        ImGui.SameLine()
        if ImGui.Button("Force Ready##Cayo") then
            HeistTool.ForceReadyCayo()
        end
        ImGui.SameLine()
        if ImGui.Button("Kill Cooldown##Cayo") then
            HeistTool.KillCooldownCayo()
        end
        
        ImGui.Text("Preps:")
        cayo_preps.difficulty = ImGui.Combo("Difficulty", cayo_preps.difficulty, {"Normal", "Hard"}, 2)
        cayo_preps.approach = ImGui.Combo("Approach", cayo_preps.approach, {"Kosatka", "Alkonost", "Velum", "Stealth Annihilator", "Patrol Boat", "Longfin"}, 6)
        cayo_preps.loadout = ImGui.Combo("Loadout", cayo_preps.loadout, {"Aggressor", "Conspirator", "Crackshot", "Saboteur", "Marksman"}, 5)
        cayo_preps.target = ImGui.Combo("Target", cayo_preps.target, {"Sinsimito Tequila", "Ruby Necklace", "Bearer Bonds", "Pink Diamond", "Panther Statue"}, 5)
        
        if ImGui.Button("Complete Preps##Cayo") then
            HeistTool.CompletePrepsCayo(cayo_preps.difficulty, cayo_preps.approach, cayo_preps.loadout, cayo_preps.target)
        end
        
        ImGui.Text("Cuts:")
        cut_values.cayo[1] = ImGui.InputInt("P1##Cayo", cut_values.cayo[1])
        cut_values.cayo[2] = ImGui.InputInt("P2##Cayo", cut_values.cayo[2])
        cut_values.cayo[3] = ImGui.InputInt("P3##Cayo", cut_values.cayo[3])
        cut_values.cayo[4] = ImGui.InputInt("P4##Cayo", cut_values.cayo[4])
        
        if ImGui.Button("Apply Cuts##Cayo") then
            HeistTool.ApplyCutsCayo(cut_values.cayo[1], cut_values.cayo[2], 
                                   cut_values.cayo[3], cut_values.cayo[4])
        end
        
        ImGui.Separator()
        
        -- Diamond Casino
        ImGui.Text("--- Diamond Casino ---")
        if ImGui.Button("Instant Finish##Casino") then
            HeistTool.InstantFinishCasino()
        end
        ImGui.SameLine()
        if ImGui.Button("Force Ready##Casino") then
            HeistTool.ForceReadyCasino()
        end
        ImGui.SameLine()
        if ImGui.Button("Kill Cooldown##Casino") then
            HeistTool.KillCooldownCasino()
        end
        
        ImGui.Text("Preps:")
        casino_preps.difficulty = ImGui.Combo("Difficulty##Casino", casino_preps.difficulty, {"Normal", "Hard"}, 2)
        casino_preps.approach = ImGui.Combo("Approach##Casino", casino_preps.approach, {"Stealth", "Big Con", "Aggressive"}, 3)
        casino_preps.gunman = ImGui.Combo("Gunman", casino_preps.gunman, {"Karl Abolaji", "Gustavo Mota", "Charlie Reed", "Chester McCoy", "Patrick McReary"}, 5)
        casino_preps.driver = ImGui.Combo("Driver", casino_preps.driver, {"Karim Denz", "Taliana Martinez", "Eddie Toh", "Zach Nelson", "Chester McCoy"}, 5)
        casino_preps.hacker = ImGui.Combo("Hacker", casino_preps.hacker, {"Rickie Lukens", "Yohan Blair", "Christian Feltz", "Paige Harris", "Avi Schwartzman"}, 5)
        casino_preps.target = ImGui.Combo("Target##Casino", casino_preps.target, {"Cash", "Artwork", "Gold", "Diamonds"}, 4)
        
        if ImGui.Button("Complete Preps##Casino") then
            HeistTool.CompletePrepsCasino(casino_preps.difficulty, casino_preps.approach, casino_preps.gunman,
                                         casino_preps.driver, casino_preps.hacker, casino_preps.target, 0, 0, 0, 0, 0)
        end
        
        ImGui.Text("Cuts:")
        cut_values.casino[1] = ImGui.InputInt("P1##Casino", cut_values.casino[1])
        cut_values.casino[2] = ImGui.InputInt("P2##Casino", cut_values.casino[2])
        cut_values.casino[3] = ImGui.InputInt("P3##Casino", cut_values.casino[3])
        cut_values.casino[4] = ImGui.InputInt("P4##Casino", cut_values.casino[4])
        
        if ImGui.Button("Apply Cuts##Casino") then
            HeistTool.ApplyCutsCasino(cut_values.casino[1], cut_values.casino[2], 
                                     cut_values.casino[3], cut_values.casino[4])
        end
        
        ImGui.Separator()
        
        -- Doomsday
        ImGui.Text("--- Doomsday ---")
        if ImGui.Button("Instant Finish##Doomsday") then
            HeistTool.InstantFinishDoomsday()
        end
        
        local doomsday_act = ImGui.Combo("Act", 0, {"Act I", "Act II", "Act III"}, 3)
        if ImGui.Button("Complete Preps##Doomsday") then
            HeistTool.CompletePrepsDoomsday(doomsday_act + 1)
        end
        
        ImGui.Text("Cuts:")
        cut_values.doomsday[1] = ImGui.InputInt("P1##Doomsday", cut_values.doomsday[1])
        cut_values.doomsday[2] = ImGui.InputInt("P2##Doomsday", cut_values.doomsday[2])
        cut_values.doomsday[3] = ImGui.InputInt("P3##Doomsday", cut_values.doomsday[3])
        cut_values.doomsday[4] = ImGui.InputInt("P4##Doomsday", cut_values.doomsday[4])
        
        if ImGui.Button("Apply Cuts##Doomsday") then
            HeistTool.ApplyCutsDoomsday(cut_values.doomsday[1], cut_values.doomsday[2], 
                                       cut_values.doomsday[3], cut_values.doomsday[4])
        end
        
        ImGui.EndTabItem()
    end
end

local function render_business_tab()
    if ImGui.BeginTabItem("Business Tool") then
        
        ImGui.Text("--- Bunker ---")
        if ImGui.Button("Maximize Price##Bunker") then
            BusinessTool.BunkerMaximizePrice()
        end
        ImGui.SameLine()
        if ImGui.Button("Reset Price##Bunker") then
            BusinessTool.BunkerResetPrice()
        end
        ImGui.SameLine()
        if ImGui.Button("Instant Sell##Bunker") then
            BusinessTool.BunkerInstantSell()
        end
        if ImGui.Button("Get Supplies##Bunker") then
            BusinessTool.BunkerGetSupplies()
        end
        
        ImGui.Separator()
        
        ImGui.Text("--- Hangar ---")
        if ImGui.Button("Instant Sell##Hangar") then
            BusinessTool.HangarInstantSell()
        end
        
        ImGui.Separator()
        
        ImGui.Text("--- Nightclub ---")
        if ImGui.Button("Max Popularity##Nightclub") then
            BusinessTool.NightclubMaxPopularity()
        end
        ImGui.SameLine()
        if ImGui.Button("Collect Safe##Nightclub") then
            BusinessTool.NightclubCollectSafe()
        end
        
        ImGui.Separator()
        
        ImGui.Text("--- Arcade ---")
        if ImGui.Button("Collect Safe##Arcade") then
            BusinessTool.ArcadeCollectSafe()
        end
        
        ImGui.EndTabItem()
    end
end

local function render_money_tab()
    if ImGui.BeginTabItem("Money Tool") then
        
        ImGui.Text("--- Money Loops ---")
        if ImGui.Button("300k Loop") then
            MoneyTool.Loop300k()
        end
        ImGui.SameLine()
        if ImGui.Button("680k Loop") then
            MoneyTool.Loop680k()
        end
        
        ImGui.Separator()
        
        ImGui.Text("--- Remove Cash ---")
        local remove_amount = ImGui.InputInt("Amount", 1000000)
        if ImGui.Button("Remove Cash") then
            MoneyTool.RemoveCash(remove_amount)
        end
        
        ImGui.EndTabItem()
    end
end

local function render_teleport_tab()
    if ImGui.BeginTabItem("Teleports") then
        
        ImGui.Text("--- Properties ---")
        
        if ImGui.Button("Apartment") then
            Helper.TeleportToXYZ(U(Teleports.Apartment))
        end
        ImGui.SameLine()
        if ImGui.Button("Facility") then
            Helper.TeleportToXYZ(U(Teleports.Facility))
        end
        ImGui.SameLine()
        if ImGui.Button("Bunker") then
            Helper.TeleportToXYZ(U(Teleports.Bunker))
        end
        
        if ImGui.Button("Hangar") then
            Helper.TeleportToXYZ(U(Teleports.Hangar))
        end
        ImGui.SameLine()
        if ImGui.Button("Nightclub") then
            Helper.TeleportToXYZ(U(Teleports.Nightclub))
        end
        ImGui.SameLine()
        if ImGui.Button("Arcade") then
            Helper.TeleportToXYZ(U(Teleports.Arcade))
        end
        
        if ImGui.Button("Kosatka") then
            Helper.TeleportToXYZ(U(Teleports.Kosatka))
        end
        ImGui.SameLine()
        if ImGui.Button("Agency") then
            Helper.TeleportToXYZ(U(Teleports.Agency))
        end
        ImGui.SameLine()
        if ImGui.Button("Salvage Yard") then
            Helper.TeleportToXYZ(U(Teleports.SalvageYard))
        end
        
        if ImGui.Button("Maze Bank") then
            Helper.TeleportToXYZ(U(Teleports.MazeBank))
        end
        ImGui.SameLine()
        if ImGui.Button("Casino") then
            Helper.TeleportToXYZ(U(Teleports.Casino))
        end
        
        ImGui.EndTabItem()
    end
end

-- ==================== MAIN RENDER ====================
local function render_menu()
    if ImGui.Begin("SilentNight v" .. SilentNight.VERSION .. " - YimMenu Legacy") then
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

notify("SilentNight v" .. SilentNight.VERSION .. " loaded successfully!")

-- Loop principal
while true do
    sleep(1000)
end
