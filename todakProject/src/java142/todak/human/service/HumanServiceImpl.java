package java142.todak.human.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java142.todak.etc.controller.EtcController;
import java142.todak.human.dao.HumanDao;
import java142.todak.human.vo.ApprVO;
import java142.todak.human.vo.ApptVO;
import java142.todak.human.vo.CommVO;
import java142.todak.human.vo.HboardVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.human.vo.StatusVO;

@Service
@Transactional
public class HumanServiceImpl implements HumanService {
	Logger logger = Logger.getLogger(EtcController.class);
	@Autowired
	private HumanDao humanDao;
	@Override
	public List<HboardVO> selectHboard(MemberVO mvo){
		logger.info("selectHboard 시작");
		List<HboardVO> bList=null;
		bList=humanDao.selectHboard(mvo);
		logger.info("selectHboard 종료");
		return bList;
	}
	
	@Override
	public boolean updateHboard(HboardVO hvo){
		logger.info("updateHboard 시작");
		boolean bFlag=false;
		int iFlag=humanDao.updateHboard(hvo);
		if(iFlag==1){
			bFlag=true;
		}
		logger.info("updateHboard 종료");
		return bFlag;
	}
	
	@Override
	public List<HboardVO> boardDetail(HboardVO hvo){
		logger.info("boardDetail 시작");
		List<HboardVO> bList=null;
		bList=humanDao.boardDetail(hvo);
		logger.info("boardDetail 종료");
		return bList;
	}
	
	@Override
	public HboardVO uploadSelect(HboardVO hvo){
		logger.info("uploadSelect 시작");
		hvo=humanDao.uploadSelect(hvo);
		logger.info("uploadSelect 종료");
		return hvo;
	}

