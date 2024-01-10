package com.jang.mtg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.mtg.mapper.MtRoomMapper;
import com.jang.mtg.model.MrResTimeVO;
import com.jang.mtg.model.MrReserveVO;
import com.jang.mtg.model.MtRoomVO;

@Service(value = "mtRoomService")
public class MtRoomServiceImpl implements MtRoomService {

	@Autowired
	private MtRoomMapper mtRoomMapper;
	
	@Override
	public List<MtRoomVO> getMtRoomList() {
		return mtRoomMapper.getMtRoomList();
	}

	@Override
	public MtRoomVO getMtRoom(int mrNo) {
		return mtRoomMapper.getMtRoom(mrNo);
	}

	@Override
	public int insertMtRoom(MtRoomVO mtRoomVO) {
		return mtRoomMapper.insertMtRoom(mtRoomVO);
	}

	@Override
	public int updateMtRoom(MtRoomVO mtRoomVO) {
		return mtRoomMapper.updateMtRoom(mtRoomVO);
	}

	@Override
	public int deleteMtRoom(int mrNo) {
		return mtRoomMapper.deleteMtRoom(mrNo);
	}

	@Override
	public List<MrReserveVO> getMrReserveList(MrResTimeVO mrResTimeVO) {
		return mtRoomMapper.getMrReserveList(mrResTimeVO);
	}

	@Override
	public MrReserveVO getMrReserve(int reNo) {
		return mtRoomMapper.getMrReserve(reNo);
	}

	@Override
	public int insertMrReserve(MrReserveVO mrReserveVO) {
		return mtRoomMapper.insertMrReserve(mrReserveVO);
	}

	@Override
	public int updateMrReserve(MrReserveVO mrReserveVO) {
		return mtRoomMapper.updateMrReserve(mrReserveVO);
	}

	@Override
	public int deleteMrReserve(int reNo) {
		return mtRoomMapper.deleteMrReserve(reNo);
	}

	@Override
	public int resDupCheck(MrReserveVO mrReserveVO) {
		return mtRoomMapper.resDupCheck(mrReserveVO);
	}

	@Override
	public MrReserveVO getMrReserveByTime(MrReserveVO mrReserveVO) {
		
		System.out.println("Service Update mrReserveVO mrNo=" + mrReserveVO.getMrNo());
		System.out.println("Update mrReserveVO Day=" + mrReserveVO.getReserve_Day());
		System.out.println("Update mrReserveVO Start=" + mrReserveVO.getReserve_Start());
		
		return mtRoomMapper.getMrReserveByTime(mrReserveVO);
	}

}
