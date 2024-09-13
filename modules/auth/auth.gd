extends Panel

var url = "https://atlantis-pbem.com/game/download-json-report";
var uploadURL = "";
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
		
func upload(order: String):
	var request = $HTTPRequest;

	# Create a FormData object
	var form_data = FormData.new()

	# Write the init image to the request
	#var init_image_path = "../init_image_1024.png"
	#var init_image_file = File.new()
	#init_image_file.open(init_image_path, File.READ)
	form_data.add_file("init_image", "orders.ord", order.to_utf8_buffer())

	# Write other fields to the request
	form_data.add_field("init_image_mode", "IMAGE_STRENGTH")
	form_data.add_field("image_strength", "0.35")
	form_data.add_field("text_prompts[0][text]", "Galactic dog with a cape")
	form_data.add_field("cfg_scale", "7")
	form_data.add_field("samples", "1")
	form_data.add_field("steps", "30")

	# Set up the HTTPRequest
	var headers = [
		 "Accept: image/png",
		 "Content-Length: " + str(len(order)),
		 "Content-Type: multipart/form-data; boundary=" + form_data.get_boundary()
	]
	# Connect the signals to handle the response
	request.request_completed.connect(self._on_request_completed)

	# Set up the HTTPRequest
	request.request_raw(uploadURL, headers, HTTPClient.METHOD_POST, form_data.get_data())

