package com.tne.selfreportingapp;

import com.mapbox.mapboxsdk.geometry.LatLng;

public class LatLngQR {
    public LatLng center;
    public Integer quarantine;
    public Integer release;

    public LatLngQR(LatLng center, Integer quarantine,Integer release) {
        this.center = center;
        this.quarantine = quarantine;
        this.release = release;
    }
}
