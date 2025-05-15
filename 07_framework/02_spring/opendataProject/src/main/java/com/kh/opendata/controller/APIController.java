package com.kh.opendata.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.kh.opendata.model.dto.AirResponse;
import com.kh.opendata.model.vo.AirVO;
import com.kh.opendata.service.APIService;

// @RestController => @Controller + @ResponseBody
// 동기와 비동기를 섞어서 사용하기에는 @Controller 가 맞음
@Controller
public class APIController {
  
  private final APIService apiService;
  public APIController(APIService apiService) {
    this.apiService=apiService;
  }
  
  // [GET] /airPollution?location=선택된 지역정보
  // return List<AirVO> 대기요염 정보
  @GetMapping("airPollution")
  @ResponseBody
  public List<AirVO> getAirPollution(@RequestParam(value="location", defaultValue="서울")String sidoName){
    //System.out.println("지역 정보 :: "+ sidoName);
    List<AirVO> list = new ArrayList<>();
    try {
      list = apiService.getAirPollution(sidoName);
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    }
    System.out.println(list);
    return list;
  }
  
  //[GET] /airPollution/v2?location=지역정보&currPage=페이지번호
  //@return
  @GetMapping("airPollution/v2")
  @ResponseBody
  public AirResponse getAirPollutionV2(@RequestParam(value="location", defaultValue="서울")String sidoName
            , @RequestParam(value="currPage", defaultValue="1")int pageNo) throws IOException {
    return apiService.getAirPollutionV2(sidoName, pageNo);
  }
}

