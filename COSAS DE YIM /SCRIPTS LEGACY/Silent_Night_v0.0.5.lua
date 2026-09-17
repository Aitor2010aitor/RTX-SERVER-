-- SilentNight - Botones separados para cada heist
local SilentNight = gui.add_tab("SilentNight")

SilentNight:add_imgui(function()
    
    if not network.is_session_started() then
        ImGui.TextColored(1, 0, 0, 1, "SOLO ONLINE")
        return
    end
    
    ImGui.Text("SilentNight - Instant Finish por Heist")
    ImGui.Separator()
    
    -- ==========================================
    -- APARTMENT HEIST
    -- ==========================================
    ImGui.TextColored(0, 1, 1, 1, "APARTMENT HEIST")
    
    if ImGui.Button("INSTANT FINISH APARTMENT", 220, 35) then
        -- Verificar si está en el heist correcto
        if not script.is_active("fm_mission_controller") then
            gui.show_message("SilentNight", "No estas en Apartment Heist!")
            return
        end
        
        -- Método SoloMissions para fm_mission_controller
        for i = 0, 5 do
            globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
        end
        
        -- Locals específicos de Apartment
        locals.set_int("fm_mission_controller", 20870, 5)      -- nextMission
        locals.set_int("fm_mission_controller", 22041, 999999) -- teamScore
        
        -- Set bits 9 y 16
        local val = locals.get_int("fm_mission_controller", 19809)
        locals.set_int("fm_mission_controller", 19809, val | (1<<9) | (1<<16))
        
        gui.show_message("SilentNight", "Apartment Heist terminado!")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("FORCE READY APT", 150, 35) then
        globals.set_int(2658291 + 1 + (0 * 468) + 270, 6)
        globals.set_int(2658291 + 1 + (1 * 468) + 270, 6)
        globals.set_int(2658291 + 1 + (2 * 468) + 270, 6)
        globals.set_int(2658291 + 1 + (3 * 468) + 270, 6)
        gui.show_message("SilentNight", "Force Ready Apartment!")
    end
    
    -- Cortes Apartment
    local apt_p1 = 100
    apt_p1 = ImGui.InputInt("Cut P1##Apt", apt_p1)
    if ImGui.Button("APLICAR CUTS APT", 180, 25) then
        globals.set_int(1935536 + 2, apt_p1)
        globals.set_int(1935536 + 3, 0)
        globals.set_int(1935536 + 4, 0)
        globals.set_int(1935536 + 5, 0)
        gui.show_message("SilentNight", "Cuts Apartment aplicados!")
    end
    
    ImGui.Separator()
    
    -- ==========================================
    -- CAYO PERICO
    -- ==========================================
    ImGui.TextColored(0, 1, 0, 1, "CAYO PERICO")
    
    if ImGui.Button("INSTANT FINISH CAYO", 220, 35) then
        -- Verificar si está en Cayo
        if not script.is_active("fm_mission_controller_2020") then
            gui.show_message("SilentNight", "No estas en Cayo Perico!")
            return
        end
        
        -- Método SoloMissions para fm_mission_controller_2020 (Cayo)
        for i = 0, 5 do
            globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
        end
        
        -- Locals específicos de Cayo
        locals.set_int("fm_mission_controller_2020", 57659, 5)      -- nextMission
        locals.set_int("fm_mission_controller_2020", 58377, 999999) -- teamScore
        
        -- Set bits 9 y 16
        local val = locals.get_int("fm_mission_controller_2020", 56071)
        locals.set_int("fm_mission_controller_2020", 56071, val | (1<<9) | (1<<16))
        
        gui.show_message("SilentNight", "Cayo Perico terminado!")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("FORCE READY CAYO", 150, 35) then
        globals.set_int(1979868 + 1 + (0 * 27) + 7 + 1, 1)
        globals.set_int(1979868 + 1 + (1 * 27) + 7 + 2, 1)
        globals.set_int(1979868 + 1 + (2 * 27) + 7 + 3, 1)
        globals.set_int(1979868 + 1 + (3 * 27) + 7 + 4, 1)
        gui.show_message("SilentNight", "Force Ready Cayo!")
    end
    
    -- Preps Cayo
    if ImGui.Button("PANTHER + PREPS", 150, 30) then
        local MPX = "MP" .. network.get_local_player_index() .. "_"
        stats.set_int(MPX .. "H4_PROGRESS", 1)           -- Hard
        stats.set_int(MPX .. "H4_MISSIONS", 0)           -- Kosatka
        stats.set_int(MPX .. "H4CNF_WEAPONS", 1)         -- Conspirator
        stats.set_int(MPX .. "H4CNF_TARGET", 4)          -- PANTHER!
        stats.set_int(MPX .. "H4CNF_BS_GEN", -1)
        stats.set_int(MPX .. "H4CNF_BS_ENTR", 63)
        stats.set_int(MPX .. "H4CNF_BS_ABIL", 63)
        stats.set_int(MPX .. "H4CNF_APPROACH", -1)
        gui.show_message("SilentNight", "Pantera lista!")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("KILL CD CAYO", 120, 30) then
        local MPX = "MP" .. network.get_local_player_index() .. "_"
        stats.set_int(MPX .. "H4_TARGET_POSIX", 1659643454)
        stats.set_int(MPX .. "H4_COOLDOWN", 0)
        stats.set_int(MPX .. "H4_COOLDOWN_HARD", 0)
        gui.show_message("SilentNight", "Cooldown Cayo eliminado!")
    end
    
    -- Cortes Cayo
    local cayo_p1 = 100
    cayo_p1 = ImGui.InputInt("Cut P1##Cayo", cayo_p1)
    if ImGui.Button("APLICAR CUTS CAYO", 180, 25) then
        globals.set_int(1978756 + 888, cayo_p1)
        globals.set_int(1978756 + 889, 0)
        globals.set_int(1978756 + 890, 0)
        globals.set_int(1978756 + 891, 0)
        gui.show_message("SilentNight", "Cuts Cayo aplicados!")
    end
    
    ImGui.Separator()
    
    -- ==========================================
    -- DIAMOND CASINO
    -- ==========================================
    ImGui.TextColored(1, 0, 1, 1, "DIAMOND CASINO")
    
    if ImGui.Button("INSTANT FINISH CASINO", 220, 35) then
        -- Casino usa fm_mission_controller también
        if not script.is_active("fm_mission_controller") then
            gui.show_message("SilentNight", "No estas en Casino Heist!")
            return
        end
        
        -- Método SoloMissions
        for i = 0, 5 do
            globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
        end
        
        -- Locals de Casino (mismos que Apartment pero con lógica diferente)
        locals.set_int("fm_mission_controller", 20870, 5)
        locals.set_int("fm_mission_controller", 22041, 999999)
        
        local val = locals.get_int("fm_mission_controller", 19809)
        locals.set_int("fm_mission_controller", 19809, val | (1<<9) | (1<<16))
        
        gui.show_message("SilentNight", "Casino Heist terminado!")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("FORCE READY CASINO", 150, 35) then
        globals.set_int(1976315 + 1 + (0 * 68) + 7 + 1, 1)
        globals.set_int(1976315 + 1 + (1 * 68) + 7 + 2, 1)
        globals.set_int(1976315 + 1 + (2 * 68) + 7 + 3, 1)
        globals.set_int(1976315 + 1 + (3 * 68) + 7 + 4, 1)
        gui.show_message("SilentNight", "Force Ready Casino!")
    end
    
    -- Preps Casino
    if ImGui.Button("DIAMONDS + PREPS", 150, 30) then
        local MPX = "MP" .. network.get_local_player_index() .. "_"
        stats.set_int(MPX .. "H3OPT_APPROACH", 1)
        stats.set_int(MPX .. "H3OPT_TARGET", 3)      -- DIAMONDS!
        stats.set_int(MPX .. "H3OPT_BITSET0", -1)
        stats.set_int(MPX .. "H3OPT_BITSET1", -1)
        gui.show_message("SilentNight", "Diamantes listos!")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("KILL CD CASINO", 120, 30) then
        local MPX = "MP" .. network.get_local_player_index() .. "_"
        stats.set_int(MPX .. "H3_COMPLETEDPOSIX", -1)
        stats.set_int("MPPLY_H3_COOLDOWN", -1)
        gui.show_message("SilentNight", "Cooldown Casino eliminado!")
    end
    
    -- Cortes Casino
    local casino_p1 = 100
    casino_p1 = ImGui.InputInt("Cut P1##Casino", casino_p1)
    if ImGui.Button("APLICAR CUTS CASINO", 180, 25) then
        globals.set_int(1971952 + 2326, casino_p1)
        globals.set_int(1971952 + 2327, 0)
        globals.set_int(1971952 + 2328, 0)
        globals.set_int(1971952 + 2329, 0)
        gui.show_message("SilentNight", "Cuts Casino aplicados!")
    end
    
    ImGui.Separator()
    
    -- ==========================================
    -- DOOMSDAY
    -- ==========================================
    ImGui.TextColored(1, 1, 0, 1, "DOOMSDAY")
    
    if ImGui.Button("INSTANT FINISH DOOMSDAY", 220, 35) then
        -- Doomsday usa fm_mission_controller
        if not script.is_active("fm_mission_controller") then
            gui.show_message("SilentNight", "No estas en Doomsday!")
            return
        end
        
        -- Método SoloMissions
        for i = 0, 5 do
            globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
        end
        
        locals.set_int("fm_mission_controller", 20870, 5)
        locals.set_int("fm_mission_controller", 22041, 999999)
        
        local val = locals.get_int("fm_mission_controller", 19809)
        locals.set_int("fm_mission_controller", 19809, val | (1<<9) | (1<<16))
        
        gui.show_message("SilentNight", "Doomsday terminado!")
    end
    
    -- Preps Doomsday
    local doomsday_act = 0
    doomsday_act = ImGui.Combo("Acto", doomsday_act, {"Act I", "Act II", "Act III"}, 3)
    
    if ImGui.Button("COMPLETAR PREPS DOOMSDAY", 220, 30) then
        local MPX = "MP" .. network.get_local_player_index() .. "_"
        local acts = {[0]={503, -229383}, [1]={240, -229378}, [2]={16368, -229380}}
        stats.set_int(MPX .. "GANGOPS_FLOW_MISSION_PROG", acts[doomsday_act][1])
        stats.set_int(MPX .. "GANGOPS_HEIST_STATUS", acts[doomsday_act][2])
        stats.set_int(MPX .. "GANGOPS_FLOW_NOTIFICATIONS", 1557)
        gui.show_message("SilentNight", "Preps Doomsday Act " .. (doomsday_act + 1) .. " completados!")
    end
    
    -- Cortes Doomsday
    local doom_p1 = 100
    doom_p1 = ImGui.InputInt("Cut P1##Doom", doom_p1)
    if ImGui.Button("APLICAR CUTS DOOMSDAY", 180, 25) then
        globals.set_int(1967983 + 863, doom_p1)
        globals.set_int(1967983 + 864, 0)
        globals.set_int(1967983 + 865, 0)
        globals.set_int(1967983 + 866, 0)
        gui.show_message("SilentNight", "Cuts Doomsday aplicados!")
    end
    
    ImGui.Separator()
    
    -- ==========================================
    -- SKIP CHECKPOINT (Universal)
    -- ==========================================
    ImGui.TextColored(1, 0.5, 0, 1, "UTILIDADES")
    
    if ImGui.Button("SKIP CHECKPOINT (Universal)", 250, 40) then
        local mscript = nil
        if script.is_active("fm_mission_controller") then
            mscript = "fm_mission_controller"
        elseif script.is_active("fm_mission_controller_2020") then
            mscript = "fm_mission_controller_2020"
        end
        
        if mscript then
            local sb2 = (mscript == "fm_mission_controller") and 19810 or 56072
            local val = locals.get_int(mscript, sb2)
            locals.set_int(mscript, sb2, val | (1<<17))
            gui.show_message("SilentNight", "Skip Checkpoint aplicado!")
        else
            gui.show_message("SilentNight", "No estas en un heist!")
        end
    end
    
    ImGui.Separator()
    
    -- ==========================================
    -- TELEPORTS
    -- ==========================================
    ImGui.Text("TELEPORTS")
    
    if ImGui.Button("KOSATKA", 90, 25) then
        entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), 1561.224, -486.318, -62.226)
    end
    ImGui.SameLine()
    if ImGui.Button("ARCADE", 90, 25) then
        entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), 2737.962, -374.760, -47.993)
    end
    ImGui.SameLine()
    if ImGui.Button("BUNKER", 90, 25) then
        entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), 2110.976, 3320.326, 45.361)
    end
    ImGui.SameLine()
    if ImGui.Button("FACILITY", 90, 25) then
        entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), 489.062, -1303.906, 29.306)
    end
    
end)

gui.show_message("SilentNight", "Script cargado! Botones por heist listos!")
