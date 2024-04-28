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