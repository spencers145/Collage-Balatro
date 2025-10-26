extern vec2  u_startPos;
extern vec2  u_endPos;
extern float u_thickness;
extern float u_progress;

vec4 effect(vec4 inputColor, Image texture, vec2 uv, vec2 screenCoord)
{
    vec2 direction = normalize(u_endPos - u_startPos);
    vec2 normal = vec2(-direction.y, direction.x);

    float distance = abs(dot(screenCoord - u_startPos, normal));

    if (distance < (1.0 - u_progress) * u_thickness * 0.5)
        return vec4(1.0, 1.0, 1.0, 1.0);
    else
        return vec4(0.0);
}
