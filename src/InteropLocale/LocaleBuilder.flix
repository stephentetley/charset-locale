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

        def newLocaleBuilder(): State[<State.Open>]

        def clear(st: State[<State.Open>]): State[<State.Open>]

        def clearExtensions(st: State[<State.Open>]): State[<State.Open>]
    
        def addUnicodeLocaleAttribute(attr: String, st: State[<State.Open>]): State[<State.Open>]

        def removeUnicodeLocaleAttribute(attr: String, st: State[<State.Open>]): State[<State.Open>]

        def setExtension(k: Char, v: String, st: State[<State.Open>]): State[<State.Open>]

        def setLanguage(lang: String, st: State[<State.Open>]): State[<State.Open>]

        def setLanguageTag(tag: String, st: State[<State.Open>]): State[<State.Open>]

        def setLocale(loc: Locale, st: State[<State.Open>]): State[<State.Open>]

        def setRegion(rgn: String, st: State[<State.Open>]): State[<State.Open>]

        def setScript(script: String, st: State[<State.Open>]): State[<State.Open>]

        def setUnicodeLocaleKeyword(key: String, ty: String, st: State[<State.Open>]): State[<State.Open>]

        def setVariant(variant: String, st: State[<State.Open>]): State[<State.Open>]

        def build(st: State[<State.Open>]): State[<State.Closed>]
    }


    restrictable enum State[i] {
        case Open(JLocaleBuilder)
        case Closed(JLocale)
    }



    def handle(f: a -> State[<State.Closed>] \ ef): a -> Result[String, Locale] \ (ef - LocaleBuilder - Fail) = x -> {
        def getLocale(st) = 
            choose st {
                case State.Closed(jloc) => jloc
            };
        let ans = run {
            Ok(f(x))
        } with handler LocaleBuilder {

            def newLocaleBuilder(k) = {
                let jbuilder = unsafe IO as {ef - LocaleBuilder} { new JLocaleBuilder() };
                k(State.Open(jbuilder))
            }


            def clear(st, k) = choose st {
                case State.Open(jbuilder) => {
                    let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.clear() };
                    k(State.Open(jbuilder1))
                }
            }
        
            def clearExtensions(st, k) = choose st {
                case State.Open(jbuilder) => {
                    let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.clearExtensions() };
                    k(State.Open(jbuilder1))
                }
            }
            
            def addUnicodeLocaleAttribute(attr, st, k) = 
                try {
                    choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.addUnicodeLocaleAttribute(attr) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }
            
            def removeUnicodeLocaleAttribute(attr, st, k) = 
                try {
                    choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.removeUnicodeLocaleAttribute(attr) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setExtension(key, val, st, k) = 
                try {
                    choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setExtension(key, val) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setLanguage(lang, st, k) = 
                try {
                    choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setLanguage(lang) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setLanguageTag(tag, st, k) = 
                try {
                    choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setLanguageTag(tag) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setLocale(loc, st, k) = 
                try {
                  choose st {
                        case State.Open(jbuilder) => {
                            let jloc1 = ToJava.toJava(loc);
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setLocale(jloc1) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setRegion(rgn, st, k) = 
                try {
                    choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setRegion(rgn) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setScript(script, st, k) = 
                try {
                    choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setScript(script) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setUnicodeLocaleKeyword(key, ty, st, k) = 
                try {
                   choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setUnicodeLocaleKeyword(key, ty) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def setVariant(variant, st, k) = 
                try {
                   choose st {
                        case State.Open(jbuilder) => {
                            let jbuilder1 = unsafe IO as {ef - LocaleBuilder} { jbuilder.setVariant(variant) };
                            k(State.Open(jbuilder1))
                        }
                    }
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            def build(st, k) = choose st {
                case State.Open(jbuilder) => {
                    let jloc = unsafe IO as {ef - LocaleBuilder} { jbuilder.build() };
                    k(State.Closed(jloc))
                }
            }

        } with handler Fail {
            def report(s, _) = Err(s)
        };
        Result.map(getLocale >> ToFlix.toFlix, ans)
    }

    pub def runLocaleBuilder(buildfun: Unit -> State[<State.Closed>] \ ef): Result[String, Locale] \ (ef - LocaleBuilder - Fail)  = 
        handle(buildfun)()



}
