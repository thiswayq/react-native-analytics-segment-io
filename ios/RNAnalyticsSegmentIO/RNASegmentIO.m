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

    [SEGAnalytics setupWithConfiguration:config];

    value = options[kSEGDebugKey];
    if (value != nil) {
        [SEGAnalytics debug:[RCTConvert BOOL:value]];
    }

    resolve(@(YES));
}

RCT_EXPORT_METHOD(identify:(NSString *)userId :(NSDictionary *)traits resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] identify:userId traits:traits];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
}

RCT_EXPORT_METHOD(track:(NSString *)event properties:(NSDictionary *)properties resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] track:event properties:properties];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
    
}

RCT_EXPORT_METHOD(screen:(NSString *)name :(NSDictionary *)properties resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] screen:name properties:properties];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
}

RCT_EXPORT_METHOD(group:(NSString *)groupId :(NSDictionary *)traits resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] group:groupId traits:traits];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
}

RCT_EXPORT_METHOD(alias:(NSString *)newId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] alias:newId];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
}

RCT_EXPORT_METHOD(reset:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] reset];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
}

RCT_EXPORT_METHOD(flush:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] flush];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
}

RCT_EXPORT_METHOD(enable:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] enable];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
}

RCT_EXPORT_METHOD(disable:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        [[SEGAnalytics sharedAnalytics] disable];
        resolve(@YES);
    } @catch (NSException *e) {
        reject(e.name, e.reason, nil);
    }
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

@end
