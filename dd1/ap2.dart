void main(List<String> args) {
  final lista = [0.0, 4.2, 15.0, 18.1, 21.7, 32.0, 40.0, 41.0];


  for (var temp in lista) {

    var f = (temp*1.8) +32;
    var k = temp + 273;

    print("Celcius $temp, Fahrenheit ${f.toStringAsFixed(2)}, Kelvin ${k.toStringAsFixed(2)}");
    
  }
}
