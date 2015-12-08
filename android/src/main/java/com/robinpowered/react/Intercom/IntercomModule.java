package com.robinpowered.react.Intercom;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class IntercomModule extends ReactContextBaseJavaModule {

    private static final String MODULE_NAME = "Intercom";

    public IntercomModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @ReactMethod
    public void registerIdentifiedUser() {

    }

    @ReactMethod
    public void registerUnidentifiedUser() {

    }

    @ReactMethod
    public void reset() {

    }

    @ReactMethod
    public void updateUser() {

    }

    @ReactMethod
    public void logEvent() {

    }

    @ReactMethod
    public void displayMessageComposer() {

    }

    @ReactMethod
    public void setVisibility() {

    }

    @ReactMethod
    public void setPreviewPosition() {

    }
}
