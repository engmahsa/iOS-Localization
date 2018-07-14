#import "LocalizationSystem.h"

@implementation LocalizationSystem

//Singleton instance
static LocalizationSystem *_sharedLocalSystem = nil;

//Current application bungle to get the languages.
static NSBundle *bundle = nil;

NSArray *rightToLeftLanguages;
NSDictionary *shortNameToFullVersion;

+(LocalizationSystem *)sharedLocalSystem {
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        _sharedLocalSystem = [[super allocWithZone:nil] init];
        [_sharedLocalSystem setLanguage:[_sharedLocalSystem getLanguage]];
    });
    return _sharedLocalSystem;
}

- (id)init {
    if (_sharedLocalSystem) {
        return _sharedLocalSystem;
    }
    if (self = [super init]) {
        rightToLeftLanguages = @[@"fa", @"ar"];
        shortNameToFullVersion = @{@"fa" : @"fa-IR", @"ar" : @"ar-SA", @"en" : @"en-US", @"fr" : @"fr", @"de" : @"de"};
        NSLog(@"LANGUAGE %@", [self getLanguage]);
        //
    }
    return self;
}

- (id)copy {
    return [[self class] sharedLocalSystem];
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedLocalSystem];
}

+(id)alloc
{
    @synchronized([LocalizationSystem class])
    {
        NSAssert(_sharedLocalSystem == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedLocalSystem = [super alloc];
        return _sharedLocalSystem;
    }
    // to avoid compiler warning
    return nil;
}

// Gets the current localized string as in NSLocalizedString.
//
// example calls:
// AMLocalizedString(@"Text to localize",@"Alternative text, in case hte other is not find");
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
    if (!bundle) {
        bundle = nil;
    }
    return [bundle localizedStringForKey:key value:comment table:nil];
}


- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment table:(NSString *)table bundle:(NSBundle *)localBundle
{
    if (!localBundle) {
        return [self localizedStringForKey:key value:comment];
    }
    return [localBundle localizedStringForKey:key value:comment table:table];
}


// Sets the desired language of the ones you have.
// example calls:
// LocalizationSetLanguage(@"Italian");
// LocalizationSetLanguage(@"German");
// LocalizationSetLanguage(@"Spanish");
//
// If this function is not called it will use the default OS language.
// If the language does not exists y returns the default OS language.
- (void) setLanguage:(NSString*) l{
#ifdef DEBUG
    NSLog(@"preferredLang: %@", l);
#endif
    
    NSString *path = [[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ];
    
    if ([l isEqualToString:@"en"]) {
        path = [[ NSBundle mainBundle ] pathForResource:@"Base" ofType:@"lproj" ];
    }
    if (path == nil) {
        //in case the language does not exists
        [self resetLocalization];
    }
    else {
        bundle = [NSBundle bundleWithPath:path];
        //
        [[NSUserDefaults standardUserDefaults] setObject:@[l] forKey:@"AppleLanguages"];
        //
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// Just gets the current setted up language.
// returns "es","fr",...
//
// example call:
// NSString * currentL = LocalizationGetLanguage;
- (NSString*) getLanguage{
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    
    NSString *preferredLang = [languages objectAtIndex:0];
    
    return preferredLang;
}

// Resets the localization system, so it uses the OS default language.
//
// example call:
// LocalizationReset;
- (void) resetLocalization
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppleLanguages"];
    //
    [[NSUserDefaults standardUserDefaults] synchronize];
    //
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Base" ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
}

- (NSString *) getLanguageShortName {
    NSString * languageName = [self getLanguage];
    NSLog(@"LANGUAGE %@", languageName);
    return [[languageName componentsSeparatedByString:@"-"] firstObject];
}

- (void) setLanguageIfNeeded
{
    [self resetLocalization];
    NSString *shortName = [self getLanguageShortName];
    if ([[shortNameToFullVersion allKeys] containsObject:shortName]) {
    
        [self setLanguage:[shortNameToFullVersion objectForKey:shortName]];
    
    } else {
        
        [self setLanguage:@"en-US"];
        
    }
}

- (BOOL) languageIsRightToLeft
{
    NSLog(@"is it right to left: %ld, %@", (long)[rightToLeftLanguages containsObject:[self getLanguageShortName]], [self getLanguageShortName]);
    return [rightToLeftLanguages containsObject:[self getLanguageShortName]];
}

@end
