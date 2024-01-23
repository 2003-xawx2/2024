shader_type canvas_item;

uniform bool if_work = false;

void fragment()
{
	if (if_work)
	{
		if (COLOR.a !=0.0)
		{
			COLOR = vec4(1,1,1,1);
		}
	}
}


