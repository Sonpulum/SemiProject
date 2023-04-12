package com.kh.semi.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.configuration.CustomFileuploadProperties;
import com.kh.semi.dao.AttachmentDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberProfileDao;
import com.kh.semi.dto.AttachmentDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.MemberProfileDto;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MemberProfileDao memberProfileDao;

	@Autowired
	private AttachmentDao attachmentDao;

	@Autowired
	private CustomFileuploadProperties fileuploadProperties;
	
	private File dir;
	
	//최초 1번만 실행되는 메소드
	@PostConstruct
	public void init() {
		dir = new File(fileuploadProperties.getPath());
		dir.mkdirs();
	}

	//프로필 이미지 등록
	public void join(
			MemberDto memberDto, 
			MultipartFile attach
		 ) throws IllegalStateException, IOException {
		
		 memberDao.insert(memberDto);

		 if(!attach.isEmpty()) {
			 int attachmentNo = attachmentDao.sequence();

			 File target = new File(dir, String.valueOf(attachmentNo));
			 attach.transferTo(target);

			 attachmentDao.insert(AttachmentDto.builder()
					 	.attachmentNo(attachmentNo)
					 	.attachmentName(attach.getOriginalFilename())
					 	.attachmentType(attach.getContentType())
					 	.attachmentSize(attach.getSize())
					 .build());

			 //연결정보 등록
			 memberProfileDao.insert(MemberProfileDto.builder()
					 	.memberId(memberDto.getMemberId())
					 	.attachmentNo(attachmentNo)
					 .build());
		 }
	}
	
	//프로필 이미지 수정
	public void update(
			MemberDto memberDto, 
			MultipartFile attach
		) throws IllegalStateException, IOException {
	    
		memberDao.changeInformation(memberDto);

	    if (!attach.isEmpty()) {
	        int attachmentNo = attachmentDao.sequence();

	        File target = new File(dir, String.valueOf(attachmentNo));
	        attach.transferTo(target);

	        attachmentDao.insert(AttachmentDto.builder()
	                .attachmentNo(attachmentNo)
	                .attachmentName(attach.getOriginalFilename())
	                .attachmentType(attach.getContentType())
	                .attachmentSize(attach.getSize())
	                .build());

	        MemberProfileDto memberProfileDto = MemberProfileDto.builder()
	                .memberId(memberDto.getMemberId())
	                .attachmentNo(attachmentNo)
	                .build();

	        MemberProfileDto existingProfile = memberProfileDao.selectOne(memberDto.getMemberId());

	        if (existingProfile == null) {
	            memberProfileDao.insert(memberProfileDto);
	        } 
	        else {
	            memberProfileDao.update(memberProfileDto);
	        }
	    }
	}
	
}
