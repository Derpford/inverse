class DragonRifle : Weapon replaces Chaingun {
    // The counterpart to the Boomstick.
    // Rapidly fires a spread of fireballs that stunlock targets.

    int burst; // ticks upward with each shot. Resets on ready.

    default {
        Inventory.PickupMessage "You got the Dragon Mark Rifle!";
        Weapon.AmmoType "Buckshot";
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 6;
        Weapon.SlotNumber 2;
        Weapon.SlotPriority 1.5;
    }

    action void SGShot(double offs) {
        // A_FireBullets(0,0,5,7,flags:FBF_NORANDOM|FBF_USEAMMO);
        A_FireProjectile("FirePellet",offs * invoker.burst, false);
        A_FireProjectile("FirePellet",offs * -invoker.burst, false);
        A_FireProjectile("FirePellet",offs * invoker.burst * 0.1);
        A_StartSound("weapons/shotgf",1);
        A_GunFlash();
        A_WeaponOffset(0,52,WOF_INTERPOLATE);
        invoker.burst++;
    }

    action state SGRefire() {
        if (GetPlayerInput(INPUT_BUTTONS) & BT_ATTACK || invoker.burst >= 3) {
            if (invoker.burst < 3) {
                return invoker.ResolveState("Fire");
            } else {
                return invoker.ResolveState("Rack");
            }
        }

        return invoker.ResolveState(null); // If we reach this point, either we're not attacking or we're out of burst shots.
    }

    states {
        Spawn:
            SLUC A -1;
            Stop;
        
        Select:
            DRGG A 1 A_Raise(20);
            Loop;
        Deselect:
            DRGG A 1 A_Lower(20);
            Loop;
        
        Ready:
        ReadyReal:
            DRGG A 0 { invoker.burst = 1; }
            DRGG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            DRGF A 4 Bright SGShot(-1);
            DRGG A 2 A_WeaponOffset(0,42,WOF_INTERPOLATE);
            DRGF B 4 Bright SGShot(1);
            DRGG A 2 A_WeaponOffset(0,42,WOF_INTERPOLATE);
            DRGG A 4 {
                A_WeaponReady(WRF_NOFIRE);
            }
            DRGG A 0 A_StartSound("weapons/sshotc",2);
            DRGG A 4 {
                A_WeaponReady();
                A_WeaponOffset(0,36,WOF_INTERPOLATE);
            }
            Goto ReadyReal;

        Flash:
            TNT1 A 3 Bright A_Light1();
            TNT1 A 2 Bright A_Light2();
            Goto LightDone;
    }
}

class FirePellet : Actor {
    default {
        Projectile;
        DamageFunction (9);
        RenderStyle "Add";
        Scale 0.7;
        Radius 8;
        Height 2;
        Speed 40;
        DeathSound "weapons/dragonx";
    }

    override int DoSpecialDamage(Actor tgt, int dmg, name mod) {
        int newdmg = super.DoSpecialDamage(tgt,dmg,mod);
        tgt.GiveInventory("FireDot",1);
        let fd = tgt.FindInventory("FireDot");
        if (fd) {
            fd.target = target;
        }
        return newdmg;
    }

    states {
        Spawn:
            BAL1 AB 4;
            Loop;
        Death:
            BAL1 CDE 4;
            Stop;
    }
}

class FireDot : Inventory {
    int paintics;
    int timer;
    Property Tics : paintics;
    default {
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        FireDot.Tics 10;
    }

    override void DoEffect() {
        Super.DoEffect();
        if (owner.bCORPSE || owner.health <= 0) { Detonate(0); return; }
        if (timer % 5 == 0) {
            owner.A_SpawnItemEX("BurnPuff",owner.radius+16,0,frandom(owner.height/2.,owner.height),angle:frandom(0,360));
        }
        if (timer == 0) {
            owner.TriggerPainChance("Fire",false);
            timer = paintics;
        } else {
            timer--;
        }
    }

    override void ModifyDamage(int dmg, Name mod, out int new, bool passive, Actor inf, Actor src, int flags) {
        super.ModifyDamage(dmg,mod,new,passive,inf,src,flags);
        if (passive) {
            if (inf is "FirePellet") { return; }
            Detonate(dmg);
        }
    }

    void Detonate(int dmg) {
        let fb = FlameBlast(owner.Spawn("FlameBlast",owner.pos+(0,0,owner.height/2.)));
        if (fb) {
            fb.target = target;
            fb.bonus = dmg;
            fb.rad = owner.radius;
            owner.TakeInventory("FireDot",1);
        }
    }
}

class BurnPuff : Actor {
    default {
        +NOINTERACTION;
        RenderStyle "Add";
    }

    states {
        Spawn:
            BAL1 BCDE 4 Bright;
            Stop;
    }
}

class FlameBlast : Actor {
    int bonus;
    int rad;
    default {
        Projectile;
        +BRIGHT;
    }

    states {
        Spawn:
            MISL B 6;
            MISL C 5 A_Explode(32+invoker.bonus,invoker.rad+80,fulldamagedistance:128);
            MISL D 4;
            Stop;
    }
}