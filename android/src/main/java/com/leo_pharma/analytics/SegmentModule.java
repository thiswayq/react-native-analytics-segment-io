package com.leo_pharma.analytics;

import android.support.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.segment.analytics.Analytics;
import com.segment.analytics.Properties;
import com.segment.analytics.Traits;
import com.segment.analytics.android.integrations.adjust.AdjustIntegration;
import com.segment.analytics.android.integrations.amplitude.AmplitudeIntegration;
import com.segment.analytics.android.integrations.appboy.AppboyIntegration;
import com.segment.analytics.android.integrations.appsflyer.AppsflyerIntegration;
import com.segment.analytics.android.integrations.bugsnag.BugsnagIntegration;
import com.segment.analytics.android.integrations.comscore.ComScoreIntegration;
import com.segment.analytics.android.integrations.countly.CountlyIntegration;
import com.segment.analytics.android.integrations.crittercism.CrittercismIntegration;
import com.segment.analytics.android.integrations.firebase.FirebaseIntegration;
import com.segment.analytics.android.integrations.google.analytics.GoogleAnalyticsIntegration;
import com.segment.analytics.android.integrations.localytics.LocalyticsIntegration;
import com.segment.analytics.android.integrations.mixpanel.MixpanelIntegration;
import com.segment.analytics.android.integrations.nielsendcr.NielsenDCRIntegration;
import com.segment.analytics.android.integrations.quantcast.QuantcastIntegration;
import com.segment.analytics.android.integrations.tapstream.TapstreamIntegration;
import com.segment.analytics.android.integrations.branch.BranchIntegration;

import java.util.HashMap;
import java.util.Map;

public class SegmentModule extends ReactContextBaseJavaModule {
    private static final String PROPERTY_FLUSH_AT = "flushAt";
    private static final String PROPERTY_RECORD_SCREEN_VIEWS = "recordScreenViews";
    private static final String PROPERTY_TRACK_APPLICATION_LIFECYCLE_EVENTS = "trackApplicationLifecycleEvents";
    private static final String PROPERTY_TRACK_ATTRIBUTION_DATA = "trackAttributionData";
    private static final String PROPERTY_DEBUG = "debug";

