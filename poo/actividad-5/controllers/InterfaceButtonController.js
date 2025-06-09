class InterfaceButtonController
{
    constructor( view, model )
    {
        this.view = view;
        this.model = model;

        this.aupdateTable = this.view.updateTable.bind(this.view, this.model.getFigures());

        // this.ctx = this.view.getDrawingContext2D();
    }

    init()
    {
        // this.model.addEventListener('modelchanged', this.onModelChanged.bind(this) );
        this.view.addEventListener('createRectangleRequest', this.onCreateRectangleButtonClick.bind(this) );
        this.view.addEventListener('createCircleRequest', this.onCreateCircleButtonClick.bind(this) );
        this.view.addEventListener('selectFigureRequest', this.onSelectFigure.bind(this));
    }

    release()
    {
        //this.view.removeEventListener()
    }

    //Estrategia 1: Procesar eventos de notificación del modelo
    // onModelChanged(event)
    // {
    //     //Clear

    //     //Drawing
    //     for( let object of this.model.getObjectIterator() )
    //     {
    //         object.draw( this.ctx );
    //     }
    // }

    //Manejadores de eventos producidos desde la UI
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
        // let new_figure = new Rectangle(x,y,width,height,color)
        // this.model.addObject(id, new_figure);
        this.model.createRectangle(x, y, width, height, color, id);
        this.aupdateTable();
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
        this.aupdateTable();
    }

    onCreateTriangleButtonClick(event)
    {

    }

    onSelectFigure(event) 
    {
        const idSelected = event.detail.id;
        this.model.chanchangeSelectedFigure(idSelected);
        // console.log("Figura seleccionada:", this.model.getSelectedFigure());
    }
}

export { InterfaceButtonController }