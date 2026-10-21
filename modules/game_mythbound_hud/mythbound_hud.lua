-- Mythbound: deja la interfaz como en el Tibia original la primera vez que entras.
-- Si despues cambias algo en Opciones, se respeta (solo corre una vez por version).
local HUD_VERSION = 1

local function applyDefaults()
    if g_settings.getNumber('mythbound_hud_version') >= HUD_VERSION then
        return
    end
    g_settings.set('mythbound_hud_version', HUD_VERSION)

    local opt = modules.client_options
    if opt and opt.setOption then
        -- Controles: "Left Smart-Click" como el Tibia actual
        opt.setOption('mouseControlMode', 2)
        -- Indicador de lag y FPS arriba a la izquierda
        opt.setOption('showFps', true)
        opt.setOption('showPing', true)
        -- Columnas: sin panel izquierdo, con una columna extra a la derecha
        -- (como el original: analyzers/skills en una, inventario/mochilas en otra)
        opt.setOption('showLeftPanel', false)
        opt.setOption('showLeftExtraPanel', false)
        opt.setOption('showRightExtraPanel', true)
    end

    -- Barras de vida/mana arriba con la linea de nivel y experiencia debajo
    g_settings.set('top_statsbar_experience', true)
    local gi = modules.game_interface
    if gi and gi.updateStatsBar then
        gi.updateStatsBar('default', 'top')
    end
end

function init()
    connect(g_game, { onGameStart = applyDefaults })
    if g_game.isOnline() then
        applyDefaults()
    end
end

function terminate()
    disconnect(g_game, { onGameStart = applyDefaults })
end
