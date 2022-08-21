function onInit()
	toggleTabButton("subspells_button");
end

function getTabNames()
	local aTabButtonControls = {};
	for _,ctrl in pairs(getControls()) do
		if ctrl.getName():find("_button$") then
			local sCtrlName = ctrl.getName():gsub("_button$", "");
			table.insert(aTabButtonControls, sCtrlName);
		end
	end
	return aTabButtonControls;
end

function toggleTabButton(sSelectedTabName)
	for _,sTabName in pairs(self.getTabNames()) do
		updateTabStyle(sTabName, "fielddark", false);
	end
	updateTabStyle(sSelectedTabName, "fieldfocus", true);
end

function updateTabStyle(sTabName, sFrame, bVisible)
	if sTabName:find("_") then
		sTabName = sTabName:sub(0, sTabName:find("_")-1);
	end
	self[sTabName].setVisible(bVisible);
	self[sTabName .. "_button"].setFrame(sFrame, 7,5,7,5);
end
