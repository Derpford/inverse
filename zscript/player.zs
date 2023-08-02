class InverseGuy : DoomPlayer {
    // Just the Doomguy, but with a boomstick to start with.
    int overhealtick;
    int overarmortick;

    default {
        Player.StartItem "Boomstick";
        Player.StartItem "Buckshot", 15;
        Player.StartItem "Fist";
    }

    override void Tick() {
        Super.Tick();

        // Handle overheal.
        if (player.health > GetMaxHealth(true)) {
            overhealtick++;
            if (overhealtick > 35) {
                player.health--;
                health = player.health;
                overhealtick = 0;
            }
        } else {
            overhealtick = -140; // it takes 5 seconds after overhealing for the first overheal tick to start.
        }

        // And over-armor.
        if (CountInv("BasicArmor") > 100) {
            overarmortick++;
            if (overarmortick > 35) {
                TakeInventory("BasicArmor",1);
                overarmortick = 0;
            }
        } else {
            overarmortick = -140;
        }
    }
}