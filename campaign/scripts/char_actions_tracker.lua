function onButtonPress()
    local sAction = self.getName();
    local sUp = "buttonup";
    local sDown = "buttondown";

    if getName() == "reset" then
        window.standard.setFrame(sUp, 5,5,5,5);
        window.move.setFrame(sUp, 5,5,5,5);
        window.fullround.setFrame(sUp, 5,5,5,5);
        window.swift.setFrame(sUp, 5,5,5,5);
    else
        setFrame(sDown, 5,5,5,5)
    end

    if sAction == "standard" or sAction == "move" then
        window.fullround.setFrame(sDown, 5,5,5,5);
    elseif sAction == "fullround" then
        window.standard.setFrame(sDown, 5,5,5,5);
        window.move.setFrame(sDown, 5,5,5,5);
    end
end
