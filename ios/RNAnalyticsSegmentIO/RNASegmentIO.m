//
//  RNASegmentIO.m
//  RNAnalyticsSegmentIO
//
//  Copyright © 2017 LEO Pharma A/S. All rights reserved.
//

#if __has_include(<Analytics/SEGAnalytics.h>)
#import <Analytics/SEGAnalytics.h>
#elif __has_include("SEGAnalytics.h")
#import "SEGAnalytics.h"
#else
#import "Analytics/SEGAnalytics.h"
#endif

#if __has_include(<React/RCTConvert.h>)
#import <React/RCTConvert.h>
#elif __has_include("RCTConvert.h")
#import "RCTConvert.h"
#else
#import "React/RCTConvert.h"
#endif

#import "RNASegmentIO.h"
#import "RNAIntegrations.h"

static NSString * const kSEGEnableAdvertisingTrackingKey = @"enableAdvertisingTracking";
static NSString * const kSEGFlushAtKey = @"flushAt";
static NSString * const kSEGRecordScreenViewsKey = @"recordScreenViews";
static NSString * const kSEGShouldUseBluetoothKey = @"shouldUseBluetooth";
static NSString * const kSEGShouldUseLocationServicesKey = @"shouldUseLocationServices";
static NSString * const kSEGTrackApplicationLifecycleEventsKey = @"trackApplicationLifecycleEvents";
static NSString * const kSEGTrackAttributionDataKey = @"trackAttributionData";
static NSString * const kSEGTrackDeepLinksKey = @"trackDeepLinks";
static NSString * const kSEGDebugKey = @"debug";

static NSString * const kSEGContextKey = @"context";
static NSString * const kSEGIntegrationsKey = @"integrations";

@implementation RNASegmentIO

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setup:(NSString *)key
                  options:(NSDictionary *)options
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    SEGAnalyticsConfiguration *config = [SEGAnalyticsConfiguration configurationWithWriteKey:key];

    id value = options[kSEGEnableAdvertisingTrackingKey];
    if (value != nil) {
        config.enableAdvertisingTracking = [RCTConvert BOOL:value];
    }

    value = options[kSEGFlushAtKey];
    if (value != nil) {
        config.flushAt = [RCTConvert NSUInteger:value];
    }

    value = options[kSEGRecordScreenViewsKey];
    if (value != nil) {
        config.recordScreenViews = [RCTConvert BOOL:value];
    }

    value = options[kSEGShouldUseBluetoothKey];
    if (value != nil) {
        config.shouldUseBluetooth = [RCTConvert BOOL:value];
    }

    value = options[kSEGShouldUseLocationServicesKey];
    if (value != nil) {
        config.shouldUseLocationServices = [RCTConvert BOOL:value];
    }

    value = options[kSEGTrackApplicationLifecycleEventsKey];
    if (value != nil) {
        config.trackApplicationLifecycleEvents = [RCTConvert BOOL:value];
    }

    value = options[kSEGTrackAttributionDataKey];
    if (value != nil) {
        config.trackAttributionData = [RCTConvert BOOL:value];
    }

    value = options[kSEGTrackDeepLinksKey];
    if (value != nil) {
        config.trackDeepLinks = [RCTConvert BOOL:value];
    }

#ifdef SEGTaplyticsIntegrationFactoryImported
    [config use:[SEGTaplyticsIntegrationFactory instance]];
#endif

#ifdef SEGAdjustIntegrationFactoryImported
    [config use:[SEGAdjustIntegrationFactory instance]];
#endif

#ifdef SEGGoogleAnalyticsIntegrationFactoryImported
    [config use:[SEGGoogleAnalyticsIntegrationFactory instance]];
#endif

#ifdef SEGComScoreIntegrationFactoryImported
    [config use:[SEGComScoreIntegrationFactory instance]];
#endif

#ifdef SEGAmplitudeIntegrationFactoryImported
    [config use:[SEGAmplitudeIntegrationFactory instance]];
#endif

#ifdef SEGFacebookAppEventsIntegrationFactoryImported
    [config use:[SEGFacebookAppEventsIntegrationFactory instance]];
#endif

#ifdef SEGMixpanelIntegrationFactoryImported
    [config use:[SEGMixpanelIntegrationFactory instance]];
#endif

#ifdef SEGLocalyticsIntegrationFactoryImported
    [config use:[SEGLocalyticsIntegrationFactory instance]];
#endif

#ifdef SEGFlurryIntegrationFactoryImported
    [config use:[SEGFlurryIntegrationFactory instance]];
#endif

