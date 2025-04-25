import { Link } from "react-router-dom";

/*
const menuInfo = [
    {pathname: "/", text: "HOME"},
    {pathname: "/basic", text: "BASIC"}
];
*/
const style = {
  color: "pink",
  textDecoration: "none",
  padding: "10px",
  border: "1px solid pink",
  margin: "10px 20px",
  borderRadius: "10px",
};
export default function MenuBar({ menuInfo }) {
  return (
    <>
      {menuInfo.map((menu) => {
        return (
          <Link style={style} to={menu.pathname}>
            {menu.text}
          </Link>
        );
      })}
    </>
  );
}
