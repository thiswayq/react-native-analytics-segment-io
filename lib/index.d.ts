declare module 'react-native-analytics-segment-io' {

    export enum AnalyticsConstants {
        enableAdvertisingTracking       = 'enableAdvertisingTracking',
        flushAt                         = 'flushAt',
        recordScreenViews               = 'recordScreenViews',
        shouldUseBluetooth              = 'shouldUseBluetooth',
        shouldUseLocationServices       = 'shouldUseLocationServices',
        trackApplicationLifecycleEvents = 'trackApplicationLifecycleEvents',
        trackAttributionData            = 'trackAttributionData',
        trackDeepLinks                  = 'trackDeepLinks',
        debug                           = 'debug',
    }

    /**
     * Initialize Segment with the write key
     * @param {string} key The writable key for segment
     * @param {{string: any}} options Parameters to initalize segment with, see AnalyticsConstants
     * @return {Promise} Returns true when initialization has started
     */
    export function setup(key: string, options: any ) : Promise<boolean>;

   /**
     * Identify the current user
     * @param {string} userID UserID
     * @param {{string: any}} traits Traits identifying the user
    */
    export function identify(userId: string, traits: any): void;

   /**
     * Track an event
     * @param {string} event Event Name
     * @param {{string: any}} properties Properties for the current event
    */
   export function track(event: string, properties: any): void;

    /**
     * Track a screen change event
     * @param {string} name Name of the screen
     * @param {{string: any}} properties Properties for the current screen
    */
   export function screen(name: string, properties: any): void;

    /**
     * Track a group
     * @param {string} groupID ID of the current users group
     * @param {{string: any}} traits Traits for this group
    */
   export function group(groupID: string, traits: any): void;

   /**
     * Set an alias for the user
     * @param {string} alias Alias of the user
    */
   export function alias(alias: string): void;

   /**
     * Reset internal current Segment cache
     * Useful to call during login/logout operations after calling flush
    */
   export function reset(): void;

   /**
     * Flush all segment data to server.
     * Note: By default segment caches 20 events before sending data to server
    */
   export function flush(): void;

   /**
     * Enable tracking for this user
     * This function allows users to opt-in/opt-out of analytics tracking
    */
   export function enable(): void;

    /**
     * Disable tracking for this user
     * This function allows users to opt-in/opt-out of analytics tracking
    */
   export function disable(): void;
}
