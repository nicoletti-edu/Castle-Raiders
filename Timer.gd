extends Control

func _process(delta):
	
	$RichTextLabel.text = secondsToMinutes($Timer.time_left)

func secondsToMinutes(seconds):
	var minutes = 0
	seconds = int(seconds)
	minutes = seconds / 60
	floor(minutes)
	seconds = seconds - minutes*60
	var resulting_string = "%d : %02d" % [minutes, seconds]
	return resulting_string
