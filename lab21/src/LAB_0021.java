/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.lab_0021;

/**
 *
 * @author ADMIN
 */
public class LAB_0021 {

    public static void main(String[] args) {
        int choice=0;
        do {
            ProgramManager.menu();
            System.out.println("Choose 1 to Create, 2 to Find and Sort, 3 to Update/Delete, 4 to Report and 5 to Exit program).");
            try {
                choice=Validation.inputInt();
                switch (choice) {
                    case 1:
                        ProgramManager.create();
                        break;
                    case 2:
                        ProgramManager.findnSort();
                        ProgramManager.pause();
                        break;
                    case 3:
                        ProgramManager.updatenDelete();
                        break;
                    case 4:
                        ProgramManager.report();
                        ProgramManager.pause();
                        break;
                    case 5:
                        System.out.println("Closed");
                        break;
                    default:
                        System.out.println("Invalid choice");
                } 
            } catch (Exception e) {System.out.println("Invalid choice");}
        } while (choice!=5);
    }
}
