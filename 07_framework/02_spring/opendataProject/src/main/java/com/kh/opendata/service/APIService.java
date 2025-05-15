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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.opendata.model.dto.AirResponse;
import com.kh.opendata.model.vo.AirVO;
import jakarta.servlet.http.HttpServletResponse;

@Service
public class APIService {
  /**
   * 공공데이터 API를 사용하여 대기오염 정보 조회
   * @param sidoName 지역명
   * @return 대기오염 조회 결과
   */
  @Value("${opendata.apikey}")
  private String serviceKey;
  
  public List<AirVO> getAirPollution(String sidoName) throws UnsupportedEncodingException{
    /*
    String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
    url += "?serviceKey=" + serviceKey;
    url += "&sidoName="+URLEncoder.encode(sidoName, "UTF-8");
    url += "&returnType=json";
    */
    
    // 요청 URL method 분리 / 오버로딩해서 pageNo 를 빼고 sidoName만 들어가는 것을 만들어서 부여, 계속 0 또는 1을 부여할 수 없으니 한번에 
    String url = makeAirPollutionURL(sidoName);
    
    
    ArrayList<AirVO> list = new ArrayList<>();
    
    try {
      URL reqUrl = new URL(url);
      HttpURLConnection urlConn = (HttpURLConnection)reqUrl.openConnection();
      
      urlConn.setRequestMethod("GET");
      //String holeText = "";
      // 통신 성공 여부 체크
      if(urlConn.getResponseCode() == HttpServletResponse.SC_OK) {
        // 응답 데이터 읽어오기
        BufferedReader bufRead = new BufferedReader( new InputStreamReader( urlConn.getInputStream()));
        
        StringBuilder responseData = new StringBuilder();
        String line;
        while((line = bufRead.readLine()) != null) {
          //holeText += line;
          responseData.append(line);
        }
        
        bufRead.close();
        urlConn.disconnect();
        
        //System.out.println(holeText);
        
        //JsonObject totalObj = JsonParser.parseString(responseData.toString()).getAsJsonObject();
        
        JsonObject responseObj = JsonParser.parseString(responseData.toString()).getAsJsonObject();
        //System.out.println(responseObj);
        //JsonObject bodyObj = responseObj.getAsJsonObject("body");
        //System.out.println(bodyObj);
        JsonArray items = responseObj.getAsJsonObject("response").getAsJsonObject("body").getAsJsonArray("items");
        //int totalCount = bodyObj.get("totalCount").getAsInt();
        //System.out.println(totalCount);
        
        //JsonArray items = bodyObj.getAsJsonArray("items");
        
        for(int i=0; i<items.size(); i++) {
          JsonObject item = items.get(i).getAsJsonObject();
          
          AirVO air = new AirVO();
          /*
          air.setStationName(item.get("stationName").getAsString());
          air.setDataTime(item.get("dataTime").getAsString());
          air.setKhaiValue(item.get("khaiValue").getAsString());
          
          air.setPm10Value(item.get("pm10Value").getAsString());
          air.setCoValue(item.get("coValue").getAsString());
          air.setNo2Value(item.get("no2Value").getAsString());
          air.setSo2Value(item.get("so2Value").getAsString());
          air.setO3Value(item.get("o3Value").getAsString());
          */
          air.setStationName(getValue(item, "stationName"));
          air.setDataTime(getValue(item, "dataTime"));
          air.setKhaiValue(getValue(item, "khaiValue"));
          
          air.setPm10Value(getValue(item, "pm10Value"));
          air.setCoValue(getValue(item, "coValue"));
          air.setNo2Value(getValue(item, "no2Value"));
          air.setSo2Value(getValue(item, "so2Value"));
          air.setO3Value(getValue(item, "o3Value"));
          list.add(air);
        }
        
      }else {
        // 통신 실패 시
        BufferedReader bufRead = new BufferedReader( new InputStreamReader( urlConn.getErrorStream()));
        
        StringBuilder responseData = new StringBuilder();
        String line="";
        while((line = bufRead.readLine()) != null) {
          responseData.append(line);
        }
        System.out.println(responseData);
        
        bufRead.close();
        urlConn.disconnect();
      }
      
     
    } catch (IOException e) {
      e.printStackTrace();
    }
    return list;
  }
  
  /**
   * 객체 내 특정 값에 대하여 안전하게 추출
   * @param obj Json 객체
   * @param key 추출하고자 하는 데이터의 키값
   * @return 키값에 해당하는 값
   */
  private String getValue(JsonObject obj, String key) {
   return obj.has(key) && obj.get(key) != null && !obj.get(key).isJsonNull() ?
       obj.get(key).getAsString() : "";
  }
  
