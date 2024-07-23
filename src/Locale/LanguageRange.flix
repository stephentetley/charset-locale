/*
 * Copyright 2023 Stephen Tetley
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
    
    use Locale.LanguageRange.{LanguageRange}

    ///
    /// Represents a LanguageRange.
    ///
    pub enum LanguageRange(##java.util.Locale$LanguageRange)

    instance ToString[LanguageRange] {
        pub def toString(x: LanguageRange): String =
            import java.util.Locale$LanguageRange.toString(): String \ {};
            let LanguageRange(x1) = x;
            toString(x1)
    }

    instance Eq[LanguageRange] {
        pub def eq(x: LanguageRange, y: LanguageRange): Bool =
            import java.util.Locale$LanguageRange.equals(##java.lang.Object): Bool \ {};
            let LanguageRange(x1) = x;
            let LanguageRange(y1) = y;
            equals(x1, checked_cast(y1))
    }

    instance Hash[LanguageRange] {
        pub def hash(x: LanguageRange): Int32 =
            import java.util.Locale$LanguageRange.hashCode(): Int32 \ {};
            let LanguageRange(x1) = x;
            hashCode(x1)
    }

}


mod Locale.LanguageRange {

    use Locale.LanguageRange
    use Locale.LanguageRange.{LanguageRange}
    import java.util.{Locale$LanguageRange => JLanguageRange}

    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def make(range: String): Result[String, LanguageRange] =
        Result.tryCatch(_ -> {
            import java_new java.util.Locale$LanguageRange(String): JLanguageRange \ {} as new1;
            LanguageRange(new1(range))
        })


    pub def maxWeight(): Float64 =
        import static java_get_field java.util.Locale$LanguageRange.MAX_WEIGHT: Float64 \ {} as get_MAX_WEIGHT;
        get_MAX_WEIGHT()

    pub def minWeight(): Float64 =
        import static java_get_field java.util.Locale$LanguageRange.MIN_WEIGHT: Float64 \ {} as get_MIN_WEIGHT;
        get_MIN_WEIGHT()

    pub def getRange(x: LanguageRange): String =
        import java.util.Locale$LanguageRange.getRange(): String \ {};
        let LanguageRange(x1) = x;
        getRange(x1)

    pub def getWeight(x: LanguageRange): Float64 =
        import java.util.Locale$LanguageRange.getWeight(): Float64 \ {};
        let LanguageRange(x1) = x;
        getWeight(x1)

    pub def parse(ranges: String): Result[String, List[LanguageRange]] = 
        Result.tryCatch(_ -> {
            import static java.util.Locale$LanguageRange.parse(String): ##java.util.List \ {};
            parse(ranges) |> Adaptor.fromList |> List.map(o -> LanguageRange(o))
        })


    pub def parseWithCustomizations(ranges: String, 
                                    customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale$LanguageRange.parse(String, ##java.util.Map): ##java.util.List \ {};
            let cust1 = Map.map(v -> Adaptor.toList(v), customizations);
            let cust2 = Adaptor.toMap(cust1);
            parse(ranges, cust2) |> Adaptor.fromList |> List.map(o -> LanguageRange(o))
        })

    pub def mapEquivalents(priorityList: List[LanguageRange], 
                            customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale$LanguageRange.mapEquivalents(##java.util.List, ##java.util.Map): ##java.util.List \ {};
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let cust1 = Map.map(v -> Adaptor.toList(v), customizations);
            let cust2 = Adaptor.toMap(cust1);
            mapEquivalents(ps1, cust2) |> Adaptor.fromList |> List.map(o -> LanguageRange(o))
        })

}   
