
ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)
local webhook = "EDIT_HERE" -- Add your webhook here
local color = 9109247 -- Don't Edit
function TaxLog(name, msg)
	local embed = {{
        ["color"] = color, 
        ["title"] = "**" .. name .. "**",
        ["description"] = msg,
    }}
	PerformHttpRequest(webhook, function(err, text, headers)
	end, 'POST', json.encode({username = "esx_taxing", embeds = embed, avatar_url = "https://cdn.discordapp.com/attachments/891828087912796190/892186680839254086/fcdev.png"}), {['Content-Type'] = 'application/json'})
end
RegisterNetEvent("tax:chargePlayer")
AddEventHandler(
    "tax:chargePlayer",
    function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        playerName = GetRealPlayerName(_source)

        if Tax.Enabled then
            Wait(Tax.TimeInterval)

            if Tax.UsePercentage then
                local currentMoney = xPlayer.getAccount(Tax.Account).money
                local percent = 0.01 * Tax.PercentageToCharge
                local amountToRemove = currentMoney * percent

                xPlayer.removeAccountMoney(Tax.Account, amountToRemove)

                ESX.ShowNotification(
                    "Your taxes have been ~g~paid~s~, you have been charged" ..
                        amountToRemove .. "from your" .. Tax.Account .. "!"
                )
            end
        else
            balance = xPlayer.getAccount("bank").money
            if balance > Tax.TaxAmount then
                xPlayer.removeAccountMoney(Tax.Account, Tax.TaxAmount)
                ESX.ShowNotification(
                    "Your taxes have been ~g~paid~s~ and ~b~deducted~s~ from your ~b~" .. Tax.Account .. "~s~!"
                )
            else
                if balance < Tax.TaxAmount then
                    ESX.ShowNotification("You are now wanted for ~r~Tax Evasion~s~!")
                    TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(128, 128 ,128, 1); border-radius: 3px;"><i class="fas fa-users"></i> <b>[Government!] ' .. playerName .. '</b> <i>has been declared guilty of tax evasion! Law Enforcement Alerted.</i></div>'
	});
			TaxLog("esx_taxing", "**" .. playerName .. "** (ID: " .. playerName(playerId) .. ") has been declared guilty of tax evasion! Law Enforcement Alerted")

                end
            end
        end
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        TriggerEvent("tax:chargePlayertax:chargePlayer")
    end
)
