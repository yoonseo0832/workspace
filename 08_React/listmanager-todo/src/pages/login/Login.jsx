import { Link } from "react-router-dom";
import { useState } from "react";
import { loginUser } from "../../services/apiService";

import Card from "../../components/card/Card";
import Input from "../../components/input/Input";
import Logo from "../../components/logo/Logo";
import { toast } from "react-toastify";
import { successAlert, errorAlert } from "../../services/toastUtils";
import "./login.css";
// 넘겨오는 것은 <Login setIsLogin={setIsLogin}  /> 은 {} 안에 {setIsLogin} 넣어야 함
export default function Login({ setIsLogin }) {
  const [id, setId] = useState("");
  const [pwd, setPwd] = useState("");

  const loginHandler = async () => {
    const result = await loginUser({ userId: id, userPwd: pwd });
    if (result === "success") {
      successAlert("로그인 성공");
      setIsLogin(true);
      // setItem : 키-벨류 / getItem : 키 / clear : 지우기
      // 브라우저 저장공간에 로그인 여부 저장
      localStorage.setItem("logined", true);
    } else errorAlert("로그인 실패");
  };
  return (
    <Card>
      <Logo className={"f-blue"} multiple big />

      <Input
        type="text"
        placeholder="아이디"
        onChange={(e) => setId(e.target.value)}
      />
      <Input
        type="password"
        placeholder="비밀번호"
        onChange={(e) => setPwd(e.target.value)}
      />
      <Input
        type="button"
        value="로그인"
        className="btn btn-blue"
        onClick={loginHandler}
      />

      <Link to={"/signup"} className="btn btn-white">
        회원가입
      </Link>
    </Card>
  );
}
