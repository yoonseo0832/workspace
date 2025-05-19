import React, { useEffect } from "react";

const KakaoMap = ({ accommodations }) => {
  useEffect(() => {
    const { kakao } = window;
    const mapContainer = document.getElementById("map");
    const mapOption = {
      center: new kakao.maps.LatLng(37.5665, 126.978),
      level: 6,
    };

    const map = new kakao.maps.Map(mapContainer, mapOption);

    accommodations.forEach((acc) => {
      const marker = new kakao.maps.Marker({
        map,
        position: new kakao.maps.LatLng(acc.lat, acc.lon),
        title: acc.name,
      });

      const infoWindow = new kakao.maps.InfoWindow({
        content: `<div style="padding:5px;font-size:13px;"><strong>${acc.name}</strong><br/>${acc.address}</div>`,
      });

      kakao.maps.event.addListener(marker, "click", () => {
        infoWindow.open(map, marker);
      });
    });
  }, [accommodations]);

  return <div id="map" style={{ width: "100%", height: "500px" }} />;
};

export default KakaoMap;
