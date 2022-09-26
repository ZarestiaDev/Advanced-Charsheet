function onInit()
    if super and super.onInit then
        super.onInit();
    end

    onExtraActions();
end

function onExtraActions()
	if CompManagerAC.EXTENSIONS["FG-Extra-Actions"] then
        local nHeightOverview = 219;
        local nTopCharsheet = 239;

		overview.setStaticBounds(15,20,-30,nHeightOverview);
        main.setStaticBounds(0,nTopCharsheet,-1,-20);
        combat.setStaticBounds(0,nTopCharsheet,-1,-20);
        skills.setStaticBounds(0,nTopCharsheet,-1,-20);
        abilities.setStaticBounds(0,nTopCharsheet,-1,-20);
        inventory.setStaticBounds(0,nTopCharsheet,-1,-20);
        notes.setStaticBounds(0,nTopCharsheet,-1,-20);
        actions.setStaticBounds(0,nTopCharsheet,-1,-20);
	end
end
