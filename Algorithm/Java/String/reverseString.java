class Solution {
    public void reverseString(char[] s) {
        int l = 0;
        int r = s.length - 1;
        for (; i < r; l++,r--) {
            char t = s[l];
            s[l] = s[r];
            s[r] = t;
        }
    }
    public void reverseString2(char[] s) {
        for (int i = 0; i < s.length / 2; i++) {
            char t = s[i];
            s[i] = s[s.length-1-i];
            s[s.length-1-i] = t;
        }
    }
}