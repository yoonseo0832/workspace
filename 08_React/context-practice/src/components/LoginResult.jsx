import { useContext } from "react";
import UserContext from "../contexts/UserContext";

function LoginResult(){
    const {user} = useContext(UserContext);
    // 3. 전달된 전역 상태에 접근, useContext 훅을 사용해, 사용할 사용자가 만든 Context 객체 지정
    return(
        <>
            { user && <p>{user.id}님, 환영합니다!</p>}
        </>
    );
}
export default LoginResult;