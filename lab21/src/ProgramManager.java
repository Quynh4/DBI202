/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import java.util.Collections;
import java.util.Comparator;

/**
 *
 * @author ADMIN
 */
public class ProgramManager {
    
    StudentList dssv = new StudentList();
    public static void menu() {
        System.out.println("WELCOME TO STUDENT MANAGEMENT");
        System.out.println("    1. Create");
        System.out.println("    2. Find and Sort");
        System.out.println("    3. Update/Delete");
        System.out.println("    4. Report");
        System.out.println("    5. Exit");
        System.out.println("");
    }
    public static void pause() {
        java.util.Scanner scan = new java.util.Scanner(System.in);
        scan.nextLine();
    }
    
    //Function 1
    public static void create() {
        int sem;
        String name,id,course;
        boolean continu=true;
        while (dssv.soSV()<=10 || continu) {
            do {
                System.out.print("Nhap id: ");
                id = Validation.inputString();
                if (dssv.idExisted(id)) {
                    System.out.println("ID da ton tai, ban co muon tang so luong khoa hoc cua sinh vien? Y/N.");
                    if (Validation.inputYN()) dssv.tangCourseTotal(id);
                }
            } while (dssv.idExisted(id));

            System.out.print("Nhap ten: ");
            name = Validation.inputString();
            System.out.print("Nhap ky hoc: ");
            sem = Validation.inputInt();
            System.out.print("Nhap ten khoa: ");
            course = Validation.inputCourse();
            System.out.println((String)(dssv.add(new Student(id,name,sem,course)) ? "Them thanh cong" : "Da xay ra loi"));
            if (dssv.soSV()>10) System.out.print("Continue? Y/N ");
            continu = Validation.inputYN();
        }
    }
    
    //Function 2
    public static void findnSort() {
        System.out.println("Nhap ten can tim: ");
        String namePart = Validation.inputString();
        int count=0;
        Collections.sort(dssv, Comparator.comparing(Student::getName));
        for (Student student : dssv) {
            if (student.getName().contains(namePart)) 
            {
                System.out.println(student.display());
                count++;
            }
        }
        if (count<1) System.out.println("Khong tim thay sinh vien nao");
    }
    
    //Function 3
    public static void updatenDelete() {
        System.out.print("Nhap id: ");
        String id = Validation.inputString();
        if (dssv.idExisted(id)) {
            System.out.print("Update hoac Delete sinh vien U/D: ");
            switch (Validation.inputUD()) {
                case "U":
                    dssv.get(dssv.getIndex(id)).update();
                    break;
                case "D":
                    if (dssv.remove(id)) System.out.println("Xoa thanh cong");
                    else System.out.println("Xoa that bai, da xay ra loi");
                    break;
            }
        }   else System.out.println("ID khong ton tai");  
    }
    
    //Function 4
    public static void report() {
        System.out.print("Nhap id: ");
        String id = Validation.inputString();
        if (dssv.idExisted(id)) {
            System.out.println(dssv.get(dssv.getIndex(id)).toString());
        } else System.out.println("ID khong ton tai");   
    }
}
