import logo from './logo.svg';
import './css/common.css';
import Footer from './components/Footer';
import Header from './components/Header';
import BoardList from './pages/BoardList';
import Join from './pages/Join';
import NoticeList from './pages/NoticeList';
import {BrowserRouter, Routes, Route} from 'react-router-dom';
function App() {
  return (
    <BrowserRouter>
      <Header />
          <Routes>
            <Route path="/" element={<div className="outer" style={{height: '600px'}}></div>}></Route>
            <Route path="/boards" element={<BoardList/>}></Route>
            <Route path="/join" element={<Join/>}></Route>
            <Route path="/notices" element={<NoticeList/>}></Route>
          </Routes>
      <Footer />
    </BrowserRouter>
  );
}

export default App;
