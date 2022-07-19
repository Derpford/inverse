# Inverse
A doom mod where the guns are all shuffled around.

## What?
Imagine a world where Doom 1 and 2 gave you a double-barreled shotgun instead of a pistol. The rocket launcher is instead a railgun. The BFG is legally distinct from the Firewall. And instead of a chaingun, you get an accurate, piercing slug-firing rifle.

## Why?
As an experiment in weapon design! I sat down to calculate the potential damage of each ammo type--you can see my notes in the file ammo.zs.

Overall, you'll find that ammunition is a bit tighter. Zombiemen only drop enough shells for *one* boomstick shot, so catching more than one with each blast is very important. The machine pistol eats zombies quickly, but it eats ammo just as quickly--while you get way more bullets from each clip you pick up, you *also* chew through them way faster. The GL fires slightly faster than the RL, and the Napalm Cannon eats 10 rockets per shot.

Everything generally shoots a bit faster, with the exception of the Assault Cannon, which actually has roughly the same firerate as the vanilla chaingun, and the Napalm Cannon, which makes up for its slightly slower firerate by being potentially absurd when fired into a big crowd.

## Elaborate a bit on the guns.

1. The fist and chainsaw are unchanged.
2. The *Boomstick* (slot 2) uses 2 shells to fire 20 pellets, which do 5 damage each. Effectively, you're getting the minimum damage of a normal SSG shot each time you fire it. The SSG is kinda busted, anyway, so it's still pretty powerful. Meanwhile, the *Slug Rifle* (also slot 2) chews up 3 shells to fire 6 perfectly-accurate slug chunks for 25 damage each. It's like a baby railgun! Note that 25 damage is exactly enough to kill a shotgun zombie.
3. The *Machine Pistol* fires in 3-shot bursts, each bullet doing 12 damage. This is, by the way, slightly above the average damage of a vanilla bullet. Naturally, there's a slight cool-off between bursts. Meanwhile, the *Assault Cannon* uses 2 bullets per shot, doing 35 damage per hit. It spreads out more than the SMG, and the spread gets worse if you hold down the trigger, but that's okay 'cuz it's meant to be a lead storm.
4. The *Grenade Launcher* fires bouncy grenades that do 80 damage to anything they hit directly, and 160 splash damage. They're slightly better than vanilla rockets, because they kinda *have* to be to keep up with the absurd damage potential that Cells have--the average damage output of all 20 PR shots from a single small Cell pickup is *400 points of damage*, which is why rockets give 2 ammo now. Anyway, the *Napalm Cannon* fires a wave of flamey goodness that spreads out as it travels, doing 40 damage per tick as it rips through enemies. 4 or 5 good shots from the Napalm Cannon takes out a cyberdemon, and anything standing around it--which is nice, because without a backpack, 5 shots is all you've got...
5. The *Charge Railgun* can be charged up to hit harder. At base charge it eats 5 cells and fires an 80 damage, piercing rail shot. There's 3 levels of charge above that; each charge level increases ammo cost by 5, but *doubles* the damage. At charge level 3, it does a whopping 640 damage to anything standing too close! But it takes a second to charge that up, and a fully-charged shot uses 20 ammo.