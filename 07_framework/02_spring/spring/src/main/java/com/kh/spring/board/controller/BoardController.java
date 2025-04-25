package com.kh.spring.board.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.board.model.dto.SearchDto;
import com.kh.spring.board.model.vo.Board;
import com.kh.spring.board.model.vo.Reply;
import com.kh.spring.board.service.BoardService;
import com.kh.spring.common.MyFileUtils;
import com.kh.spring.common.PageInfo;
import com.kh.spring.notice.model.vo.Notice;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
  private final BoardService boardService;

  @GetMapping("/list")
  public String boardList(Model model, @RequestParam(defaultValue = "1") int cpage,
      SearchDto searchDto) {
    // TODO: 페이징 처리
    // 한 페이지당 게시글 개수: 10, 페이징바 표시 개수: 5
    int count = boardService.selectBoardCount(searchDto);

    PageInfo pi = new PageInfo(count, cpage, 5, 10);

    ArrayList<Board> list = boardService.selectBoardList(pi, searchDto);

    // request 영역에 조회된 데이터 저장
    model.addAttribute("list", list);
    model.addAttribute("pi", pi);
    model.addAttribute("condition", searchDto.getCondition());
    model.addAttribute("keyword", searchDto.getKeyword());

    return "board/boardList";
  }

  @GetMapping("/enrollForm")
  public String boardEnrollForm() {
    return "board/enrollForm";
  }

  @PostMapping("/write")
  public String boardWrite(Board board, MultipartFile upfile, HttpSession session, Model model) {
    System.out.println(board);
    System.out.println(upfile);
    System.out.println("첨부파일:::" + upfile.isEmpty());

    if (!upfile.isEmpty()) {
      // 파일명을 변경 -> "spring_" + 현재날짜시간 + 랜덤값 + 확장자
      String changeName = MyFileUtils.saveFile(upfile, session, "/resources/upfile/");
      board.setOriginName(upfile.getOriginalFilename());
      board.setChangeName(changeName);
    }
    int result = boardService.insertBoard(board);

    if (result > 0) {
      session.setAttribute("alertMsg", "게시글 작성 성공");
      return "redirect:/board/list";
    } else {
      model.addAttribute("errorMsg", "게시글 작성 실패");
      return "common/errorPage";
    }
  }

  @GetMapping("/detail")
  public String boardDetail(@RequestParam(required = true) int bno, Model model) {
    int result = boardService.increaseCount(bno);

    if (result > 0) {
      Board board = boardService.selectBoardDetail(bno);
      ArrayList<Reply> rlist = boardService.selectReplyList(bno);

      model.addAttribute("board", board);
      model.addAttribute("rlist", rlist);

      return "board/boardDetail";
    } else {
      model.addAttribute("errorMsg", "게시글 조회 실패");
      return "common/errorPage";
    }
  }

  @PostMapping("/delete")
  public String boardDelete(@RequestParam(required = true) int bno, HttpSession session,
      Model model) {
    int result = boardService.deleteBoard(bno);

    if (result > 0) {
      session.setAttribute("alertMsg", "게시글 삭제 성공");
      return "redirect:/board/list";
    } else {
      model.addAttribute("errorMsg", "게시글 삭제 실패");
      return "common/errorPage";
    }
  }

  // 요청주소 : /board/updateForm 요청방식: get방식 전달되는 데이터(키값): ?bno=5
  @GetMapping("/updateForm")
  public ModelAndView updatePage(@RequestParam(required = true) int bno, ModelAndView mv) {
    // 게시글 수정 페이지로 응답
    Board board = boardService.selectBoardDetail(bno);

    // 조회된 게시글 정보를 request 영역에 저장 = 이유: 응답페이지에서 사용하려고 저장한다
    mv.addObject("board", board);
    mv.setViewName("board/updateForm");
    // 응답 페이지 경로 /WEB-INF/views/board/updateForm.jsp
    // 게시글 수정 페이지 응답

    return mv;
  }

  @PostMapping("/update")
  public ModelAndView updateBoard(HttpSession session, Board board, ModelAndView mv,
      MultipartFile upfile) {
    // 새롱누 첨부파일이 있는 경우 Board 객체에 첨부파일 저장 서버에도 저장

    // 새로운 첨부파일이 있는지 체크
    if (!upfile.isEmpty()) {
      String changeName = MyFileUtils.saveFile(upfile, session, "/resources/upfile/");
      // 서버에 파일명을 변경하여 자장

      // TODO: 기본 첨부파일이 있을경우 해당 파일 삭제

      // Board 객체에 첨부파일 정보 저장 (변경된 파일명, 원본 파일명)
      board.setChangeName(changeName);
      board.setOriginName(upfile.getOriginalFilename());
    }
    int result = boardService.updateBoard(board);

    if (result > 0) {
      mv.setViewName("redirect:/board/detail?bno=" + board.getBoardNo());
    } else {
      mv.setViewName("common/errorPage");
    }
    return mv;
  }
  // *******************************************************************************

}
