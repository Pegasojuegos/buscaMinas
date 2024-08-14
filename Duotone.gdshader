shader_type canvas_item;

//const vec3 greyWeights = vec3(0.299f,0.587f,0.114f);

const vec3 colorInput = vec3(229.0,108.0,28.0);
const float unifyFactor = 0.00392156862745;
void vertex() {

}



void fragment() {

	vec3 ColorOutput = vec3(229.0*unifyFactor,108.0*unifyFactor,28.0*unifyFactor);

	vec4 input_color = texture(TEXTURE, UV); // 1
	float gray = 0.21 * input_color.r + 0.71 * input_color.g + 0.07 * input_color.b; // 2
	vec4 output_color = vec4(ColorOutput, input_color.a); // 3
	COLOR = output_color; // 4
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
