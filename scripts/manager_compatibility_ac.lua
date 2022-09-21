EXTENSIONS = {};

function onInit()
    for index, name in pairs(Extension.getExtensions()) do
		EXTENSIONS[name] = index;
	end
end
