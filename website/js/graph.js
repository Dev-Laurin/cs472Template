var theToggles = document.querySelectorAll('.toggles');
  //console.log(theToggles);
  for(var i=0;i<theToggles.length;i++)
  {
    theToggles[i].addEventListener('change',toggleOptions);
    //console.log(theToggles[i].id);
  }
  function toggleOptions()
  {
    console.log("CHANGE");
  }


Plotly.d3.json("pollen", function(data)
{
  var rawDataURL = 'pollen';//'https://raw.githubusercontent.com/plotly/datasets/master/2016-weather-data-seattle.csv';/*'https://fbxpollenfallen.com/pollen/';*/
  var xField = 'Year';//'Date';
  var yField = 'Data';//'Mean_TemperatureC';

  var pdata = data;
  //console.log(data);

  var x = [];
  var y = [];

  for (let record=0;record<pdata.length;record++)
  {
    for (let day=0;day<pdata[record]['Data'].length;day++)
    {
      //console.log(data[record]['Year']);
      for(let j=0;j<theToggles.length;j++)
      {
        switch(theToggles[j].id)
        {
          case 'alder':
            x.push(pdata[record]['Data'][day]['Alder']);
            y.push(pdata[record]['Year']);
            /*line: {
              color: '#039a03',
              width: 2
            };*/
            break;
          case 'birch':
            break;
          case 'grass1':
            break;
          case 'grass2':
            break;
          case 'mold':
            break;
          case 'othertree1':
            break;
          case 'othertree2':
            break;
          case 'other1':
            break;
          case 'other2':
            break;
          case 'poplaraspen':
            break;
          case 'spruce':
            break;
          case 'weed':
            break;
          case 'willow':
            break;
          default:
            console.log("Not a pollen source.");
        }
      }
    }
  }

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
      xaxis: {
        rangeselector: selectorOptions,
        rangeslider: {}
      },
      yaxis: {
        fixedrange: true
      }
    };

    Plotly.plot('graph', data, layout);
  });

  function prepData(rawData) {
    var x = [];
    var y = [];

    rawData.forEach(function(datum, i) {

      x.push(new Date(datum[xField]));
      y.push(datum[yField]);
    });

    return [{
      mode: 'lines',
      x: x,
      y: y
    }];
  }
});
