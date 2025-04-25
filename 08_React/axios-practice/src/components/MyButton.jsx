export default function MyButton({ clickHandler, text }) {
  return (
    <button
      styple={{ color: "pink", backgroundColor: "pink" }}
      onClick={clickHandler}
    >
      {text}
    </button>
  );
}
