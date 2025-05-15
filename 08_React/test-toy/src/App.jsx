import { useState } from "react";
import reactLogo from "./assets/react.svg";
import viteLogo from "/vite.svg";
import "./App.css";
import PriceRangeSlider from "./priceRange.utils";

function App() {
  const [count, setCount] = useState(0);

  return (
    <>
      <PriceRangeSlider />
    </>
  );
}

export default App;
