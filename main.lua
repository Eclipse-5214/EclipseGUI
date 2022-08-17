local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("EclipseGUI", "DarkTheme")

local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("MainSection")

MainSection:NewLabel("Created By Eclipse5214")

MainSection:NewKeybind("Toggle UI", "Toggles the UI", Enum.KeyCode.RightShift, function()
    Library:ToggleUI()
end)

MainSection:NewButton("Anti Afk", "no kicks", function()
    MainSection:UpdateSection("Sucsess")
    wait(1)
    print("Anti Afk Loaded")
    local GC = getconnections or get_signal_cons
    if GC then
        for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
            if v["Disable"] then
                v["Disable"](v)
            elseif v["Disconnect"] then
                v["Disconnect"](v)
            end
        end
    else
        print("lol bad exploit")
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end

    local VirtualUser=game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    end)
end)

--Petsim--

    local players = game:GetService("Players")
    local client = players.LocalPlayer

    local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
    local Network = GameLibrary.Network

    local Library = require(game:GetService("ReplicatedStorage").Framework.Library)
    local IDToName = {}
    local NameToID = {}
    for i,v in pairs(Library.Directory.Pets ) do
        IDToName[i] = v.name
        NameToID[v.name] = i
    end

    workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "claim orbs")

    local runService = game:GetService("RunService")

    local areas = {
    --Misc
    ['VIP'] = {'VIP'};
    --Spawn
    ['Town'] = {'Town', 'Town FRONT'}; ['Forest'] = {'Forest', 'Forest FRONT'}; ['Beach'] = {'Beach', 'Beach FRONT'}; ['Mine'] = {'Mine', 'Mine FRONT'}; ['Winter'] = {'Winter', 'Winter FRONT'}; ['Glacier'] = {'Glacier', 'Glacier Lake'}; ['Desert'] = {'Desert', 'Desert FRONT'}; ['Volcano'] = {'Volcano', 'Volcano FRONT'};
    -- Fantasy init
    ['Enchanted Forest'] = {'Enchanted Forest', 'Enchanted Forest FRONT'}; ['Ancient'] = {'Ancient Island'}; ['Samurai'] = {'Samurai Island', 'Samurai Island FRONT'}; ['Candy'] = {'Candy Island'}; ['Haunted'] = {'Haunted Island', 'Haunted Island FRONT'}; ['Hell'] = {'Hell Island'}; ['Heaven'] = {'Heaven Island'};
    -- Tech
    ['Ice Tech'] = {'Ice Tech'}; ['Tech City'] = {'Tech City'; 'Tech City FRONT'}; ['Dark Tech'] = {'Dark Tech'; 'Dark Tech FRONT'}; ['Steampunk'] = {'Steampunk'; 'Steampunk FRONT'}, ['Alien Forest'] = {"Alien Forest"; "Alien Forest FRONT"}, ['Alien Lab'] = {"Alien Forest"; "Alien Lab FRONT"}, ['Glitch'] = {"Glitch"; "Glitch FRONT"}; ['Hacker Portal'] = {"Hacker Portal", "Hacker Portal FRONT"};
    -- Axolotl
    ['Axolotl Ocean'] = {'Axolotl Ocean', 'Axolotl Ocean FRONT'}; ['Axolotl Deep Ocean'] = {'Axolotl Deep Ocean', 'Axolotl Deep Ocean FRONT'}; ['Axolotl Cave'] = {'Axolotl Cave', 'Axolotl Cave FRONT'};
    -- Minecraft
    ['Pixel Forest'] = {'Pixel Forest', 'Pixel Forest FRONT'}; ['Pixel Kyoto'] = {'Pixel Kyoto', 'Pixel Kyoto FRONT'}; ['Pixel Alps'] = {'Pixel Alps', 'Pixel Alps FRONT'} ; ['Pixel Vault'] = {'Pixel Vault', 'Pixel Vault FRONT'};
    }


    local areaList = {
        'VIP';
        'Town'; 'Forest'; 'Beach'; 'Mine'; 'Winter'; 'Glacier'; 'Desert'; 'Volcano';
        'Enchanted Forest'; 'Ancient'; 'Samurai'; 'Candy'; 'Haunted'; 'Hell'; 'Heaven';
        'Ice Tech'; 'Tech City'; 'Dark Tech'; 'Steampunk'; 'Alien Lab'; 'Alien Forest'; 'Glitch'; "Hacker Portal";
        'Axolotl Ocean'; 'Axolotl Deep Ocean'; 'Axolotl Cave';
        'Pixel Forest'; 'Pixel Kyoto'; 'Pixel Alps'; 'Pixel Vault';
    }

    local flags = {}
    function flags:SetFlag(name, value)
        flags[name] = value
    end

    -- // Pet Simualtor Functions
    --#region Pet Simualtor Functions
    -- local area = flags.autoFarmArea

    local pathToScript = game.Players.LocalPlayer.PlayerScripts.Scripts.Game['Open Eggs']
    local oldFunc = getsenv(pathToScript).OpenEgg

    local PetSim = {}

    function PetSim:FarmCoin(coinId, petId)
        game.workspace["__THINGS"]["__REMOTES"]["join coin"]:InvokeServer({[1] = coinId, [2] = {[1] = petId}})
        game.workspace["__THINGS"]["__REMOTES"]["farm coin"]:FireServer({[1] = coinId, [2] = petId})
    end

    function PetSim:LeaveCoin(coinId, petId)
        local ohTable1 = {
            [1] = coinId,
            [2] = {
                [1] = petId
            }
        }

        workspace.__THINGS.__REMOTES["leave coin"]:InvokeServer(ohTable1)
    end

    function PetSim:GetPetIds()
        local returntable = {}
        for i,v in pairs(GameLibrary.Save.Get().Pets) do
            if v.e then 
                table.insert(returntable, v.uid)
            end
        end
        return returntable
    end
    

    function PetSim:GetAllCoinsInArea(area)
        local ret = {}
        local ListCoins = game.workspace["__THINGS"]["__REMOTES"]["get coins"]:InvokeServer({})[1]
        for i, v in pairs(ListCoins) do
            if table.find(areas[flags.autoFarmArea], v.a) then
                local val = v
                val["id"] = i
                table.insert(ret, val)
            end
        end
        return ret
    end

    function PetSim:GetSmallestCoinTable(area)
        local coins = PetSim:GetAllCoinsInArea(area)
        function getKeys(tbl, func)
            local keys = {}
            for key in pairs(tbl) do
                table.insert(keys, key)
            end
            table.sort(
                keys,
                function(a, b)
                    return func(tbl[a].h, tbl[b].h)
                end
            )
            return keys
        end
        local sorted =
            getKeys(
            coins,
            function(a, b)
                return a < b
            end
        )
        local ret = {}

        for _, v in pairs(sorted) do
            table.insert(ret, coins[v])
        end

        return ret
    end

    function PetSim:GetHighestCoinTable(area)
        local coins = PetSim:GetAllCoinsInArea(area)
        function getKeys(tbl, func)
            local keys = {}
            for key in pairs(tbl) do
                table.insert(keys, key)
            end
            table.sort(
                keys,
                function(a, b)
                    return func(tbl[a].h, tbl[b].h)
                end
            )
            return keys
        end
        local sorted =
            getKeys(
            coins,
            function(a, b)
                return a > b
            end
        )
        local ret = {}

        for _, v in pairs(sorted) do
            table.insert(ret, coins[v])
        end

        return ret
    end

    function PetSim:GetAllEggs()
        local toReturn = {}
        local toReturnKeys = {}

        local eggsFolder = game:GetService("ReplicatedStorage").Game.Eggs

        for _, v in pairs(eggsFolder:GetDescendants()) do
            if v:IsA("ModuleScript") then
                local module = require(v)
                if module.hatchable and not module.disabled then
                    local displayNameOrModuleName = module.displayName or v.Name

                    toReturn[displayNameOrModuleName] = displayNameOrModuleName
                    table.insert(toReturnKeys, displayNameOrModuleName)
                end
            end
        end
        return toReturn, toReturnKeys
    end
    --#endregion PetSimFunctions

    -- // Pet Sim Variables
    local petIds = PetSim:GetPetIds()
    local eggs, eggList = PetSim:GetAllEggs()

    local currentCoinId = nil

    -- // UI Library

    --misc--
    
    local Misc = Window:NewTab("Misc")
    local MiscSection = Misc:NewSection("MiscSection")

    MiscSection:NewToggle("Auto Claim Gifts", "Auto claims gifts", function(state)
        if state then
            local args = {
                [1] = {
                    [1] = 1
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 2
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 3
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 4
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 5
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 6
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 7
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 8
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 9
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 10
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 11
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            local args = {
                [1] = {
                    [1] = 12
                }
            }
            
            workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer(unpack(args))
            wait(0)    
        end
    end)

    MiscSection:NewButton("Show Hidden Pet Chance (synapse x only)", "Shows hidden pet chance", function()
        workspace.__MAP.Eggs.DescendantAdded:Connect(function(a)
            if a.Name == 'EggInfo' then
                for i,v in pairs(a.Frame.Pets:GetChildren()) do
                    if v:IsA('Frame') and v.Thumbnail.Chance.Text == '??' then
                        local pet
                        for _,tbl in pairs(getgc(true)) do
                            if (typeof(tbl) == 'table' and rawget(tbl, 'thumbnail')) then
                                if tbl.thumbnail == v.Thumbnail.Image then
                                    pet = string.split(tostring(tbl.model.Parent), ' - ')[1]
                                end
                            end
                        end
                        for _,egg in pairs(game.ReplicatedStorage.Game.Eggs:GetDescendants()) do
                            if egg:IsA('ModuleScript') and typeof(require(egg).drops) == 'table' then
                                for _,drop in pairs(require(egg).drops) do
                                    if pet == '266' then v.Thumbnail.Chance.Text = '0.000002%' return end
                                    if drop[1] == pet then
                                        v.Thumbnail.Chance.Text = drop[2] .. '%'
                                    end
                                end
                            end
                        end
                    end
                end
            end
         end)
         
         local lib = require(game.ReplicatedStorage.Framework.Library)
         table.foreach(lib.Save.Get(), print)
         
         local oldworld = lib.Save.Get().World
         while wait(0.1) do
            if lib.Save.Get().World ~= oldworld then
                oldworld = lib.Save.Get().World
                workspace.__MAP.Eggs.DescendantAdded:Connect(function(a)
                    if a.Name == 'EggInfo' then
                        for i,v in pairs(a.Frame.Pets:GetChildren()) do
                            if v:IsA('Frame') and v.Thumbnail.Chance.Text == '??' then
                                local pet
                                for _,tbl in pairs(getgc(true)) do
                                    if (typeof(tbl) == 'table' and rawget(tbl, 'thumbnail')) then
                                        if tbl.thumbnail == v.Thumbnail.Image then
                                            pet = string.split(tostring(tbl.model.Parent), ' - ')[1]
                                        end
                                    end
                                end
                                for _,egg in pairs(game.ReplicatedStorage.Game.Eggs:GetDescendants()) do
                                    if egg:IsA('ModuleScript') and typeof(require(egg).drops) == 'table' then
                                        for _,drop in pairs(require(egg).drops) do
                                            if pet == '266' then v.Thumbnail.Chance.Text = '0.000002%' return end
                                            if drop[1] == pet then
                                                v.Thumbnail.Chance.Text = drop[2] .. '%'
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
         end
    end)

    local farmingTab = Window:NewTab("Farming")
    do
        local farmingSection = farmingTab:NewSection("Farming")
        do
            farmingSection:NewDropdown(
                "Area",
                "Select the area to use",
                areaList,
                function(selected)
                    flags:SetFlag("autoFarmArea", selected)
                end
            )
            farmingSection:NewDropdown(
                "Method",
                "Select the method to use",
                {"Smallest Value", "Highest Value", "Chests", "Random Coin"},
                function(method)
                    flags:SetFlag("autoFarmMethod", method)
                end
            )
            farmingSection:NewToggle(
                "Auto Farm",
                "Starts the auto farm",
                function(state)
                    flags:SetFlag("autoFarm", state)
                    while task.wait() do
                        if flags.autoFarm then
                            -- local coins = PetSim:GetAllCoinsInArea(selectedArea)
                            -- local randomCoin = coins[math.random(1, #coins)].id

                            -- currentCoinId = randomCoin
                            local selectedArea = flags.autoFarmArea
                            local selectedMethod = flags.autoFarmMethod

                            if selectedMethod == "Smallest Value" then
                                local smallestCoins = PetSim:GetSmallestCoinTable(selectedArea)
                                print(selectedArea)
                                local i = 1
                                local currentCoin = smallestCoins[i].id
                                petIds = PetSim:GetPetIds()
                                currentCoinId = currentCoin

                                for _, id in pairs(petIds) do
                                    PetSim:FarmCoin(currentCoin, id)
                                end
                                local dummyTable = {[1] = {}}
                                local orbsRemote = game.Workspace["__THINGS"]["__REMOTES"]["claim orbs"]
                                for i, v in pairs(game.workspace["__THINGS"].Orbs:GetChildren()) do
                                    dummyTable[1][i] = v.Name
                                end
                                orbsRemote:FireServer(dummyTable)
                                task.wait(0.3)
                            elseif selectedMethod == "Highest Value" then
                                local highestCoins = PetSim:GetHighestCoinTable(selectedArea)
                                print(selectedArea)
                                local i = 1
                                local currentCoin = highestCoins[i].id
                                petIds = PetSim:GetPetIds()
                                currentCoinId = currentCoin

                                for _, id in pairs(petIds) do
                                    PetSim:FarmCoin(currentCoin, id)
                                end
                                local dummyTable = {[1] = {}}
                                local orbsRemote = game.Workspace["__THINGS"]["__REMOTES"]["claim orbs"]
                                for i, v in pairs(game.workspace["__THINGS"].Orbs:GetChildren()) do
                                    dummyTable[1][i] = v.Name
                                end
                                orbsRemote:FireServer(dummyTable)
                                task.wait(0.3)
                            end
                            repeat
                                runService.RenderStepped:Wait()
                            until (not game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(currentCoinId) or
                                not flags.autoFarm)
                        else
                            for _, id in pairs(petIds) do
                                PetSim:LeaveCoin(currentCoinId, id)
                            end
                            break
                        end
                    end
                end
            )

            farmingSection:NewToggle(
                "Auto Collect Orbs",
                "Automatically Collects all Orbs",
                function(bool)
                    if bool == true then
                        _G.CollectOrbs = true
                    elseif bool == false then
                        _G.CollectOrbs = false
                        end
                    
                    function CollectOrbs()
                       local ohTable1 = {[1] = {}}
                       for i,v in pairs(game.workspace['__THINGS'].Orbs:GetChildren()) do
                           ohTable1[1][i] = v.Name
                            end
                       game.workspace['__THINGS']['__REMOTES']["claim orbs"]:FireServer(ohTable1)
                        end
                    
                    while wait() and _G.CollectOrbs do
                          pcall(function() CollectOrbs() end)
                    end
                end
            )

            farmingSection:NewToggle(
                "Auto Collect Lootbags",
                "Automatically Collects all Lootbags",
                function(bool)
                    if bool then
                        local Running = {}
                        while wait() and bool do
                            for i, v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
                                spawn(function()
                                    if v ~= nil and v.ClassName == 'MeshPart' then
                                        if not Running[v.Name] then
                                            Running[v.Name] = true
                                            local StartTick = tick()
                                            v.Transparency = 1
                                            for a,b in pairs(v:GetChildren()) do
                                                if not string.find(b.Name, "Body") then
                                                    b:Destroy()
                                                end
                                            end
                                            repeat task.wait()
                                                v.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                                            until v == nil or not v.Parent or tick() > StartTick + 3
                                            Running[v.Name] = nil
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end
            )
        end
    end

    local eggsTab = Window:NewTab("Eggs")
    do
        local openingSection = eggsTab:NewSection("Opening")
        do
            openingSection:NewDropdown(
                "Egg to Open",
                "The Egg you want to open",
                eggList,
                function(eggSelected)
                    flags:SetFlag("eggToOpen", eggSelected)
                end
            )
            openingSection:NewDropdown(
                "Method",
                "The Method to use when you open the egg",
                {"Custom Amount", "Open / Stop opening with toggle"},
                function(methodSelected)
                    flags:SetFlag("methodToUse", methodSelected)
                end
            )
            openingSection:NewSlider(
                "Amount of Eggs",
                "The amount of eggs to open (only if you chose the custom amount method)",
                100,
                1,
                function(value)
                    flags:SetFlag("amountToOpen", tonumber(value))
                end
            )

            local startOpeningToggle
            startOpeningToggle =
                openingSection:NewToggle(
                "Toggle Opening",
                "Starts / Stops opening eggs",
                function(bool)
                    local selectedMethod = flags.methodToUse
                    local amountToOpen = flags.amountToOpen
                    local eggToOpen = flags.eggToOpen

                    flags:SetFlag("toggleEggs", bool)
                    task.spawn(
                        function()
                            while flags.toggleEggs do
                                if selectedMethod == "Custom Amount" then
                                    local amountOpened = 0
                                    repeat
                                        local ohTable1 = {
                                            [1] = eggs[eggToOpen],
                                            [2] = flags.useTripleHatch
                                        }

                                        workspace.__THINGS.__REMOTES["buy egg"]:InvokeServer(ohTable1)
                                        amountOpened = amountOpened + 1
                                        task.wait(0.5)
                                    until amountOpened == amountToOpen or not flags.toggleEggs
                                    startOpeningToggle:UpdateToggle("Toggle Opening", false)
                                    break
                                elseif selectedMethod == "Open / Stop opening with toggle" then
                                    if not flags.toggleEggs then
                                        break
                                    end
                                    local ohTable1 = {
                                        [1] = eggs[eggToOpen],
                                        [2] = flags.useTripleHatch
                                    }

                                    workspace.__THINGS.__REMOTES["buy egg"]:InvokeServer(ohTable1)
                                end
                            end
                        end
                    )
                end
            )
            openingSection:NewToggle(
                "Triple Hatch",
                "Whether to use the triple hatch gamepass (you need to own it)",
                function(bool)
                    flags:SetFlag("useTripleHatch", bool)
                end
            )
            openingSection:NewToggle("Remove Egg Animation","Remove Egg Animation Reduce Hatch Lag", function(state)
                if state == true then 
                    getsenv(pathToScript).OpenEgg = function() return end 
                else
                    getsenv(pathToScript).OpenEgg = oldFunc
                end 
            end)
        end

        




        local playerTab = Window:NewTab("Player")
        do
            local playerSection = playerTab:NewSection("Player")
            do
                playerSection:NewSlider(
                    "Walkspeed",
                    "Changes your Walkspeed (re execute if it doesnt work)",
                    400,
                    16,
                    function(value)
                        client.Character.Humanoid.WalkSpeed = value
                    end
                )
                playerSection:NewSlider(
                    "JumpPower",
                    "Changes your Jump power (re execute if it doesnt work)",
                    400,
                    50,
                    function(value)
                        client.Character.Humanoid.JumpPower = value
                    end
                )
                playerSection:NewSlider(
                    "HipHeight",
                    "Changes your Jump power (re execute if it doesnt work)",
                    400,
                    1,
                    function(value)
                        client.Character.Humanoid.HipHeight = value
                    end
                )
            end
        end
    end

    runService.Heartbeat:Connect(
        function()
            if flags.autoCollectOrbs then
                local dummyTable = {[1] = {}}
                local orbsRemote = game.Workspace["__THINGS"]["__REMOTES"]["claim orbs"]
                for i, v in pairs(game.workspace["__THINGS"].Orbs:GetChildren()) do
                    dummyTable[1][i] = v.Name
                end
                orbsRemote:FireServer(dummyTable)
                task.wait(0.3)
            end
            if flags.autoCollectLootbags then
                task.wait()
                local lootBagsPath = game:GetService("Workspace")["__THINGS"].Lootbags
                for _, lootbag in pairs(lootBagsPath:GetChildren()) do
                    local lootBagCFrame = lootbag.CFrame
                    local lootBagId = lootbag.Name

                    local ohTable1 = {
                        [1] = lootBagId,
                        [2] = lootBagCFrame
                    }

                    workspace.__THINGS.__REMOTES["collect lootbag"]:FireServer(ohTable1)
                end
            end
        end
    )

