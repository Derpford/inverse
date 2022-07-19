class Railgun : Weapon replaces RocketLauncher {
    // A powerful zappy thing. Uses 5 Cell Ammo per charge level, doing 80 damage with no charge and doubling that for each charge level.
    int charge; // Goes from 0 to 3.
    int progress; // Counts up as we charge.
    default {
        Inventory.PickupMessage "You got the Charge Railgun!";
        Weapon.SlotNumber 5;
        Weapon.AmmoType "Cell";
        Weapon.AmmoUse 5; // Per charge level.
        Weapon.AmmoGive 40;
    }

    action void RailReady() {
        invoker.charge = 0;
        invoker.progress = 0;
        A_WeaponReady();
    }

    action void RailCharge() {
        invoker.progress += 1;
        if(invoker.progress > 10) {
            invoker.progress = 0;
            if (CountInv("Cell") > invoker.ammouse1 * (invoker.charge + 1)) {
                // We have enough ammo to increase the charge level.
                invoker.charge = min(invoker.charge + 1,3);
            }
            double p = 1 + (invoker.charge / 10.);
            A_GunFlash();
            A_StartSound("weapons/plasmax",1,pitch:p);
        }
    }

    action void RailShot() {
        int dmg = 80 * (2 ** invoker.charge);
        A_RailAttack(dmg,useammo:false,color1:"FFFFFF",color2:"00AAFF");
        A_TakeInventory("Cell",invoker.ammouse1 * (invoker.charge + 1));
        double p = 1.2 - (invoker.charge * .05);
        A_StartSound("weapons/bfgx",1,pitch:p);
        A_GunFlash();
        A_WeaponOffset(0,52);
    }

    states {
        Spawn:
            PLAS A -1;
            Stop;

        Select:
            PLSG B 1 A_Raise(20);
            Loop;
        Deselect:
            PLSG B 1 A_Lower(20);
            Loop;
        
        Ready:
            PLSG A 1 RailReady();
            Loop;
        
        Fire:
        Hold:
            PLSG A 1 RailCharge();
            PLSG A 1 A_Refire();
        Shoot:
            PLSG A 10 RailShot();
            PLSG B 25 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            Goto Ready;

        Flash:
            PLSF AB 4 Bright A_Light1();
            Goto LightDone;
        
    }
}