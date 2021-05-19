/**
 * @class IntercomClient
 */
export declare const Visibility: {
    VISIBLE: string;
    GONE: string;
};
export declare class IntercomClient {
    static Visibility: {
        VISIBLE: string;
        GONE: string;
    };
    Notifications: {
        UNREAD_COUNT: any;
        WINDOW_DID_HIDE: any;
        WINDOW_DID_SHOW: any;
    };
    _eventEmitter: any;
    _eventHandlers: Record<string, any>;
    constructor();
    registerIdentifiedUser(options: any): any;
    sendTokenToIntercom(token: any): any;
    updateUser(options: any): any;
    registerUnidentifiedUser(): any;
    logout(): any;
    logEvent(eventName: any, metaData: any): any;
    handlePushMessage(): any;
    displayMessenger(): any;
    hideMessenger(): any;
    displayMessageComposer(): any;
    displayMessageComposerWithInitialMessage(message: any): any;
    displayConversationsList(): any;
    getUnreadConversationCount(): any;
    displayHelpCenter(): any;
    setLauncherVisibility(visibility: any): any;
    setInAppMessageVisibility(visibility: any): any;
    setupAPN(deviceToken: any): any;
    registerForPush(): any;
    setUserHash(userHash: any): any;
    setBottomPadding(padding: any): any;
    presentCarousel(carousel: any): any;
    presentArticle(articleId: any): any;
    addEventListener(type: any, handler: any): void;
    removeEventListener(type: any, handler: any): void;
}
declare const _default: IntercomClient;
export default _default;
