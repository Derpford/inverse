class InverseGuy : DoomPlayer {
    // Just the Doomguy, but with a boomstick to start with.
    default {
        Player.StartItem "Boomstick";
        Player.StartItem "Shell", 12;
        Player.StartItem "Fist";
    }
}