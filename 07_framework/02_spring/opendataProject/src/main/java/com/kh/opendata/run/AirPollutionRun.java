package com.kh.opendata.run;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.opendata.model.vo.AirVO;

public class AirPollutionRun {

  private static final String SERVICE_KEY = "cJwQGXshJwUq%2F1P%2F6RlKRdoqk99jixRyrNjH%2FSEhVm7nnGt0LjC1afBs1CkGZ%2FVUX4%2BgfcNk5kenLTkciIT09Q%3D%3D";
  public static void main(String[] args) throws IOException {
    // * 요청 주소(URL)
    String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty"; 

    // 전달 데이터 (request Parameter)
    url += "?serviceKey="+SERVICE_KEY;
    // 시도 이름
    // 한글이 포함된 경우 인코딩 처리를 해야 오류 발생을 막을 수 있음, 예외는 서비스되는 페이지인 경우 throws 말고 try-catch문을 사용해야함
    url += "&sidoName="+URLEncoder.encode("서울", "UTF-8");
    url += "&returnType=json";
    // xml / json
    
    System.out.println(url);
    // ctrl + F11 누르면 실행되면서 url 값이 출력됨
    
    //  (1) 요청 주소와 함께 URL 객체 생성
    URL requsetUrl = new URL(url);
    
    //  (2) HttpUrlConnection 객체 생성
    HttpURLConnection urlConn = (HttpURLConnection)requsetUrl.openConnection();
    
    //  (3) 요청 시 필요한 헤더 설정
    // setRequestMethod 기본값: GET 이기에 POST로 설정해야할 때 필수적
    urlConn.setRequestMethod("GET");
    
    //  (4) 공공데이터 API 서버로 요청을 보낸 후 입력 스트림을 통해 응답 데이터 읽기
    BufferedReader buf = new BufferedReader(
                        new InputStreamReader(
                              urlConn.getInputStream()
                            )
                        );
    
    // (5) 
    String line;
    String responseText ="";
    while((line = buf.readLine())!= null) {
      responseText += line;
    }
    
    //(5) 사용한 자원 반납
    buf.close();
    urlConn.disconnect();
    
    // *응답 데이터 확인 
    System.out.println(responseText);
    
    //----------------------------------------------------
    
    // JsonObject, JsonArray, JsonElement 이용해 파싱 가능
    // Gson 라이브러리를 사용하여 원하는 데이터를 추출 : 라이브러리를 추가(build.gradle) 주로 가장 사용량이 많은 버전을 사용함
    
    // JsonParser를 사용하여 문자열 형태의 데이터를 JsonObject 변환, getAsJsonObject() 하면 형변환 하지 않아도 됨
    JsonObject totalObj = JsonParser.parseString(responseText).getAsJsonObject();
    
    // 아래의 코드는 :: 응답 데이터 중 필요한 부분을 찾아가는 과정임
    
    // 응답 데이터에서 "response" 키에 해당하는 데이터 추출, 
    JsonObject responseObj = totalObj.getAsJsonObject("response");
    //System.out.println(responseObj);
    
    // "body" 키에 해당하는 데이터 추출
    JsonObject bodyObj = responseObj.getAsJsonObject("body");
    //System.out.println(bodyObj);
    
    int totalCount = bodyObj.get("totalCount").getAsInt();
    //System.out.println(totalCount);
    
    JsonArray items = bodyObj.getAsJsonArray("items");
    //System.out.println(items);
    
    ArrayList<AirVO> list = new ArrayList<>();
    // JsonArray --> ArrayList
    for(int i =0; i<items.size(); i++) {
      JsonObject item = items.get(i).getAsJsonObject();
      //System.out.println(item);
      AirVO air = new AirVO();
      
      air.setStationName(item.get("stationName").getAsString() );
      air.setDataTime(item.get("dataTime").getAsString() );
      air.setKhaiValue(item.get("khaiValue").getAsString() );
      air.setNo2Value(item.get("no2Value").getAsString() );
      air.setCoValue(item.get("coValue").getAsString() );
      air.setO3Value(item.get("o3Value").getAsString() );
      air.setPm10Value(item.get("pm10Value").getAsString() );
      air.setSo2Value(item.get("so2Value").getAsString() );
      
      //System.out.println(air);
      list.add(air);
    }
    for(AirVO air : list) {
      System.out.println(air);
    }
  }

}
