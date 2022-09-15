function createWidgets(sIdentity)
	if super and super.createWidgets then
        super.createWidgets();
    end

	portraitwidget = addBitmapWidget("portrait_" .. sIdentity .. "_charlist");
	portraitwidget.setSize(72,72);
end
