:Namespace Spike
	⍝ Converted from the quick2wire-python-api
	⍝ For more information see https://github.com/quick2wire/quick2wire-python-api
	
	⍝ Dependencies
	⍝∇:require =/i2c-admin
	
	I2C_BUS←1
	ADDRESS←4
	
	∇ ret←main;⎕IO;ret;funret;funerr
		ret←0
		
		funret funerr ← #.I2C.OpenI2C I2C_BUS 0 0
		:If funret≢0
			ret←funerr
			→clean
		:EndIf
		
		GetInput
		
		clean:         ⍝ Tidy Up
		funret funerr ← #.I2C.CloseI2C 0
	∇
	
	∇ GetInput;⎕RTL
		⎕RTL←1
		
		'Started'
		input_loop:
		char←⊃⎕ARBIN ''
		
		:Select char
			:Case 113	⍝ 'q'
			→input_loop_end
			:Else
			funret funerr ← #.I2C.WriteBytes ADDRESS 1 char 0
		:EndSelect
		
		→input_loop
		
		input_loop_end:
		'Exited'
	∇	
	
:EndNamespace