function onCreatePost()
	reset = getProperty('camera.zoom')
end
function onEvent(name, value1, value2)
	if not lowQuality then
		ChartingMode = getPropertyFromClass('PlayState', 'chartingMode')
		

		davalue = tonumber(value1);
	
	if davalue == null then
		davalue = reset
	else
		davalue = davalue
	end
	
	
	
	
	if name == 'Zoom' then
		
		setProperty('defaultCamZoom', davalue)
			
			
	end
end
end