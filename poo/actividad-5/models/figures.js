class Figure
{
    constructor(x, y, color, angle = 0) 
    {
        this._x = x;
        this._y = y;
        this._color = color;
        this._angle = angle;
    }

    rotate(radians) 
    {
        this._angle += radians;
    }

    move(distance)
    {
        this._x += distance * Math.cos(this._angle);
        this._y += distance * Math.sin(this._angle);
    }
}

class RectangleModel extends Figure
{
    constructor(x, y, width, height, color) 
    {
        super(x, y, color)

        this._width = width;
        this._height = height;

    }

    draw(ctx) 
    {
        ctx.save();
        ctx.translate(this._x, this._y);
        ctx.rotate(this._angle);
        ctx.fillStyle = this._color;
        ctx.fillRect(-this._width / 2, -this._height / 2, this._width, this._height);
        ctx.restore();
    }
}

class CircleModel extends Figure
{
    constructor(x, y, radius, color) 
    {
        super(x, y, color)

        this._radius = radius;
    }

    draw(ctx) 
    {
        ctx.save();
        ctx.translate(this._x, this._y);
        ctx.beginPath();
        ctx.arc(0, 0, this._radius, 0, 2 * Math.PI);
        ctx.fillStyle = this._color;
        ctx.fill();
        ctx.restore();
    }
}

export {Figure, RectangleModel, CircleModel};


// class RectangleModel
// {
//     constructor(x, y, width, height, color, angle = 0) 
//     {
//         this._x = x;
//         this._y = y;
//         this._width = width;
//         this._height = height;
//         this._color = color;
//         this._angle = angle;
//     }

//     rotate(radians) 
//     {
//         this._angle += radians;
//     }

//     move(distance)
//     {
//         this._x += distance * Math.cos(this._angle);
//         this._y += distance * Math.sin(this._angle);
//     }

//     draw(ctx) 
//     {
//         ctx.save();
//         ctx.translate(this._x, this._y);
//         ctx.rotate(this._angle);
//         ctx.fillStyle = this._color;
//         ctx.fillRect(-this._width / 2, -this._height / 2, this._width, this._height);
//         ctx.restore();
//     }
// }

// export { RectangleModel };