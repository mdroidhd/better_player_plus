#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheManager : NSObject
- (void)setup;
- (void)setMaxCacheSize:(NSNumber* _Nullable)maxCacheSize;
- (void)preCacheURL:(NSURL*)url
           cacheKey:(NSString* _Nullable)cacheKey
     videoExtension:(NSString* _Nullable)videoExtension
        withHeaders:(NSDictionary<NSObject*, NSObject*>*)headers
  completionHandler:(void (^ _Nullable)(BOOL success))completionHandler;
- (void)stopPreCache:(NSURL*)url
            cacheKey:(NSString* _Nullable)cacheKey
   completionHandler:(void (^ _Nullable)(BOOL success))completionHandler;
- (AVPlayerItem*)getCachingPlayerItemForNormalPlayback:(NSURL*)url
                                              cacheKey:(NSString* _Nullable)cacheKey
                                        videoExtension:(NSString* _Nullable)videoExtension
                                               headers:(NSDictionary<NSObject*, NSObject*>*)headers;
- (void)clearCache;
- (BOOL)isPreCacheSupportedWithUrl:(NSURL*)url videoExtension:(NSString* _Nullable)videoExtension;
@end

NS_ASSUME_NONNULL_END
