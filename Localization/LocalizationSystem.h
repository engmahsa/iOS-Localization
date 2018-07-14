

#import <Foundation/Foundation.h>

#define AMLocalizedString(key, comment) \
[[LocalizationSystem sharedLocalSystem] localizedStringForKey:(key) value:(comment)]

#define BPLocalizedString(key, comment, table, bundle) \
[[LocalizationSystem sharedLocalSystem] localizedStringForKey:(key) value:(comment) table:(table) bundle:(bundle)]

#define LocalizationSetLanguage(language) \
[[LocalizationSystem sharedLocalSystem] setLanguage:(language)]

#define LocalizationGetLanguage \
[[LocalizationSystem sharedLocalSystem] getLanguage]

#define LocalizationReset \
[[LocalizationSystem sharedLocalSystem] resetLocalization]

#define LocalizationGetLanguageShortName \
[[LocalizationSystem sharedLocalSystem] getLanguageShortName]

#define SetLanguageIfNeeded \
[[LocalizationSystem sharedLocalSystem] setLanguageIfNeeded]

#define LocalizationIsLanguageRightToLeft \
[[LocalizationSystem sharedLocalSystem] languageIsRightToLeft]


@interface LocalizationSystem : NSObject {
    NSString *language;
}

// you really shouldn't care about this functions and use the MACROS
+ (LocalizationSystem *)sharedLocalSystem;

//gets the string localized
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment;

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment table:(NSString *)table bundle:(NSBundle *)localBundle;

//sets the language
- (void) setLanguage:(NSString*) language;

//gets the current language
- (NSString*) getLanguage;

- (NSString *) getLanguageShortName;

//resets this system.
- (void) resetLocalization;

- (void) setLanguageIfNeeded;

- (BOOL) languageIsRightToLeft;

@end
