#ifdef GL_ES
  precision mediump float;
  precision mediump int;
#endif


// --- Uniforms ---
extern vec2 gold_foil;
extern float dissolve;
extern float time;
extern vec4 texture_details;
extern vec2 image_details;
extern bool shadow;
extern vec4 burn_colour_1;
extern vec4 burn_colour_2;
extern vec2 mouse_screen_pos;
extern float hovering;
extern float screen_scale;

// --- Dissolve mask helper (unchanged) ---
vec4 dissolve_mask(vec4 tex, vec2 tc, vec2 uv) {
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.0) : tex.xyz,
                    shadow ? tex.a * 0.3 : tex.a);
    }
    float adj = (dissolve*dissolve*(3.0-2.0*dissolve))*1.02 - 0.01;
    float tval = time * 10.0 + 2003.0;

    vec2 fuv = floor(uv * texture_details.ba)
             / max(texture_details.b, texture_details.a);
    vec2 c = (fuv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);

    vec2 f1 = c + 50.0 * vec2(sin(-tval/143.6340), cos(-tval/99.4324));
    vec2 f2 = c + 50.0 * vec2(cos( tval/53.1532),    cos( tval/61.4532));
    vec2 f3 = c + 50.0 * vec2(sin(-tval/87.53218),  sin(-tval/49.0));

    float field = (1.0 + (
        cos(length(f1)/19.483) +
        sin(length(f2)/33.155) * cos(f2.y/15.73) +
        cos(length(f3)/27.193) * sin(f3.x/21.92)
    )) * 0.5;

    vec2 borders = vec2(0.2, 0.8);
    float res = 0.5 + 0.5 * cos(adj/82.612 + (field-0.5)*3.14);

    // border fades
    res -= (fuv.x > borders.y ? (fuv.x-borders.y)*(5.0+5.0*dissolve) : 0.0) * dissolve;
    res -= (fuv.y > borders.y ? (fuv.y-borders.y)*(5.0+5.0*dissolve) : 0.0) * dissolve;
    res -= (fuv.x < borders.x ? (borders.x-fuv.x)*(5.0+5.0*dissolve) : 0.0) * dissolve;
    res -= (fuv.y < borders.x ? (borders.x-fuv.y)*(5.0+5.0*dissolve) : 0.0) * dissolve;

    if (tex.a>0.01 && burn_colour_1.a>0.01 && !shadow
        && res>adj
        && res<adj+0.8*(0.5-abs(adj-0.5)))
    {
        if (res<adj+0.5*(0.5-abs(adj-0.5))) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a>0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow?vec3(0.0):tex.xyz,
                res>adj ? (shadow?tex.a*0.3:tex.a) : 0.0);
}

// --- HSL ↔ RGB helpers ---
float hue(float s, float t, float h) {
    float hs = mod(h,1.0)*6.0;
    if (hs<1.0) return (t-s)*hs + s;
    if (hs<3.0) return t;
    if (hs<4.0) return (t-s)*(4.0-hs) + s;
    return s;
}
vec4 RGB(vec4 c) {
    if (c.y<0.0001) return vec4(vec3(c.z), c.a);
    float tt = (c.z<0.5) ? c.y*c.z + c.z
                        : -c.y*c.z + (c.y+c.z);
    float ss = 2.0*c.z - tt;
    return vec4(
        hue(ss,tt,c.x+1.0/3.0),
        hue(ss,tt,c.x),
        hue(ss,tt,c.x-1.0/3.0),
        c.w
    );
}
vec4 HSL(vec4 c) {
    float lo = min(c.r, min(c.g,c.b));
    float hi = max(c.r, max(c.g,c.b));
    float d  = hi - lo;
    float sum = hi + lo;
    vec4 hsl = vec4(0.0,0.0,0.5*sum,c.a);
    if (d==0.0) return hsl;
    hsl.y = (hsl.z<0.5) ? d/sum : d/(2.0-sum);
    if (hi==c.r)      hsl.x = (c.g-c.b)/d;
    else if (hi==c.g) hsl.x = (c.b-c.r)/d + 2.0;
    else              hsl.x = (c.r-c.g)/d + 4.0;
    hsl.x = mod(hsl.x/6.0,1.0);
    return hsl;
}

// --- Fragment effect entrypoint ---
vec4 effect(
    mediump vec4 colour,
    Image texture,
    mediump vec2 tc,
    mediump vec2 sc
) {
    // build UV
    vec2 uv = ((tc * image_details)
              - texture_details.xy * texture_details.ba)
              / texture_details.ba;
    vec2 adv = uv - vec2(0.5);
    adv.x *= texture_details.b/texture_details.a;
    adv.y *= texture_details.b/texture_details.a;

    // base sample
    vec4 base = Texel(texture, tc);

    // HSL shift for sheen
    vec4 hslc = HSL(base);
    hslc.y = 0.02;  // low saturation
    hslc.z *= (0.5 - adv.x * cos(gold_foil.r * 0.512));
    hslc.z *= (1.5 - adv.y * cos(gold_foil.r * 0.512));
    vec4 tinted = RGB(hslc);

    // add gold tint
    vec4 gold = vec4(231.0,164.0,25.0,0.0)/255.0;
    vec4 tex = tinted + gold * 0.6;

    // brightness noise
    float lo = min(tex.r,min(tex.g,tex.b));
    float hi = max(tex.r,max(tex.g,tex.b));
    float d  = min(hi, max(0.6, 1.0 - lo));
    float fac = 0.8 + 0.9 * sin(
        11.0*uv.x + 4.32*uv.y +
        gold_foil.r*12.0 +
        cos(gold_foil.r*5.3 + uv.y*4.2 - uv.x*4.0)
    );
    float maxf = 0.37 * max(fac, 0.0);
    tex.b = tex.b - d + d * maxf * 0.75;
    tex.r = tex.r - d + d * maxf * 0.15;
    tex.g = tex.g - d + d * maxf * 0.10;

    // dummy use of uniforms so Lovely won't strip them
    float _u = (mouse_screen_pos.x
              + mouse_screen_pos.y
              + hovering
              + screen_scale) * 0.0;
    tex.rgb += _u;

    // apply dissolve mask
    return dissolve_mask(tex * colour, tc, uv);
}

#ifdef VERTEX
// Vertex position entrypoint
vec4 position(
    highp mat4 transform_projection,
    highp vec4 vertex_position
) {
    if (hovering <= 0.0) {
        return transform_projection * vertex_position;
    }
    vec2 ms = mouse_screen_pos;
    vec2 diff = (vertex_position.xy - ms) / screen_scale;
    float md = length(vertex_position.xy - 0.5 * love_ScreenSize.xy)
             / length(love_ScreenSize.xy);
    float s = 0.2 * (-0.03 - 0.3 * max(0.0, 0.3 - md))
            * hovering * dot(diff,diff) / (2.0 - md);
    return transform_projection * vertex_position
         + vec4(0.0,0.0,0.0,s);
}
#endif
