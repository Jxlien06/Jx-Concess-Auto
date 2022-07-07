ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('mxxr:categorie', function(source, cb)
    MySQL.Async.fetchAll('SELECT name, label FROM catalogue_categories', {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('mxxr:car', function(source, cb, categorie)
    MySQL.Async.fetchAll('SELECT name, model, price, categorie FROM vehicles_catalogues WHERE categorie = @categorie', {
        ['@categorie'] = categorie
    }, function(result)
        cb(result)
    end)
end)