-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

--
--	INITIALIZATION AND HELPERS
--

local _tData;
function initData(tData)
	if not tData then
		return;
	end

	_tData = UtilityManager.copyDeep(tData);

	self.updatePortraitWidget();
	self.updateDisplay();
	self.setMenuItems();

	for _,fn in pairs(CharacterListManager.getDecorators()) do
		fn(self);
	end
	
	local sIdentity = CharacterListManager.convertPathToIdentity(_tData.sPath);
	if sIdentity then
		for _,fn in pairs(CharacterListManager.getLegacyDecorators()) do
			fn(self, sIdentity);
		end
	end
end
function updateData(tData)
	_tData = UtilityManager.copyDeep(tData);
	self.updateDisplay();
	self.setMenuItems();
end

function getData()
	return _tData;
end
function getRecordPath()
	if not _tData then
		return nil;
	end
	return _tData.sPath;
end
function getRecordNode()
	if not _tData or ((_tData.sPath or "") == "") then
		return nil;
	end
	return DB.findNode(_tData.sPath);
end
function getName()
	if not _tData then
		return "";
	end
	return _tData.sName or _tData.sUser or "";
end
function isActiveAndOwned()
	if not _tData or not _tData.sPath then
		return false;
	end
	if Session.IsHost then
		return true;
	end
	local sIdentity = CharacterListManager.convertPathToIdentity(_tData.sPath);
	if not sIdentity then
		return DB.isOwner(_tData.sPath);
	end
	return User.isOwnedIdentity(sIdentity);
end

local _sState = "";
function getActiveState()
	return _sState;
end
function setActiveState(sState)
	_sState = sState;
	self.updateStateWidget();
end

function updateDisplay()
	self.updatePortraitWidget();
	self.updateNameWidget();
	self.updateColorWidget();
end

function updatePortraitWidget()
	local sIdentity = CharacterListManager.convertPathToIdentity(self.getRecordPath());
	local wgt = findWidget("portrait");
	if wgt then
		if not sIdentity then
			wgt.destroy();
			wgt = nil;
		end
	else
		if sIdentity then
			wgt = addBitmapWidget({ name = "portrait", icon = "portrait_" .. sIdentity .. "_charlist", });
			-- Change by Zarestia to set the portait size
			wgt.setSize(CharacterListManager.PORTRAIT_SIZE, CharacterListManager.PORTRAIT_SIZE);
		end
	end

	if wgt then
		local sUser = _tData and _tData.sUser;
		if (sUser or "") == "" then
			wgt.setColor("80FFFFFF");
		else
			wgt.setColor(nil);
		end
	end
end
function updateNameWidget()
	local bCurrent = _tData and _tData.bCurrent or false;
	local sName = _tData and _tData.sName;
	local sUser = _tData and _tData.sUser;

	local wgt = findWidget("name");
	if not wgt then
		wgt = addTextWidget({
			name = "name",
			font = CharacterListManager.CHARLIST_NAME_WIDGET_FONT, text = "",
			frame = CharacterListManager.CHARLIST_NAME_WIDGET_FRAME, frameoffset = CharacterListManager.CHARLIST_NAME_WIDGET_FRAME_OFFSET,
			position = CharacterListManager.CHARLIST_NAME_WIDGET_POSITION, 
			x = CharacterListManager.CHARLIST_NAME_WIDGET_X, y = CharacterListManager.CHARLIST_NAME_WIDGET_Y, 
			w = CharacterListManager.CHARLIST_NAME_WIDGET_W,
		});
	end

	if sUser and not sName then
		wgt.setText(sUser);
		wgt.setTooltipText(sUser);
		wgt.setFont(CharacterListManager.CHARLIST_NAME_WIDGET_FONT_CURRENT);
	else
		if (sName or "") == "" then
			sName = Interface.getString("library_recordtype_empty_charsheet");
		end
		wgt.setText(sName);
		wgt.setTooltipText(sName);

		if bCurrent then
			wgt.setFont(CharacterListManager.CHARLIST_NAME_WIDGET_FONT_CURRENT);
		else
			wgt.setFont(CharacterListManager.CHARLIST_NAME_WIDGET_FONT);
		end
	end
end
function updateColorWidget()
	local sColor = _tData and _tData.sColor or nil;
	
	local wgtBase = findWidget("colorbase");
	local wgtColor = findWidget("color");
	local wgtEffect = findWidget("coloreffect");
	if sColor then
		if not wgtBase then
			wgtBase = addBitmapWidget({ 
				name="colorbase", 
				icon = "colorgizmo_bigbtn_base", 
				position = CharacterListManager.CHARLIST_COLOR_WIDGET_POSITION, 
				x = CharacterListManager.CHARLIST_COLOR_WIDGET_X, y = CharacterListManager.CHARLIST_COLOR_WIDGET_Y,
				w = CharacterListManager.CHARLIST_COLOR_WIDGET_W, h = CharacterListManager.CHARLIST_COLOR_WIDGET_H, 
			});
		end
		if not wgtColor then
			wgtColor = addBitmapWidget({ 
				name="color", 
				icon = "colorgizmo_bigbtn_color", 
				position = CharacterListManager.CHARLIST_COLOR_WIDGET_POSITION, 
				x = CharacterListManager.CHARLIST_COLOR_WIDGET_X, y = CharacterListManager.CHARLIST_COLOR_WIDGET_Y,
				w = CharacterListManager.CHARLIST_COLOR_WIDGET_W, h = CharacterListManager.CHARLIST_COLOR_WIDGET_H, 
			});
		end
		if not wgtEffect then
			wgtEffect = addBitmapWidget({ 
				name="coloreffect", 
				icon = "colorgizmo_bigbtn_effects", 
				position = CharacterListManager.CHARLIST_COLOR_WIDGET_POSITION, 
				x = CharacterListManager.CHARLIST_COLOR_WIDGET_X, y = CharacterListManager.CHARLIST_COLOR_WIDGET_Y,
				w = CharacterListManager.CHARLIST_COLOR_WIDGET_W, h = CharacterListManager.CHARLIST_COLOR_WIDGET_H, 
			});
		end
		wgtColor.setColor(sColor);
	else
		if wgtBase then
			wgtBase.destroy();
		end
		if wgtColor then
			wgtColor.destroy();
		end
		if wgtEffect then
			wgtEffect.destroy();
		end
	end
