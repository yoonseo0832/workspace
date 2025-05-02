import axios from "axios";

// 설정 통해 axios 객체 생성
const apiAxios = axios.create({
  baseURL: "http://localhost:8080",
});

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
