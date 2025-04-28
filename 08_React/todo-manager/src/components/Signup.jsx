import { Link } from "react-router-dom";
export default function Login() {
  const divStyle = {
    width: "470px",
    height: "500px",
    backgroundColor: "white",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  };

  const innerDivStyle = {
    width: "400px",
    hegiht: "373px",
    display: "flex",
    flexDirection: "column",
    gap: "10px",
  };

  const h1Style = {
    color: "#4682B4",
    fontSize: "34px",
    fontWeight: "700",
    lineHeight: "44px",
    textAlign: "center",
    marginBottom: "20px",
  };

  const inputContainerStyle = {
    display: "flex",
    alignItems: "center",
    marginBottom: "10px",
  };

  const inputStyle = {
    flexGrow: 1,
    height: "45px",
    backgroundColor: "white",
    border: "1px solid #DDDDDD",
    borderRadius: "5px",
    fontSize: "14px",
    color: "black",
    paddingLeft: "10px",
  };

  const buttonStyle = {
    backgroundColor: "white",
    border: "1px solid #dddddd",
    color: "black",
    height: "45px",
    padding: "10px 15px",
    borderRadius: "5px",
    marginLeft: "10px",
    fontSize: "14px",
  };

  const linkStyle = {
    backgroundColor: "#5087B5",
    color: "white",
    borderRadius: "5px",
    fontSize: "16px",
    textAlign: "center",
    padding: "15px 0",
    display: "block",
    marginTop: "30px",
  };
  return (
    <div style={divStyle}>
      <div style={innerDivStyle}>
        <h1 style={h1Style}>TODO MANAGER</h1>
        <div style={inputContainerStyle}>
          <input type="text" placeholder="아이디" style={inputStyle} />
          <button style={buttonStyle}>중복체크</button>
        </div>
        <input type="password" placeholder="비밀번호" style={inputStyle} />
        <input type="text" placeholder="닉네임" style={inputStyle} />
        <div style={inputContainerStyle}>
          <input type="email" placeholder="이메일" style={inputStyle} />
          <button style={buttonStyle}>인증</button>
        </div>
        <Link to="/todo" style={linkStyle}>
          회원가입
        </Link>
      </div>
    </div>
  );
}
