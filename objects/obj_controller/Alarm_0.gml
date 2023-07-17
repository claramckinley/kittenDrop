randomize();
var count = irandom_range(1, 2);
var vx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2;
var vy = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 100;

var i = instance_create_layer(vx, vy, "Instances", obj_obstacle);
i.sprite_index = choose(spr_obstacle);

switch(i.sprite_index) {
	case spr_obstacle:
		i.image_speed = 0;
		
		if(global.speedModifier > 1.5) {
			if(count == 2) {
				var j = instance_create_layer(vx, vy, "Instances", obj_obstacle);
				j.sprite_index = choose(spr_obstacle)
				j.image_speed = 0;
			}
		}
		break;
}

alarm[0] = room_speed * random_range(1/global.speedModifier, 3/global.speedModifier);