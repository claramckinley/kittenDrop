
var leftx = 0;
var lefty =  camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]);

var rightx = room_width;
var righty = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]);

var leftBookcase = instance_create_layer(leftx, lefty, "Instances", obj_bookcase);
var rightBookcase = instance_create_layer(rightx, righty, "Instances", obj_bookcase);

leftBookcase.image_xscale = 10;
leftBookcase.image_yscale = 10;

rightBookcase.image_xscale = 10;
rightBookcase.image_yscale = 10;