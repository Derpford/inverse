class Boomstick : Weapon replaces Pistol {
    // A sawn-off shotgun that blasts a spread of 20 pellets for 5 damage per pellet, once every 20 frames.
    // Eats ammo rapidly! That's okay, though.

    default {
        Inventory.PickupMessage "You got a boomstick! Groovy.";
        Weapon.SlotNumber 2;
        Weapon.AmmoUse 2;
        Weapon.AmmoGive 4;
        Weapon.AmmoType "Shell";
    }

    action void BoomShot() {
        A_FireBullets(7,3,20,5,flags:FBF_NORANDOM|FBF_USEAMMO);
        A_StartSound("weapons/sshotf",2);
        A_GunFlash();
        A_WeaponOffset(0,48);
    }

    states {
        Spawn:
            SGN2 A -1;
            Stop;

        Select:
            SHT2 D 1 A_Raise(20);
            Loop;
        Deselect:
            SHT2 ABC 3;
        DeselectReal:
            SHT2 D 1 A_Lower(20);
            Loop;
        
        Ready:
            SHT2 G 3;
            SHT2 H 3 A_StartSound("weapons/sshotc",1);
        ReadyReal:
            SHT2 A 1 A_WeaponReady();
            Loop;
        
        Fire:
            SHT2 A 5 BoomShot();
            SHT2 A 0 A_CheckReload();
            SHT2 B 6 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            SHT2 C 5;
            SHT2 D 4 A_StartSound("weapons/sshoto",1);
            SHT2 E 5;
            SHT2 F 6 A_StartSound("weapons/sshotl",2);
            SHT2 G 5;
            SHT2 H 3 A_StartSound("weapons/sshotc",1);
            Goto ReadyReal;

        Flash:
            SHT2 I 3 Bright A_Light1();
            SHT2 J 2 Bright A_Light2();
            Goto LightDone;

    }
}