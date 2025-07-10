class Auto 
{
    constructor() 
    {
        this._isOn = false;
        this._speed = 0;
        this._turnAngle = 90;
        this._hand_brake = true;
    }

    get isOn() 
    {
        return this._isOn;
    }

    get speed() 
    {
        return this._speed;
    }

    get turnAngle() 
    {
        return this._turnAngle;
    }

    get hand_brake() 
    {
        return this._hand_brake;
    }

    turn_on() 
    {
        if (!this._isOn && this._hand_brake) 
        {
            this._isOn = true;
        }
    }

    turn_off() 
    {
        this._isOn = false;
        this._speed = 0;
        this._turnAngle = 90;
    }

    accelerate() 
    {
        if (this._isOn && !this._hand_brake && this._speed < 200) 
        {
            this._speed += 10;
        }
    }

    decelerate() {
        if (this._speed > 0) 
        {
            this._speed -= 10;
            if (this._speed < 0) this._speed = 0;
        }
    }

    turn_left() 
    {
        if (this._turnAngle > 60) 
        {
            this._turnAngle -= 5;
        }
    }

    turn_right() 
    {
        if (this._turnAngle < 120) 
        {
            this._turnAngle += 5;
        }
    }

    activate_handbrake() 
    {
        this._hand_brake = true;
        this._speed = 0;
    }

    release_handbrake() 
    {
        this._hand_brake = false;
    }
}
