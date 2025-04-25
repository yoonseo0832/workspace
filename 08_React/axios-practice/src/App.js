import logo from './logo.svg';
import './App.css';
import {BrowserRouter} from 'react-router-dom';
import MenuBar from './components/MenuBar';
import Layout from './components/Layout';

const mainMenu = [
  {pathname: "/", text: "HOME"},
  {pathname: "/basic", text: "BASIC"},
  {pathname: "/api", text: "API"}
];

function App() {
  return (
    <BrowserRouter>
      <MenuBar menuInfo={mainMenu} />
      <hr />
      <Layout />
    </BrowserRouter>
  );
}

export default App;
