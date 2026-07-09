#import "CacheManager.h"

@implementation CacheManager

// SwiftPM support currently uses direct AVPlayerItem playback on iOS.
// The CocoaPods-only cache stack still needs a separate SPM migration.

- (void)setup {
}

- (void)setMaxCacheSize:(NSNumber* _Nullable)maxCacheSize {
}

- (void)preCacheURL:(NSURL*)url
           cacheKey:(NSString* _Nullable)cacheKey
     videoExtension:(NSString* _Nullable)videoExtension
        withHeaders:(NSDictionary<NSObject*, NSObject*>*)headers
  completionHandler:(void (^ _Nullable)(BOOL success))completionHandler {
    if (completionHandler) {
        completionHandler(NO);
    }
}

- (void)stopPreCache:(NSURL*)url
            cacheKey:(NSString* _Nullable)cacheKey
   completionHandler:(void (^ _Nullable)(BOOL success))completionHandler {
    if (completionHandler) {
        completionHandler(NO);
    }
}

- (AVPlayerItem*)getCachingPlayerItemForNormalPlayback:(NSURL*)url
                                              cacheKey:(NSString* _Nullable)cacheKey
                                        videoExtension:(NSString* _Nullable)videoExtension
                                               headers:(NSDictionary<NSObject*, NSObject*>*)headers {
    NSMutableDictionary* assetOptions = [NSMutableDictionary dictionary];
    if (headers.count > 0) {
        assetOptions[@"AVURLAssetHTTPHeaderFieldsKey"] = headers;
    }
    AVURLAsset* asset = [AVURLAsset URLAssetWithURL:url options:assetOptions];
    return [AVPlayerItem playerItemWithAsset:asset];
}

- (void)clearCache {
}

- (BOOL)isPreCacheSupportedWithUrl:(NSURL*)url videoExtension:(NSString* _Nullable)videoExtension {
    return NO;
}

@end
