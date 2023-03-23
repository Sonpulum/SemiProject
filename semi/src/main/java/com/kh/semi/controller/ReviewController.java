package com.kh.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.semi.dao.ReviewDao;

@Controller
public class ReviewController {
	@Autowired ReviewDao reviewDao;
}
