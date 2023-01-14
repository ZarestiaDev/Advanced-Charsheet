function onInit()
    registerOptionsAC();
end

function registerOptionsAC()
    OptionsManager.registerOption2("ACCI",true, "option_header_ac", "option_label_ACCI", "option_entry_cycler", 
    { labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });

    OptionsManager.registerOption2("ACAT",true, "option_header_ac", "option_label_ACAT", "option_entry_cycler", 
    { labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });

    if CompManagerAC.RULESET == "PFRPG" then
        OptionsManager.registerOption2("ACHP",false, "option_header_ac", "option_label_ACHP", "option_entry_cycler", 
        { labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });
	end
end