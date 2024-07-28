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

///
/// Represents a Locale.
///
enum Locale(##java.util.Locale)

instance ToString[Locale] {
    pub def toString(x: Locale): String = 
        import java.util.Locale.toString(): String \ {};
        let Locale(x1) = x;
        toString(x1)
}

instance Eq[Locale] {
    pub def eq(x: Locale, y: Locale): Bool = 
        import java.util.Locale.equals(##java.lang.Object): Bool \ {};
        let Locale(x1) = x;
        let Locale(y1) = y;
        equals(x1, checked_cast(y1))
}

instance Hash[Locale] {
    pub def hash(x: Locale): Int32 = 
        import java.util.Locale.hashCode(): Int32 \ {};
        let Locale(x1) = x;
        hashCode(x1)
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
        import static java_get_field java.util.Locale$Category.DISPLAY: JCategory \ {} as get_DISPLAY;
        import static java_get_field java.util.Locale$Category.FORMAT: JCategory \ {} as get_FORMAT;
        match c {
            case Display => get_DISPLAY()
            case Format  => get_FORMAT()
        }

    pub enum IsoCountryCode with Eq, Order, ToString {
        case Part1_Alpha2
        case Part1_Alpha3
        case Part3
    }

    def isoCountryCodeToJava(c: IsoCountryCode): JIsoCountryCode = 
        import static java_get_field java.util.Locale$IsoCountryCode.PART1_ALPHA2: JIsoCountryCode \ {} as get_PART1_ALPHA2;
        import static java_get_field java.util.Locale$IsoCountryCode.PART1_ALPHA3: JIsoCountryCode \ {} as get_PART1_ALPHA3;
        import static java_get_field java.util.Locale$IsoCountryCode.PART3: JIsoCountryCode \ {} as get_PART3;
        match c {
            case Part1_Alpha2 => get_PART1_ALPHA2()
            case Part1_Alpha3 => get_PART1_ALPHA3()
            case Part3        => get_PART3()
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
        import static java_get_field java.util.Locale$FilteringMode.AUTOSELECT_FILTERING: JFilteringMode \ {} as get_AUTOSELECT_FILTERING;        
        import static java_get_field java.util.Locale$FilteringMode.EXTENDED_FILTERING: JFilteringMode \ {} as get_EXTENDED_FILTERING;
        import static java_get_field java.util.Locale$FilteringMode.IGNORE_EXTENDED_RANGES: JFilteringMode \ {} as get_IGNORE_EXTENDED_RANGES;
        import static java_get_field java.util.Locale$FilteringMode.MAP_EXTENDED_RANGES: JFilteringMode \ {} as get_MAP_EXTENDED_RANGES;
        import static java_get_field java.util.Locale$FilteringMode.REJECT_EXTENDED_RANGES: JFilteringMode \ {} as get_REJECT_EXTENDED_RANGES;
        match m {
            case AutoselectFiltering => get_AUTOSELECT_FILTERING()
            case ExtendedFiltering  => get_EXTENDED_FILTERING()
            case IgnoreExtendedRanges => get_IGNORE_EXTENDED_RANGES()
            case MapExtendedRanges => get_MAP_EXTENDED_RANGES()
            case RejectExtendedRanges => get_REJECT_EXTENDED_RANGES()

        }


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def make(lang: String): Locale =
        import java_new java.util.Locale(String): JLocale \ {} as make1;
        Locale(make1(lang))


    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def makeWithCountry(lang: {lang = String}, country: {country = String}): Locale =
        import java_new java.util.Locale(String, String): JLocale \ {} as make1;
        Locale(make1(lang.lang, country.country))

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def makeLocaleWithVariant(lang: {lang = String}, country: {country = String}, variant: {variant = String}): Locale =
        import java_new java.util.Locale(String, String, String): JLocale \ {} as make1;
        Locale(make1(lang.lang, country.country, variant.variant))



    pub def setJvmDefaultLocale!(x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale.setDefault(JLocale): Unit \ IO;
            let Locale(x1) = x;
            setDefault(x1)
        })




    pub def setJvmDefaultLocaleWithCategory!(cat: LocaleCategory, x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale.setDefault(JCategory, JLocale): Unit \ IO;
            let Locale(x1) = x;
            let cat1 = localeCategoryToJava(cat);
            setDefault(cat1, x1)
        })



    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        import static java_get_field java.util.Locale.ROOT: JLocale \ {} as get_ROOT;
        Locale(get_ROOT())

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        import static java_get_field java.util.Locale.CANADA: JLocale \ {} as get_CANADA;
        Locale(get_CANADA())

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        import static java_get_field java.util.Locale.CANADA_FRENCH: JLocale \ {} as get_CANADA_FRENCH;
        Locale(get_CANADA_FRENCH())

    pub def china(): Locale =
        import static java_get_field java.util.Locale.CHINA: JLocale \ {} as get_CHINA;
        Locale(get_CHINA())

    pub def chinese(): Locale =
        import static java_get_field java.util.Locale.CHINESE: JLocale \ {} as get_CHINESE;
        Locale(get_CHINESE())

    pub def english(): Locale =
        import static java_get_field java.util.Locale.ENGLISH: JLocale \ {} as get_ENGLISH;
        Locale(get_ENGLISH())

    pub def france(): Locale =
        import static java_get_field java.util.Locale.FRANCE: JLocale \ {} as get_FRANCE;
        Locale(get_FRANCE())

    pub def french(): Locale =
        import static java_get_field java.util.Locale.FRENCH: JLocale \ {} as get_FRENCH;
        Locale(get_FRENCH())

    pub def german(): Locale =
        import static java_get_field java.util.Locale.GERMAN: JLocale \ {} as get_GERMAN;
        Locale(get_GERMAN())

    pub def germany(): Locale =
        import static java_get_field java.util.Locale.GERMANY: JLocale \ {} as get_GERMANY;
        Locale(get_GERMANY())

    pub def italian(): Locale =
        import static java_get_field java.util.Locale.ITALIAN: JLocale \ {} as get_ITALIAN;
        Locale(get_ITALIAN())

    pub def italy(): Locale =
        import static java_get_field java.util.Locale.ITALY: JLocale \ {} as get_ITALY;
        Locale(get_ITALY())

    pub def japan(): Locale =
        import static java_get_field java.util.Locale.JAPAN: JLocale \ {} as get_JAPAN;
        Locale(get_JAPAN())

    pub def japanese(): Locale =
        import static java_get_field java.util.Locale.JAPANESE: JLocale \ {} as get_JAPANESE;
        Locale(get_JAPANESE())

    pub def korea(): Locale =
        import static java_get_field java.util.Locale.KOREA: JLocale \ {} as get_KOREA;
        Locale(get_KOREA())

    pub def korean(): Locale =
        import static java_get_field java.util.Locale.KOREAN: JLocale \ {} as get_KOREAN;
        Locale(get_KOREAN())

    pub def prc(): Locale =
        import static java_get_field java.util.Locale.PRC: JLocale \ {} as get_PRC;
        Locale(get_PRC())


    pub def simplified_chinese(): Locale =
        import static java_get_field java.util.Locale.SIMPLIFIED_CHINESE: JLocale \ {} as get_SIMPLIFIED_CHINESE;
        Locale(get_SIMPLIFIED_CHINESE())

    pub def taiwan(): Locale =
        import static java_get_field java.util.Locale.TAIWAN: JLocale \ {} as get_TAIWAN;
        Locale(get_TAIWAN())

    pub def traditional_chinese(): Locale =
        import static java_get_field java.util.Locale.TRADITIONAL_CHINESE: JLocale \ {} as get_TRADITIONAL_CHINESE;
        Locale(get_TRADITIONAL_CHINESE())

    pub def uk(): Locale =
        import static java_get_field java.util.Locale.UK: JLocale \ {} as get_UK;
        Locale(get_UK())

    pub def us(): Locale =
        import static java_get_field java.util.Locale.US: JLocale \ {} as get_US;
        Locale(get_US())

    pub def getDefault(): Locale \ IO =
        import static java.util.Locale.getDefault(): JLocale \ IO;
        Locale(getDefault())

    pub def getDefaultWithCategory(cat: LocaleCategory): Locale \ IO =
        import static java.util.Locale.getDefault(JCategory): JLocale \ IO;
        let cat1 = localeCategoryToJava(cat);
        Locale(getDefault(cat1))

    pub def getCountry(x: Locale): String =
        import java.util.Locale.getCountry(): String \ {};
        let Locale(x1) = x;
        getCountry(x1)

    pub def getLanguage(x: Locale): String =
        import java.util.Locale.getLanguage(): String \ {};
        let Locale(x1) = x;
        getLanguage(x1)

    pub def getScript(x: Locale): String =
        import java.util.Locale.getScript(): String \ {};
        let Locale(x1) = x;
        getScript(x1)

    pub def getISO3Language(x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            import java.util.Locale.getISO3Language(): String \ {};
            let Locale(x1) = x;
            getISO3Language(x1)
        })

    pub def getDisplayCountry(x: Locale): String =
        import java.util.Locale.getDisplayCountry(): String \ {};
        let Locale(x1) = x;
        getDisplayCountry(x1)

    pub def getDisplayCountryWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayCountry(JLocale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayCountry(x1, inLocale1)

    pub def getDisplayLanguage(x: Locale): String =
        import java.util.Locale.getDisplayLanguage(): String \ {};
        let Locale(x1) = x;
        getDisplayLanguage(x1)

    pub def getDisplayLanguageWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayLanguage(JLocale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayLanguage(x1, inLocale1)

    pub def getDisplayName(x: Locale): String =
        import java.util.Locale.getDisplayName(): String \ {};
        let Locale(x1) = x;
        getDisplayName(x1)

    pub def getDisplayNameWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayName(JLocale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayName(x1, inLocale1)

    pub def getDisplayScript(x: Locale): String =
        import java.util.Locale.getDisplayScript(): String \ {};
        let Locale(x1) = x;
        getDisplayScript(x1)

    pub def getDisplayScriptWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayScript(JLocale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayScript(x1, inLocale1)


    pub def getDisplayVariant(x: Locale): String =
        import java.util.Locale.getDisplayVariant(): String \ {};
        let Locale(x1) = x;
        getDisplayVariant(x1)

    pub def getDisplayVariantWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayVariant(JLocale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayVariant(x1, inLocale1)        

    pub def hasExtensions(x: Locale): Bool =
        import java.util.Locale.hasExtensions(): Bool \ {};
        let Locale(x1) = x;
        hasExtensions(x1)

    /// Produces a new Locale...
    pub def stripExtensions(x: Locale): Locale =
        import java.util.Locale.stripExtensions(): JLocale \ {};
        let Locale(x1) = x;
        Locale(stripExtensions(x1))


    pub def toLanguageTag(x: Locale): String =
        import java.util.Locale.toLanguageTag(): String \ {};
        let Locale(x1) = x;
        toLanguageTag(x1)

    pub def forLanguageTag(tag: String): Locale =
        import static java.util.Locale.forLanguageTag(String): JLocale \ {};
        Locale(forLanguageTag(tag))

    pub def getAvailableLocales(): List[Locale] \ IO = region rc {
        import static java.util.Locale.getAvailableLocales(): Array[JLocale, rc] \ {rc, IO} ;
        let _ = Array#{} @ rc;
        let xs = getAvailableLocales() |> Array.toList;
        List.map(Locale, xs)
    }

    pub def getIsoCountries(): List[String] = region rc {
        import static java.util.Locale.getISOCountries(): Array[String, rc] \ rc;
        let _ = Array#{} @ rc;
        getISOCountries() |> Array.toList
    }

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[String, Set[String]] =
        Result.tryCatch(_ ->  {
            import static java.util.Locale.getISOCountries(JIsoCountryCode): JSet \ {};
            let icc1 = isoCountryCodeToJava(icc);
            getISOCountries(icc1) 
                |> Adaptor.fromSet
        })


    pub def getIsoLanguages(): Result[String, List[String]] =
        Result.tryCatch(_ -> {
            region rc {
                import static java.util.Locale.getISOLanguages(): Array[String, rc] \ rc;
                let _ = Array#{} @ rc;            
                getISOLanguages() |> Array.toList
            }
        })

    pub def getExtension(key: Char, x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            import java.util.Locale.getExtension(Char): String \ {};
            let Locale(x1) = x;
            let s = getExtension(x1, key);
            if (Object.isNull(s)) 
                ""
            else
                s
        })


    pub def getExtensionKeys(x: Locale): Set[Char] =
        import java.util.Locale.getExtensionKeys(): JSet \ {};
        let Locale(x1) = x;
        let keys = getExtensionKeys(x1);
        let chars: List[JCharacter] = fromSetAsList(keys);
        List.foldLeft((s, c) -> {let c1 = charFromJava(c); Set.insert(c1, s)}, Set.empty(), chars)
    
    def fromSetAsList(l: JSet): List[a] = region rc {
        import java.util.Set.iterator(): JIterator \ rc;
        iterator(l) |> Adaptor.fromIterator(rc, (Proxy.Proxy: Proxy[a])) |> Iterator.toList
    }

    def charFromJava(c: JCharacter): Char = 
        import java.lang.Character.charValue(): Char \ {};
        charValue(c)

    pub def getUnicodeLocaleAttributes(x: Locale): Set[String] = 
        import java.util.Locale.getUnicodeLocaleAttributes(): JSet \ {};
        let Locale(x1) = x;
        getUnicodeLocaleAttributes(x1) |> Adaptor.fromSet

    pub def getUnicodeLocaleKeys(x: Locale): Set[String] = 
        import java.util.Locale.getUnicodeLocaleKeys(): JSet \ {};
        let Locale(x1) = x;
        getUnicodeLocaleKeys(x1) |> Adaptor.fromSet

    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, Option[Locale]] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale.lookup(JList, JCollection): JLocale \ {};
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let locs1 = List.map(w -> {let Locale(w1) = w; w1}, locales) |> Adaptor.toList;
            lookup(ps1, unchecked_cast(locs1 as JCollection)) |> Object.toOption |> Option.map(Locale)
        })


    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Result[String, Option[String]] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale.lookupTag(JList, JCollection): String \ {};
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let tags1 = Adaptor.toList(tags);
            lookupTag(ps1, unchecked_cast(tags1 as JCollection)) |> Object.toOption
        })


    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, List[Locale]] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale.filter(JList, JCollection): JList \ {};
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let locs1 = List.map(w -> {let Locale(w1) = w; w1}, locales) |> Adaptor.toList;
            filter(ps1, unchecked_cast(locs1 as JCollection)) 
                |> Adaptor.fromList 
                |> List.map(o -> Locale(o))
        })



    pub def filterWithFilteringMode(priorityList: List[LanguageRange], 
                                    mode: FilteringMode, 
                                    locales: List[Locale]): Result[String, List[Locale]] \ IO = 
        Result.tryCatch(_ ->  {
            import static java.util.Locale.filter(JList, JCollection, JFilteringMode): JList \ {};
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let locs1 = List.map(w -> {let Locale(w1) = w; w1}, locales) |> Adaptor.toList;
            let mode1 = filteringModeToJava(mode);
            filter(ps1, unchecked_cast(locs1 as JCollection), mode1) 
                |> Adaptor.fromList 
                |> List.map(o -> Locale(o))
        })

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): Result[String, List[String]] \ IO = 
        Result.tryCatch(_ -> {
            import static java.util.Locale.filterTags(JList, JCollection): JList \ {};
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let tags1 = Adaptor.toList(tags);
            filterTags(ps1, unchecked_cast(tags1 as JCollection)) |> Adaptor.fromList
        })


    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], 
                                        mode: FilteringMode, 
                                        tags: List[String]): Result[String, List[String]] \ IO = 
        Result.tryCatch(_ -> {
            import static java.util.Locale.filterTags(JList, JCollection, JFilteringMode): JList \ {};
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let tags1 = Adaptor.toList(tags);
            let mode1 = filteringModeToJava(mode);
            filterTags(ps1, unchecked_cast(tags1 as JCollection), mode1) |> Adaptor.fromList
        })


}
