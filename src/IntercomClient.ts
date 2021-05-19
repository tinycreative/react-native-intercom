import { NativeModules, NativeEventEmitter } from "react-native";

const { IntercomWrapper, IntercomEventEmitter } = NativeModules;

/**
 * @class IntercomClient
 */

export const Visibility = {
  VISIBLE: "VISIBLE",
  GONE: "GONE",
};

export class IntercomClient {
  static Visibility = Visibility;

  Notifications = {
    UNREAD_COUNT: IntercomEventEmitter.UNREAD_CHANGE_NOTIFICATION,
    WINDOW_DID_HIDE: IntercomEventEmitter.WINDOW_DID_HIDE_NOTIFICATION,
    WINDOW_DID_SHOW: IntercomEventEmitter.WINDOW_DID_SHOW_NOTIFICATION,
  };

  _eventEmitter: any;
  _eventHandlers: Record<string, any>;

  constructor() {
    this._eventHandlers = {
      [IntercomEventEmitter.UNREAD_CHANGE_NOTIFICATION]: new Map(),
      [IntercomEventEmitter.WINDOW_DID_HIDE_NOTIFICATION]: new Map(),
      [IntercomEventEmitter.WINDOW_DID_SHOW_NOTIFICATION]: new Map(),
    };
  }

  registerIdentifiedUser(options: any) {
    return IntercomWrapper.registerIdentifiedUser(options);
  }

  sendTokenToIntercom(token: any) {
    return IntercomWrapper.sendTokenToIntercom(token);
  }

  updateUser(options: any) {
    return IntercomWrapper.updateUser(options);
  }

  registerUnidentifiedUser() {
    return IntercomWrapper.registerUnidentifiedUser();
  }

  logout() {
    return IntercomWrapper.logout();
  }

  logEvent(eventName: any, metaData: any) {
    return IntercomWrapper.logEvent(eventName, metaData);
  }

  handlePushMessage() {
    return IntercomWrapper.handlePushMessage();
  }

  displayMessenger() {
    return IntercomWrapper.displayMessenger();
  }

  hideMessenger() {
    return IntercomWrapper.hideMessenger();
  }

  displayMessageComposer() {
    return IntercomWrapper.displayMessageComposer();
  }

  displayMessageComposerWithInitialMessage(message: any) {
    return IntercomWrapper.displayMessageComposerWithInitialMessage(message);
  }

  displayConversationsList() {
    return IntercomWrapper.displayConversationsList();
  }

  getUnreadConversationCount() {
    return IntercomWrapper.getUnreadConversationCount();
  }

  displayHelpCenter() {
    return IntercomWrapper.displayHelpCenter();
  }

  setLauncherVisibility(visibility: any) {
    return IntercomWrapper.setLauncherVisibility(visibility);
  }

  setInAppMessageVisibility(visibility: any) {
    return IntercomWrapper.setInAppMessageVisibility(visibility);
  }

  setupAPN(deviceToken: any) {
    return IntercomWrapper.setupAPN(deviceToken);
  }

  registerForPush() {
    return IntercomWrapper.registerForPush();
  }

  setUserHash(userHash: any) {
    return IntercomWrapper.setUserHash(userHash);
  }

  setBottomPadding(padding: any) {
    return IntercomWrapper.setBottomPadding(padding);
  }

  presentCarousel(carousel: any) {
    return IntercomWrapper.presentCarousel(carousel);
  }

  presentArticle(articleId: any) {
    return IntercomWrapper.presentArticle(articleId);
  }

  addEventListener(type: any, handler: any) {
    if (!this._eventEmitter) {
      this._eventEmitter = new NativeEventEmitter(IntercomEventEmitter);
    }

    const listener = this._eventEmitter.addListener(type, (rtn: any) =>
      handler(rtn)
    );
    this._eventHandlers[type].set(handler, listener);
  }

  removeEventListener(type: any, handler: any) {
    if (!this._eventHandlers[type].has(handler)) {
      return;
    }
    this._eventHandlers[type].get(handler).remove();
    this._eventHandlers[type].delete(handler);
  }
}

export default new IntercomClient();
