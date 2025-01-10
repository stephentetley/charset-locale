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
    import java.util.{Locale$LanguageRange => JLanguageRange}
    import java.lang.{Object}

    ///
    /// Represents a LanguageRange.
    ///
    pub enum LanguageRange(JLanguageRange)

    instance ToString[LanguageRange] {
        pub def toString(x: LanguageRange): String =
            let LanguageRange(x1) = x;
            unsafe x1.toString()
    }

    instance Eq[LanguageRange] {
        pub def eq(x: LanguageRange, y: LanguageRange): Bool =
            let LanguageRange(x1) = x;
            let LanguageRange(y1) = y;
            unsafe x1.equals(y1)
    }

    instance Hash[LanguageRange] {
        pub def hash(x: LanguageRange): Int32 =
            let LanguageRange(x1) = x;
            unsafe x1.hashCode()
    }

}


mod Locale.LanguageRange {

    use Locale.LanguageRange
    use Locale.LanguageRange.{LanguageRange}
    import java.util.{Locale$LanguageRange => JLanguageRange}
    import java.util.{List => JList, Map => JMap}

    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def make(range: String): Result[String, LanguageRange] =
        Result.tryCatch(_ -> {
            LanguageRange(unsafe new JLanguageRange(range))
        })


    pub def maxWeight(): Float64 = unsafe JLanguageRange.MAX_WEIGHT

    pub def minWeight(): Float64 = unsafe JLanguageRange.MIN_WEIGHT

    pub def getRange(x: LanguageRange): String =
        let LanguageRange(x1) = x;
        unsafe x1.getRange()

    pub def getWeight(x: LanguageRange): Float64 =
        let LanguageRange(x1) = x;
        unsafe x1.getWeight()

    pub def parse(ranges: String): Result[String, List[LanguageRange]] = 
        Result.tryCatch(_ -> {
            unsafe JLanguageRange.parse(ranges) |> Adaptor.fromList |> List.map(o -> LanguageRange(o))
        })


    pub def parseWithCustomizations(ranges: String, 
                                    customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] \ IO =
        Result.tryCatch(_ -> {
            let cust1 = Map.map(v -> Adaptor.toList(v), customizations);
            let cust2 = Adaptor.toMap(cust1);
            unsafe JLanguageRange.parse(ranges, cust2) |> Adaptor.fromList |> List.map(o -> LanguageRange(o))
        })

    pub def mapEquivalents(priorityList: List[LanguageRange], 
                            customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] \ IO =
        Result.tryCatch(_ -> {
            let ps1 = List.map(w -> {let LanguageRange(w1) = w; w1}, priorityList) |> Adaptor.toList;
            let cust1 = Map.map(v -> Adaptor.toList(v), customizations);
            let cust2 = Adaptor.toMap(cust1);
            unsafe JLanguageRange.mapEquivalents(ps1, cust2) |> Adaptor.fromList |> List.map(o -> LanguageRange(o))
        })

}   
