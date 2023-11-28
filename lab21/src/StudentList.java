/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.lab_0021;

import java.util.ArrayList;


public class StudentList extends ArrayList<Student>{
    private int count=0;
    @Override
    public boolean add(Student s) {
        if (super.add(s)) { 
            count++;
            return true;
        }
        return false;
    }
    public boolean remove(String id) {
        try
            {
                super.remove(this.getIndex(id));
                count--;
                return true;
            }  catch (Exception e) {return false;}
    }
    public boolean idExisted(String id) {
        for (Student s : this) {
            if (s.getId().equals(id)) return true;
        }
        return false;
    }
    public int soSV() {
        return count;
    }
    public void tangCourseTotal(String id) {
        this.get(this.getIndex(id)).upCT();
    }
    public int getIndex(String id) {
        for (int i = 0; i < this.size(); i++) {
            if (this.get(i).getId().equals(id)) return i;
        }
        return -1;
    }
}
