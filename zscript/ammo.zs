class Buckshot : Shell replaces Clip {
    // Shotgun shells on the bullet slot.
    // In vanilla, 4 shells is 300-600 damage with the SSG, or 140-420 with the regular SG.
    // A clip is usually worth 50-150 damage.
    // Quake's shells are worth 24 damage each and a small shellbox has 20 in it, so Quake's shellboxes are worth 480 damage...
    // Whereas our boomstick does 33 per shell, and our slugrifle does 35 per shell. 
    // At 8 shells per pack, this pickup would be worth ~260 damage, or ~130 when dropped from zombies.
    default {
        Inventory.PickupMessage "Picked up some shells.";
        Inventory.Amount 8;
    }
}

class BuckBox : ShellBox replaces ClipBox {
    // Whereas the big box should actually hold *FEWER* shells to make up for the fact that you're getting way more from zombies.
    default {
        Inventory.Amount 16;
    }

}

class Mag : Clip replaces Shell {
    // Likewise, bullet ammo now goes in the shell slot.
    // Each mag should be worth somewhere in the neighborhood of 450 damage.
    // The SMG does ~14 per shot if you land all 3 shots. The Assault Cannon, in turn, does 15 per shot.
    // 24 * 15 = 360. On the low end for 4 shells, if you're using the vanilla SSG.
    default {
        Inventory.Amount 24;
    }
}

class MagBox : ClipBox replaces ShellBox {
    default {
        Inventory.Amount 60; 
        // Not quite triple the original clipbox amount, but a lot more. 
        // 60 * 15 = 900, which is...just over half what the SSG gets out of a shellbox.
        // God, the SSG is just impossible to balance around, huh?
        // It's roughly in range for a regular SG, though.
    }
}

class Battery : Cell replaces RocketAmmo {
    // Rockets normally do 20-160 damage on impact plus 128 splash, per rocket.
    // There are normally 20 shots in a cell.
    // The max damage of a rocket, 288, divided by 20, comes out to...14.4.
    // Eh, we're already upping damage slightly by removing randomness. Call it 20 per shot, for a total of 400 per cell.
    // Less than the equivalent bullet ammo pickup, but piercing makes up for it.
}

class BatteryBox : CellPack replaces RocketBox {

}

class GrenadeAmmo : RocketAmmo replaces Cell {
    // The PR does 5-40 damage per shot, for a total of 100-800 damage per Cell.
    // The BFG uses 2 Cells to fire one BFG Ball, doing 100-800 damage directly.
    // It then spawns 40 tracers, each of which does 15 to 120 damage, for an additional 600-4800 damage.
    // Thus, the total potential damage of a BFG ball is 700 to 5600 damage, which, divided by 2...
    // Means 450-2800 per cell.
    // So 400 per cell is actually about right, though I'll want to scale that way up for the BFG-equivalent.
    // Frankly, this is insane damage for any RL-like weapon to have, so I'm gonna double the pickup amount and halve the damage per shot.
    // 200-ish per shot is perfectly acceptable and in line with standard RL performance.
    default {
        Inventory.Amount 2;
    }
}

class GrenadeBox : RocketBox replaces CellPack {
    default {
        Inventory.Amount 10;
    }
}