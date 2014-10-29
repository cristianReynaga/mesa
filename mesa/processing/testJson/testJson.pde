
String uno= "11:00";
String dos= "14:15";
String tres= "18:00";

JSONObject json;

void setup() {
  size(640, 480);
}


void draw() {

  background(255, 120, 120);
  json=loadJSONObject("innovatiba.json");

  JSONArray aAgenda= json.getJSONArray("agenda");

  for (int i=0;i<aAgenda.size();i++) {
    JSONObject agenda = aAgenda.getJSONObject(i);
    int id= agenda.getInt("id");
    String time= agenda.getString("time");
    println(id+ " "+ time);
  }


  textSize(36);
  String hora= str(second());
  text(hora, 20, 220);
  String _min="0";
  /*
  if (_min.equals(hora)) {
   println("OK!!!");
   }
   */
}

