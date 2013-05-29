:Class BarLED
   ⍝ Drive a bar LED board via I2C, using the Quick2Wire interface boards
   ⍝ http://quick2wire.com/2013/01/make-your-own-bar-led-board/
   ⍝∇:require =/I2C
       
    (⎕IO ⎕ML)←1 1
    
    :Field Public Bits←8⍴0 ⍝ 8 LEDs
    :Field Public Delay←0  ⍝ How long to wait after set

    :Field Public Shared Demos←⎕NS ''
    
    ∇ Set arg;v
      :Access Public
      :Implements Trigger Bits                           
      ⎕SIGNAL(8≠⍴v←arg.NewValue)/5 ⍝ LENGTH ERROR
      {}#.I2C.WriteBytes I2C_ADDRESS(GPIO_REGISTER_B(2⊥v)0)0
      ⎕DL Delay
    ∇
         
    ∇ Make args;z
      :Access Public
      :Implements Constructor
     
      :If 0=⍴args
          args←1 32 1 19
      :EndIf
     
      (I2C_BUS I2C_ADDRESS IODIR_REGISTER_B GPIO_REGISTER_B)←args
     
      z←#.I2C.Init ⍬
      z←#.I2C.Open I2C_BUS 0 0
      z←#.I2C.WriteBytes I2C_ADDRESS(IODIR_REGISTER_B 0)0
      Bits←8⍴1 ⋄ ⎕DL 0.1 ⍝ Flash
      Bits←8⍴0           ⍝ Clear
    ∇
    
    ∇ UnMake;z
      :Implements Destructor     
      :If 1=⍴⎕INSTANCES⊃⊃⎕CLASS ⎕THIS ⍝ If we are the last instance
          Bits←8⍴0
          z←#.I2C.Close 0
      :EndIf
    ∇
   
    ∇ {DL}Play pattern;show;play;LED
      :Access Shared Public
     
      LED←⎕NEW ⎕THIS ⍬
      :If 2=⎕NC'DL' ⋄ LED.Delay←DL ⋄ :EndIf
     
      LED{⍺.Bits←8⍴⍵}¨pattern,⊂8⍴0
    ∇
    

:EndClass