package com.robinpowered.react.Intercom;

import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Nullable;

import io.intercom.android.sdk.Intercom;
import io.intercom.android.sdk.UserAttributes;
import io.intercom.android.sdk.identity.Registration;
import io.intercom.android.sdk.push.IntercomPushClient;

public class IntercomModule extends ReactContextBaseJavaModule {

    private static final String MODULE_NAME = "IntercomWrapper";
    public static final String TAG = "Intercom";

    private final IntercomPushClient intercomPushClient = new IntercomPushClient();

    public IntercomModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @ReactMethod
    public void registerIdentifiedUser(ReadableMap options, Callback callback) {
        if (options.hasKey("email") && options.getString("email").length() > 0) {
            Intercom.client().registerIdentifiedUser(
                    new Registration().withEmail(options.getString("email"))
            );
            Log.i(TAG, "registerIdentifiedUser with userEmail");
            callback.invoke(null, null);
        } else if (options.hasKey("userId") && options.getString("userId").length() > 0) {
            Intercom.client().registerIdentifiedUser(
                    new Registration().withUserId(options.getString("userId"))
            );
            Log.i(TAG, "registerIdentifiedUser with userId");
            callback.invoke(null, null);
        } else {
            Log.e(TAG, "registerIdentifiedUser called with invalid userId or email");
            callback.invoke("Invalid userId or email");
        }
    }

    @ReactMethod
    public void sendTokenToIntercom(String token, Callback callback) {
        if (getCurrentActivity() != null) {
            intercomPushClient.sendTokenToIntercom(getCurrentActivity().getApplication(), token);
            Log.i(TAG, "sendTokenToIntercom");
            callback.invoke(null, null);
        } else {
            Log.e(TAG, "sendTokenToIntercom; getCurrentActivity() is null");
        }
    }

    @ReactMethod
    public void registerUnidentifiedUser(Callback callback) {
        Intercom.client().registerUnidentifiedUser();
        Log.i(TAG, "registerUnidentifiedUser");
        callback.invoke(null, null);
    }

    @ReactMethod
    public void reset(@Nullable Callback callback) {
        Intercom.client().reset();
        Log.i(TAG, "reset");
        if (callback != null) {
            callback.invoke(null, null);
        }
    }

    @ReactMethod
    public void updateUser(ReadableMap options, Callback callback) {
        try {
            UserAttributes userAttributes = convertToUserAttributes(options);
            Intercom.client().updateUser(userAttributes);
            Log.i(TAG, "updateUser");
            callback.invoke(null, null);
        } catch (Exception e) {
            Log.e(TAG, "updateUser - unable to deconstruct argument map");
            callback.invoke(e.toString());
        }
    }

    @ReactMethod
    public void logEvent(String eventName, @Nullable ReadableMap metaData, Callback callback) {
        try {
            if (metaData == null) {
                Intercom.client().logEvent(eventName);
            }
            if (metaData != null) {
                Map<String, Object> deconstructedMap = recursivelyDeconstructReadableMap(metaData);
                Intercom.client().logEvent(eventName, deconstructedMap);
            }
            Log.i(TAG, "logEvent");
            callback.invoke(null, null);
        } catch (Exception e) {
            Log.e(TAG, "logEvent - unable to deconstruct metaData");
            callback.invoke(e.toString());
        }
    }

    @ReactMethod
    public void handlePushMessage(Callback callback) {
        Intercom.client().handlePushMessage();
        callback.invoke(null, null);
    }

    @ReactMethod
    public void displayMessenger(Callback callback) {
        Intercom.client().displayMessenger();
        callback.invoke(null, null);
    }

    @ReactMethod
    public void hideMessenger(Callback callback) {
        Intercom.client().hideMessenger();
        callback.invoke(null, null);
    }

    @ReactMethod
    public void displayMessageComposer(Callback callback) {
        Intercom.client().displayMessageComposer();
        callback.invoke(null, null);
    }

    @ReactMethod
    public void displayMessageComposerWithInitialMessage(String message, Callback callback) {
        Intercom.client().displayMessageComposer(message);
        callback.invoke(null, null);
    }

    @ReactMethod
    public void setUserHash(String userHash, Callback callback) {
        Intercom.client().setUserHash(userHash);
        callback.invoke(null, null);
    }

    @ReactMethod
    public void setHMAC(String hmac, String data, Callback callback) {
        Intercom.client().setSecureMode(hmac, data);
        callback.invoke(null, null);
    }

