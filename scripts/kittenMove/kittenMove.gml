function kittenMove() {
	vsp = 4; //grv;

//drift
	if(key_left && !key_right) {
		//hsp = max(-maxsp, hsp-acc);
		hsp = hsp - 1;
	}
	else if(key_right && !key_left) {
			//hsp = min(maxsp, hsp+acc);
			hsp = hsp + 1;
	}
	else {
		if(hsp > 0) {
			hsp = max(0, hsp - acc);	
		}
		else if(hsp < 0) {
			hsp = min(0, hsp + acc);	
		}
	}

	//horizontal collision
	if(place_meeting (x+hsp, y, obj_bookcase)) || place_meeting (x+hsp, y, obj_obstacle) {
		while (!place_meeting(x+sign(hsp), y, obj_bookcase) && !place_meeting (x+hsp, y, obj_obstacle)) {
			//x = x + sign(hsp);
			if(!obj_obstacle.hasBeenHit) collision();
		}
		hsp = 0;
	}
	x = x + hsp;
	
	//vertical collision
	if(place_meeting(x, y + vsp, obj_obstacle)) {
		vsp = 0;
		if(!obj_obstacle.hasBeenHit) collision();
	}
	
	y = y + vsp;
}

function collision() {
	switch(state) {
		case ORIENTATION.UP: state = ORIENTATION.LEFT; break;
		case ORIENTATION.RIGHT: state = ORIENTATION.UP; break;
		case ORIENTATION.DOWN: state = ORIENTATION.RIGHT; break;
		case ORIENTATION.LEFT: state = ORIENTATION.DOWN; break;
	}
	draw_self();
	obj_obstacle.hasBeenHit = true;
}

