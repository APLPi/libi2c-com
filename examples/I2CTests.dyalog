:Namespace I2CTests
	⍝ Converted from the quick2wire-python-api
	⍝ For more information see https://github.com/quick2wire/quick2wire-python-api
	
	⍝ Dependencies
	⍝∇:require =/../I2C
	
	I2C_BUS←1
	IODIR_REGISTER_B←1
	GPIO_REGISTER_B←19
	ADDRESS←32
	
	∇ ret←GPIORegisterReadWriteTest i;ret;funret;funout;funerr;msg
		ret←0
		
		funret funout funerr ← #.I2C.ReadBytes ADDRESS (,GPIO_REGISTER_B) (,1) 0
		msg←'Value at GPIORegister is ',(⍕funout),'. Setting it to ',(⍕i),':'
		
		funret funerr ← #.I2C.WriteBytes ADDRESS (GPIO_REGISTER_B i) 0
		funret funout funerr ← #.I2C.ReadBytes ADDRESS (,GPIO_REGISTER_B) (,1) 0
		:IF funout≡i
			msg,←' Success'
		:Else
			msg,←' Failure'
			ret←1
		:EndIf
		
		msg
	∇
	
	∇ ret←GPIORegisterReadWriteTests;ret;funret;funerr
		ret←0
		
		funret funerr ← #.I2C.OpenI2C I2C_BUS 0 0
		:If funret≢0
			ret←funerr
			→clean
		:EndIf
		
		funret funerr ← #.I2C.WriteBytes ADDRESS (IODIR_REGISTER_B 0) 0
		{funret funerr ← GPIORegisterReadWriteTest ⍵ ⋄ ⎕DL 0.1}¨⍳255
		funret funerr ← #.I2C.WriteBytes ADDRESS (GPIO_REGISTER_B 0) 0
		
		clean:         ⍝ Tidy Up
		funret funerr ← #.I2C.CloseI2C 0
	∇
	
	∇ ret←main;ret;funret
		ret←0
		
		⍝	Tests
		funret←GPIORegisterReadWriteTests
	∇
:EndNamespace