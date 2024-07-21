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

use Charset.{Charset}

///
/// Represents a Charset.
///
enum Charset(##java.nio.charset.Charset)

instance ToString[Charset] {
    pub def toString(cs: Charset): String = 
        import java.nio.charset.Charset.toString(): String \ {};
        let Charset(cs1) = cs;
        toString(cs1)
}

instance Eq[Charset] {
    pub def eq(x: Charset, y: Charset): Bool = 
        import java.nio.charset.Charset.equals(##java.lang.Object): Bool \ {};
        let Charset(x1) = x;
        let Charset(y1) = y;
        equals(x1, checked_cast(y1))
}

instance Order[Charset] {
    pub def compare(x: Charset, y: Charset): Comparison =
        import java.nio.charset.Charset.compareTo(##java.nio.charset.Charset): Int32 \ {};
        let Charset(x1) = x;
        let Charset(y1) = y;
        compareTo(x1, y1) |> Comparison.fromInt32
}

instance Hash[Charset] {
    pub def hash(cs: Charset): Int32 = 
        import java.nio.charset.Charset.hashCode(): Int32 \ {};
        let Charset(cs1) = cs;
        hashCode(cs1)
}

mod Charset {
 
    use Locale.{Locale}
    import java.nio.charset.{Charset => JCharset}


    pub def defaultCharset(): Charset \ IO =
        import static java.nio.charset.Charset.defaultCharset(): JCharset \ IO;
        Charset(defaultCharset())

    pub def iso_8859_1(): Charset =
        import static java_get_field java.nio.charset.StandardCharsets.ISO_8859_1: JCharset \ {} as get_ISO_8859_1;
        Charset(get_ISO_8859_1())

    pub def us_ascii(): Charset =
        import static java_get_field java.nio.charset.StandardCharsets.US_ASCII: JCharset \ {} as get_US_ASCII;
        Charset(get_US_ASCII())

    pub def utf_16(): Charset =
        import static java_get_field java.nio.charset.StandardCharsets.UTF_16: JCharset \ {} as get_UTF_16;
        Charset(get_UTF_16())

    pub def utf_16be(): Charset =
        import static java_get_field java.nio.charset.StandardCharsets.UTF_16BE: JCharset \ {} as get_UTF_16BE;
        Charset(get_UTF_16BE())

    pub def utf_16le(): Charset =
        import static java_get_field java.nio.charset.StandardCharsets.UTF_16LE: JCharset \ {} as get_UTF_16LE;
        Charset(get_UTF_16LE())

    pub def utf_8(): Charset =
        import static java_get_field java.nio.charset.StandardCharsets.UTF_8: JCharset \ {} as get_UTF_8;
        Charset(get_UTF_8())

    pub def forName(name: String): Result[String, Charset] =
        Result.tryCatch(_ -> {
            import static java.nio.charset.Charset.forName(String): JCharset \ {};
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
        import java.nio.charset.Charset.contains(JCharset): Bool \ {};
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
