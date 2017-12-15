using System;
using OxyPlot;
using OxyPlot.Axes;
using OxyPlot.Series;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Net.Http;
using Newtonsoft.Json;
using Xamarin.Forms;

namespace pollencount
{
    public class LineChart
    {
        // Request Data from the website
        public async Task<List<PollenData>> GetPollenData ()
        {
            var client = new HttpClient();
            var uri = new Uri(string.Format("https://fbxpollenfallen.com/pollen/", string.Empty));
            var response = await client.GetAsync(uri);
            var Items = new List<PollenData> ();
            if (response.IsSuccessStatusCode)
            {
                var content = await response.Content.ReadAsStringAsync();
                Items = JsonConvert.DeserializeObject<List<PollenData>>(content);
                //The clear is necessary to prevent doubled legend tags.
                LineModel.Series.Clear();
                //Create all the series for lines
                var Spruce = new LineSeries() { Title = "Spruce" };
                var Alder = new LineSeries { Title = "Alder" };
                var Grass = new LineSeries { Title = "Grass" };
                var Grass2 = new LineSeries { Title = "Grass2" };
                var Poplar_Aspen = new LineSeries { Title = "Poplar Aspen" };
                var Birch = new LineSeries { Title = "Birch" };
                var Weed = new LineSeries { Title = "Weed" };
                var Willow = new LineSeries { Title = "Willow" };
                var Other1 = new LineSeries { Title = "Other1" };
                var Other2 = new LineSeries { Title = "Other2" };
                var Other1_Tree = new LineSeries { Title = "Other1 Tree" };
                var Other2_Tree = new LineSeries { Title = "Other2 Tree" };

                foreach (var i in Items)
                {
                    if (i.Year > 2014)
                    { 
                        foreach (var j in i.Data)
                        {
                            DateTime dt = new DateTime(i.Year, j.Month, j.Day);
                            var dtN = DateTimeAxis.ToDouble(dt);
                            Spruce.Points.Add(new DataPoint(dtN, j.Spruce));
                            Alder.Points.Add(new DataPoint(dtN, j.Alder));
                            Grass.Points.Add(new DataPoint(dtN, j.Grass));
                            Grass2.Points.Add(new DataPoint(dtN, j.Grass2));
                            Poplar_Aspen.Points.Add(new DataPoint(dtN, j.Poplar_Aspen));
                            Birch.Points.Add(new DataPoint(dtN, j.Birch));
                            Weed.Points.Add(new DataPoint(dtN, j.Weed));
                            Willow.Points.Add(new DataPoint(dtN, j.Willow));
                            Other1.Points.Add(new DataPoint(dtN, j.Other1));
                            Other2.Points.Add(new DataPoint(dtN, j.Other2));
                            Other1_Tree.Points.Add(new DataPoint(dtN, j.Other1_Tree));
                            Other2_Tree.Points.Add(new DataPoint(dtN, j.Other2_Tree));

                        }
                    }
                }
                LineModel.Series.Add(Spruce);
                LineModel.Series.Add(Alder);
                LineModel.Series.Add(Grass);
                LineModel.Series.Add(Grass2);
                LineModel.Series.Add(Poplar_Aspen);
                LineModel.Series.Add(Birch);
                LineModel.Series.Add(Weed);
                LineModel.Series.Add(Willow);
                LineModel.Series.Add(Other1);
                LineModel.Series.Add(Other2);
                LineModel.Series.Add(Other1_Tree);
                LineModel.Series.Add(Other2_Tree);

                //Hide the "extra" series.
                Grass2.IsVisible = false;
                Other1.IsVisible = false;
                Other2.IsVisible = false;
                Other1_Tree.IsVisible = false;
                Other2_Tree.IsVisible = false;

                //You invaldiate the plot to force a redraw.  Since we got the information for the plot late
                //Because we had to request it via https, we have to redraw.
                LineModel.PlotView.InvalidatePlot(true);
                LineModel.IsLegendVisible = true;
                LineModel.InvalidatePlot(true);
                
            }
            
            return Items;
        }
        public PlotModel LineModel { get; set; }

        public LineChart()
        {
            var pollenData = GetPollenData();
            
            LineModel = CreateLineChart();
        }
        public PlotModel CreateLineChart2(List<PollenData> pollenData)
        {
            var plotModel2 = new PlotModel { Title = "Total Pollen" };

            return plotModel2;
        }
        public PlotModel CreateLineChart()
        {
            var pollenData = GetPollenData();
            var plotModel1 = new PlotModel { Title = "Total Pollen" };
            
            // Test data.
            /*
            var day1 = DateTimeAxis.ToDouble(DateTime.Parse("05/20/2016"));
            var day2 = DateTimeAxis.ToDouble(DateTime.Parse("05/23/2016"));
            var day3 = DateTimeAxis.ToDouble(DateTime.Parse("05/24/2016"));
            var day4 = DateTimeAxis.ToDouble(DateTime.Parse("05/25/2016"));
            var day5 = DateTimeAxis.ToDouble(DateTime.Parse("05/26/2016"));
            var day6 = DateTimeAxis.ToDouble(DateTime.Parse("05/27/2016"));
            var day7 = DateTimeAxis.ToDouble(DateTime.Parse("05/31/2016"));
            
            var Series1 = new LineSeries();
            Series1.Points.Add(new DataPoint(day1, 371));
            Series1.Points.Add(new DataPoint(day2, 785));
            Series1.Points.Add(new DataPoint(day3, 67));
            Series1.Points.Add(new DataPoint(day4, 234));
            Series1.Points.Add(new DataPoint(day5, 122));
            Series1.Points.Add(new DataPoint(day6, 32));
            Series1.Points.Add(new DataPoint(day7, 192));
            plotModel1.Series.Add(Series1);

            var Series2 = new LineSeries();
            Series2.Points.Add(new DataPoint(day1, 61));
            Series2.Points.Add(new DataPoint(day2, 114));
            Series2.Points.Add(new DataPoint(day3, 4));
            Series2.Points.Add(new DataPoint(day4, 27));
            Series2.Points.Add(new DataPoint(day5, 14));
            Series2.Points.Add(new DataPoint(day6, 4));
            Series2.Points.Add(new DataPoint(day7, 29));
            plotModel1.Series.Add(Series2);
            */
            var startDate = DateTime.Parse("05/20/2016");
            var endDate = DateTime.Parse("05/31/2016");

            var minValue = DateTimeAxis.ToDouble(startDate);
            var maxValue = DateTimeAxis.ToDouble(endDate);

            plotModel1.Axes.Add(new DateTimeAxis
            {
                Position = AxisPosition.Bottom,
                //Minimum = minValue,
                //Maximum = maxValue,
                StringFormat = "M/d"
            });

            return plotModel1;
        }

        private AxisPosition CategoryAxisPosition()
        {
            if (typeof(BarSeries) == typeof(ColumnSeries))
            {
                return AxisPosition.Bottom;
            }

            return AxisPosition.Left;
        }

        private AxisPosition ValueAxisPosition()
        {
            if (typeof(BarSeries) == typeof(ColumnSeries))
            {
                return AxisPosition.Left;
            }

            return AxisPosition.Bottom;
        }

        public void TogSpruce()
        {

        }

    }
}
