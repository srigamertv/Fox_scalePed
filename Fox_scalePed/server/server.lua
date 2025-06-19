local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

RegisterCommand(Config.commandName, function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local priority = vRP.prompt(source, "[ valor entre 0.1 e 2.5 ]:", "")
    print(priority)

    priority = tonumber(priority)

    if priority == Config.defaultScale then
        TriggerClientEvent("um-ped-scale:stopScale", source)
        print("Escala redefinida para o normal (" .. Config.defaultScale .. ")")
        return
    end

    TriggerClientEvent("um-ped-scale:applyScale", source, priority)
    print("Escala aplicada: " .. priority)
end)
