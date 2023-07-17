//get input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));

kittenMove();
prevState = state;

switch (state) {
	case ORIENTATION.UP: image_angle = 180; break;
	case ORIENTATION.DOWN: image_angle = 0; break;
	case ORIENTATION.LEFT: image_angle = 90; break;
	case ORIENTATION.RIGHT: image_angle = -90; break;
}