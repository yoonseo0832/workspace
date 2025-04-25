import './App.css';
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';
import Timer from './components/Timer';
import CountLetters from './components/CountLetters';
function App() {
  return (
    <BrowserRouter>

      <div className="container">
        <nav>
          <Link to="/">HOME</Link>
          <Link to="/timer">타이머</Link>
          <Link to="/count/letters" >글자수세기</Link>
        </nav>
      </div>

      <Routes>
        <Route path="/" element={<div className="outer" style={{ height: '600px', backgroundColor:'orange', textAlign:'center'}}>메인페이지</div>}></Route>
        <Route path="/timer" element={<Timer />}></Route>
        <Route path="/count/letters" element={<CountLetters />}></Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
