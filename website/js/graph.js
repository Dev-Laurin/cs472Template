var theToggles = document.querySelectorAll('.toggles');

for(var i=0;i<theToggles.length;i++)
{
  theToggles[i].addEventListener('change',toggleOptions);
}

var graph_lines = [];

Plotly.d3.json("pollen.json", function(data)
{
  var rawDataURL = 'pollen.json';

  var pdata = data;

  var selectorOptions = {
    buttons: [{
      step: 'month',
      stepmode: 'backward',
      count: 1,
      label: '1m'
    }, {
      step: 'month',
      stepmode: 'backward',
      count: 6,
      label: '6m'
    }, {
      step: 'year',
      stepmode: 'backward',
      count: 1,
      label: '1y'
    }, {
      step: 'year',
      stepmode: 'backward',
      count: 3,
      label: '3y'
    }, {
      step: 'all',
    }],
  };

  Plotly.d3.csv(rawDataURL, function(err, rawData) {
    if(err) throw err;

    var data = prepData(rawData);
    var layout = {
      autosize: true,
      xaxis: {
        rangeselector: selectorOptions,
        rangeslider: {}
      },
      yaxis: {
        fixedrange: true
      },
      paper_bgcolor: 'rgba(0,0,0,0)',
      plot_bgcolor: 'rgba(0,0,0,0)',
      margin: {
        l: 40,
        r: 15,
        b: 0,
        t: 25,
        pad: 0
      },
      showlegend: false
    };
    
    var options = {
      displayModeBar: false
    };

    Plotly.plot('graph', data, layout, options);
  });

  function prepData(rawData) {
    // I am 100% sure there is a better way
    var x00 = [];
    var y00 = [];
    
    var x01 = [];
    var y01 = [];
    
    var x02 = [];
    var y02 = [];

    var x03 = [];
    var y03 = [];

    var x04 = [];
    var y04 = [];

    var x05 = [];
    var y05 = [];

    var x06 = [];
    var y06 = [];

    var x07 = [];
    var y07 = [];

    var x08 = [];
    var y08 = [];

    var x09 = [];
    var y09 = [];

    var x10 = [];
    var y10 = [];

    var x11 = [];
    var y11 = [];

    var x12 = [];
    var y12 = [];

    for (let record=0;record<pdata.length;record++)
    {
      for (let day=0;day<pdata[record]['Data'].length;day++)
      {
        var date = pdata[record]['Year'] + '-' + pdata[record]['Data'][day]['Month'] + '-' + pdata[record]['Data'][day]['Day'];
        
        for(let j=0;j<theToggles.length;j++)
        {
         switch(theToggles[j].id)
          {
            case 'alder':
              x00.push(date);
              y00.push(pdata[record]['Data'][day]['Alder']);
              break;
            case 'birch':
              x01.push(date);
              y01.push(pdata[record]['Data'][day]['Birch']);
              break;
            case 'grass1':
              x02.push(date);
              y02.push(pdata[record]['Data'][day]['Grass']);
              break;
            case 'grass2':
              x03.push(date);
              y03.push(pdata[record]['Data'][day]['Grass2']);
              break;
            case 'mold':
              x04.push(date);
              y04.push(pdata[record]['Data'][day]['Mold']);
              break;
            case 'othertree1':
              x05.push(date);
              y05.push(pdata[record]['Data'][day]['Other1_Tree']);
              break;
            case 'othertree2':
              x06.push(date);
              y06.push(pdata[record]['Data'][day]['Other2_Tree']);
              break;
            case 'other1':
              x07.push(date);
              y07.push(pdata[record]['Data'][day]['Other1']);
              break;
            case 'other2':
              x08.push(date);
              y08.push(pdata[record]['Data'][day]['Other2']);
              break;
            case 'poplaraspen':
              x09.push(date);
              y09.push(pdata[record]['Data'][day]['Poplar_Aspen']);
              break;
            case 'spruce':
              x10.push(date);
              y10.push(pdata[record]['Data'][day]['Spruce']);
              break;
            case 'weed':
              x11.push(date);
              y11.push(pdata[record]['Data'][day]['Weed']);
              break;
            case 'willow':
              x12.push(date);
              y12.push(pdata[record]['Data'][day]['Willow']);
              break;
            default:
              console.log("Not a pollen source.");
          }
        }
      }
    }
    
    var trace00 = {
      mode: 'lines',
      name: 'Alder',
      line: {
        color: '#039a03',
        width: 1
      },
      x: x00,
      y: y00
    };
    var trace01 =  {
      mode: 'lines',
      name: 'Birch',
      line: {
        color: '#226666',
        width: 1
      },
      x: x01,
      y: y01
    };
    var trace02 = {
      mode: 'lines',
      name: 'Grass 1',
      line: {
        color: '#0ba668',
        width: 1
      },
      x: x02,
      y: y02
    };
    var trace03 = {
      mode: 'lines',
      name: 'Grass 2',
      line: {
        color: '#0a0eb4',
        width: 1
      },
        x: x03,
        y: y03
    };
    var trace04 = {
      mode: 'lines',
      name: 'Mold',
      line: {
        color: '#9a0358',
        width: 1
      },
      x: x04,
      y: y04
    };
    var trace05 = {
      mode: 'lines',
      name: 'Other Tree 1',
      line: {
        color: '#76276c',
        width: 1
      },
      x: x05,
      y: y05
    };
    var trace06 = {
      mode: 'lines',
      name: 'Other Tree 2',
      line: {
        color: '#aa3939',
        width: 1
      },
      x: x06,
      y: y06
    };
    var trace07 = {
      mode: 'lines',
      name: 'Other 1',
      line: {
        color: '#4c2d73',
        width: 1
      },
      x: x07,
      y: y07
    };
    var trace08 = {
      mode: 'lines',
      name: 'Other 2',
      line: {
        color: '#2a4f6e',
        width: 1
      },
      x: x08,
      y: y08
    };
    var trace09 = {
      mode: 'lines',
      name: 'Poplar Aspen',
      line: {
        color: '#c65c00',
        width: 1
      },
      x: x09,
      y: y09
    };
    var trace10 = {
      mode: 'lines',
      name: 'Spruce',
      line: {
        color: '#aa6c39',
        width: 1
      },
      x: x10,
      y: y10
    };
    var trace11 = {
      mode: 'lines',
      name: 'Weed',
      line: {
        color: '#c69400',
        width: 1
      },
      x: x11,
      y: y11
    };
    var trace12 = {
      mode: 'lines',
      name: 'Willow',
      line: {
        color: '#727d15',
        width: 1
      },
      x: x12,
      y: y12
    };
    
    graph_lines.push(trace00);
    graph_lines[0].visible00 = true;
    graph_lines.push(trace01);
    graph_lines[1].visible01 = true;
    graph_lines.push(trace02);
    graph_lines[2].visible02 = true;
    graph_lines.push(trace03);
    graph_lines[3].visible03 = true;
    graph_lines.push(trace04);
    graph_lines[4].visible04 = true;
    graph_lines.push(trace05);
    graph_lines[5].visible05 = true;
    graph_lines.push(trace06);
    graph_lines[6].visible06 = true;
    graph_lines.push(trace07);
    graph_lines[7].visible07 = true;
    graph_lines.push(trace08);
    graph_lines[8].visible08 = true;
    graph_lines.push(trace09);
    graph_lines[9].visible09 = true;
    graph_lines.push(trace10);
    graph_lines[10].visible10 = true;
    graph_lines.push(trace11);
    graph_lines[11].visible11 = true;
    graph_lines.push(trace12);
    graph_lines[12].visible12 = true;

    return graph_lines;
  }
});

