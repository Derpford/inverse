class Boomstick : Weapon replaces Pistol {
    // A sawn-off shotgun that blasts a spread of 11 pellets for 3 damage per pellet, once every 18 frames.
    // Eats ammo rapidly! That's okay, though.

    default {
        Inventory.PickupMessage "You got a boomstick! Groovy.";
        Weapon.SlotNumber 2;
        Weapon.SlotPriority 1.0;
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 4;
        Weapon.AmmoType "Buckshot";
    }

    action void BoomShot() {
        A_FireBullets(4,1.5,3,3,flags:FBF_NORANDOM|FBF_USEAMMO);
        A_FireBullets(2,1,8,3,flags:FBF_NORANDOM);
        A_StartSound("weapons/sshotf",2);
        A_GunFlash();
        A_WeaponOffset(0,44);
    }

    states {
        Spawn:
            SHTC A -1;
            Stop;

        Select:
            SHTG A 1 A_Raise(20);
            Loop;
        Deselect:
            SHTG A 1 A_Lower(20);
            Loop;
        
        Ready:
            SHTG A 1 A_StartSound("weapons/sshotc",1);
        ReadyReal:
            SHTG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            SHTG B 3 BoomShot();
            SHTG C 2 A_WeaponOffset(0,4,WOF_ADD);
            SHTG A 0 A_CheckReload();
            SHTG A 5 A_WeaponOffset(0,-8,WOF_ADD);
            SHTG A 0 A_StartSound("weapons/sshoto",1);
            SHTG A 4 A_WeaponOffset(0,-8,WOF_ADD);
            Goto ReadyReal;

        Flash:
            TNT1 A 3 Bright A_Light1();
            TNT1 A 2 Bright A_Light2();
            Goto LightDone;

    }
}