    public SegmentModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "SegmentModule";
    }

    @ReactMethod
    public void setup(@Nullable String key, @Nullable ReadableMap options, Promise promise) {
        Analytics.Builder analyticsBuilder = new Analytics.Builder(getReactApplicationContext(), key);

        if (options != null) {
            if (options.hasKey(PROPERTY_FLUSH_AT)) {
                analyticsBuilder.flushQueueSize(options.getInt(PROPERTY_FLUSH_AT));
            }

            if (options.hasKey(PROPERTY_RECORD_SCREEN_VIEWS) && options.getBoolean(PROPERTY_RECORD_SCREEN_VIEWS)) {
                analyticsBuilder.recordScreenViews();
            }

            if (options.hasKey(PROPERTY_TRACK_APPLICATION_LIFECYCLE_EVENTS)
                    && options.getBoolean(PROPERTY_TRACK_APPLICATION_LIFECYCLE_EVENTS)) {
                analyticsBuilder.trackApplicationLifecycleEvents();
            }

            if (options.hasKey(PROPERTY_TRACK_ATTRIBUTION_DATA)
                    && options.getBoolean(PROPERTY_TRACK_ATTRIBUTION_DATA)) {
                analyticsBuilder.trackAttributionInformation();
            }

            if (options.hasKey(PROPERTY_DEBUG) && options.getBoolean(PROPERTY_DEBUG)) {
                analyticsBuilder.logLevel(Analytics.LogLevel.VERBOSE);
            }
            else {
                analyticsBuilder.logLevel(Analytics.LogLevel.NONE);
            }
        }

        setupIntegrations(analyticsBuilder);

        try {
            Analytics.setSingletonInstance(analyticsBuilder.build());
            promise.resolve(true);
        } catch (IllegalStateException e) {
            promise.reject("IllegalStateException", "Analytics is already set up, cannot perform setup twice.");
        }
    }

    /**
     * Sets up integrations from https://github.com/segment-integrations plus AppsFlyer, if their SDK is present
     *
     * @param analyticsBuilder
     */
    private void setupIntegrations(Analytics.Builder analyticsBuilder) {
        if (isClassAvailable("com.segment.analytics.android.integrations.adjust.AdjustIntegration")) {
            analyticsBuilder.use(AdjustIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.amplitude.AmplitudeIntegration")) {
            analyticsBuilder.use(AmplitudeIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.appboy.AppboyIntegration")) {
            analyticsBuilder.use(AppboyIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.appsflyer.AppsflyerIntegration")) {
            analyticsBuilder.use(AppsflyerIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.bugsnag.BugsnagIntegration")) {
            analyticsBuilder.use(BugsnagIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.comscore.ComScoreIntegration")) {
            analyticsBuilder.use(ComScoreIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.countly.CountlyIntegration")) {
            analyticsBuilder.use(CountlyIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.crittercism.CrittercismIntegration")) {
            analyticsBuilder.use(CrittercismIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.firebase.FirebaseIntegration")) {
            analyticsBuilder.use(FirebaseIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.google.analytics.GoogleAnalyticsIntegration")) {
            analyticsBuilder.use(GoogleAnalyticsIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.localytics.LocalyticsIntegration")) {
            analyticsBuilder.use(LocalyticsIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.mixpanel.MixpanelIntegration")) {
            analyticsBuilder.use(MixpanelIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.nielsendcr.NielsenDCRIntegration")) {
            analyticsBuilder.use(NielsenDCRIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.quantcast.QuantcastIntegration")) {
            analyticsBuilder.use(QuantcastIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.tapstream.TapstreamIntegration")) {
            analyticsBuilder.use(TapstreamIntegration.FACTORY);
        }

        if (isClassAvailable("com.segment.analytics.android.integrations.branch.BranchIntegration")) {
            analyticsBuilder.use(BranchIntegration.FACTORY);
        }
    }

    /**
     * Checks if a certain class is available.
     *
     * @param className Including the full package name
     * @return True if the class is available. False if it cannot be found.
     */
    private boolean isClassAvailable(String className) {
        try {
            Class.forName(className);
            return true;
        } catch (ClassNotFoundException e) {
            return false;
        }
    }

    @ReactMethod
    public void identify(@Nullable String userId, @Nullable ReadableMap properties, Promise promise) {
        Traits traits = new Traits();

        if (properties != null) {
            traits.putAll(properties.toHashMap());
        }
        try {

            Analytics.with(getReactApplicationContext()).identify(userId, traits, null);
            promise.resolve(true);
        } catch (Exception e) {
            promise.reject("Exception", e.getMessage());
        }
    }

    @ReactMethod
    public void track(@Nullable String event, @Nullable ReadableMap properties, Promise promise) {
        Properties segmentProperties = new Properties();

        if (properties != null) {
            segmentProperties.putAll(properties.toHashMap());
        }
        try {

            Analytics.with(getReactApplicationContext()).track(event, segmentProperties);
            promise.resolve(true);
        } catch (Exception e) {
            promise.reject("Exception", e.getMessage());
        }
    }

    @ReactMethod
    public void screen(@Nullable String name, @Nullable ReadableMap properties, Promise promise) {
        Properties segmentProperties = new Properties();

        if (properties != null) {
            segmentProperties.putAll(properties.toHashMap());
        }
        try {

            Analytics.with(getReactApplicationContext()).screen("", name, segmentProperties);
            promise.resolve(true);
        } catch (Exception e) {
            promise.reject("Exception", e.getMessage());
        }
    }

    @ReactMethod
    public void group(@Nullable String groupId, @Nullable ReadableMap properties, Promise promise) {
        Traits traits = new Traits();

        if (properties != null) {
            traits.putAll(properties.toHashMap());
        }

        try {
            Analytics.with(getReactApplicationContext()).group(groupId, traits, null);
            promise.resolve(true);
        } catch (Exception e) {
            promise.reject("Exception", e.getMessage());
        }
    }

    @ReactMethod
    public void alias(@Nullable String newId, Promise promise) {
        try {
            Analytics.with(getReactApplicationContext()).alias(newId);
            promise.resolve(true);
        } catch (Exception e) {
            promise.reject("Exception", e.getMessage());
        }
    }

    @ReactMethod
    public void reset(Promise promise) {
        try {
            Analytics.with(getReactApplicationContext()).reset();
            promise.resolve(true);
        } catch (Exception e) {
            promise.reject("Exception", e.getMessage());
        }

    }

    @ReactMethod
    public void flush(Promise promise) {
        try {
            Analytics.with(getReactApplicationContext()).flush();
            promise.resolve(true);
        } catch (Exception e) {
            promise.reject("Exception", e.getMessage());
        }
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put(PROPERTY_FLUSH_AT, PROPERTY_FLUSH_AT);
        constants.put(PROPERTY_RECORD_SCREEN_VIEWS, PROPERTY_RECORD_SCREEN_VIEWS);
        constants.put(PROPERTY_TRACK_APPLICATION_LIFECYCLE_EVENTS, PROPERTY_TRACK_APPLICATION_LIFECYCLE_EVENTS);
        constants.put(PROPERTY_TRACK_ATTRIBUTION_DATA, PROPERTY_TRACK_ATTRIBUTION_DATA);
        constants.put(PROPERTY_DEBUG, PROPERTY_DEBUG);
        return constants;
    }
}