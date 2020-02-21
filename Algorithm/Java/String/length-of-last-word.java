class Solution {
    public static void main(String[] args) {
        int l = lengthOfLastWord("Hello World");
        System.out.println("l = "+l);
    }
    public static int lengthOfLastWord(String s) {
        if (s.equals("")) 
            return 0;
        int length = 0;
        for (int i = s.toCharArray().length - 1; i >= 0; i--) {
            char c = s.charAt(i);
            if (c == ' ') {
                if (length == 0) 
                    continue;
                return length;
            } else {
                length++;
            }
        }
        return length;
    }
}