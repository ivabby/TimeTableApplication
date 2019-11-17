package com.example.audiodemo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.SeekBar;

import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends AppCompatActivity {

    MediaPlayer mediaPlayer;
    AudioManager audioManager;

    public void onCLick(View view){

        String tag = view.getTag().toString();
        System.out.println("Tag is:" +tag);

        if(tag.equals("play")){
            mediaPlayer.start();
        }
        else if(tag.equals("pause")){
            mediaPlayer.pause();
        }
        else if(tag.equals("stop")){
            mediaPlayer.stop();
            mediaPlayer = MediaPlayer.create(this , R.raw.media);
        }

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        //  Creating media player
        mediaPlayer = MediaPlayer.create(this , R.raw.media);

        //  Getting system media volume
        audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);

        //  Max media volume
        int maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);

        //  Get current volume
        int curVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);


        //  Seekbar for volume control
        SeekBar volumeSeekBar = (SeekBar) findViewById(R.id.volumeSeekBar);

        //  Max volume for the volume seek bar
        volumeSeekBar.setMax(maxVolume);

        //  Current volume for the seek bar
        volumeSeekBar.setProgress(curVolume);

        volumeSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                Log.d("SeekBar Value" , "Progress: "+progress);

                //  Update the stream volume
                audioManager.setStreamVolume(AudioManager.STREAM_MUSIC , progress , 0);

            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });


        //  SeekBar for song progress
        final SeekBar songProgress = (SeekBar) findViewById(R.id.trackSeekBar);

        //  Setting the max duration of song to song progress seek bar
        songProgress.setMax(mediaPlayer.getDuration());

//        new Timer().scheduleAtFixedRate(new TimerTask() {
//            @Override
//            public void run() {
//                songProgress.setProgress(mediaPlayer.getCurrentPosition());
//            }
//        } , 0 , 100);

        songProgress.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {

                mediaPlayer.seekTo(progress);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                while(true){
                    songProgress.setProgress(mediaPlayer.getCurrentPosition());
                    try{
                        Thread.sleep(1000);
                    } catch (Exception e){
                        e.printStackTrace();
                    }
                }
            }
        };

        Thread thread = new Thread(runnable);
        thread.start();
    }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               