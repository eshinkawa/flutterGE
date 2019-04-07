// package com.example.feedflutterge;

// import android.app.FragmentTransaction;
// import android.content.Intent;
// import android.content.pm.ActivityInfo;
// import android.os.Bundle;
// import android.support.v7.app.AppCompatActivity;
// import android.support.v7.widget.Toolbar;
// import android.view.OrientationEventListener;
// import android.view.View;
// import android.view.ViewGroup;

// import com.globo.video.player.Player;
// import com.globo.video.player.base.PlayerMimeType;

// import java.util.HashMap;

// import io.clappr.player.base.Callback;
// import io.clappr.player.base.ErrorInfo;
// import io.clappr.player.base.Event;
// import io.clappr.player.base.Options;



// public class PlayerActivity extends AppCompatActivity {

//     protected Player player;

//     protected ViewGroup playerContainer;
//     private View decorView;
//     private OrientationEventListener orientationListener;


//     @Override
//     protected void onCreate(Bundle savedInstanceState) {
//         super.onCreate(savedInstanceState);
//         setContentView(R.layout.activity_player2);
//         Toolbar toolbar = findViewById(R.id.toolbar);
//         setSupportActionBar(toolbar);


//         configurePlayerOptions();

//         FragmentTransaction fragmentTransaction = getFragmentManager().beginTransaction();
//         fragmentTransaction.add(R.id.player_container, player);
//         fragmentTransaction.commit();


//     }

//     private void configurePlayerOptions() {
//         Intent intent = getIntent();
//         Integer id = intent.getIntExtra("videoId", 0);
//         HashMap<String, Object> optionMap = new HashMap<>();
//         player = new Player();

//         Options options = new Options(id.toString(), PlayerMimeType.VIDEO_ID.getValue(), optionMap);
//         player.configure(options);
//     }


//     private void bindEvents() {
//         player.on(Event.REQUEST_FULLSCREEN.getValue(), new Callback() {
//             @Override
//             public void invoke(Bundle bundle) {
//                 enterFullscreen();
//             }
//         });

//         player.on(Event.EXIT_FULLSCREEN.getValue(), new Callback() {
//             @Override
//             public void invoke(Bundle bundle) {
//                 exitFullscreen();
//             }
//         });

//         player.on(Event.ERROR.getValue(), new Callback() {
//             @Override
//             public void invoke(Bundle bundle) {
//                 ErrorInfo info = bundle.getParcelable(Event.ERROR.getValue());

//                 String title = String.format("Código do erro: %s", Integer.toString(info.getCode()));
//                 String message = info.getMessage();

//             }
//         });
//     }

//     protected void enterFullscreen() {
//         setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE);
//     }

//     protected void exitFullscreen() {
//         setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT);
//     }

// }