    @ReactMethod
    public void displayConversationsList(Callback callback) {
        Intercom.client().displayConversationsList();
        callback.invoke(null, null);
    }

    @ReactMethod
    public void getUnreadConversationCount(Callback callback) {

        try {
            int conversationCount = Intercom.client().getUnreadConversationCount();

            callback.invoke(null, conversationCount);
        } catch (Exception ex) {
            Log.e(TAG, "logEvent - unable to get conversation count");
            callback.invoke(ex.toString());
        }
    }

    private Intercom.Visibility visibilityStringToVisibility(String visibility) {
      if (visibility.equalsIgnoreCase("VISIBLE")) {
        return Intercom.Visibility.VISIBLE;
      } else {
        return Intercom.Visibility.GONE;
      }
    }

    @ReactMethod
    public void setLauncherVisibility(String visibility, Callback callback) {
        Intercom.Visibility intercomVisibility = visibilityStringToVisibility(visibility);

        try {
            Intercom.client().setLauncherVisibility(intercomVisibility);

            callback.invoke(null, null);
        } catch (Exception ex) {
            callback.invoke(ex.toString());
        }
    }

    @ReactMethod
    public void setInAppMessageVisibility(String visibility, Callback callback) {
        Intercom.Visibility intercomVisibility = visibilityStringToVisibility(visibility);

        try {
            Intercom.client().setInAppMessageVisibility(intercomVisibility);

            callback.invoke(null, null);
        } catch (Exception ex) {
            callback.invoke(ex.toString());
        }
    }
    
    @ReactMethod
    public void setBottomPadding( Integer padding, Callback callback) {
         Intercom.client().setBottomPadding(padding);
         Log.i(TAG, "setBottomPadding");
         callback.invoke(null, null);
    }

    private UserAttributes convertToUserAttributes(ReadableMap readableMap) {
        Map<String, Object> map = recursivelyDeconstructReadableMap(readableMap);
        UserAttributes.Builder builder = new UserAttributes.Builder();
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            builder.withCustomAttribute(entry.getKey(), entry.getValue());
        }
        return builder.build();
    }


    private Map<String, Object> recursivelyDeconstructReadableMap(ReadableMap readableMap) {
        ReadableMapKeySetIterator iterator = readableMap.keySetIterator();
        Map<String, Object> deconstructedMap = new HashMap<>();
        while (iterator.hasNextKey()) {
            String key = iterator.nextKey();
            ReadableType type = readableMap.getType(key);
            switch (type) {
                case Null:
                    deconstructedMap.put(key, null);
                    break;
                case Boolean:
                    deconstructedMap.put(key, readableMap.getBoolean(key));
                    break;
                case Number:
                    deconstructedMap.put(key, readableMap.getDouble(key));
                    break;
                case String:
                    deconstructedMap.put(key, readableMap.getString(key));
                    break;
                case Map:
                    deconstructedMap.put(key, recursivelyDeconstructReadableMap(readableMap.getMap(key)));
                    break;
                case Array:
                    deconstructedMap.put(key, recursivelyDeconstructReadableArray(readableMap.getArray(key)));
                    break;
                default:
                    throw new IllegalArgumentException("Could not convert object with key: " + key + ".");
            }

        }
        return deconstructedMap;
    }

    private List<Object> recursivelyDeconstructReadableArray(ReadableArray readableArray) {
        List<Object> deconstructedList = new ArrayList<>(readableArray.size());
        for (int i = 0; i < readableArray.size(); i++) {
            ReadableType indexType = readableArray.getType(i);
            switch(indexType) {
                case Null:
                    deconstructedList.add(i, null);
                    break;
                case Boolean:
                    deconstructedList.add(i, readableArray.getBoolean(i));
                    break;
                case Number:
                    deconstructedList.add(i, readableArray.getDouble(i));
                    break;
                case String:
                    deconstructedList.add(i, readableArray.getString(i));
                    break;
                case Map:
                    deconstructedList.add(i, recursivelyDeconstructReadableMap(readableArray.getMap(i)));
                    break;
                case Array:
                    deconstructedList.add(i, recursivelyDeconstructReadableArray(readableArray.getArray(i)));
                    break;
                default:
                    throw new IllegalArgumentException("Could not convert object at index " + i + ".");
            }
        }
        return deconstructedList;
    }
}
