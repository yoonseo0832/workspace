package com.kh.open.service;

import org.springframework.stereotype.Service;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.open.model.vo.DataVO;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;

@Service
public class OpenAPIService {
  @Value("${open.apikey}")
  private String serviceKey;
  
  public List<DataVO> getOpenData() throws IOException{
    String url = "https://www.safetydata.go.kr/V2/api/DSSP-IF-10944";
    url += "?serviceKey=" + serviceKey;
    url += "&returnType=json";
    
    ArrayList<DataVO> list = new ArrayList<>();
    
    URL reqUrl = new URL(url);
    HttpURLConnection urlConn = (HttpURLConnection)reqUrl.openConnection();
    urlConn.setRequestMethod("GET");
    // HttpServletResponse.SC_OK
    BufferedReader buf=null;
    
    if(urlConn.getResponseCode() == HttpServletResponse.SC_OK) {
      buf = new BufferedReader(new InputStreamReader (urlConn.getInputStream()));
    }else {
      buf = new BufferedReader(new InputStreamReader(urlConn.getErrorStream()));
    }
    StringBuilder responseData = new StringBuilder();
    String line;
    while((line = buf.readLine()) != null) {
      responseData.append(line);
    }
    buf.close();
    urlConn.disconnect();
    // 메이븐에서 gson 의존성 추가 in pom.xml 파일에
    JsonObject responseObj = JsonParser.parseString(responseData.toString()).getAsJsonObject();
    JsonArray items = responseObj.getAsJsonObject("response").getAsJsonObject("body").getAsJsonArray("items");
    
    for(int i=0; i<items.size(); i++) {
      JsonObject item = items.get(i).getAsJsonObject();
      DataVO data = new DataVO();
      
      data.setShntPlaceNm(getValue(item, "shntPlaceNm"));
      data.setRnDtlAdres(getValue(item, "rnDtlAdres"));
      data.setArcd(getValue(item, "arcd"));
      data.setPsblNmpr(getValue(item, "psblNmpr"));
      
      list.add(data);
    }
    return list;
  }

  private String getValue(JsonObject obj, String key) {
    return obj.has(key) && obj.get(key) != null && !obj.get(key).isJsonNull() ? obj.get(key).getAsString() : "";
  }
}
