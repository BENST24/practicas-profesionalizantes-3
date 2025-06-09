import { MoveKeyController } from "./controllers/MoveKeyController.js";
import { Manager_Figures } from "./models/Manager_figures.js";
import { ApplicationUI } from "./views/ApplicationUI.js";
import { InterfaceButtonController } from "./controllers/InterfaceButtonController.js";




function main() 
{
    let applicationui = new ApplicationUI();
    let managerFigure = new Manager_Figures();
    let interfaceController = new InterfaceButtonController(applicationui, managerFigure);
    let controller = new MoveKeyController();

    // console.log(managerFigure.getSelectedFigure());
    
    interfaceController.init();
    controller.init();

    // Preparar contexto
    const context = 
    {
        manager: managerFigure,
        controller: controller
    };

    // Escuchar evento de selección sin lambda
    applicationui.addEventListener('selectFigureRequest', onFigureSelected.bind(context));
    
    setInterval(applicationui.render.bind(applicationui, managerFigure.getFigures()), 16);
    // setInterval(controller.chanchangeModelFigure.bind(controller, managerFigure.getSelectedFigure()), 16);
    // setInterval(applicationui.updateTable.bind(applicationui, managerFigure.getFigures()), 16);
    // console.log(managerFigure._figures);
    setInterval( controller.moveControl.bind(controller), 16 );

    document.body.appendChild(applicationui);
}

function onFigureSelected(event) 
{
    const selectedId = event.detail.id;

    // Cambiar figura seleccionada en el modelo
    this.manager.chanchangeSelectedFigure(selectedId);

    // Pasar figura al controlador de movimiento
    const figure = this.manager.getSelectedFigure();
    this.controller.chanchangeModelFigure(figure);
}

window.onload = main;