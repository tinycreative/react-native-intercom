# react-native-intercom
React Native wrapper for Intercom.io. Based off of [intercom-cordova](https://github.com/intercom/intercom-cordova)

Install
=======

1. `npm install react-native-intercom`
2. In XCode, in the project navigator right click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `react-native-intercom`➜ iOS and add `IntercomWrapper.h` and `IntercomWrapper.m` 
4. Add `pod 'Intercom'` to your Podfile and run `pod install`. More instructions here: [Intercom for iOS](https://github.com/intercom/intercom-ios)
5. Initialize Intercom in your `AppDelegate.m`
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Intercom
    [Intercom setApiKey:@"<#ios_sdk-...#>" forAppId:@"<#your-app-id#>"];
}
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