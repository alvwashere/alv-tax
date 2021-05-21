ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        TriggerEvent("alv_tax:chargePlayer")
    end
)

ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

RegisterNetEvent("alv_tax:chargePlayer")
AddEventHandler(
    "alv_tax:chargePlayer",
    function()
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = GetRealPlayerName(playerId)

        if Config.Enabled then
            Wait(Config.TimeInterval)

            balance = xPlayer.getAccount("bank").money
            if balance > Config.TaxAmount then
                xPlayer.removeAccountMoney(Config.Account, Config.TaxAmount)
                ESX.ShowNotification(
                    "Your taxes have been ~g~paid~s~ and ~b~deducted~s~ from your ~b~" .. Config.Account .. "~s~!"
                )
            else
                if balance < Config.TaxAmount then
                    ESX.ShowNotification("You are now wanted for ~r~Tax Evasion~s~!")
                    TriggerClientEvent(
                        "chatMessage",
                        -1,
                        "Government",
                        {255, 0, 0},
                        "Player" .. playerName .. "has been declared guilty of tax evasion! Law Enforcement Alerted!"
                    )
                end
            end
        end
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        TriggerEvent("alv_tax:chargePlayer")
    end
)
