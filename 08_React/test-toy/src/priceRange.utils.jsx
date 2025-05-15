import React, { useState } from "react";
import Slider from "rc-slider";
import "rc-slider/assets/index.css";

const PriceRangeSlider = () => {
  const [range, setRange] = useState([30000, 300000]);

  const handleSliderChange = (value) => {
    setRange(value);
  };

  return (
    <div style={{ width: "300px", margin: "2rem auto" }}>
      <label
        style={{ fontWeight: "bold", display: "block", marginBottom: "8px" }}
      >
        가격 <span style={{ fontSize: "12px", color: "#888" }}>1박 기준</span>
      </label>
      <Slider
        range
        min={0}
        max={10000000}
        step={1000}
        defaultValue={range}
        onChange={handleSliderChange}
        trackStyle={[{ backgroundColor: "#007aff" }]}
        handleStyle={[{ borderColor: "#007aff" }, { borderColor: "#007aff" }]}
      />
      <div style={{ marginTop: "10px", color: "#007aff", fontWeight: "bold" }}>
        {range[0].toLocaleString()}원 ~ {range[1].toLocaleString()}원
      </div>
    </div>
  );
};

export default PriceRangeSlider;
