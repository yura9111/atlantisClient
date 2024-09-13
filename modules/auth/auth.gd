extends Panel

var url = "https://atlantis-pbem.com/game/download-json-report";
signal loged_in;

func _on_login_pressed():
	$Panel/error.hide();
	loadReport();

func loadReport():
	var json = JSON.stringify({
		"factionId" : $Panel/HBoxContainer/VBoxContainer2/factionId.text, 
		"password" : $Panel/HBoxContainer/VBoxContainer2/password.text
		})
	var headers = ["Content-Type: application/json"]
	var result = $HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json);
	print(result);
	print($Panel/HBoxContainer/VBoxContainer2/factionId.text);


func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.new()
		var error = json.parse(body.get_string_from_utf8())
		if error != 0:
			$Panel/error.show();
			return;
		var gameReport = json.get_data()
		emit_signal("loged_in", gameReport);
	else:
		$Panel/error.show();

