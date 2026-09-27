shader_type spatial;

void fragment() {
	vec3 gold = vec3(0.83, 0.55, 0.15);

	ALBEDO = gold;
	METALLIC = 1.0;
	ROUGHNESS = 0.18;
}