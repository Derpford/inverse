class DragonRifle : Weapon replaces Chaingun {
    // The counterpart to the Boomstick.
    // Rapidly fires a spread of ripping fireballs that stunlock targets; fires up to 3 before having to rack the slide.

    int burst; // ticks upward with each shot. Resets on ready.

    default {
        Inventory.PickupMessage "You got the Dragon Rifle!";
        Weapon.AmmoType "Buckshot";
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 6;
        Weapon.SlotNumber 2;
        Weapon.SlotPriority 0.5;
    }

    action void SGShot() {
        // A_FireBullets(0,0,5,7,flags:FBF_NORANDOM|FBF_USEAMMO);
        for (int i = -2; i <= 2; i++) {
            A_FireProjectile("FirePellet",i * 2, (i == 0));
        }
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
            SLUG C 1 A_Raise(20);
            Loop;
        Deselect:
            SLUG AB 3;
        DeselectReal:
            SLUG C 1 A_Lower(20);
            Loop;
        
        Ready:
            SLUG BA 2;
        ReadyReal:
            SLUG A 0 { invoker.burst = 0; }
            SLUG A 1 A_WeaponReady();
            Loop;
        
        Fire:
            SLUG A 4 SGShot();
            SLUG A 2 A_WeaponOffset(0,42,WOF_INTERPOLATE);
            SLUG A 0 SGRefire();
            Goto ReadyReal;
        Rack:
            SLUG A 6 A_WeaponOffset(0,48,WOF_INTERPOLATE);
            SLUG B 5 A_WeaponOffset(0,32,WOF_INTERPOLATE);
            SLUG D 0 A_WeaponReady(WRF_NOFIRE);
            SLUG C 3 {
                A_StartSound("weapons/sshotc");
                A_WeaponReady(WRF_NOFIRE);
            }
            SLUG D 7 {
                A_WeaponReady(WRF_NOFIRE);
                A_WeaponOffset(0,40,WOF_INTERPOLATE);
            }
            SLUG E 5 {
                A_WeaponReady(WRF_NOFIRE);
                A_StartSound("weapons/sshotl");
            }
            SLUG F 4 {
                A_WeaponReady(WRF_NOFIRE);
                A_WeaponOffset(0,32,WOF_INTERPOLATE);
            }
            SLUG C 5 {
                A_WeaponReady(WRF_NOFIRE);
                A_StartSound("weapons/sshoto");
            }
            SLUG B 3 A_WeaponReady(WRF_NOFIRE);
            Goto ReadyReal;

        Flash:
            SLUF A 3 Bright A_Light1();
            SLUF B 2 Bright A_Light2();
            Goto LightDone;
    }
}

class FirePellet : Actor {
    int bonus;
    default {
        Projectile;
        DamageFunction (7+bonus);
        RenderStyle "Add";
        Scale 0.7;
        Radius 8;
        Height 2;
        Speed 40;
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
            bonus = 7;
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
    Property Tics : paintics;
    default {
        Inventory.Amount 1;
        Inventory.MaxAmount 3;
        FireDot.Tics 35;
    }

    override void DoEffect() {
        if (owner.bCORPSE || owner.health <= 0) { owner.TakeInventory("FireDot",1); return; }
        if ( paintics > 0 ) {
            if ( !owner.InStateSequence(owner.curstate, owner.ResolveState("pain")) ) {
                owner.SetState(owner.ResolveState("pain"));
            }
            paintics--;
        } else {
            owner.TakeInventory("FireDot",1);
            return;
        }
    }
}