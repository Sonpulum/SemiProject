package com.kh.semi.component;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Component;

@Component //독립 기능을 처리하는 도구
public class RandomComponent {
   private List<String> data = new ArrayList<>();
   private List<String> data1 = new ArrayList<>();
   private List<String> data2 = new ArrayList<>();
   private List<String> data3 = new ArrayList<>();
   private List<String> data4 = new ArrayList<>();
   private Random r = new Random();
   
   //Spring에서는 초기 설정을 위해 생성자를 사용하지 않는다(Java Reflection 때문)
   //public RandomComponent(){}
   
   //Spring에서는 메소드에 @PostConstruct를 추가하여 생성자 역할을 수행한다
   @PostConstruct
   public void init() {
      for(char i='A'; i <='Z'; i++) data.add(String.valueOf(i));
      for(char i='A'; i <='Z'; i++) data1.add(String.valueOf(i));
      for(char i='a'; i <='z'; i++) data.add(String.valueOf(i));
      for(char i='a'; i <='z'; i++) data2.add(String.valueOf(i));
      for(char i='0'; i <='9'; i++) data.add(String.valueOf(i));
      for(char i='0'; i <='9'; i++) data3.add(String.valueOf(i));
      data.add("!");
      data4.add("!");
      data.add("@");
      data4.add("@");
      data.add("#");
      data4.add("#");
      data.add("$");
      data4.add("$");
      data.add("%");
      data4.add("%");
      data.add("^");
      data4.add("^");
      data.add("&");
      data4.add("&");
      data.add("(");
      data4.add("(");
      data.add(")");
      data4.add(")");
      data.add("_");
      data4.add("_");
      data.add("-");
      data4.add("-");
      data.add("+");
      data4.add("+");
   }
   
   public String generateString(int size) {
      StringBuffer buffer = new StringBuffer();
      for(int i = 0; i < size; i++) {
    	  if (i==0) {
    		  int idx = r.nextInt(data1.size());
    		  buffer.append(data1.get(idx));
    	  }
    	  
    	  else if (i==1) {
    		  int idx = r.nextInt(data2.size());
    		  buffer.append(data2.get(idx));	 
    	  }
    	  
    	  else if (i==2) {
    		  int idx = r.nextInt(data3.size());
    		  buffer.append(data3.get(idx));	 
    	  }
    	  
    	  else if (i==3) {
    		  int idx = r.nextInt(data4.size());
    		  buffer.append(data4.get(idx));	 
    	  }
    	  else {
	    	  int index = r.nextInt(data.size());
	    	  buffer.append(data.get(index));
    	  }
      }
      return buffer.toString();
   }
}