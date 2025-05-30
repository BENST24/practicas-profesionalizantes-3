import { GameEngineRenderer } from "./views/renderer.js";
import { RectangleModel } from "./models/figures.js";
import { CircleModel } from "./models/figures.js";
import { RectangleController } from "./controllers/controllers.js";


function main() 
{
    const canvas = document.getElementById('myCanvas');

    let renderer = new GameEngineRenderer(canvas);
    renderer.addObject( 'a', new RectangleModel(200, 200, 50, 25, 'blue'));
    renderer.addObject( 'b', new RectangleModel(200, 300, 50, 25, 'red'));
    renderer.addObject( 'C', new CircleModel(200, 100, 25, 'red'));

    const controllers = 
    [
        new RectangleController(renderer.getObject('a')), // usa flechas
        new RectangleController(renderer.getObject('b'), {forward: 'w', backward: 's', rotateLeft: 'a', rotateRight: 'd'}),
        new RectangleController(renderer.getObject('C')), // usa flechas
    ];

    for (const item of controllers.values() )
    {
        item.init();
    }

    setInterval( renderer.render.bind(renderer), 16 );

    for (const item of controllers.values() )
    {
        setInterval( item.moveControl.bind(item), 16 );
    }
}

window.onload = main;