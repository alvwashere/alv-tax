Tax = {}

Tax.UsePercentage = true -- If you have this enabled, Tax.TaxAmount will not work! 
Tax.PercentageToCharge = 20 -- Make this from a value of 1-100, this will remove the percent amount from players chosen account
Tax.TaxAmount = 5000 -- How much the player should be taxed in the time interval if you are not using Tax.UsePercentage!
Tax.TimeInterval = 12000000 -- The amount of time until player should be taxed, default is 20 minutes!
Tax.Account = 'bank' -- Make this bank or cash if ESX v1.1 - else bank or money (or of course black_money :) )
Tax.Enabled = true -- Use this to enable/disable the script!
