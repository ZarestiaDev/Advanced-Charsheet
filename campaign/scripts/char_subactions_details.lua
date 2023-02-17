-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	registerMenuItem(Interface.getString("menu_addspellclass"), "insert", 5);
	
	self.updateAbility();

	local node = getDatabaseNode();
	ActionsTab = parentcontrol.window.getClass();
	
	DB.addHandler(DB.getPath(node, "abilities"), "onChildUpdate", updateAbility);
	
	if ActionsTab == "char_spells" then
		DB.addHandler(DB.getPath(node, "spellset"), "onChildUpdate", updateAbility);
	elseif ActionsTab == "char_weapons" then
		registerMenuItem(Interface.getString("menu_addweapon"), "insert", 3);
		DB.addHandler(DB.getPath(node, "weaponspellset"), "onChildUpdate", updateAbility);
		DB.addHandler(DB.getPath(node, "weaponlist"), "onChildUpdate", updateAbility);
	elseif ActionsTab == "char_items" then
		DB.addHandler(DB.getPath(node, "itemspellset"), "onChildUpdate", updateAbility);
	elseif ActionsTab == "char_others" then
		DB.addHandler(DB.getPath(node, "otherspellset"), "onChildUpdate", updateAbility);
	end
end

function onClose()
	local node = getDatabaseNode();
	DB.removeHandler(DB.getPath(node, "abilities"), "onChildUpdate", updateAbility);
	
	if ActionsTab == "char_spells" then
		DB.removeHandler(DB.getPath(node, "spellset"), "onChildUpdate", updateAbility);
	elseif ActionsTab == "char_weapons" then
		DB.removeHandler(DB.getPath(node, "weaponspellset"), "onChildUpdate", updateAbility);
	elseif ActionsTab == "char_items" then
		DB.removeHandler(DB.getPath(node, "itemspellset"), "onChildUpdate", updateAbility);
	elseif ActionsTab == "char_others" then
		DB.removeHandler(DB.getPath(node, "otherspellset"), "onChildUpdate", updateAbility);
	end
end

function onMenuSelection(selection)
	if selection == 3 then
		self.addWeapon();
	elseif selection == 5 then
		self.addSpellClass();
	end
end

function addSpellClass()
	local w = spellclasslist.createWindow();
	if w then
		w.activatedetail.setValue(1);
		w.label.setFocus();
		DB.setValue(getDatabaseNode(), "spellmode", "string", "standard");
	end
end

function addWeapon()
	local w = weaponlist.createWindow();
	if w then
		w.name.setFocus();
	end
end

local bUpdateLock = false;
function updateAbility()
	if bUpdateLock then
		return;
	end
	bUpdateLock = true;
	for _,v in pairs(spellclasslist.getWindows()) do
		v.onStatUpdate();
	end
	if weaponlist then
		for _,v in pairs(weaponlist.getWindows()) do
			v.onDataChanged();
		end
	end
	bUpdateLock = false;
end
