import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if(imc < 18.6){
        _infoText = 'Abaixo do peso! IMC: ${imc.toStringAsPrecision(3)}';
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = 'Peso ideal! IMC: ${imc.toStringAsPrecision(3)}';
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = 'Levemente acima do pseo! IMC: ${imc.toStringAsPrecision(3)}';
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = 'Obesidade Grau I! IMC: ${imc.toStringAsPrecision(3)}';
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = 'Obesidade Grau II! IMC: ${imc.toStringAsPrecision(3)}';
      } else if(imc >= 40){
        _infoText = 'Obesidade Grau III! IMC: ${imc.toStringAsPrecision(3)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.deepPurpleAccent,
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.deepPurpleAccent,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso (Em KG)',
                    labelStyle: TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 25,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Insira o seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura (Em CM)',
                    labelStyle: TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 25,
                  ),
                  controller: heightController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Insira o sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
