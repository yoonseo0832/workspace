// src/store/searchStore.js
import { create } from "zustand";

const useSearchStore = create((set) => ({
  keyword: "",
  guests: 2,
  dateRange: {
    startDate: new Date(),
    endDate: new Date(new Date().setDate(new Date().getDate() + 1)),
  },

  setKeyword: (keyword) => set({ keyword }),
  setDateRange: (range) => set({ dateRange: range }),
  setGuests: (guests) => set({ guests }),
}));

export default useSearchStore;
