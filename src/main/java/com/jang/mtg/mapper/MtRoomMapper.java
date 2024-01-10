package com.jang.mtg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jang.mtg.model.MrResTimeVO;
import com.jang.mtg.model.MrReserveVO;
import com.jang.mtg.model.MtRoomVO;

@Mapper
public interface MtRoomMapper {
	
	List<MtRoomVO> getMtRoomList();	//등록된 회의실 전체 불러오기
	
	MtRoomVO getMtRoom(int mrNo);	//특정 회의실 불러오기
	
	int insertMtRoom(MtRoomVO mtRoomVO);	//회의실 등록
	
	int updateMtRoom(MtRoomVO mtRoomVO);	//회의실 정보수정
	
	int deleteMtRoom(int mrNo);	// 회의실 등록 취소
	
	List<MrReserveVO> getMrReserveList(MrResTimeVO mrResTimeVO);	// 일별, 회의실별 예약블록 불러오기
	
	MrReserveVO getMrReserve(int reNo);	//특정 예약 불러오기
	
	int insertMrReserve(MrReserveVO mrReserveVO);	//예약 등록

	int updateMrReserve(MrReserveVO mrReserveVO);	//예약 수정
	
	int deleteMrReserve(int reNo);	//예약 취소
	
	int resDupCheck(MrReserveVO mrReserveVO);	//예약 중복체크
	
	MrReserveVO getMrReserveByTime(MrReserveVO mrReserveVO);	//특정시간 예약 불러오기
	
}
