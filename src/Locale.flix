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

///
/// Represents a Locale.
///
enum Locale(##java.util.Locale)


mod Locale {


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def new(lang: String): Locale =
        import new java.util.Locale(String): ##java.util.Locale \ {} as new1;
        Locale(new1(lang))


    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def newLocaleWithCountry(lang: {lang = String}, country: {country = String}): Locale =
        import new java.util.Locale(String, String): ##java.util.Locale \ {} as new1;
        Locale(new1(lang.lang, country.country))



    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        import static get java.util.Locale.ROOT: ##java.util.Locale \ {} as get_ROOT;
        Locale(get_ROOT())

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        import static get java.util.Locale.CANADA: ##java.util.Locale \ {} as get_CANADA;
        Locale(get_CANADA())

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        import static get java.util.Locale.CANADA_FRENCH: ##java.util.Locale \ {} as get_CANADA_FRENCH;
        Locale(get_CANADA_FRENCH())

    pub def china(): Locale =
        import static get java.util.Locale.CHINA: ##java.util.Locale \ {} as get_CHINA;
        Locale(get_CHINA())

    pub def chinese(): Locale =
        import static get java.util.Locale.CHINESE: ##java.util.Locale \ {} as get_CHINESE;
        Locale(get_CHINESE())

    pub def english(): Locale =
        import static get java.util.Locale.ENGLISH: ##java.util.Locale \ {} as get_ENGLISH;
        Locale(get_ENGLISH())

    pub def france(): Locale =
        import static get java.util.Locale.FRANCE: ##java.util.Locale \ {} as get_FRANCE;
        Locale(get_FRANCE())

    pub def french(): Locale =
        import static get java.util.Locale.FRENCH: ##java.util.Locale \ {} as get_FRENCH;
        Locale(get_FRENCH())

    pub def german(): Locale =
        import static get java.util.Locale.GERMAN: ##java.util.Locale \ {} as get_GERMAN;
        Locale(get_GERMAN())

    pub def germany(): Locale =
        import static get java.util.Locale.GERMANY: ##java.util.Locale \ {} as get_GERMANY;
        Locale(get_GERMANY())

    pub def italian(): Locale =
        import static get java.util.Locale.ITALIAN: ##java.util.Locale \ {} as get_ITALIAN;
        Locale(get_ITALIAN())

    pub def italy(): Locale =
        import static get java.util.Locale.ITALY: ##java.util.Locale \ {} as get_ITALY;
        Locale(get_ITALY())

    pub def japan(): Locale =
        import static get java.util.Locale.JAPAN: ##java.util.Locale \ {} as get_JAPAN;
        Locale(get_JAPAN())

    pub def japanese(): Locale =
        import static get java.util.Locale.JAPANESE: ##java.util.Locale \ {} as get_JAPANESE;
        Locale(get_JAPANESE())

    pub def korea(): Locale =
        import static get java.util.Locale.KOREA: ##java.util.Locale \ {} as get_KOREA;
        Locale(get_KOREA())

    pub def korean(): Locale =
        import static get java.util.Locale.KOREAN: ##java.util.Locale \ {} as get_KOREAN;
        Locale(get_KOREAN())

    pub def prc(): Locale =
        import static get java.util.Locale.PRC: ##java.util.Locale \ {} as get_PRC;
        Locale(get_PRC())


    pub def simplified_chinese(): Locale =
        import static get java.util.Locale.SIMPLIFIED_CHINESE: ##java.util.Locale \ {} as get_SIMPLIFIED_CHINESE;
        Locale(get_SIMPLIFIED_CHINESE())

    pub def taiwan(): Locale =
        import static get java.util.Locale.TAIWAN: ##java.util.Locale \ {} as get_TAIWAN;
        Locale(get_TAIWAN())

    pub def traditional_chinese(): Locale =
        import static get java.util.Locale.TRADITIONAL_CHINESE: ##java.util.Locale \ {} as get_TRADITIONAL_CHINESE;
        Locale(get_TRADITIONAL_CHINESE())

    pub def uk(): Locale =
        import static get java.util.Locale.UK: ##java.util.Locale \ {} as get_UK;
        Locale(get_UK())

    pub def us(): Locale =
        import static get java.util.Locale.US: ##java.util.Locale \ {} as get_US;
        Locale(get_US())

}
