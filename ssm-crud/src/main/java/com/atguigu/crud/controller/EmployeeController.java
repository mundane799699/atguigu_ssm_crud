package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;


    @ResponseBody
    @RequestMapping(value = "/checkuser")
    public Msg checkUser(@RequestParam("empName") String empName) {
        String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regex)) {
            return Msg.fail().add("va_msg", "用户名必须是6-16位英文和数字的组合或者2-5位中文");
        }
        boolean nameNotRegisterd = employeeService.checkUser(empName);
        if (nameNotRegisterd) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "该用户名已存在");
        }
    }


    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5, "emp_id asc");
        List<Employee> emps = employeeService.getAll();
        PageInfo<Employee> page = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 新增员工信息
     *
     * @param employee
     * @param result
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     * 更新员工信息
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 删除员工, 单个批量二合一
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            String[] strIds = ids.split("-");
            List<Integer> idList = new ArrayList<>();
            for (String strId : strIds) {
                idList.add(Integer.parseInt(strId));
            }
            employeeService.deleteBatch(idList);
        } else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    // @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//        PageHelper.startPage(pn, 5, "emp_id asc");
//        List<Employee> emps = employeeService.getAll();
//        PageInfo<Employee> page = new PageInfo<>(emps, 5);
//        model.addAttribute("pageInfo", page);
//        return "list";
//    }
}
