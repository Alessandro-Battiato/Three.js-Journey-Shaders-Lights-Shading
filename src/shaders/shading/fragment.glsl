uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/ambientLight.glsl
#include ../includes/directionalLight.glsl

void main()
{
    vec3 normal = normalize(vNormal); // fixes the grid like effect of normals being lower than 1
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    vec3 color = uColor;

    // Light
    vec3 light = vec3(0.0); // fully dark light thus no colors
    light += ambientLight(
        vec3(1.0), // Light color
        0.03 // Light intensity
    );
    light += directionalLight(
        vec3(0.1, 0.1, 1.0), // Light color
        1.0, // Light intensity
        normal, // Normal
        vec3(0.0, 0.0, 3.0), // Light position
        viewDirection, // View direction
        20.0 // Specular power
    );
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}