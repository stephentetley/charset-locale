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

}


mod Locale.Builder {

    use IoError.ErrorKind
    use IoError.IoError
    use Locale.{Locale}
    use Locale.LocaleBuilder

    import java.util.{Locale$Builder => JLocaleBuilder}
    import java.util.IllformedLocaleException
    import java.lang.NullPointerException 

    pub def handle(build: a -> b \ ef): a -> Result[IoError, Locale] \ ef - LocaleBuilder + IO =
        let builder = unsafe new JLocaleBuilder();
        x -> let ans = run {
            Ok(build(x))
        } with handler LocaleBuilder {
            def clear(k) = {
                builder.clear();
                k()
            }
        
            def clearExtensions(k) = {
                builder.clearExtensions();
                k()
            }
            
            def addUnicodeLocaleAttribute(attr, k) = try {
                builder.addUnicodeLocaleAttribute(attr);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
                case ex: NullPointerException  => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }
            
            def removeUnicodeLocaleAttribute(attr, k) = try {
                builder.removeUnicodeLocaleAttribute(attr);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
                case ex: NullPointerException  => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }

            def setExtension(key, val, k) = try {
                builder.setExtension(key, val);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }


            def setLanguage(lang, k) = try {
                builder.setLanguage(lang);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }

            def setLanguageTag(tag, k) = try {
                builder.setLanguageTag(tag);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }

            def setLocale(loc, k) = try {
                let Locale(loc1) = loc;
                builder.setLocale(loc1);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
                case ex: NullPointerException  => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }

            def setRegion(rgn, k) = try {
                builder.setRegion(rgn);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }

            def setScript(script, k) = try {
                builder.setScript(script);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }

            def setUnicodeLocaleKeyword(key, ty, k) = try {
                builder.setUnicodeLocaleKeyword(key, ty);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
                case ex: NullPointerException  => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }

            def setVariant(variant, k) = try {
                builder.setVariant(variant);
                k()
            } catch {
                case ex: IllformedLocaleException => Err(IoError(ErrorKind.InvalidInput, ex.getMessage()))
            }


        };
        match ans {
            case Ok(_)    => Ok(Locale(unsafe builder.build()))
            case Err(msg) => Err(msg)
        }

    pub def runWithIO(buildfun: Unit -> a \ ef): Result[IoError, Locale] \ (ef - LocaleBuilder) + IO = 
        handle(buildfun)()



}
