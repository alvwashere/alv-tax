ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("alv_tax:chargePlayer")
AddEventHandler("alv_tax:chargePlayer", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.Enabled then
        Wait(Config.TimeInterval)

        xPlayer.removeAccountMoney(Config.Account, Config.TaxAmount)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerEvent("alv_tax:chargePlayer")
end)