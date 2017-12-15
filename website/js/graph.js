var theToggles = document.querySelectorAll('.toggles');

for(var i=0;i<theToggles.length;i++)
{
  theToggles[i].addEventListener('change',toggleOptions);
}
function toggleOptions()
{
  console.log("CHANGE");
}


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

    return [{
      mode: 'lines',
      name: 'Alder',
      line: {
        color: '#039a03',
        width: 1
      },
      x: x00,
      y: y00
    },{
      mode: 'lines',
      name: 'Birch',
      line: {
        color: '#226666',
        width: 1
      },
      x: x01,
      y: y01
    },{
      mode: 'lines',
      name: 'Grass 1',
      line: {
        color: '#0ba668',
        width: 1
      },
      x: x02,
      y: y02
    },{
      mode: 'lines',
      name: 'Grass 2',
      line: {
        color: '#0a0eb4',
        width: 1
      },
      x: x03,
      y: y03
    },{
      mode: 'lines',
      name: 'Mold',
      line: {
        color: '#9a0358',
        width: 1
      },
      x: x04,
      y: y04
    },{
      mode: 'lines',
      name: 'Other Tree 1',
      line: {
        color: '#76276c',
        width: 1
      },
      x: x05,
      y: y05
    },{
      mode: 'lines',
      name: 'Other Tree 2',
      line: {
        color: '#aa3939',
        width: 1
      },
      x: x06,
      y: y06
    },{
      mode: 'lines',
      name: 'Other 1',
      line: {
        color: '#4c2d73',
        width: 1
      },
      x: x07,
      y: y07
    },{
      mode: 'lines',
      name: 'Other 2',
      line: {
        color: '#2a4f6e',
        width: 1
      },
      x: x08,
      y: y08
    },{
      mode: 'lines',
      name: 'Poplar Aspen',
      line: {
        color: '#c65c00',
        width: 1
      },
      x: x09,
      y: y09
    },{
      mode: 'lines',
      name: 'Spruce',
      line: {
        color: '#aa6c39',
        width: 1
      },
      x: x10,
      y: y10
    },{
      mode: 'lines',
      name: 'Weed',
      line: {
        color: '#c69400',
        width: 1
      },
      x: x11,
      y: y11
    },{
      mode: 'lines',
      name: 'Willow',
      line: {
        color: '#727d15',
        width: 1
      },
      x: x12,
      y: y12
    }];
  }
});