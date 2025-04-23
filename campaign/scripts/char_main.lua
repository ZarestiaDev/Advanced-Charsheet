-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

NODETOTALHP = "hp.total";

function onInit()
	self.onLevelChanged();
	self.onSystemChanged();
	self.onLockModeChanged(WindowManager.getWindowReadOnlyState(self));

	DB.addHandler(DB.getPath(getDatabaseNode(), "classes"), "onChildUpdate", self.onLevelChanged);

	onLiveHP();
	onDrainPermanentBonus();
	onMaladyTracker();
end

function onClose()
	DB.removeHandler(DB.getPath(getDatabaseNode(), "classes"), "onChildUpdate", self.onLevelChanged);
end

function onLockModeChanged(bReadOnly)
	local tFieldsAbility = { "strength", "dexterity", "constitution", "intelligence", "wisdom", "charisma", };
	local tFieldsAbilityBonus = { "strengthbonus", "dexteritybonus", "constitutionbonus", "intelligencebonus", "wisdombonus", "charismabonus", };
	local tFieldsAbilityDamage = { "strengthdamage", "dexteritydamage", "constitutiondamage", "intelligencedamage", "wisdomdamage", "charismadamage", };
	local tFieldsHealth = { "hp", };
	--local tFieldsHealth = { "wounds", "hptemp", "nonlethal", };
	local tFieldsOther = { "speedfinal", "speedspecial", "senses", };

	WindowManager.callSafeControlsSetLockMode(self, tFieldsAbility, bReadOnly);
	WindowManager.callSafeControlsSetLockMode(self, tFieldsAbilityBonus, bReadOnly);
	WindowManager.callSafeControlsSetLockMode(self, tFieldsAbilityDamage, bReadOnly);
	WindowManager.callSafeControlsSetLockMode(self, tFieldsHealth, bReadOnly);
	WindowManager.callSafeControlsSetLockMode(self, tFieldsOther, bReadOnly);

	if UtilityManager.getTopWindow(self).getClass() == "charsheetmini" then
		local tFieldsCombat = { "initiative", "melee", "ranged", "grapple", };
		local tFieldsDefense = { "ac", "srfinal", "fortitude", "reflex", "will", };
		WindowManager.callSafeControlsSetLockMode(self, tFieldsCombat, bReadOnly);
		WindowManager.callSafeControlsSetLockMode(self, tFieldsDefense, bReadOnly);
	else
		local tFieldsTop = { "race", };
		local tFieldsCombat = { "initiative", "meleemainattackbonus", "rangedmainattackbonus", "grappleattackbonus", }
		local tFieldsDefense = { "dr", "ac", "spellresistance", "fortitude", "reflex", "will", "resistances", "immunities1", "immunities2"};
		WindowManager.callSafeControlsSetLockMode(self, tFieldsTop, bReadOnly);
		WindowManager.callSafeControlsSetLockMode(self, tFieldsCombat, bReadOnly);
		WindowManager.callSafeControlsSetLockMode(self, tFieldsDefense, bReadOnly);
	end
end

function onLevelChanged()
	CharManager.calcLevel(getDatabaseNode());
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
		elseif minisheet then
			label_grapple.setValue(Interface.getString("grp"));
		else
			label_grapple.setValue(Interface.getString("grapple"));
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

function onDrop(x, y, draginfo)
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"referenceclass", "referencerace"}, sClass) then
			CharManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
			return true;
		end
	end
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
		abilityframe.setStaticBounds(0,0,245,244);
		hpframe.setStaticBounds(246,0,-1,180);
		initframe.setStaticBounds(246,180,71,64);
		acframe.setStaticBounds(317,180,-1,64);
		combatframe.setStaticBounds(0,244,245,64);
		saveframe.setStaticBounds(0,308,245,64);
		babframe.setStaticBounds(246,244,71,64);
		srframe.setStaticBounds(246,308,71,64);
		sensesframe.setStaticBounds(317,308,-1,64);
		speedframe.setStaticBounds(317,244,-1,64);

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
		-- speedfinal.setAnchor("left", "ac", "left", "", -30)
	end
end

function onMaladyTracker()
	if CompManagerAC.EXTENSIONS["FG-PFRPG-Malady-Tracker"] then
		pc_diseases.setAnchor("left", "leftanchor", "right", "relative", 5);
	end
end
