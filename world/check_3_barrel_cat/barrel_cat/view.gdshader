shader_type canvas_item;

uniform float view;
uniform vec2 look_direction;
uniform vec2 character_position;


void fragment()
{
	float player_distance = distance(character_position,VERTEX);
	COLOR.a = player_distance/view;
}
