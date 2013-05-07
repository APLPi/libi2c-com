:Namespace I2C
	⍝ Converted from the quick2wire-python-api
	⍝ For more information see https://github.com/quick2wire/quick2wire-python-api

	'OpenI2C' ⎕NA 'I libi2c-com.so|OpenI2C I I =I'
	'CloseI2C' ⎕NA 'I libi2c-com.so|CloseI2C =I'
	'WriteBytes' ⎕NA 'I libi2c-com.so|WriteBytes I <#U1[256] =I'
	'ReadBytes' ⎕NA 'I libi2c-com.so|ReadBytes I >#U1[256] =I'
:EndNamespace