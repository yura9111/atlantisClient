extends Panel


func _on_auth_loged_in(gameReport):
	$auth.queue_free();
	var nexusScene = load("res://modules/nexus/nexus.tscn");
	add_child(nexusScene.instantiate());
