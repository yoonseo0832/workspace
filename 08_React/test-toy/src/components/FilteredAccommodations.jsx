import React from "react";
import useFilterStore from "../store/filterStore";

const FilteredAccommodations = ({ accommodations }) => {
  const { priceRange, selectedFacilities } = useFilterStore();

  const filtered = accommodations.filter((acc) => {
    const withinPrice =
      acc.price >= priceRange[0] && acc.price <= priceRange[1];
    const hasFacility = selectedFacilities.every((fac) =>
      acc.facilities.includes(fac)
    );
    return withinPrice && hasFacility;
  });

  return (
    <div>
      {filtered.map((acc) => (
        <div
          key={acc.id}
          style={{ padding: "10px", borderBottom: "1px solid #ddd" }}
        >
          <h4>{acc.name}</h4>
          <p>
            ₩{acc.price.toLocaleString()} / {acc.facilities.join(", ")}
          </p>
        </div>
      ))}
    </div>
  );
};

export default FilteredAccommodations;
