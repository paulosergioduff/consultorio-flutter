setDomain(str) {
  //split string
  var arr = str.split('@');
  var domain = arr[1];
  var result = domain.toString();

  return result;
}
//String domain = setDomain("usuario@nova-iguacu.com.br").toString();
//print("$domain");
