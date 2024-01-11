package com.jang.mtg.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jang.mtg.model.MtRoomVO;
import com.jang.mtg.service.MtRoomService;

@Controller
public class MtRoomController {

	@Autowired
	private MtRoomService mtRoomService;
	
	@RequestMapping(value="/index")
	public String indexView() throws Exception{
		return "index";
	}
	
	@RequestMapping(value="/mtRoomList")
	public String mtRoomList(@ModelAttribute("mtRoomVO") MtRoomVO mtRoomVO, Model model, HttpSession session) throws Exception{
		
		session.setAttribute("userId", "Test"); // Login 개발 완료 후 삭제 예정
	
		List<MtRoomVO> mtRoomList = mtRoomService.getMtRoomList();
		
		model.addAttribute("mtRoomList",mtRoomList);
		
		return "mtRoomList";	
	}
	
	@RequestMapping(value="/insertMtRoom", method = RequestMethod.GET)
	public String insertMtRoomView(Model model) throws Exception{
		model.addAttribute("mtRoomVO", new MtRoomVO());
		return "mtRoomRegist";
	}
	
	@RequestMapping(value="/insertMtRoom", method = RequestMethod.POST)
	public String insertMtRoomView(@ModelAttribute("mtRoomVO") MtRoomVO mtRoomVO, Model model, HttpSession session, MultipartHttpServletRequest mRequest) throws Exception{
		String userId = (String)session.getAttribute("userId");
		
		/* 사진저장 경로지정 */
		ServletContext servletContext = mRequest.getSession().getServletContext();
		String webappRoot = servletContext.getRealPath("/");
		String relativeFolder = File.separator + "resources" + File.separator + "images" + File.separator;
		
		mtRoomVO.setFirst_Reg_ID(userId);
		
		List<MultipartFile> fileList = mRequest.getFiles("file_1");
		
		for(MultipartFile mf : fileList) {
			if(!mf.isEmpty()) {
				String originFileName = mf.getOriginalFilename(); //원본 파일명
				long fileSize = mf.getSize(); //원본 사이즈
				
				mtRoomVO.setPicture(originFileName);
				System.out.println("New Pic=" + mtRoomVO.getPicture());
				
				/* 하드디스크에 파일 저장 */
				String safeFile = webappRoot + relativeFolder + originFileName;
				
				try {
					mf.transferTo(new File(safeFile));
				}catch(IllegalStateException e) {
					e.printStackTrace();
				}catch(IOException e) {
					e.printStackTrace();
				}	
			}
		}
		if(this.mtRoomService.insertMtRoom(mtRoomVO)!=0) {
			model.addAttribute("mtRoomvo", mtRoomVO);
			model.addAttribute("msgCode", "등록성공");
			return "redirect:mtRoomList";
		}else {
			model.addAttribute("msgCode", "등록실패! 확인 후 다시 시도해 주세요.");
			return "mtRoomRegist";
		}
	}
	
}
