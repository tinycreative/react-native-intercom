

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
    WINDOW_DID_HIDE: IntercomEventEmitter.WINDOW_DID_HIDE_NOTIFICATION,
    WINDOW_DID_SHOW: IntercomEventEmitter.WINDOW_DID_SHOW_NOTIFICATION
  };

  _eventEmitter;
  _eventHandlers;

  nativeModule = IntercomWrapper;

  constructor() {
    this._eventHandlers = {
      [IntercomEventEmitter.UNREAD_CHANGE_NOTIFICATION]: new Map(),
      [IntercomEventEmitter.WINDOW_DID_HIDE_NOTIFICATION]: new Map(),
      [IntercomEventEmitter.WINDOW_DID_SHOW_NOTIFICATION]: new Map()
    };
  }

  initializeIntercom(apiKey, appId) {
    return this.nativeModule.initializeIntercom(apiKey, appId);
  }

  registerIdentifiedUser(options) {
    return this.nativeModule.registerIdentifiedUser(options);
  }

  sendTokenToIntercom(token) {
    return this.nativeModule.sendTokenToIntercom(token);
  }

  updateUser(options) {
    return this.nativeModule.updateUser(options);
  }

  registerUnidentifiedUser() {
    return this.nativeModule.registerUnidentifiedUser();
  }

  logout() {
    return this.nativeModule.logout();
  }

  logEvent(eventName, metaData) {
    return this.nativeModule.logEvent(eventName, metaData);
  }

  handlePushMessage() {
    return this.nativeModule.handlePushMessage();
  }

  displayMessenger() {
    return this.nativeModule.displayMessenger();
  }

  hideMessenger() {
    return this.nativeModule.hideMessenger();
  }

  displayMessageComposer() {
    return this.nativeModule.displayMessageComposer();
  }

  displayMessageComposerWithInitialMessage(message) {
    return this.nativeModule.displayMessageComposerWithInitialMessage(message);
  }

  displayConversationsList() {
    return this.nativeModule.displayConversationsList();
  }

  getUnreadConversationCount() {
    return this.nativeModule.getUnreadConversationCount();
  }

  displayHelpCenter() {
    return this.nativeModule.displayHelpCenter();
  }

  setLauncherVisibility(visibility: String) {
    return this.nativeModule.setLauncherVisibility(visibility);
  }

  setInAppMessageVisibility(visibility: String) {
    return this.nativeModule.setInAppMessageVisibility(visibility);
  }

  setupAPN(deviceToken) {
    return this.nativeModule.setupAPN(deviceToken);
  }

  registerForPush() {
    return this.nativeModule.registerForPush();
  }

  setUserHash(userHash) {
    return this.nativeModule.setUserHash(userHash);
  }

  setBottomPadding(padding) {
    return this.nativeModule.setBottomPadding(padding);
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
}

module.exports = new IntercomClient();
