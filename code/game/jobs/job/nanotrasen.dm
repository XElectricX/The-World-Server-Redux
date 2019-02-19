/datum/job/nanotrasen
	title = "Nanotrasen Representative"
	flag = NANOTRASEN
	department = "Command"
	head_position = 0
	department_flag = ENGSEC
	faction = "City"
	total_positions = 0
	spawn_positions = 0
	supervisors = "your superior officer or supervisor"
	selection_color = "#0F0F6F"
	idtype = /obj/item/weapon/card/id/centcom/station
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

	outfit_type = /decl/hierarchy/outfit/nanotrasen/representative

	alt_titles = list("Nanotrasen Security" = /decl/hierarchy/outfit/nanotrasen/guard,
                      "Nanotrasen Officer" = /decl/hierarchy/outfit/nanotrasen/officer,
					  "Nanotrasen Regional Commander" = /decl/hierarchy/outfit/nanotrasen/captain)

	economic_modifier = 40
	minimum_character_age = 20 // Pushing it I guess, but possible
	ideal_character_age = 40
	req_admin_notify = 1

/datum/job/nanotrasen/get_access()
	get_all_station_access()
	get_all_centcom_access()
	return