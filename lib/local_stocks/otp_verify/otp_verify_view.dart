import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Generation with Provider',
      initialRoute: '/',
      onGenerateRoute: name,
    );
  }

  Route<dynamic>? name(settings) {
      if (settings.name == '/') {
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      } else if (settings.name == '/details') {
        return MaterialPageRoute(
          builder: (context) => DetailsScreen(),
        );
      }
      // Handle other routes as needed
      return null;
    }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: '),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/details');
              },
              child: Text('Go to Details'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // counterProvider.incrementCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: '),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}

