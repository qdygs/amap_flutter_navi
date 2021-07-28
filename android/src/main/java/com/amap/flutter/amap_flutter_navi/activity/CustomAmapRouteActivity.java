package com.amap.flutter.amap_flutter_navi.activity;


import android.os.Bundle;
import android.view.WindowManager;

import com.amap.api.navi.AmapRouteActivity;

public class CustomAmapRouteActivity extends AmapRouteActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN,
//                WindowManager.LayoutParams.FLAG_FULLSCREEN);
    }

}