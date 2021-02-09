package com.robinpowered.react.Intercom;

import android.util.Log;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Nullable;

import io.intercom.android.sdk.Company;
import io.intercom.android.sdk.Intercom;
import io.intercom.android.sdk.UserAttributes;
import io.intercom.android.sdk.identity.Registration;
import io.intercom.android.sdk.push.IntercomPushClient;
import io.intercom.android.sdk.identity.AppIdentity;

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

    @Override
    public boolean canOverrideExistingModule() {        
        return true;
    }

    @ReactMethod
    public void registerIdentifiedUser(ReadableMap options, Promise promise) {
        try {
            Boolean hasEmail = options.hasKey("email") && options.getString("email").length() > 0;
            Boolean hasUserId = options.hasKey("userId") && options.getString("userId").length() > 0;
            if (hasEmail && hasUserId) {
                Intercom.client().registerIdentifiedUser(
                        new Registration().withEmail(options.getString("email")).withUserId(options.getString("userId"))
                );
                Log.i(TAG, "registerIdentifiedUser with userEmail");
                promise.resolve(null);
            } else if (hasEmail) {
                Intercom.client().registerIdentifiedUser(
                    Registration.create().withEmail(options.getString("email"))
                );
                Log.i(TAG, "registerIdentifiedUser with userEmail");
                promise.resolve(null);
            } else if (hasUserId) {
                Intercom.client().registerIdentifiedUser(
                    Registration.create().withUserId(options.getString("userId"))
                );
                Log.i(TAG, "registerIdentifiedUser with userId");
                promise.resolve(null);
            } else {
                Log.e(TAG, "registerIdentifiedUser called with invalid userId or email");
                promise.reject("Invalid userId or email");
            }
        } catch (Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void sendTokenToIntercom(String token, Promise promise) {
        try {
            if (getCurrentActivity() != null) {
                intercomPushClient.sendTokenToIntercom(getCurrentActivity().getApplication(), token);
                Log.i(TAG, "sendTokenToIntercom");
                promise.resolve(null);
            } else {
                Log.e(TAG, "sendTokenToIntercom; getCurrentActivity() is null");
            }
        } catch(Exception e) {
            promise.reject(e.toString());
        }
    }
  
    @ReactMethod
    public void presentCarousel(String carouselID, Promise promise) {
        try {
            Intercom.client().displayCarousel(carouselID);
            Log.i(TAG, "presentCarousel");
            promise.resolve(null);
        } catch(Exception e) {
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void registerUnidentifiedUser(Promise promise) {
        try {
            Intercom.client().registerUnidentifiedUser();
            Log.i(TAG, "registerUnidentifiedUser");
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void logout(Promise promise) {
        try {
            Intercom.client().logout();
            Log.i(TAG, "logout");
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void updateUser(ReadableMap options, Promise promise) {
        try {
            UserAttributes userAttributes = convertToUserAttributes(options);
            Intercom.client().updateUser(userAttributes);
            Log.i(TAG, "updateUser");
            promise.resolve(null);
        } catch (Exception e) {
            Log.e(TAG, "updateUser - unable to deconstruct argument map");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void logEvent(String eventName, @Nullable ReadableMap metaData, Promise promise) {
        try {
            if (metaData == null) {
                Intercom.client().logEvent(eventName);
            }
            if (metaData != null) {
                Map<String, Object> deconstructedMap = recursivelyDeconstructReadableMap(metaData);
                Intercom.client().logEvent(eventName, deconstructedMap);
            }
            Log.i(TAG, "logEvent");
            promise.resolve(null);
        } catch (Exception e) {
            Log.e(TAG, "logEvent - unable to deconstruct metaData");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void handlePushMessage(Promise promise) {
        try {
            Intercom.client().handlePushMessage();
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void displayMessenger(Promise promise) {
        try {
            Intercom.client().displayMessenger();
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void hideMessenger(Promise promise) {
        try {
            Intercom.client().hideMessenger();
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void displayMessageComposer(Promise promise) {
        try {
            Intercom.client().displayMessageComposer();
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void displayMessageComposerWithInitialMessage(String message, Promise promise) {
        try {
            Intercom.client().displayMessageComposer(message);
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void setUserHash(String userHash, Promise promise) {
        try {
            Intercom.client().setUserHash(userHash);
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void displayConversationsList(Promise promise) {
        try {
            Intercom.client().displayConversationsList();
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    @ReactMethod
    public void getUnreadConversationCount(Promise promise) {

        try {
            int conversationCount = Intercom.client().getUnreadConversationCount();

            promise.resolve(conversationCount);
        } catch (Exception ex) {
            Log.e(TAG, "logEvent - unable to get conversation count");
            promise.reject(ex.toString());
        }
    }

    @ReactMethod
    public void displayHelpCenter(Promise promise) {
        try {
            Intercom.client().displayHelpCenter();
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
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
    public void setLauncherVisibility(String visibility, Promise promise) {
        Intercom.Visibility intercomVisibility = visibilityStringToVisibility(visibility);

        try {
            Intercom.client().setLauncherVisibility(intercomVisibility);

            promise.resolve(null);
        } catch (Exception ex) {
            promise.reject(ex.toString());
        }
    }

    @ReactMethod
    public void setInAppMessageVisibility(String visibility, Promise promise) {
        Intercom.Visibility intercomVisibility = visibilityStringToVisibility(visibility);

        try {
            Intercom.client().setInAppMessageVisibility(intercomVisibility);

            promise.resolve(null);
        } catch (Exception ex) {
            promise.reject(ex.toString());
        }
    }

    @ReactMethod
    public void setBottomPadding( Integer padding, Promise promise) {
        try {
            Intercom.client().setBottomPadding(padding);
            Log.i(TAG, "setBottomPadding");
            promise.resolve(null);
        } catch(Exception e) {
            Log.e(TAG, "Intercom not initialized");
            promise.reject(e.toString());
        }
    }

    private UserAttributes convertToUserAttributes(ReadableMap readableMap) {
        Map<String, Object> map = recursivelyDeconstructReadableMap(readableMap);
        UserAttributes.Builder builder = new UserAttributes.Builder();
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            if (key.equals("email")) {
                builder.withEmail((String)value);
            } else if (key.equals("user_id")) {
                builder.withUserId((String)value);
            } else if (key.equals("name")) {
                builder.withName((String)value);
            } else if (key.equals("phone")) {
                builder.withPhone((String)value);
            } else if (key.equals("language_override")) {
                builder.withLanguageOverride((String)value);
            } else if (key.equals("signed_up_at")) {
                Date dateSignedUpAt = new Date(((Number)value).longValue() * 1000);
                builder.withSignedUpAt(dateSignedUpAt);
            } else if (key.equals("unsubscribed_from_emails")) {
                builder.withUnsubscribedFromEmails((Boolean)value);
            } else if (key.equals("custom_attributes")) {
                // value should be a Map here
                builder.withCustomAttributes((Map)value);
            } else if (key.equals("companies")) {
                ArrayList<Map<String, Object>> companyaArray =  (ArrayList<Map<String, Object>>)value;
                for (Map<String, Object> companyObject: companyaArray) {
                    if (companyObject.containsKey("company_id")) {
                        Company.Builder companyBuilder = new Company.Builder();
                        companyBuilder.withCompanyId(companyObject.get("company_id").toString());
                        if (companyObject.containsKey("name")) {
                            companyBuilder.withName(companyObject.get("name").toString());
                        }
                        Company company = companyBuilder.build();
                        builder.withCompany(company);
                    }
                }
            }
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

