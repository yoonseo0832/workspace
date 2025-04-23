import {Routes, Route, useParams} from 'react-router-dom';
function Layout() {
    function MenuTemplate(){
        const { no } = useParams();
      
        return(
          <p>Menu{no} 페이지</p>
        );
      
      }
    return (
        <>
            <Routes>
                {/*path="/" == index (동일함)*/}
                <Route index element={<p>메인 페이지</p>} />
                {/*
        <Route path="/menu1" element={<p>Menu1 페이지</p>} />
        <Route path="/menu2" element={<p>Menu2 페이지</p>} />
        */}
                <Route path="/menu/:no" element={<MenuTemplate />} />
            </Routes>
        </>
    );
}
export default Layout;