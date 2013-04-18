:Namespace MultiCounter
	⍝ Converted from the quick2wire-python-api
	⍝ For more information see https://github.com/quick2wire/quick2wire-python-api
	
	⍝ Dependencies
	⍝∇:require =/../I2C
	
	I2C_BUS←1
	IODIR_REGISTER_B←1
	GPIO_REGISTER_B←19
	ADDRESS←32
	
	∇ ret←main;⎕IO;ret;funret;funerr
		⎕IO←0
		ret←0
		
		funret funerr ← #.I2C.OpenI2C I2C_BUS 0 0
		:If funret≢0
			ret←funerr
			→clean
		:EndIf
		
		funret funerr ← #.I2C.WriteBytes ADDRESS (IODIR_REGISTER_B 0) 0
		{funret funerr ← #.I2C.WriteBytes ADDRESS (GPIO_REGISTER_B ⍵) 0 ⋄ ⎕DL 0.1}¨⍳256
		funret funerr ← #.I2C.WriteBytes ADDRESS (GPIO_REGISTER_B 0) 0
		
		clean:         ⍝ Tidy Up
		funret funerr ← #.I2C.CloseI2C 0
	∇
:EndNamespace