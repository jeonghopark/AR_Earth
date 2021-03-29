attribute vec4 position;
attribute vec4 color;
attribute vec4 normal;
attribute vec2 texcoord;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

uniform vec4 u_texturecord;
//varying vec2 texCoord;

varying vec4 colorVarying;
varying vec2 texCoordVarying;

varying float textureNumber;

uniform vec2 u_resolution;

uniform float u_time;
varying float time;

uniform vec2 offsetAudioSignal;
varying vec2 _offsetAudioSignal;


void main() {
    
    _offsetAudioSignal = offsetAudioSignal;
    
    time = u_time;
    texCoordVarying = texcoord;
//    vec2 _v = vec2(1024.0, 768.0);
//    resolution = u_resolution;
//	texCoordVarying = u_resolution;
	gl_Position = projectionMatrix * modelViewMatrix * position;

}


