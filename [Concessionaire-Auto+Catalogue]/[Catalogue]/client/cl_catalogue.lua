ESX = nil

local CouleurOn, inmenu, testvehicle = false, false, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0) 
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end 
	PlayerData = ESX.GetPlayerData() 
end) 
 
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job
	Citizen.Wait(5000)
end)
function DrawTopNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

TriggerEvent('instance:registerType', 'catalogue')

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'catalogue' then
		TriggerEvent('instance:enter', instance)
	end
end)

deletvehicle = function()
    TriggerEvent('esx:deleteVehicle', vehicle)
end

CatalogueMenu = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = 'Catalogue Concess'},
	Data = { currentMenu = "Catalogue Concessionnaire", " "},
	Events = { onSelected = function(self, _, MXXR, PMenu, menuData, currentBtn, currentMenu, currentSlt, result, slide)

        if MXXR.name == "Essayer les véhicules" then 
            if testvehicle then  
                testvehicle = false     
                ESX.ShowNotification('~r~Vous avez désactivé le test de véhicule') 
            else
                testvehicle = true
                ESX.ShowNotification('~g~Vous avez activé le test de véhicule')
            end
        end
        if self.Data.currentMenu == "Catégories Vehicules" then
            ESX.TriggerServerCallback('mxxr:car', function(carserv)
                CatalogueMenu.Menu["Véhicules"].b = {}
                for k,v in pairs(carserv) do 
                    table.insert(CatalogueMenu.Menu["Véhicules"].b, {name = v.name, ask = "~g~"..v.price.."$", namecar = v.name, cartest = v.model, cat = MXXR.value, arrowsonly = true, askX = true})
                end
                OpenMenu("Véhicules") 
            end, MXXR.value)
        end
        if MXXR.name == "Catégories Véhicules" then
            CatalogueMenu.Menu["Catégories Vehicules"].b = {}
            ESX.TriggerServerCallback('mxxr:categorie', function(categories)
                for k,v in pairs(categories) do
                 table.insert(CatalogueMenu.Menu["Catégories Vehicules"].b, {name = v.label, value = v.name, ask = ">", arrowsonly = true, askX = true})
            end
            OpenMenu("Catégories Vehicules") 
            end)
        end   
        if MXXR.name == "Paramètres" then
            OpenMenu('Paramètres')
        end
        if self.Data.currentMenu == "Couleur" then 
            if MXXR.Colour then  
                MXXR.Colour = false  
                CouleurOn = false  
                ESX.ShowNotification('~r~Vous avez changé la couleur des véhicules en Aléatoire !') 
            else
                MXXR.Colour = true
                CouleurOn = true
                ESX.ShowNotification('~g~Vous avez changé la couleur des véhicules en '..MXXR.name..' !') 
                function Metlacouleurpls()
                    SetVehicleCustomPrimaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false), MXXR.r,MXXR.g,MXXR.b)
                    SetVehicleCustomSecondaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false), MXXR.r,MXXR.g,MXXR.b)
                    SetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false), MXXR.plaque)
                end
                Metlacouleurpls()
            end
        end
        if MXXR.name == "Choisir la couleur" then
            OpenMenu('Couleur')
        end
        if self.Data.currentMenu == "Véhicules" and testvehicle then
            local playerPed = GetPlayerPed(-1)
            TriggerEvent('esx:deleteVehicle')
            Citizen.Wait(30)
            inmenu = true
            ESX.Game.SpawnVehicle(MXXR.cartest, vector3(1073.975708, -2966.7597, 5.90082), 177.6612, function(vehicle)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle,-1)	
                local hash = 0x8247D331
                RequestModel(hash)
                print(hash)
                while not HasModelLoaded(hash) do
                    Wait(5)
                end
                ped = CreatePed(4, hash, 1073.975708, -2966.7597, 5.90082, true, false)
                SetPedIntoVehicle(ped, vehicle) 
                ESX.ShowNotification("~g~Test du Véhicule disponible pendant 25 secondes !")
                ESX.ShowAdvancedNotification("Concessionnaire", "Samanta", "Je vous accompagnes pour ce tour en ~b~"..MXXR.namecar.." ~s~de 25 secondes", "CHAR_HITCHER_GIRL", 1)
                CloseMenu(true)
                if CouleurOn then
                Metlacouleurpls()
                Citizen.Wait(26000)
                ESX.Game.DeleteVehicle(vehicle)
                ESX.Game.Teleport(PlayerPedId(), {x = 201.6528, y = -1001.05798, z = -100.2 })
                ESX.ShowAdvancedNotification("Concessionnaire", "Samanta", "Le tour en ~b~"..MXXR.namecar.." ~s~est terminé !", "CHAR_HITCHER_GIRL", 1)
                FreezeEntityPosition(playerPed, false)
                DeletePed(ped)
                else
                Citizen.Wait(26000)
                ESX.Game.DeleteVehicle(vehicle)
                ESX.Game.Teleport(PlayerPedId(), {x = 201.6528, y = -1001.05798, z = -100.2 })
                ESX.ShowAdvancedNotification("Concessionnaire", "Samanta", "Le tour en ~b~"..MXXR.namecar.." ~s~est terminé !", "CHAR_HITCHER_GIRL", 1)
                FreezeEntityPosition(playerPed, false)
                SetEntityVisible(playerPed, true)
                DeletePed(ped)
            end
        end)
        end
        if self.Data.currentMenu == "Véhicules" and not testvehicle then
            local playerPed = GetPlayerPed(-1)
            TriggerEvent('esx:deleteVehicle')
            inmenu = true
            SetEntityVisible(playerPed, false)
            SetEntityVisible(vehicle, false, false)
            ESX.Game.SpawnVehicle(MXXR.cartest, vector3(201.6528, -1001.05798, -99.0), 178.89, function(vehicle)
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle,-1)	
            FreezeEntityPosition(playerPed, true)
            SetEntityVisible(playerPed, false)
            DisableControlAction(1, 75, false)
            SetVehicleDoorsLocked(vehicle, 2)
            SetEntityAsNoLongerNeeded(vehicle)
            FreezeEntityPosition(vehicle, true)
            if CouleurOn then
                Metlacouleurpls()
            end
        end)
    end
