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


void main(){
	
	time = u_time;
    texCoordVarying = texcoord;

    gl_Position = projectionMatrix * modelViewMatrix * position;

}
