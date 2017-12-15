package com.example.cs472.cs472template;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.Legend;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        // LINE CHART
        LineChart mChart = (LineChart) findViewById(R.id.chart);



        // !!!!!
        // DATA!!!!!
        // !!!!!

        int[] Xitems = {0 ,1 ,2 ,3 ,4 ,5 ,6 ,7,8 ,9 ,10, 11, 12,13,14, 15, 16, 17, 18, 19, 20, 21, 22, 23};
        int[] Yitems = {16,28,37,21,17,17,25,9,58,84,88,190,186,77,15,133,127,130,106,185,353,484,939,147};

        mChart.getXAxis().setAxisMaximum(30);
        mChart.getXAxis().setAxisMinimum(0);

        int[] Xitems2 = {1,2,3,4,5};
        int[] Yitems2 = {3,4,5,6,7};


        // To hold our new list of line data entries
        List<Entry> entries1 = new ArrayList<>();
        List<Entry> entries2 = new ArrayList<>();

        for (int i = 0; i < Xitems.length; i++){

            entries1.add(new Entry(Xitems[i], Yitems[i]));
//            entries2.add(new Entry(Xitems2[i], Yitems2[i]));

        }

        // Create linedataset
        LineDataSet dataSet = new LineDataSet(entries1,"Alder");
//        LineDataSet dataSet2 = new LineDataSet(entries2,"Willow");
        dataSet.setColor(Color.RED);
//        dataSet2.setColor(Color.BLUE);
//        dataSet.setLineWidth(3);
//        dataSet.setValueTextColor(0x0);

        // Create line data


        LineData lineData = new LineData(dataSet);

//        lineData.addDataSet(dataSet2);

        mChart.setData(lineData);
        mChart.invalidate(); // refresh




        mChart.setDrawGridBackground(true);



        Legend l = mChart.getLegend();
        l.setForm(Legend.LegendForm.LINE);

    }


    // func pollenOnClick
    // Pre - Existing View
    // Post - Displays new intent to view pollen_select class
    public void pollenOnClick(View v){

        Button button = (Button) v;
        startActivity(new Intent(getApplicationContext(), pollen_select.class));

    }
}
