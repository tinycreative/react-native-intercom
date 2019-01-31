package com.robinpowered.react.Intercom;

import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import javax.annotation.Nullable;

import android.util.Log;

import java.util.Map;
import java.util.HashMap;

import io.intercom.android.sdk.Intercom;
import io.intercom.android.sdk.UnreadConversationCountListener;

public class IntercomEventEmitter extends ReactContextBaseJavaModule {

    private static final String MODULE_NAME = "IntercomEventEmitter";
    public static final String TAG = "Intercom Event";
    private static final String UNREAD_CHANGE_NOTIFICATION = "IntercomUnreadConversationCountDidChangeNotification";

    public IntercomEventEmitter(ReactApplicationContext reactContext) {
        super(reactContext);
        try {
            Intercom.client().addUnreadConversationCountListener(unreadConversationCountListener);
        } catch (Exception e) {
            Log.e(TAG, "client called before Intercom initialization");
        }
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put("UNREAD_CHANGE_NOTIFICATION", UNREAD_CHANGE_NOTIFICATION);
        return constants;
    }

    private void handleUpdateUnreadCount() {
        try {
            WritableMap params = Arguments.createMap();
            params.putInt("count", Intercom.client().getUnreadConversationCount());
            sendEvent(UNREAD_CHANGE_NOTIFICATION, params);
        } catch (Exception e) {
            Log.e(TAG, "client called before Intercom initialization");
        }
    }

    private void sendEvent(String eventName, @Nullable WritableMap params) {
        if(getReactApplicationContext().hasActiveCatalystInstance()) {
            try {
                getReactApplicationContext()
                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit(eventName, params);
            } catch (Exception e) {
                Log.e(TAG, "sendEvent called before bundle loaded");
            }
        }
    }

    private final UnreadConversationCountListener unreadConversationCountListener = new UnreadConversationCountListener() {
        @Override
        public void onCountUpdate(int conversationCount) {
            handleUpdateUnreadCount();
        }
    };
}