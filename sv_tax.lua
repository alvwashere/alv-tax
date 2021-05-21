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
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        playerName = GetRealPlayerName(_source)

        if Config.Enabled then
            Wait(Config.TimeInterval)

            if Config.UsePercentage then
                local currentMoney = xPlayer.getAccount(Config.Account).money
                local percent = 0.01 * Config.PercentageToCharge
                local amountToRemove = currentMoney * percent

                xPlayer.removeAccountMoney(Config.Account, amountToRemove)

                ESX.ShowNotification(
                    "Your taxes have been ~g~paid~s~, you have been charged" ..
                        amountToRemove .. "from your" .. Config.Account .. "!"
                )
            end
        else
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
