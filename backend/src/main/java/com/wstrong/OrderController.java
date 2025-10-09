package com.wstrong;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@SpringBootApplication
@Controller
public class OrderController {

	@GetMapping("/order")
	public String getOrder(Model model) {
		return "order";
	}

  @PostMapping("/order")
  public String postOrder(Model model) {
    return "orderComplete";
  }

}
