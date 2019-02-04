/* Two-handed Weapons
 * Contains:
 * 		Twohanded
 *		Fireaxe
 *		Double-Bladed Energy Swords
 */

/*##################################################################
##################### TWO HANDED WEAPONS BE HERE~ -Agouri :3 ########
####################################################################*/

//Rewrote TwoHanded weapons stuff and put it all here. Just copypasta fireaxe to make new ones ~Carn
//This rewrite means we don't have two variables for EVERY item which are used only by a few weapons.
//It also tidies stuff up elsewhere.

/*
 * Twohanded
 */
/obj/item/weapon/material/twohanded
	w_class = ITEMSIZE_LARGE
	var/wielded = 0
	var/force_wielded = 0
	var/force_unwielded
	var/wieldsound = null
	var/unwieldsound = null
	var/base_icon
	var/base_name
	var/unwielded_force_divisor = 0.25

/obj/item/weapon/material/twohanded/update_held_icon()
	var/mob/living/M = loc
	if(istype(M) && M.can_wield_item(src) && is_held_twohanded(M))
		wielded = 1
		force = force_wielded
		name = "[base_name] (wielded)"
		update_icon()
	else
		wielded = 0
		force = force_unwielded
		name = "[base_name]"
	update_icon()
	..()

/obj/item/weapon/material/twohanded/update_force()
	base_name = name
	if(sharp || edge)
		force_wielded = material.get_edge_damage()
	else
		force_wielded = material.get_blunt_damage()
	force_wielded = round(force_wielded*force_divisor)
	force_unwielded = round(force_wielded*unwielded_force_divisor)
	force = force_unwielded
	throwforce = round(force*thrown_force_divisor)
	//world << "[src] has unwielded force [force_unwielded], wielded force [force_wielded] and throwforce [throwforce] when made from default material [material.name]"

/obj/item/weapon/material/twohanded/New()
	..()
	update_icon()

//Allow a small chance of parrying melee attacks when wielded - maybe generalize this to other weapons someday
/obj/item/weapon/material/twohanded/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(wielded && default_parry_check(user, attacker, damage_source) && prob(15))
		user.visible_message("<span class='danger'>\The [user] parries [attack_text] with \the [src]!</span>")
		playsound(user.loc, 'sound/weapons/punchmiss.ogg', 50, 1)
		return 1
	return 0

/obj/item/weapon/material/twohanded/update_icon()
	icon_state = "[base_icon][wielded]"
	item_state = icon_state

/obj/item/weapon/material/twohanded/dropped()
	..()
	if(wielded)
		spawn(0)
			update_held_icon()

/*
 * Fireaxe
 */
/obj/item/weapon/material/twohanded/fireaxe  // DEM AXES MAN, marker -Agouri
	icon_state = "fireaxe0"
	base_icon = "fireaxe"
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	description_info = "This weapon can cleave, striking nearby lesser, hostile enemies close to the primary target.  It must be held in both hands to do this."
	unwielded_force_divisor = 0.25
	force_divisor = 0.7 // 10/42 with hardness 60 (steel) and 0.25 unwielded divisor
	dulled_divisor = 0.75	//Still metal on a stick
	sharp = 1
	edge = 1
	w_class = ITEMSIZE_LARGE
	slot_flags = SLOT_BACK
	force_wielded = 30
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	applies_material_colour = 0
	can_cleave = TRUE

/obj/item/weapon/material/twohanded/fireaxe/update_held_icon()
	var/mob/living/M = loc
	if(istype(M) && !issmall(M) && M.item_is_in_hands(src) && !M.hands_are_full())
		wielded = 1
		pry = 1
		force = force_wielded
		name = "[base_name] (wielded)"
		update_icon()
	else
		wielded = 0
		pry = 0
		force = force_unwielded
		name = "[base_name]"
	update_icon()
	..()

/obj/item/weapon/material/twohanded/fireaxe/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity) return
	..()
	if(A && wielded)
		if(istype(A,/obj/structure/window))
			var/obj/structure/window/W = A
			W.shatter()
		else if(istype(A,/obj/structure/grille))
			qdel(A)
		else if(istype(A,/obj/effect/plant))
			var/obj/effect/plant/P = A
			P.die_off()

/obj/item/weapon/material/twohanded/fireaxe/scythe
	icon_state = "scythe0"
	base_icon = "scythe"
	name = "scythe"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	force_divisor = 0.65
	origin_tech = list(TECH_MATERIAL = 2, TECH_COMBAT = 2)
	attack_verb = list("chopped", "sliced", "cut", "reaped")

