"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.IntercomClient = exports.Visibility = void 0;
const react_native_1 = require("react-native");
const { IntercomWrapper, IntercomEventEmitter } = react_native_1.NativeModules;
/**
 * @class IntercomClient
 */
exports.Visibility = {
    VISIBLE: "VISIBLE",
    GONE: "GONE",
};
class IntercomClient {
    constructor() {
        this.Notifications = {
            UNREAD_COUNT: IntercomEventEmitter.UNREAD_CHANGE_NOTIFICATION,
            WINDOW_DID_HIDE: IntercomEventEmitter.WINDOW_DID_HIDE_NOTIFICATION,
            WINDOW_DID_SHOW: IntercomEventEmitter.WINDOW_DID_SHOW_NOTIFICATION,
        };
        this._eventHandlers = {
            [IntercomEventEmitter.UNREAD_CHANGE_NOTIFICATION]: new Map(),
            [IntercomEventEmitter.WINDOW_DID_HIDE_NOTIFICATION]: new Map(),
            [IntercomEventEmitter.WINDOW_DID_SHOW_NOTIFICATION]: new Map(),
        };
    }
    registerIdentifiedUser(options) {
        return IntercomWrapper.registerIdentifiedUser(options);
    }
    sendTokenToIntercom(token) {
        return IntercomWrapper.sendTokenToIntercom(token);
    }
    updateUser(options) {
        return IntercomWrapper.updateUser(options);
    }
    registerUnidentifiedUser() {
        return IntercomWrapper.registerUnidentifiedUser();
    }
    logout() {
        return IntercomWrapper.logout();
    }
    logEvent(eventName, metaData) {
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
    displayMessageComposerWithInitialMessage(message) {
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
    setLauncherVisibility(visibility) {
        return IntercomWrapper.setLauncherVisibility(visibility);
    }
    setInAppMessageVisibility(visibility) {
        return IntercomWrapper.setInAppMessageVisibility(visibility);
    }
    setupAPN(deviceToken) {
        return IntercomWrapper.setupAPN(deviceToken);
    }
    registerForPush() {
        return IntercomWrapper.registerForPush();
    }
    setUserHash(userHash) {
        return IntercomWrapper.setUserHash(userHash);
    }
    setBottomPadding(padding) {
        return IntercomWrapper.setBottomPadding(padding);
    }
    presentCarousel(carousel) {
        return IntercomWrapper.presentCarousel(carousel);
    }
    presentArticle(articleId) {
        return IntercomWrapper.presentArticle(articleId);
    }
    addEventListener(type, handler) {
        if (!this._eventEmitter) {
            this._eventEmitter = new react_native_1.NativeEventEmitter(IntercomEventEmitter);
        }
        const listener = this._eventEmitter.addListener(type, (rtn) => handler(rtn));
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
exports.IntercomClient = IntercomClient;
IntercomClient.Visibility = exports.Visibility;
exports.default = new IntercomClient();
