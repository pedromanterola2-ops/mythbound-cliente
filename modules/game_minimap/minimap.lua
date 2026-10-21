local iconTopMenu = nil
-- Mythbound: marcas fijas del minimapa (ciudades, portales y hunts)
local MYTHBOUND_FLAGS = {
    {pos = {x = 1093, y = 411, z = 5}, icon = 9, text = "Templo de Mordragor"},
    {pos = {x = 1929, y = 384, z = 7}, icon = 9, text = "Templo de Kindernia"},
    {pos = {x = 374, y = 326, z = 7}, icon = 9, text = "Templo de Dolwatha"},
    {pos = {x = 668, y = 423, z = 7}, icon = 9, text = "Templo de Falanaar"},
    {pos = {x = 1217, y = 1028, z = 5}, icon = 9, text = "Templo de Freewind"},
    {pos = {x = 1449, y = 1292, z = 5}, icon = 9, text = "Templo de Arkeron"},
    {pos = {x = 1376, y = 407, z = 6}, icon = 9, text = "Templo de Death Valley"},
    {pos = {x = 1094, y = 415, z = 5}, icon = 3, text = "Portal de viajes (o escribe !viajes)"},
    {pos = {x = 374, y = 328, z = 7}, icon = 3, text = "Portal de viajes (o escribe !viajes)"},
    {pos = {x = 663, y = 423, z = 7}, icon = 3, text = "Portal de viajes (o escribe !viajes)"},
    {pos = {x = 1376, y = 409, z = 6}, icon = 3, text = "Portal de viajes (o escribe !viajes)"},
    {pos = {x = 1217, y = 1025, z = 5}, icon = 3, text = "Portal de viajes (o escribe !viajes)"},
    {pos = {x = 1449, y = 1296, z = 5}, icon = 3, text = "Portal de viajes (o escribe !viajes)"},
    {pos = {x = 1267, y = 460, z = 7}, icon = 8, text = "Hunt nivel 5: Snakes"},
    {pos = {x = 2039, y = 363, z = 5}, icon = 8, text = "Hunt nivel 7: Trolls y Bears"},
    {pos = {x = 1374, y = 975, z = 6}, icon = 8, text = "Hunt nivel 7: Frost Trolls"},
    {pos = {x = 1199, y = 325, z = 7}, icon = 8, text = "Hunt nivel 19: Cyclops"},
    {pos = {x = 276, y = 360, z = 6}, icon = 8, text = "Hunt nivel 42: Dragons y Dragon Hatchlings"},
    {pos = {x = 1879, y = 1120, z = 7}, icon = 8, text = "Hunt nivel 42: Dragons y Dragon Lords"},
    {pos = {x = 1136, y = 482, z = 7}, icon = 8, text = "Hunt nivel 8: Trolls y Troll Champions"},
    {pos = {x = 1077, y = 281, z = 7}, icon = 8, text = "Hunt nivel 8: Goblins y Goblin Assassins"},
    {pos = {x = 1045, y = 919, z = 8}, icon = 8, text = "Hunt nivel 10: Chakoya Toolshapers y Chakoya Windcallers"},
    {pos = {x = 1174, y = 431, z = 8}, icon = 8, text = "Hunt nivel 13: Rotworms y Carrion Worms"},
    {pos = {x = 1108, y = 50, z = 7}, icon = 8, text = "Hunt nivel 13: Elves y Elf Scouts"},
    {pos = {x = 1009, y = 518, z = 9}, icon = 8, text = "Hunt nivel 17: Crypt Shamblers y Elf Arcanists"},
    {pos = {x = 1096, y = 29, z = 6}, icon = 8, text = "Hunt nivel 22: Barbarian Bloodwalkers y Barbarian Headsplitters"},
    {pos = {x = 576, y = 298, z = 5}, icon = 8, text = "Hunt nivel 25: Deepling Brawlers y Deepling Spellsingers"},
    {pos = {x = 1014, y = 527, z = 7}, icon = 8, text = "Hunt nivel 27: Vampires y Necromancers"},
    {pos = {x = 448, y = 183, z = 13}, icon = 8, text = "Hunt nivel 32: Green Djinns y Efreets"},
    {pos = {x = 992, y = 621, z = 11}, icon = 8, text = "Hunt nivel 38: Demon Skeletons y Giant Spiders"},
    {pos = {x = 1571, y = 933, z = 7}, icon = 8, text = "Hunt nivel 40: Ogre Brutes y Ogre Savages"},
    {pos = {x = 1813, y = 1143, z = 8}, icon = 8, text = "Hunt nivel 45: Massive Earth Elementals y Bog Raiders"},
    {pos = {x = 1107, y = 202, z = 9}, icon = 8, text = "Hunt nivel 55: Necromancers y Vile Grandmasters"},
    {pos = {x = 1535, y = 998, z = 10}, icon = 8, text = "Hunt nivel 56: Yielothax y Blood Beasts"},
    {pos = {x = 1740, y = 934, z = 7}, icon = 8, text = "Hunt nivel 61: Worm Priestess y Minotaur Amazons"},
    {pos = {x = 1735, y = 877, z = 6}, icon = 8, text = "Hunt nivel 65: Yielothax y Lost Berserkers"},
    {pos = {x = 1971, y = 1084, z = 5}, icon = 8, text = "Hunt nivel 75: Warlocks y Infernalists"},
    {pos = {x = 1865, y = 925, z = 6}, icon = 12, text = "Hunt nivel 86: Magma Crawlers y Infected Weepers"},
    {pos = {x = 1866, y = 949, z = 7}, icon = 12, text = "Hunt nivel 86: Lost Berserkers y Stone Devourers"},
    {pos = {x = 1224, y = 34, z = 9}, icon = 12, text = "Hunt nivel 88: Medusas y Serpent Spawns"},
    {pos = {x = 1830, y = 1093, z = 9}, icon = 12, text = "Hunt nivel 101: Blightwalkers y Ghastly Dragons"},
    {pos = {x = 448, y = 655, z = 8}, icon = 12, text = "Hunt nivel 102: Midnight Asuras y Dawnfire Asuras"},
    {pos = {x = 559, y = 323, z = 9}, icon = 12, text = "Hunt nivel 103: Draken Spellweavers y Draken Elites"},
    {pos = {x = 1187, y = 847, z = 10}, icon = 12, text = "Hunt nivel 109: Destroyers y Blightwalkers"},
    {pos = {x = 1355, y = 280, z = 9}, icon = 12, text = "Hunt nivel 109: Demon Outcasts y Dark Torturers"},
    {pos = {x = 1555, y = 326, z = 7}, icon = 12, text = "Hunt nivel 109: Frazzlemaws y Silencers"},
    {pos = {x = 1204, y = 40, z = 12}, icon = 12, text = "Hunt nivel 118: Hellspawns y Grim Reapers"},
    {pos = {x = 1478, y = 406, z = 10}, icon = 12, text = "Hunt nivel 122: Demon Outcasts y Energy Elementals"},
    {pos = {x = 1415, y = 378, z = 9}, icon = 12, text = "Hunt nivel 125: Demon Outcasts y Plaguesmiths"},
}
-- @ Minimap
local minimapWidget = nil -- bot fix
local otmm = true
local oldPos = nil
local fullscreenWidget
local virtualFloor = 7
local currentDayTime = {
    h = 12,
    m = 0
}

