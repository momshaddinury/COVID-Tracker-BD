package com.tne.selfreportingapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.graphics.Color;
import android.graphics.PointF;
import android.graphics.RectF;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.databinding.DataBindingUtil;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.mapbox.android.core.location.LocationEngineCallback;
import com.mapbox.android.core.location.LocationEngineProvider;
import com.mapbox.android.core.location.LocationEngineRequest;
import com.mapbox.android.core.location.LocationEngineResult;
import com.mapbox.geojson.Feature;
import com.mapbox.geojson.LineString;
import com.mapbox.geojson.Point;
import com.mapbox.geojson.Polygon;
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
import com.mapbox.mapboxsdk.plugins.annotation.Symbol;
import com.mapbox.mapboxsdk.plugins.annotation.SymbolManager;
import com.mapbox.mapboxsdk.style.layers.FillLayer;
import com.mapbox.mapboxsdk.style.layers.Property;
import com.mapbox.mapboxsdk.style.sources.GeoJsonSource;
import com.mapbox.turf.TurfConversion;
import com.mapbox.turf.TurfMeta;
import com.mapbox.turf.TurfTransformation;
import com.tne.selfreportingapp.databinding.ActivityMapBinding;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillColor;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillOpacity;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.visibility;
import static com.mapbox.turf.TurfConstants.UNIT_METERS;

public class MapActivity extends Activity implements OnMapReadyCallback, MapboxMap.OnMapClickListener {

    ActivityMapBinding activityMapBinding;
    String TAG = "MapActivity";
    private static final String TURF_CALCULATION_FILL_LAYER_GEOJSON_SOURCE_ID
            = "TURF_CALCULATION_FILL_LAYER_GEOJSON_SOURCE_ID";
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

    private static final String mapMetaKey = "map_meta";
    private static final String mapUrlKey = "mapBoxUrl";
    private static final String mapCircleRadiusKey = "circleRadius";
    private static final String mapCircleRadiusScalingKey = "circleRadiusScaling";
    private static final String mapCircleStrokeKey = "strokedCircleLayout";

    private static final boolean IS_STROKED_CIRCLE = true;
    private static final float FIXED_RADIUS = 18000;
    private static final float FIXED_RADIUS_SCALE = 1.5f;

    private boolean isStrokedCircle = IS_STROKED_CIRCLE;

    private String mapBoxUrl;
    private float radius=FIXED_RADIUS;
    private float radiusScaling=FIXED_RADIUS_SCALE;

    private RequestQueue requestQueue;

    private ArrayList<LatLngQR> centers = new ArrayList<>();

    StringRequest mapRequest;

    @Override
    protected void onResume() {
        super.onResume();
        requestQueue.start();
    }

    @Override
    protected void onPause() {
        super.onPause();
        requestQueue.stop();
    }

    @SuppressLint("LogNotTimber")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Mapbox.getInstance(this, getString(R.string.access_token));
        activityMapBinding = DataBindingUtil.setContentView(this, R.layout.activity_map);

        activityMapBinding.backButton.setOnClickListener(view -> {
            finish();
        });

        activityMapBinding.closeStatus.setOnClickListener(view -> {
            activityMapBinding.statusLayout.setVisibility(View.GONE);
        });

        requestQueue = Volley.newRequestQueue(this);

