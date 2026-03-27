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



pub mod InteropLocale.Charset {
 
    use InteropLocale.Locale.{Locale}
    import java.nio.charset.{Charset => JCharset}
    import java.nio.charset.{StandardCharsets}
    import java.util.{Map => JMap, SortedMap => JSortedMap, Set => JSet,
            Locale => JLocale}

    ///
    /// Represents a Charset.
    ///
    pub enum Charset(JCharset)

    instance ToString[Charset] {
        pub def toString(c: Charset): String = 
            let Charset.Charset(c1) = c;
            unsafe IO { c1.toString() }
    }

    instance Eq[Charset] {
        pub def eq(x: Charset, y: Charset): Bool = 
            let Charset.Charset(x1) = x;
            let Charset.Charset(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Order[Charset] {
        pub def compare(x: Charset, y: Charset): Comparison =
            let Charset.Charset(x1) = x;
            let Charset.Charset(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance Hash[Charset] {
        pub def hash(c: Charset): Int32 = 
            let Charset.Charset(c1) = c;
            unsafe IO { c1.hashCode() }
    }

    pub def defaultCharset(): Charset \ IO =
        Charset.Charset(JCharset.defaultCharset())

    pub def iso_8859_1(): Charset =
        Charset.Charset(unsafe IO { StandardCharsets.ISO_8859_1 })

    pub def us_ascii(): Charset =
        Charset.Charset(unsafe IO { StandardCharsets.US_ASCII })

    pub def utf_16(): Charset =
        Charset.Charset(unsafe IO { StandardCharsets.UTF_16 })

    pub def utf_16be(): Charset =
        Charset.Charset(unsafe IO { StandardCharsets.UTF_16BE })

    pub def utf_16le(): Charset =
        Charset.Charset(unsafe IO { StandardCharsets.UTF_16LE })

    pub def utf_8(): Charset =
        Charset.Charset(unsafe IO { StandardCharsets.UTF_8 })

    pub def forName(name: String): Result[String, Charset] =
        Result.tryCatch(_ -> {
            Charset.Charset(unsafe IO { JCharset.forName(name) })
        })

    pub def isSupported(name: String): Result[String, Bool] \ IO =
        Result.tryCatch(_ -> {
            JCharset.isSupported(name)
        })

    /// 
    /// Returns the canonical name of Charset `c`.
    /// 
    pub def name(c: Charset): String =
        let Charset.Charset(c1) = c;
        unsafe IO { c1.name() }

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the system's default locale.
    ///
    pub def displayName(c: Charset): String \ IO =
        let Charset.Charset(c1) = c;
        c1.displayName()

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the supplied locale.
    ///    
    pub def displayNameWithLocale(locale: Locale, c: Charset): String =
        let Charset.Charset(c1) = c;
        let Locale.Locale(locale1) = locale;
        unsafe IO { c1.displayName(locale1) }

    pub def isRegistered(c: Charset): Bool =
        let Charset.Charset(c1) = c;
        unsafe IO { c1.isRegistered() }

    pub def canEncode(c: Charset): Bool =
        let Charset.Charset(c1) = c;
        unsafe IO { c1.canEncode() }

    pub def contains(x: Charset, y: Charset): Bool =
        let Charset.Charset(x1) = x;
        let Charset.Charset(y1) = y;
        unsafe IO { x1.contains(y1) }

    pub def aliases(x: Charset): Set[String] =
        let Charset.Charset(x1) = x;
        unsafe IO { x1.aliases() } |> Adaptor.fromSet


    pub def availableCharsets(): Map[String, Charset] \ IO =
        let m: JSortedMap[String, JCharset] = JCharset.availableCharsets();
        let m1: JMap[String, JCharset] = checked_cast(m);
        m1 |> Adaptor.fromMap |> Map.map(Charset.Charset)

}
