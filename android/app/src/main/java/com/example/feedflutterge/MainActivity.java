package com.example.feedflutterge;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import com.globo.video.player.Player;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.example.feedflutterge";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Player.initialize(this);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.d("tag", "MethodCall: " + methodCall.method);
        int videoId = methodCall.argument("videoId");
        Log.i("tag", "VideoId: " + videoId);
        showPlayer(videoId);

      }
    });

  }

  public void showPlayer(int videoId) {
    // INFO: function implementation
    Log.i("tag", "Chamando intent de video");
    Intent intent = new Intent(MainActivity.this, PlayerActivity.class);
    intent.putExtra("videoId", videoId);
    startActivity(intent);
  }
}
