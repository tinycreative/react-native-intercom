//
//Thanks to https://github.com/intercom/intercom-cordova/blob/master/src/android/IntercomIntentService.java
//
package com.robinpowered.react.Intercom;

import android.app.IntentService;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ResolveInfo;

import java.util.List;

import io.intercom.android.sdk.push.IntercomPushClient;

public class IntercomIntentService extends IntentService {
    private final IntercomPushClient intercomPushClient = new IntercomPushClient();

    public IntercomIntentService() {
        super("Intercom React Native Intent Service");
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        if (intercomPushClient.isIntercomPush(intent.getExtras())) {
            intercomPushClient.handlePush(getApplication(), intent.getExtras());
            return;
        }

        Intent passThroughIntent = new Intent(intent);
        passThroughIntent.setComponent(null);

        List<ResolveInfo> services = getPackageManager().queryIntentServices(passThroughIntent, 0);
        for (ResolveInfo info : services) {
            try {
                Class serviceClass = Class.forName(info.serviceInfo.name);
                if (serviceClass == this.getClass()) {
                    continue;
                }

                Context applicationContext = getApplicationContext();
                passThroughIntent.setClass(applicationContext, serviceClass);
                applicationContext.startService(passThroughIntent);
                return;
            } catch (ClassNotFoundException e) {
                // Class not found. Try the next service
            }
        }
    }
}