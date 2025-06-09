import { ApplicationController } from "./controllers/ApplicationController.js";
import { Manager_Figures } from "./models/Manager_figures.js";
import { ApplicationUI } from "./views/ApplicationUI.js";

function main() 
{
    const view = new ApplicationUI();
    const model = new Manager_Figures();
    const controller = new ApplicationController(view, model);

    controller.init();

    setInterval(view.render.bind(view, model.getFigures()), 16);
    setInterval(controller.moveControl.bind(controller), 16);

    document.body.appendChild(view);
}

window.onload = main;