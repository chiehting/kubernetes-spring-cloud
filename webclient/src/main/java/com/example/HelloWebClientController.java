package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;


@Controller
public class HelloWebClientController {
    @Value("${webservice.name}")
    private String webservice_name;

    @GetMapping("/")
    public String handleRequest(Model model) {
        //accessing hello-service

        String url = webservice_name;
        url = url + "/hello";
        RestTemplate restTemplate = new RestTemplate();
        HelloObject helloObject = restTemplate.getForObject(url,
                HelloObject.class);
        model.addAttribute("msg", helloObject.getMessage());
        model.addAttribute("time", LocalDateTime.now());
        model.addAttribute("webservice_name", webservice_name);
        model.addAttribute("url", url);

        return "hello-page";
    }
}
