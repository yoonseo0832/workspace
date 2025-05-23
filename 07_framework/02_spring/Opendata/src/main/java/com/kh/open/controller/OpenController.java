package com.kh.open.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.web.bind.annotation.RestController;
import com.kh.open.model.vo.DataVO;
import com.kh.open.service.OpenAPIService;

@RestController
public class OpenController {
  
  private final OpenAPIService apiService;
  public OpenController(OpenAPIService apiService) {
    this.apiService=apiService;
  }
  
  public List<DataVO> getOpenData() throws IOException{
    List<DataVO> list = new ArrayList<>();
    list = apiService.getOpenData();
    
    return list;
  }
}
