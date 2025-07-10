class Ventilador 
{
    constructor(blades_material, blades, diameter, height) 
    {
        this._blades_material = blades_material;
        this._blades = blades;
        this._diameter = diameter;
        this._height = height;
        this._speed = 0;
        this._isOn = false;
    }

    get blades_material() 
    {
        return this._blades_material;
    }

    get blades()
    {
        return this._blades;
    }

    get diameter() 
    {
        return this._diameter;
    }

    get height() 
    {
        return this._height;
    }

    get speed() 
    {
        return this._speed;
    }

    get isOn() 
    {
        return this._isOn;
    }

    increaseSpeed() 
    {
        if (this._speed < 3) 
        {
            this._speed++;
        }
    }

    lowerSpeed() 
    {
        if (this._speed > 0) 
        {
            this._speed--;
        }
    }

    turn_on() 
    {
        if(this._isOn != true)
        {
            this._isOn = true;
        }
    }

    turn_off() 
    {
        if(this._isOn != false)
        {
            this._isOn = false;
            this._speed = 0;
        }
    }
}