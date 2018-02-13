

import { NativeModules, NativeEventEmitter } from 'react-native';

const { IntercomWrapper, IntercomEventEmitter } = NativeModules;

/**
 * @class IntercomClient
 */

class IntercomClient {
  static Visibility = {
    VISIBLE: 'VISIBLE',
    GONE: 'GONE',
  };

  Notifications = {
    UNREAD_COUNT: IntercomEventEmitter.UNREAD_CHANGE_NOTIFICATION,
  };

  _eventEmitter;
  _eventHandlers;

  _promiseChain;

  constructor() {
    this._eventHandlers = {
      [IntercomEventEmitter.UNREAD_CHANGE_NOTIFICATION]: new Map(),
    };

    // the first item in the chain needs to be a succesfull promise
    // so once new promises are added, they are automatically called
    this._promiseChain = Promise.resolve();
  }

  registerIdentifiedUser(options) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.registerIdentifiedUser(options, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  sendTokenToIntercom(token) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.sendTokenToIntercom(token, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  updateUser(options) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.updateUser(options, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  registerUnidentifiedUser() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.registerUnidentifiedUser((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  reset() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.reset((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  logEvent(eventName, metaData) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.logEvent(eventName, metaData, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  handlePushMessage() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.handlePushMessage((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  displayMessenger() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.displayMessenger((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  hideMessenger() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.hideMessenger((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  displayMessageComposer() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.displayMessageComposer((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  displayMessageComposerWithInitialMessage(message) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.displayMessageComposerWithInitialMessage(message, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  displayConversationsList() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.displayConversationsList((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  getUnreadConversationCount() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.getUnreadConversationCount((error, count) => {
            if (error) {
              reject(error);
            } else {
              resolve(count);
            }
          });
        }),
    );
  }

  displayHelpCenter() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.displayHelpCenter((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  setLauncherVisibility(visibility: String) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.setLauncherVisibility(visibility, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  setInAppMessageVisibility(visibility: String) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.setInAppMessageVisibility(visibility, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  setupAPN(deviceToken) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.setupAPN(deviceToken, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  registerForPush() {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.registerForPush((error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  setUserHash(userHash) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.setUserHash(userHash, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  setBottomPadding(padding) {
    return this._pushIntercomChain(
      () =>
        new Promise((resolve, reject) => {
          IntercomWrapper.setBottomPadding(padding, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        }),
    );
  }

  addEventListener(type, handler) {
    if (!this._eventEmitter) {
      this._eventEmitter = new NativeEventEmitter(IntercomEventEmitter);
    }

    const listener = this._eventEmitter.addListener(type, rtn => handler(rtn));
    this._eventHandlers[type].set(handler, listener);
  }

  removeEventListener(type, handler) {
    if (!this._eventHandlers[type].has(handler)) {
      return;
    }
    this._eventHandlers[type].get(handler).remove();
    this._eventHandlers[type].delete(handler);
  }

  //
  // since Intercom calls send data to the server each time, we need to make sure they are properly chained
  // as it was intended when calling the functions. It solves the following error found in logs
  // E/Intercom: You cannot update the email of an anonymous user. Please call registerIdentified user instead. The email: _____ was NOT applied
  // even though registerIdentifiedUser was called before
  //
  _pushIntercomChain(call) {
    // add to the promise chain
    return this._promiseChain.then(call).catch((err) => {
      // log the error
      console.log('Intercom React Native Error', err);

      // but do not block the rest of the chain
      Promise.resolve();
    });
  }
}

module.exports = new IntercomClient();
