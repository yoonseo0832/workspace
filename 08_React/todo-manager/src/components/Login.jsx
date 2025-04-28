import { Link } from "react-router-dom";
export default function Login() {
  const divStyle = {
    width: "470px",
    height: "500px",
    backgroundColor: "white",
    margin: "0 auto",
  };
  const h1Style = {
    color: "#4682B4",
    fontSize: "34px",
    fontWeight: "700",
    lineHeight: "44px",
    textAlign: "center",
  };
  const inputStyle1 = {
    width: "400px",
    height: "45px",
    backgroundColor: "white",
    border: "1px solid #DDDDDD",
    borderRadius: "5px",
    fontSize: "14px",
    color: "#A8A8A8",
    marginBottom: "16px",
  };
  const inputStyle2 = {
    width: "400px",
    height: "45px",
    backgroundColor: "white",
    border: "1px solid #DDDDDD",
    borderRadius: "5px",
    fontSize: "14px",
    color: "#A8A8A8",
    marginBottom: "45px",
  };
  const linkStyle = {
    width: "124px",
    padding: " 15px 140px",
    marginLeft: "32px",
    backgroundColor: "#5087B5",
    color: "white",
    borderRadius: "5px",
    fontSize: "16px",
    display: "block",
  };
  return (
    <div
      style={{
        width: "100vw",
        display: "flex",
        height: "100vh",
        margin: "0 auto",
        top: "500px",
      }}
    >
      <div style={divStyle}>
        <h1 style={h1Style}>
          TODO
          <br />
          MANAGER
        </h1>
        <div>
          <input type="text" placeholder="아이디" style={inputStyle1} />
          <br />
          <input type="password" placeholder="비밀번호" style={inputStyle2} />
          <br />
          <Link to="/todo" style={linkStyle}>
            로그인
          </Link>
          <br />
          <Link to="/signup" style={{ color: "black", fontSize: "14px" }}>
            회원가입
          </Link>
        </div>
      </div>
    </div>
  );
}
