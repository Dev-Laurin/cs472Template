using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pollencount
{
    public class PollenData
    {
        public int Year;
        public PollenRecord[] Data;

        public PollenData()
        {
            Year = 2016;
        }
    }
    public class PollenRecord
    {
        public int Mold;
        public int Spruce;
        public int Alder;
        public int Day;
        public int Other2;
        public int Grass;
        public int Poplar_Aspen;
        public int Birch;
        public int Weed;
        public int Willow;
        public int Grass2;
        public int Other1_Tree;
        public int Month;
        public int Other2_Tree;
        public int Other1;
    }
}
