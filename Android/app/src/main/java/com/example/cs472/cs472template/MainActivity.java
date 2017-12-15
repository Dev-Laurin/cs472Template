package com.example.cs472.cs472template;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.Legend;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.formatter.IndexAxisValueFormatter;

import org.apache.commons.lang3.ArrayUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class MainActivity extends AppCompatActivity {


    LineChart mChart;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        // LINE CHART
        mChart = (LineChart) findViewById(R.id.chart);

    }


    // func pollenOnClick
    // Pre - Existing View
    // Post - Displays new intent to view pollen_select class
    public void pollenOnClick(View v){

        Button button = (Button) v;
        startActivity(new Intent(getApplicationContext(), pollen_select.class));

    }


    @Override
    protected void onResume() {

        super.onResume();

        // Get saved boolean values from the other pollen activity.
        SharedPreferences shared = getSharedPreferences("com.example.cs472.cs472template", MODE_PRIVATE);

        JSONArray json = null;

        // Holds all our data until plotted
        LineData lineData = new LineData();

        try {
            json = new JSONArray(shared.getString("Years", "").toString());
            System.out.println(shared.getString("Years", "").toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }

        // Sort years
        List<JSONObject> jsonlist = new ArrayList<>();
        for (int i = 0; i < json.length(); i++){
            try {
                jsonlist.add(json.getJSONObject(i));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        // Use collection sort to sort the year
        Collections.sort( jsonlist, new Comparator<JSONObject>() {
            //You can change "Name" with "ID" if you want to sort by ID
            private static final String KEY_NAME = "Year";

            @Override
            public int compare(JSONObject a, JSONObject b) {
                Integer valA = 0;
                Integer valB = 0;

                try {
                    valA = (Integer) a.get(KEY_NAME);
                    valB = (Integer) b.get(KEY_NAME);
                }
                catch (JSONException e) {
                    //do something
                }

                return valA.compareTo(valB);
                //if you want to change the sort order, simply use the following:
                //return -valA.compareTo(valB);
            }
        });

        List<String> dateArray = new ArrayList<>();

        if (shared.contains("Years") && json != null) {


            List<Integer> years = new ArrayList<>();

            List<List<Integer>> alder = new ArrayList<List<Integer>>();
            List<List<Integer>> willow = new ArrayList<List<Integer>>();
            List<List<Integer>> poplar_aspen = new ArrayList<List<Integer>>();
            List<List<Integer>> birch = new ArrayList<List<Integer>>();
            List<List<Integer>> spruce = new ArrayList<List<Integer>>();
            List<List<Integer>> other1_tree = new ArrayList<List<Integer>>();
            List<List<Integer>> other2_tree = new ArrayList<List<Integer>>();
            List<List<Integer>> grass = new ArrayList<List<Integer>>();
            List<List<Integer>> grass2 = new ArrayList<List<Integer>>();
            List<List<Integer>> weed = new ArrayList<List<Integer>>();
            List<List<Integer>> other1 = new ArrayList<List<Integer>>();
            List<List<Integer>> other2 = new ArrayList<List<Integer>>();
            List<List<Integer>> mold = new ArrayList<List<Integer>>();
            List<List<Integer>> day = new ArrayList<List<Integer>>();
            List<List<Integer>> month = new ArrayList<List<Integer>>();

            JSONObject obj = null;
            JSONArray data = null;

            // Iterates through each year.
            for (int i = 0; i < json.length(); i++){


                try {

                    obj = json.getJSONObject(i);
                    years.add(obj.getInt("Year"));
                    data = obj.getJSONArray("Data");

                    List<JSONObject> sortdata = new ArrayList<>();
                    for (int k = 0; k < data.length(); k++){
                        try {
                            sortdata.add(data.getJSONObject(k));
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }

                    // Use collection sort to sort the
                    Collections.sort( jsonlist, new Comparator<JSONObject>() {
                        //You can change "Name" with "ID" if you want to sort by ID
                        private static final String KEY_NAME = "Month";

                        @Override
                        public int compare(JSONObject a, JSONObject b) {
                            Integer valA = 0;
                            Integer valB = 0;

                            try {
                                valA = (Integer) a.get(KEY_NAME);
                                valB = (Integer) b.get(KEY_NAME);
                            }
                            catch (JSONException e) {
                                //do something
                            }

                            return valA.compareTo(valB);
                            //if you want to change the sort order, simply use the following:
                            //return -valA.compareTo(valB);
                        }
                    });

                    System.out.println("Hello world!");
                    System.out.println(sortdata);


                    List<Integer> alderHolder = new ArrayList<>();
                    List<Integer> willowHolder = new ArrayList<>();
                    List<Integer> poplar_aspenHolder = new ArrayList<>();
                    List<Integer> birchHolder = new ArrayList<>();
                    List<Integer> spruceHolder = new ArrayList<>();

                    List<Integer> other1_treeHolder = new ArrayList<>();
                    List<Integer> other2_treeHolder = new ArrayList<>();
                    List<Integer> grassHolder = new ArrayList<>();
                    List<Integer> grass2Holder = new ArrayList<>();
                    List<Integer> weedHolder = new ArrayList<>();

                    List<Integer> other1Holder = new ArrayList<>();
                    List<Integer> other2Holder = new ArrayList<>();
                    List<Integer> moldHolder = new ArrayList<>();
                    List<Integer> dayHolder = new ArrayList<>();
                    List<Integer> monthHolder = new ArrayList<>();


                    JSONObject obj2 = null;

                    for (int j = 0; j < data.length(); j++){

                        obj2 =  data.getJSONObject(j);

                        alderHolder.add(obj2.getInt("Alder"));
                        willowHolder.add(obj2.getInt("Willow"));
                        poplar_aspenHolder.add(obj2.getInt("Poplar_Aspen"));
                        birchHolder.add(obj2.getInt("Birch"));
                        spruceHolder.add(obj2.getInt("Spruce"));

                        other1_treeHolder.add(obj2.getInt("Other1_Tree"));
                        other2_treeHolder.add(obj2.getInt("Other2_Tree"));
                        grassHolder.add(obj2.getInt("Grass"));
                        grass2Holder.add(obj2.getInt("Grass2"));
                        weedHolder.add(obj2.getInt("Weed"));

                        other1Holder.add(obj2.getInt("Other1"));
                        other2Holder.add(obj2.getInt("Other2"));
                        moldHolder.add(obj2.getInt("Mold"));
                        dayHolder.add(obj2.getInt("Day"));
                        monthHolder.add(obj2.getInt("Month"));

                    }
                    // Add 2nd list to first list for 2 dimensions, thank you very much!
                    alder.add(alderHolder);
                    willow.add(willowHolder);
                    poplar_aspen.add(poplar_aspenHolder);
                    birch.add(birchHolder);
                    spruce.add(spruceHolder);

                    other1_tree.add(other1_treeHolder);
                    other2_tree.add(other2_treeHolder);
                    grass.add(grassHolder);
                    grass2.add(grass2Holder);
                    weed.add(weedHolder);

                    other1.add(other1Holder);
                    other2.add(other2Holder);
                    mold.add(moldHolder);
                    day.add(dayHolder);
                    month.add(monthHolder);

                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }

            System.out.println(day.get(0));
            System.out.println(month.get(0));
            System.out.println(alder.get(0));

            String date = new String();

            for (int i = 0; i < years.size(); i++){

                System.out.println(date);

                if (shared.contains("Alder") && shared.getBoolean("Alder", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < alder.get(i).size(); j++){

                        date = Integer.toString(month.get(i).get(j)) + "/"+Integer.toString(day.get(i).get(j));
                        dateArray.add(date);
                        entries.add(new Entry(j, alder.get(i).get(j)));

                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Alder");

                    dataSet.setColor(getResources().getColor(R.color.alder));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Willow") && shared.getBoolean("Willow", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < willow.get(i).size(); j++){

                        entries.add(new Entry(j, willow.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Willow");
                    dataSet.setColor(getResources().getColor(R.color.willow));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Poplar_Aspen") && shared.getBoolean("Poplar_Aspen", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < poplar_aspen.get(i).size(); j++){

                        entries.add(new Entry(j, poplar_aspen.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Poplar_Aspen");
                    dataSet.setColor(getResources().getColor(R.color.poplar_aspen));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Birch") && shared.getBoolean("Birch", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < birch.get(i).size(); j++){

                        entries.add(new Entry(j, birch.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Birch");
                    dataSet.setColor(getResources().getColor(R.color.birch));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Spruce") && shared.getBoolean("Spruce", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < spruce.get(i).size(); j++){

                        entries.add(new Entry(j, spruce.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Spruce");
                    dataSet.setColor(getResources().getColor(R.color.spruce));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Other1_Tree") && shared.getBoolean("Other1_Tree", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < other1_tree.get(i).size(); j++){

                        entries.add(new Entry(j, other1_tree.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Other1_Tree");
                    dataSet.setColor(getResources().getColor(R.color.other1_tree));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Other2_Tree") && shared.getBoolean("Other2_Tree", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < other2_tree.get(i).size(); j++){

                        entries.add(new Entry(j, other2_tree.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Other2_Tree");
                    dataSet.setColor(getResources().getColor(R.color.other2_tree));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Grass") && shared.getBoolean("Grass", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < grass.get(i).size(); j++){

                        entries.add(new Entry(j, grass.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Grass");
                    dataSet.setColor(getResources().getColor(R.color.grass));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Grass2") && shared.getBoolean("Grass2", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < grass2.get(i).size(); j++){

                        entries.add(new Entry(j, grass2.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Grass2");
                    dataSet.setColor(getResources().getColor(R.color.grass2));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Weed") && shared.getBoolean("Weed", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < weed.get(i).size(); j++){

                        entries.add(new Entry(j, weed.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Weed");
                    dataSet.setColor(getResources().getColor(R.color.weed));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Other1") && shared.getBoolean("Other1", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < other1.get(i).size(); j++){

                        entries.add(new Entry(j, other1.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Other1");
                    dataSet.setColor(getResources().getColor(R.color.other1));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Other2") && shared.getBoolean("Other2", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < other2.get(i).size(); j++){

                        entries.add(new Entry(j, other2.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Other2");
                    dataSet.setColor(getResources().getColor(R.color.other2));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }

                if (shared.contains("Mold") && shared.getBoolean("Mold", false)){

                    List<Entry> entries = new ArrayList<>();
                    for (int j = 0; j < mold.get(i).size(); j++){

                        entries.add(new Entry(j, mold.get(i).get(j)));


                    }
                    LineDataSet dataSet = new LineDataSet(entries,"Mold");
                    dataSet.setColor(getResources().getColor(R.color.mold));
                    dataSet.setDrawValues(false);
                    dataSet.setLineWidth(2f);
                    dataSet.setDrawCircles(false);
                    lineData.addDataSet(dataSet);

                }



            }
        }

        Collections.reverse(dateArray);

        mChart.getXAxis().setValueFormatter(new IndexAxisValueFormatter(dateArray));
        mChart.getXAxis().setGranularity(1);
        mChart.getXAxis().setPosition(XAxis.XAxisPosition.BOTTOM);
        mChart.getXAxis().setLabelCount(5);


        mChart.setData(lineData);
        mChart.invalidate(); // refresh
        mChart.setDrawGridBackground(true);
        Legend l = mChart.getLegend();
        l.setForm(Legend.LegendForm.LINE);


    }
}
