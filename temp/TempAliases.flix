

def main(): Int32 \ IO = 
    let c = Charset.defaultCharset();
    let s = Charset.aliases(c);
    Set.forEach(println, s);
    let m = Charset.availableCharsets();
    Map.forEach((k,_v) -> println("Avialable ${k}:"), m);
    0