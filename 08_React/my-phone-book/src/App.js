import logo from './logo.svg';
import './App.css';
import {useState} from 'react';
import PhoneInput from './components/PhoneInput';
import PhoneList from './components/PhoneList';
import MyContext from './contexts/MyContext';
/*
  리액트에서는 상위(부모) 컴포넌트에서 하위(자식) 컴포넌트의 상태를 직접 변경할 수 없음
  따라서, 하위 컴포넌트에서 발생한 이벤트를 상위 컴포넌트에서 처리하도록 하는 상태 끌어올리기 패턴을 사용
  (State lifting up)

  Props를 통해 데이터가 전달될 때 하위 컴포넌트에서 필요하지 않은 props를 계속 전달해야 하는 상황 발생
  (Props drilling, 상태 내리꽂기)
  > 단점: 코드의 가독성 떨어지고, 유지보수성 떨어짐
  해결하기 위해) React Content 또는 Redux 와 같은 상태 관리 라이브러리를 사용하기도 함
*/
function App() {
  // 상태를 부모컴포넌트로 올리고, phoneList가 phoneInput값을 불러오기 위한 조치
  const [list, setList] = useState([]);

  const addPhone = (data) => {
    // 전개연산자(...) : 기존 배열(객체) 내용을 복사, 그 뒤에 새 항목을 추가함
    setList([...list, data]);
  }
  return (
    <div>
      <h2>My Phone Book</h2>
      <MyContext.Provider value={{list, addPhone}}>
        <PhoneInput />
        <hr />
        <PhoneList />
      </MyContext.Provider>
    </div>
  );
}

export default App;
