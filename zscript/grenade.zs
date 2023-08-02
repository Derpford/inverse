class GrenadeLauncher : Weapon replaces PlasmaRifle {
    // THOONK THOONK THOONK
    // An excellent area denial tool that rapid-fires grenades. Slightly faster than vanilla RL, with projectiles that linger if they don't make direct contact.

    default {
        Inventory.PickupMessage "Grabbed a Grenade Launcher!";
        Weapon.AmmoType "GrenadeAmmo";
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 5;
        Weapon.SlotNumber 4;
    }

    action void GLShot() {
        A_FireProjectile("TimeGrenade",pitch:-5);
        A_StartSound("weapons/rocklf",1);
        A_GunFlash();
        A_WeaponOffset(0,48,WOF_INTERPOLATE);
    }

    States {
        Spawn:
            LAUN A -1;
            Stop;
        
        Select:
            MISG A 1 A_Raise(20);
            Loop;
        DeSelect:
            MISG A 1 A_Lower(20);
            Loop;

        Ready:
            MISG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            MISG B 4 GLShot();
            MISG B 8 A_WeaponOffset(0,24,WOF_INTERPOLATE);
            MISG A 4 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            Goto Ready; 

        Flash:
            MISF A 3 Bright A_Light1();
            MISF BCD 2 Bright A_Light2();
            Goto LightDone;
    }
}

class TimeGrenade : Actor {
    // A grenade that blows up after a bit when hitting a wall or floor, or immediately on hitting an actor.

    default {
        BounceType "Doom";
        DamageFunction (80);
        Radius 8;
        PROJECTILE;
        -NOGRAVITY;
        Speed 40; // Faster, to account for the fact that it bounces and falls.
        Gravity 0.4;
        BounceFactor 0.5; // But it loses momentum fast.
        WallBounceFactor 0.5;
    }

    action void GrenExplode() {
        A_StartSound("weapons/rocklx");
        { invoker.bNOGRAVITY = true; }
        A_Explode(160); // Total damage 240 on direct hit.
    }

    states {
        Spawn:
            SGRN A 1 Bright A_SpawnItemEX("BulletPuff");
            Loop;
        
        Death:
            SGRN A 35 Bright;
        Crash:
        XDeath:
            MISL B 8 Bright GrenExplode();
            MISL C 6 Bright;
            MISL D 4 Bright;
            TNT1 A 0;
            Stop;
    }
}