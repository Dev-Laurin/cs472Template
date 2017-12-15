using Xamarin.Forms;
using Xamarin.Forms.Xaml;
[assembly:XamlCompilation(XamlCompilationOptions.Compile)]

namespace pollencount
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
            var LineData = new LineChart();
            var LDat = new TabbedPage();
            LDat.Children.Add(new LineCh { Title = "Fairbanks Pollen", BindingContext = LineData });
            LDat.Children.Add(new Settings { Title = "Settings"});
            MainPage = LDat;
        }

        protected override void OnStart()
        {
            // Handle when your app starts
        }

        protected override void OnSleep()
        {
            // Handle when your app sleeps
        }

        protected override void OnResume()
        {
            // Handle when your app resumes
        }

        public void SpruceTog()
        {

        }
    }
}
