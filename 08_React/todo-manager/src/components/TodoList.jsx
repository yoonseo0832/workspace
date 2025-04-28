import "../App.css";
export default function TodoList() {
  const leftDiv = {
    width: "20%",
    backgroundColor: "#5087B5",
    color: "white",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    paddingTop: "50px",
  };
  const rightDiv = {
    width: "80%",
    backgroundColor: "#E9E9E9",
    display: "flex",
    justifyContent: "center",
    alignItems: "flex-start",
    paddingTop: "50px",
  };
  const listItemStyle = {
    display: "flex",
    alignItems: "center",
    height: "60px",
    width: "1050px",
    padding: "0 20px",
    backgroundColor: "#FFFFFF",
    color: "black",
    marginBottom: "10px",
    borderRadius: "5px",
  };
  const todoTextStyle = {
    flexGrow: 1,
    textAlign: "left",
  };
  const checkButtonStyle = {
    backgroundColor: "#4CAF50",
    color: "white",
    border: "none",
    borderRadius: "50%",
    width: "50px",
    height: "50px",
    marginRight: "10px",
    cursor: "pointer",
  };
  const deleteButtonStyle = {
    backgroundColor: "#f44336",
    color: "white",
    border: "none",
    borderRadius: "50%",
    width: "50px",
    height: "50px",
    cursor: "pointer",
  };

  const contentContainerStyle = {
    width: "80%",
    maxWidth: "1200px",
    padding: "20px",
    borderRadius: "8px",
  };
  const inputContainerStyle = {
    display: "flex",
    marginBottom: "20px",
  };
  const inputStyle = {
    flexGrow: 1,
    padding: "10px",
    borderRadius: "5px",
    border: "1px solid #ccc",
    backgroundColor: "white",
    fontSize: "16px",
    color: "black",
  };
  const addButton = {
    backgroundColor: "#FFFFFF",
    color: "black",
    border: "none",
    borderRadius: "5px",
    padding: "10px 15px",
    marginLeft: "10px",
    fontSize: "20px",
    cursor: "pointer",
  };

  return (
    <div
      style={{
        width: "100vw",
        display: "flex",
        height: "100vh",
        overflow: "hidden",
      }}
    >
      <div style={leftDiv}>
        <h2>TODO MANAGER</h2>
        <a href="#">진행중</a>
        <a href="#">완료 </a>
        <a href="#">삭제 </a>
      </div>
      <div style={rightDiv}>
        <div style={contentContainerStyle}>
          <div style={inputContainerStyle}>
            <input type="text" placeholder="할 일 입력" style={inputStyle} />
            <button style={addButton}>+</button>
          </div>
          <hr />
          <ul>
            <li style={listItemStyle}>
              <div style={todoTextStyle}>스프링과 친해지기</div>
              <button style={checkButtonStyle}>Y</button>
              <button style={deleteButtonStyle}>X</button>
            </li>
            <li style={listItemStyle}>
              <div style={todoTextStyle}>스프링과 친해지기</div>
              <button style={checkButtonStyle}>Y</button>
              <button style={deleteButtonStyle}>X</button>
            </li>
            <li style={listItemStyle}>
              <div style={todoTextStyle}>스프링과 친해지기</div>
              <button style={checkButtonStyle}>Y</button>
              <button style={deleteButtonStyle}>X</button>
            </li>
            <li style={listItemStyle}>
              <div style={todoTextStyle}>스프링과 친해지기</div>
              <button style={checkButtonStyle}>Y</button>
              <button style={deleteButtonStyle}>X</button>
            </li>
            <li style={listItemStyle}>
              <div style={todoTextStyle}>스프링과 친해지기</div>
              <button style={checkButtonStyle}>Y</button>
              <button style={deleteButtonStyle}>X</button>
            </li>
            <li style={listItemStyle}>
              <div style={todoTextStyle}>스프링과 친해지기</div>
              <button style={checkButtonStyle}>Y</button>
              <button style={deleteButtonStyle}>X</button>
            </li>
            <li style={listItemStyle}>
              <div style={todoTextStyle}>스프링과 친해지기</div>
              <button style={checkButtonStyle}>Y</button>
              <button style={deleteButtonStyle}>X</button>
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
}
