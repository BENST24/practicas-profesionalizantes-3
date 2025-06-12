class ApplicationController 
{
    constructor(view, model) 
    {
        this.view = view;
        this.model = model;

        this.modelFigure = null;

        this.keys = {
            w: false,
            s: false,
            a: false,
            d: false
        };

        this.updateTable = this.view.updateTable.bind(this.view, this.model.getFigures());
    }

    init()
    {
        this.view.addEventListener('createRectangleRequest', this.onCreateRectangleButtonClick.bind(this) );
        this.view.addEventListener('createCircleRequest', this.onCreateCircleButtonClick.bind(this) );
        this.view.addEventListener('createTriangleRequest', this.onCreateTriangleButtonClick.bind(this));
        
        this.view.addEventListener('selectFigureRequest', this.onSelectFigure.bind(this));

        window.addEventListener("keydown", this.onKeyDownPressed.bind(this));
        window.addEventListener("keyup", this.onKeyDropUp.bind(this));
    }

    onCreateRectangleButtonClick(event)
    {
        //Datos pedidos al usuario
        let id = prompt('Ingrese ID:');
        let width = prompt('Ingrese ancho:');
        let height = prompt('Ingrese alto:');
        let x = prompt('Ingrese x:');
        let y = prompt('Ingrese y:');

        //Datos pedidos a la interfaz
        let color = this.view.getFormData().color;

        //Acceso al modelo
        this.model.createRectangle(x, y, width, height, color, id);
        this.updateTable();
    }

    onCreateCircleButtonClick(event)
    {
        //Datos pedidos al usuario
        let id = prompt('Ingrese ID:');
        let radius = prompt('Ingrese Radio del Circulo');
        let x = prompt('Ingrese x:');
        let y = prompt('Ingrese y:');

        //Datos pedidos a la interfaz
        let color = this.view.getFormData().color;

        //Acceso al modelo
        this.model.createCircle(x, y, radius, color, id);
        this.updateTable();
    }

    onCreateTriangleButtonClick(event) 
    {
        let id = prompt('Ingrese ID:');
        let side = prompt('Ingrese lado del triángulo:');
        let x = prompt('Ingrese x:');
        let y = prompt('Ingrese y:');
        let color = this.view.getFormData().color;

        this.model.createTriangle(x, y, side, color, id);
        this.updateTable();
    }

    onSelectFigure(event) 
    {
        const id = event.detail.id;
        this.model.chanchangeSelectedFigure(id);
        this.modelFigure = this.model.getSelectedFigure();
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
        if (this.modelFigure && this.keys.w) 
        {
            this.modelFigure.move(2);
        }
    }

    moveBackward() 
    {
        if (this.modelFigure && this.keys.s) 
        {
            this.modelFigure.move(-2);
        }
    }

    moveRotateLeft() 
    {
        if (this.modelFigure && this.keys.a) 
        {
            this.modelFigure.rotate(-0.05);
        }
    }

    moveRotateRight() 
    {
        if (this.modelFigure && this.keys.d) 
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

export { ApplicationController };