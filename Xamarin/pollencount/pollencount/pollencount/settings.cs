using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Xamarin.Forms;

namespace pollencount
{
    public class Settings : ContentPage
    {
        Label label;

        public Settings()
        {
            Label header = new Label
            {
                Text = "Visibility",
                FontSize = Device.GetNamedSize(NamedSize.Large, typeof(Label)),
                HorizontalOptions = LayoutOptions.Center
            };
            EntryCell Year;
            SwitchCell Spruce;
            SwitchCell Alder;
            SwitchCell Grass;
            SwitchCell Grass2;
            SwitchCell Poplar_Aspen;
            SwitchCell Birch;
            SwitchCell Weed;
            SwitchCell Willow;
            SwitchCell Other1;
            SwitchCell Other2;
            SwitchCell Other1_Tree;
            SwitchCell Other2_Tree;

            TableView tableView = new TableView
            {
                Intent = TableIntent.Form,
                Root = new TableRoot
                {
                    new TableSection
                    {
                        (Year = new EntryCell
                        {
                            Label = "Year:",
                            Text = "2016"
                        }),
                        (Spruce = new SwitchCell
                        {
                            Text = "Spruce",
                            On = true
                        }),
                        (Alder = new SwitchCell
                        {
                            Text = "Alder",
                            On = true
                        }),
                        (Grass = new SwitchCell
                        {
                            Text = "Grass",
                            On = true
                        }),
                        (Grass2 = new SwitchCell
                        {
                            Text = "Grass2",
                            On = false
                        }),
                        (Poplar_Aspen = new SwitchCell
                        {
                            Text = "Poplar Aspen",
                            On = true
                        }),
                        (Birch = new SwitchCell
                        {
                            Text = "Birch",
                            On = true
                        }),
                        (Weed = new SwitchCell
                        {
                            Text = "Weed",
                            On = true
                        }),
                        (Willow = new SwitchCell
                        {
                            Text = "Willow",
                            On = true
                        }),
                        (Other1 = new SwitchCell
                        {
                            Text = "Other1",
                            On = false
                        }),
                        (Other2 = new SwitchCell
                        {
                            Text = "Other2",
                            On = false
                        }),
                        (Other1_Tree = new SwitchCell
                        {
                            Text = "Other1_Tree",
                            On = false
                        }),
                        (Other2_Tree = new SwitchCell
                        {
                            Text = "Other2_Tree",
                            On = false
                        })
                    }
                }
            };
            Year.Completed += (s, e) =>
            {
                var newVal = Year.Text;
                int n;
                if (int.TryParse(newVal, out n))
                {
                    if (n > 2000 && n < 2017)
                    {
                        MessagingCenter.Send<Settings, int>(this, "Year", n);
                    }
                    else
                    {
                        Year.Text = "2016";
                    }
                }
                else
                {
                    Year.Text = "2016";
                }
            };
            Spruce.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Spruce");
            };
            Alder.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Alder");
            };
            Grass.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Grass");
            };
            Grass2.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Grass2");
            };
            Poplar_Aspen.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Poplar_Aspen");
            };
            Birch.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Birch");
            };
            Weed.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Weed");
            };
            Willow.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Willow");
            };
            Other1.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Other1");
            };
            Other2.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Other2");
            };
            Other1_Tree.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Other1_Tree");
            };
            Other2_Tree.OnChanged += (s, e) =>
            {
                MessagingCenter.Send<Settings>(this, "Other2_Tree");
            };

            // Accomodate iPhone status bar.
            this.Padding = new Thickness(10, Device.OnPlatform(20, 0, 0), 10, 5);

            // Build the page.
            this.Content = new StackLayout
            {
                Children =
                {
                    header,
                    tableView
                }
            };
        }

    }
}