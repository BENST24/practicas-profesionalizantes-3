class ApplicationUI extends HTMLElement 
{
    constructor() 
    {
        super();
        const shadow = this.attachShadow({ mode: 'closed' });

        // ==== Styles ====
        const style = document.createElement('style');
        style.textContent = `
          :host {
            display: flex;
            height: 100vh;
            font-family: Arial, sans-serif;
          }

          .sidebar {
            width: 200px;
            background-color: #f0f0f0;
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            gap: 10px;
            border-right: 1px solid #ccc;
          }

          .sidebar button {
            padding: 10px;
            font-size: 14px;
            cursor: pointer;
          }

          .sidebar input[type="color"] {
            width: 100%;
            height: 40px;
            border: none;
            cursor: pointer;
          }

          .canvas-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ffffff;
            border-right: 1px solid #ccc;
          }

          canvas {
            border: 1px solid #000;
            width: 800px;
            height: 400px;
            background-color: #eee;
          }

          .table-panel {
            width: 300px;
            padding: 20px;
            box-sizing: border-box;
            background-color: #fafafa;
          }

          table {
            width: 100%;
            border-collapse: collapse;
          }

          th, td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: left;
          }

          th {
            background-color: #ddd;
          }

          td input[type="radio"] {
            display: block;
            margin: auto;
          }
        `;

        // ==== Container ====
        const container = document.createElement('div');
        container.style.display = 'flex';
        container.style.flex = '1';

        // ==== Sidebar ====
        const sidebar = document.createElement('div');
        sidebar.className = 'sidebar';

        this.btnRect = document.createElement('button');
        this.btnRect.textContent = 'Crear rectángulo';

        this.btnCircle = document.createElement('button');
        this.btnCircle.textContent = 'Crear círculo';

        this.btnTriangle = document.createElement('button');
        this.btnTriangle.textContent = 'Crear triángulo';

        const colorLabel = document.createElement('label');
        colorLabel.setAttribute('for', 'colorPicker');
        colorLabel.textContent = 'Color:';

        this.colorInput = document.createElement('input');
        this.colorInput.type = 'color';
        this.colorInput.id = 'colorPicker';
        this.colorInput.name = 'colorPicker';

        sidebar.appendChild(this.btnRect);
        sidebar.appendChild(this.btnCircle);
        sidebar.appendChild(this.btnTriangle);
        sidebar.appendChild(colorLabel);
        sidebar.appendChild(this.colorInput);

        // ==== Canvas Container ====
        const canvasContainer = document.createElement('div');
        canvasContainer.className = 'canvas-container';

        this.canvas = document.createElement('canvas');
        this.canvas.width = 800;
        this.canvas.height = 400;
        canvasContainer.appendChild(this.canvas);

        // ==== Table Panel ====
        const tablePanel = document.createElement('div');
        tablePanel.className = 'table-panel';

        this.table = document.createElement('table');

        const thead = document.createElement('thead');
        const trHead = document.createElement('tr');

        const thSelect = document.createElement('th');
        thSelect.textContent = ' ';
        const thId = document.createElement('th');
        thId.textContent = 'ID';
        const thType = document.createElement('th');
        thType.textContent = 'Tipo';

        trHead.appendChild(thSelect);
        trHead.appendChild(thId);
        trHead.appendChild(thType);
        thead.appendChild(trHead);
        this.table.appendChild(thead);

        tablePanel.appendChild(this.table);

        const tbody = document.createElement('tbody');
        this.table.appendChild(tbody);

        // ==== Assemble ====
        container.appendChild(sidebar);
        container.appendChild(canvasContainer);
        container.appendChild(tablePanel);

        shadow.appendChild(style);
        shadow.appendChild(container);

        //-------------------------------Event management-------
        this.btnRect.onclick = () =>
        {
            //console.log('click on btnRect');
            this.dispatchEvent( new CustomEvent('createRectangleRequest') );
        }

        this.btnCircle.onclick = () =>
        {
            this.dispatchEvent( new CustomEvent('createCircleRequest') );
        }

        this.btnTriangle.onclick = () => 
        {
            this.dispatchEvent(new CustomEvent('createTriangleRequest'));
        };
    }

    handleRadioChange(event) 
    {
      const id = event.target.value;
      this._selectedFigureId = id;

      this.dispatchEvent(new CustomEvent('selectFigureRequest', {
          detail: { id: id }
      }));
    }

    updateTable(figuresMap) 
    {
        const tbody = this.table.querySelector('tbody');
        tbody.innerHTML = ""; // limpiar contenido actual

        for (const [id, figure] of figuresMap.entries()) 
        {
            const row = document.createElement('tr');

            const tdId = document.createElement('td');
            tdId.textContent = id;

            const tdType = document.createElement('td');
            // Usamos el nombre de la clase como tipo
            tdType.textContent = figure.constructor.name.replace("Model", "");

            const tdRadio = document.createElement('td');
            const radio = document.createElement('input');
            radio.type = 'radio';
            radio.name = 'selectedFigure';
            radio.value = id;

            tdRadio.appendChild(radio);
            row.appendChild(tdRadio);
            row.appendChild(tdId);
            row.appendChild(tdType);
            tbody.appendChild(row);
            radio.addEventListener('change', this.handleRadioChange.bind(this));
        }
    }


    static getDispatchedEvents()
    {
        return ['createRectangleRequest', 'createCircleRequest', 'createTriangleRequest', 'selectFigureRequest'];
    }

    getDrawingContext2D()
    {
       return this.canvas.getContext("2d");
    }

    getFormData()
    {
        let dataObject =
        {
            color: this.colorInput.value,
            selectedFigure: null
        };

        return dataObject;
    }

    render(objects)
    {
        //Limpieza
        this.getDrawingContext2D().clearRect(0, 0, this.canvas.width, this.canvas.height);

        //Dibujado
        for (const item of objects.values() )
        {
            item.draw(this.getDrawingContext2D());
        }
    }

}

customElements.define('applicationui-wc', ApplicationUI );

export { ApplicationUI };