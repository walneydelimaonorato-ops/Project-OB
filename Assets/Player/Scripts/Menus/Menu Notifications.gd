extends Node

func _ready() -> void:
	SignalBus.Notification.connect(Notification)
	%Notification.visible = false

func Notification(Notification_Text: String, Notification_Time: int):
	%Notification.visible = true
	%Message.text = str(Notification_Text, "...")
	
	%"Notification Timer".wait_time = Notification_Time
	%"Notification Timer".start()

func notification_timer_timeout() -> void:
	%Notification.visible = false
	%Message.text = ""
