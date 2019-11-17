package com.example.timetableapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    long tableOf = 1;

    TextView textView;
    ListView listView;
    ArrayList<String> tables;
    ArrayAdapter<String> arrayAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tables = new ArrayList<>();

        listView = (ListView) findViewById(R.id.listView);

        textView = (TextView) findViewById(R.id.textView);

        Button plus = (Button) findViewById(R.id.button1);
        Button minus = (Button) findViewById(R.id.button2);

        updateListView();

        plus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tableOf+=1;
                updateListView();
            }
        });

        minus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(tableOf == 1)
                {
                    Toast.makeText(getApplicationContext() , "Error" , Toast.LENGTH_SHORT).show();
                } else{
                    tableOf-=1;
                    updateListView();
                }
            }
        });
    }

    public void updateListView()
    {
        textView.setText(Long.toString(tableOf));

        Log.d("Size " , "Table size: "+tables.size());
        if(tables.size()>0)
            tables.clear();
        for(int i=1;i<=10;i++)
            tables.add(Long.toString(i*tableOf));

        arrayAdapter = new ArrayAdapter<>(this , android.R.layout.simple_list_item_1 , tables);

        listView.setAdapter(arrayAdapter);
    }
}
