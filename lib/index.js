/* @flow */
import { NativeModules } from 'react-native'

const RNASegmentIO = NativeModules.RNASegmentIO || NativeModules.SegmentModule

type GroupId = string
type KeyValueMap = Object
type SetupOptions = $Shape<{
  enableAdvertisingTracking?: boolean,
  flushAt?: number,
  recordScreenViews?: boolean,
  shouldUseBluetooth?: boolean,
  shouldUseLocationServices?: boolean,
  trackApplicationLifecycleEvents?: boolean,
  trackAttributionData?: boolean,
  trackDeepLinks?: boolean,
  debug?: boolean,
}>
type UserId = string

export function setup(key: string, options: SetupOptions = {}) {
  return RNASegmentIO.setup(key, options)
}

export function identify(userId: UserId, traits: KeyValueMap = {}) {
  RNASegmentIO.identify(userId, traits)
}

export function track(event: string, properties: KeyValueMap = {}) {
  RNASegmentIO.track(event, properties)
}

export function screen(name: string, properties: KeyValueMap = {}) {
  RNASegmentIO.screen(name, properties)
}

export function group(groupId: GroupId, traits: KeyValueMap = {}) {
  RNASegmentIO.group(groupId, traits)
}

export function alias(newId: UserId) {
  RNASegmentIO.alias(newId)
}

export function reset() {
  RNASegmentIO.reset()
}

export function flush() {
  RNASegmentIO.flush()
}

export function enable() {
  RNASegmentIO.enable()
}

export function disable() {
  RNASegmentIO.disable()
}

export const AnalyticsConstants: { [key: $Keys<SetupOptions>]: string } = {
  enableAdvertisingTracking: RNASegmentIO.enableAdvertisingTracking,
  flushAt: RNASegmentIO.flushAt,
  recordScreenViews: RNASegmentIO.recordScreenViews,
  shouldUseBluetooth: RNASegmentIO.shouldUseBluetooth,
  shouldUseLocationServices: RNASegmentIO.shouldUseLocationServices,
  trackApplicationLifecycleEvents: RNASegmentIO.trackApplicationLifecycleEvents,
  trackAttributionData: RNASegmentIO.trackAttributionData,
  trackDeepLinks: RNASegmentIO.trackDeepLinks,
  debug: RNASegmentIO.debug,
}
