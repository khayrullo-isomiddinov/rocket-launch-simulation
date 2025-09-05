with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package body Util is

   protected body Printer is
      procedure Print(S : in String) is
      begin
         Put_Line(S);
      end Print;
   end Printer;
   
   protected body Gen_Failure is
      procedure Init is
      begin
         Reset(G);
      end Init;
      
      function Failure return Boolean is
      begin
         return Random(G) < 0.0001;
      end Failure;
   end Gen_Failure;
   
end Util;
