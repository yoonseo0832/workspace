// 함수형 컴포넌트
// => 상태, 생명주기를 훅을 통해 관리
import { useEffect, useState } from 'react';
function CounterFunction(){
    const [count, setCount] = useState(0);
    // 컴포넌트의 상태(state)를 변경하고자 할때 무조건 setState를 통해 업데이트 해야함
    // 업데이트를 하는 과정에서 상태값을 직접 수정 불가
    const countUp = () =>{{setCount(count +1)}};

    // 생명 주기 : useEffect
    // - 처음 랜더링된 시점
    useEffect(()=> {
        console.log("componentDidMount####");
    }, []);

    // - 상태가 변경된 
    useEffect(()=> {
        console.log("componentDidUpdate####");
    }, [count]);

    // - 
    return(
        <div>
            <h2>함수형 컴포넌트</h2>
            <p>Count: {count}</p>
            <button onClick={countUp}>+</button>
        </div>
    );
}
export default CounterFunction;