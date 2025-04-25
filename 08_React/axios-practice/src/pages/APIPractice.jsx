import MenuBar from "../components/MenuBar";
import { Outlet } from "react-router-dom";

const apiMenu = [
  { pathname: "/api", text: "고양이 보기" },
  { pathname: "/api/dog", text: "강아지 보기" },
  { pathname: "/api/my", text: "MY API~" },
];

export default function APIPractice() {
  return (
    <>
      <h1>APIPractice</h1>
      <MenuBar menuInfo={apiMenu} />
      <Outlet />
    </>
  );
}
