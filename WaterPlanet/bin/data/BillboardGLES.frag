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

varying vec2 _offsetAudioSignal;



varying float textureNumber;
varying float time;


// Author @patriciogv - 2015
// Title: Ikeda Data Stream

//varying vec2 texCoord;


//uniform vec2 u_mouse;
//uniform float u_time;


float random (in float x) {
    return fract(sin(x)*1e4);
}

float random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float pattern(vec2 st, vec2 v, float t) {
    vec2 p = floor(st+v);
    return step(t, random(100.+p*.000001)+random(p.x)*0.5 );
}

void main() {
    
    vec2 st = texCoordVarying;
    
    vec2 grid = vec2(120.0, 60.0);
    st *= grid;
    
    vec2 ipos = floor(st);  // integer
    vec2 fpos = fract(st);  // fraction
    
    vec2 vel = vec2(time * 2. * max(grid.x, grid.y)); // time
    vel *= vec2((random(ipos.y) - 0.5) * 2.0, 0.0) * random(1.0 + ipos.y); // direction
    
    // Assign a random value base on the integer coord
    vec2 offset = vec2(0.5, 0.0);
//    offset = _offsetAudioSignal;
    
    vec4 color = vec4(0.);
    color.r = pattern(st + offset, vel, 0.5);
    color.g = pattern(st, vel, 0.5);
    color.b = pattern(st - offset, vel, 0.5);
    
    // Margins
    color *= smoothstep(0.9, 0.8, fpos.y) * smoothstep(0.2, 0.3, fpos.y);
    
    // if ((color.r + color.g + color.b) > 2.9) {
    //     color.a = 0.0;
    // } else {
    //     color.a = 1.0;
    // }
    color.a = smoothstep(2.5, 3.0, (color.r + color.g + color.b));
//    color.a = 1.0;
    gl_FragColor = vec4(0.1, 0.1, color.b * 0.6, color.a);
    
//    gl_FragColor = texture2D(src_tex_unit0, gl_PointCoord) * vec4(1.0);
}

