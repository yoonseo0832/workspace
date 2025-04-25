export default function ImageList({ images, showImage }) {
  return (
    <>
      <button onClick={showImage}>이미지 보기</button>
      <div style={{ display: "flex", gap: "5px" }}>
        {images.map((url, idx) => (
          <img
            key={"img_" + idx}
            src={url}
            alt="로딩중.."
            width={200}
            height={200}
          />
        ))}
      </div>
    </>
  );
}
