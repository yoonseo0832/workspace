package com.kh.opendata.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/*
 * 에어코리아 대기오염 - 시도별 실시간 측정 조회 후 응답 데이터를 저장
 * 데이터 타입이 int/double이 아닌 이유: "-" 값이 데이터에 존재하기 때문이다
 * lombok @Data 사용하지 않는 이유는 Setter를 필요한 부분만 지정하기 위함
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AirVO {
  private String stationName;   // 측정소 이름
  private String dataTime;      // 측정 일시
  private String khaiValue;     // 통합 대기환경 수치
  
  private String pm10Value;     // 미세먼지 농도
  private String so2Value;      // 아황산가스 농도
  private String coValue;       // 일산화질소 농도
  private String no2Value;      // 이산화질소 농도
  private String o3Value;       // 오존 농도
}
