targetsEntitys = {}
ND_mTrackerRunning = false
timer = 0

AddEventHandler('ND_mTracker:start', function()
  ND_mTrackerRunning = true
  nuiMsg = {}
	nuiMsg.run = ND_mTrackerRunning
  nuiMsg.show = ND_mTrackerRunning
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('ND_mTracker:stop', function()
  ND_mTrackerRunning = false
  nuiMsg = {}
	nuiMsg.run = ND_mTrackerRunning
  nuiMsg.show = ND_mTrackerRunning
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('ND_mTracker:settargets', function(targets)
  targetsEntitys = targets
  polartargets = transformTargets()
  nuiMsg = {}
	nuiMsg.settargets = polartargets
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('ND_mTracker:updatetargets', function()
  polartargets = transformTargets()
  nuiMsg = {}
	nuiMsg.updatetargets = polartargets
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('ND_mTracker:removealltargets', function()
  nuiMsg = {}
	nuiMsg.removealltargets = true
	SendNUIMessage(nuiMsg)
end)

function isrunning()
  return ND_mTrackerRunning
end

function atan2(x, y)
	local res = 0
	if x > 0 then
		res = math.atan(y/x)
	elseif x < 0 and y > 0 then
		res = math.atan(y/x) + math.pi
	elseif x < 0 and y < 0 then
		res = math.atan(y/x) - math.pi
	elseif x == 0 and y > 0 then
		res = 0.5 * math.pi
	elseif x == 0 and y < 0 then
		res = -0.5 * math.pi
	elseif y == 0 and x > 0 then
		res = math.pi
	end
	return res
end

function radToDeg(f)
	res = 180.0/math.pi * f
	if res >= 360 then
		res = res - 360.0
	end
	return res
end

function calculateRelativePolarCoordinates(playerPos, targetPos)
  local v = {x = targetPos.x - playerPos.x, y = targetPos.y - playerPos.y}
  local phi = radToDeg(atan2(v.y, v.x)) + GetEntityHeading(PlayerPedId())
  if phi > 360.0 then phi = phi - 360.0 end
  if phi < 0.0 then phi = phi + 360.0 end
  local r = scalingFunction( math.sqrt( v.x*v.x + v.y*v.y ) )
  return {['r'] = r, ['phi'] = phi}
end

function transformTargets()
  if not IsEntityDead(PlayerPedId()) then
    local t = {}
    local v = GetEntityCoords(PlayerPedId(), true)
    for _,ent in pairs(targetsEntitys) do
      if not IsEntityDead(ent) then
        table.insert(t, calculateRelativePolarCoordinates(v, GetEntityCoords(ent, true)))
      end
    end
    return t
  else
    TriggerEvent("ND_mTracker:stop")
  end
end

function setTimer()
  timer = GetGameTimer()
end

function getTimer()
  return GetGameTimer() - timer
end

function scalingFunction(r)
  res = 0
  if ND_mTracker_ScalingType == "LOG" then
    if r > 0 then
      res = ND_mTracker_MaxRings * math.log(r)/math.log(ND_mTracker_MaxDistance)
    else
      res = 0
    end
  elseif ND_mTracker_ScalingType == "SQRT" then
    res = ND_mTracker_MaxRings * math.sqrt(r/ND_mTracker_MaxDistance)
  elseif ND_mTracker_ScalingType == "LIN" then
    res = ND_mTracker_MaxRings * r/ND_mTracker_MaxDistance
  end
  return res
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ND_mTrackerRunning then
      if getTimer() > 15 then
        TriggerEvent('ND_mTracker:updatetargets')
        setTimer()
      end
      if IsControlJustPressed(1, ND_mTracker_StoppingKey) then
        TriggerEvent("ND_mTracker:stop")
      end
    end
  end
end)
