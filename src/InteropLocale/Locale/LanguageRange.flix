/*
 * Copyright 2023 Stephen Tetley
  *
 * Use of this source code is governed by the Apache 2.0 license
 * that can be found in the LICENSE.md file.
 */


pub mod InteropLocale.Locale.LanguageRange {

    use ee::EffectExtras.Fail.Fail

    import java.util.{Locale$LanguageRange => JLanguageRange}
    import java.util.{List => JList, Map => JMap}
    import java.lang.{Exception => JException}

    ///
    /// Represents a LanguageRange.
    ///
    pub enum LanguageRange(JLanguageRange)

    instance ToString[LanguageRange] {
        pub def toString(x: LanguageRange): String =
            let LanguageRange.LanguageRange(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[LanguageRange] {
        pub def eq(x: LanguageRange, y: LanguageRange): Bool =
            let LanguageRange.LanguageRange(x1) = x;
            let LanguageRange.LanguageRange(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[LanguageRange] {
        pub def hash(x: LanguageRange): Int32 =
            let LanguageRange.LanguageRange(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance ToJava[LanguageRange] {
        type Out = JLanguageRange
        pub def toJava(x: LanguageRange): JLanguageRange = 
            let LanguageRange.LanguageRange(x1) = x;
            x1
    }

    instance ToFlix[LanguageRange] {
        type In = JLanguageRange
        pub def toFlix(x: JLanguageRange): LanguageRange = LanguageRange.LanguageRange(x)
    }

    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def newLanguageRange(range: String): LanguageRange \ Fail[String] =
        try {
            LanguageRange.LanguageRange(unsafe IO { new JLanguageRange(range) })
        } catch {
            case ex: JException => Fail.report(ex.getMessage())
        }


    pub def maxWeight(): Float64 = unsafe IO { JLanguageRange.MAX_WEIGHT }

    pub def minWeight(): Float64 = unsafe IO { JLanguageRange.MIN_WEIGHT }

    pub def getRange(x: LanguageRange): String =
        let LanguageRange.LanguageRange(x1) = x;
        unsafe IO { x1.getRange() }

    pub def getWeight(x: LanguageRange): Float64 =
        let LanguageRange.LanguageRange(x1) = x;
        unsafe IO { x1.getWeight() }

    pub def parse(ranges: String): List[LanguageRange] \ Fail[String] = 
        try {
            unsafe IO { JLanguageRange.parse(ranges) } |> Adaptor.fromList |> List.map(LanguageRange.LanguageRange)
        } catch {
            case ex: JException => Fail.report(ex.getMessage())
        }


    pub def parseWithCustomizations(ranges: String, 
                                    customizations: Map[String, List[String]]): List[LanguageRange] \ IO + Fail[String] =
        try {
            let cust1 = Map.map(v -> Adaptor.toList(v), customizations);
            let cust2 = Adaptor.toMap(cust1);
            unsafe IO { JLanguageRange.parse(ranges, cust2) } 
                |> Adaptor.fromList 
                |> List.map(LanguageRange.LanguageRange) 
        } catch {
            case ex: JException => Fail.report(ex.getMessage())
        }

    pub def mapEquivalents(priorityList: List[LanguageRange], 
                            customizations: Map[String, List[String]]): List[LanguageRange] \ IO + Fail[String] =
        try {
            let ps1 = List.map(w -> {let LanguageRange.LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let cust1 = Map.map(v -> Adaptor.toList(v), customizations);
            let cust2 = Adaptor.toMap(cust1);
            unsafe IO { JLanguageRange.mapEquivalents(ps1, cust2) } 
                |> Adaptor.fromList 
                |> List.map(LanguageRange.LanguageRange)
        } catch {
            case ex: JException => Fail.report(ex.getMessage())
        }

}   
