-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
    if super and super.onInit then
        super.onInit();
    end

    onSystemChanged();
end

function onSystemChanged()
    if super and super.onSystemChanged then
        super.onSystemChanged();
    end

	local bPFMode = DataCommon.isPFRPG();
	
	if bPFMode then
		acframe.setStaticBounds(15,0,570,210);
	else
		acframe.setStaticBounds(15,0,570,140);
        saveframe.setStaticBounds(15,140,380,120);
        attackframe.setStaticBounds(15,260,380,150);
        srframe.setStaticBounds(395,140,130,90);
        speedframe.setStaticBounds(395,230,130,90);
        initiativeframe.setStaticBounds(395,320,130,90);
	end
end
