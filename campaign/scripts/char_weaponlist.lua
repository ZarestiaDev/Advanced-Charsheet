function onInit()
	self.onModeChanged();
end

function onChildAdded()
	self.onModeChanged();
end

function onModeChanged()
	if not minisheet then
		local bPrepMode = (DB.getValue(window.getDatabaseNode(), "spellmode", "") == "preparation");
		for _,w in ipairs(getWindows()) do
			w.carried.setVisible(bPrepMode);
		end
	end
	
	applyFilter();
end

function addEntry(bFocus)
	local w = createWindow();
	if bFocus and w then
		w.name.setFocus();
	end
	return w;
end

function onDrop(x, y, draginfo)
	return CharManager.onActionDrop(draginfo, window.getDatabaseNode());
end

function onFilter(w)
	local bEquipped = (w.carried.getValue() >= 2);
	if minisheet then
		return bEquipped;
	end
	return (bEquipped or (DB.getValue(window.getDatabaseNode(), "spellmode", "") ~= "combat"));
end
