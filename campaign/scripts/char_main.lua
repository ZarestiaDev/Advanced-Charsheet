-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

NODETOTALHP = "hp.total";

function onInit()
	onSystemChanged();

	onLiveHP();
end

function onHealthChanged()
	local nodeChar = getDatabaseNode();
	local rActor = ActorManager.resolveActor(nodeChar);
	local sColor = ActorHealthManager.getHealthColor(rActor);

	local nHPMax = DB.getValue(nodeChar, NODETOTALHP, 0);
	local nHPWounds = DB.getValue(nodeChar, "hp.wounds", 0);
	local nHPCurrent = nHPMax - nHPWounds;
	DB.setValue(nodeChar, "hp.current", "number", nHPCurrent);
	
	wounds.setColor(sColor);
	nonlethal.setColor(sColor);
end

function onSystemChanged()
	local bPFMode = DataCommon.isPFRPG();
	
	cmd.setVisible(bPFMode);
	label_cmd.setVisible(bPFMode);
	
	if label_grapple then
		if bPFMode then
			label_grapple.setValue(Interface.getString("cmb"));
		else
			label_grapple.setValue(Interface.getString("grp"));
		end
	end
	
	spot.setVisible(not bPFMode);
	label_spot.setVisible(not bPFMode);
	listen.setVisible(not bPFMode);
	label_listen.setVisible(not bPFMode);
	search.setVisible(not bPFMode);
	label_search.setVisible(not bPFMode);

	perception.setVisible(bPFMode);
	label_perception.setVisible(bPFMode);
end

function onLiveHP()
	if CompManagerAC.EXTENSIONS["FG-PFRPG-Live-Hitpoints"] then
		button_health.setVisible(true);
		livehitpoints.setVisible(false);
		
		NODETOTALHP = "livehp.total";
	end
end
