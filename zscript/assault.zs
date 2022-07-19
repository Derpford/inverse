class AssaultCannon : Weapon replaces SuperShotgun {
    // A big fuckoff minigun.
    // Shoots more powerful bullets, but uses more bullet ammo per shot.

    double spread; // Increases as you shoot.

    default {
        Inventory.PickupMessage "You got the Assault Cannon! Like a firehose of lead.";
        Weapon.SlotNumber 3;
        Weapon.SlotPriority 1.5;
        Weapon.AmmoType "Clip";
        Weapon.AmmoGive 30;
        Weapon.AmmoUse 2;
    }

    action void AShot() {
        A_FireBullets(invoker.spread+3,1,1,25,flags:FBF_NORANDOM|FBF_USEAMMO);
        invoker.spread = min(invoker.spread + 0.3, 5);
        A_StartSound("weapons/cgunf",1);
        A_GunFlash();
        A_WeaponOffset(frandom(-invoker.spread,invoker.spread),40,WOF_INTERPOLATE);
    }

    states {
        Spawn:
            MGUN A -1;
            Stop;

        Select:
            CHGG AB 3 A_Raise(30);
            Loop;
        
        Deselect:
            CHGG A 1 A_Lower(10);
            Loop;
        
        Ready:
            CHGG A 1 {
                A_WeaponReady();
                invoker.spread = 0;
            }
            Loop;
        
        Fire:
            CHGG B 3 A_StartSound("weapons/cgunr",1);
            CHGG A 2;
        Hold:
            CHGG A 2 AShot();
            CHGG B 2 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            CHGG A 2 A_Refire();
            CHGG B 3 A_StartSound("weapons/shotgr",1);
            CHGG A 4;
            CHGG B 4;
            Goto Ready;
        
        Flash:
            CHGF A 2 Bright A_Light1;
            CHGF B 2 Bright A_Light2;
            Goto LightDone;
    } 
}