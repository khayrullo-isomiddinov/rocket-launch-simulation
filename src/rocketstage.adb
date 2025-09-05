with Ada.Calendar; use Ada.Calendar;

with Util; use Util;

package body RocketStage is

   protected body Propellant_Tank is
      procedure Init (O : Float; RF : Float) is
      begin
         Max_O      := O;
         Current_O  := O;
         Max_RF     := RF;
         Current_RF := RF;
      end Init;

      procedure D_O (T : Float) is
      begin
         Current_O := Float'Max (0.0, Current_O - (4.85 * T));
      end D_O;

      procedure D_RF (T : Float) is
      begin
         Current_RF := Float'Max (0.0, Current_RF - 1.0 * T);
      end D_RF;

      function Get_P_O return Float is
      begin
         if Max_O = 0.0 then
            return 0.0;
         else
            return (Current_O / Max_O) * 100.0;
         end if;
      end Get_P_O;

      function Get_P_RF return Float is
      begin
         if Max_RF = 0.0 then
            return 0.0;
         else
            return (Current_RF / Max_RF) * 100.0;
         end if;
      end Get_P_RF;
   end Propellant_Tank;

   task body Raptor_Engine is
      type PStr is access String;
      nameP       : PStr;
      Engines_Num : Integer := 0;
      Tank        : P_Tank;
      Running     : Boolean := False;
      Finished    : Boolean := False;

      Last_Time : Time     := Clock;
      Delta_T   : Duration := 0.0;

   begin
      accept Init
        (name : in String := ""; Num_Of_Engine : in Integer; ptank : in P_Tank)
      do
         nameP       := new String (1 .. name'Length);
         nameP.all   := name;
         Engines_Num := Num_Of_Engine;
         Tank        := ptank;
      end Init;

      accept Engine_Start do
         Printer.Print
           (nameP.all & " engine " & Integer'Image (Engines_Num) &
            " is starting");
         Running := True;
      end Engine_Start;

      loop
         select
            accept Engine_Shut_Off do
               Printer.Print
                 (nameP.all & " engine " & Engines_Num'Image &
                  " is shutting off");
               Finished := True;
            end Engine_Shut_Off;
         or
            delay 0.1;
            if Running and not Finished then
               declare
                  Now : constant Time := Clock;
               begin
                  Delta_T   := Duration (Now - Last_Time);
                  Last_Time := Now;

                  Tank.D_O (Float (Delta_T));
                  Tank.D_RF (Float (Delta_T));
               end;
            end if;
         end select;

         exit when Finished;
      end loop;
   end Raptor_Engine;

   task body Stage is
      Engines : Engine_Arr (1 .. Num_Engines);
   begin
      accept Init (name : in String := ""; ptank : in P_Tank) do
         for I in Engines'Range loop
            Engines (I).Init (name, I, ptank);
         end loop;
      end Init;

      accept Start_Engines do
         for I in Engines'Range loop
            Engines (I).Engine_Start;
         end loop;

      end Start_Engines;

      accept MECO do
         for I in Engines'Range loop
            Engines (I).Engine_Shut_Off;
         end loop;
      end MECO;
   end Stage;

end RocketStage;
