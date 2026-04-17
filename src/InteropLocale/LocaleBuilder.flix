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

    use InteropLocale.Locale.Locale

    import java.util.{Locale$Builder => JLocaleBuilder}
    import java.util.{Locale => JLocale}
    import java.lang.{Exception}


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

    pub def handle(f: a -> b \ ef): a -> Result[String, (Locale, b)] \ (ef - LocaleBuilder) = x ->
        region rc {
            handleHelper(rc, f, x)
        }


    // Use a region rather than IO...
    def handleHelper(_: Region[r], f: a -> b \ ef): a -> Result[String, (Locale, b)] \ (ef - LocaleBuilder + r) =
        x -> {
            let builder = unsafe IO { new JLocaleBuilder() };
            let ans = run {
                Ok(f(x))
            } with handler LocaleBuilder {
                
                def clear(k) = {
                    unsafe IO as r { discard builder.clear() };
                    k()
                }
            
                def clearExtensions(k) = {
                    unsafe IO as r { discard builder.clearExtensions() };
                    k()
                }
                
                def addUnicodeLocaleAttribute(attr, k) = try {
                    unsafe IO as r { discard builder.addUnicodeLocaleAttribute(attr) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }
                
                def removeUnicodeLocaleAttribute(attr, k) = try {
                    unsafe IO as r { discard builder.removeUnicodeLocaleAttribute(attr) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setExtension(key, val, k) = try {
                    unsafe IO as r { discard builder.setExtension(key, val) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setLanguage(lang, k) = try {
                    unsafe IO as r { discard builder.setLanguage(lang) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setLanguageTag(tag, k) = try {
                    unsafe IO as r { discard builder.setLanguageTag(tag) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setLocale(loc, k) = try {
                    let Locale.Locale(loc1) = loc;
                    unsafe IO as r { discard builder.setLocale(loc1) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setRegion(rgn, k) = try {
                    unsafe IO as r { discard builder.setRegion(rgn) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setScript(script, k) = try {
                    unsafe IO as r { discard builder.setScript(script) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setUnicodeLocaleKeyword(key, ty, k) = try {
                    unsafe IO as r { discard builder.setUnicodeLocaleKeyword(key, ty) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setVariant(variant, k) = try {
                    unsafe IO as r { discard builder.setVariant(variant) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }


            };
            match ans {
                case Ok(ans1)    => { 
                    let jloc: JLocale = unsafe IO { builder.build() };
                    Ok((Locale.Locale(jloc), ans1))
                }
                case Err(msg) => Err(msg)
            }
        }

    pub def runLocaleBuilder(buildfun: Unit -> a \ ef): Result[String, (Locale, a)] \ (ef - LocaleBuilder)  = 
        handle(buildfun)()



}
