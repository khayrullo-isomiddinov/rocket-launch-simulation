with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package Util is

   protected Printer is
      procedure Print(S : in String);
   end Printer;
   
   protected Gen_Failure is
      procedure Init;
      function Failure return Boolean;
   private 
      G : Generator;
   end Gen_Failure;
   
   
   
end Util;
