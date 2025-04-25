import { useState } from "react";
import { getDogImages } from "../services/apiTest";
import ImageList from "./ImageList";

export default function DogComponent() {
  const [list, setList] = useState([]);

  const showDogImage = async () => {
    const data = await getDogImages();
    setList([...list, data[0].url]);
  };

  return (
    <>
      <p>강아지 보는 컴포넌트@@</p>
      <hr />
      <ImageList images={list} showImage={showDogImage} />
    </>
  );
}
