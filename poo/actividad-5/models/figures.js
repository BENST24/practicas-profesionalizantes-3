class Figure
{
    constructor(x, y, color, angle = 0) 
    {
        this._x = parseFloat(x);
        this._y = parseFloat(y);
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

        this._width = parseFloat(width);
        this._height = parseFloat(height);

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

        this._radius = parseFloat(radius);
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

class TriangleModel extends Figure 
{
    constructor(x, y, sideLength, color) 
    {
        super(x, y, color);
        this._sideLength = parseFloat(sideLength);
    }

    draw(ctx) 
    {
        const h = (Math.sqrt(3) / 2) * this._sideLength; // altura del triángulo

        ctx.save();
        ctx.translate(this._x, this._y);
        ctx.rotate(this._angle);
        ctx.beginPath();
        ctx.moveTo(0, -h / 2); // vértice superior
        ctx.lineTo(-this._sideLength / 2, h / 2); // vértice inferior izquierdo
        ctx.lineTo(this._sideLength / 2, h / 2); // vértice inferior derecho
        ctx.closePath();
        ctx.fillStyle = this._color;
        ctx.fill();
        ctx.restore();
    }
}

export {Figure, RectangleModel, CircleModel, TriangleModel};