#ifdef GL_ES
// define default precision for float, vec, mat.
precision highp float;
#endif


uniform sampler2D src_tex_unit0;
uniform float useTexture;
uniform float useColors;
uniform vec4 color;

varying float depth;
varying vec4 colorVarying;
varying vec2 texCoordVarying;
uniform sampler2D tex0;
uniform vec2 u_resolution;
        
uniform float alpha;

varying float textureNumber;
varying float time;


#define TWO_PI 6.2831853071
#define MAX_ITER 10



void main( void ) {
    
    float _time = time * 0.25 + 100.0;
    vec2 uv = texCoordVarying;
    uv *= 1.0;
    
    vec2 p = vec2(mod((uv.x + 0.0) * TWO_PI * 3.0, TWO_PI), mod(uv.y * TWO_PI * 4.0, TWO_PI)) - 255.0;
    vec2 i = vec2(p);
    float c = 1.0;
    float inten = 0.003;
    
    for (int n = 0; n < MAX_ITER; n++) {
        float t = _time * (1.0 - (3.5 / float(n+1))) * 0.5;
        i.x = p.x + cos(t - i.x * 3.0) + sin(t + i.y);
        i.y = p.y + sin(t - i.y) + cos(t + i.x);
        c += 1.0 / length(vec2(p.x / (sin(i.x + t) / inten), p.y / (cos(i.y + t) / inten)));
    }

    c /= float(MAX_ITER);
    c = 1.17 - pow(c, 1.4);
    float _p = 2.0;
    vec3 colour = vec3(pow(abs(c), _p));
    colour = clamp(colour + vec3(0.3, 0.1, 0.0), 0.0, 1.0);
    
//    double _alpha = smoothstep(0.5, 0.6, colour);

    gl_FragColor = vec4(colour.rrr, 1.0 - smoothstep(1.0, 0.9, colour.r) * 0.9);

}

