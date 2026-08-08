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



pub mod InteropLocale.LocaleBuilder {


    use EffectExtras.Fail.Fail
    use InteropLocale.Locale.Locale

    import java.util.{Locale$Builder => JLocaleBuilder}
    import java.util.{Locale => JLocale}
    import java.lang.{Exception => JException}




    pub eff LocaleBuilder {

        def clear(): Unit

        def clearExtensions(): Unit
    
        def addUnicodeLocaleAttribute(attr: String): Unit

        def removeUnicodeLocaleAttribute(attr: String): Unit

        def setExtension(k: Char, v: String): Unit

        def setLanguage(lang: String): Unit

        def setLanguageTag(tag: String): Unit

        def setLocale(loc: Locale): Unit

        def setRegion(rgn: String): Unit

        def setScript(script: String): Unit

        def setUnicodeLocaleKeyword(key: String, ty: String): Unit

        def setVariant(variant: String): Unit

    }



    def handle(f: a -> b \ ef): a -> (Locale, b) \ (ef + Fail - LocaleBuilder) = x -> {
        let jbuilder: JLocaleBuilder = unsafe IO as {} { new JLocaleBuilder() };
        let ans = run {
            f(x)
        } with handler LocaleBuilder {

            def clear(k) = {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.clear() };
                k()
            }

            def clearExtensions(k) = {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.clearExtensions() };
                k()
            }

            def addUnicodeLocaleAttribute(attr, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.addUnicodeLocaleAttribute(attr) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }
            
            def removeUnicodeLocaleAttribute(attr, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.removeUnicodeLocaleAttribute(attr) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setExtension(key, val, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setExtension(key, val) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setLanguage(lang, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setLanguage(lang) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setLanguageTag(tag, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setLanguageTag(tag) };
                k()
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setLocale(loc, k) = try {
                let jloc1 = ToJava.toJava(loc);
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setLocale(jloc1) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setRegion(rgn, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setRegion(rgn) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setScript(script, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setScript(script) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setUnicodeLocaleKeyword(key, ty, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setUnicodeLocaleKeyword(key, ty) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setVariant(variant, k) = try {
                discard unsafe IO as {ef + Fail - LocaleBuilder} { jbuilder.setVariant(variant) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }
        };
        let jloc = unsafe IO as {} { jbuilder.build() };
        (ToFlix.toFlix(jloc), ans)
    }

    pub def runLocaleBuilder(buildfun: Unit -> a \ ef): (Locale, a) \ (ef + Fail - LocaleBuilder)  = 
        handle(buildfun)()

    pub def execLocaleBuilder(buildfun: Unit -> a \ ef): Locale \ (ef + Fail - LocaleBuilder)  = 
        handle(buildfun)() |> fst

    pub def runLocaleBuilderWithResult(buildfun: Unit -> a \ ef): Result[String, (Locale, a)] \ (ef - Fail - LocaleBuilder)  = 
        run { handle(buildfun)() } with EffectExtras.Fail.runWithResult

    pub def execLocaleBuilderWithResult(buildfun: Unit -> a \ ef): Result[String, Locale] \ (ef - Fail - LocaleBuilder)  = 
        { run { handle(buildfun)() } with EffectExtras.Fail.runWithResult } |> Result.map(fst)

}

