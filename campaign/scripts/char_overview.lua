-- 
-- Please see the LICENSE.md file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	onLevelChanged();
	DB.addHandler(DB.getPath(getDatabaseNode(), "classes"), "onChildUpdate", onLevelChanged);

	onLocalDiceTower();
end

function onClose()
	DB.removeHandler(DB.getPath(getDatabaseNode(), "classes"), "onChildUpdate", onLevelChanged);
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

function onLocalDiceTower()
	if Session.IsHost then
		return;
	end

    if CompManagerAC.EXTENSIONS["M23185F_LDTE"] then
		speak.resetAnchor("right");
		speak.resetAnchor("left");
        speak.setAnchor("right", "dicetower_forwarding", "left", "", 60);
    end
end