-- 
-- Please see the LICENSE.md file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	onLevelChanged();
	DB.addHandler(DB.getPath(getDatabaseNode(), "classes"), "onChildUpdate", onLevelChanged);

	onHeroPoints();
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

function onHeroPoints()
    if CompManagerAC.EXTENSIONS["HeroPoints"] then
		name.resetAnchor("right");
		name.setAnchoredWidth(150);
    end
end
