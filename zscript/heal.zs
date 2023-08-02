class SmallHeal : Health replaces Stimpack {
    default {
        Inventory.Amount 15;
        Inventory.PickupMessage "+15 Health";
    }
    
    states {
        Spawn:
            HEAL A -1;
            Stop;
    }
}

class LargeHeal : Health replaces Medikit {
    default {
        Inventory.Amount 30;
        Inventory.PickupMessage "+30 Health";
    }

    states {
        Spawn:
            HEAL B -1;
            Stop;
    }
}

class HealthShard : HealthBonus replaces HealthBonus {
    default {
        Inventory.Amount 5;
        Inventory.MaxAmount 300;
    }
}

class ArmorShard : ArmorBonus replaces ArmorBonus {
    default {
        Armor.SaveAmount 5;
        Armor.SavePercent 75;
        Armor.MaxSaveAmount 300;
    }
}

class LightArmor : BasicArmorBonus replaces GreenArmor {
    default {
        Armor.SaveAmount 75;
        Armor.SavePercent 75;
        Armor.MaxSaveAmount 300;
        Inventory.PickupMessage "Got the Light Armor";
    }

    states {
        Spawn:
            ARM1 A 6;
            ARM1 B 7 Bright;
            Loop;
    }
}

class HeavyArmor : LightArmor replaces BlueArmor {
    default {
        Armor.SaveAmount 100;
        Inventory.PickupMessage "Got the Heavy Armor";
    }

    states {
        Spawn:
            ARM2 A 6;
            ARM2 B 7 Bright;
            Loop;
    }
}