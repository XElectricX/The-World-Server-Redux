/obj/structure/closet/secure_closet/hydroponics
	name = "botanist's locker"
	req_access = list(access_hydroponics)
	icon_state = "hydrosecure1"
	icon_closed = "hydrosecure"
	icon_locked = "hydrosecure1"
	icon_opened = "hydrosecureopen"
	icon_broken = "hydrosecurebroken"
	icon_off = "hydrosecureoff"


	New()
		..()
		switch(rand(1,2))
			if(1)
				new /obj/item/clothing/suit/storage/apron(src)
			if(2)
				new /obj/item/clothing/suit/storage/apron/overalls(src)
		new /obj/item/weapon/storage/bag/plants(src)
		new /obj/item/clothing/under/rank/hydroponics(src)
		new /obj/item/device/analyzer/plant_analyzer(src)
		new /obj/item/device/radio/headset/headset_service(src)
		new /obj/item/clothing/head/greenbandana(src)
		new /obj/item/weapon/material/minihoe(src)
		new /obj/item/weapon/material/knife/machete/hatchet(src)
		new /obj/item/weapon/wirecutters/clippers(src)
		new /obj/item/weapon/reagent_containers/spray/plantbgone(src)
		new /obj/item/clothing/suit/storage/hooded/wintercoat/hydro(src)
		new /obj/item/clothing/shoes/boots/winter/hydro(src)
//		new /obj/item/weapon/bee_net(src) //No more bees, March 2014
		return
