def s = java.net.URLEncoder.encode('vekatkriish', "UTF-8")
String encoded = s.bytes.encodeBase64().toString()
println encoded

byte[] decoded = encoded.decodeBase64()
sString s1 == new String(decoded)
println s1