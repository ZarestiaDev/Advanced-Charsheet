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
		acframe.setStaticBounds(0,0,540,210);
	else
		acframe.setStaticBounds(0,0,540,140);
        saveframe.setStaticBounds(0,140,380,120);
        attackframe.setStaticBounds(0,260,380,150);
        srframe.setStaticBounds(380,140,130,90);
        speedframe.setStaticBounds(380,230,130,90);
        initiativeframe.setStaticBounds(380,320,130,90);
	end
end
