/*
  react-router-dom 모듈 (라이브러리)
    : 리액트로 생성된 SPA 내부에서 페이지 이동을 간으하도록 만들어주는 모듈

    [컴포넌트 목록]
    - BrowserRouter
    : history api 를 이용하여 history 객체 생성
      라우팅을 진행할 컴포넌트 상위 Routes 컴포넌트를 생성하고 감싸줘야 함

    - Routes 
    : 모든 Route의 상위 경로에 존재
      location 변경 시 하위에 있는 모든 Route 중 현재 location과 맞는 Route를 찾아줌

    - Route
    : 현재 브라우저의 location 정보를 가져옴 -> 값에 따라 컴포넌트를 렌더링 함
      <Route path="주소값(경로)" element={렌더링할 컴포넌트} />
      
      ex) <Route path="/board" element={<BoardComponent />} />

    - Link
    : 라우팅을 통한 탐색을 가능하게 하는 컴포넌트 (a href="주소")
    <Link to="이동할 주소(경로)">표사할 내용</Link>

    ex) <Link to="/board">게시판</Link>
        <Link to={{
                  pathname: "/board",     // 이동할 주소 
                  search: "?bno={bno}",   // 쿼리 매개변수(전달값)
                  hash: "#hash"           // 프래그먼트(페이지 내 특정 위치)
                  }}>자세히 보기</Link>
*/
import {BrowserRouter} from 'react-router-dom';
// useParams 는 react 아닌 react-router-dom 을 import 함
import "./App.css";
import Menu from './components/Menu';
import Layout from './components/Layout';

function App() {
  return (
    <BrowserRouter>
      <Menu />
      <Layout />
    </BrowserRouter>
  );
}

export default App;
