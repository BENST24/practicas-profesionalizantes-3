class MoveKeyController 
{
    constructor(controls = {}) 
    {
        this.modelFigure = null;

        // this.controls = 
        // {
        //     forward: controls.forward || "ArrowUp",
        //     backward: controls.backward || "ArrowDown",
        //     rotateLeft: controls.rotateLeft || "ArrowLeft",
        //     rotateRight: controls.rotateRight || "ArrowRight"
        // };

        // this.keys = {};
        // for (const action in this.controls) 
        // {
        //     const key = this.controls[action];
        //     this.keys[key] = false;
        // }
        this.keys = {
            ArrowUp: false,
            ArrowDown: false,
            ArrowLeft: false,
            ArrowRight: false
        };

    }

    chanchangeModelFigure(figureObject) 
    {
        this.modelFigure = figureObject;
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

    // moveForward() 
    // {
    //     if (this.keys[this.controls.forward]) 
    //     {
    //         this.modelFigure.move(2);
    //     }
    // }

    // moveBackward() 
    // {
    //     if (this.keys[this.controls.backward]) 
    //     {
    //         this.modelFigure.move(-2);
    //     }
    // }

    // moveRotateLeft() 
    // {
    //     if (this.keys[this.controls.rotateLeft]) 
    //     {
    //         this.modelFigure.rotate(-0.05);
    //     }
    // }

    // moveRotateRight() 
    // {
    //     if (this.keys[this.controls.rotateRight]) 
    //     {
    //         this.modelFigure.rotate(0.05);
    //     }
    // }

    moveForward() 
    {
        if (this.modelFigure && this.keys.ArrowUp) 
        {
            this.modelFigure.move(2);
        }
    }

    moveBackward() 
    {
        if (this.modelFigure && this.keys.ArrowDown) 
        {
            this.modelFigure.move(-2);
        }
    }

    moveRotateLeft() 
    {
        if (this.modelFigure && this.keys.ArrowLeft) 
        {
            this.modelFigure.rotate(-0.05);
        }
    }

    moveRotateRight() 
    {
        if (this.modelFigure && this.keys.ArrowRight) 
        {
            this.modelFigure.rotate(0.05);
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

export { MoveKeyController };