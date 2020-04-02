package com.tne.selfreportingapp;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.DataBindingUtil;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.mapbox.android.core.location.LocationEngineCallback;
import com.mapbox.android.core.location.LocationEngineProvider;
import com.mapbox.android.core.location.LocationEngineRequest;
import com.mapbox.android.core.location.LocationEngineResult;
import com.mapbox.geojson.Feature;
import com.mapbox.mapboxsdk.Mapbox;
import com.mapbox.mapboxsdk.camera.CameraUpdateFactory;
import com.mapbox.mapboxsdk.geometry.LatLng;
import com.mapbox.mapboxsdk.location.LocationComponent;
import com.mapbox.mapboxsdk.location.LocationComponentActivationOptions;
import com.mapbox.mapboxsdk.location.modes.CameraMode;
import com.mapbox.mapboxsdk.location.modes.RenderMode;
import com.mapbox.mapboxsdk.maps.MapView;
import com.mapbox.mapboxsdk.maps.MapboxMap;
import com.mapbox.mapboxsdk.maps.OnMapReadyCallback;
import com.mapbox.mapboxsdk.maps.Style;
import com.mapbox.mapboxsdk.maps.UiSettings;
import com.mapbox.mapboxsdk.plugins.annotation.Circle;
import com.mapbox.mapboxsdk.plugins.annotation.CircleManager;
import com.mapbox.mapboxsdk.plugins.annotation.CircleOptions;
import com.mapbox.mapboxsdk.plugins.annotation.OnCircleClickListener;
import com.mapbox.mapboxsdk.plugins.annotation.Symbol;
import com.mapbox.mapboxsdk.plugins.annotation.SymbolManager;
import com.tne.selfreportingapp.databinding.ActivityMapBinding;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class MapActivity extends AppCompatActivity implements OnMapReadyCallback {

    ActivityMapBinding activityMapBinding;
    String TAG = "MapActivity";

    Geocoder geocoder;
    private MapView mapView;
    MapboxMap map;
    private String source = null, destination = null;

    LocationComponent locationComponent;
    LocationComponentActivationOptions locationComponentActivationOptions;
    private LocationManager locationManager;
    private LocationListener locationListener;
    SymbolManager symbolManager;
    private ArrayList<Circle> circleArrayListRelease = new ArrayList<>();
    private ArrayList<Circle> circleArrayListQuarantine = new ArrayList<>();

    private Location currentLocation;
    private LatLng testLocHome = new LatLng(23.770022, 90.362926);
    private LatLng testLocSS = new LatLng(23.774718, 90.365370);
    private Symbol testSymHome;
    private Symbol testSymSS;
    private CircleManager circleManager;

    private String mapUrl = "https://perceptronlab.com/covidtrackerbd/mapdata";

    private RequestQueue requestQueue;

    private ArrayList<LatLngQR> centers = new ArrayList<>();

    @SuppressLint("LogNotTimber")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Mapbox.getInstance(this, getString(R.string.access_token));
        activityMapBinding = DataBindingUtil.setContentView(this, R.layout.activity_map);

        requestQueue = Volley.newRequestQueue(this);

        requestQueue.add(new StringRequest(Request.Method.GET, mapUrl, response -> {
            Log.i(TAG, "onResponse: " + response);
            try {
                JSONObject jsonObject = new JSONObject(response);
                JSONArray latLngArray = jsonObject.getJSONArray("data");
                for (int i = 0; i < latLngArray.length(); i++) {
                    centers.add(new LatLngQR(
                            new LatLng(latLngArray.getJSONObject(i).getJSONArray("lat_lng").getDouble(0), latLngArray.getJSONObject(i).getJSONArray("lat_lng").getDouble(1)),
                            latLngArray.getJSONObject(i).getInt("quarentine"),
                            latLngArray.getJSONObject(i).getInt("release")
                    ));
                }
                initMap(savedInstanceState);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }, error -> {

        }));


        source = getIntent().getStringExtra("source");
        destination = getIntent().getStringExtra("destination");
        Log.i(TAG, "onCreateView: " + source + " and " + destination);

        activityMapBinding.locationFab.setOnClickListener(v -> {
            Location lastKnownLocation = map.getLocationComponent().getLastKnownLocation();

            map.animateCamera(CameraUpdateFactory.newLatLngZoom(
                    new LatLng(lastKnownLocation.getLatitude(), lastKnownLocation.getLongitude()), 16.5), new MapboxMap.CancelableCallback() {
                @Override
                public void onCancel() {

                }

                @Override
                public void onFinish() {
                    map.getLocationComponent().setCameraMode(CameraMode.TRACKING);
                }
            });
        });
    }

    private void initMap(Bundle savedInstanceState) {
        LatLng source = new LatLng(23, 90), destination = new LatLng(23, 90);
        mapView = activityMapBinding.coronaMap;

        mapView.onCreate(savedInstanceState);

        geocoder = new Geocoder(this);

        List<Feature> symbolLayerIconFeatureList = new ArrayList<>();

        mapView.getMapAsync(new OnMapReadyCallback() {
            @Override
            public void onMapReady(@NonNull final MapboxMap mapboxMap) {
                map = mapboxMap;
                map.setStyle(new Style.Builder().fromUri(/*"mapbox://styles/mapbox/cjf4m44iw0uza2spb3q0a7s41"*/ /*"mapbox://styles/mapbox/light-v10"*/ /*"mapbox://styles/mapbox/navigation-preview-day-v4"*/ "mapbox://styles/mapbox/streets-v11")
                        , style -> {

                            activityMapBinding.locationFab.show();

                            symbolManager = new SymbolManager(mapView, mapboxMap, style);
                            circleManager = new CircleManager(mapView, mapboxMap, style);

                            UiSettings uiSettings = mapboxMap.getUiSettings();
                            uiSettings.setAllGesturesEnabled(true);
                            uiSettings.setZoomGesturesEnabled(true);
                            uiSettings.setQuickZoomGesturesEnabled(true);
                            uiSettings.setCompassEnabled(true);

                            locationComponent = mapboxMap.getLocationComponent();
                            locationComponent.activateLocationComponent(locationComponentActivationOptions = LocationComponentActivationOptions.builder(MapActivity.this, style).build());

                            locationComponent.setLocationComponentEnabled(true);
                            locationComponent.setRenderMode(RenderMode.NORMAL);

                            for (LatLngQR x :
                                    centers) {
                                JsonObject dataQ = new JsonObject();
                                JsonObject dataR = new JsonObject();
                                dataQ.addProperty("count", "Quarantine: "+x.quarantine);
                                dataR.addProperty("count", "Release: "+x.release);
                                circleArrayListQuarantine.add(circleManager.create(new CircleOptions().withCircleRadius(x.quarantine*3.0f).withLatLng(x.center).withCircleColor("#FF0000").withCircleOpacity(0.4f).withData(dataQ)));
                                circleArrayListRelease.add(circleManager.create(new CircleOptions().withCircleRadius(x.release*3.0f).withLatLng(x.center).withCircleColor("#00FF00").withCircleOpacity(0.4f).withData(dataR)));
                            }

                            map.animateCamera(CameraUpdateFactory.newLatLngZoom(
                                    new LatLng(map.getLocationComponent().getLastKnownLocation().getLatitude(), map.getLocationComponent().getLastKnownLocation().getLongitude()), 14), new MapboxMap.CancelableCallback() {
                                @Override
                                public void onCancel() {

                                }

                                @Override
                                public void onFinish() {
                                }
                            });

                            circleManager.addClickListener(circle -> {
                                JsonObject jsonObject;
                                JsonElement jsonElement = circle.getData();
                                String count="";
                                if (jsonElement != null && jsonElement.isJsonObject()) {
                                    jsonObject = jsonElement.getAsJsonObject();
                                    count=jsonObject.get("count").getAsString();
                                }
                                Log.i(TAG, "onMapReady: "+count);
                            });


                            locationComponent.setLocationEngine(LocationEngineProvider.getBestLocationEngine(MapActivity.this));

                            locationComponent.getLocationEngine().requestLocationUpdates(
                                    new LocationEngineRequest
                                            .Builder(1000)
                                            .setMaxWaitTime(5000)
                                            .setPriority(LocationEngineRequest.PRIORITY_HIGH_ACCURACY)
                                            .build(),
                                    new LocationEngineCallback<LocationEngineResult>() {
                                        @Override
                                        public void onSuccess(LocationEngineResult result) {
                                            currentLocation = result.getLastLocation();
                                            LatLng current = new LatLng(currentLocation);
                                        }

                                        @Override
                                        public void onFailure(@NonNull Exception exception) {

                                        }
                                    },
                                    getMainLooper()
                            );
                            // Move the camera instantly to Sydney with a zoom of 15.
                        });
            }
        });
    }

    @Override
    public void onMapReady(@NonNull MapboxMap mapboxMap) {
        map = mapboxMap;
    }

    /*public static void drawCircle(MapboxMap map, LatLng position, int color, double radiusMeters) {
        PolylineOptions polylineOptions = new PolylineOptions();
        polylineOptions.color(color);
        polylineOptions.width(0.5f); // change the line width here
        polylineOptions.addAll(getCirclePoints(position, radiusMeters));
        map.addPolyline(polylineOptions);
    }

    private static ArrayList<LatLng> getCirclePoints(LatLng position, double radius) {
        int degreesBetweenPoints = 10; // change here for shape
        int numberOfPoints = (int) Math.floor(360 / degreesBetweenPoints);
        double distRadians = radius / 6371000.0; // earth radius in meters
        double centerLatRadians = position.getLatitude() * Math.PI / 180;
        double centerLonRadians = position.getLongitude() * Math.PI / 180;
        ArrayList<LatLng> polygons = new ArrayList<>(); // array to hold all the points
        for (int index = 0; index < numberOfPoints; index++) {
            double degrees = index * degreesBetweenPoints;
            double degreeRadians = degrees * Math.PI / 180;
            double pointLatRadians = Math.asin(sin(centerLatRadians) * cos(distRadians)
                    + cos(centerLatRadians) * sin(distRadians) * cos(degreeRadians));
            double pointLonRadians = centerLonRadians + Math.atan2(sin(degreeRadians)
                            * sin(distRadians) * cos(centerLatRadians),
                    cos(distRadians) - sin(centerLatRadians) * sin(pointLatRadians));
            double pointLat = pointLatRadians * 180 / Math.PI;
            double pointLon = pointLonRadians * 180 / Math.PI;
            LatLng point = new LatLng(pointLat, pointLon);
            polygons.add(point);
        }
        // add first point at end to close circle
        polygons.add(polygons.get(0));
        return polygons;
    }*/

}
