function onFirstLayout()
    OptionsManager.registerCallback("ACCI", stateChanged);

    stateChanged();

    DB.addHandler(DB.getPath(getDatabaseNode().getChild("...."), "classes"), "onChildUpdate", stateChanged);
end

function onClose()
    OptionsManager.unregisterCallback("ACCI", stateChanged);

	DB.removeHandler(DB.getPath(getDatabaseNode().getChild("...."), "classes"), "onChildUpdate", stateChanged);
end

function stateChanged()
    local nodeChar = window.getDatabaseNode();

    if OptionsManager.isOption("ACCI", "on") then
        setIdentifier(nodeChar);
    else
        resetIdentifier(nodeChar);
    end
end

function getClasses(nodeChar)
    local rActor = nodeChar.getChild("...");
    local nClasses = DB.getChildCount(rActor.getChild("classes"));
    
    return nClasses;
end

function setIdentifier(nodeChar)
    if getClasses(nodeChar) <= 1 then
        return;
    end

    local sName = DB.getValue(nodeChar, "name", "");
    if sName:match("^%[.*%]") then
        return;
    end

    local sSource = DB.getValue(nodeChar, "source", "");
    if sSource == "" then
        return;
    end

    local sAbbr = "";
    for abbr, class in pairs(DataCommon.class_stol) do
        if class == sSource:lower() then
            sAbbr = abbr;
            break;
        else
            sAbbr = sSource:sub(1,3);
        end
    end

    DB.setValue(nodeChar, "name", "string", "[" .. sAbbr:upper() .. "] " .. sName);
end

function resetIdentifier(nodeChar)
    local sName = DB.getValue(nodeChar, "name", "");
    if sName:match("%[") then
        sName = sName:gsub("^%b[]%s", "");
        
        DB.setValue(nodeChar, "name", "string", sName);
    end
end