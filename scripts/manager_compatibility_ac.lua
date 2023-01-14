EXTENSIONS = {};
RULESET = "";

function onInit()
    for index, name in pairs(Extension.getExtensions()) do
		EXTENSIONS[name] = index;
	end
	RULESET = User.getRulesetName();
end
