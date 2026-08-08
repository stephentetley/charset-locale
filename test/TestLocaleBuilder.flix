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

mod TestLocaleBuilder {
    use Assert.assertTrue

    use Assert.{assertTrue}
    use InteropLocale.LocaleBuilder.LocaleBuilder

    // Comparing Applicative builder to the original effect handler builder
    // (rather than the state passing experiment)...
    // I'm inclided to say the the effect handler builder wins out - semicolon
    // works naturally as a delimiter between operations; we can ignore binding
    // completely because the operations return Unit (don't even have to discard) 
    // and it is arguably closer to common Flix which favours effect handlers over 
    // monads / applicatives.


    @Test
    def run01(): Unit \ {Assert} =
        let ans = InteropLocale.LocaleBuilder.runLocaleBuilder(_ -> {
            LocaleBuilder.setLanguage("en");
            LocaleBuilder.setRegion("US")
        });
        assertTrue(Result.isOk(ans))

    @Test
    def run02(): Unit \ {Assert} =
        use Applicative.{*>};
        let ans = InteropLocale.LocaleBuilder.exec1( 
            InteropLocale.LocaleBuilder.setLanguage1("ENG") *> 
            InteropLocale.LocaleBuilder.setLanguage1("ENG")
        );
    assertTrue(Result.isOk(ans))
}
