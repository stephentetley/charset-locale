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

    @test
    def run01(): Bool =
        let action = () -> {
            let _ = Locale.Builder.setLanguage("sr");
            let _ = Locale.Builder.setScript("Latn");
            let _ = Locale.Builder.setRegion("RS");
            ()
        };
        Locale.Builder.build(action) |> Result.isOk


}
