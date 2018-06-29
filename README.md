# react-native-intercom

React Native wrapper for Intercom.io. Based off of [intercom-cordova](https://github.com/intercom/intercom-cordova)

## Install

### IOS

Run `npm install react-native-intercom`
Run `react-native link`

#### CocoaPods

Add the following to your podfile

    pod 'react-native-intercom', :path => '../node_modules/react-native-intercom'

#### Manual

Follow how to manually link a library here [https://facebook.github.io/react-native/docs/linking-libraries-ios.html#content](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#content)

### Android

Run `npm install react-native-intercom`

## Necessary Code Bits

iOS and Android each have their own special API keys. Get them in the intercom app settings, under "installation" in the left hand menu. [Details here](https://developers.intercom.com/docs/ios-installation#section-step-3-initialize-intercom). They provide the snippets mentioned below to be easily pasted into your app.

### IOS

More instructions here: [Intercom for iOS](https://github.com/intercom/intercom-ios)

Initialize Intercom in your `AppDelegate.m`

```
#import "Intercom/intercom.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Intercom
    [Intercom setApiKey:@"ios-api-key-goes-here" forAppId:@"app-id-goes-here"];
}
```

[Intercom's documentation](https://github.com/intercom/intercom-ios/blob/1fe2e92c4913e4ffef290b5b62dac5ecef74ea1d/Intercom.framework/Versions/A/Headers/Intercom.h#L65) suggests adding the following call in order to receive push notifications for new messages:

```
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
     [Intercom setDeviceToken:deviceToken];
}
```

### Android

More instructions here: [Intercom for Android](https://github.com/intercom/intercom-android)

Your Android Application should look like:

```java
// ...
import com.robinpowered.react.Intercom.IntercomPackage;
import io.intercom.android.sdk.Intercom;

public class MainApplication extends Application {

  @Override
  public void onCreate() {
    super.onCreate();
    Intercom.initialize(this, "android-api-key-goes-here", "app-id-goes-here");
    // ...
  }

  public List<ReactPackage> getPackages() {
    return Arrays.<ReactPackage>asList(
        // ...
        new IntercomPackage()
	// ...
    );
  }
}
```

And in your _AndroidManifest.xml_ should look like

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest package="com.myapp"
	  ...
	  ... add the tools namespace if not already present...
          xmlns:tools="http://schemas.android.com/tools"
          ...
    >

  <application
	       ...
	       >

    ...
    ...
    ...

    <!-- Add these lines -->
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

Don't forget the _tools_ namespace `xmlns:tools="http://schemas.android.com/tools"` in your main `<application>` tag

# Methods

### logEvent(eventName, metadata);

Log an event with intercom.

```javascript
Intercom.logEvent('event_name', { any: 'metadata', you: 'want' });
```

### registerIdentifiedUser({ userId })

Register a user with userId

```javascript
Intercom.registerIdentifiedUser({ userId: 'bob' });
```

### registerUnidentifiedUser()

For when a userId is not available or relevant

```javascript
Intercom.registerUnidentifiedUser();
```

### setLauncherVisibility('VISIBLE' | 'HIDDEN');

Show/hide the launcher button (hidden by default).

```javascript
// show
Intercom.setLauncherVisibility('VISIBLE');
// hide
Intercom.setLauncherVisibility('HIDDEN');
```

### setBottomPadding(dpi)

Set the bottom padding for the launcher button

```javascript
Intercom.setBottomPadding(64);
```

### updateUser(userAttributes)

Updates a registered user.

```javascript
Intercom.registerIdentifiedUser({ userId: 'bob' });
Intercom.updateUser({
  // Pre-defined user attributes
  email: 'mimi@intercom.com',
  user_id: 'user_id',
  name: 'your name',
  phone: '010-1234-5678',
  language_override: 'language_override',
  signed_up_at: 1004,
  unsubscribed_from_emails: true,
  companies: [
    {
      // Only supported for iOS now
      // Parameters: IntercomUserAttribtesBuilder.m -> companyForDictionary()
    },
  ],
  custom_attributes: {
    my_custom_attribute: 123,
  },
});
```

### setUserHash(hash)

Set User Hash for Identity Validation (optional)

```javascript
Intercom.setUserHash(hash_received_from_backend);
```

### reset()

Log user out

```javascript
Intercom.reset();
```

### displayMessenger()

Show messenger overlay

```javascript
Intercom.displayMessenger();
```

### displayMessageComposer()

Same as displayMessenger

```javascript
Intercom.displayMessageComposer();
```

### displayMessageComposerWithInitialMessage(message)

Show Message Composer with an Initial Message

```javascript
Intercom.displayMessageComposerWithInitialMessage('Initial message');
```

### hideMessenger()

Hide messenger overlay (works with any of the 3 above)

```javascript
Intercom.hideMessenger();
```

### displayHelpCenter()

Show Help Center

```javascript
Intercom.displayHelpCenter();
```

### displayConversationsList()

Show Conversation List

```javascript
Intercom.displayConversationsList();
```

### setInAppMessageVisibility('GONE' | 'VISIBLE')

If set to 'GONE', hides in app messages

```javascript
// hide in app messages
Intercom.setInAppMessageVisibility('GONE');
// show in app messages
Intercom.setInAppMessageVisibility('VISIBLE');
```

### getUnreadConversationCount()

Get Unread Message Count

```javascript
Intercom.getUnreadConversationCount((err, count) => {
  console.log(`${count} conversations waiting`);
});
```

### addEventListener(Intercom.Notifications.UNREAD_COUNT)

Listen for Unread Conversation Notifications. Example:

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

### removeEventListener(Intercom.Notifications.UNREAD_COUNT)

Removes event listener

### sendTokenToIntercom(token)

Send FCM token directly to Intercom. Does nothing in iOS (that's handled with the setDeviceToken native code in the iOS instructions). Example:

```javascript
Firebase.messaging()
  .getToken()
  .then(token => {
    console.log('Device FCM Token: ', token);
    Intercom.sendTokenToIntercom(token);
  });
```

### setupAPN(deviceToken)

Set up iOS push notifications, passing in the device token.

```javascript
Intercom.setupAPN('my-unique-device-token');
```

### registerForPush()

Register device for push notifications

Set up iOS push notifications, passing in the device token.

```javascript
Intercom.registerForPush();
```
