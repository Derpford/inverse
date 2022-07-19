class Buckshot : Shell replaces Clip {
    // Shotgun shells on the bullet slot.
    // In vanilla, 4 shells is 300-600 damage with the SSG, or 140-420 with the regular SG.
    // A clip is usually worth 50-150 damage.
    // So, let's hit a decent middle ground of 200 potential damage, or 50 per shell.
    default {
        Inventory.PickupMessage "Picked up some shells.";
    }
}

class BuckBox : ShellBox replaces ClipBox {

}

class Mag : Clip replaces Shell {
    // Likewise, bullet ammo now goes in the shell slot.
    // Each mag should be worth somewhere in the neighborhood of 450 damage.
    // ...I'm considering tripling the size of the mags, so that would mean 15 per bullet.
    default {
        Inventory.Amount 30;
    }
}

class MagBox : ClipBox replaces ShellBox {
    default {
        Inventory.Amount 90; // Not quite triple the original clipbox amount, but a lot more.
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