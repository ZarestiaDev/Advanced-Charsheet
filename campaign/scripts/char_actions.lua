function onInit()
	toggleTabButton("subspells_button");

	onAttackModifiers();
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

function onAttackModifiers()
	if CompManagerAC.EXTENSIONS["Attack Modifiers"] then
		toggle_actions_am.setVisible(true);
		actions_am.setVisible(true);

		subspells.setAnchor("top", "actions_am", "bottom", "", 22);
		subweapons.setAnchor("top", "actions_am", "bottom", "", 22);
		subitems.setAnchor("top", "actions_am", "bottom", "", 22);
		subothers.setAnchor("top", "actions_am", "bottom", "", 22);
	end
end
