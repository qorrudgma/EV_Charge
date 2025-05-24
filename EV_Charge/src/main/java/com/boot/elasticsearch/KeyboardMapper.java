package com.boot.elasticsearch;

import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class KeyboardMapper {
	private static final Map<Character, Character> ENG_TO_KOR = Map.ofEntries(Map.entry('q', 'ㅂ'), Map.entry('w', 'ㅈ'),
			Map.entry('e', 'ㄷ'), Map.entry('r', 'ㄱ'), Map.entry('t', 'ㅅ'), Map.entry('y', 'ㅛ'), Map.entry('u', 'ㅕ'),
			Map.entry('i', 'ㅑ'), Map.entry('o', 'ㅐ'), Map.entry('p', 'ㅔ'),

			Map.entry('a', 'ㅁ'), Map.entry('s', 'ㄴ'), Map.entry('d', 'ㅇ'), Map.entry('f', 'ㄹ'), Map.entry('g', 'ㅎ'),
			Map.entry('h', 'ㅗ'), Map.entry('j', 'ㅓ'), Map.entry('k', 'ㅏ'), Map.entry('l', 'ㅣ'),

			Map.entry('z', 'ㅋ'), Map.entry('x', 'ㅌ'), Map.entry('c', 'ㅊ'), Map.entry('v', 'ㅍ'), Map.entry('b', 'ㅠ'),
			Map.entry('n', 'ㅜ'), Map.entry('m', 'ㅡ'),

			// Shift
			Map.entry('Q', 'ㅃ'), Map.entry('W', 'ㅉ'), Map.entry('E', 'ㄸ'), Map.entry('R', 'ㄲ'), Map.entry('T', 'ㅆ'),
			Map.entry('O', 'ㅒ'), Map.entry('P', 'ㅖ'),

			// 모음
			Map.entry('A', 'ㅁ'), Map.entry('S', 'ㄴ'), Map.entry('D', 'ㅇ'), Map.entry('F', 'ㄹ'), Map.entry('G', 'ㅎ'),
			Map.entry('H', 'ㅗ'), Map.entry('J', 'ㅓ'), Map.entry('K', 'ㅏ'), Map.entry('L', 'ㅣ'),

			// 자음
			Map.entry('Z', 'ㅋ'), Map.entry('X', 'ㅌ'), Map.entry('C', 'ㅊ'), Map.entry('V', 'ㅍ'), Map.entry('B', 'ㅠ'),
			Map.entry('N', 'ㅜ'), Map.entry('M', 'ㅡ'));

	public String convertEngToKor(String input) {
		StringBuilder result = new StringBuilder();
		for (char c : input.toCharArray()) {
			result.append(ENG_TO_KOR.getOrDefault(c, c));
		}
		return result.toString();
	}
}