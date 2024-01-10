package com.jang.mtg.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
}
