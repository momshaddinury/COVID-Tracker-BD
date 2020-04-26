package com.tne.selfreportingapp;

import android.content.Intent;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.tne.selfreportingapp/MAP_CHANNEL";
    private static final String CHANNEL_FIRST = "com.tne.selfreportingapp/FIRST_RUN_CHANNEL";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("map")) {
                                startActivity(new Intent(this, MapActivity.class));
                                result.success("starting");
                            } else result.notImplemented();
                        }
                );

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_FIRST)
                .setMethodCallHandler(
                        (call, result) -> {
                            SharedPreferences savedData = getSharedPreferences("SAVED_DATA", MODE_PRIVATE);
                            switch (call.method) {
                                case "getFirstRun":
                                    result.success(savedData.getBoolean("isFirst", true));
                                    break;
                                case "firstRunCompleted":
                                    result.success(savedData.edit().putBoolean("isFirst", false).commit());
                                    break;
                                case "firstRunReset":
                                    result.success(savedData.edit().putBoolean("isFirst", true).commit());
                                    break;
                                default:
                                    result.notImplemented();
                                    break;
                            }
                        }
                );
    }
}
