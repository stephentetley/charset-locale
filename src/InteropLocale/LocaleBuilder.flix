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
    use InteropLocale.LocaleBuilder.setScript1
    use InteropLocale.LocaleBuilder.setLanguage1
    use InteropLocale.LocaleBuilder

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



    def handle(f: a -> Unit \ ef): a -> Result[String, Locale] \ (ef - LocaleBuilder - Fail) = x -> {
        let jbuilder: JLocaleBuilder = unsafe IO as {} { new JLocaleBuilder() };
        let ans = run {
            Ok(f(x))
        } with handler LocaleBuilder {

    
            def clear(k) = {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.clear() };
                k()
            }

        
            def clearExtensions(k) = {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.clearExtensions() };
                k()
            }

            
            def addUnicodeLocaleAttribute(attr, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.addUnicodeLocaleAttribute(attr) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }
            
            def removeUnicodeLocaleAttribute(attr, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.removeUnicodeLocaleAttribute(attr) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setExtension(key, val, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setExtension(key, val) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setLanguage(lang, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setLanguage(lang) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setLanguageTag(tag, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setLanguageTag(tag) };
                k()
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setLocale(loc, k) = try {
                let jloc1 = ToJava.toJava(loc);
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setLocale(jloc1) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setRegion(rgn, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setRegion(rgn) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setScript(script, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setScript(script) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setUnicodeLocaleKeyword(key, ty, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setUnicodeLocaleKeyword(key, ty) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def setVariant(variant, k) = try {
                discard unsafe IO as {ef - LocaleBuilder} { jbuilder.setVariant(variant) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            // def build(k) = {
            //     let jloc = unsafe IO as {ef - LocaleBuilder} { jbuilder.build()  };
            //     k()
            // }

        } with handler Fail {
            def report(s, _) = Err(s)
        };
        let jloc = unsafe IO as {} { jbuilder.build() };
        Result.map(_ -> ToFlix.toFlix(jloc), ans)
    }

    pub def runLocaleBuilder(buildfun: Unit -> Unit \ ef): Result[String, Locale] \ (ef - LocaleBuilder - Fail)  = 
        handle(buildfun)()

    // Alternative...

    // We have simplified the effect handler builder to back to 
    // having operations return Unit rather than pass state in a 
    // restricted variant

    // The effect handler version again works when chained with (;), 
    // e.g.
    // >        LocaleBuilder.setLanguage("en");
    // >        LocaleBuilder.setRegion("US")
    //
    // This looks nice! The applicative version below now feels less
    // impressive.


    pub enum LocaleBuilder1[a: Type](JLocaleBuilder -> Result[String, (JLocaleBuilder, a)] \ IO)

    instance Functor[LocaleBuilder1] {
        pub def map(f: a -> b \ ef, x: LocaleBuilder1[a]): LocaleBuilder1[b] \ ef = 
            unchecked_cast(LocaleBuilder1.LocaleBuilder1(jbuild-> 
                let LocaleBuilder1.LocaleBuilder1(xf) = x;
                match xf(jbuild) { 
                    case Ok((jbuild1, a1)) => {
                        let a2 = unchecked_cast(f(a1) as _ \ IO);
                        Ok((jbuild1, a2))
                    }
                    case Err(msg) => Err(msg)
                }) as _ \ ef)
    }

    instance Applicative[LocaleBuilder1] {
        pub def point(x: a): LocaleBuilder1[a] = 
            LocaleBuilder1.LocaleBuilder1(jbuild -> checked_ecast(Ok((jbuild, x))))
        
        pub def ap(f: LocaleBuilder1[a -> b \ ef], x: LocaleBuilder1[a]): LocaleBuilder1[b] \ ef = 
            unchecked_cast(LocaleBuilder1.LocaleBuilder1(jbuild-> 
                let LocaleBuilder1.LocaleBuilder1(ff) = f;
                match ff(jbuild) {
                    case Ok((jbuild1, f2)) => {
                        let LocaleBuilder1.LocaleBuilder1(xf) = x;
                        match xf(jbuild1) {
                            case Ok((jbuild2, a1)) => { 
                                let a2 = unchecked_cast(f2(a1) as _ \ IO);
                                Ok((jbuild2, a2))
                            }
                            case Err(msg) => Err(msg)
                        }
                    }
                    case Err(msg) => Err(msg)
                }) as _ \ ef)
    }

    pub def setScript1(script: String): LocaleBuilder1[Unit] = 
        LocaleBuilder1.LocaleBuilder1(jbuild -> try {
            let jbuild1 =  jbuild.setScript(script) ;
            Ok((jbuild1, ()))
        } catch { 
            case _: JException => Err("setScript(${script})")
        })

    pub def setLanguage1(lang: String): LocaleBuilder1[Unit] = 
        LocaleBuilder1.LocaleBuilder1(jbuild -> try {
            let jbuild1 = jbuild.setLanguage(lang);
            Ok((jbuild1, ()))
        } catch { 
            case _: JException => Err("setLanguage(${lang})")
        })


    // Using "seqRight" gives us point free chaining
    pub def prgm1(): LocaleBuilder1[Unit] = 
        use Applicative.{*>};
        setLanguage1("ENG") *> setScript1("ENG")


    // Using forA gives us binding if we must (because all the 
    // operations return Unit there is nothing valuable to bind). 
    // Note - if we don't care about binding we have have no need 
    // for a Monad instance 
    pub def prgm2(): LocaleBuilder1[Unit] = 
        forA(_ <- setLanguage1("ENG");
             _ <- setScript1("ENG")
        ) yield()

    pub def build1(x: LocaleBuilder1[a]): Result[String, (Locale, a)] = unsafe IO as {} {
        let jbuild =  new JLocaleBuilder() ;
        let LocaleBuilder1.LocaleBuilder1(f) = x;
        match f(jbuild) { 
            case Ok((jbuild1, a1)) => {
                let jloc: JLocale = jbuild1.build() ;
                let jloc1 = ToFlix.toFlix(jloc);
                Ok((jloc1, a1))
            }
            case Err(msg) => Err(msg)
        }
    }
    
    pub def exec1(x: LocaleBuilder1[a]): Result[String, Locale] =
        build1(x) |> Result.map(fst)

}

