import { Component } from "react";
// 클래스 정의
class CounterClass extends Component{
    // 생성자 정의
    constructor(props){ // props : 부모 컴포넌트로부터 전달된 데이터를 담은 객체
        super(props);   // super() : 부모클래스(Components)의 생성자를 호출
        this.state = {count :0};
        // state 필드에 객체를 초기화.
    }
    // 화살표 함수
    handlerClick = () =>{
        // 상태를 변경(업데이트) --> setState 메소드 사용
        this.setState({ count: this.state.count +1 });
    }

    // 생명주기
    // -처음 랜더링 된 시점
    componentDidMount(){
        console.log("componentDidMount:::::");
    }
    
    // - 상태가 변경되었을 떄
    componentDidUpdate(){
        console.log("componentDidUpdate:::::");
    }

    // - 해당 컴포넌트가 사라질때
    componentWillUnmount(){
        console.log("componentWillUnmount:::::");
    }

    render(){
        return(
            <div>
                <h2>함수형 컴포넌트</h2>
                <p>Count: {this.state.count}</p>
                <button onClick={this.handlerClick}>+</button>
            </div>
        );
    }
}
export default CounterClass;