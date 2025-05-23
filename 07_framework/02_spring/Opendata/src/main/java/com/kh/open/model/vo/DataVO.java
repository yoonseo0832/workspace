package com.kh.open.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DataVO {
  private String shntPlaceNm;       // 대피장소명
  private String rnDtlAdres;        // 도로명상세주소
  private String arcd;                 // 지역코
  private String psblNmpr;             // 수용인원
}
