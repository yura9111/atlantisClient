RSRC                    ShaderMaterial            ��������                                                  resource_local_to_scene    resource_name    code    script    shader        
   local://1          local://ShaderMaterial_1i2y0 �         Shader          �   shader_type canvas_item;
render_mode unshaded;

void fragment() {
COLOR = texture(TEXTURE, UV); 
COLOR.rgb = vec3(dot(COLOR.rgb, vec3(0.299, 0.587, 0.114)));
}          ShaderMaterial                       RSRC