function toggleOptions()
{
 switch(this.id)
  {
    case 'alder':
      var visible = graph_lines[0].visible00;
      graph_lines[0].visible00 = !graph_lines[0].visible00;
      Plotly.restyle("graph", 'visible', !visible, [0]);
      break;
    case 'birch':
      var visible = graph_lines[1].visible01;
      graph_lines[1].visible01 = !graph_lines[1].visible01;
      Plotly.restyle("graph", 'visible', !visible, [1]);
      break;
    case 'grass1':
      var visible = graph_lines[2].visible02;
      graph_lines[2].visible02 = !graph_lines[2].visible02;
      Plotly.restyle("graph", 'visible', !visible, [2]);
      break;
    case 'grass2':
      var visible = graph_lines[3].visible03;
      graph_lines[3].visible03 = !graph_lines[3].visible03;
      Plotly.restyle("graph", 'visible', !visible, [3]);
      break;
    case 'mold':
      var visible = graph_lines[4].visible04;
      graph_lines[4].visible04 = !graph_lines[4].visible04;
      Plotly.restyle("graph", 'visible', !visible, [4]);
      break;
    case 'othertree1':
      var visible = graph_lines[5].visible05;
      graph_lines[5].visible05 = !graph_lines[5].visible05;
      Plotly.restyle("graph", 'visible', !visible, [5]);
      break;
    case 'othertree2':
      var visible = graph_lines[6].visible06;
      graph_lines[6].visible06 = !graph_lines[6].visible06;
      Plotly.restyle("graph", 'visible', !visible, [6]);
      break;
    case 'other1':
      var visible = graph_lines[7].visible07;
      graph_lines[7].visible07 = !graph_lines[7].visible07;
      Plotly.restyle("graph", 'visible', !visible, [7]);
      break;
    case 'other2':
      var visible = graph_lines[8].visible08;
      graph_lines[8].visible08 = !graph_lines[8].visible08;
      Plotly.restyle("graph", 'visible', !visible, [8]);
      break;
    case 'poplaraspen':
      var visible = graph_lines[9].visible09;
      graph_lines[9].visible09 = !graph_lines[9].visible09;
      Plotly.restyle("graph", 'visible', !visible, [9]);
      break;
    case 'spruce':
      var visible = graph_lines[10].visible10;
      graph_lines[10].visible10 = !graph_lines[10].visible10;
      Plotly.restyle("graph", 'visible', !visible, [10]);
      break;
    case 'weed':
      var visible = graph_lines[11].visible11;
      graph_lines[11].visible11 = !graph_lines[11].visible11;
      Plotly.restyle("graph", 'visible', !visible, [11]);
      break;
    case 'willow':
      var visible = graph_lines[12].visible12;
      graph_lines[12].visible12 = !graph_lines[12].visible12;
      Plotly.restyle("graph", 'visible', !visible, [12]);
      break;
    default:
      console.log("Not a pollen source.");
  }
  //console.log("CHANGE");
}