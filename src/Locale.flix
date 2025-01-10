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

use Locale.{Locale}
import java.util.{Locale => JLocale}

///
/// Represents a Locale.
///
enum Locale(JLocale)

instance ToString[Locale] {
    pub def toString(x: Locale): String = 
        let Locale(x1) = x;
        unsafe x1.toString()
}

instance Eq[Locale] {
    pub def eq(x: Locale, y: Locale): Bool = 
        let Locale(x1) = x;
        let Locale(y1) = y;
        unsafe x1.equals(y1)
}

instance Hash[Locale] {
    pub def hash(x: Locale): Int32 = 
        let Locale(x1) = x;
        unsafe x1.hashCode()
}

mod Locale {

    use Locale.LanguageRange
    use Locale.LanguageRange.{LanguageRange}
    use LocaleCategory.{Display, Format}
    use IsoCountryCode.{Part1_Alpha2, Part1_Alpha3, Part3}
    use FilteringMode.{AutoselectFiltering, ExtendedFiltering, IgnoreExtendedRanges, MapExtendedRanges, RejectExtendedRanges}
    
    import java.util.{Locale => JLocale, Locale$Category => JCategory, 
                        Locale$FilteringMode => JFilteringMode, 
                        Locale$IsoCountryCode => JIsoCountryCode}
    import java.lang.{Character => JCharacter}
    import java.util.{Set => JSet, Iterator => JIterator, List => JList, Collection => JCollection}

    ///
    /// Locale categories.
    ///
    pub enum LocaleCategory with Eq, Order, ToString {
        case Display
        case Format
    }

    def localeCategoryToJava(c: LocaleCategory): JCategory = 
        match c {
            case Display => unsafe JCategory.DISPLAY
            case Format  => unsafe JCategory.FORMAT
        }

    pub enum IsoCountryCode with Eq, Order, ToString {
        case Part1_Alpha2
        case Part1_Alpha3
        case Part3
    }

