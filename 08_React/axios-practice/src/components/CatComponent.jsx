import { useState } from "react";
import { getCatImages } from "../services/apiTest";
import ImageList from "./ImageList";

export default function CatComponent() {
  const [image, setImage] = useState([]);
  /*  useEffect(() => {
    const data = getCatImages();
    console.log(data);
  }, []);*/

  const showImage = async () => {
    const data = await getCatImages();
    console.log(data);
    //setImage(data[0].url);
    const imgUrl = data[0].url;
    setImage([...image, imgUrl]);
  };

  /*<img src={image} alt="이미지 로딩중..." width={200} height={200} />*/

  return (
    <>
      <p>!!고양이 보는 컴포넌트</p>
      <hr />
      <ImageList images={image} showImage={showImage} />
    </>
  );
}
