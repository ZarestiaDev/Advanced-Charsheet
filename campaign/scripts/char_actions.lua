function onInit()
    OptionsManager.registerCallback("ACAT", stateChanged);

    stateChanged();

	toggleTabButton("subspells_button");
end

function onClose()
    OptionsManager.unregisterCallback("ACAT", stateChanged);
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

function stateChanged()
    local bVisible;
    local nTopActionFrame;
    local nTopActionSub;

    if OptionsManager.isOption("ACAT", "on") then
        bVisible = true;
        nTopActionFrame = 60;
        nTopActionSub = 67;
    else
        bVisible = false;
        nTopActionFrame = 28;
        nTopActionSub = 35;
    end

    setTracker(bVisible, nTopActionFrame, nTopActionSub);
end

function setTracker(bVisible, nTopActionFrame, nTopActionSub)
    actionframe.setStaticBounds(15,nTopActionFrame,-29,-2);

    subspells.setAnchor("top", "", "top", "", nTopActionSub);
    subweapons.setAnchor("top", "", "top", "", nTopActionSub);
    subitems.setAnchor("top", "", "top", "", nTopActionSub);
    subothers.setAnchor("top", "", "top", "", nTopActionSub);

    label_actiontracker.setVisible(bVisible);
	standard.setVisible(bVisible);
	move.setVisible(bVisible);
	fullround.setVisible(bVisible);
	swift.setVisible(bVisible);
	reset.setVisible(bVisible);
end
