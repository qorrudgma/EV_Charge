package com.boot.elasticsearch;

import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class HangulComposer {
	// 초성, 중성, 종성 배열 정의
	private static final char[] CHOSUNG = { 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ',
			'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' };

	private static final char[] JUNGSUNG = { 'ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ',
			'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ' };

	private static final char[] JONGSUNG = { '\0', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ',
			'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' };

	// 중성 결합 규칙 (예: ㅗ+ㅏ = ㅘ)
	private static final Map<String, Character> COMPOSED_JUNGSUNG = Map.ofEntries(Map.entry("ㅗㅏ", 'ㅘ'),
			Map.entry("ㅗㅐ", 'ㅙ'), Map.entry("ㅗㅣ", 'ㅚ'), Map.entry("ㅜㅓ", 'ㅝ'), Map.entry("ㅜㅔ", 'ㅞ'),
			Map.entry("ㅜㅣ", 'ㅟ'), Map.entry("ㅡㅣ", 'ㅢ'), Map.entry("ㅏㅣ", 'ㅐ'), Map.entry("ㅓㅣ", 'ㅔ'),
			Map.entry("ㅑㅣ", 'ㅒ'), Map.entry("ㅕㅣ", 'ㅖ'));

	// 복합 받침 결합 규칙 (예: ㄱ+ㅅ = ㄳ)
	private static final Map<String, Character> COMPOSED_JONGSUNG = Map.ofEntries(Map.entry("ㄱㅅ", 'ㄳ'),
			Map.entry("ㄴㅈ", 'ㄵ'), Map.entry("ㄴㅎ", 'ㄶ'), Map.entry("ㄹㄱ", 'ㄺ'), Map.entry("ㄹㅁ", 'ㄻ'),
			Map.entry("ㄹㅂ", 'ㄼ'), Map.entry("ㄹㅅ", 'ㄽ'), Map.entry("ㄹㅌ", 'ㄾ'), Map.entry("ㄹㅍ", 'ㄿ'),
			Map.entry("ㄹㅎ", 'ㅀ'), Map.entry("ㅂㅅ", 'ㅄ'));

	// 문자 배열에서 인덱스를 구함
	private static int indexOf(char[] array, char target) {
		for (int i = 0; i < array.length; i++) {
			if (array[i] == target) {
				return i;
			}
		}
		return -1;
	}

	// 자모 문자열을 완성형 한글로 조합
	public String combine(String jamos) {
		StringBuilder result = new StringBuilder();
		int state = 0; // 0: 초성 대기, 1: 중성 대기, 2: 종성 대기
		int cho = -1, jung = -1, jong = 0;

		for (int i = 0; i < jamos.length(); i++) {
			char ch = jamos.charAt(i);
			char nextChar = (i + 1) < jamos.length() ? jamos.charAt(i + 1) : '\0';
			char nextNextChar = (i + 2) < jamos.length() ? jamos.charAt(i + 2) : '\0';

			// 중성 결합 (예: ㅗ + ㅏ = ㅘ)
			if (state == 1 && indexOf(JUNGSUNG, ch) != -1 && indexOf(JUNGSUNG, nextChar) != -1) {
				String combo = "" + ch + nextChar;
				if (COMPOSED_JUNGSUNG.containsKey(combo)) {
					ch = COMPOSED_JUNGSUNG.get(combo);
					i++;
				}
			}

			// 종성 결합 (다음다음 글자가 모음이면 초성일 가능성 있음 -> 조합 금지)
			if (state == 2 && indexOf(JONGSUNG, ch) != -1 && indexOf(JONGSUNG, nextChar) != -1) {
				String combo = "" + ch + nextChar;
				int nextNextJungIndex = indexOf(JUNGSUNG, nextNextChar);
				if (COMPOSED_JONGSUNG.containsKey(combo) && nextNextJungIndex == -1) {
					ch = COMPOSED_JONGSUNG.get(combo);
					i++;
				}
			}

			int choIndex = indexOf(CHOSUNG, ch);
			int jungIndex = indexOf(JUNGSUNG, ch);
			int jongIndex = indexOf(JONGSUNG, ch);
			int nextJungIndex = indexOf(JUNGSUNG, nextChar);

			switch (state) {
			case 0: // 초성 입력 대기 상태
				if (choIndex != -1) {
					cho = choIndex;
					state = 1;
				} else {
					result.append(ch);
				}
				break;
			case 1: // 중성 입력 대기 상태
				if (jungIndex != -1) {
					jung = jungIndex;
					state = 2;
				} else {
					result.append(CHOSUNG[cho]);
					if (choIndex != -1) {
						cho = choIndex;
					} else {
						result.append(ch);
						state = 0;
						cho = -1;
					}
				}
				break;
			case 2: // 종성 입력 대기 상태
				if (jongIndex != -1) {
					if (nextJungIndex != -1) {
						// 다음 글자가 중성이면 현재 글자는 초성 -> 분리 처리
						char syllable = (char) (0xAC00 + cho * 21 * 28 + jung * 28);
						result.append(syllable);
						cho = indexOf(CHOSUNG, ch);
						state = cho == -1 ? 0 : 1;
						jong = 0;
					} else {
						// 종성으로 간주하고 결합
						jong = jongIndex;
						char syllable = (char) (0xAC00 + cho * 21 * 28 + jung * 28 + jong);
						result.append(syllable);
						state = 0;
						cho = jung = jong = 0;
					}
				} else {
					// 종성 없음 -> 초성 + 중성만 결합
					char syllable = (char) (0xAC00 + cho * 21 * 28 + jung * 28);
					result.append(syllable);
					state = choIndex != -1 ? 1 : 0;
					cho = choIndex;
					jong = 0;
					if (state == 0) {
						result.append(ch);
					}
				}
				break;
			}
		}

		// 루프 종료 후 남은 글자 처리
		if (state == 1) {
			result.append(CHOSUNG[cho]);
		} else if (state == 2) {
			result.append((char) (0xAC00 + cho * 21 * 28 + jung * 28));
		}
		return result.toString();
	}
}