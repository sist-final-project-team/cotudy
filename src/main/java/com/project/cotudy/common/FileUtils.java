package com.project.cotudy.common;

import java.io.File;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.cotudy.model.BoardFileDto;

@Component
public class FileUtils {

	public List<BoardFileDto> parseFileInfo(int freeNum, MultipartHttpServletRequest multireq) throws Exception{
		if(ObjectUtils.isEmpty(multireq)){
			return null;
		}
		
		List<BoardFileDto> fileList = new ArrayList<>();
		
		//파일이 업로드 될 폴더 생성 ex)20191025
		DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyyMMdd"); 
    	ZonedDateTime current = ZonedDateTime.now();
    	String path = "images/"+current.format(format);
    	File file = new File(path);
		if(file.exists() == false){
			file.mkdirs();
		}
		
		Iterator<String> iterator = multireq.getFileNames();
		
		String newFileName, originalFileExtension, contentType;
		
		//파일 형식 확인 후 확장자 지정
		while(iterator.hasNext()){
			List<MultipartFile> list = multireq.getFiles(iterator.next());
			for (MultipartFile multipartFile : list){
				if(multipartFile.isEmpty() == false){
					contentType = multipartFile.getContentType();
					if(ObjectUtils.isEmpty(contentType)){
						break;
					}
					else{
						if(contentType.contains("image/jpeg")) {
							originalFileExtension = ".jpg";
						}
						else if(contentType.contains("image/png")) {
							originalFileExtension = ".png";
						}
						else if(contentType.contains("image/gif")) {
							originalFileExtension = ".gif";
						}
						else{
							break;
						}
					}
					
					//서버에 저장될 파일 이름 생성
					newFileName = Long.toString(System.nanoTime()) + originalFileExtension;
					//DB에 저장할 파일 정보를 fileDto에 저장
					BoardFileDto boardFile = new BoardFileDto();
					boardFile.setFreeNum(freeNum);
					boardFile.setFileSize(multipartFile.getSize());
					boardFile.setOriginalFileName(multipartFile.getOriginalFilename());
					boardFile.setStoredFilePath(path + "/" + newFileName);
					fileList.add(boardFile);
					
					//업로드된 파일을 이름 바꿔서 지정된 경로에 저장
					file = new File(path + "/" + newFileName);
					multipartFile.transferTo(file);
				}
			}
		}
		return fileList;
	}
}
