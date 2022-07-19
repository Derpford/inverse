class NapalmCannon : Weapon replaces BFG9000 {
    // A firewall by any other name...
    // Rips through enemies for massive damage.
    Default {
        Inventory.PickupMessage "You got the Napalm Cannon! Porkchop sandwiches.";
        Weapon.AmmoType "RocketAmmo";
        Weapon.AmmoUse 10;
        Weapon.AmmoGive 10;
        Weapon.SlotNumber 4;
        Weapon.SlotPriority 0.5;
    }

    action void NapalmShot() {
        A_FireProjectile("NapalmWave");
        A_StartSound("weapons/napalmf",1);
        A_Light1();
        A_WeaponOffset(0,64,WOF_INTERPOLATE);
    }

    action void NapalmSteam() {
        A_GunFlash();
        for(int i = -2; i < 2; i++) {
            A_SpawnItemEX("NapalmSteam",40,zofs:frandom(32,40),angle:i * 5);
        }
        A_WeaponOffset(frandom(-8,8),frandom(28,36),WOF_INTERPOLATE);
        A_StartSound("weapons/napalms",2);
    }

    action void NapalmReload() {
        A_StartSound("weapons/napalmr",1);
        A_WeaponOffset(0,32,WOF_INTERPOLATE);
    }

    states {
        Spawn:
            BFUG A -1;
            Stop;
        
        Select:
            BFGG A 1 A_Raise(10);
            Loop;
        Deselect:
            BFGG A 1 A_Lower(10);
            Loop;
        
        Ready:
            BFGG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            BFGG B 5 NapalmShot();
            BFGG B 15 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            BFGG B 4 NapalmSteam();
            BFGG B 8;
            BFGG B 4 NapalmSteam();
            BFGG B 8;
            BFGG B 4 NapalmSteam();
            BFGG B 8;
            BFGG A 16 NapalmReload();
            Goto Ready;

        Flash:
            BFGF A 4 Bright;
            BFGF B 4 Bright;
            Goto LightDone;
    }
}

class NapalmWave : Actor {
    int count; // How many children have we spawned?
    bool side; // Are we the left or the right?
    default {
        Radius 40;
        Height 64;
        Speed 20;
        +RIPPER;
        RenderStyle "Add";
        DamageFunction (40); // You'd be amazed how hard this hits.
        PROJECTILE;
        +NOEXPLODEFLOOR;
        +STEPMISSILE;
        -NOGRAVITY; // Hugs floors. Sort of.
    }

    action void FireSpread(bool side) {
        if (invoker.count > 4) { return; } // Firewave only goes 7 out to each side.
        double offs = 40;
        if (side) { offs = -offs; }
        bool res; Actor it;
        [res, it] = A_SpawnItemEX("NapalmWave",-20,offs);
        if (res) {
            let wave = NapalmWave(it);
            if (wave) {
                wave.count = invoker.count + 1;
                wave.vel = invoker.vel;
                wave.target = invoker.target;
                wave.side = side;
            }
        }
    }

    action void DoFireSpread() {
        if(invoker.count == 0) {
            FireSpread(false); FireSpread(true);
        } else {
            FireSpread(invoker.side);
        }
    }

    states {
        Spawn:
            FIRE ABABC 3 Bright;
            FIRE D 4 Bright DoFireSpread();
        FlameLoop:
            FIRE CDEFG Random(1,4) Bright;
            Loop;
        Death:
            FIRE FGH 4 Bright;
            TNT1 A 0;
            Stop;
    }
}

class NapalmSteam : Actor {
    default {
        RenderStyle "Add";
        +NOINTERACTION;
    }

    override void Tick() {
        Super.Tick();
        vel.z += frandom(0,0.5);
    }

    states {
        Spawn:
            PUFF CDE 5;
            TNT1 A 0;
            Stop;
    }
}