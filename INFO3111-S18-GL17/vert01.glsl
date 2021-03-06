#version 420
// If 420 doesn't work, try 330 
// The VERTEX SHADER

attribute vec3 vCol;		// float r, g, b;
attribute vec3 vPos;		// float x, y, z;

//uniform mat4 MVP;		// Model View Projection
uniform mat4 matModel;
uniform mat4 matView;
uniform mat4 matProjection;

uniform vec3 meshColour; 

// glUniform1f()  pass in 0 or 1 
uniform bool bUseVertexColour;		// 0 or 1 Really a float

// Being passed to next shader stage... 
out vec3 color;				// was varying
out vec3 vertInWorld;		// was varying
out mat4 mat4WorldRotOnly;	// To be used on Tuesday

void main()
{
    vec3 newVertex = vPos;				
	
//    gl_Position = MVP * vec4(newVertex, 1.0);

	// Check the main render to see a similar line of code
	mat4 matMVP = matProjection * matView * matModel;
	// This is the "screen space" location
	gl_Position = matMVP * vec4(newVertex, 1.0);
	
	// Calculate the "world" location of the  matrix.
	// (is vec4 because 4x4 times 4x1 is a 4x1)
	vec4 vertInWorldTemp = matModel * vec4(newVertex, 1.0);
	// Pass along the vec3
	vertInWorld = vertInWorldTemp.xyz;
	
	
	// For diffuse (just copy for now)
	mat4WorldRotOnly = matModel;
	
	color = meshColour;	
	
	if ( bUseVertexColour )
	{
		color = vCol;
	}
};
