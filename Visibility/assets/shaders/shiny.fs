#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define MY_HIGHP_OR_MEDIUMP highp
#else
	#define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 shiny;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    // Pixelation effect: quantize texture coordinates
    MY_HIGHP_OR_MEDIUMP float pixel_size = 0.02 * (1.0 + shiny.x); // Adjust pixelation based on shiny.x
    MY_HIGHP_OR_MEDIUMP vec2 pixelated_coords = floor(texture_coords / pixel_size) * pixel_size;

    // Sample texture at pixelated coordinates
    vec4 tex = Texel(texture, pixelated_coords);

    // Base golden color (RGB for gold: ~1.0, 0.843, 0.0)
    MY_HIGHP_OR_MEDIUMP vec3 gold_color = vec3(1.0, 0.843, 0.0);

    // Modulate golden tint intensity with shiny.y
    MY_HIGHP_OR_MEDIUMP float shine_factor = 0.5 + 0.5 * sin(shiny.y * 3.14159); // Oscillate between 0.5 and 1.0
    MY_HIGHP_OR_MEDIUMP vec3 final_color = mix(tex.rgb, gold_color, 0.4 * shine_factor);

    // Preserve original alpha
    return vec4(final_color, tex.a);
}

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position;
}
#endif
