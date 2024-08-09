-- Constants
Battle_Pass = {}
Battle_Pass["LEVELS"] = {1, 2, 3}
Battle_Pass["MONTHS"] = {["JULY"] = 1, ["FEBRUARY"] = 2, ["MARCH"] = 3, ["APRIL"] = 4, ["MAY"] = 5, ["JUNE"] = 6, ["JULY"] = 7, ["AUGUST"] = 8, ["SEPTEMBER"] = 9, ["OCTOBER"] = 10, ["NOVEMBER"] = 11,["DECEMBER"] = 12}
Battle_Pass["TRIGGERS"] = {["KILL"] = 1, ["KILL_PC"] = 2, ["KILL_MONSTERS"] = 3, ["KILL_BOSSESS"] = 4, ["KILL_STONES"] = 5, ["USE"] = 6, ["REFINE"] = 7, ["REFINE_ALL"] = 8, ["FISHING"] = 9, ["FISHING_ALL"] = 10, ["MINING"] = 11, ["MINING_ALL"] = 12, ["DUNGEON"] = 13, ["CUBE"] = 14, ["CUBE_ALL"] = 15, ["ALL_GET_MONEY"] = 16, ["ALL_SPEND_MONEY"] = 17, ["NPC_GET_MONEY"] = 18, ["NPC_SPEND_MONEY"] = 19, ["NPC_SELL_ITEM"] = 20, ["ALL_SELL_ITEM"] = 21, ["DESTROY_ITEM"] = 22, ["GET_GAYA"] = 23}

-- Register pool
battle_pass_register_pool(Battle_Pass["LEVELS"][1])

-- Register month
battle_pass_register_month(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"])

-- Add month's rewards
battle_pass_add_month_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 200002, 3)
battle_pass_add_month_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 200014, 1)
battle_pass_add_month_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 200016, 1)
battle_pass_add_month_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 200017, 1)

-- Add tasks
battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_1", "BATTLE_PASS_DESC_1_1", Battle_Pass["TRIGGERS"]["KILL_MONSTERS"], 0, 25000)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 0, 39023, 10)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 0, 174001, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_2", "BATTLE_PASS_DESC_1_2", Battle_Pass["TRIGGERS"]["KILL_BOSSESS"], 0, 50)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 1, 170405, 10)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 1, 174003, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_3", "BATTLE_PASS_DESC_1_3", Battle_Pass["TRIGGERS"]["KILL_STONES"], 0, 500)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 2, 172001, 10)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 2, 174002, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_4", "BATTLE_PASS_DESC_1_4", Battle_Pass["TRIGGERS"]["USE"], 50255, 50)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 3, 50259, 1)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 3, 174101, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_5", "BATTLE_PASS_DESC_1_5", Battle_Pass["TRIGGERS"]["USE"], 71084, 20000)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 4, 170151, 5)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 4, 174102, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_6", "BATTLE_PASS_DESC_1_6", Battle_Pass["TRIGGERS"]["REFINE_ALL"], 0, 50)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 5, 25042, 1)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 5, 174103, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_7", "BATTLE_PASS_DESC_1_7", Battle_Pass["TRIGGERS"]["CUBE_ALL"], 0, 25)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 6, 25045, 5)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 6, 174201, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_8", "BATTLE_PASS_DESC_1_8", Battle_Pass["TRIGGERS"]["ALL_SPEND_MONEY"], 0, 100000000)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 7, 170208, 300)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 7, 174202, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_9", "BATTLE_PASS_DESC_1_9", Battle_Pass["TRIGGERS"]["ALL_GET_MONEY"], 0, 200000000)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 8, 200015, 1)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 8, 174203, 1)

battle_pass_add_new_task(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], "BATTLE_PASS_TITLE_1_10", "BATTLE_PASS_DESC_1_10", Battle_Pass["TRIGGERS"]["GET_GAYA"], 0, 50)
battle_pass_add_task_reward(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["JULY"], 9, 25045, 3)

-- Printing info
-- battle_pass_print_info(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["APRIL"], 0)
-- battle_pass_print_info(Battle_Pass["LEVELS"][1], Battle_Pass["MONTHS"]["APRIL"], 1)