    def isoCountryCodeToJava(c: IsoCountryCode): JIsoCountryCode = 
        match c {
            case Part1_Alpha2 => unsafe JIsoCountryCode.PART1_ALPHA2
            case Part1_Alpha3 => unsafe JIsoCountryCode.PART1_ALPHA3
            case Part3        => unsafe JIsoCountryCode.PART3
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
            case AutoselectFiltering    => unsafe JFilteringMode.AUTOSELECT_FILTERING
            case ExtendedFiltering      => unsafe JFilteringMode.EXTENDED_FILTERING
            case IgnoreExtendedRanges   => unsafe JFilteringMode.IGNORE_EXTENDED_RANGES
            case MapExtendedRanges      => unsafe JFilteringMode.MAP_EXTENDED_RANGES
            case RejectExtendedRanges   => unsafe JFilteringMode.REJECT_EXTENDED_RANGES

        }


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def make(lang: String): Locale = Locale(unsafe new JLocale(lang))


    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def makeWithCountry(lang: {lang = String}, country: {country = String}): Locale =
        Locale(unsafe new JLocale(lang#lang, country#country))

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def makeLocaleWithVariant(lang: {lang = String}, country: {country = String}, variant: {variant = String}): Locale =
        Locale(unsafe new JLocale(lang#lang, country#country, variant#variant))



    pub def setJvmDefaultLocale!(x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            let Locale(x1) = x;
            JLocale.setDefault(x1)
        })




    pub def setJvmDefaultLocaleWithCategory!(cat: LocaleCategory, x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            let Locale(x1) = x;
            let cat1 = localeCategoryToJava(cat);
            JLocale.setDefault(cat1, x1)
        })



    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale = Locale(unsafe JLocale.ROOT)

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale = Locale(unsafe JLocale.CANADA)

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale = Locale(unsafe JLocale.CANADA_FRENCH)

    pub def china(): Locale = Locale(unsafe JLocale.CHINA)

    pub def chinese(): Locale = Locale(unsafe JLocale.CHINESE)

    pub def english(): Locale = Locale(unsafe JLocale.ENGLISH)

    pub def france(): Locale = Locale(unsafe JLocale.FRANCE)

    pub def french(): Locale = Locale(unsafe JLocale.FRENCH)

    pub def german(): Locale = Locale(unsafe JLocale.GERMAN)

    pub def germany(): Locale = Locale(unsafe JLocale.GERMANY)

    pub def italian(): Locale = Locale(unsafe JLocale.ITALIAN)

    pub def italy(): Locale = Locale(unsafe JLocale.ITALY)

    pub def japan(): Locale = Locale(unsafe JLocale.JAPAN)

    pub def japanese(): Locale = Locale(unsafe JLocale.JAPANESE)

    pub def korea(): Locale = Locale(unsafe JLocale.KOREA)

    pub def korean(): Locale = Locale(unsafe JLocale.KOREAN)

    pub def prc(): Locale = Locale(unsafe JLocale.PRC)

    pub def simplified_chinese(): Locale = Locale(unsafe JLocale.SIMPLIFIED_CHINESE)

    pub def taiwan(): Locale = Locale(unsafe JLocale.TAIWAN)

    pub def traditional_chinese(): Locale = Locale(unsafe JLocale.TRADITIONAL_CHINESE)

    pub def uk(): Locale = Locale(unsafe JLocale.UK)

    pub def us(): Locale = Locale(unsafe JLocale.US)

    pub def getDefault(): Locale \ IO = 
        checked_ecast(Locale(unsafe JLocale.getDefault()))

    pub def getDefaultWithCategory(cat: LocaleCategory): Locale \ IO =
        let cat1 = localeCategoryToJava(cat);
        checked_ecast(Locale(unsafe JLocale.getDefault(cat1)))

    pub def getCountry(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getCountry()

    pub def getLanguage(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getLanguage()

    pub def getScript(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getScript()

    pub def getISO3Language(x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            let Locale(x1) = x;
            unsafe x1.getISO3Language()
        })

    pub def getDisplayCountry(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getDisplayCountry()

    pub def getDisplayCountryWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale(inLocale1) = inLocale#inLocale;
        let Locale(x1) = x;
        unsafe x1.getDisplayCountry(inLocale1)

    pub def getDisplayLanguage(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getDisplayLanguage()

    pub def getDisplayLanguageWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale(inLocale1) = inLocale#inLocale;
        let Locale(x1) = x;
        unsafe x1.getDisplayLanguage(inLocale1)

    pub def getDisplayName(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getDisplayName()

    pub def getDisplayNameWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale(inLocale1) = inLocale#inLocale;
        let Locale(x1) = x;
        unsafe x1.getDisplayName(inLocale1)

    pub def getDisplayScript(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getDisplayScript()

    pub def getDisplayScriptWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale(inLocale1) = inLocale#inLocale;
        let Locale(x1) = x;
        unsafe x1.getDisplayScript(inLocale1)


    pub def getDisplayVariant(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.getDisplayVariant()

    pub def getDisplayVariantWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        let Locale(inLocale1) = inLocale#inLocale;
        let Locale(x1) = x;
        unsafe x1.getDisplayVariant(inLocale1)

    pub def hasExtensions(x: Locale): Bool =
        let Locale(x1) = x;
        unsafe x1.hasExtensions()

    /// Produces a new Locale...
    pub def stripExtensions(x: Locale): Locale =
        let Locale(x1) = x;
        Locale(unsafe x1.stripExtensions())


    pub def toLanguageTag(x: Locale): String =
        let Locale(x1) = x;
        unsafe x1.toLanguageTag()

    pub def forLanguageTag(tag: String): Locale =
        Locale(unsafe JLocale.forLanguageTag(tag))

    pub def getAvailableLocales(): List[Locale] \ IO = region rc {
        let _ = Array#{} @ rc;
        let xs = JLocale.getAvailableLocales() |> Array.toList;
        List.map(Locale, xs)
    }

    pub def getIsoCountries(): List[String] = region rc {
        let _ = Array#{} @ rc;
        unsafe JLocale.getISOCountries() |> Array.toList
    }

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[String, Set[String]] =
        Result.tryCatch(_ ->  {
            let icc1 = isoCountryCodeToJava(icc);
            unsafe JLocale.getISOCountries(icc1) 
                |> Adaptor.fromSet
        })


    pub def getIsoLanguages(): Result[String, List[String]] =
        Result.tryCatch(_ -> {
            region rc {
                let _ = Array#{} @ rc;
                unsafe JLocale.getISOLanguages() |> Array.toList
            }
        })

    pub def getExtension(key: Char, x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            let Locale(x1) = x;
            let s = unsafe x1.getExtension(key);
            if (Object.isNull(s)) 
                ""
            else
                s
        })


    pub def getExtensionKeys(x: Locale): Set[Char] =
        let Locale(x1) = x;
        let keys = unsafe x1.getExtensionKeys();
        let chars: List[JCharacter] = fromSetAsList(keys);
        List.foldLeft((s, c) -> {let c1 = charFromJava(c); Set.insert(c1, s)}, Set.empty(), chars)
    
    def fromSetAsList(s: JSet): List[a] = region rc {
        unsafe s.iterator() |> Adaptor.fromIterator(rc, (Proxy.Proxy: Proxy[a])) |> Iterator.toList
    }

    def charFromJava(c: JCharacter): Char = c.charValue()

    pub def getUnicodeLocaleAttributes(x: Locale): Set[String] = 
        let Locale(x1) = x;
        unsafe x1.getUnicodeLocaleAttributes() |> Adaptor.fromSet

    pub def getUnicodeLocaleKeys(x: Locale): Set[String] = 
        let Locale(x1) = x;
        unsafe x1.getUnicodeLocaleKeys() |> Adaptor.fromSet

    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, Option[Locale]] \ IO =
        Result.tryCatch(_ -> {
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let locs1 = List.map(w -> {let Locale(w1) = w; w1}, locales) |> Adaptor.toList;
            JLocale.lookup(ps1, unchecked_cast(locs1 as JCollection)) |> Object.toOption |> Option.map(Locale)
        })


    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Result[String, Option[String]] \ IO =
        Result.tryCatch(_ -> {
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let tags1 = unchecked_cast(Adaptor.toList(tags) as JCollection);
            JLocale.lookupTag(ps1, tags1) |> Object.toOption
        })


    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, List[Locale]] \ IO =
        Result.tryCatch(_ -> {
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let locs1 = List.map(w -> {let Locale(w1) = w; w1}, locales) |> Adaptor.toList;
            JLocale.filter(ps1, unchecked_cast(locs1 as JCollection)) 
                |> Adaptor.fromList 
                |> List.map(o -> Locale(o))
        })



    pub def filterWithFilteringMode(priorityList: List[LanguageRange], 
                                    mode: FilteringMode, 
                                    locales: List[Locale]): Result[String, List[Locale]] \ IO = 
        Result.tryCatch(_ ->  {
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let locs1 = List.map(w -> {let Locale(w1) = w; w1}, locales) |> Adaptor.toList;
            let mode1 = filteringModeToJava(mode);
            JLocale.filter(ps1, unchecked_cast(locs1 as JCollection), mode1) 
                |> Adaptor.fromList 
                |> List.map(o -> Locale(o))
        })

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): Result[String, List[String]] \ IO = 
        Result.tryCatch(_ -> {
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let tags1 = unchecked_cast(Adaptor.toList(tags) as JCollection);
            JLocale.filterTags(ps1, tags1) |> Adaptor.fromList
        })


    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], 
                                        mode: FilteringMode, 
                                        tags: List[String]): Result[String, List[String]] \ IO = 
        Result.tryCatch(_ -> {
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let tags1 = unchecked_cast(Adaptor.toList(tags) as JCollection);
            let mode1 = filteringModeToJava(mode);
            JLocale.filterTags(ps1, tags1, mode1) |> Adaptor.fromList
        })


}