	@Override
	public boolean boardAccept(HboardVO hvo){
		logger.info("boardAccept 시작");
		boolean bFlag=false;
		int iFlag=humanDao.boardAccept(hvo);
		if(iFlag==1){
			bFlag=true;
		}
		logger.info("boardAccept 종료");
		return bFlag;
	}
	@Override
	public boolean boardHit(HboardVO hvo){
		logger.info("boardHit 시작");
		boolean bFlag=false;
		int iFlag=humanDao.boardHit(hvo);
		if(iFlag==1){
			bFlag=true;
		}
		logger.info("boardHit 종료");
		return bFlag;
	}
	@Override
	public ApprVO chaebunMemberAppr() {
		// TODO Auto-generated method stub
		logger.info("chaebunMemberAppr 시작");
		ApprVO hvo=humanDao.chaebunMemberAppr();
		logger.info("chaebunMemberAppr 종료");
		return hvo;
	}
	@Override
	public String chaebunBoard(){
		logger.info("chaebunBoard 시작");
		String Chaenum=humanDao.chaebunBoard();
		logger.info("chaebunBoard 종료");
		return Chaenum;
	}
	@Override
	public String chaebunMember(){
		logger.info("chaebunMember 시작");
		String Chaenum=humanDao.chaebunMember();
		logger.info("chaebunMember 종료");
		return Chaenum;
	}
	@Override
	public String chaebunApptRecord(){
		logger.info("chaebunApptRecord 시작");
		String Chaenum=humanDao.chaebunApptRecord();
		logger.info("chaebunApptRecord 종료");
		return Chaenum;
	}
	@Override
	public boolean insertHboard(HboardVO hvo){
		logger.info("insertHboard 시작");
		boolean flag=false;
		int cnt=humanDao.insertHboard(hvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("insertHboard 종료");
		return flag;
	}
	@Override
	public boolean deleteHboard(HboardVO hvo){
		logger.info("deleteHboard 시작");
		boolean flag=false;
		int cnt=humanDao.deleteHboard(hvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("deleteHboard 종료");
		return flag;
	}
	@Override
	public boolean insertMemberAppr(ApprVO avo){
		logger.info("insertMemberAppr 시작");
		boolean flag=false;
				
		int cnt=humanDao.insertMemberAppr(avo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("insertMemberAppr 종료");
		return flag;
	}
	
	@Override
	public boolean insertMember(MemberVO mvo){
		logger.info("insertMember 시작");
		boolean flag=false;
	
		int cnt=humanDao.insertMember(mvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("insertMember 종료");
		return flag;
	}
	@Override
	public boolean refusedMemberAppr(ApprVO avo){
		logger.info("refusedMemberAppr 시작");
		boolean flag=false;
	
		int cnt=humanDao.refusedMemberAppr(avo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("refusedMemberAppr 종료");
		return flag;
	}
	@Override
	public boolean acceptedMemberAppr(ApprVO avo){
		logger.info("acceptedMemberAppr 시작");
		boolean flag=false;
	
		int cnt=humanDao.refusedMemberAppr(avo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("acceptedMemberAppr 종료");
		return flag;
	}
	@Override
	public boolean updateMember(MemberVO mvo){
		logger.info("updateMember 시작");
		boolean flag=false;
			//트랜잭션 처리 했을때 try 캐치 사용
		try{
			int cnt=humanDao.updateMember(mvo);
			if(cnt!=0){
				flag=true;
			}
		}catch(DataAccessException e){
			e.printStackTrace();
			throw e;
		}
		logger.info("updateMember 종료");
		return flag;
	}
	@Override
	public boolean updateResignation(MemberVO mvo){
		logger.info("updateResignation 시작");
		boolean flag=false;
		
		int cnt=humanDao.updateResignation(mvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("updateResignation 종료");
		return flag;
	}
	@Override
	public boolean changeCommuteUpdate(CommVO cvo){
		logger.info("changeCommuteUpdate 시작");
		boolean flag=false;
	
		int cnt=humanDao.changeCommuteUpdate(cvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("changeCommuteUpdate 종료");
		return flag;
	}
	@Override
	public boolean vacationUpdate(CommVO cvo){
		logger.info("vacationUpdate 시작");
		boolean flag=false;

		int cnt=humanDao.vacationUpdate(cvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("vacationUpdate 종료");
		return flag;
	}
	@Override
	public boolean halfUpdate(CommVO cvo){
		logger.info("halfUpdate 시작");
		boolean flag=false;
	
		int cnt=humanDao.halfUpdate(cvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("halfUpdate 종료");
		return flag;
	}
	@Override
	public boolean insertApptRecord(ApptVO apvo){
		logger.info("insertApptRecord 시작");
		boolean flag=false;
		
		
		int cnt=humanDao.insertApptRecord(apvo);
		if(cnt!=0){
			flag=true;
		}
		logger.info("insertApptRecord 종료");
		return flag;
	}
	@Override
	public HboardVO selectPost(HboardVO hvo){
		logger.info("selectPost 시작");
		HboardVO pvo=null;
		pvo=humanDao.selectPost(hvo);
		logger.info("selectPost 종료");
		return pvo;
	}
	@Override
	public List<MemberVO> selectMember(MemberVO mvo){
		logger.info("selectMember 시작");
		List<MemberVO> memberList=null;
		memberList=humanDao.selectMember(mvo);
		logger.info("selectMember 종료");
		return memberList;
	}
	@Override
	public List<ApptVO> apptRecordSelect(ApptVO apvo){
		logger.info("apptRecordSelect 시작");
		List<ApptVO> apptList=null;
		apptList=humanDao.apptRecordSelect(apvo);
		logger.info("apptRecordSelect 종료");
		return apptList;
	}
	@Override
	public List<ApptVO> apptRecordAll(ApptVO apvo){
		logger.info("apptRecordAll 시작");
		List<ApptVO> apptList=null;
		apptList=humanDao.apptRecordAll(apvo);
		logger.info("apptRecordAll 종료");
		return apptList;
	}
	@Override
	public List<MemberVO> selectPersonAppt(MemberVO mvo){
		logger.info("selectPersonAppt 시작");
		List<MemberVO> memberList=null;
		memberList=humanDao.selectPersonAppt(mvo);
		logger.info("selectPersonAppt 종료");
		return memberList;
	}
	@Override
	public List<CommVO> selectCommute(CommVO cvo){
		logger.info("selectCommute 시작");
		List<CommVO> memberList=null;
		memberList=humanDao.selectCommute(cvo);
		logger.info("selectCommute 종료");
		return memberList;
	}
	@Override
	public StatusVO selectTotal(){
		
		return humanDao.selectTotal();
	}
	@Override
	public MemberVO memberInfo(MemberVO mvo){
		return humanDao.memberInfo(mvo);
	}
	@Override
	public MemberVO selectPosition(MemberVO mvo){
		logger.info("selectPosition 시작");
		MemberVO pvo=null;
		pvo=humanDao.selectPosition(mvo);
		logger.info("selectPosition 종료");
		return pvo;
	}
	@Override
	public List<MemberVO> selectDeptMem(MemberVO mvo){
		logger.info("selectDeptMem 시작");
		List<MemberVO> memberList=null;
		memberList=humanDao.selectDeptMem(mvo);
		logger.info("selectDeptMem 종료");
		return memberList;
	}
	@Override
	public List<MemberVO> selectAllMem(MemberVO mvo){
		logger.info("selectAllMem 시작");
		List<MemberVO> memberList=null;
		memberList=humanDao.selectAllMem(mvo);
		logger.info("selectAllMem 종료");
		return memberList;
	}
	@Override
	public List<ApprVO> selectAppr(ApprVO avo){
		logger.info("selectAppr 시작");
		List<ApprVO> apprList=null;
		apprList=humanDao.selectAppr(avo);
		logger.info("selectAppr 종료");
		return apprList;
	}
	@Override
	public ApprVO selectApprMem(ApprVO avo){
		avo=humanDao.selectApprMem(avo);
		return avo;
	}
	@Override
	public List<CommVO> selectLastHour(CommVO cvo) {
		logger.info("selectLastHour 시작");
		List<CommVO> sList = null;
		sList = humanDao.selectLastHour(cvo);
		logger.info("selectLastHour 종료");
		return sList;
	}
	
	@Override
	public boolean insertExtrawork(CommVO cvo){
		logger.info("insertExtrawork 시작");
		boolean bFlag = false;
		int iFlag = humanDao.insertExtrawork(cvo);
		if(iFlag == 1) bFlag = true;
		logger.info("insertExtrawork 종료");
		return bFlag;
	}
	@Override
	public boolean idCheck(MemberVO mvo){
		logger.info("idCheck 시작");
		boolean flag=false;
	
		String id=null;
		
		id=humanDao.idCheck(mvo);
		
		if(Integer.parseInt(id)<=0){
			flag=true;
		}
		logger.info("idCheck 종료");
		return flag;
	}
	
	//로그인 후 첫 화면에서 쓰임
	@Override
	public List<MemberVO> selectUserInfo(MemberVO mvo) {
		// TODO Auto-generated method stub
		
		List<MemberVO> list = null;
		list = humanDao.selectUserInfo(mvo);
		
		return list;
	}
	
	
	
}
