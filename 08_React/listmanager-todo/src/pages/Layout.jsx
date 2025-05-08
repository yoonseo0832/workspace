import { BrowserRouter, Route, Routes } from "react-router-dom";
import { useState } from "react";
import { ToastContainer } from "react-toastify";

import Login from "./login/Login";
import MainPage from "./MainPage";
import Join from "./join/Join";

export default function Layout() {
  const [isLoign, setIsLogin] = useState(() => {
    return !!localStorage.getItem("logined");
  });
  //const isLogin = false;
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route
            index
            element={isLoign ? <MainPage /> : <Login setIsLogin={setIsLogin} />}
          />
          <Route path="/signup" element={<Join />} />
        </Routes>
      </BrowserRouter>
      <ToastContainer />
    </>
  );
}
