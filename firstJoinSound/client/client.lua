RegisterNetEvent('firstJoinSound:playSound')
AddEventHandler('firstJoinSound:playSound', function()
    Citizen.Wait(10000)  -- waits for 10 seconds
    SendNUIMessage({
        type = 'playSound',
        soundFile = 'your_sound_file.ogg'
    })
end)

-- Notify the server when the script starts
Citizen.CreateThread(function()
    TriggerServerEvent('firstJoinSound:playerJoined')
end)
