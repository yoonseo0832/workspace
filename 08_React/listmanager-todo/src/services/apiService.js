import axios from "axios";

// 설정 통해 axios 객체 생성
const apiAxios = axios.create({
  baseURL: "http://localhost:8080",
});

export const sendEmail = async (email) => {
  const response = apiAxios.post("/email/send", { email: email });
  return response.data;
};

export const verifyEmail = async (email, code) => {
  const response = apiAxios.post("/email/verify", { email: email, code: code });
  return response.data;
};
