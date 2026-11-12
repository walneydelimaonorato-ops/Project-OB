extends Node

func _ready() -> void:
	IntSigBus.Interaction_Wait.connect(InterWaitTrig)
func _physics_process(delta: float) -> void:
	InterWaitMoni()

func InterWaitTrig(Active: bool, Modifier: float):
	PLY_Data.IntWai_Thre_Modi = Modifier
	PLY_Data.IntWaiAct = Active

func InterWaitMoni():
	if PLY_Data.IntWaiAct == true and PLY_Data.IntWaiTim <= (PLY_Data.IntWai_Threshold + PLY_Data.IntWai_Thre_Modi):
		PLY_Data.IntWaiTim += 0.1
	else:
		# over the threshold
		if PLY_Data.IntWaiTim > (PLY_Data.IntWai_Threshold + PLY_Data.IntWai_Thre_Modi): 
			InterWaitTrig(false, 0.0)
			PLY_Data.IntWaiTim = 0.0
		# under the threshold
		elif PLY_Data.IntWaiTim < (PLY_Data.IntWai_Threshold + PLY_Data.IntWai_Thre_Modi) and PLY_Data.IntWaiTim > 0.0: 
			InterWaitTrig(false, 0.0)
			PLY_Data.IntWaiTim = 0.0
	return
