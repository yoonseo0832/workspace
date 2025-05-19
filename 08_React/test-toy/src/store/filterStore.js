import { create } from "zustand";

const useFilterStore = create((set) => ({
  selectedCategory: "",
  selectedFacilities: [],
  priceRange: [0, 200000],

  setCategory: (category) => set({ selectedCategory: category }),
  toggleFacility: (facility) =>
    set((state) => ({
      selectedFacilities: state.selectedFacilities.includes(facility)
        ? state.selectedFacilities.filter((f) => f !== facility)
        : [...state.selectedFacilities, facility],
    })),
  setPriceRange: (range) => set({ priceRange: range }),
}));

export default useFilterStore;