end},

    Menu = {
        ["Catalogue Concessionnaire"] = {
            b = {
                {name = "Catégories Véhicules", ask = ">", askX = true},
                {name = "Paramètres", ask = ">", askX = true}
            }
        },
        ["Paramètres"] = {
            b = {
                {name = "Essayer les véhicules", checkbox = false},
                {name = "Choisir la couleur", ask = ">", askX = true}
            }
        },
        ["Couleur"] = {
            b = {
                {name = "Noir", plaque = "CTLG", Colour = noir, r = 0, g = 0, b = 0, checkbox = false},
                {name = "Blanc", plaque = "CTLG", Colour = blanc, r = 255, g = 255, b = 255, checkbox = false},
                {name = "Rouge", plaque = "CTLG", Colour = rouge, r = 255, g = 0, b = 0, checkbox = false},
                {name = "Orange", plaque = "CTLG", Colour = orange, r = 255, g = 119, b = 1, checkbox = false},
                {name = "Jaune", plaque = "CTLG", Colour = jaune, r = 255, g = 209, b = 1, checkbox = false},
                {name = "Vert", plaque = "CTLG", Colour = vert, r = 3, g = 193, b = 1, checkbox = false},
                {name = "Bleu", plaque = "CTLG", Colour = vert, r = 35, g = 84, b = 161, checkbox = false},
                {name = "Violet", plaque = "CTLG", Colour = violet, r = 153, g = 0, b = 231, checkbox = false},
                {name = "Marron", plaque = "CTLG", Colour = marron, r = 133, g = 73, b = 0, checkbox = false},
                {name = "Rose", plaque = "CTLG", Colour = rose, r = 211, g = 40, b = 250, checkbox = false},
                {name = "Beige", plaque = "CTLG", Colour = beige, r = 238, g = 192, b = 73, checkbox = false}
            }
        },
        ["Catégories Vehicules"] = {
            b = {}
        },
        ["Véhicules"] = {
            b = {}
        },
    }
}

local garage = {
    { x = -50.117149, y = -1089.13012, z = 26.42233}
} 

local concess = {
    { x = 194.59133, y = -1007.57800, z = -100.05}
} 

local catalogue = {
    { x = 197.85833, y = -1001.09600, z = -99.000015}
} 

Citizen.CreateThread(function()
    while true do
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
        wait = 2000
        for k in pairs(catalogue) do 
            local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, catalogue[k].x, catalogue[k].y, catalogue[k].z) 
        
            if dist3 <= 7.0 then
                DrawMarker(25, 197.85833, -1001.09600, -99.950015, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 255, 102, 0, 0, 0, 0, nil, nil, 0)
                if dist3 <= 1.1 then 
                    DrawTopNotification("Appuyez sur ~INPUT_PICKUP~ Pour accéder au Catalogue")
                    if IsControlJustPressed(1,38) then 
                        Citizen.Wait(10)
                        CreateMenu(CatalogueMenu)
                    end
                end
            end
            wait = 5
        end
        for k in pairs(garage) do
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, garage[k].x, garage[k].y, garage[k].z)
            if dist <= 7.0 then
                DrawMarker(25, -50.117149, -1089.13012, 25.45, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 255, 102, 0, 0, 0, 0, nil, nil, 0)
                if dist <= 1.0 then 
                    DrawTopNotification("Appuyez sur ~INPUT_PICKUP~ Pour accéder au garage")
                    if IsControlJustPressed(1,38) then 
                        TriggerEvent('instance:create', 'catalogue')
                        SetEntityCoords(GetPlayerPed(-1), 194.59133, -1007.57800, -100.05)
                    end
                end
            end
            wait = 5
        end
        if inmenu then
            if IsControlJustPressed(1,75) then
            deletvehicle()
            inmenu = false
            local playerPed = GetPlayerPed(-1)
            FreezeEntityPosition(playerPed, false)
            SetEntityVisible(playerPed, true)
            CloseMenu(true)
            end
            wait = 5
        end
        for k in pairs(concess) do
            local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, concess[k].x, concess[k].y, concess[k].z)
            if dist2 <= 7.0 then
                DrawMarker(25, 194.59133, -1007.57800, -100.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 255, 102, 0, 0, 0, 0, nil, nil, 0)
            if dist2 <= 1.1 then
                DrawTopNotification("Appuyez sur ~INPUT_PICKUP~ Pour accéder au Concessionnaire")
                if IsControlJustPressed(1,38) then 
                    TriggerEvent('instance:close')
                    SetEntityCoords(GetPlayerPed(-1), -50.117149, -1089.13012, 25.00233)
                    end
                end
            end
            wait = 5
        end
        Citizen.Wait(wait)
    end
end)