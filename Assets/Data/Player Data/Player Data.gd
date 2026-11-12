extends Node

var Dumah: CharacterBody3D

# Menu indexing and location
enum Menu_List {NONE}
var Cur_Menu = Menu_List.NONE
enum SubMenu_List {NONE}
var Cur_SubMenu = SubMenu_List.NONE
# Vitals
var Max_Health: float = 20.0
var Max_Stamina: float = 40.0
var Health: float = 0.0
var Stamina: float = 0.0
# Bonuses
var Health_Bonus: float = 0.0
var Health_Moth_Bonus: float = 0.0
var Stamina_Bonus: float = 0.0
var Stamina_Moth_Bonus: float = 0.0
# Interaction waiting
var IntWaiAct: bool = false
var IntWaiTim: float = 0.0
const IntWai_Threshold: float = 5.0
var IntWai_Thre_Modi: float = 0.0
