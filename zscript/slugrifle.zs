class DragonRifle : Weapon replaces Chaingun {
    // The counterpart to the Boomstick.
    // Rapidly fires a spread of fireballs that stunlock targets.

    int burst; // ticks upward with each shot. Resets on ready.

    default {
        Inventory.PickupMessage "You got the Dragon Rifle!";
        Weapon.AmmoType "Buckshot";
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 6;
        Weapon.SlotNumber 2;
        Weapon.SlotPriority 1.5;
    }

    action void SGShot(double offs) {
        // A_FireBullets(0,0,5,7,flags:FBF_NORANDOM|FBF_USEAMMO);
        A_FireProjectile("FirePellet",offs);
        A_FireProjectile("FirePellet",0, false);
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
            DRGG A 0 { invoker.burst = 0; }
            DRGG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            DRGF A 4 Bright SGShot(-0.5);
            DRGG A 2 A_WeaponOffset(0,42,WOF_INTERPOLATE);
            DRGF B 4 Bright SGShot(0.5);
            DRGG A 2 A_WeaponOffset(0,42,WOF_INTERPOLATE);
            DRGG A 4 {
                A_SetTics(min(12,4+invoker.burst));
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
    int bonus;
    default {
        Projectile;
        DamageFunction (15+bonus);
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

        return newdmg;
    }

    override void Tick() {
        super.Tick();
        if (vel.length() > 5) {
            vel = vel.unit() * (vel.length() - 1.0);
        }
        if (vel.length() < 10) {
            bonus = 15;
        }
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
    int pausetics;
    int tickstate;
    Property Tics : paintics, pausetics;
    default {
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        FireDot.Tics 2, 5;
    }

    override bool HandlePickup(Inventory other) {
        if (other.GetClass() == self.GetClass()) {
            paintics = min(10,paintics+1); // Half effect when stacked.
            other.bPickupGood = true;
            return true;
        }
        return false;
    }

    override void DoEffect() {
        Super.DoEffect();
        if (owner.bCORPSE || owner.health <= 0) { owner.TakeInventory("FireDot",1); return; }
        if ( paintics > 0) {
            if ( !owner.InStateSequence(owner.curstate, owner.ResolveState("pain")) ) {
                if ( tickstate >= pausetics ) {
                    owner.SetState(owner.ResolveState("pain"));
                    tickstate = 0;
                    paintics--;
                } else {
                    tickstate++;
                }
            } 
        } else {
            owner.TakeInventory("FireDot",1);
            return;
        }
    }
}