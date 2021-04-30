# react-native-intercom
React Native wrapper for Intercom.io. Based off of [intercom-cordova](https://github.com/intercom/intercom-cordova)

# Installation Guide

1. [Install Intercom for iOS](https://developers.intercom.com/installing-intercom/docs/ios-installation) via whichever method you prefer.

    More recently others have had more success [Installing Intercom Manually](https://developers.intercom.com/installing-intercom/docs/ios-installation#section-option-3-install-intercom-manually).

    In the past, [installing via CocoaPods](https://developers.intercom.com/installing-intercom/docs/ios-installation#section-option-1-cocoapods) was recommended.


1. Install `react-native-intercom`:

    ```bash
    yarn add react-native-intercom  # or npm install react-native-intercom
    ```

1. Link native dependencies

    ```bash
    react-native link react-native-intercom
    ```

1. Manually Link the library in Xcode ([Linking librarys on iOS](https://facebook.github.io/react-native/docs/linking-libraries-ios.html))

    1. Open Xcode -> Right click "[Your Project Name]/Libraries" folder and select "Add File to [Your Project Name]" -> Select `RNIntercom.xcodeproj` located in `node_modules/react-native-intercom/iOS`.
    1. Open "General Settings" -> "Build Phases" -> "Link Binary with Libraries" and add `libRNIntercom.a`

1. Config for iOS ([intercom-ios](https://github.com/intercom/intercom-ios))

    1. Add `#import "Intercom/intercom.h"` with the other imports at the top of `ios/YOUR_PROJECT/AppDelegate.m`.
    1. Initialize Intercom in `ios/YOUR_PROJECT/AppDelegate.m` with your Intercom iOS API Key and your Intercom App ID:

        ```obj-c
        - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

            // Intercom
            [Intercom setApiKey:@"YOUR_IOS_API_KEY_HERE" forAppId:@"YOUR_APP_ID_HERE"];

        }
        ```

    1. Optional, [Intercom's documentation](https://github.com/intercom/intercom-ios/blob/1fe2e92c4913e4ffef290b5b62dac5ecef74ea1d/Intercom.framework/Versions/A/Headers/Intercom.h#L65) suggests adding the following call in order to receive push notifications for new messages:

        ```obj-c
        - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

            // Intercom
            [Intercom setDeviceToken:deviceToken];

        }
        ```

    1. Optional, [allow access to photos on iOS](https://developers.intercom.com/docs/ios-installation#section-step-2-update-infoplist). Open `Info.plist` in Xcode and add a new key "Privacy - Photo Library Usage Description". Or alternately, open `ios/YOUR_PROJECT/Info.plist` and add:

        ```xml
        <dict>

          ...other configuration here...

          <key>NSPhotoLibraryUsageDescription</key>
          <string>Send photos to help resolve app issues</string>

          ...other configuration here...

        </dict>
        ```

1. Config for Android ([intercom-android](https://github.com/intercom/intercom-android))

    1. In `android/app/src/main/java/com/YOUR_APP/app/MainApplication.java`, add the following code in the respective sections of the file using your Intercom Android API Key and Intercom App ID:

        ```java

        // ...other configuration here...

        import com.robinpowered.react.Intercom.IntercomPackage;
        import io.intercom.android.sdk.Intercom;

        public class MainApplication extends Application {

          @Override
          public void onCreate() {
            super.onCreate();
            Intercom.initialize(this, "YOUR_ANDROID_API_KEY_HERE", "YOUR_APP_ID_HERE");

            // ...other configuration here...

          }

          public List<ReactPackage> getPackages() {
            return Arrays.<ReactPackage>asList(

              // ...other configuration here...

              new IntercomPackage()

              // ...other configuration here...

            );
          }
        }
        ```

    1. In `android/build.gradle` add `maven { url "https://maven.google.com" }` ([h/t](https://github.com/tinycreative/react-native-intercom/issues/153#issuecomment-348602868)):

        ```gradle
        allprojects {
          repositories {

            //...other configuration here...

            maven { url "https://maven.google.com" }
          }
        }
        ```

    1. Decide which type of push messaging you want to install, and add choosen method to `android/app/build.gradle`.

        1. If you'd rather not have push notifications in your app, you can use this dependency:

            ```gradle
            dependencies {
                implementation 'io.intercom.android:intercom-sdk-base:5.+'
            }
            ```

        1. If "Firebase Cloud Messaging(FCM)", then:
            ```gradle
            dependencies {

              //...other configuration here...

              compile 'io.intercom.android:intercom-sdk-fcm:5.+'
            }
            ```

            If you're already using FCM in your application you'll need to extend `FirebaseMessagingService` to handle Intercom's push notifications (refer to [Using Intercom with other FCM setups](https://developers.intercom.com/installing-intercom/docs/android-fcm-push-notifications#section-step-7-using-intercom-with-other-fcm-setups-optional))

            ### Here's an example if you're using [react-native-firebase](https://github.com/invertase/react-native-firebase) as your existing FCM setup:

            I. Add a new file if you don't have one (`android/app/src/main/java/com/YOUR_APP/MainMessagingService.java`)

            ```java
            package com.YOUR_APP;
            import io.invertase.firebase.messaging.*;
            import android.content.Intent;
            import android.content.Context;
            import io.intercom.android.sdk.push.IntercomPushClient;
            import io.invertase.firebase.messaging.RNFirebaseMessagingService;
            import com.google.firebase.messaging.RemoteMessage;
            import android.util.Log;
            import java.util.Map;

            public class MainMessagingService extends RNFirebaseMessagingService {
                private static final String TAG = "MainMessagingService";
                private final IntercomPushClient intercomPushClient = new IntercomPushClient();

                @Override
                public void onMessageReceived(RemoteMessage remoteMessage) {
                    Map message = remoteMessage.getData();

                    if (intercomPushClient.isIntercomPush(message)) {
                        Log.d(TAG, "Intercom message received");
                        intercomPushClient.handlePush(getApplication(), message);
                    } else {
                        super.onMessageReceived(remoteMessage);
                    }
                }
            }
            ```

            II. Then add the following code to `android/app/src/main/AndroidManifest.xml`:
            
            ```xml
            <?xml version="1.0" encoding="utf-8"?>
            <manifest package="com.YOUR_APP"

              ...other configuration here...

            >
              <application

                ...other configuration here...

                xmlns:tools="http://schemas.android.com/tools"
              >

                <!-- ...other configuration here... -->
                <!-- ...ADD THE SERVICE BELOW... -->
                <service
                  android:name=".MainMessagingService"
                  android:enabled="true"
                  android:exported="true">
                    <intent-filter>
                      <action android:name="com.google.firebase.MESSAGING_EVENT" />
                    </intent-filter>
                </service>
              </application>
            </manifest>
            ```

1. Import Intercom and use methods

    ```javascript
    import Intercom from 'react-native-intercom';
    // or…
    // var Intercom = require('react-native-intercom');
    Intercom.registerIdentifiedUser({ userId: 'Bob' });
    Intercom.logEvent('viewed_screen', { extra: 'metadata' });

    //...rest of your file...

    ```

    Note that calling `Intercom.registerIdentifiedUser({ userId: 'Bob' })` (or `Intercom.registerUnidentifiedUser()`) is required before using methods which require that Intercom know the current user… such as `Intercom.displayMessageComposer()`, etc.

# Usage

### Import or Require the module

```javascript
import Intercom from 'react-native-intercom';
```

or

```javascript
var Intercom = require('react-native-intercom');
```

### Log an event
```javascript
Intercom.logEvent('viewed_screen', { extra: 'metadata' });
```

### Register a Logged In user
```javascript
Intercom.registerIdentifiedUser({ userId: 'bob' });
```

### Register Unidentified user
```javascript
Intercom.registerUnidentifiedUser();
```

### Register a Logged In user and post extra metadata
```javascript
Intercom.registerIdentifiedUser({ userId: 'bob' })
Intercom.updateUser({
    // Pre-defined user attributes
    email: 'mimi@intercom.com',
    user_id: 'user_id',
    name: 'your name',
    phone: '010-1234-5678',
    language_override: 'language_override',
    signed_up_at: 1004,
    unsubscribed_from_emails: true,
    companies: [{
        company_id: 'your company id',
        name: 'your company name'
    }],
    custom_attributes: {
        my_custom_attribute: 123
    },
});
```

### Set User Hash for Identity Validation (optional)
```javascript
Intercom.setUserHash(hash_received_from_backend)
```

### Sign Out
```javascript
Intercom.logout()
```

### Show Message Composer
```javascript
Intercom.displayMessageComposer();
```

### Show Message Composer with an Initial Message
```javascript
Intercom.displayMessageComposerWithInitialMessage('Initial Message');
```

### Display Latest Conversation 
```javascript
Intercom.displayMessenger();
```

### Display Conversations List
```javascript
Intercom.displayConversationsList();
```

### Display Help Center
```javascript
Intercom.displayHelpCenter();
```

### Set Bottom Padding
```javascript
Intercom.setBottomPadding(64);
```

### Display Help Center
```javascript
Intercom.displayHelpCenter();
```
Note that before calling `Intercom.displayHelpCenter()` it is required to enable Help Center in your Intercom settings.

### Present a Carousel
```javascript
Intercom.presentCarousel(carouselID);
```
Note that before calling `Intercom.presentCarousel(carouselID)` it is required to enable carousels and create a carousel in your Intercom settings.

### Listen for Unread Conversation Notifications
```javascript
componentDidMount() {
  Intercom.addEventListener(Intercom.Notifications.UNREAD_COUNT, this._onUnreadChange)
}

componentWillUnmount() {
  Intercom.removeEventListener(Intercom.Notifications.UNREAD_COUNT, this._onUnreadChange);
}

_onUnreadChange = ({ count }) => {
  //...
}
```
### Other Notifications
```javascript
    // The window was hidden
    Intercom.Notifications.WINDOW_DID_HIDE

    // The window was shown
    Intercom.Notifications.WINDOW_DID_SHOW
```

### Send FCM token directly to Intercom for push notifications (Android only)
```
Firebase.messaging().getToken()
  .then((token) => {
    console.log('Device FCM Token: ', token);
    Intercom.sendTokenToIntercom(token);
});
```
