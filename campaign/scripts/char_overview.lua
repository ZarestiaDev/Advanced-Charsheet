-- 
-- Please see the LICENSE.md file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	onLevelChanged();
	DB.addHandler(DB.getPath(getDatabaseNode(), "classes"), "onChildUpdate", onLevelChanged);

	OptionsManager.registerCallback("ACHP", onHeroPoints);
	onHeroPoints();
end

function onClose()
	DB.removeHandler(DB.getPath(getDatabaseNode(), "classes"), "onChildUpdate", onLevelChanged);
	OptionsManager.unregisterCallback("ACHP", onHeroPoints);
end

function onLevelChanged()
	CharManager.calcLevel(getDatabaseNode());
end

function onDrop(x, y, draginfo)
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"referenceclass", "referencerace"}, sClass) then
			CharManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
			return true;
		end
	end
end

function onHeroPoints()
    if CompManagerAC.RULESET == "3.5E" then
		return;
	end

	local bVisible = false;
	local nOffset = 0;

	if OptionsManager.getOption("ACHP") == "on" then
		bVisible = true;
		nOffset = -50;
	else
		bVisible = false;
		nOffset = 0;
	end

	heropointframe.setVisible(bVisible);
	heropoint.setVisible(bVisible);
	heropoint_label.setVisible(bVisible);
	classframe.setAnchor("right", "", "right", "", nOffset);
end
