window.onload = () => {
    // 카카오 맵 API 로드 여부 확인
    if (typeof kakao === 'undefined' || !kakao.maps) {
        console.error("카카오 맵 SDK가 로드되지 않았습니다.");
        return;
    }

    const container = document.getElementById('map');
    if (!container) {
        console.error("'map' 아이디를 가진 DOM 요소가 없습니다.");
        return;
    }

    const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };

    const map = new kakao.maps.Map(container, options);
};