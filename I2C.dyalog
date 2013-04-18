:Namespace I2C
	⍝ Converted from the quick2wire-python-api
	⍝ For more information see https://github.com/quick2wire/quick2wire-python-api

	'OpenI2C' ⎕NA 'libi2c-admin.so|OpenI2C I I =I'
	'CloseI2C' ⎕NA 'libi2c-admin.so|CloseI2C =I'
	'WriteBytes' ⎕NA 'libi2c-admin.so|WriteBytes I <#U1[] =I'
	'ReadBytes' ⎕NA 'libi2c-admin.so|ReadBytes I I =I =I'
	
:EndNamespace