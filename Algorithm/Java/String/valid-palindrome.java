import jdk.nashorn.internal.ir.ContinueNode;

class Solution {
    public static void main(String[] args) {
        boolean s = isPalindrome("A man a plan a canal Panama");
        if (s) {
            System.out.println("huiwen");
        } else {
            System.out.println("no");
        }
    }
    public static boolean isValidChar(char c) {
        if (c >= 'A' && c <= 'Z') 
            return true;
        else if (c >= 'a' && c <= 'z') 
            return true;
        else if (c >= '0' && c <= '9') 
            return true;
        else 
            return false;
    }
    public static boolean isPalindrome(String s) {
        int i = 0;
        int j = s.toCharArray().length - 1;
        while (i <= j) {
            char c = s.charAt(i);
            if (!isValidChar(c)) {
                i++;
                continue;
            }
            char ct = s.charAt(j);
            if (!isValidChar(ct)) {
                j--;
                continue;
            }
            String a = String.valueOf(c).toLowerCase();
            String b = String.valueOf(ct).toLowerCase();
            if (!String.valueOf(c).toLowerCase().equals(String.valueOf(ct).toLowerCase())) {
                return false;
            }
            i++;
            j--;
        }
        return true;
    }
}