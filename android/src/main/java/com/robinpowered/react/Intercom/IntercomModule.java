package com.robinpowered.react.Intercom;

import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import java.util.HashMap;
import java.util.Map;

import io.intercom.android.sdk.Intercom;
import io.intercom.android.sdk.identity.Registration;

public class IntercomModule extends ReactContextBaseJavaModule {

    private static final String MODULE_NAME = "Intercom";
    public static final String TAG = "Intercom";

    public IntercomModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @ReactMethod
    public void registerIdentifiedUser(ReadableMap options, Callback errorCallback, Callback successCallback) {
        String userId = options.getString("userId");
        String userEmail = options.getString("email");

        if (userEmail != null && userEmail.length() > 0) {
            Intercom.client().registerIdentifiedUser(
                new Registration().withEmail(userEmail)
            );
            Log.i(TAG, "registerIdentifiedUser with userEmail");
            successCallback.invoke(userEmail);
        } else if (userId != null && userId.length() > 0) {
            Intercom.client().registerIdentifiedUser(
                new Registration().withUserId(userId)
            );
            Log.i(TAG, "registerIdentifiedUser with userId");
            successCallback.invoke(userId);
        } else {
            Log.e(TAG, "registerIdentifiedUser called with invalid userId or email");
            errorCallback.invoke("Invalid userId or email");
        }
    }

    @ReactMethod
    public void registerUnidentifiedUser(Callback callback) {
        Intercom.client().registerUnidentifiedUser();
        Log.i(TAG, "registerUnidentifiedUser");
        callback.invoke(null);
    }

    @ReactMethod
    public void reset(Callback callback) {
        Intercom.client().reset();
        Log.i(TAG, "reset");
        callback.invoke(null);
    }

    @ReactMethod
    public void updateUser(ReadableMap options, Callback errorCallback, Callback successCallback) {
        Log.i(TAG, "updateUser");
        Map<String, Object> map = new HashMap<>();

//        Intercom.client().updateUser();
        successCallback.invoke(null);
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
