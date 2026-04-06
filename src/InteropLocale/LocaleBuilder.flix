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
                    unchecked_cast(discard builder.clear() as _ \ r);
                    k()
                }
            
                def clearExtensions(k) = {
                    unchecked_cast(discard builder.clearExtensions() as _ \ r);
                    k()
                }
                
                def addUnicodeLocaleAttribute(attr, k) = try {
                    unchecked_cast(discard builder.addUnicodeLocaleAttribute(attr) as _ \r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }
                
                def removeUnicodeLocaleAttribute(attr, k) = try {
                    unchecked_cast(discard builder.removeUnicodeLocaleAttribute(attr) as _ \ r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setExtension(key, val, k) = try {
                    unchecked_cast(discard builder.setExtension(key, val) as _ \r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setLanguage(lang, k) = try {
                    unchecked_cast(discard builder.setLanguage(lang) as _ \ r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setLanguageTag(tag, k) = try {
                    unchecked_cast(discard builder.setLanguageTag(tag) as _ \ r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setLocale(loc, k) = try {
                    let Locale.Locale(loc1) = loc;
                    unchecked_cast(discard builder.setLocale(loc1) as _ \ r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setRegion(rgn, k) = try {
                    unchecked_cast(discard builder.setRegion(rgn) as _ \ r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setScript(script, k) = try {
                    unchecked_cast(discard builder.setScript(script) as _ \r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setUnicodeLocaleKeyword(key, ty, k) = try {
                    unchecked_cast(discard builder.setUnicodeLocaleKeyword(key, ty) as _ \ r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def setVariant(variant, k) = try {
                    unchecked_cast(discard builder.setVariant(variant) as _ \ r);
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
