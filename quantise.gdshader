shader_type spatial; 
render_mode unshaded, cull_front; 

uniform sampler2D screenTex: hint_screen_texture; 
uniform float levels : hint_range(2.0, 64.0) = 4.0; 
group_uniforms ColorAdjustment; 
uniform vec3 shadowAdjustment; 
uniform vec3 colAdjustment; 

float bayer4x4(vec2 uv) { 
	int m[16] = int[]( 
	0, 8, 2, 10, 
	12, 4, 14, 6, 
	3, 11, 1, 9, 
	15, 7, 13, 5
	); 
	
	int x = int(mod(uv.x, 4.0));
	int y = int(mod(uv.y, 4.0));
	return float(m[x + y * 4]) / 16.0; } 

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
	} 

void fragment() {
	vec4 col = texture(screenTex, SCREEN_UV);
	float brightness = (col.r + col.g + col.b) - 0.6;
	float limit = bayer4x4(FRAGCOORD.xy);
	col = floor(col * levels) / levels;
	vec3 newCol = (vec3(step(limit, brightness)) * col.rgb);
	ALBEDO = (newCol + (shadowAdjustment / vec3(2.0))) * colAdjustment;
}
