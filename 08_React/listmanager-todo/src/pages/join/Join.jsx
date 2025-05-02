import Card from "../../components/card/Card";
import Input from "../../components/input/Input";
import Logo from "../../components/logo/Logo";
import { useState } from "react";
import {
  verifyEmail,
  sendEmail,
  checkId,
  registUser,
} from "../../services/apiService";
import { toast } from "react-toastify";
import {
  successAlert,
  errorAlert,
  topCenterAlert,
} from "../../services/toastUtils";

const shortInputStyle = { width: "290px", marginRight: "10px" };
export default function Join() {
  const [id, setId] = useState("");
  const [pwd, setPwd] = useState("");
  const [nickname, setNickname] = useState("");
  const [email, setEmail] = useState("");
  const [code, setCode] = useState("");

  const checkIdHandler = async () => {
    //alert(` 버튼 클릭됨`);
    const result = await checkId(id);
    if (result === "nnnnY") {
      successAlert(`사용 가능한 아이디입니다`, { topCenterAlert });
    } else {
      errorAlert(`이미 사용중인 아이디입니다`, topCenterAlert);
    }
  };

  const sendHandler = async () => {
    //alert(`입력된 이메일: ${email}`);

    const result = await sendEmail(email);
    console.log(result);
  };

  const verifyHandler = async () => {
    const result = await verifyEmail(email, code);
    console.log(result);
    alert(`코드 입력 완료됬습니다: ${code}`);
  };

  const registHandler = async () => {
    // 입력된 정보를 담아 회원 가입 요청
    const user = {
      userId: id,
      userPwd: pwd,
      nickname: nickname,
      email: email,
    };

    const result = await registUser(user);
    if (result === "success") {
      successAlert("회원가입 성공");
      <Link to={"/"}></Link>;
    } else {
      errorAlert("회원가입 실패");
    }
  };
  return (
    <Card>
      <Logo className={"f-blue"} />
      <Input
        type="text"
        placeholder="아이디"
        onChange={(e) => setId(e.target.value)}
        style={shortInputStyle}
      />
      <Input
        type="button"
        value="중복체크"
        className="btn-white btn-sm"
        onClick={checkIdHandler}
      />
      <Input
        type="password"
        placeholder="비밀번호"
        onChange={(e) => setPwd(e.target.value)}
      />
      <Input
        type="text"
        placeholder="닉네임"
        onChange={(e) => setNickname(e.target.value)}
      />
      <Input
        type="mail"
        placeholder="이메일"
        onChange={(e) => setEmail(e.target.value)}
        style={shortInputStyle}
      />
      <Input
        type="button"
        value="인증"
        className="btn-white btn-sm"
        onClick={sendHandler}
      />
      <Input
        type="text"
        placeholder="인증코드"
        style={shortInputStyle}
        onChange={(e) => setCode(e.target.value)}
      />
      <Input
        type="button"
        value="확인"
        className="btn-white btn-sm"
        onClick={verifyHandler}
      />
      <Input
        type="button"
        value="회원가입"
        className="btn btn-blue"
        onClick={registHandler}
      />
    </Card>
  );
}
