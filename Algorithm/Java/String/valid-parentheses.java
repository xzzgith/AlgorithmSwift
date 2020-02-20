import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

class Solution {
    public static void main(String[] args) {
        if (isValid("(()(")) {
            System.out.println("是有效的括号");
        }else {
            System.out.println("不是有效的括号");
        }
    }
    /* 
     * 有效括号
     * https://leetcode-cn.com/problems/valid-parentheses/
     */
    // public static boolean isValid(String s) {
    //     Stack tempS = new Stack<Character>();
    //     Map map = new HashMap<Character, Character>();
    //     map.put('{', '}');
    //     map.put('[', ']');
    //     map.put('(', ')');
    //     for (Character c : s.toCharArray()) {
    //         if (map.containsKey(c)) {
    //             tempS.push(c);
    //         } else {
    //             char top = tempS.empty() ? '?' : (char)tempS.pop();
    //             if (c != map.get(top)) 
    //                 return false;
    //         }
    //     }
    //     return tempS.empty();
    // }
    public static boolean isValid(String s) {
        if (s.isEmpty()) 
            return true;
        Stack tempS = new Stack<Character>();
        for (Character c : s.toCharArray()) {
            if (c=='[') 
                tempS.push(']');
            else if (c=='{') 
                tempS.push('}');
            else if (c=='(')
                tempS.push(')');
            else if (tempS.empty() || c != tempS.pop()){
                return false;
            }
        }
        return tempS.empty();
    }
}