        String mapUrl = "https://zerothindex.org/mapdata";
        requestQueue.add(mapRequest = new StringRequest(Request.Method.GET, mapUrl, response -> {
            Log.i(TAG, "onResponse: " + response);
            try {
                JSONObject jsonObject = new JSONObject(response);

                if (jsonObject.has(mapMetaKey)) {
                    JSONObject mapMeta = jsonObject.getJSONObject(mapMetaKey);
                    if (mapMeta.has(mapUrlKey)) mapBoxUrl=mapMeta.getString(mapUrlKey);
                    if (mapMeta.has(mapCircleRadiusKey)) radius= (float) mapMeta.getDouble(mapCircleRadiusKey);
                    if (mapMeta.has(mapCircleRadiusScalingKey)) radiusScaling= (float) mapMeta.getDouble(mapCircleRadiusScalingKey);
                    if (mapMeta.has(mapCircleStrokeKey)) isStrokedCircle=mapMeta.getBoolean(mapCircleStrokeKey);
                }

                JSONArray latLngArray = jsonObject.getJSONArray("data");
                for (int i = 0; i < latLngArray.length(); i++) {
                    centers.add(new LatLngQR(
                            new LatLng(latLngArray.getJSONObject(i).getJSONArray("lat_lng").getJSONArray(0).getDouble(0), latLngArray.getJSONObject(i).getJSONArray("lat_lng").getJSONArray(0).getDouble(1)),
                            latLngArray.getJSONObject(i).getInt("quarentine"),
                            latLngArray.getJSONObject(i).getInt("release"),
                            latLngArray.getJSONObject(i).getString("region")
                    ));
                }
                initMap(savedInstanceState);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }, error -> {
            Toast.makeText(MapActivity.this, "Possible Connection Issue, Retrying...", Toast.LENGTH_SHORT).show();
            requestQueue.add(mapRequest);
        }));


        source = getIntent().getStringExtra("source");
        destination = getIntent().getStringExtra("destination");
        Log.i(TAG, "onCreateView: " + source + " and " + destination);

        activityMapBinding.locationFab.setOnClickListener(v -> {
            Location lastKnownLocation = map.getLocationComponent().getLastKnownLocation();

            map.animateCamera(CameraUpdateFactory.newLatLngZoom(
                    new LatLng(lastKnownLocation.getLatitude(), lastKnownLocation.getLongitude()), 6), new MapboxMap.CancelableCallback() {
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

    private void showStats(LatLngQR lnQR) {
        activityMapBinding.statusLayout.setVisibility(View.VISIBLE);
        activityMapBinding.regionT.setText(lnQR.name);
        activityMapBinding.qText.setText(String.valueOf(lnQR.quarantine));
        activityMapBinding.rText.setText(String.valueOf(lnQR.release));
        activityMapBinding.statusProgress.setProgress(lnQR.quarantine * 100 / (lnQR.quarantine + lnQR.release));

    }

    private void initMap(Bundle savedInstanceState) {
        LatLng source = new LatLng(23, 90), destination = new LatLng(23, 90);
        mapView = activityMapBinding.coronaMap;

        mapView.onCreate(savedInstanceState);

        geocoder = new Geocoder(this);

        List<Feature> symbolLayerIconFeatureList = new ArrayList<>();

        mapView.getMapAsync(mapboxMap -> {
            map = mapboxMap;
            map.setStyle(new Style.Builder().fromUri(/*"mapbox://styles/mapbox/cjf4m44iw0uza2spb3q0a7s41"*/ /*"mapbox://styles/mapbox/light-v10"*/ /*"mapbox://styles/mapbox/navigation-preview-day-v4"*/ mapBoxUrl == null ? "mapbox://styles/mapbox/streets-v11" : mapBoxUrl)
                    , style -> {

                        activityMapBinding.locationFab.show();
                        activityMapBinding.mapLoading.setVisibility(View.GONE);

                        mapboxMap.addOnMapClickListener(MapActivity.this);

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

                        /*for (LatLngQR x :
                                centers) {
                            JsonObject dataQ = new JsonObject();
                            JsonObject dataR = new JsonObject();
                            dataQ.addProperty("count", "Quarantine: "+x.quarantine);
                            dataR.addProperty("count", "Release: "+x.release);
                            circleArrayListQuarantine.add(circleManager.create(new CircleOptions().withCircleRadius(x.quarantine*0.03f).withLatLng(x.center).withCircleColor("#FF0000").withCircleOpacity(0.4f).withData(dataQ)));
                            circleArrayListRelease.add(circleManager.create(new CircleOptions().withCircleRadius(x.release*0.03f).withLatLng(x.center).withCircleColor("#00FF00").withCircleOpacity(0.4f).withData(dataR)));
                        }*/

//                            initPolygonCircleFillLayer();

                        drawPolygonCircle();

                        initPolygonCircleFillLayer();

                        /*try {
                            map.animateCamera(CameraUpdateFactory.newLatLngZoom(
                                    new LatLng(map.getLocationComponent().getLastKnownLocation().getLatitude(), map.getLocationComponent().getLastKnownLocation().getLongitude()), 14), new MapboxMap.CancelableCallback() {
                                @Override
                                public void onCancel() {

                                }

                                @Override
                                public void onFinish() {
                                }
                            });
                        } catch (Exception e) {*/
                        map.animateCamera(CameraUpdateFactory.newLatLngZoom(
                                new LatLng(23.770264, 90.320395), 6), new MapboxMap.CancelableCallback() {
                            @Override
                            public void onCancel() {

                            }

                            @Override
                            public void onFinish() {
                            }
                        });
//                            }

                        /*circleManager.addClickListener(circle -> {
                            JsonObject jsonObject;
                            JsonElement jsonElement = circle.getData();
                            String count="";
                            if (jsonElement != null && jsonElement.isJsonObject()) {
                                jsonObject = jsonElement.getAsJsonObject();
                                count=jsonObject.get("count").getAsString();
                            }
                            Log.i(TAG, "onMapReady: "+count);
                        });*/


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
        });
    }

    @Override
    public void onMapReady(@NonNull MapboxMap mapboxMap) {
        map = mapboxMap;
    }

    private void initPolygonCircleFillLayer() {
        map.getStyle(style -> {
            for (int i = 0; i < centers.size(); i++) {
                /*LineLayer lineLayerQ = new LineLayer(centers.get(i).name + "q",
                        centers.get(i).name + "r");
                lineLayerQ.setProperties(
                        visibility(Property.VISIBLE),
                        lineColor(Color.parseColor("#ff0000")),
                        lineOpacity(.5f),
                        lineWidth(centers.get(i).quarantine * 100 / (centers.get(i).quarantine + centers.get(i).release))
                );*/
                FillLayer fillLayerQ = new FillLayer(centers.get(i).name + "q",
                        centers.get(i).name + "q");
                fillLayerQ.setProperties(
                        visibility(Property.VISIBLE),
                        fillColor(Color.parseColor("#ff0000")),
                        fillOpacity(.5f));

                FillLayer fillLayerR = new FillLayer(centers.get(i).name + "r",
                        centers.get(i).name + "r");
                fillLayerR.setProperties(
                        visibility(Property.VISIBLE),
                        fillColor(Color.parseColor("#00dd00")),
                        fillOpacity(.5f));
                /*if(i>0) {
                    style.addLayerAbove(fillLayerQ, centers.get(i - 1).name + "r");
                } else {
                    style.addLayer(fillLayerQ);
                }
                style.addLayerAbove(fillLayerR, centers.get(i).name + "q");*/
                style.addLayer(fillLayerQ);
                style.addLayer(fillLayerR);

            }
        });
    }

    private void drawPolygonCircle() {
        map.getStyle(style -> {
            for (LatLngQR lnQR :
                    centers) {
                /*Polygon polygonAreaQ = getTurfPolygon(Point.fromLngLat(lnQR.center.getLongitude(), lnQR.center.getLatitude()), lnQR.quarantine * 3f, 400, UNIT_METERS);
                GeoJsonSource polygonCircleSourceQ = style.getSourceAs(lnQR.name + "q");
                if (polygonCircleSourceQ != null) {
                    polygonCircleSourceQ.setGeoJson(Polygon.fromOuterInner(
                            LineString.fromLngLats(TurfMeta.coordAll(polygonAreaQ, false))));
                } else {
                    polygonCircleSourceQ = new GeoJsonSource(lnQR.name + "q", Polygon.fromOuterInner(
                            LineString.fromLngLats(TurfMeta.coordAll(polygonAreaQ, false))));
                    style.addSource(polygonCircleSourceQ);
                }*/

                Polygon polygonAreaQ = getTurfPolygon(Point.fromLngLat(lnQR.center.getLongitude(), lnQR.center.getLatitude()), isStrokedCircle ? ((lnQR.quarantine + lnQR.release) * radiusScaling) : radius*radiusScaling, 400, UNIT_METERS);
                GeoJsonSource polygonCircleSourceQ = style.getSourceAs(lnQR.name + "q");
                if (polygonCircleSourceQ != null) {
                    polygonCircleSourceQ.setGeoJson(Polygon.fromOuterInner(
                            LineString.fromLngLats(TurfMeta.coordAll(polygonAreaQ, false))));
                } else {
                    polygonCircleSourceQ = new GeoJsonSource(lnQR.name + "q", Polygon.fromOuterInner(
                            LineString.fromLngLats(TurfMeta.coordAll(polygonAreaQ, false))));
                    style.addSource(polygonCircleSourceQ);
                }


                Polygon polygonAreaR = getTurfPolygon(Point.fromLngLat(isStrokedCircle ? lnQR.center.getLongitude() : (lnQR.center.getLongitude() + TurfConversion.lengthToDegrees(radius * radiusScaling * 2, UNIT_METERS)), lnQR.center.getLatitude()), isStrokedCircle ? lnQR.release * radiusScaling : radius*radiusScaling, 400, UNIT_METERS);
                GeoJsonSource polygonCircleSourceR = style.getSourceAs(lnQR.name + "r");
                if (polygonCircleSourceR != null) {
                    polygonCircleSourceR.setGeoJson(Polygon.fromOuterInner(
                            LineString.fromLngLats(TurfMeta.coordAll(polygonAreaR, false))));
                    Log.i(TAG, "drawPolygonCircle: " + polygonAreaR.toString());
                    style.addSource(polygonCircleSourceR);
                } else {
                    polygonCircleSourceR = new GeoJsonSource(lnQR.name + "r", Polygon.fromOuterInner(
                            LineString.fromLngLats(TurfMeta.coordAll(polygonAreaR, false))));
                    style.addSource(polygonCircleSourceR);
                }

            }
// Use Turf to calculate the Polygon's coordinates

        });
    }

    @Override
    public boolean onMapClick(@NonNull LatLng point) {
        PointF pointf = map.getProjection().toScreenLocation(point);
        RectF rectF = new RectF(pointf.x - 10, pointf.y - 10, pointf.x + 10, pointf.y + 10);
        for (LatLngQR lnQR :
                centers) {
            List<Feature> featureList;
            if ((featureList = map.queryRenderedFeatures(rectF, lnQR.name + "q")).size() > 0) {
                Log.i(TAG, "onMapClick: " + featureList.get(0).toJson());
//                Toast.makeText(MapActivity.this, "Clicked " + lnQR.name, Toast.LENGTH_LONG).show();
                showStats(lnQR);
            } else if ((featureList = map.queryRenderedFeatures(rectF, lnQR.name + "r")).size() > 0) {
                Log.i(TAG, "onMapClick: " + featureList.get(0).toJson());
//                Toast.makeText(MapActivity.this, "Clicked " + lnQR.name, Toast.LENGTH_LONG).show();
                showStats(lnQR);
            }
        }
        /*List<Feature> featureList = map.queryRenderedFeatures(rectF, geoJsonLayerId);
        if (featureList.size() > 0) {
            for (Feature feature : featureList) {

            }
            return true;
        }*/
        return false;
    }

    private Polygon getTurfPolygon(@NonNull Point centerPoint, @NonNull double radius,
                                   @NonNull int steps, @NonNull String units) {
        return TurfTransformation.circle(centerPoint, radius, steps, units);
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
