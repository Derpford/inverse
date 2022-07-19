class SlugRifle : Weapon replaces Chaingun {
    // The counterpart to the Boomstick.
    // Uses 3 shells per shot to fire 3 perfect-accuracy pellets, each of which does 50 damage.

    default {
        Inventory.PickupMessage "You got a slug rifle!";
        Weapon.AmmoType "Shell";
        Weapon.AmmoUse 3;
        Weapon.AmmoGive 6;
        Weapon.SlotNumber 2;
        Weapon.SlotPriority 1.5;
    }

    action void SGShot() {
        A_FireBullets(0,0,3,50,flags:FBF_NORANDOM|FBF_USEAMMO);
        A_StartSound("weapons/shotgf",1);
        A_GunFlash();
        A_WeaponOffset(0,52,WOF_INTERPOLATE);
    }

    states {
        Spawn:
            SHOT A -1;
            Stop;
        
        Select:
            SHTG C 1 A_Raise(20);
            Loop;
        Deselect:
            SHTG AB 3;
        DeselectReal:
            SHTG C 1 A_Lower(20);
            Loop;
        
        Ready:
            SHTG BA 3;
        ReadyReal:
            SHTG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            SHTG A 5 SGShot();
            SHTG B 6 A_WeaponOffset(0,48,WOF_INTERPOLATE);
            SHTG C 6 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            SHTG D 3 A_StartSound("weapons/sshotc");
            SHTG D 9 A_WeaponOffset(0,40,WOF_INTERPOLATE);
            SHTG D 5 A_StartSound("weapons/sshotl");
            SHTG D 4 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            SHTG C 5 A_StartSound("weapons/sshoto");
            SHTG B 3;
            Goto ReadyReal;

        Flash:
            SHTF A 3 Bright A_Light1();
            SHTF B 2 Bright A_Light2();
            Goto LightDone;
    }
}