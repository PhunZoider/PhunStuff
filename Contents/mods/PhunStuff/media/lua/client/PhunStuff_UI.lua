local repeatAfterMe = ""

local oldRemoteZUILoadSavedParemeters = nil;

local function TweakRDC_Z_UIButtonLocation()
    if RDC_Z_UI then
        oldRemoteZUILoadSavedParemeters = RDC_Z_UI.loadSavedParameters;
        RDC_Z_UI.loadSavedParameters = function()
            local params = oldRemoteZUILoadSavedParemeters();
            repeatAfterMe = "RDC_Z_UI.loadSavedParameters() called " .. params["zToggleButton"].x .. " " ..
                                params["zToggleButton"].y .. " " .. params["zInstance"].x .. " " ..
                                params["zInstance"].y .. ". "

            if params["zToggleButton"].x == 400 and params["zToggleButton"].y == 400 then
                repeatAfterMe = repeatAfterMe .. "zToggle Button is at 400,400. "
                params["zToggleButton"].x = 10;
                params["zToggleButton"].y = 600;
            end

            return params
        end
    end

    local oldMyClothingLoadSavedParameters = nil;
    if myClothingUI then
        oldMyClothingLoadSavedParameters = myClothingUI.loadSavedParameters;
        myClothingUI.loadSavedParameters = function()
            local params = oldMyClothingLoadSavedParameters();
            if params["toggleButton"].x == 500 and params["toggleButton"].y == 500 then
                params["toggleButton"].x = 10;
                params["toggleButton"].y = 550;
            end
            return params
        end

    end
end

Events.OnInitGlobalModData.Add(function()
    TweakRDC_Z_UIButtonLocation()
end)
