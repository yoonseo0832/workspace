# router-practice
> 라우터 연습 프로젝트

## dependency 추가
> yarn add 라이브러리명
> 또는 npm add 라이브러리명
> npm install 라이브러리명 --save

### 추가목록(라이브러리명(추가한 날짜))
- react-router-dom (2024-04-23)

## Memo
- URL : 프로토콜+도메인+포트+경로+쿼리매개변수+프래그먼트
    ex) http://localhost:3000/a/v/c/?d=100&e=hi#hash
- location 객체 : 주소창에 입력된 URL 정보를 담고 있는 객체
    - href : URL 전체 정보(조회, 설정)
    - protocol : 프로토콜 정보
    - host : 도메인 + 포트번호
    - search : 쿼리 매개변수
    - hash : 프래그먼트
- history 객체 : 페이지 이동 기능을 제공하는 객체
    - back() : 뒤로가기
    - go() : URL 이동. 숫자: -1 뒤로, 1: 앞으로, -2 뒤로 3번
    - forword() : 앞으로 가기
- 라우팅 : URL에 명시된 자원을 찾는 과정
    - 웹브라우저(클라이언트)에서 발생하는 라우팅 : client-side routing
    - SPA 방식에서는 특정 컴포넌트를 찾아서 화면에 표시해줌
        - URL를 입력하지만 실제로 서버로 요청하는 것 아님
        그래서 컴포넌트가 변경되더라도 새로고침이 발생하지 않음
- 주요 훅
    - useNavigate : navigate 함수 제공
        - 메개변수로 전달된 경로로 이동해줌
        - 숫자 입력 시 history.go()와 똑같이 동작
    - useLocation : location 객체 제공
        - location 과 비슷 but, 동일하지 않음
        - location.pathname을 통해 현재 실행된 라우팅 경로를 확인 가능
    - useParams : params 객체 제공
        - params : 라우트(Route) 매개변수의 값 확인