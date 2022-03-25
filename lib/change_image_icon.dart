import 'package:flutter/material.dart';

AssetImage backChange(double temp) {
  if (temp > 30) {
    return AssetImage('assets/images/hot.jpg');
  } else if (temp >= 20 && temp <= 30) {
    return AssetImage('assets/images/sunny.jpg');
  } else if (temp >= 5 && temp <= 20) {
    return AssetImage('assets/images/few_could.jpg');
  } else {
    return AssetImage('assets/images/cold.jpg');
  }
}


AssetImage iconChange(String description) {
  if (description == "dust") {
    return AssetImage('assets/icons/partly_cloudy.png');
  } else if (description == "few clouds") {
    return AssetImage('assets/icons/rain_s_cloudy.png');
  } else if (description == "clear sky") {
    return AssetImage('assets/icons/sunny_s_cloudy.png');
  } else if (description == "overcast clouds") {
    return AssetImage('assets/icons/cloudy.png');
<<<<<<< HEAD
  } else if (description == "light rain") {
    return AssetImage('assets/icons/sunny.png');
=======
  } else if (description == "scattered clouds") {
    return AssetImage('assets/icons/rain_light.png');
>>>>>>> dffb0b88cdc9c4659336e564261d41d4168e0b0d
  } else if (description == 'sunny') {
    return AssetImage('assets/icons/sunny.png');
  } else {
    return AssetImage('assets/icons/snow_s_cloudy.png');
  }
<<<<<<< HEAD
}

Color textColor(double temp) {
if(temp>30){
  return Colors.red;
}
else if(temp>=20 && temp<30){
  return Colors.black;
}
else if (temp >= 5 && temp <= 20) {
  return Colors.black;
} else {
  return Colors.white;
}
=======
>>>>>>> dffb0b88cdc9c4659336e564261d41d4168e0b0d
}