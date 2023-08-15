/*
 * Copyright 2022 Stephen Tetley
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
/// Represents a Charset.
///
enum Charset(##java.nio.charset.Charset)

mod Charset {
 
    use Locale.{Locale}

    pub def defaultCharset(): Charset \ IO =
        import static java.nio.charset.Charset.defaultCharset(): ##java.nio.charset.Charset \ IO;
        Charset(defaultCharset())

    pub def iso_8859_1(): Charset =
        import static get java.nio.charset.StandardCharsets.ISO_8859_1: ##java.nio.charset.Charset \ {} as get_ISO_8859_1;
        Charset(get_ISO_8859_1())

    pub def us_ascii(): Charset =
        import static get java.nio.charset.StandardCharsets.US_ASCII: ##java.nio.charset.Charset \ {} as get_US_ASCII;
        Charset(get_US_ASCII())

    pub def utf_16(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16: ##java.nio.charset.Charset \ {} as get_UTF_16;
        Charset(get_UTF_16())

    pub def utf_16be(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16BE: ##java.nio.charset.Charset \ {} as get_UTF_16BE;
        Charset(get_UTF_16BE())

    pub def utf_16le(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16LE: ##java.nio.charset.Charset \ {} as get_UTF_16LE;
        Charset(get_UTF_16LE())

    pub def utf_8(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_8: ##java.nio.charset.Charset \ {} as get_UTF_8;
        Charset(get_UTF_8())

    pub def forName(name: String): Result[String, Charset] =
        Result.tryCatch(_ -> {
            import static java.nio.charset.Charset.forName(String): ##java.nio.charset.Charset \ {};
            Charset(forName(name))
        })

    pub def isSupported(name: String): Result[String, Bool] \ IO =
        Result.tryCatch(_ -> {
            import static java.nio.charset.Charset.isSupported(String): Bool \ IO;
            isSupported(name)
        })

    /// 
    /// Returns the canonical name of Charset `c`.
    /// 
    pub def name(c: Charset): String =
        import java.nio.charset.Charset.name(): String \ {};
        let Charset(c1) = c;
        name(c1)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the system's default locale.
    ///
    pub def displayName(c: Charset): String \ IO =
        import java.nio.charset.Charset.displayName(): String \ IO;
        let Charset(c1) = c;
        displayName(c1)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the supplied locale.
    ///    
    pub def displayNameWithLocale(locale: Locale, cs: Charset): String =
        import java.nio.charset.Charset.displayName(##java.util.Locale): String \ {};
        let Charset(cs1) = cs;
        let Locale(locale1) = locale;
        displayName(cs1, locale1)

    pub def isRegistered(cs: Charset): Bool =
        import java.nio.charset.Charset.isRegistered(): Bool \ {};
        let Charset(cs1) = cs;
        isRegistered(cs1)

    pub def canEncode(cs: Charset): Bool =
        import java.nio.charset.Charset.canEncode(): Bool \ {};
        let Charset(cs1) = cs;
        canEncode(cs1)

    pub def contains(x: Charset, y: Charset): Bool =
        import java.nio.charset.Charset.contains(##java.nio.charset.Charset): Bool \ {};
        let Charset(x1) = x;
        let Charset(y1) = y;
        contains(x1, y1)

    pub def aliases(x: Charset): Set[String] =
        import java.nio.charset.Charset.aliases(): ##java.util.Set \ {};
        let Charset(x1) = x;
        aliases(x1) |> Adaptor.fromSet


    pub def availableCharsets(): Map[String, Charset] \ IO = 
        import static java.nio.charset.Charset.availableCharsets(): ##java.util.SortedMap \ IO;
        let m = unchecked_cast(availableCharsets() as ##java.util.Map);
        m |> Adaptor.fromMap |> Map.map(v -> Charset(v))

}
