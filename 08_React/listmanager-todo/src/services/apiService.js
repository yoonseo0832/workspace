import axios from "axios";
import { errorAlert } from "./toastUtils";
// 설정 통해 axios 객체 생성
const apiAxios = axios.create({
  baseURL: "http://localhost:8080",
  withCredentials: true, //쿠키 또는 인증 헤더를 포함하여 요청할 것인지에 대한 설정
});

// 통신 오류 발생 시 처리
apiAxios.interceptors.response.use(
  // 2xx범위의 코드 시 현재 함수를 실행
  function (response) {
    // 응답 결과 전달
    return response;
  },
  function (error) {
    if (error.status === 401) {
      localStorage.removeItem("logined");
      location.href = "/";
    }

    errorAlert("문제가 발생함");
    return Promise.reject(error);
  }
);
export const sendEmail = async (email) => {
  const response = await apiAxios.post("/email/send", { email: email });
  return response.data;
};

export const verifyEmail = async (email, code) => {
  const response = await apiAxios.post("/email/verify", {
    email: email,
    code: code,
  });
  return response.data;
};

export const checkId = async (id) => {
  const response = await apiAxios.post("/checkId", { id: id });
  // status ; 통신 상태 코드 / data: 응답 데이터
  return response.data;
};

export const registUser = async (user) => {
  const response = await apiAxios.post("/user", user);
  return response.data;
};
// 기다리도록 작업하는 이우: 비동기 처리를 위해
export const loginUser = async (user) => {
  const response = await apiAxios.post("login", user); // {user} 객체로 감싸면 백엔드에서 (서버_)에서 인식 못해 오류발생
  return response.data;
};

export const getTodoList = async () => {
  const response = await apiAxios.get("todo");
  return response.data;
};

export const insertTodo = async (content) => {
  const response = await apiAxios.post("/todo", { content: content });
  return response.data;
};