local function refreshVirtualFloors()
    mapController.ui.layersPanel.layersMark:setMarginTop(((virtualFloor + 1) * 4) - 3)
    mapController.ui.layersPanel.automapLayers:setImageClip((virtualFloor * 14) .. ' 0 14 67')
end

local function onPositionChange()
    local player = g_game.getLocalPlayer()
    if not player then
        return
    end

    local pos = player:getPosition()
    if not pos then
        return
    end

    local minimapWidget = mapController.ui.minimapBorder.minimap
    if not (minimapWidget) or minimapWidget:isDragging() then
        return
    end

    if not minimapWidget.fullMapView then
        minimapWidget:setCameraPosition(pos)
    end

    minimapWidget:setCrossPosition(pos)
    virtualFloor = pos.z
    refreshVirtualFloors()
end

mapController = Controller:new()
mapController:setUI('minimap', modules.game_interface.getMainRightPanel())

function onChangeWorldTime(hour, minute)
--[[ 

check 
tfs c++ (old) : void ProtocolGame::sendWorldTime()
tfs lua (new) : function Player.sendWorldTime(self, time)
Canary: void ProtocolGame::sendTibiaTime(int32_t time)
 ]]

    currentDayTime = {
        h = hour % 24,
        m = minute
    }

    mapController:scheduleEvent(function()
        local nextH = currentDayTime.h
        local nextM = currentDayTime.m + 12
        if nextM >= 60 then
            nextH = nextH + 1
            nextM = nextM - 60
        end

        onChangeWorldTime(nextH, nextM)
    end, 30000, 'dayTime')

    local position = math.floor((124 / (24 * 60)) * ((hour * 60) + minute))
    local mainWidth = 31
    local secondaryWidth = 0

    if (position + 31) >= 124 then
        secondaryWidth = ((position + 31) - 124) + 1
        mainWidth = 31 - secondaryWidth
    end

    mapController.ui.rosePanel.ambients.main:setWidth(mainWidth)
    mapController.ui.rosePanel.ambients.secondary:setWidth(secondaryWidth)

    if secondaryWidth == 0 then
        mapController.ui.rosePanel.ambients.secondary:hide()
    else
        mapController.ui.rosePanel.ambients.secondary:setImageClip('0 0 ' .. secondaryWidth .. ' 31')
        mapController.ui.rosePanel.ambients.secondary:show()
    end

    if mainWidth == 0 then
        mapController.ui.rosePanel.ambients.main:hide()
    else
        mapController.ui.rosePanel.ambients.main:setImageClip(position .. ' 0 ' .. mainWidth .. ' 31')
        mapController.ui.rosePanel.ambients.main:show()
    end
