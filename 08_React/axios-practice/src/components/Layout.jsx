import { Routes, Route } from "react-router-dom";
import BasicPrcatice from "../pages/BasicPractice";
import APIPractice from "../pages/APIPractice";
import DogComponent from "./DogComponent";
import CatComponent from "./CatComponent";
import MyAPIComponent from "./MyAPIComponent";

export default function Layout() {
  return (
    <Routes className="menu-bar">
      <Route index element={<p>main</p>}></Route>

      <Route path="/basic" element={<BasicPrcatice />}></Route>
      <Route path="/api" element={<APIPractice />}>
        <Route index element={<CatComponent />}></Route>
        <Route path="dog" element={<DogComponent />}></Route>
        <Route path="my" element={<MyAPIComponent />}></Route>
      </Route>

      <Route path="*" element={<h1>404 NotFound</h1>}></Route>
    </Routes>
  );
}
