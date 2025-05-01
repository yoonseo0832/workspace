import Card from "../../components/card/Card";
import Input from "../../components/input/Input";
import Logo from "../../components/logo/Logo";
import { useState } from "react";
import { verifyEmail, sendEmail } from "../../services/apiService";

const shortInputStyle = { width: "290px", marginRight: "10px" };
export default function Join() {
  const [id, setId] = useState("");
  const [email, setEmail] = useState("");
  const [code, setCode] = useState("");

  const checkIdHandler = (inputId) => {
    setId(inputId);
    id;
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
      <Input type="password" placeholder="비밀번호" />
      <Input type="text" placeholder="닉네임" />
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
      <Input type="button" value="회원가입" className="btn btn-blue" />
    </Card>
  );
}
