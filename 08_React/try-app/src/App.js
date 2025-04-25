import logo from './logo.svg';
import './css/Reset.css';
import Header from './components/Header';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <Header />
      <Routes>
        <Route to="/" element={<p></p>}></Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
