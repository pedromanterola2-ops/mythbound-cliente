-- Mythbound: adaptador para el protocolo 10.98.
-- El servidor 10.98 no manda los paquetes de "impact/kill tracker" del Tibia 12+,
-- asi que se leen los mensajes de texto de daño, curacion y loot para llenar
-- Hunting, Impact e Input Analyser.

local function num(s)
	return tonumber(s) or 0
end

local function onDamageDealt(mode, text)
	local amount = text:match("loses (%d+) hitpoints?") or text:match("loses (%d+) mana")
	if amount then
		onImpactTracker(ANALYZER_DAMAGE_DEALT, num(amount), 0, "")
	end
end

local function onDamageReceived(mode, text)
	local amount, source = text:match("^You lose (%d+) hitpoints? due to an attack by (.-)%.$")
	if not amount then
		amount, source = text:match("^You lose (%d+) mana due to an attack by (.-)%.$")
	end
	if not amount then
		amount = text:match("^You lose (%d+) hitpoints?") or text:match("^You lose (%d+) mana")
		source = "unknown"
	end
	if amount then
		source = (source or "unknown"):gsub("^an? ", ""):gsub("^the ", "")
		onImpactTracker(ANALYZER_DAMAGE_RECEIVED, num(amount), 0, source:lower())
	end
end

local function onHeal(mode, text)
	local amount = text:match("for (%d+) hitpoints?") or text:match("(%d+) hitpoints?")
	if amount then
		onImpactTracker(ANALYZER_HEAL, num(amount), 7, "")
	end
end

local function onLoot(mode, text)
	local monster = text:match("^Loot of (.-):")
	if monster then
		monster = monster:gsub("^an? ", ""):gsub("^the ", "")
		HuntingAnalyser:addMonsterKilled(monster:lower())
	end
end

local handlers = {
	[MessageModes.DamageDealed] = onDamageDealt,
	[MessageModes.DamageReceived] = onDamageReceived,
	[MessageModes.Heal] = onHeal,
	[MessageModes.Loot] = onLoot,
}

function mythboundAnalyserInit()
	for mode, fn in pairs(handlers) do
		registerMessageMode(mode, fn)
	end
end

function mythboundAnalyserTerminate()
	for mode, fn in pairs(handlers) do
		unregisterMessageMode(mode, fn)
	end
end
