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
        // public variables
        public PlotModel LineModel { get; set; }
        public LineSeries Spruce { get; set; }
        public LineSeries Alder { get; set; }
        public LineSeries Grass { get; set; }
        public LineSeries Grass2 { get; set; }
        public LineSeries Poplar_Aspen { get; set; }
        public LineSeries Birch { get; set; }
        public LineSeries Weed { get; set; }
        public LineSeries Willow { get; set; }
        public LineSeries Other1 { get; set; }
        public LineSeries Other2 { get; set; }
        public LineSeries Other1_Tree { get; set; }
        public LineSeries Other2_Tree { get; set; }
        public int Year { get; set; }
        public List<PollenData> Items {get;set;}

        //SetPollenSeries 
        //clears the series
        //sets up the new series
        //forces a refresh
        public void SetPollenSeries ()
        {
            //The clear is necessary to prevent doubled legend tags.
            LineModel.Series.Clear();
            //Create all the series for lines
            Spruce = new LineSeries() { Title = "Spruce" };
            Alder = new LineSeries { Title = "Alder" };
            Grass = new LineSeries { Title = "Grass" };
            Grass2 = new LineSeries { Title = "Grass2" };
            Poplar_Aspen = new LineSeries { Title = "Poplar Aspen" };
            Birch = new LineSeries { Title = "Birch" };
            Weed = new LineSeries { Title = "Weed" };
            Willow = new LineSeries { Title = "Willow" };
            Other1 = new LineSeries { Title = "Other1" };
            Other2 = new LineSeries { Title = "Other2" };
            Other1_Tree = new LineSeries { Title = "Other1 Tree" };
            Other2_Tree = new LineSeries { Title = "Other2 Tree" };

            foreach (var i in Items)
            {
                if (i.Year == Year)
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
            LineModel.InvalidatePlot(true);
        }

        // Request Data from the website
        public async Task<List<PollenData>> GetPollenData ()
        {
            var client = new HttpClient();
            var uri = new Uri(string.Format("https://fbxpollenfallen.com/pollen/", string.Empty));
            var response = await client.GetAsync(uri);
            if (response.IsSuccessStatusCode)
            {
                var content = await response.Content.ReadAsStringAsync();
                Items = JsonConvert.DeserializeObject<List<PollenData>>(content);
                SetPollenSeries(); 
            }
            
            return Items;
        }
        

        public LineChart()
        {
            var pollenData = GetPollenData();

            //MessagingCenter is for passing messages back.  
            //The year to show - note, trying to display more than 1 year unstable
            MessagingCenter.Subscribe<Settings, int>(this, "Year", (sender, n) =>
            {
                Year = n;
                SetPollenSeries();
            });


            //In this case, to show/hide plots
            //A select case would be better, but out of time.
            MessagingCenter.Subscribe<Settings>(this, "Spruce", (sender) =>
            {
                Spruce.IsVisible = !Spruce.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Alder", (sender) =>
            {
                Alder.IsVisible = !Alder.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Grass", (sender) =>
            {
                Grass.IsVisible = !Grass.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Grass2", (sender) =>
            {
                Grass2.IsVisible = !Grass2.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Poplar_Aspen", (sender) =>
            {
                Poplar_Aspen.IsVisible = !Poplar_Aspen.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Birch", (sender) =>
            {
                Birch.IsVisible = !Birch.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Weed", (sender) =>
            {
                Weed.IsVisible = !Weed.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Willow", (sender) =>
            {
                Willow.IsVisible = !Willow.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Other1", (sender) =>
            {
                Other1.IsVisible = !Other1.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Other2", (sender) =>
            {
                Other2.IsVisible = !Other2.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Other1_Tree", (sender) =>
            {
                Other1_Tree.IsVisible = !Other1_Tree.IsVisible;
                LineModel.InvalidatePlot(true);
            });
            MessagingCenter.Subscribe<Settings>(this, "Other2_Tree", (sender) =>
            {
                Other2_Tree.IsVisible = !Other2_Tree.IsVisible;
                LineModel.InvalidatePlot(true);
            });

            LineModel = CreateLineChart();
        }

        public PlotModel CreateLineChart()
        {
            // Get the information from the server
            var pollenData = GetPollenData();
            // Initialize the new plot model.
            var plotModel1 = new PlotModel { Title = "Total Pollen" };
            // Set the year.
            Year = 2016;
            
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
            var startDate = DateTime.Parse("01/01/2016");
            var endDate = DateTime.Parse("12/31/2016");

            var minValue = DateTimeAxis.ToDouble(startDate);
            var maxValue = DateTimeAxis.ToDouble(endDate);

            plotModel1.Axes.Add(new DateTimeAxis
            {
                Position = AxisPosition.Bottom,
                //Disabled restricting the width, as it looks better with the automatic settings.
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
    }
}
