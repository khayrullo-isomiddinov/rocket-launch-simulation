with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Util; use Util;
with RocketStage; use RocketStage;

procedure Main is

   Catastrophic_Failure : exception;

   task Flight_Computer;

   task body Flight_Computer is
      Core_Stage_Tank   : P_Tank := new Propellant_Tank;
      Second_Stage_Tank : P_Tank := new Propellant_Tank;

      Core_Stage    : PStage := new Stage(33);
      Second_Stage  : PStage := new Stage(6);
   begin
      Gen_Failure.Init;
      Core_Stage_Tank.Init(3400.0, 700.0);
      Second_Stage_Tank.Init(1600.0, 330.0);
      Core_Stage.Init("Super Heavy Booster", Core_Stage_Tank);
      Printer.Print("Countdown:");
      for I in reverse 1..10 loop
         Printer.Print(Integer'Image(I));
         delay 1.0;
      end loop;
      Printer.Print("Main Engines on Super Heavy Booster starting...");
      Core_Stage.Start_Engines;
      Printer.Print("We have lift off!");

      loop
         delay 0.2;

         if Gen_Failure.Failure then
            Core_Stage.MECO;
            raise Catastrophic_Failure;
         end if;

         Printer.Print("Super Heavy Booster: Oxidizer percentage:  " & Float'Image(Core_Stage_Tank.Get_P_O));
         Printer.Print("Super_Heavy_Booster: Rocket percentage: " & Float'Image(Core_Stage_Tank.Get_P_RF));

         if Core_Stage_Tank.Get_P_O < 10.0 and Core_Stage_Tank.Get_P_RF < 10.0 then
            exit;
         end if;
      end loop;

      Core_Stage.MECO;
      delay 2.0;
      Printer.Print("Main engines on Super Heavy Booster shut down.");
      Printer.Print("Successful Stage Separation");

      Printer.Print("Main engines on Starship starting");
      Second_Stage.Init("Starship", Second_Stage_Tank);
      Second_Stage.Start_Engines;

      loop
         delay 0.2;

         if Gen_Failure.Failure then
            Second_Stage.MECO;
            raise Catastrophic_Failure;
         end if;

         Printer.Print("Starship: Oxidizer percentage: " & Float'Image(Second_Stage_Tank.Get_P_O));
         Printer.Print("Starship: Fuel percentage:     " & Float'Image(Second_Stage_Tank.Get_P_RF));

         if Second_Stage_Tank.Get_P_O < 10.0 and Second_Stage_Tank.Get_P_RF < 10.0 then
            exit;
         end if;

      end loop;

      Second_Stage.MECO;
      Printer.Print("Main engines on Starship shut down.");
      Printer.Print("Successful Orbit Insertion");

   exception
      when Catastrophic_Failure =>
         Printer.Print("EXPERIENCED CATASTROPHIC FAILURE - ABORTED MISSION");
   end Flight_Computer;

begin
   null;
end Main;
