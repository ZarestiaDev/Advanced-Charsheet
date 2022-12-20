-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--
function onInit()
	-- Be sure to always be in "action" mode
	updateDisplayMode()

	onWinnowingPursuits();
end

function onModeChanged()
	updateSpellCounters();
end

function updateSpellCounters()
	local sWindow = getControls()[1].getName();

	if sWindow == "weapons" then
		weapons.subwindow.weaponlist.onModeChanged();
	end

	if self[sWindow] then
		for _,v in pairs(self[sWindow].subwindow.spellclasslist.getWindows()) do
			v.onSpellCounterUpdate();
		end
	end
end

function updateDisplayMode()
	local nodeChar = getDatabaseNode();
	local sSpellMode = DB.getValue(nodeChar, "spelldisplaymode", "");

	if sSpellMode == "action" then
		return;
	end
	
	DB.setValue(nodeChar, "spelldisplaymode", "string", "action");

	local sWindow = getControls()[1].getName();
	
	if self[sWindow] and self[sWindow].subwindow then
		for _,v in pairs(self[sWindow].subwindow.spellclasslist.getWindows()) do
			v.onDisplayChanged();
		end
	end
end

function onWinnowingPursuits()
	if CompManagerAC.EXTENSIONS["WinnowingPursuits"] then
		local nBottomOffset = -50;
		local sWindow = getControls()[1].getName();

		if self[sWindow] then
			self[sWindow].setAnchor("bottom", "", "bottom", "", nBottomOffset);
		end
	end
end
