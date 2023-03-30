//Fog Shader by Thiago Avidos "PbmnLuv"
//MIT License


shader_type spatial;
render_mode depth_draw_opaque, unshaded, shadows_disabled;

uniform sampler2D image;

uniform float alpha;
uniform vec2 speed;
varying vec3 world_pos;
uniform vec3 cameraPos;
uniform float fogMax;
uniform float fogMin;

varying float distToCam;

void vertex() {
    world_pos = VERTEX;
	distToCam = abs(world_pos.z - cameraPos.z);
}
void fragment( )
{
	vec2 new_uv = UV;
	vec4 new_image = texture( image, new_uv );
	
            
    float alpha02 = 1.0f - (fogMax - distToCam) / (fogMax - fogMin);
            
    if (distToCam > fogMax) {
    	alpha02 = 1.0f;
    }
    if (distToCam < fogMin) {
    	alpha02 = 0.0f;
    }
            
    vec4 finalMix = mix(new_image, vec4(1,1,1,1), alpha02);
	finalMix = mix(finalMix, vec4(1,1,1,1), alpha02);
	

	ALPHA = alpha;
	ALBEDO = finalMix.rgb;
}