import reactLogo from "./assets/react.svg";
import viteLogo from "/vite.svg";
import "./App.css";
//import SearchBar from "./components/SearchBar";
import FilterPanel from "./components/FilterPenal";
import SearchBar from "./components/SearchBar";
import KakaoMap from "./components/KakaoMap";
import AccommodationListPage from "./pages/AccommodationListPage";

function App() {
  return (
    <div>
      <SearchBar />

      <AccommodationListPage />
    </div>
  );
}

export default App;
