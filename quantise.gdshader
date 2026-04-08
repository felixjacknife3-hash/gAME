shader_type spatial;
render_mode unshaded, cull_front;

uniform sampler2D screenTex: hint_screen_texture;
uniform float levels : hint_range(2.0, 64.0) = 4.0;
uniform vec3 colorAdjustment;

float bayer4x4(vec2 uv) {
    float m[16] = float[](
        0.0, 8.0, 2.0, 10.0,
        12.0, 4.0, 14.0, 6.0,
        3.0, 11.0, 1.0, 9.0,
        15.0, 7.0, 13.0, 5.0
    );
    int x = int(mod(uv.x, 4.0));
    int y = int(mod(uv.y, 4.0));
    return m[x + y * 4] / 16.0;
}

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}
void fragment() {
	vec4 col = texture(screenTex, SCREEN_UV);
	
	col = floor(col * levels) / levels;
	col.rgb *= (vec3(1.0, 0.4, 0.5));
	float brightness = (col.r + col.g + col.b);
	float limit = bayer4x4(FRAGCOORD.xy);
	
	ALBEDO = (vec3(step(limit, brightness)) * col.rgb) + colorAdjustment;
}
