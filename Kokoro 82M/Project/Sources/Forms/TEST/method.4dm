var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		var $LLM : cs:C1710.LLM
		$LLM:=cs:C1710.LLM.new(\
			Folder:C1567(fk home folder:K87:24).folder(".ONNX").folder("Kokoro-82M"); \
			"Kokoro-82M-onnx-f32"; \
			"keisuke-miyako/Kokoro-82M-onnx-f32"; \
			Current form window:C827; Formula:C1597(OnLLM))
		
		OBJECT SET VISIBLE:C603(*; "progress"; Not:C34($LLM.available))
		OBJECT SET VISIBLE:C603(*; "btn.@"; $LLM.available)
		
		Form:C1466.text:="Life is like a box of chocolates, you never know what you're gonna get."
		Form:C1466.speed:=100
		
		var $voice : Object
		$voice:={}
		$voice.values:=[\
			"af_sky"; \
			"af_sarah"; \
			"af_bella"; \
			"af_nicole"; \
			"am_adam"; \
			"am_michael"; \
			"bf_isabella"; \
			"bf_emma"; \
			"bm_lewis"; \
			"bm_george"]
		$voice.index:=$voice.values.indexOf("bf_isabella")
		
		Form:C1466.voice:=$voice
		
End case 