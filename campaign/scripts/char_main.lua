-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

NODETOTALHP = "hp.total";

function onInit()
	onSystemChanged();

	onLiveHP();
	onDrainPermanentBonus();
end

function onHealthChanged()
	local nodeChar = getDatabaseNode();
	local sColor = ActorManager35E.getPCSheetWoundColor(nodeChar);

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

function onDrainPermanentBonus()
	if CompManagerAC.EXTENSIONS["FG-PFRPG-Drain-and-Permanent-Bonuses"] then
		abilityframe.setStaticBounds(15,0,245,244);
		hpframe.setStaticBounds(261,0,-29,180);
		initframe.setStaticBounds(261,180,71,64);
		acframe.setStaticBounds(332,180,-29,64);

		strength_label.setValue(Interface.getString("str"));
		dexterity_label.setValue(Interface.getString("dex"));
		constitution_label.setValue(Interface.getString("con"));
		intelligence_label.setValue(Interface.getString("int"));
		wisdom_label.setValue(Interface.getString("wis"));
		charisma_label.setValue(Interface.getString("cha"));

		strength_label.setAnchoredWidth(70);
		dexterity_label.setAnchoredWidth(70);
		constitution_label.setAnchoredWidth(70);
		intelligence_label.setAnchoredWidth(70);
		wisdom_label.setAnchoredWidth(70);
		charisma_label.setAnchoredWidth(70);

		strength.setAnchor("left", "", "left", "", 64);
		speedfinal.setAnchor("left", "ac", "left", "", -30)
	end
end