end
function updateStateWidget()
	local sState = self.getActiveState();
	local sBitmap = "";
	if sState == "idle" then
		sBitmap = "charlist_idling";
	elseif sState == "typing" then
		sBitmap = "charlist_typing";
	elseif sState == "afk" then
		sBitmap = "charlist_afk";
	end

	local wgt = findWidget("state");
	if sBitmap ~= "" then
		if not wgt then
			wgt = addBitmapWidget({
				name="state", 
				position = CharacterListManager.CHARLIST_STATE_WIDGET_POSITION, 
				x = CharacterListManager.CHARLIST_STATE_WIDGET_X, y = CharacterListManager.CHARLIST_STATE_WIDGET_Y, 
			});
		end
		wgt.setBitmap(sBitmap);
	else
		if wgt then
			wgt.destroy();
		end
	end
end

--
--	UI
--

function setMenuItems()
	if resetMenuItems and registerMenuItem then
		resetMenuItems();
		if Session.IsHost then
			registerMenuItem(Interface.getString("charlist_menu_whisper"), "broadcast", 3);
			if _tData and ((_tData.sUser or "") ~= "") then
				registerMenuItem(Interface.getString("charlist_menu_ring"), "bell", 4);
				registerMenuItem(Interface.getString("charlist_menu_kick"), "kick", 6);
				registerMenuItem(Interface.getString("charlist_menu_kickconfirm"), "kickconfirm", 6, 7);
			end
		elseif self.isActiveAndOwned() then
			registerMenuItem(Interface.getString("charlist_menu_afk"), "hand", 3);
			registerMenuItem(Interface.getString("charlist_menu_color"), "pointer_circle", 4);
			registerMenuItem(Interface.getString("charlist_menu_release"), "erase", 6);
		elseif _tData and ((_tData.sUser or "") ~= "") then
			registerMenuItem(Interface.getString("charlist_menu_whisper"), "broadcast", 3);
		end
	end
end
function onMenuSelection(selection, subselection)
	if selection == 3 then
		if Session.IsHost or not self.isActiveAndOwned() then
			ChatManager.sendWhisperToName(self.getName());
		else
			CharacterListManager.toggleAFK();
		end
	else
		if Session.IsHost then
			if selection == 4 then
				User.ringBell(_tData.sUser);
			elseif selection == 6 and subselection == 7 then
				User.kick(_tData.sUser);
			end
		elseif self.isActiveAndOwned() then
			if selection == 4 then
				self.setCurrentIdentity();
				Interface.openWindow("colorselect", "");
			elseif selection == 6 then
				self.releaseIdentity();
			end
		end
	end
end

function onClickDown(button, x, y)
	return true;
end
function onClickRelease(button, x, y)
	if Session.IsHost then
		self.bringCharacterToTop();
	elseif self.isActiveAndOwned() then
		self.setCurrentIdentity();
		local aOwned = User.getOwnedIdentities();
		if #aOwned == 1 then
			self.bringCharacterToTop();
		end
	end
	return true;
end
function onDoubleClick(x, y)
	if self.isActiveAndOwned() then
		self.bringCharacterToTop();
	end
	return true;
end
function onDragStart(button, x, y, draginfo)
	if self.isActiveAndOwned() then
		return RecordAssetManager.handlePictureDragStart(self.getRecordPath(), draginfo);
	end
end
function onDrop(x, y, draginfo)
	return CharacterListManager.processDrop(_tData, draginfo);
end

--
--	FEATURES
--

function setCurrentIdentity()
	local sIdentity = CharacterListManager.convertPathToIdentity(self.getRecordPath());
	if sIdentity then
		UserManager.activatePlayerID(sIdentity);
	end
end
function releaseIdentity()
	local sIdentity = CharacterListManager.convertPathToIdentity(self.getRecordPath());
	if sIdentity then
		User.releaseIdentity(sIdentity);
	end
end
function bringCharacterToTop()
	local rActor = ActorManager.resolveActor(self.getRecordPath());
	if not rActor then
		return;
	end
	Interface.openWindow(ActorManager.getRecordType(rActor), ActorManager.getCreatureNodeName(rActor));
end

-- DEPRECATED - 2023-12-12 (Long Release) - 2024-05-28 (Chat Notice)

function getIdentityPath()
	Debug.console("characterlist_entry.lua:getIdentityPath - DEPRECATED - 2023-12-12 - Use characterlist_entry.lua:getRecordPath");
	ChatManager.SystemMessage("characterlist_entry.lua:getIdentityPath - DEPRECATED - 2023-12-12 - Contact ruleset/extension/forge author");
	return self.getRecordPath();
end
