using System;
using OxyPlot;
using OxyPlot.Axes;
using OxyPlot.Series;
using System.Collections.Generic;

namespace pollencount
{
    public class LineChart
    {
        public PlotModel LineModel { get; set; }

        public LineChart()
        {
            LineModel = CreateLineChart();
        }

        public PlotModel CreateLineChart()
        {
            var day1 = DateTimeAxis.ToDouble(DateTime.Parse("05/20/2016"));
            var day2 = DateTimeAxis.ToDouble(DateTime.Parse("05/23/2016"));
            var day3 = DateTimeAxis.ToDouble(DateTime.Parse("05/24/2016"));
            var day4 = DateTimeAxis.ToDouble(DateTime.Parse("05/25/2016"));
            var day5 = DateTimeAxis.ToDouble(DateTime.Parse("05/26/2016"));
            var day6 = DateTimeAxis.ToDouble(DateTime.Parse("05/27/2016"));
            var day7 = DateTimeAxis.ToDouble(DateTime.Parse("05/31/2016"));

            var plotModel1 = new PlotModel { Title = "Total Pollen" };
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

            var startDate = DateTime.Parse("05/20/2016");
            var endDate = DateTime.Parse("05/31/2016");

            var minValue = DateTimeAxis.ToDouble(startDate);
            var maxValue = DateTimeAxis.ToDouble(endDate);

            plotModel1.Axes.Add(new DateTimeAxis
            {
                Position = AxisPosition.Bottom,
                Minimum = minValue,
                Maximum = maxValue,
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