/obj/item/weapon/material/twohanded/gravityhammer
	name = "gravity hammer"
	desc = "An incredibly experimental device capable of weaponizing one of the most powerful forces in our universe. <br>This weapon causes devastating damage to those it hits due to a power field sustained by a mini-singularity inside of the hammer."
	icon_state = "fireaxe0"
	base_icon = "fireaxe"
	flags = CONDUCT
	slot_flags = SLOT_BACK
	//no_embed = 1
	unwielded_force_divisor = 0.2 //10 damage while one handed, hammer is not activated
	force_divisor = 1
	force_wielded = 50
	throwforce = 15
	throw_range = 1
	w_class = 5
	//var/charged = 5
	origin_tech = "combat=5;bluespace=6"
	attack_verb = list("smashed")
	applies_material_colour = 0
	can_dull = 0

/obj/item/weapon/material/twohanded/gravityhammer/update_held_icon()
	var/mob/living/M = loc
	if(istype(M) && !issmall(M) && M.item_is_in_hands(src) && !M.hands_are_full())
		wielded = 1
		force = force_wielded
		name = "[base_name] (wielded)"
		M.visible_message("The hammer whirs upon activation.")
		update_icon()
	else
		wielded = 0S
		force = force_unwielded
		name = "[base_name]"
		M.visible_message("The hammer hums into silence.")
	update_icon()
	..()

/*/obj/item/weapon/material/twohanded/gravityhammer/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/material/twohanded/gravityhammer/Destroy()
	processing_objects.Remove(src)
	return ..()*/
/*
/obj/item/weapon/material/material/twohanded/gravityhammer/process()
	if(charged < 5)
		charged++
	return
*/
/*
/obj/item/weapon/material/twohanded/gravityhammer/update_icon()  //Currently only here to fuck with the on-mob icons.
	icon_state = "knighthammer[wielded]"
	return
*/
/obj/item/weapon/material/twohanded/gravityhammer/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity) return
//	if(charged == 5)
//		charged = 0
	if(istype(A, /mob/living/))
		var/mob/living/Z = A
		if(Z/*.health >= 1*/)
			Z.visible_message("<span class='danger'>[Z.name] was sent flying by a blow from the [src.name]!</span>", \
				"<span class='userdanger'>You feel a powerful blow connect with your body and send you flying!</span>", \
				"<span class='danger'>You hear something heavy impact flesh!.</span>")
			var/atom/throw_target = get_edge_target_turf(Z, get_dir(src, get_step_away(Z, src)))
			Z.throw_at(throw_target, 200, 4)
			playsound(user, 'sound/weapons/marauder.ogg', 50, 1)
		/*else if(wielded && Z.health < 1)
			Z.visible_message("<span class='danger'>[Z.name] was blown to peices by the power of [src.name]!</span>", \
				"<span class='userdanger'>You feel a powerful blow rip you apart!</span>", \
				"<span class='danger'>You hear a heavy impact and the sound of ripping flesh!.</span>")
			Z.gib()
			playsound(user, 'sound/weapons/marauder.ogg', 50, 1)*/
	if(wielded)
		if(istype(A, /turf/simulated/wall))
			var/turf/simulated/wall/Z = A
			Z.ex_act(2)
			//charged = 3
			playsound(user, 'sound/weapons/marauder.ogg', 50, 1)
		else if(istype(A, /obj/structure) || istype(A, /obj/mecha/))
			var/obj/Z = A
			Z.ex_act(2)
			//charged = 3
			playsound(user, 'sound/weapons/marauder.ogg', 50, 1)

//spears, bay edition
/obj/item/weapon/material/twohanded/spear
	icon_state = "spearglass0"
	base_icon = "spearglass"
	name = "spear"
	desc = "A haphazardly-constructed yet still deadly weapon of ancient design."
	description_info = "This weapon can strike from two tiles away, and over certain objects such as tables, or other people."
	force = 10
	w_class = ITEMSIZE_LARGE
	slot_flags = SLOT_BACK
	force_divisor = 0.5 			// 15 when wielded with hardness 15 (glass)
	unwielded_force_divisor = 0.375
	thrown_force_divisor = 1.5 		// 20 when thrown with weight 15 (glass)
	throw_speed = 3
	edge = 0
	sharp = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	default_material = "glass"
	applies_material_colour = 0
	fragile = 1	//It's a haphazard thing of glass, wire, and steel
	reach = 2 // Spears are long.
	attackspeed = 14