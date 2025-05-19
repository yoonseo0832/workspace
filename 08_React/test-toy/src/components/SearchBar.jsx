// 위치: src/components/SearchBar.jsx
import React, { useState } from "react";
import { DateRange } from "react-date-range";
import { ko } from "date-fns/locale";
import { format, differenceInDays } from "date-fns";
import "react-date-range/dist/styles.css";
import "react-date-range/dist/theme/default.css";
import useSearchStore from "../store/searchStore";
import { FiSearch } from "react-icons/fi";
import { FaUser } from "react-icons/fa";
import { BsCalendar3 } from "react-icons/bs";

const SearchBar = () => {
  const { keyword, setKeyword, dateRange, setDateRange, guests, setGuests } =
    useSearchStore();

  const [showDatePicker, setShowDatePicker] = useState(false);

  const nights = differenceInDays(dateRange.endDate, dateRange.startDate);

  const handleSearch = () => {
    console.log("장소:", keyword);
    console.log(
      "날짜:",
      format(dateRange.startDate, "MM.dd (eee)", { locale: ko }),
      "~",
      format(dateRange.endDate, "MM.dd (eee)", { locale: ko })
    );
    console.log("숙박일수:", nights, "박", nights + 1, "일");
    console.log("인원:", guests);
  };

  return (
    <div
      style={{
        display: "flex",
        gap: "10px",
        alignItems: "center",
        padding: "25px",
        backgroundColor: "#fafafa",
        borderRadius: "10px",
        Width: "1200px",
        margin: "40px auto",
        border: "3px solid #9e7dff",
        position: "relative",
      }}
    >
      <div
        style={{
          flex: 1,
          display: "flex",
          alignItems: "center",
          background: "#9e7dff",
          padding: "12px",
          borderRadius: "8px",
        }}
      >
        <FiSearch style={{ marginRight: "8px", color: "#fff" }} />
        <input
          type="text"
          value={keyword}
          onChange={(e) => setKeyword(e.target.value)}
          placeholder="가고싶으신 곳 혹은 숙박명으로 찾아보세요"
          style={{
            border: "none",
            outline: "none",
            fontSize: "14px",
            width: "100%",
            background: "transparent",
            color: "#5500FF",
          }}
        />
      </div>

      <div
        style={{
          flex: 1,
          display: "flex",
          alignItems: "center",
          background: "#9e7dff",
          padding: "12px",
          borderRadius: "8px",
          color: "#5500FF",
          cursor: "pointer",
        }}
        onClick={() => setShowDatePicker(!showDatePicker)}
      >
        <BsCalendar3 style={{ marginRight: "6px", color: "#fff" }} />
        <span style={{ fontWeight: "bold", fontSize: "14px" }}>
          {format(dateRange.startDate, "MM.dd EEE", { locale: ko })} -{" "}
          {format(dateRange.endDate, "MM.dd EEE", { locale: ko })} ({nights}박)
        </span>
      </div>

      <div
        style={{
          flex: 1,
          display: "flex",
          alignItems: "center",
          background: "#9e7dff",
          padding: "12px",
          borderRadius: "8px",
        }}
      >
        {Array.from({ length: 8 }, (_, idx) => (
          <FaUser
            key={idx}
            onClick={() => setGuests(idx + 1)}
            style={{
              marginRight: "4px",
              color: idx < guests ? "#fff" : "#d1c3ff",
              cursor: "pointer",
              fontSize: "16px",
            }}
          />
        ))}
      </div>

      <button
        onClick={handleSearch}
        style={{
          background: "#5200ff",
          color: "white",
          border: "none",
          borderRadius: "8px",
          padding: "12px 20px",
          fontWeight: "bold",
          cursor: "pointer",
        }}
      >
        검색
      </button>

      {showDatePicker && (
        <div
          style={{
            position: "absolute",
            top: "95px",
            left: "228px",
            zIndex: 99,
            background: "white",
            borderRadius: "10px",
            overflow: "hidden",
          }}
        >
          <DateRange
            ranges={[
              {
                startDate: dateRange.startDate,
                endDate: dateRange.endDate,
                key: "selection",
              },
            ]}
            locale={ko}
            minDate={new Date()} // 과거 날짜 막기
            onChange={(item) =>
              setDateRange({
                startDate: item.selection.startDate,
                endDate: item.selection.endDate,
              })
            }
            moveRangeOnFirstSelection={false}
            showDateDisplay={false}
            rangeColors={["#9e7dff"]}
          />
        </div>
      )}
    </div>
  );
};

export default SearchBar;
