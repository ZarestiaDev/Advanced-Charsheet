-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--
function onInit()
	-- Be sure to always be in "action" mode
	updateDisplayMode()
end

function onModeChanged()
	updateSpellCounters();
end

function updateSpellCounters()
	if spells then
		for _,v in pairs(spells.subwindow.spellclasslist.getWindows()) do
			v.onSpellCounterUpdate();
		end
	end
	if items then
		for _,v in pairs(items.subwindow.spellclasslist.getWindows()) do
			v.onSpellCounterUpdate();
		end
	end
	if others then
		for _,v in pairs(others.subwindow.spellclasslist.getWindows()) do
			v.onSpellCounterUpdate();
		end
	end
end

function updateDisplayMode()
	local nodeChar = getDatabaseNode();
	local sSpellMode = DB.getValue(nodeChar, "spelldisplaymode", "");

	if sSpellMode ~= "action" then
		DB.setValue(nodeChar, "spelldisplaymode", "string", "action");

		if spells and spells.subwindow then
			for _,v in pairs(spells.subwindow.spellclasslist.getWindows()) do
				v.onDisplayChanged();
			end
		end
		if items and items.subwindow then
			for _,v in pairs(items.subwindow.spellclasslist.getWindows()) do
				v.onDisplayChanged();
			end
		end
		if others and others.subwindow then
			for _,v in pairs(others.subwindow.spellclasslist.getWindows()) do
				v.onDisplayChanged();
			end
		end
	end
end
