function onInit()
	onWinnowingPursuits();
end

function onModeChanged()
	weapons.subwindow.weaponlist.onModeChanged();
end

function onWinnowingPursuits()
	local nBottomOffset = -2;

	if CompManagerAC.EXTENSIONS["WinnowingPursuits"] then
		nBottomOffset = -50;

		if weapons then
			weapons.setAnchor("bottom", "", "bottom", "", nBottomOffset);
		end
	end
end
