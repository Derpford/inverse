# Inverse
A doom mod where the guns are all shuffled around.

## What?
Imagine a world where Doom 1 and 2 gave you a shotgun instead of a pistol. The rocket launcher is instead a railgun. The BFG is legally distinct from the Firewall. And instead of a chaingun, you get a fiery crowd-control auto shotgun.

## Why?
As an experiment in weapon design! I sat down to calculate the potential damage of each ammo type--you can see my notes in the file ammo.zs.

Overall, you'll find that ammunition is a bit tighter. Shotgun blasts aren't an instant kill on imps anymore. The SMG eats zombies quickly, but it eats ammo just as quickly--while you get way more bullets from each clip you pick up, you *also* chew through them way faster. The GL fires slightly faster than the RL, and the Napalm Cannon eats 10 rockets per shot.

Everything generally shoots a bit faster, with the exception of the Assault Cannon, which actually has roughly the same firerate as the vanilla chaingun, and the Napalm Cannon, which makes up for its slightly slower firerate by being potentially absurd when fired into a big crowd.

## Elaborate a bit on the guns.

1. The fist and chainsaw are unchanged.
2. The *Boomstick* (slot 2) uses 1 shells to fire 11 pellets, which do 3 damage each. It's got a tight spread, and it fires reasonably fast--*and* it still kills most zombies in one hit, though imps take two shots. Meanwhile, the *Dragon Rifle* (also slot 2) uses shells to shoot balls of unholy fire, igniting targets--making them periodically flinch. Additionally, shooting an ignited target with other weapons detonates the flames for bonus damage.
3. The *SMG* fires in 3-shot bursts, the first two bullets doing 12 damage while the last does 18 damage, with a reasonably high accuracy. Naturally, there's a slight cool-off between bursts. Meanwhile, the *Assault Cannon* uses 2 bullets per shot, firing two rounds that do 15 damage per hit. It spreads out more than the SMG, and the spread gets worse if you hold down the trigger, but that's okay 'cuz it's meant to be a lead storm.
4. The *Grenade Launcher* fires bouncy grenades that do 80 damage to anything they hit directly, and 160 splash damage. They're slightly better than vanilla rockets, because they kinda *have* to be to keep up with the absurd damage potential that Cells have--the average damage output of all 20 PR shots from a single small Cell pickup is *400 points of damage*, which is why rockets give 2 ammo now. Anyway, the *Napalm Cannon* fires a wave of flamey goodness that spreads out as it travels, doing 40 damage per tick as it rips through enemies. 4 or 5 good shots from the Napalm Cannon takes out a cyberdemon, and anything standing around it--which is nice, because without a backpack, 5 shots is all you've got...
5. The *Charge Railgun* can be charged up to hit harder. At base charge it eats 5 cells and fires an 80 damage, piercing rail shot. There's 3 levels of charge above that; each charge level increases ammo cost by 5, but *doubles* the damage. At charge level 3, it does a whopping 640 damage to anything standing too close! But it takes a second to charge that up, and a fully-charged shot uses 20 ammo.

## Any other changes?

- Armor is way more effective, but doesn't last as long. All armor is at 75% save percentage, but the blue armor only gives 150 and the green armor gives 75; armor bonuses give 5 each now, though. All armor stacks with all other armor, but armor over 100 starts decaying over time.
- Likewise, healing is more effective--stimpacks give 15, medkits give 30, and health bonuses give 5 each. *And* your overheal cap is 300, too. However, like with armor, your overhealing ticks down over time.
- Ammo counts have changed slightly--you can now carry 60 shells and 300 bullets at base capacity, but cell storage has dropped to 250. In addition, your ammo storage can 'overfill' slightly; don't worry about picking up a shellbox that you don't have room for.