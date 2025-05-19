import React, { useEffect, useState } from "react";
import FilterPenal from "../components/FilterPenal";
import FilteredAccommodations from "../components/FilteredAccommodations";

const AccommodationListPage = () => {
  const [accommodations, setAccommodations] = useState([]);

  useEffect(() => {
    // 실제 API 요청 또는 더미 데이터
    setAccommodations([
      {
        id: 1,
        name: "서울 호텔",
        price: 120000,
        facilities: ["주차장", "수영장", "TV"],
      },
      {
        id: 2,
        name: "강릉 리조트",
        price: 90000,
        facilities: ["바베큐", "와이파이"],
      },
      {
        id: 3,
        name: "제주 펜션",
        price: 65000,
        facilities: ["애완동물", "노래방", "TV", "에어컨"],
      },
    ]);
  }, []);

  return (
    <div style={{ display: "flex", gap: "24px" }}>
      <div style={{ width: "300px" }}>
        <FilterPenal />
      </div>
      <div style={{ flex: 1 }}>
        <FilteredAccommodations accommodations={accommodations} />
      </div>
    </div>
  );
};

export default AccommodationListPage;
