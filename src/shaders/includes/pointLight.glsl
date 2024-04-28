vec3 pointLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 lightPosition, vec3 viewDirection, float specularPower, vec3 position, float lightDecay) {
    vec3 lightDelta = lightPosition - position;
    float lightDistance = length(lightDelta);
    vec3 lightDirection = normalize(lightDelta);
    vec3 lightReflection = reflect(- lightDirection, normal); // minus lightDirection fixes the wrong direction of light reflection

    // Shading
    float shading = dot(normal, lightDirection); // dot product
    shading = max(0.0, shading);

    // Specular
    float specular = - dot(lightReflection, viewDirection); // minus here as well fixes an issue regarding the wrong direction
    specular = max(0.0, specular);
    specular = pow(specular, specularPower);

    // Decay
    float decay = 1.0 - lightDistance * 0.3 * lightDecay; // the farther it gets from the light the weaker the light is
    decay = max(0.0, decay);

    return lightColor * lightIntensity * decay * (shading + specular);
}