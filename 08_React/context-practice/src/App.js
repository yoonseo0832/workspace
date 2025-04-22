import logo from './logo.svg';
import './App.css';
import LoginForm from './components/LoginForm';
import LoginResult from './components/LoginResult';
import UserContext from './contexts/UserContext';
import {useState} from 'react';

function App() {
  const [user, setUser] = useState(null);
  // 전달해야 하는 상태

  return (
    <div>
      {/*Provider: 전역 상태를 하위 컴포넌트에게 전달하는 역할, 부모컴포넌트인 App.js에 Provider 함 
              하위 컴포넌트를 Context로 감싸준다, 전달할 상태를 보낼 것은 value에 담아서
      */}
      <UserContext.Provider value={{user, setUser}}>
        <LoginForm />
        <hr></hr>
        <LoginResult />
      </UserContext.Provider>
    </div>
  );
}

export default App;
