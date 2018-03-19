# Cel Shading

Unity implementation of the 'Dot3 Cel Shading' method described in ShaderX #3.

Contains two variations of the method.

Calculates the angle between the camera and the fragment normal [`dot(viewDir, normal)`] and colors given a color and a maximum number of color steps. 


X outer angle divisions are colored in edge color (black).

It's easier if you read the code.

# Renders

## Method 1
![Bubble](Renders/Cel1.png "Render.PNG")
## Method 2
![Bubble](Renders/Cel2.png "Render.PNG")

