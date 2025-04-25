import { useState } from "react";
import { getServerInfo } from "../services/apiTest";
import { getUserList } from "../services/apiTest";
import MyButton from "./MyButton";
import TableList from "./TableLIst";

const theadkey = {
  id: "이름",
  age: "나이",
  phone: "연락처",
};
const types = ["이름", "나이", "연락처"];

export default function MyAPIComponent() {
  const [data, setData] = useState({ list: [] });

  const showServerInfo = async () => {
    const result = await getServerInfo();
    setData({ ...data, r1: result });
  };

  const showUserList = async () => {
    const result = await getUserList();
    setData({ ...data, list: result });
  };

  return (
    <>
      <MyButton clickHandler={showServerInfo} text={"서버 정보 조회"} />
      <p>{data.r1}</p> {/* {re:result}*/}
      <MyButton clickHandler={showUserList} text={"사용자 목록 조회"} />
      <TableList typeList={types} dataList={data.list} keyName={"user_"} />
    </>
  );
}
