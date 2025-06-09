import { Figure } from "./figures.js";
import { CircleModel } from "./figures.js";
import { RectangleModel } from "./figures.js";

class Manager_Figures extends EventTarget
{
    constructor() 
    {
        super();

        this._figures = new Map();
        this._selectedFigure = null;
    }

    chanchangeSelectedFigure(idName)
    {
        this._selectedFigure = this._figures.get(idName);
        this.dispatchEvent(new CustomEvent('modelchanged'));
    }

    createCircle(x, y, radius, color, idName)
    {
        this._figures.set(idName, new CircleModel(x, y, radius, color))
        this.dispatchEvent( new CustomEvent('modelchanged') );
    }

    createRectangle(x, y, width, height, color, idName)
    {
        this._figures.set(idName,  new RectangleModel(x, y, width, height, color));
        this.dispatchEvent( new CustomEvent('modelchanged') );
    }

    getFigure(idName)
    {
        return this._figures.get(idName);
    }

    getFigures()
    {
        return this._figures;
    }

    getSelectedFigure()
    {
        return this._selectedFigure;
    }
}

export { Manager_Figures };