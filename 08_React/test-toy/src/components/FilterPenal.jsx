// src/components/FilterPanel.jsx
import React from "react";
import useFilterStore from "../store/filterStore";
import Slider from "rc-slider";
import "rc-slider/assets/index.css";

const CATEGORY_GROUPS = [
  { label: "공용 시설", facilities: ["주차장", "수영장", "바베큐", "조식"] },
  { label: "객실 내 시설", facilities: ["에어컨", "TV", "욕조", "와이파이"] },
  { label: "기타 시설", facilities: ["애완동물", "키즈존", "캠핑", "노래방"] },
];

const FilterPanel = () => {
  const { selectedFacilities, toggleFacility, priceRange, setPriceRange } =
    useFilterStore();

  return (
    <div
      style={{
        padding: "20px",
        background: "#0e0b1f",
        color: "#fff",
        borderRadius: "10px",
      }}
    >
      <h3 style={{ color: "#9e7dff" }}>💰 가격대 설정</h3>
      <Slider
        range
        min={0}
        max={200000}
        defaultValue={priceRange}
        step={10000}
        onAfterChange={setPriceRange}
        trackStyle={[{ backgroundColor: "#9e7dff" }]}
        handleStyle={[{ borderColor: "#9e7dff" }, { borderColor: "#9e7dff" }]}
      />
      <p style={{ color: "#aaa" }}>
        ₩{priceRange[0].toLocaleString()} ~ ₩{priceRange[1].toLocaleString()}
      </p>

      {CATEGORY_GROUPS.map((group) => (
        <div key={group.label} style={{ marginTop: "20px" }}>
          <h4 style={{ color: "#9e7dff" }}>{group.label}</h4>
          <div
            style={{
              display: "flex",
              flexWrap: "wrap",
              gap: "8px",
              marginTop: "10px",
            }}
          >
            {group.facilities.map((facility) => (
              <button
                key={facility}
                onClick={() => toggleFacility(facility)}
                style={{
                  padding: "8px 14px",
                  borderRadius: "999px",
                  border: selectedFacilities.includes(facility)
                    ? "2px solid #9e7dff"
                    : "1px solid #444",
                  background: selectedFacilities.includes(facility)
                    ? "#9e7dff22"
                    : "transparent",
                  color: "#fff",
                  cursor: "pointer",
                }}
              >
                {facility}
              </button>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
};

export default FilterPanel;
