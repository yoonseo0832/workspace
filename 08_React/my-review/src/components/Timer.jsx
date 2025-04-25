import {useState, useEffect} from 'react';

function Timer(props) {
    const [now, setNow] = useState(new Date());
    // 1초 마다 now 상태를 현재 말짜시간으로 변경 ==> setInterval(함수,시간) : 시간마다 함수 내용을 실행
    // setImter(함수, 시간) : 일정 시간 뒤에 함수 내용을 실행, clearInterval()
    useEffect(()=>{
        const timer = setInterval(()=>{
          setNow(new Date());
        }, 1*1000);
    
        return() => {
          // 컴포넌트가 소멸될 때 타이머 정리 --> clearInterval(대상타이머)
          clearInterval(timer);
        }
      }, []);

    return (
        <div className="App">
            <header className="App-header">
                <h1>현재 시간</h1>
                <p>{now.toLocaleDateString()}</p>
                <p>{now.toLocaleTimeString()}</p>
            </header>
        </div>
    );
}
export default Timer;