/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.lab_0021;

/**
 *
 * @author ADMIN
 */
public class Student {
    private String id;
    private String name;
    private int sem;
    private String course;
    private int courseNum=1;

    public Student() {
    }

    public Student(String id, String name, int sem, String course) {
        this.id = id;
        this.name = name;
        this.sem = sem;
        this.course = course;
    }
    
    public String display() {
        return "Name: "+name+" Semester: "+sem+" Course: "+courseNum;
    }
    @Override
    public String toString() {
        return name+" | "+course+" | "+courseNum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSem() {
        return sem;
    }

    public void setSem(int sem) {
        this.sem = sem;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public int getCourseNum() {
        return courseNum;
    }

    public void setCourseNum(int courseNum) {
        this.courseNum = courseNum;
    }
    
    public void upCT() {
        this.courseNum++;
    }
    
    public void update() {
        System.out.print("Nhap ten: ");
        name = Validation.inputString();
        System.out.print("Nhap ky hoc: ");
        sem = Validation.inputInt();
        System.out.print("Nhap ten khoa: ");
        course = Validation.inputCourse();
    }
}
