property text : Text
property reasoning_content : Text
property tool_calls : Collection
property wavplay : cs:C1710.wavplay.wavplay
property _USE_TEMP_FILE : Boolean

Class constructor
	
	This:C1470.wavplay:=cs:C1710.wavplay.wavplay.new()
	
Function spoken($worker : 4D:C1709.SystemWorker; $params : Object)
	
	If (Form:C1466=Null:C1517)
		return 
	End if 
	
	If (Form:C1466._USE_TEMP_FILE)
		var $file : 4D:C1709.File
		$file:=$params.context
		$file.delete()
	End if 
	
	OBJECT SET ENABLED:C1123(*; "btn.@"; True:C214)
	
Function response($request : 4D:C1709.HTTPRequest; $event : Object)
	
	If (Form:C1466=Null:C1517)
		return 
	End if 
	
	OBJECT SET ENABLED:C1123(*; "btn.@"; False:C215)
	
	If ($request.response.status=200)
		If (Form:C1466._USE_TEMP_FILE)
			$file:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).file(Generate UUID:C1066+".wav")
			$file.setContent($request.response.body)
			Form:C1466.wavplay.play({file: $file; data: $file}; Form:C1466.spoken)
		Else 
			Form:C1466.wavplay.play({file: $request.response.body; data: $request.body.input}; Form:C1466.spoken)
		End if 
	End if 
	
Function demo()
	
	If (Form:C1466.text="")
		return 
	End if 
	
	var $request : Object
	$request:={}
	$request.input:=Form:C1466.text
	$request.voice:=Form:C1466.voice.currentValue
	$request.speed:=Form:C1466.speed/100
	
	var $url : Text
	$url:="http://127.0.0.1:8080/v1/audio/speech"
	
	var $options : Object
	$options:={}
	$options.body:=$request
	$options.onResponse:=This:C1470.response
	$options.method:="POST"
	
	4D:C1709.HTTPRequest.new($url; $options)