var pollen_data;

var selector = document.getElementById("alder");

function update_pollen()
{
  plot_data(selector.value);
}
selector.addEventListener('change',update_pollen,false);

Plotly.d3.json(encodeURI("https://fbxpollenfallen.com/pollen/"), function(data)
{
  pollen_data = data;
  console.log(data);
  var rawDataURL = 'https://raw.githubusercontent.com/plotly/datasets/master/2016-weather-data-seattle.csv';/*'https://fbxpollenfallen.com/pollen/';*/
  var xField = 'Date';
  var yField = 'Mean_TemperatureC';

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