end

function mapController:onInit()
    self.ui.minimapBorder.minimap:getChildById('floorUpButton'):hide()
    self.ui.minimapBorder.minimap:getChildById('floorDownButton'):hide()
    self.ui.minimapBorder.minimap:getChildById('zoomInButton'):hide()
    self.ui.minimapBorder.minimap:getChildById('zoomOutButton'):hide()
    self.ui.minimapBorder.minimap:getChildById('resetButton'):hide()
end

function mapController:onGameStart()
    mapController:registerEvents(g_game, {
        onChangeWorldTime = onChangeWorldTime
    })

    mapController:registerEvents(LocalPlayer, {
        onPositionChange = onPositionChange
    }):execute()

    -- Load Map
    g_minimap.clean()

    local minimapFile = '/minimap'
    local loadFnc = nil

    if otmm then
        minimapFile = minimapFile .. '.otmm'
        loadFnc = g_minimap.loadOtmm
    else
        minimapFile = minimapFile .. '_' .. g_game.getClientVersion() .. '.otcm'
        loadFnc = g_map.loadOtcm
    end

    -- Mythbound: el mundo completo viene descubierto (data/minimap_mythbound.otmm)
    if otmm and g_resources.fileExists('/minimap_mythbound.otmm') then
        g_minimap.loadOtmm('/minimap_mythbound.otmm')
    elseif g_resources.fileExists(minimapFile) then
        loadFnc(minimapFile)
    end

    self.ui.minimapBorder.minimap:load()

    -- Mythbound: marcas de ciudades, portales y hunts
    for _, flag in ipairs(MYTHBOUND_FLAGS) do
        self.ui.minimapBorder.minimap:addFlag(flag.pos, flag.icon, flag.text, true)
    end
end

function mapController:onGameEnd()
    -- Save Map
    if otmm then
        g_minimap.saveOtmm('/minimap.otmm')
    else
        g_map.saveOtcm('/minimap_' .. g_game.getClientVersion() .. '.otcm')
    end

    self.ui.minimapBorder.minimap:save()
end

function mapController:onTerminate()
    if iconTopMenu then
        iconTopMenu:destroy()
        iconTopMenu = nil
    end
end

function zoomIn()
    mapController.ui.minimapBorder.minimap:zoomIn()
end

function zoomOut()
    mapController.ui.minimapBorder.minimap:zoomOut()
