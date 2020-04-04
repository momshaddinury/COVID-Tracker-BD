package com.tne.selfreportingapp;

import com.mapbox.mapboxsdk.geometry.LatLng;

public class LatLngQR {
    public LatLng center;
    public Integer quarantine;
    public Integer release;
    public String name;

    public LatLngQR(LatLng center, Integer quarantine,Integer release, String name) {
        this.center = center;
        this.quarantine = quarantine;
        this.release = release;
        this.name = name;
    }
}
