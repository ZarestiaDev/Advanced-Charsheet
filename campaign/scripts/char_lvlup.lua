function onButtonPress()
    local nodeChar = window.getDatabaseNode();
    local nodeParent = DB.getParent(DB.getParent(nodeChar));
    local sClass, sRecord = DB.getValue(nodeChar, "shortcut", "");

    if sClass == "referenceclass" then
        CharManager.addInfoDB(nodeParent, sClass, sRecord);
    end
end
