package com.example.cs472.cs472template;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Switch;

public class pollen_select extends AppCompatActivity {

    Switch s;

    // Booleans to hold state values
    public boolean alder,
                willow,
                poplar_aspen,
                birch,
                spruce,

                other1_tree,
                other2_tree,
                grass,
                grass2,
                weed,

                other1,
                other2,
                mold;


    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pollen_select);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);


        // Backbutton.

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        SharedPreferences sharedPrefs = getSharedPreferences("com.example.cs472.cs472template", MODE_PRIVATE);


        // Create a local storage and save default values.
        // When onCreate() is called, the booleans will start false.
        // Separated by max 5 for easy reading.

        s = findViewById(R.id.switch_alder);
        s.setChecked((sharedPrefs.getBoolean("Alder", false)));
        s = findViewById(R.id.switch_willow);
        s.setChecked((sharedPrefs.getBoolean("Willow", false)));
        s = findViewById(R.id.switch_poplar_aspen);
        s.setChecked((sharedPrefs.getBoolean("Poplar Aspen", false)));
        s = findViewById(R.id.switch_birch);
        s.setChecked((sharedPrefs.getBoolean("Birch", false)));
        s = findViewById(R.id.switch_spruce);
        s.setChecked((sharedPrefs.getBoolean("Spruce", false)));

        s = findViewById(R.id.switch_other1_tree);
        s.setChecked((sharedPrefs.getBoolean("Other1 Tree", false)));
        s = findViewById(R.id.switch_other2_tree);
        s.setChecked((sharedPrefs.getBoolean("Other2 Tree", false)));
        s = findViewById(R.id.switch_grass);
        s.setChecked((sharedPrefs.getBoolean("Grass", false)));
        s = findViewById(R.id.switch_grass2);
        s.setChecked((sharedPrefs.getBoolean("Grass2", false)));
        s = findViewById(R.id.switch_weed);
        s.setChecked((sharedPrefs.getBoolean("Weed", false)));

        s = findViewById(R.id.switch_other1);
        s.setChecked((sharedPrefs.getBoolean("Other1", false)));
        s = findViewById(R.id.switch_other2);
        s.setChecked((sharedPrefs.getBoolean("Other2", false)));
        s = findViewById(R.id.switch_mold);
        s.setChecked((sharedPrefs.getBoolean("Mold", false)));


    }


//
    @Override
    public void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);

        // Retrieving stored key:value pairs.
        SharedPreferences sharedPref = pollen_select.this.getPreferences(Context.MODE_PRIVATE);
//        long highScore = sharedPref.getInt(getString(R.string.saved_high_score), defaultValue);

        s = findViewById(R.id.switch_alder);
        s.setChecked(sharedPref.getBoolean("Alder", false));
        s = findViewById(R.id.switch_willow);
        s.setChecked(sharedPref.getBoolean("Willow", false));
        s = findViewById(R.id.switch_poplar_aspen);
        s.setChecked(sharedPref.getBoolean("Poplar Aspen", false));
        s = findViewById(R.id.switch_birch);
        s.setChecked(sharedPref.getBoolean("Birch", false));
        s = findViewById(R.id.switch_spruce);
        s.setChecked(sharedPref.getBoolean("Spruce", false));

        s = findViewById(R.id.switch_other1_tree);
        s.setChecked(sharedPref.getBoolean("Other1 Tree", false));
        s = findViewById(R.id.switch_other2_tree);
        s.setChecked(sharedPref.getBoolean("Other2 Tree", false));
        s = findViewById(R.id.switch_grass);
        s.setChecked(sharedPref.getBoolean("Grass", false));
        s = findViewById(R.id.switch_grass2);
        s.setChecked(sharedPref.getBoolean("Grass2", false));
        s = findViewById(R.id.switch_weed);
        s.setChecked(sharedPref.getBoolean("Weed", false));

        s = findViewById(R.id.switch_other1);
        s.setChecked(sharedPref.getBoolean("Other1", false));
        s = findViewById(R.id.switch_other2);
        s.setChecked(sharedPref.getBoolean("Other2", false));
        s = findViewById(R.id.switch_mold);
        s.setChecked(sharedPref.getBoolean("Mold", false));


    }

    public void saveClick(View v) {

        SharedPreferences.Editor editor =
                getSharedPreferences(
                "com.example.cs472.cs472template",
                MODE_PRIVATE
                ).edit();


        s = findViewById(R.id.switch_alder);
        alder = s.isChecked();
        editor.putBoolean("Alder", alder);

        s = findViewById(R.id.switch_willow);
        willow = s.isChecked();
        editor.putBoolean("Willow", willow);

        s = findViewById(R.id.switch_poplar_aspen);
        poplar_aspen = s.isChecked();
        editor.putBoolean("Poplar Aspen", poplar_aspen);

        s = findViewById(R.id.switch_birch);
        birch = s.isChecked();
        editor.putBoolean("Birch", birch);

        s = findViewById(R.id.switch_spruce);
        spruce = s.isChecked();
        editor.putBoolean("Spruce", spruce);


        s = findViewById(R.id.switch_other1_tree);
        other1_tree = s.isChecked();
        editor.putBoolean("Other1 Tree", other1_tree);

        s = findViewById(R.id.switch_other2_tree);
        other2_tree = s.isChecked();
        editor.putBoolean("Other1 Tree", other2_tree);

        s = findViewById(R.id.switch_grass);
        grass = s.isChecked();
        editor.putBoolean("Grass", grass);

        s = findViewById(R.id.switch_grass2);
        grass2 = s.isChecked();
        editor.putBoolean("Grass2", grass2);

        s = findViewById(R.id.switch_weed);
        weed = s.isChecked();
        editor.putBoolean("Weed", weed);



        s = findViewById(R.id.switch_other1);
        other1 = s.isChecked();
        editor.putBoolean("Other1", other1);

        s = findViewById(R.id.switch_other2);
        other2 = s.isChecked();
        editor.putBoolean("Other2", other2);

        s = findViewById(R.id.switch_mold);
        mold = s.isChecked();
        editor.putBoolean("Mold", mold);



        // Commit changes to local storage and finish to parent activity.
        editor.commit();
        finish();
    }


}
