class SubGun : Weapon replaces Shotgun {
    // A rapid-firing, reasonably accurate gun that fires in 3-shot bursts. Total 36 per burst (3x12).
    default {
        Inventory.PickupMessage "You got a burst-firing SMG!";
        Weapon.SlotNumber 3;
        Weapon.AmmoType "Mag";
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 24;
    }

    action void MPShot(int dmg = 12) {
        A_FireBullets(1,1,-1,dmg,flags:FBF_NORANDOM|FBF_USEAMMO);
        A_StartSound("weapons/pistol",1);
        A_GunFlash();
        A_WeaponOffset(0,48,WOF_INTERPOLATE);
    }

    states {
        Spawn:
            SMGC A -1;
            Stop;
        
        Select:
            SMGG D 1 A_Raise(30);
            Loop;

        DeSelect:
            SMGG D 1 A_Lower(30);
            Loop;
        
        Ready:
            SMGG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            SMGF A 1 Bright MPShot();
            SMGF B 1 Bright;
            SMGG B 1 A_WeaponOffset(0,40,WOF_INTERPOLATE);
            SMGF A 1 Bright MPShot();
            SMGF B 1 Bright;
            SMGG B 1 A_WeaponOffset(0,40,WOF_INTERPOLATE);
            SMGF A 1 Bright MPShot(18);
            SMGF B 1 Bright;
            SMGG B 1 A_WeaponOffset(0,40,WOF_INTERPOLATE);
            SMGG C 5 {
                A_WeaponOffset(0,36,WOF_INTERPOLATE);
                A_WeaponReady(WRF_NOFIRE);
            }
            Goto Ready;
        
        Flash:
            TNT1 A 1 Bright A_Light1();
            Goto LightDone;
    }
}