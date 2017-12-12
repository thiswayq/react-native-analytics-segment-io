import { NativeModules } from 'react-native'

const RNASegmentIO = NativeModules.RNASegmentIO || NativeModules.SegmentModule

export default {
  setup: function (key, options = {}) {
    return RNASegmentIO.setup(key, options)
  },

  identify: function (userId, traits = {}) {
    return RNASegmentIO.identify(userId, traits)
  },

  track: function (event, properties = {}) {
    return RNASegmentIO.track(event, properties)
  },

  screen: function (name, properties = {}) {
    return RNASegmentIO.screen(name, properties)
  },

  group: function (groupId, traits = {}) {
    return RNASegmentIO.group(groupId, traits)
  },

  alias: function (newId) {
    return RNASegmentIO.alias(newId)
  },

  reset: function () {
    return RNASegmentIO.reset()
  },

  flush: function () {
    return RNASegmentIO.flush()
  },

  enable: function () {
    return RNASegmentIO.enable()
  },

  disable: function () {
    return RNASegmentIO.disable()
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
