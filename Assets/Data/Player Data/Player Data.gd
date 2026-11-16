extends Node

var Dumah: CharacterBody3D

## Menus assignment
# Menus collections
var Menus_Minor: Array[Control]
var Menus_Major: Array[Control]
var Menus_All: Array[Array]
# Individual menus
var MRest: Control
var M: Control
# SubMenu Indexing
var Equipment_Selector_Index: int = 0
## Vitals
var Max_Health: float = 20.0
var Max_Stamina: float = 40.0
var Health: float = 0.0
var Stamina: float = 0.0
## Bonuses
var Health_Bonus: float = 0.0
var Health_Moth_Bonus: float = 0.0
var Stamina_Bonus: float = 0.0
var Stamina_Moth_Bonus: float = 0.0
## Interaction waiting
var IntWaiAct: bool = false
var IntWaiTim: float = 0.0
const IntWai_Threshold: float = 5.0
var IntWai_Thre_Modi: float = 0.0
