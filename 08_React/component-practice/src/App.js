import logo from './logo.svg';
import './App.css';
import { useState } from 'react';
import CounterClass from './components/CounterClass';
import CounterFunction from './components/CounterFunction';
function App() {
  const [kind, setKind] = useState(0);
  return (
    <div>
      <h1>컴포넌트 : 리액트 앱의 구성 단위</h1>

      <button onClick={()=> {setKind('function')}}>함수형 컴포넌트</button>
      <button onClick={()=> {setKind('class')}}>클래스형 컴포넌트</button>

    {/* kind 상태에 따라 컴포넌트 내용을 표시 */}
    
    {/*
      kind === 'function' ? <CounterFunction /> : <CounterClass />
    */}
    {kind === 'function' && <CounterFunction />}
    {kind === 'class' && <CounterClass />}
    </div>
  );
}

export default App;
