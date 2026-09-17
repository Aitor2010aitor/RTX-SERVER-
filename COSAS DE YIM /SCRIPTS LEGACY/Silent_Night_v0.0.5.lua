-- SilentNight.lua
local function notify(msg)
    gui.show_message("SilentNight", msg)
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

gui.add_tab("SilentNight", function()
    -- Header
    ImGui.Text("SilentNight Heist Tool")
    ImGui.Separator()
    
    -- Solo Missions
    local solo = false
    solo, _ = ImGui.Checkbox("Solo Missions", solo)
    
    ImGui.Separator()
    ImGui.Text("INSTANT FINISH:")
    
    -- Boton Instant Finish
    if ImGui.Button("INSTANT FINISH", 180, 35) then
        local mscript = GetMissionScript()
        if mscript then
            -- Limpiar globals
            for i = 0, 5 do
                globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
            end
            
            -- Aplicar finish segun script
            if mscript == "fm_mission_controller" then
                locals.set_int(mscript, 20870, 5)
                locals.set_int(mscript, 22041, 999999)
                set_bits(mscript, 19809, 9, 16)
            else
                locals.set_int(mscript, 57659, 5)
                locals.set_int(mscript, 58377, 999999)
                set_bits(mscript, 56071, 9, 16)
            end
            notify("INSTANT FINISH APLICADO!")
        else
            notify("No estas en un heist")
        end
    end
    
    ImGui.SameLine()
    
    -- Boton Skip Checkpoint
    if ImGui.Button("SKIP CHECKPOINT", 180, 35) then
        local mscript = GetMissionScript()
        if mscript then
            local bitset2 = (mscript == "fm_mission_controller") and 19810 or 56072
            set_bits(mscript, bitset2, 17)
            notify("Skip Checkpoint aplicado")
        else
            notify("No estas en un heist")
        end
    end
    
    ImGui.Separator()
    ImGui.Text("CORTES:")
    
    -- Cortes
    local p1 = 100
    p1 = ImGui.InputInt("P1 %", p1)
    
    if ImGui.Button("APARTMENT", 120, 30) then
        globals.set_int(1935536 + 2, p1)
        globals.set_int(1935536 + 3, 0)
        globals.set_int(1935536 + 4, 0)
        globals.set_int(1935536 + 5, 0)
        notify("Cuts aplicados")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("CAYO", 120, 30) then
        globals.set_int(1978756 + 888, p1)
        globals.set_int(1978756 + 889, 0)
        globals.set_int(1978756 + 890, 0)
        globals.set_int(1978756 + 891, 0)
        notify("Cuts aplicados")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("CASINO", 120, 30) then
        globals.set_int(1971952 + 2326, p1)
        globals.set_int(1971952 + 2327, 0)
        globals.set_int(1971952 + 2328, 0)
        globals.set_int(1971952 + 2329, 0)
        notify("Cuts aplicados")
    end
    
    ImGui.Separator()
    ImGui.Text("TELEPORTS:")
    
    if ImGui.Button("KOSATKA", 100, 30) then
        local ped = player.get_player_ped(player.player_id())
        entity.set_entity_coords_no_offset(ped, 1561.224, -486.318, -62.226)
        notify("Teletransportado")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("ARCADE", 100, 30) then
        local ped = player.get_player_ped(player.player_id())
        entity.set_entity_coords_no_offset(ped, 2737.962, -374.760, -47.993)
        notify("Teletransportado")
    end
    
    ImGui.SameLine()
    
    if ImGui.Button("BUNKER", 100, 30) then
        local ped = player.get_player_ped(player.player_id())
        entity.set_entity_coords_no_offset(ped, 2110.976, 3320.326, 45.361)
        notify("Teletransportado")
    end
end)

notify("SilentNight cargado!")
