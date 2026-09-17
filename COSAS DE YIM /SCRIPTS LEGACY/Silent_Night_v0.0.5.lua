-- SilentNight_MINIMO.lua - Prueba esta primero
local SilentNight = gui.add_tab("SilentNight")

SilentNight:add_imgui(function()
    
    -- Texto simple
    ImGui.Text("SilentNight - Test")
    ImGui.Separator()
    
    -- Checkbox
    local solo = false
    solo, _ = ImGui.Checkbox("Solo Missions", solo)
    
    -- BOTON 1
    if ImGui.Button("INSTANT FINISH", 200, 40) then
        gui.show_message("SilentNight", "Boton Instant Finish funciona!")
        
        -- Logica de SoloMissions
        local mscript = nil
        if script.is_active("fm_mission_controller") then
            mscript = "fm_mission_controller"
        elseif script.is_active("fm_mission_controller_2020") then
            mscript = "fm_mission_controller_2020"
        end
        
        if mscript then
            -- Limpiar
            for i = 0, 5 do
                globals.set_string(4718592 + 133252 + 1 + i * 6, "", 0)
            end
            
            -- Locals
            local nextMission = (mscript == "fm_mission_controller") and 20870 or 57659
            local teamScore = (mscript == "fm_mission_controller") and 22041 or 58377
            local serverBitSet = (mscript == "fm_mission_controller") and 19809 or 56071
            
            locals.set_int(mscript, nextMission, 5)
            locals.set_int(mscript, teamScore, 999999)
            
            -- Set bits
            local value = locals.get_int(mscript, serverBitSet)
            value = value | (1 << 9) | (1 << 16)
            locals.set_int(mscript, serverBitSet, value)
            
            gui.show_message("SilentNight", "INSTANT FINISH APLICADO!")
        else
            gui.show_message("SilentNight", "No estas en un heist!")
        end
    end
    
    -- BOTON 2
    if ImGui.Button("SKIP CHECKPOINT", 200, 40) then
        gui.show_message("SilentNight", "Boton Skip Checkpoint funciona!")
        
        local mscript = nil
        if script.is_active("fm_mission_controller") then
            mscript = "fm_mission_controller"
        elseif script.is_active("fm_mission_controller_2020") then
            mscript = "fm_mission_controller_2020"
        end
        
        if mscript then
            local serverBitSet2 = (mscript == "fm_mission_controller") and 19810 or 56072
            local value = locals.get_int(mscript, serverBitSet2)
            value = value | (1 << 17)
            locals.set_int(mscript, serverBitSet2, value)
            gui.show_message("SilentNight", "Skip Checkpoint aplicado!")
        else
            gui.show_message("SilentNight", "No estas en un heist!")
        end
    end
    
    -- BOTON 3
    if ImGui.Button("TEST - Hola", 200, 40) then
        gui.show_message("SilentNight", "Si ves esto, los botones funcionan!")
    end
    
end)

gui.show_message("SilentNight", "Script cargado! Mira la pestaña SilentNight")
