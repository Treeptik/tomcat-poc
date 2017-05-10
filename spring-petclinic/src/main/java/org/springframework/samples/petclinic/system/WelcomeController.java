package org.springframework.samples.petclinic.system;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.metrics.CounterService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
class WelcomeController {

    private final CounterService counterService;

    @Autowired
    public WelcomeController(CounterService counterService) {
        this.counterService = counterService;
    }

    @RequestMapping("/")
    public String welcome() {
        System.out.println("welcome increment");
        counterService.increment("counter.calls.welcome");
        return "welcome";
    }
}