  /**
   * 시도별 실시간 대기오염 요청 URL 생성
   * @Param sidoName 지역정보
   * @Param pageNo 페이지 번호
   * @return 요청 URL
   * @throws UnsupportedEncodingException 
   */
  // 분히된 
  private String makeAirPollutionURL(String sidoName, int pageNo) throws UnsupportedEncodingException {
    String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
    url += "?serviceKey=" + serviceKey;
    url += "&sidoName="+URLEncoder.encode(sidoName, "UTF-8");
    url += "&pageNo=" + pageNo;
    url += "&returnType=json";
    return url;
  }
  
  private String makeAirPollutionURL(String sidoName) throws UnsupportedEncodingException {
    return makeAirPollutionURL(sidoName, 1);
  }
  /**
   * JsonArray 타입을 
   * @param items JsonArray 타입
   * @return list list<AirVO> 타입으로 변경된 데이터
   */
  private  List<AirVO> convertJsonArrayToList(JsonArray items){
    List<AirVO> list = new ArrayList<>();
    
    for(int i=0; i<items.size(); i++) {
      
      JsonObject item = items.get(i).getAsJsonObject();
      
      AirVO air = new AirVO();
     
      air.setStationName(getValue(item, "stationName"));
      air.setDataTime(getValue(item, "dataTime"));
      air.setKhaiValue(getValue(item, "khaiValue"));
      
      air.setPm10Value(getValue(item, "pm10Value"));
      air.setCoValue(getValue(item, "coValue"));
      air.setNo2Value(getValue(item, "no2Value"));
      air.setSo2Value(getValue(item, "so2Value"));
      air.setO3Value(getValue(item, "o3Value"));
      list.add(air);
    }
    return list;
  }
  /**
   * 요청 후 응답 데이터 반환
   * @param url 요청 주소
   * @return 성공 시 응답 데이터 문자열, 실패 시 null
   * @throws IOException 
   */
  private String getAirPollutionResponse(String url) throws IOException {
    // * 요청 전송
    URL requestUrl = new URL(url);
    HttpURLConnection urlConn = (HttpURLConnection)requestUrl.openConnection();
    
    BufferedReader buf;
    // * 통신 성공 여부 체크
    if (urlConn.getResponseCode() == HttpServletResponse.SC_OK) {
      // 요청 성공 시
      buf = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
    }else {
      // 요청 실패 시 
      buf= new BufferedReader(new InputStreamReader(urlConn.getErrorStream()));
    }
    // 응답 결과를 변수에 저장
    // 상수 풀에 많은 양의 데이터를 저장하는 것보다 StringBuilder 영역에 저장하는 것이 좋음
    StringBuilder responseData = new StringBuilder();
    String line ="";
    while((line = buf.readLine())!= null) {
      responseData.append(line);
    }
    
    // 자원 반납
    buf.close();
    urlConn.disconnect();
    
    if(urlConn.getResponseCode() == HttpServletResponse.SC_OK) {
      return responseData.toString();
    }else {
      System.out.println(responseData); // 오류 내용 출력 log.error(...)
      return null;
    }
  }
  
  
  /**
   * 공공데이터 API 를 사용하여 대기오염 정보 조회 + 페이지 정보
   * @param sidoName    지역정보
   * @param pageNo      페이지 번호
   * @return    조회된 
   * @throws IOException 
   */
  public AirResponse getAirPollutionV2(String sidoName, int pageNo) throws IOException {
    // 요청 URL 
    String url = makeAirPollutionURL(sidoName, pageNo);
    
    
    
    // 응답 데이터 
    String responseData = getAirPollutionResponse(url);
    // 응답 데이터가 null 인 경우 메소드 종료
    //if(responseData == null) {
    //  return list;
    //}
    
    // 추출 및 가공 처리
    JsonObject bodyObj = JsonParser.parseString(responseData).getAsJsonObject()
                                  .getAsJsonObject("response")
                                  .getAsJsonObject("body");
    
    AirResponse airResponse = new AirResponse();
    airResponse.setTotalCount(bodyObj.get("totalCount").getAsInt());
    airResponse.setNumOfRows(bodyObj.get("numOfRows").getAsInt());
    airResponse.setPageNo(bodyObj.get("pageNo").getAsInt());
    
    JsonArray items = bodyObj.getAsJsonArray("items");
    List<AirVO> list = convertJsonArrayToList(items);
    
    airResponse.setItems(list);
    
    return airResponse;
  }
}
