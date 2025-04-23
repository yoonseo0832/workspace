import { Link } from 'react-router-dom';
function Header() {
    return (
        <>
            <div className="header">
                <a href="/"><img src="https://khedu.co.kr/resources/images/main/logo.svg" alt="kh_logo" width="150"/></a>
                <div></div>
                <div className="login-form">
                    <Link to="/join">회원가입</Link> |
                    <Link to="#" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</Link>
                </div>
            </div>
            <hr />
            <nav className="container text-center menu-bar">
                <div className="row">
                    <Link to="/" className="active col-3">HOME</Link>
                    <Link to="/notices" className="col">공지사항</Link>
                    <Link to="/boards" className="col">자유게시판</Link>
                    <Link to="#" className="col">사진게시판</Link>
                </div>
            </nav>
        </>
    );
}
export default Header;