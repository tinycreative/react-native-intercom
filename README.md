# react-native-intercom
React Native wrapper for Intercom.io. Based off of [intercom-cordova](https://github.com/intercom/intercom-cordova)

# Installation Guide

1. Add `pod 'Intercom'` to `ios/Podfile` and then run `pod install` in the `ios` directory to install the cocoapod.
2. Open `ios/Podfile` and add `pod 'Intercom'`. It will look something like this:

    ```obj-c
    platform :ios, '9.2'

    target 'YOUR_APP_NAME' do
      # Add Intercom here…
      pod 'Intercom'
    end
    ```

3. In the `ios` directory, run `pod install` to install the cocoapod.
4. Run `npm install react-native-intercom` (or `yarn add react-native-intercom`).
5. Run `react-native link` to link the package.

    This will perform some of the linking of `react-native-intercom`. This includes adding `pod 'react-native-intercom', :path => '../node_modules/react-native-intercom'` to `ios/Podfile`. In the future the `link` command can be added to do more of the steps in this installation guide.

6. Manually Link the library in Xcode ([Linking librarys on iOS](https://facebook.github.io/react-native/docs/linking-libraries-ios.html))

    1. Open Xcode -> Right click "[Your Project Name]/Libraries" folder and select "Add File to [Your Project Name]" -> Select `RNIntercom.xcodeproj` located in `node_modules/react-native-intercom/iOS`.
    2. Open "General Settings" -> "Build Phases" -> "Link Binary with Libraries" and add `libRNIntercom.a`

7. Config for iOS ([intercom-ios](https://github.com/intercom/intercom-ios))

    1. Add `#import "Intercom/intercom.h"` with the other imports at the top of `ios/YOUR_PROJECT/AppDelegate.m`.
    2. Initialize Intercom in `ios/YOUR_PROJECT/AppDelegate.m` with your Intercom iOS API Key and your Intercom App ID:

        ```obj-c
        - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
            // Initialize Intercom
            [Intercom setApiKey:@"YOUR_IOS_API_KEY_HERE" forAppId:@"YOUR_APP_ID_HERE"];
        }
        ```

    3. Optional, [Intercom's documentation](https://github.com/intercom/intercom-ios/blob/1fe2e92c4913e4ffef290b5b62dac5ecef74ea1d/Intercom.framework/Versions/A/Headers/Intercom.h#L65) suggests adding the following call in order to receive push notifications for new messages:

        ```obj-c
        - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
            [Intercom setDeviceToken:deviceToken];
        }
        ```

    4. Optional, [allow access to phots on iOS](https://developers.intercom.com/docs/ios-installation#section-step-2-update-infoplist). Open `Info.plist` in Xcode and add a new key "Privacy - Photo Library Usage Description". Or alternately, open `ios/YOUR_PROJECT/Info.plist` and add:

        ```xml
        <dict>

          ...other configuration here...

          <key>NSPhotoLibraryUsageDescription</key>
          <string>Send photos to help resolve app issues</string>

          ...other configuration here...

        </dict>
        ```

8. Config for Android ([intercom-android](https://github.com/intercom/intercom-android))

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

    2. In `android/app/src/main/AndroidManifest.xml`, add the following code in the respective sections of the file:

        ```xml
        <?xml version="1.0" encoding="utf-8"?>
        <manifest package="com.myapp"

          ...other configuration here...

        >
          <application

            ...other configuration here...

            xmlns:tools="http://schemas.android.com/tools"
          >

            <!-- ...other configuration here... -->

            <service
              android:name="com.robinpowered.react.Intercom.IntercomIntentService"
              android:exported="false">
              <intent-filter
                android:priority="999">
                  <action android:name="com.google.android.c2dm.intent.RECEIVE"/>
              </intent-filter>
            </service>
            <receiver
              android:name="io.intercom.android.sdk.push.IntercomPushBroadcastReceiver"
              tools:replace="android:exported"
              android:exported="true" />
          </application>
        </manifest>
        ```

    3. In `android/build.gradle` add `maven { url "https://maven.google.com" }` ([h/t](https://github.com/tinycreative/react-native-intercom/issues/153#issuecomment-348602868)):

        ```gradle
        allprojects {
          repositories {

            //...other configuration here...

            maven { url "https://maven.google.com" }
          }
        }
        ```

    4. Decide which type of push messaging you want to install, and add choosen method to `android/app/build.gradle`. If "Google Cloud Messaging (GCM)", then:

        ```gradle
        dependencies {

          //...other configuration here...

          compile 'io.intercom.android:intercom-sdk:5.+'
        }
        ```

9. Import Intercom and use methods

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
        // Only supported for iOS now
        // Parameters: IntercomUserAttribtesBuilder.m -> companyForDictionary()
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
Intercom.reset()
```

### Show Message Composer
```javascript
Intercom.displayMessageComposer();
```

### Show Message Composer with an Initial Message
```javascript
Intercom.displayMessageComposerWithInitialMessage('Initial Message');
```

### Set Bottom Padding
```javascript
Intercom.setBottomPadding(64);
```

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

### Send FCM token directly to Intercom
```
Firebase.messaging().getToken()
  .then((token) => {
    console.log('Device FCM Token: ', token);
    Intercom.sendTokenToIntercom(token);
});
```
