export type Visibility = 'GONE' | 'VISIBLE';
export type Notifications = 'UNREAD_CHANGE_NOTIFICATION';

/**
 * sendTokenToIntercom
 * @param token
 */
export function sendTokenToIntercom(token: any): Promise<void>;

/**
 * registerUnidentifiedUser
 * @returns {Promise<void>}
 */
export function registerUnidentifiedUser(): Promise<void>;

/**
 * We can basically pass any people attributes that exist in intercom. But right now we type specifically the ones
 * we use.
 * @param {email: string, name: string} attributes
 * @returns {Promise<void>}
 */
export function updateUser(attributes: { email: string, name: string }): Promise<void>;

/**
 * registerIdentifiedUser
 * @param {{userId: string}} options
 * @returns {Promise<void>}
 */
export function registerIdentifiedUser(options: { userId: string }): Promise<void>;

/**
 * reset
 * @returns {Promise<void>}
 */
export function reset(): Promise<void>;

/**
 * Log an event
 * @param {string} eventName
 * @param {[key: string]: string} metadata
 */
export function logEvent(eventName: string, metadata: { [key: string]: string }): Promise<void>;

/**
 * handlePushMessage
 * @returns {Promise<void>}
 */
export function handlePushMessage(): Promise<void>;

/**
 * displayMessenger
 * @returns {Promise<void>}
 */
export function displayMessenger(): Promise<void>;

/**
 * hideMessenger
 * @returns {Promise<void>}
 */
export function hideMessenger(): Promise<void>;

/**
 * Show Message Composer
 */
export function displayMessageComposer(): Promise<void>;

/**
 * displayMessageComposerWithInitialMessage
 * @param {string} message
 * @returns {Promise<void>}
 */
export function displayMessageComposerWithInitialMessage(message: string): Promise<void>;

/**
 * displayConversationsList
 * @returns {Promise<void>}
 */
export function displayConversationsList(): Promise<void>;

/**
 * getUnreadConversationCount
 * @returns {Promise<void>}
 */
export function getUnreadConversationCount(): Promise<void>;

/**
 * setLauncherVisibility
 * @param {string} visibility
 * @returns {Promise<void>}
 */
export function setLauncherVisibility(visibility: Visibility): Promise<void>;

/**
 * setLauncherVisibility
 * @param {string} visibility
 * @returns {Promise<void>}
 */
export function setInAppMessageVisibility(visibility: Visibility): Promise<void>;

/**
 * setupAPN
 * @param {string} deviceToken
 * @returns {Promise<void>}
 */
export function setupAPN(deviceToken: string): Promise<void>;

/**
 * setUserHash
 * @param {string} userHash
 * @returns {Promise<void>}
 */
export function setUserHash(userHash: string): Promise<void>;

/**
 * setBottomPadding
 * @param {number} padding
 * @returns {Promise<void>}
 */
export function setBottomPadding(padding: number): Promise<void>;

/**
 * addEventListener
 * @param {string} type
 * @param {() => void} handler
 */
export function addEventListener(type: string, handler: () => void): void;

/**
 * removeEventListener
 * @param {string} type
 * @param {() => void} handler
 */
export function removeEventListener(type: string, handler: () => void): void;

/**
 * To enable iOS push notifications, simply call the following anywhere in your code:
 */
export function registerForPush(): Promise<void>;