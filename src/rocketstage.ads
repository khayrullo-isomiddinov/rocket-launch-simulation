with util; use util;
with Ada.Numerics.Discrete_Random; 

package RocketStage is
   
   protected type Propellant_Tank is
      procedure Init(O : Float; RF : Float);
      procedure D_O(T : Float);
      procedure D_RF(T : Float);
      function Get_P_O return Float;
      function Get_P_RF return Float;
   private
      Max_O : Float := 0.0;
      Max_RF : Float := 0.0;
      Current_O : Float := 0.0;
      Current_RF : Float := 0.0;
   end Propellant_Tank;
   
   type P_Tank is access Propellant_Tank;
   
   task type Raptor_Engine is
      entry Init(name : in String := ""; Num_Of_Engine : Integer; ptank : P_Tank);
      entry Engine_Start;
      entry Engine_Shut_Off;
   end Raptor_Engine;
   
   type Engine_Arr is array(Natural range<>) of Raptor_Engine;
   
   task type Stage(Num_Engines : Natural) is
      entry Init(name : String := ""; ptank : P_Tank);
      entry Start_Engines;
      entry MECO;
   end Stage;
   
   type PStage is access Stage;
   
end RocketStage;
