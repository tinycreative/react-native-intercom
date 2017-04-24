# react-native-intercom
React Native wrapper for Intercom.io. Based off of [intercom-cordova](https://github.com/intercom/intercom-cordova)

## Install


### IOS

1. `npm install react-native-intercom`

#### RNPM

Run `rnpm link`

#### CocoaPods

Add the following to your podfile

    pod 'react-native-intercom', :path => '../node_modules/react-native-intercom'

#### Manual

Follow how to manually link a library here [https://facebook.github.io/react-native/docs/linking-libraries-ios.html#content](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#content)

### Android

Run `rnpm link`



## Necessary Code Bits

### IOS

More instructions here: [Intercom for iOS](https://github.com/intercom/intercom-ios)
 
Initialize Intercom in your `AppDelegate.m`
```
#import "Intercom/intercom.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Intercom
    [Intercom setApiKey:@"<#ios_sdk-...#>" forAppId:@"<#your-app-id#>"];
}
```
6. [Intercom's documentation](https://github.com/intercom/intercom-ios/blob/1fe2e92c4913e4ffef290b5b62dac5ecef74ea1d/Intercom.framework/Versions/A/Headers/Intercom.h#L65) suggests adding the following call in order to receive push notifications for new messages:
```
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
     [Intercom setDeviceToken:deviceToken];
}
```

### Android

More instructions here: [Intercom for Android](https://github.com/intercom/intercom-android)

```
Intercom.initialize(getApplicationContext(), "your api key", "your app id");
```

And in your *AndroidManifest.xml* file add the following lines within the `<application> ... </application>` tags
```xml
<service
     android:name="com.robinpowered.react.Intercom.IntercomIntentService"
     android:exported="false">
     <intent-filter
        android:priority="999">
        <action android:name="com.google.android.c2dm.intent.RECEIVE"/>
    </intent-filter>
 </service>
```


Usage
=====
### Require the module
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

### Register a Logged In user and post extra metadata
```javascript
Intercom.registerIdentifiedUser({ userId: 'bob' })
.then(() => {
	console.log('registerIdentifiedUser done');

	return Intercom.updateUser({
		email: 'email',
		name: 'name',
	});
})
.catch((err) => {
	console.log('registerIdentifiedUser ERROR', err);
});
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
