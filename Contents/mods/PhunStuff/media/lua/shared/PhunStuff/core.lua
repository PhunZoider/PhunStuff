PhunStuff = {
    name = "PhunStuff",
    inied = false,
    commands = {
        onStart = "PhunStuffOnStart",
        refillContainer = "PhunStuffRefillContainer",
        daytimeStart = "PhunStuffDaytimeStart",
        nightTimeStart = "PhunStuffNightTimeStart"
    },
    recipeOverrides = {},
    events = {
        OnPhunNight = "OnPhunNight",
        OnPhunDay = "OnPhunDay"
    },
    itemOverrides = {
        ["FunctionalAppliances.FABubBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FABubLiteBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FASwillerBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FASwillerLiteBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FAHomeBrewBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["SapphCooking.Vermouth"] = {
            DisplayCategory = "FoodA"
        },
        ["SapphCooking.LiqueurBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["SapphCooking.CachacaFull"] = {
            DisplayCategory = "FoodA"
        },
        ["SOMW.Kukri"] = {
            DisplayCategory = "WepMelee"
        },
        ["SOMW.CombatKnife"] = {
            DisplayCategory = "WepMelee"
        },
        ["SOMW.LongLeadPipe"] = {
            DisplayCategory = "WepMelee"
        }
    }
}

local Core = PhunStuff
Core.settings = SandboxVars[Core.name] or {}

for _, event in pairs(Core.events or {}) do
    if not Events[event] then
        LuaEventManager.AddEvent(event)
    end
end

function Core:ini()
    if not self.inied then
        self.inied = true
        self.data = ModData.getOrCreate(self.name)
        if isClient() then
            sendClientCommand(self.name, self.commands.onStart, {})
        end
    end
end

function Core:debug(...)

    local args = {...}
    for i, v in ipairs(args) do
        if type(v) == "table" then
            self:printTable(v)
        else
            print(tostring(v))
        end
    end

end

function Core:printTable(t, indent)
    indent = indent or ""
    for key, value in pairs(t or {}) do
        if type(value) == "table" then
            print(indent .. key .. ":")
            Core:printTable(value, indent .. "  ")
        elseif type(value) ~= "function" then
            print(indent .. key .. ": " .. tostring(value))
        end
    end
end

function Core:say(message, player, r, g, b, a)
    if not player then
        player = getPlayer();
    end

    player:setHaloNote(message, r or 255, g or 255, b or 0, a or 300);

end

print('- -- -- EVENTS! --  - ')
local e = {}
for k, v in pairs(Events) do
    table.insert(e, k)
end
table.sort(e, function(a, b)
    return a < b
end)
Core:printTable(e)
print(" /-------")
