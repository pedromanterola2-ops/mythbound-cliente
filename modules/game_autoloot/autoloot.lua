-- Autoloot de Mythbound (tibia-oce/BlackTek 10.98)
-- Cliente -> servidor: 0x60  u16 clientId, string nombre, u8 quitar
-- Servidor -> cliente: 0x60  u8 quitar, u16 cantidad, (string nombre, u16 clientId)*
--   (el C++ lo pasa a Lua como g_game.onMythboundAutoloot(quitar, ids, nombres))

local MYTHBOUND_VERSION = 1098
local OPCODE_AUTOLOOT = 0x60

local autolootWindow = nil
local listWidget = nil
local addEdit = nil
local countLabel = nil
local autolootButton = nil
local entries = {} -- [clientId] = nombre

local function isMythbound()
    return g_game.getClientVersion() == MYTHBOUND_VERSION
end

local function sendUpdate(clientId, name, remove)
    local protocolGame = g_game.getProtocolGame()
    if not protocolGame or not isMythbound() then
        return
    end
    local msg = OutputMessage.create()
    msg:addU8(OPCODE_AUTOLOOT)
    msg:addU16(clientId or 0)
    msg:addString(name or '')
    msg:addU8(remove and 1 or 0)
    protocolGame:send(msg)
end

local function getItemIdFromThings(lookThing, useThing)
    local thing = useThing or lookThing
    if thing and thing.isItem and thing:isItem() and thing:isPickupable() then
        return thing:getId()
    end
    return nil
end

function refresh()
    if not listWidget then
        return
    end
    listWidget:destroyChildren()

    local sorted = {}
    for id, name in pairs(entries) do
        table.insert(sorted, { id = id, name = name })
    end
    table.sort(sorted, function(a, b) return (a.name or '') < (b.name or '') end)

    for _, entry in ipairs(sorted) do
        local row = g_ui.createWidget('AutolootRow', listWidget)
        row:getChildById('item'):setItemId(entry.id)
        row:getChildById('name'):setText(entry.name ~= '' and entry.name or ('#' .. entry.id))
        row:getChildById('remove').onClick = function()
            sendUpdate(entry.id, '', true)
        end
    end

    if countLabel then
        countLabel:setText(tr('%d items on the list', #sorted))
    end
end

function onAutolootList(remove, ids, names)
    if type(ids) ~= 'table' then
        return
    end
    for i, id in ipairs(ids) do
        if remove then
            entries[id] = nil
        else
            entries[id] = (names and names[i]) or ''
        end
    end
    refresh()
end

function addByName()
    if not addEdit then
        return
    end
    local text = addEdit:getText():trim()
    if text == '' then
        return
    end
    sendUpdate(0, text, false)
    addEdit:clearText()
end

function show()
    if not autolootWindow or not g_game.isOnline() then
        return
    end
    autolootWindow:show()
    autolootWindow:raise()
    autolootWindow:focus()
    if addEdit then
        addEdit:focus()
    end
    if autolootButton then
        autolootButton:setOn(true)
    end
end

function hide()
    if autolootWindow then
        autolootWindow:hide()
    end
    if autolootButton then
        autolootButton:setOn(false)
    end
end

function toggle()
    if autolootWindow and autolootWindow:isVisible() then
        hide()
    else
        show()
    end
end

local function online()
    if not isMythbound() then
        return
    end
    if not autolootButton then
        autolootButton = modules.game_mainpanel.addToggleButton('autolootButton', tr('Autoloot'),
            '/images/options/analyzers', toggle, false, 12)
        autolootButton:setOn(false)
    end
end

local function offline()
    entries = {}
    refresh()
    hide()
end

function init()
    autolootWindow = g_ui.displayUI('autoloot')
    autolootWindow:hide()
    listWidget = autolootWindow:getChildById('list')
    addEdit = autolootWindow:getChildById('addEdit')
    countLabel = autolootWindow:getChildById('count')
    g_keyboard.bindKeyPress('Enter', addByName, addEdit)

    connect(g_game, {
        onGameStart = online,
        onGameEnd = offline,
        onMythboundAutoloot = onAutolootList
    })

    modules.game_interface.addMenuHook('autoloot', tr('Add to autoloot'), function(_, lookThing, useThing)
        local id = getItemIdFromThings(lookThing, useThing)
        if id then
            sendUpdate(id, '', false)
        end
    end, function(_, lookThing, useThing)
        local id = isMythbound() and getItemIdFromThings(lookThing, useThing)
        return id and not entries[id] or false
    end)

    modules.game_interface.addMenuHook('autoloot', tr('Remove from autoloot'), function(_, lookThing, useThing)
        local id = getItemIdFromThings(lookThing, useThing)
        if id then
            sendUpdate(id, '', true)
        end
    end, function(_, lookThing, useThing)
        local id = isMythbound() and getItemIdFromThings(lookThing, useThing)
        return id and entries[id] ~= nil or false
    end)

    refresh()
    if g_game.isOnline() then
        online()
    end
end

function terminate()
    disconnect(g_game, {
        onGameStart = online,
        onGameEnd = offline,
        onMythboundAutoloot = onAutolootList
    })
    if modules.game_interface then
        modules.game_interface.removeMenuHook('autoloot')
    end
    if autolootButton then
        autolootButton:destroy()
        autolootButton = nil
    end
    if autolootWindow then
        autolootWindow:destroy()
        autolootWindow = nil
    end
    listWidget, addEdit, countLabel = nil, nil, nil
end
