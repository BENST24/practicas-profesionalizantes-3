class RectangleController {
    constructor(model, controls = {}) 
    {
        this.model = model;

        this.controls = 
        {
            forward: controls.forward || "ArrowUp",
            backward: controls.backward || "ArrowDown",
            rotateLeft: controls.rotateLeft || "ArrowLeft",
            rotateRight: controls.rotateRight || "ArrowRight"
        };

        this.keys = {};
        for (const action in this.controls) 
        {
            const key = this.controls[action];
            this.keys[key] = false;
        }
    }

    init() 
    {
        window.addEventListener("keydown", this.onKeyDownPressed.bind(this));
        window.addEventListener("keyup", this.onKeyDropUp.bind(this));
    }

    onKeyDownPressed(event) 
    {
        if (event.key in this.keys) 
        {
            this.keys[event.key] = true;
        }
    }

    onKeyDropUp(event) 
    {
        if (event.key in this.keys) 
        {
            this.keys[event.key] = false;
        }
    }

    moveForward() 
    {
        if (this.keys[this.controls.forward]) 
        {
            this.model.move(2);
        }
    }

    moveBackward() 
    {
        if (this.keys[this.controls.backward]) 
        {
            this.model.move(-2);
        }
    }

    moveRotateLeft() 
    {
        if (this.keys[this.controls.rotateLeft]) 
        {
            this.model.rotate(-0.05);
        }
    }

    moveRotateRight() 
    {
        if (this.keys[this.controls.rotateRight]) 
        {
            this.model.rotate(0.05);
        }
    }

    moveControl() 
    {
        this.moveForward();
        this.moveBackward();
        this.moveRotateLeft();
        this.moveRotateRight();
    }
}

export { RectangleController };