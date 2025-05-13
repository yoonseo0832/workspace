package com.kh.opendata.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.opendata.model.vo.AirVO;

@Service
public class APIService {
  /**
   * 공공데이터 API를 사용하여 대기오염 정보 조회
   * @param sidoName 지역명
   * @return 대기오염 조회 결과
   */
  
  private static final String SERVICE_KEY= "cJwQGXshJwUq%2F1P%2F6RlKRdoqk99jixRyrNjH%2FSEhVm7nnGt0LjC1afBs1CkGZ%2FVUX4%2BgfcNk5kenLTkciIT09Q%3D%3D";
  public List<AirVO> getAirPollution(String sidoName) throws UnsupportedEncodingException{
    String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
    url += "?serviceKey=" + SERVICE_KEY;
    url += "&sidoName="+URLEncoder.encode(sidoName, "UTF-8");
    url += "&returnType=json";
    
    
    ArrayList<AirVO> list = new ArrayList<>();
    
    try {
      URL reqUrl = new URL(url);
      HttpURLConnection urlConn = (HttpURLConnection)reqUrl.openConnection();
      urlConn.setRequestMethod("GET");
      String holeText = "";
      if(urlConn.getResponseCode() >= 200 && urlConn.getResponseCode() <= 300) {
        BufferedReader bufRead = new BufferedReader( new InputStreamReader( urlConn.getInputStream()));
        String line;
        while((line = bufRead.readLine()) != null) {
          holeText += line;
        }
        bufRead.close();
        urlConn.disconnect();
        
        System.out.println(holeText);
        
        JsonObject totalObj = JsonParser.parseString(holeText).getAsJsonObject();
        JsonObject responseObj = totalObj.getAsJsonObject("response");
        System.out.println(responseObj);
        JsonObject bodyObj = responseObj.getAsJsonObject("body");
        System.out.println(bodyObj);
        int totalCount = bodyObj.get("totalCount").getAsInt();
        System.out.println(totalCount);
        JsonArray items = bodyObj.getAsJsonArray("items");
        for(int i=0; i<items.size(); i++) {
          JsonObject item = items.get(i).getAsJsonObject();
          AirVO air = new AirVO();
          
          air.setStationName(item.get("stationName").getAsString());
          air.setDataTime(item.get("dataTime").getAsString());
          air.setCoValue(item.get("coValue").getAsString());
          air.setKhaiValue(item.get("khaiValue").getAsString());
          air.setNo2Value(item.get("no2Value").getAsString());
          air.setO3Value(item.get("o3Value").getAsString());
          air.setSo2Value(item.get("so2Value").getAsString());
          air.setPm10Value(item.get("pm10Value").getAsString());
          
          list.add(air);
        }
        for(AirVO air : list) {
          System.out.println(air);
        }
      }else {
        BufferedReader bufRead = new BufferedReader( new InputStreamReader( urlConn.getErrorStream()));
        bufRead.close();
        urlConn.disconnect();
      }
      
     
    } catch (IOException e) {
      e.printStackTrace();
    }
    return list;
   
  }
}
