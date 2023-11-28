/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.lab_0021;

import java.util.Scanner;

/**
 *
 * @author ADMIN
 */
public class Validation {
    public static int inputInt() {
        Scanner scan = new Scanner(System.in);
        while (true) {
            try {
                    return Integer.parseInt(scan.nextLine());
            } catch (NumberFormatException e) {System.out.println("Please input an integer");}
        } 
    }
    public static String inputUD() {
        Scanner scan = new Scanner(System.in);
        while (true) {
            try {
                    String input = scan.nextLine().trim().toLowerCase();
                    if (input.matches("u|d")) return input;
            } catch (NumberFormatException e) {System.out.println("Please input 'U' or 'D'");}
        } 
    }
    public static String inputString() {
        Scanner scan = new Scanner(System.in);
        while (true) {
            try {
                    String input = scan.nextLine().trim();
                    if (!input.isEmpty()) return input;
            } catch (NumberFormatException e) {System.out.println("This cannot be blank");}
        } 
    }
    public static boolean inputYN() {
        Scanner scan = new Scanner(System.in);
        while (true) {
            try {
                    String input = scan.nextLine().trim().toLowerCase();
                    if (input.matches("y")) return true;
                    else if (input.matches("n")) return false;
                    throw new NumberFormatException();
            } catch (NumberFormatException e) {System.out.println("Please input 'Y' or 'N'");}
        } 
    }
    public static String inputCourse() {
        Scanner scan = new Scanner(System.in);
        while (true) {
            try {
                    String input = scan.nextLine().trim().toLowerCase();
                    switch (input) {
                        case "j":
                        case "java":
                            return "Java";
                        case ".net":
                        case ".":
                        case "n":
                            return ".Net";
                        case "c":
                        case "c/c++":
                        case "c++":
                            return "C/C++";
                        default:
                            throw new NumberFormatException();
                    }
            } catch (NumberFormatException e) {System.out.println("Course name invalid, enter again");}
        } 
    }
}
