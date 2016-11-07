package com.robinpowered.react.Intercom;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import javax.annotation.Nullable;

import io.intercom.android.sdk.Intercom;
import io.intercom.android.sdk.UnreadConversationCountListener;

public class IntercomEventEmitter extends ReactContextBaseJavaModule {

    private static final String MODULE_NAME = "IntercomEventEmitter";
    public static final String TAG = "Intercom Event";
    public static final String UNREAD_CHANGE_NOTIFICATION = "INTERCOM_UNREAD_CHANGE_NOTIFICATION";

    public IntercomEventEmitter(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    private void handleUpdateUnreadCount() {
        WritableMap params = Arguments.createMap();
        params.putInt("count", Intercom.client().getUnreadConversationCount());
        sendEvent(UNREAD_CHANGE_NOTIFICATION, params);
    }

    private void sendEvent(String eventName, @Nullable WritableMap params) {
        getReactApplicationContext()
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    private final UnreadConversationCountListener unreadConversationCountListener = new UnreadConversationCountListener() {
        @Override
        public void onCountUpdate(int conversationCount) {
            handleUpdateUnreadCount();
        }
    };
}
