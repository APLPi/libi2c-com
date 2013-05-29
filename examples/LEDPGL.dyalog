:Namespace LEDPGL
   ⍝ LED Pattern Generation Language 
   ⍝∇:require =/BarLED

    ⍝ Base patterns
    head←{⍵↑1}                                              
    tail←{⌽head ⍵}                                          
    binary←{↓[1](8⍴2)⊤⍵}

    ⍝ Intra-pattern transformations
    shift←{a←-⍺ ⋄ 2=≡⍵:a⌽¨⍵ ⋄ 1=⍴⍴a:a⌽¨⊂⍵ ⋄ a⌽⍵}            
    mirror←{2=≡⍵:∇¨⍵ ⋄ ⍵,⌽⍵}                                
    cycle←{⍺←⍴⍵ ⋄ (¯1+⍳⍺)shift ⍵}                           

    ⍝ Macro transformations
    pad←{⍵,⍺⍴⍵×0}                                           
    repeat←{⍺⍴⍵}                                            
    reverse←⌽                                               

    ⍝ Visualization
    show←{⍪{'.⎕'[1+8↑⍵]}¨⍵}                                   
    sim←{⎕SM←(8⍴'.')1 1 1 8 ⋄ {(⊃⎕SM)←'.⎕'[1+⍵] ⋄ ⎕DL 1}¨⍵} 

    ∇ Demo Delay;i;p;z;bl;reps
    ⍝ Patterns
      p←⊂'0 4 shift 4/1 0         ⍝ Left Right'
      p,←⊂'cycle 4 4/1 0           ⍝ Barber pole'
      p,←⊂'4 cycle 8 repeat head 4 ⍝ Ripple'
      p,←⊂'binary ⍳256             ⍝ Counter'
      p,←⊂'mirror cycle head 4     ⍝ Halves-in'
      p,←⊂'6 repeat 3 repeat x∨ reverse x←mirror cycle head 4 ⍝ Half-flip'
      p,←⊂'12 repeat ¯1↓x,1↓reverse x←mirror cycle head 4     ⍝ Out-In-Out'
     
      :If Delay≠0
          bl←⎕NEW #.BarLED ⍬
          bl.Delay←Delay
          reps←⌈3÷Delay ⍝ 3 seconds per pattern
      :EndIf
     
      :For i :In ⍳⍴p
          ⎕←'      ',i⊃p
          z←⍎i⊃p
          :If Delay≠0 ⋄ Delay bl.Play reps⍴z
          :Else ⋄ ⎕←show z
          :EndIf
      :EndFor
    ∇

:EndNamespace