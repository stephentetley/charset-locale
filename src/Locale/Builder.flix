/*
 * Copyright 2024 Stephen Tetley
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

mod Locale {
    
    import java.util.{Locale$Builder => JLocaleBuilder}

    eff LocaleBuilder {
        def currentLocaleBuilder(): JLocaleBuilder
        def fail(msg: String): Void
    }

}


mod Locale.Builder {

    use Locale.{Locale}
    use Locale.LocaleBuilder
    import java.util.{Locale$Builder => JLocaleBuilder}

    pub def handle(build: a -> b \ ef): a -> Result[String, Locale] \ (ef - LocaleBuilder) =
        let builder = unsafe new JLocaleBuilder();
        x -> let ans = run {
            Ok(build(x))
        } with handler LocaleBuilder {
            def currentLocaleBuilder(k) = {
                k(builder)
            }
            def fail(msg, _k) = {
                checked_ecast(Err(msg))
            }
        };
        match ans {
            case Ok(_)    => Ok(Locale(unsafe builder.build()))
            case Err(msg) => Err(msg)
        }

    pub def build(buildfun: Unit -> a \ ef): Result[String, Locale] \ (ef - LocaleBuilder) = handle(buildfun)()



    pub def clear(): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.clear();
        ()

    pub def clearExtensions(): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.clearExtensions();
        ()
    
    pub def addUnicodeLocaleAttribute(attr: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.addUnicodeLocaleAttribute(attr);
        ()

    pub def removeUnicodeLocaleAttribute(attr: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.removeUnicodeLocaleAttribute(attr);
        ()

    pub def setExtension(k: Char, v: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.setExtension(k, v);
        ()

    pub def setLanguage(lang: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.setLanguage(lang);
        ()

    pub def setLanguageTag(tag: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.setLanguageTag(tag);
        ()

    pub def setLocale(loc: Locale): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let Locale(loc1) = loc;
        let _ = unsafe builder.setLocale(loc1);
        ()

    pub def setRegion(rgn: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.setVariant(rgn);
        ()

    pub def setScript(script: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.setScript(script);
        ()

    pub def setUnicodeLocaleKeyword(key: String, ty: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.setUnicodeLocaleKeyword(key, ty);
        ()

    pub def setVariant(variant: String): Unit \ LocaleBuilder = 
        let builder = Locale.LocaleBuilder.currentLocaleBuilder();
        let _ = unsafe builder.setVariant(variant);
        ()

}
