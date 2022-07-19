class MachinePistol : Weapon replaces Shotgun {
    // A rapid-firing, reasonably accurate gun that fires in 3-shot bursts.
    default {
        Inventory.PickupMessage "You got a burst-firing machine pistol!";
        Weapon.SlotNumber 3;
        Weapon.AmmoType "Clip";
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 24;
    }

    action void MPShot() {
        A_FireBullets(2,2,1,12,flags:FBF_NORANDOM|FBF_USEAMMO);
        A_StartSound("weapons/pistol",1);
        A_GunFlash();
        A_WeaponOffset(0,48,WOF_INTERPOLATE);
    }

    states {
        Spawn:
            PIST A -1;
            Stop;
        
        Select:
            PISG A 1 A_Raise(30);
            Loop;

        DeSelect:
            PISG A 1 A_Lower(30);
            Loop;
        
        Ready:
            PISG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            PISG B 2 MPShot();
            PISG C 1 A_WeaponOffset(0,40,WOF_INTERPOLATE);
            PISG B 2 MPShot();
            PISG C 1 A_WeaponOffset(0,40,WOF_INTERPOLATE);
            PISG B 2 MPShot();
            PISG C 1 A_WeaponOffset(0,40,WOF_INTERPOLATE);
            PISG A 5 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            Goto Ready;
        
        Flash:
            PISF A 1 Bright A_Light1();
            Goto LightDone;
    }
}