package com.jang.mtg.controller;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.jang.mtg.model.MrResTimeVO;
import com.jang.mtg.model.MrReserveVO;
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
	
	@RequestMapping(value="/mtRoomDetail", method = RequestMethod.POST)
	public String getMtRoomView(@RequestParam("mrNo")int mrNo, Model model) throws Exception {
		
		MtRoomVO mtRoomVO = mtRoomService.getMtRoom(mrNo);
		
		model.addAttribute("mtRoomVO", mtRoomVO);
		
		return "mtRoomDetail";
	}
	
	@RequestMapping(value="/deleteMtRoom", method= RequestMethod.GET)
	public String deleteMtRoom(@RequestParam("mrNo")int mrNo, Model model) throws Exception{
		
		if(this.mtRoomService.deleteMtRoom(mrNo)!=0) {
			model.addAttribute("errCode", 3);	//삭제 성공
			return "redirect:mtRoomList";
		}else {
			model.addAttribute("errCode", 5);	//삭제 실패
			return "redirect:getMtRoomManage";
		}
	}
	
	@RequestMapping(value="/updateMtRoom", method= RequestMethod.GET)
	public String getMtRoomUpView(@RequestParam("mrNo")int mrNo, Model model) throws Exception{
		
		MtRoomVO mtRoomVO = mtRoomService.getMtRoom(mrNo);
		
		System.out.println("No=" + mtRoomVO.getMrNo());
		System.out.println("Pic=" + mtRoomVO.getPicture());
		
		model.addAttribute("mtRoomVO",mtRoomVO);
		
		return "mtRoomUpdate";
	}
	
	@RequestMapping(value = "/updateMtRoom", method = RequestMethod.POST)
	public String updateMtRoomOn(@ModelAttribute("mtRoomVO") MtRoomVO mtRoomVO, Model model, HttpSession session, MultipartHttpServletRequest mRequest) {
		
		String userId = (String)session.getAttribute("userId");
		
		ServletContext servletContext = mRequest.getSession().getServletContext();
		String webappRoot = servletContext.getRealPath("/");
		
		String relativeFolder = File.separator + "resources" + File.separator + "images" + File.separator;
		
		mtRoomVO.setFirst_Reg_ID(userId);
		
		List<MultipartFile> fileList = mRequest.getFiles("file_1");
		
		for(MultipartFile mf : fileList) {
			if(!mf.isEmpty()) {
				//새 파일과 구 파일이 있으면 구 파일 삭제
				if(!(mtRoomVO.getPicture().equals(null))) {
					String safeFile = webappRoot + relativeFolder + mtRoomVO.getPicture();
					File removeFile = new File(safeFile); //remove disk uploaded file
					removeFile.delete();
				}
				
				String originFileName = mf.getOriginalFilename(); //원본파일명
				long fileSize = mf.getSize(); //파일 사이즈
				
				mtRoomVO.setPicture(originFileName);
				
				//하드디스크에 새 파일 저장
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
		
		if(this.mtRoomService.updateMtRoom(mtRoomVO) != 0 ) {
			model.addAttribute("mtRoomVo", mtRoomVO);
			model.addAttribute("errCode", 3);	//수정 성공
			return "redirect:mtRoomList";
		}else {
			model.addAttribute("errCode", 5);	//수정 실패
			return "redirect:mtRoomUpdate";
		}
		
	}
	
	
	@RequestMapping(value = "mtResList")
	public String mrReserveList(@ModelAttribute("reserve_Day") String reserve_Day, Model model) throws Exception{
		
		String strSearchDay = "";
		
		LocalDate now = LocalDate.now();	//날짜 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		strSearchDay = now.format(formatter);
		
		if(reserve_Day.isEmpty()) {	//날짜가 입력되지 않았을 때 현재 날짜
			reserve_Day = strSearchDay;
		}
		
		List<MtRoomVO> mtRoomList = mtRoomService.getMtRoomList();	//회의실 정보를 모두 Read
		
		List<MrResTimeVO> mrResTimeList = new ArrayList<MrResTimeVO>();	//특정 날짜의 회의실 마다 예약 Read
		
		for(MtRoomVO mtRoom : mtRoomList) {	//회의실마다 예약시간 DTO(VO) 생성
			
			MrResTimeVO mrResTimeVO1 = new MrResTimeVO();
			
			mrResTimeVO1.setReserve_Day(reserve_Day);
			mrResTimeVO1.setMrNo(mtRoom.getMrNo());
			mrResTimeVO1.setMr_Name(mtRoom.getMr_Name());
			
			List<MrReserveVO> mrDayReserveList = mtRoomService.getMrReserveList(mrResTimeVO1);	//예약 테이블에서 특정일 회의실 여러개의 예약 Read
			
			for(MrReserveVO mrDayReserve : mrDayReserveList) {
				
				String sst = mrDayReserve.getReserve_Start().replace(":", "");	//09:30
				String set = mrDayReserve.getReserve_End().replace(":", "");	//12:00
				
				int st = Integer.parseInt(sst);	//0930
				int et = Integer.parseInt(set);	//1200
				
				int num;
				
				for(int i = st; i <= et; i+=50) {
					
					if(i%100>30) num = i-20;
					else num = i;
					
					if(num%100==60) num += 40;
					
					String resveTn="setResveTemp"+num;
					
					//특정 객체의 클래스 이름을 읽어와 변수에 있는 메소드 이름으로 호출
					Object obj = mrResTimeVO1;	//cls.newInstance();
					Class<?> cls = Class.forName(obj.getClass().getName());
					Method m = cls.getMethod(resveTn, String.class);
					
					m.invoke(obj, "1");	//메소드 호출("1" : 매개변수 : 파라미터)
				}
			}
			mrResTimeList.add(mrResTimeVO1);
		}
		model.addAttribute("mrResTimeList", mrResTimeList);
		model.addAttribute("reserve_Day", reserve_Day);
		
		return "mtResList";
	}
	
	@RequestMapping(value = "/mtResRegist", method = RequestMethod.POST)
	public String insertResVeiw(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO, Model model, HttpSession session) throws Exception{
		
		System.out.println("mrReserveVo No=" + mrReserveVO.getMrNo());
		System.out.println("mrReserveVo Day=" + mrReserveVO.getReserve_Day());
		System.out.println("mrReserveVo Start=" + mrReserveVO.getReserve_Start());
		
		int intValue1 = Integer.parseInt(mrReserveVO.getReserve_Start())+100;
		String endTime = Integer.toString(intValue1);
		mrReserveVO.setReserve_End(endTime);
		
		session.setAttribute("userId", "Test20"); //login 개발 완료 후 삭제
		String userId = (String) session.getAttribute("userId");
		mrReserveVO.setBookerID(userId);
		
		MtRoomVO mtRoomVO = mtRoomService.getMtRoom(mrReserveVO.getMrNo());
		
		System.out.println("mtRoomVO Name=" + mtRoomVO.getMr_Name());
		System.out.println("mtRoomVO Location=" + mtRoomVO.getLocation());
		System.out.println("mtRoomVO mrNo=" + mtRoomVO.getMrNo());
		
		model.addAttribute("mtRoomVO",mtRoomVO);
		model.addAttribute("mrReserveVO",mrReserveVO);
		
		return "mtResRegist";
	}
	
	@RequestMapping(value = "resDupCheck") @ResponseBody
	public String mtgResDupCheck(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO,
								 @RequestParam("reserve_Day") String reserve_Day,
								 @RequestParam("reserve_Start") String reserve_Start,
								 @RequestParam("reserve_End") String reserve_End,
								 @RequestParam("mrNo") String mrNo,
								 Model model) throws Exception{
		System.out.println("mrReserveVO reserve_Day=" + mrReserveVO.getReserve_Day());
		System.out.println("mrReserveVO mrNo=" + mrReserveVO.getMrNo());
		System.out.println("mrReserveVO st=" + mrReserveVO.getReserve_Start());
		System.out.println("mrReserveVO et=" + mrReserveVO.getReserve_End());
		
		JSONObject obj = new JSONObject();
		
		int dupCheck = this.mtRoomService.resDupCheck(mrReserveVO);
		
		if(dupCheck != 0) {
			obj.append("dup","false");
			return obj.toString();
		}else {
			obj.append("dup", "true");
			return obj.toString();
		}
		
	}
	
	@RequestMapping(value = "/insertReserve", method = RequestMethod.POST)
	public String insertResOn(@ModelAttribute("mrReserveVO") MrReserveVO mrReserveVO, Model model, HttpSession session, RedirectAttributes rea)throws Exception {
		
		String userId = (String)session.getAttribute("userId");
		
		mrReserveVO.setFirst_Reg_ID(userId);
		mrReserveVO.setBookerID(userId);
		
		System.out.println(mrReserveVO);
		
		if(this.mtRoomService.insertMrReserve(mrReserveVO)!=0) {
			rea.addFlashAttribute("reserve_Day",mrReserveVO.getReserve_Day());
			return "redirect:mtResList";
		}else {
			model.addAttribute("errCode","5");
			return "mtResRegist";
		}
		
	}
	
}
