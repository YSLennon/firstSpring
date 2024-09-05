package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.BoardService;
import com.google.gson.Gson;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("board/list.do")
	public String main(Model model) throws Exception{
		return "/board-list";
	}	
	@RequestMapping("board/insert.do")
	public String maininsert(Model model) throws Exception{
		return "/board-insert";
	}	
	@RequestMapping("board/view.do")
	public String mainView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("boardNo", map.get("boardNo"));
		return "/board-view";
	}
	
	
	@RequestMapping(value = "/board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= boardService.searchBoardList(map);
		return new Gson().toJson(resultMap);	
	}
	@RequestMapping(value = "/board/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= boardService.removeBoard(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/board/insert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= boardService.insertBoard(map);
		System.out.println(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/board/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String viewBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HashMap<String, Object> resultMap= boardService.viewBoard(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping("/board/fileUpload.dox")
    public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("idx") int idx, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path=System.getProperty("user.dir");
        try {
 
            //String uploadpath = request.getServletContext().getRealPath(path);
            String uploadpath = path;
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            long size = multi.getSize();
            String saveFileName = genSaveFileName(extName);
            
            System.out.println("uploadpath : " + uploadpath);
            System.out.println("originFilename : " + originFilename);
            System.out.println("extensionName : " + extName);
            System.out.println("size : " + size);
            System.out.println("saveFileName : " + saveFileName);
//            String path2 = System.getProperty("user.dir");
            System.out.println("Working Directory = " + path + "\\src\\webapp\\img");
            if(!multi.isEmpty()){
            	// mkdir 먼저 만들어져야함
                File file = new File(path + "\\src\\main\\webapp\\img", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("fileName", saveFileName);
                map.put("filePath", "../img/" + saveFileName);
                map.put("idx", idx);
                map.put("fileOrgName", originFilename);
                map.put("fileSize", size);
                map.put("fileExt", extName);
                
                // insert 쿼리 실행         
                
                model.addAttribute("filename", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                  System.out.println("insertBoardFile: " + map);              
                boardService.insertBoardFile(map);
                
                
                return "redirect:../board/list.do";
            }
        }catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:../board/list.do";
    }
    
    // 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
        String fileName = "";
        
        Calendar calendar = Calendar.getInstance();
        fileName += calendar.get(Calendar.YEAR);
        fileName += calendar.get(Calendar.MONTH);
        fileName += calendar.get(Calendar.DATE);
        fileName += calendar.get(Calendar.HOUR);
        fileName += calendar.get(Calendar.MINUTE);
        fileName += calendar.get(Calendar.SECOND);
        fileName += calendar.get(Calendar.MILLISECOND);
        fileName += extName;
        
        return fileName;
    }
}
