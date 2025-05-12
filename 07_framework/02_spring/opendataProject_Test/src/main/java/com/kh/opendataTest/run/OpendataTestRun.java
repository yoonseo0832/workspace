package com.kh.opendataTest.run;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.opendataTest.model.vo.OpendataVo;

public class OpendataTestRun {
  private static final String SERVICE_KEY = "cJwQGXshJwUq%2F1P%2F6RlKRdoqk99jixRyrNjH%2FSEhVm7nnGt0LjC1afBs1CkGZ%2FVUX4%2BgfcNk5kenLTkciIT09Q%3D%3D";
  public static void main(String[] args) throws IOException {
   String url = "http://apis.data.go.kr/B551177/StatusOfArrivals/getArrivalsCongestion";
   
   url += "?serviceKey="+ SERVICE_KEY;
   url += "&numOfRows="+ 10;
   url += "&pageNo="+1;
   url += "&type=json";
   
   System.out.println(url);
   
   URL requestUrl = new URL(url);
   HttpURLConnection urlConn = (HttpURLConnection)requestUrl.openConnection();
   urlConn.setRequestMethod("GET");
   
   BufferedReader buf = new BufferedReader(
                             new InputStreamReader(
                                     urlConn.getInputStream()
                                 )
                         );
   String line;
   String fullText = "";
   while((line = buf.readLine())!= null) {
     fullText += line;
   }
   buf.close();
   urlConn.disconnect();
   
   //System.out.println(fullText);
   
   JsonObject totalObj = JsonParser.parseString(fullText).getAsJsonObject();
   JsonObject responseObj = totalObj.getAsJsonObject("response");
   //System.out.println(responseObj);
   
   JsonObject bodyObj = responseObj.getAsJsonObject("body");
   //System.out.println(bodyObj);
   
   int totalCount = bodyObj.get("totalCount").getAsInt();
   //System.out.println(totalCount);
   
   JsonArray items = bodyObj.getAsJsonArray("items");
   //System.out.println(items);
   
   ArrayList<OpendataVo> list = new ArrayList<>();
   for(int i =0; i<items.size(); i++) {
     JsonObject item = items.get(i).getAsJsonObject();
     OpendataVo airport = new OpendataVo();
    
     airport.setAirport(item.get("airport").getAsString());
     airport.setEstimatedtime(item.get("estimatedtime").getAsString());
     airport.setFlightid(item.get("flightid").getAsString());
     airport.setForeigner(item.get("foreigner").getAsString());
     airport.setKorean(item.get("korean").getAsString());
     
     list.add(airport);
  }
   for(OpendataVo airport : list) {
     System.out.println(airport);
   }
  }
}
