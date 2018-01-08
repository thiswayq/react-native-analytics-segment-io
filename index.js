import { NativeModules } from 'react-native'

const RNASegmentIO = NativeModules.RNASegmentIO || NativeModules.SegmentModule

export default {
  setup: function (key, options = {}) {
    return RNASegmentIO.setup(key, options)
  },

  identify: function (userId, traits = {}, integrations = {}) {
    RNASegmentIO.identify(userId, traits, integrations)
  },

  track: function (event, properties = {}, integrations = {}) {
    RNASegmentIO.track(event, properties, integrations)
  },

  screen: function (name, properties = {},integrations = {}) {
    RNASegmentIO.screen(name, properties, integrations)
  },

  group: function (groupId, traits = {}, integrations = {}) {
    RNASegmentIO.group(groupId, traits, integrations)
  },

  alias: function (newId, integrations = {}) {
    RNASegmentIO.alias(newId, integrations)
  },

  reset: function () {
    RNASegmentIO.reset()
  },

  flush: function () {
    RNASegmentIO.flush()
  },

  enable: function () {
    RNASegmentIO.enable()
  },

  disable: function () {
    RNASegmentIO.disable()
  }
}

export const AnalyticsConstants = {
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
