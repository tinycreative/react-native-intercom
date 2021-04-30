interface IVisibility {
  GONE: 'GONE';
  VISIBLE: 'VISIBLE';
}
declare const Visibility: IVisibility;
type VisibilityType = IVisibility[keyof IVisibility];

interface INotifications {
  UNREAD_COUNT: 'UNREAD_CHANGE_NOTIFICATION';
  WINDOW_DID_SHOW: 'WINDOW_DID_SHOW';
  WINDOW_DID_HIDE: 'WINDOW_DID_HIDE';
}
declare const Notifications: INotifications;

/**
 * sendTokenToIntercom
 * @param token
 */
export function sendTokenToIntercom(token: any): Promise<void>;

/**
 * presentCarousel
 * @param token
 */
export function presentCarousel(carouselID: String): Promise<void>;

/**
 * registerUnidentifiedUser
 * @returns {Promise<void>}
 */
export function registerUnidentifiedUser(): Promise<void>;

/**
 * updateUser
 * @param { email?: string,user_id?: string, name?: string, phone?: string, language_override?: string, signed_up_at?: number, unsubscribed_from_emails?: boolean, companies?: Array<{company_id?: string, name?: string, created_at?: number, monthly_spend?: number, plan?: string, custom_attributes?: { [key: string]: string } }>, custom_attributes?: { [key: string]: string } } attributes
 * @returns {Promise<void>}
 */
export function updateUser(attributes: {
  email?: string;
  user_id?: string;
  name?: string;
  phone?: string;
  language_override?: string;
  signed_up_at?: number;
  unsubscribed_from_emails?: boolean;
  companies?: Array<{
    company_id?: string;
    name?: string;
    created_at?: number;
    monthly_spend?: number;
    plan?: string;
    custom_attributes?: { [key: string]: string };
  }>;
  custom_attributes?: { [key: string]: string };
}): Promise<void>;

/**
 * registerIdentifiedUser
 * @param {userId: string} | {email: string} options
 * @returns {Promise<void>}
 */
export function registerIdentifiedUser(options: { userId: string } | { email: string }): Promise<void>;

/**
 * logout
 * @returns {Promise<void>}
 */
export function logout(): Promise<void>;

/**
 * Log an event
 * @param {string} eventName
 * @param {[key: string]: string | number | boolean } metadata
 */
export function logEvent(eventName: string, metadata: { [key: string]: string | number | boolean }): Promise<void>;

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
export function getUnreadConversationCount(): Promise<number>;

/**
 * displayHelpCenter
 * @returns {Promise<void>}
 */
export function displayHelpCenter(): Promise<void>;

/**
 * setLauncherVisibility
 * @param {string} visibility
 * @returns {Promise<void>}
 */
export function setLauncherVisibility(visibility: VisibilityType): Promise<void>;

/**
 * setLauncherVisibility
 * @param {string} visibility
 * @returns {Promise<void>}
 */
export function setInAppMessageVisibility(visibility: VisibilityType): Promise<void>;

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
export function addEventListener(type: string, handler: (event?: any) => void): void;

/**
 * removeEventListener
 * @param {string} type
 * @param {() => void} handler
 */
export function removeEventListener(type: string, handler: (event?: any) => void): void;

/**
 * To enable iOS push notifications, simply call the following anywhere in your code:
 */
export function registerForPush(): Promise<void>;