end

function openCyclopediaMap()
    if g_game.getClientVersion() >= 1310 then
        modules.game_cyclopedia.toggle('map')
    else
        return fullscreen()
    end
end

function fullscreen()
    local minimapWidget = mapController.ui.minimapBorder.minimap
    if not minimapWidget then
        minimapWidget = fullscreenWidget
    end
    local zoom;

    if not minimapWidget then
        return
    end

    if minimapWidget.fullMapView then
        fullscreenWidget = nil
        minimapWidget:setParent(mapController.ui.minimapBorder)
        minimapWidget:fill('parent')
        mapController.ui:show()
        zoom = minimapWidget.zoomMinimap
        g_keyboard.unbindKeyDown('Escape')
        minimapWidget.fullMapView = false
    else
        fullscreenWidget = minimapWidget
        mapController.ui:hide(true)
        minimapWidget:setParent(modules.game_interface.getRootPanel())
        minimapWidget:fill('parent')
        zoom = minimapWidget.zoomFullmap
        g_keyboard.bindKeyDown('Escape', fullscreen)
        minimapWidget.fullMapView = true
    end

    local pos = oldPos or minimapWidget:getCameraPosition()
    oldPos = minimapWidget:getCameraPosition()
    minimapWidget:setZoom(zoom)
    minimapWidget:setCameraPosition(pos)
end

function upLayer()
    if virtualFloor == 0 then
        return
    end

    mapController.ui.minimapBorder.minimap:floorUp(1)
    virtualFloor = virtualFloor - 1
    refreshVirtualFloors()
end

function downLayer()
    if virtualFloor == 15 then
        return
    end

    mapController.ui.minimapBorder.minimap:floorDown(1)
    virtualFloor = virtualFloor + 1
    refreshVirtualFloors()
end

function onClickRoseButton(dir)
    if dir == 'north' then
        mapController.ui.minimapBorder.minimap:move(0, 1)
    elseif dir == 'north-east' then
        mapController.ui.minimapBorder.minimap:move(-1, 1)
    elseif dir == 'east' then
        mapController.ui.minimapBorder.minimap:move(-1, 0)
    elseif dir == 'south-east' then
        mapController.ui.minimapBorder.minimap:move(-1, -1)
    elseif dir == 'south' then
        mapController.ui.minimapBorder.minimap:move(0, -1)
    elseif dir == 'south-west' then
        mapController.ui.minimapBorder.minimap:move(1, -1)
    elseif dir == 'west' then
        mapController.ui.minimapBorder.minimap:move(1, 0)
    elseif dir == 'north-west' then
        mapController.ui.minimapBorder.minimap:move(1, 1)
    end
end

function resetMap()
    mapController.ui.minimapBorder.minimap:reset()
    local player = g_game.getLocalPlayer()
    if player then
        virtualFloor = player:getPosition().z
        refreshVirtualFloors()
    end
end

function getMiniMapUi()
    return mapController.ui.minimapBorder.minimap
end

function extendedView(extendedView)
    if extendedView then
        if not iconTopMenu then
            iconTopMenu = modules.client_topmenu.addTopRightToggleButton('miniMap', tr('Show miniMap'),
                '/images/topbuttons/minimap', toggle)
            iconTopMenu:setOn(mapController.ui:isVisible())
            mapController.ui:setBorderColor('black')
            mapController.ui:setBorderWidth(2)
        end
    else
        if iconTopMenu then
            iconTopMenu:destroy()
            iconTopMenu = nil
        end
        mapController.ui:setBorderColor('alpha')
        mapController.ui:setBorderWidth(0)
        local mainRightPanel = modules.game_interface.getMainRightPanel()
        if not mainRightPanel:hasChild(mapController.ui) then
            mainRightPanel:insertChild(1, mapController.ui)
        end
        mapController.ui:show()

    end
    mapController.ui.moveOnlyToMain = not extendedView
end

function toggle()
    if iconTopMenu:isOn() then
        mapController.ui:hide()
        iconTopMenu:setOn(false)
    else
        mapController.ui:show()
        iconTopMenu:setOn(true)
    end
end
