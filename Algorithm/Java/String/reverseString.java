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
}