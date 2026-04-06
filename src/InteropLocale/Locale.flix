/*
 * Copyright 2023 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



pub mod InteropLocale.Locale {
    use InteropLocale.Locale.LanguageRange


    use InteropLocale.Locale.LanguageRange.LanguageRange
    
    import java.util.{Locale => JLocale} 
    import java.util.{Locale$LanguageRange => JLanguageRange,
                        Locale$Category => JCategory, 
                        Locale$FilteringMode => JFilteringMode, 
                        Locale$IsoCountryCode => JIsoCountryCode}
    import java.lang.{Character => JCharacter}
    import java.util.{Set => JSet, Iterator => JIterator, List => JList, Collection => JCollection}

    ///
    /// Represents a Locale.
    ///
    pub enum Locale(JLocale)

    instance ToString[Locale] {
        pub def toString(x: Locale): String = 
            let Locale.Locale(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[Locale] {
        pub def eq(x: Locale, y: Locale): Bool = 
            let Locale.Locale(x1) = x;
            let Locale.Locale(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[Locale] {
        pub def hash(x: Locale): Int32 = 
            let Locale.Locale(x1) = x;
            unsafe IO { x1.hashCode() }
    }


    ///
    /// Locale categories.
    ///
    pub enum LocaleCategory with Eq, Order, ToString {
        case Display
        case Format
    }

    def localeCategoryToJava(c: LocaleCategory): JCategory = 
        match c {
            case LocaleCategory.Display => unsafe IO { JCategory.DISPLAY }
            case LocaleCategory.Format  => unsafe IO { JCategory.FORMAT }
        }

    pub enum IsoCountryCode with Eq, Order, ToString {
        case Part1_Alpha2
        case Part1_Alpha3
        case Part3
    }

    def isoCountryCodeToJava(c: IsoCountryCode): JIsoCountryCode = 
        match c {
            case IsoCountryCode.Part1_Alpha2 => unsafe IO { JIsoCountryCode.PART1_ALPHA2 }
            case IsoCountryCode.Part1_Alpha3 => unsafe IO { JIsoCountryCode.PART1_ALPHA3 }
            case IsoCountryCode.Part3        => unsafe IO { JIsoCountryCode.PART3 }
        }

    ///
    /// Filtering modes.
    ///
    pub enum FilteringMode with Eq, Order, ToString {
        case AutoselectFiltering
        case ExtendedFiltering
        case IgnoreExtendedRanges
        case MapExtendedRanges
        case RejectExtendedRanges
    }

    def filteringModeToJava(m: FilteringMode): JFilteringMode = 
        match m {
            case FilteringMode.AutoselectFiltering    => unsafe IO { JFilteringMode.AUTOSELECT_FILTERING }
            case FilteringMode.ExtendedFiltering      => unsafe IO { JFilteringMode.EXTENDED_FILTERING }
            case FilteringMode.IgnoreExtendedRanges   => unsafe IO { JFilteringMode.IGNORE_EXTENDED_RANGES }
            case FilteringMode.MapExtendedRanges      => unsafe IO { JFilteringMode.MAP_EXTENDED_RANGES }
            case FilteringMode.RejectExtendedRanges   => unsafe IO { JFilteringMode.REJECT_EXTENDED_RANGES }

        }


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def make(lang: String): Locale = 
        Locale.Locale(unsafe IO { new JLocale(lang) })


    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def makeWithCountry(lang: {lang = String}, country: {country = String}): Locale =
        Locale.Locale(unsafe IO { new JLocale(lang#lang, country#country) })

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def makeLocaleWithVariant(lang: {lang = String}, country: {country = String}, variant: {variant = String}): Locale =
        Locale.Locale(unsafe IO { new JLocale(lang#lang, country#country, variant#variant) })



    pub def setJvmDefaultLocale(x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            let Locale.Locale(x1) = x;
            JLocale.setDefault(x1)
        })




    pub def setJvmDefaultLocaleWithCategory(cat: LocaleCategory, x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            let Locale.Locale(x1) = x;
            let cat1 = localeCategoryToJava(cat);
            JLocale.setDefault(cat1, x1)
        })



    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale = 
        Locale.Locale(unsafe IO { JLocale.ROOT })

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale = 
        Locale.Locale(unsafe IO { JLocale.CANADA })

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale = 
        Locale.Locale(unsafe IO { JLocale.CANADA_FRENCH })

    pub def china(): Locale = 
        Locale.Locale(unsafe IO { JLocale.CHINA })

    pub def chinese(): Locale = 
        Locale.Locale(unsafe IO { JLocale.CHINESE })

    pub def english(): Locale = 
        Locale.Locale(unsafe IO { JLocale.ENGLISH })

    pub def france(): Locale = 
        Locale.Locale(unsafe IO { JLocale.FRANCE })

    pub def french(): Locale = 
        Locale.Locale(unsafe IO { JLocale.FRENCH })

    pub def german(): Locale = 
        Locale.Locale(unsafe IO { JLocale.GERMAN })

    pub def germany(): Locale = 
        Locale.Locale(unsafe IO { JLocale.GERMANY })

    pub def italian(): Locale = 
        Locale.Locale(unsafe IO { JLocale.ITALIAN })

    pub def italy(): Locale = 
        Locale.Locale(unsafe IO { JLocale.ITALY })

    pub def japan(): Locale = 
        Locale.Locale(unsafe IO { JLocale.JAPAN })

    pub def japanese(): Locale = 
        Locale.Locale(unsafe IO { JLocale.JAPANESE })

    pub def korea(): Locale = 
        Locale.Locale(unsafe IO { JLocale.KOREA })

    pub def korean(): Locale = 
        Locale.Locale(unsafe IO { JLocale.KOREAN })

    pub def prc(): Locale = 
        Locale.Locale(unsafe IO { JLocale.PRC })

    pub def simplified_chinese(): Locale = 
        Locale.Locale(unsafe IO { JLocale.SIMPLIFIED_CHINESE })

    pub def taiwan(): Locale = 
        Locale.Locale(unsafe IO { JLocale.TAIWAN })

    pub def traditional_chinese(): Locale = 
        Locale.Locale(unsafe IO { JLocale.TRADITIONAL_CHINESE })

    pub def uk(): Locale = 
        Locale.Locale(unsafe IO { JLocale.UK })

    pub def us(): Locale = 
        Locale.Locale(unsafe IO { JLocale.US })

    pub def getDefault(): Locale \ IO = 
        Locale.Locale(JLocale.getDefault())

    pub def getDefaultWithCategory(cat: LocaleCategory): Locale \ IO =
        let cat1 = localeCategoryToJava(cat);
        Locale.Locale(JLocale.getDefault(cat1))

    pub def getCountry(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getCountry() }

    pub def getLanguage(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getLanguage() }

    pub def getScript(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getScript() }

    pub def getISO3Language(x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            let Locale.Locale(x1) = x;
            unsafe IO { x1.getISO3Language() }
        })

    pub def getDisplayCountry(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayCountry() }

    pub def getDisplayCountryWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale.Locale(inLocale1) = inLocale#inLocale;
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayCountry(inLocale1) }

    pub def getDisplayLanguage(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayLanguage() }

    pub def getDisplayLanguageWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale.Locale(inLocale1) = inLocale#inLocale;
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayLanguage(inLocale1) }

    pub def getDisplayName(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayName() }

    pub def getDisplayNameWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale.Locale(inLocale1) = inLocale#inLocale;
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayName(inLocale1) }

    pub def getDisplayScript(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayScript() }

    pub def getDisplayScriptWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale.Locale(inLocale1) = inLocale#inLocale;
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayScript(inLocale1) }


    pub def getDisplayVariant(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayVariant() }

    pub def getDisplayVariantWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale.Locale(inLocale1) = inLocale#inLocale;
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getDisplayVariant(inLocale1) }

    pub def hasExtensions(x: Locale): Bool =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.hasExtensions() }

    /// Produces a new Locale...
    pub def stripExtensions(x: Locale): Locale =
        let Locale.Locale(x1) = x;
        Locale.Locale(unsafe IO { x1.stripExtensions() })


    pub def toLanguageTag(x: Locale): String =
        let Locale.Locale(x1) = x;
        unsafe IO { x1.toLanguageTag() }

    pub def forLanguageTag(tag: String): Locale =
        Locale.Locale(unsafe IO { JLocale.forLanguageTag(tag) })

    pub def getAvailableLocales(): List[Locale] \ IO = region rc {
        let _ = Array#{} @ rc;
        let xs = JLocale.getAvailableLocales() |> Array.toList;
        List.map(Locale.Locale, xs)
    }

    pub def getIsoCountries(): List[String] \ IO = region rc {
        let _ = Array#{} @ rc;
        unsafe IO { JLocale.getISOCountries() } |> Array.toList
    }

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[String, Set[String]] \ IO & {~IO} =
        Result.tryCatch(_ ->  {
            let icc1 = isoCountryCodeToJava(icc);
            unsafe IO { JLocale.getISOCountries(icc1) }
                |> Adaptor.fromSet
        })


    pub def getIsoLanguages(): Result[String, List[String]] \ IO =
        Result.tryCatch(_ -> {
            region rc {
                let _ = Array#{} @ rc;
                unsafe IO { JLocale.getISOLanguages() } |> Array.toList
            }
        })

    pub def getExtension(key: Char, x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            let Locale.Locale(x1) = x;
            let s = unsafe IO { x1.getExtension(key) };
            if (Object.isNull(s)) 
                ""
            else
                s
        })


    pub def getExtensionKeys(x: Locale): Set[Char] =
        let Locale.Locale(x1) = x;
        let keys = unsafe IO { x1.getExtensionKeys() };
        let chars: List[JCharacter] = fromSetAsList(keys);
        List.foldLeft((s, c) -> {let c1 = charFromJava(c); Set.insert(c1, s)}, Set.empty(), chars)
    
    def fromSetAsList(s: JSet[a]): List[a] = region rc {
        let javaIter = unsafe IO { s.iterator() };
        let flixIter =  Adaptor.fromIterator(rc, (Proxy.Proxy: Proxy[a]), javaIter);
        Iterator.toList(flixIter)
    }

    def charFromJava(c: JCharacter): Char = c.charValue()

    pub def getUnicodeLocaleAttributes(x: Locale): Set[String] = 
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getUnicodeLocaleAttributes() } |> Adaptor.fromSet

    pub def getUnicodeLocaleKeys(x: Locale): Set[String] = 
        let Locale.Locale(x1) = x;
        unsafe IO { x1.getUnicodeLocaleKeys() } |> Adaptor.fromSet

    def unwrapLanguageRange(w: LanguageRange): JLanguageRange = 
        let LanguageRange.LanguageRange(w1) = w; 
        w1
    
    def unwrapLocale(w: Locale): JLocale = 
        let Locale.Locale(w1) = w; 
        w1

    // TODO - shouldn't need to be in IO
    pub def lookup(priorities: List[LanguageRange], locales: List[Locale]): Result[String, Option[Locale]] \ IO =
        Result.tryCatch(_ -> {
            let priorities1 = List.map(unwrapLanguageRange, priorities);
            let javaPriorities: JList[JLanguageRange] = Adaptor.toList(priorities1);
            let locales1 = List.map(unwrapLocale, locales);
            let javaLocales: JList[JLocale] = Adaptor.toList(locales1);
            let javaCollLocales = unchecked_cast(javaLocales as JCollection[JLocale]);
            let javaAns = JLocale.lookup(javaPriorities, javaCollLocales);
            let javaAns1: Option[JLocale] = Object.toOption(javaAns);
            Option.map(Locale.Locale, javaAns1)
        })

    // TODO - shouldn't need to be in IO
    pub def lookupTag(priorities: List[LanguageRange], tags: List[String]): Result[String, Option[String]] \ IO =
        Result.tryCatch(_ -> {
            let priorities1 = List.map(unwrapLanguageRange, priorities);
            let javaPriorities: JList[JLanguageRange] = Adaptor.toList(priorities1);
            let javaTags: JList[String] = Adaptor.toList(tags);
            let javaTagsColl: JCollection[String] = checked_cast(javaTags);
            let ans = JLocale.lookupTag(javaPriorities, javaTagsColl);
            Object.toOption(ans)
        })


    pub def filter(priorities: List[LanguageRange], locales: List[Locale]): Result[String, List[Locale]] \ IO =
        Result.tryCatch(_ -> {
            let priorities1 = List.map(unwrapLanguageRange, priorities);
            let javaPriorities: JList[JLanguageRange] = Adaptor.toList(priorities1);
            let locales1 = List.map(unwrapLocale, locales);
            let javaLocales: JList[JLocale] = Adaptor.toList(locales1);
            let javaCollLocales = unchecked_cast(javaLocales as JCollection[JLocale]);
            let javaAns: JList[JLocale] = JLocale.filter(javaPriorities, javaCollLocales);
            let ans1 = Adaptor.fromList(javaAns);
            List.map(Locale.Locale, ans1)
        })


    // TODO - shouldn't need to be in IO
    pub def filterWithFilteringMode(priorities: List[LanguageRange], 
                                    mode: FilteringMode, 
                                    locales: List[Locale]): Result[String, List[Locale]] \ IO = 
        Result.tryCatch(_ ->  {
            let priorites1 = List.map(unwrapLanguageRange, priorities);
            let javaPriorities: JList[JLanguageRange] = Adaptor.toList(priorites1);
            let locales1 = List.map(unwrapLocale, locales);
            let javaLocales = Adaptor.toList(locales1);
            let javaCollLocales = unchecked_cast(javaLocales as JCollection[JLocale]);
            let javaMode = filteringModeToJava(mode);
            let javaAns = JLocale.filter(javaPriorities, javaCollLocales, javaMode);
            let ans1 = Adaptor.fromList(javaAns); 
            List.map(Locale.Locale, ans1)
        })

    // TODO - shouldn't need to be in IO
    pub def filterTags(priorities: List[LanguageRange], tags: List[String]): Result[String, List[String]] \ IO = 
        Result.tryCatch(_ -> {
            let priorities1 = List.map(unwrapLanguageRange, priorities);
            let javaPriorities: JList[JLanguageRange] = Adaptor.toList(priorities1);
            let javaTags: JList[String] = Adaptor.toList(tags);
            let javaTagsColl: JCollection[String] = checked_cast(javaTags);
            let ans: JList[String] = JLocale.filterTags(javaPriorities, javaTagsColl);
            Adaptor.fromList(ans)
        })

    // TODO - shouldn't need to be in IO
    pub def filterTagsWithFilteringMode(priorities: List[LanguageRange], 
                                        mode: FilteringMode, 
                                        tags: List[String]): Result[String, List[String]] \ IO = 
        Result.tryCatch(_ -> {
            let priorities1 = List.map(unwrapLanguageRange, priorities);
            let javaPriorities: JList[JLanguageRange] = Adaptor.toList(priorities1);
            let javaTags: JList[String] = Adaptor.toList(tags);
            let javaTagsColl: JCollection[String] = checked_cast(javaTags);
            let javaMode = filteringModeToJava(mode);
            let ans: JList[String] = JLocale.filterTags(javaPriorities, javaTagsColl, javaMode);
            Adaptor.fromList(ans)
        })


}
