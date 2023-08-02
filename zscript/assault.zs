class AssaultCannon : Weapon replaces SuperShotgun {
    // A big fuckoff minigun.
    // Chews through ammo more rapidly if you hold down the button for a bit.

    double spread; // Increases as you shoot.

    default {
        Inventory.PickupMessage "You got the Assault Cannon! Like a firehose of lead.";
        Weapon.SlotNumber 3;
        Weapon.SlotPriority 0.5;
        Weapon.AmmoType "Mag";
        Weapon.AmmoGive 30;
        Weapon.AmmoUse 2;
    }

    action void AShot() {
        A_FireBullets(invoker.spread+2,1,2,15,flags:FBF_NORANDOM|FBF_USEAMMO);
        invoker.spread = min(invoker.spread + 0.3, 5);
        A_StartSound("weapons/cgunf",2);
        A_GunFlash();
        A_WeaponOffset(frandom(-invoker.spread,invoker.spread),40,WOF_INTERPOLATE);
    }

    action state ASpin() {
        if (GetPlayerInput(INPUT_BUTTONS) & BT_ATTACK && invoker.CheckAmmo(PrimaryFire,false)) {
            if (invoker.spread < 0.5) {
                return invoker.ResolveState("Hold");
            } else {
                return invoker.ResolveState("Hold2");
            }
        } else {
            return invoker.ResolveState(null);
        }
    }

    states {
        Spawn:
            MGUN A -1;
            Stop;

        Select:
            ASGG ABCD 3 A_Raise(40);
            Loop;
        
        Deselect:
            ASGG A 1 A_Lower(10);
            Loop;
        
        Ready:
            ASGG A 1 {
                A_WeaponReady();
                invoker.spread = 0;
            }
            Loop;
        
        Fire:
            ASGG BC 2 A_StartSound("weapons/cgunr",1);
            ASGG D 2;
        Hold:
            ASGF A 1 AShot();
            ASGF B 1 A_WeaponOffset(0,-2,WOF_ADD);
            ASGG BCD 2 A_WeaponOffset(0,-2,WOF_ADD);
            CHGG A 0 ASpin();
            Goto Spindown;
        Hold2:
            ASGF A 1 AShot();
            ASGF B 1;
            ASGG BCD 1 A_WeaponOffset(0,-2,WOF_ADD);
            ASGG A 0 ASpin();
            Goto Spindown;
        Spindown:
            ASGG A 2 A_StartSound("weapons/shotgr",1);
            ASGG B 2;
            ASGG C 3;
            ASGG D 4;
            Goto Ready;
        
        Flash:
            TNT1 A 1 Bright A_Light1;
            TNT1 A 1 Bright A_Light2;
            Goto LightDone;
    } 
}