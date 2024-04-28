uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/ambientLight.glsl

vec3 directionalLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 lightPosition, vec3 viewDirection, float specularPower) {
    vec3 lightDirection = normalize(lightPosition);
    vec3 lightReflection = reflect(- lightDirection, normal); // minus lightDirection fixes the wrong direction of light reflection

    // Shading
    float shading = dot(normal, lightDirection); // dot product
    shading = max(0.0, shading);

    // Specular
    float specular = - dot(lightReflection, viewDirection); // minus here as well fixes an issue regarding the wrong direction
    specular = max(0.0, specular);
    specular = pow(specular, specularPower);

    return lightColor * lightIntensity * (shading + specular);
}

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