#ifdef SEGQuantcastIntegrationFactoryImported
    [config use:[SEGQuantcastIntegrationFactory instance]];
#endif

#ifdef SEGCrittercismIntegrationFactoryImported
    [config use:[SEGCrittercismIntegrationFactory instance]];
#endif

#ifdef SEGFirebaseIntegrationFactoryImported
    [config use:[SEGFirebaseIntegrationFactory instance]];
#endif

#ifdef SEGAppsFlyerIntegrationFactoryImported
    [config use:[SEGAppsFlyerIntegrationFactory instance]];
#endif

#ifdef BNCBranchIntegrationFactoryImported
    [config use:[BNCBranchIntegrationFactory instance]];
#endif

#ifdef SEGAppboyIntegrationFactoryImported
    [config use:[SEGAppboyIntegrationFactory instance]];
#endif

#ifdef SEGIntercomIntegrationFactoryImported
    [config use:[SEGIntercomIntegrationFactory instance]];
#endif

    [SEGAnalytics setupWithConfiguration:config];

    value = options[kSEGDebugKey];
    if (value != nil) {
        [SEGAnalytics debug:[RCTConvert BOOL:value]];
    }

    resolve(@(YES));
}

RCT_EXPORT_METHOD(identify:(NSString *)userId traits:(NSDictionary *)traits integrations:(NSDictionary *)integrations)
{
    NSDictionary *options = [RNASegmentIO optionsWithContext:nil integrations:integrations];
    [[SEGAnalytics sharedAnalytics] identify:userId traits:traits options:options;
}

RCT_EXPORT_METHOD(track:(NSString *)event properties:(NSDictionary *)properties integrations:(NSDictionary *)integrations)
{
    NSDictionary *options = [RNASegmentIO optionsWithContext:nil integrations:integrations];
    [[SEGAnalytics sharedAnalytics] track:event properties:properties options:options];
}

RCT_EXPORT_METHOD(screen:(NSString *)name properties:(NSDictionary *)properties integrations:(NSDictionary *)integrations)
{
    NSDictionary *options = [RNASegmentIO optionsWithContext:nil integrations:integrations];
    [[SEGAnalytics sharedAnalytics] screen:name properties:properties options:options];
}

RCT_EXPORT_METHOD(group:(NSString *)groupId traits:(NSDictionary *)traits integrations:(NSDictionary *)integrations)
{
    NSDictionary *options = [RNASegmentIO optionsWithContext:nil integrations:integrations];
    [[SEGAnalytics sharedAnalytics] group:groupId traits:traits options:options];
}

RCT_EXPORT_METHOD(alias:(NSString *)newId integrations:(NSDictionary *)integrations)
{
    NSDictionary *options = [RNASegmentIO optionsWithContext:nil integrations:integrations];
    [[SEGAnalytics sharedAnalytics] alias:newId options:options];
}

RCT_EXPORT_METHOD(reset)
{
    [[SEGAnalytics sharedAnalytics] reset];
}

RCT_EXPORT_METHOD(flush)
{
    [[SEGAnalytics sharedAnalytics] flush];
}

RCT_EXPORT_METHOD(enable)
{
    [[SEGAnalytics sharedAnalytics] enable];
}

RCT_EXPORT_METHOD(disable)
{
    [[SEGAnalytics sharedAnalytics] disable];
}

- (NSDictionary<NSString *, id> *)constantsToExport {
    return @{
        kSEGEnableAdvertisingTrackingKey: kSEGEnableAdvertisingTrackingKey,
        kSEGFlushAtKey: kSEGFlushAtKey,
        kSEGRecordScreenViewsKey: kSEGRecordScreenViewsKey,
        kSEGShouldUseBluetoothKey: kSEGShouldUseBluetoothKey,
        kSEGShouldUseLocationServicesKey: kSEGShouldUseLocationServicesKey,
        kSEGTrackApplicationLifecycleEventsKey: kSEGTrackApplicationLifecycleEventsKey,
        kSEGTrackAttributionDataKey: kSEGTrackAttributionDataKey,
        kSEGTrackDeepLinksKey: kSEGTrackDeepLinksKey,
        kSEGDebugKey: kSEGDebugKey,
    };
}

+ (NSDictionary *)optionsWithContext:(NSDictionary *)context integrations:(NSDictionary *)integrations {
    NSMutableDictionary *options = [NSMutableDictionary new];
    if (context != nil) {
      options[kSEGContextKey] = context;
    }
    if (integrations != nil) {
      options[kSEGIntegrationsKey] = integrations;
    }

    return [options copy];
}

@end
