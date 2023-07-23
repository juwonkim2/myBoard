package com.myportfolio.web.controller;

import com.myportfolio.web.domain.UserDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.net.URLEncoder;


@Controller
public class RegisterController {

    @GetMapping("/register/add")
    public String register() {
        return "registerForm";
    } // register

// 	@PostMapping("/register/save")
    @PostMapping("/register/add")
    public String save(@ModelAttribute("user") UserDto user, Model m) throws Exception {
        if(!isValid(user)) {
            String msg = URLEncoder.encode("id를 잘못 입력하셨습니다.", "utf-8");

            m.addAttribute("msg", msg);
            return "redirect:/register/add"; // 신규회원 가입화면으로 이동(redirect)
        } // if

        return "redirect:/juwon";
    } // save

    private boolean isValid(UserDto user) { return false; }

} // end class