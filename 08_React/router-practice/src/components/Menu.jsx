import {Link} from 'react-router-dom';

function Menu(){
    return(
        <>
            <Link to="/">홈</Link>
            <Link to="/menu/1">메뉴1</Link>
            <Link to="/menu/2">메뉴2</Link>
        </>
    );
}
export default Menu;