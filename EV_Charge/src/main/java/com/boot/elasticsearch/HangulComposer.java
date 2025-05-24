package com.boot.elasticsearch;

import org.springframework.stereotype.Component;

@Component
public class HangulComposer {
	private static final char[] CHOSUNG = { 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ',
			'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' };

	private static final char[] JUNGSUNG = { 'ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ',
			'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ' };

	private static final char[] JONGSUNG = { '\0', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ',
			'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' };

	private static int indexOf(char[] array, char target) {
		for (int i = 0; i < array.length; i++) {
			if (array[i] == target) {
				return i;
			}
		}
		return -1;
	}

	public String combine(String jamos) {
		StringBuilder result = new StringBuilder();

		int state = 0; // 0: 초성, 1: 중성, 2: 종성 대기
		int cho = -1, jung = -1, jong = 0;

		for (int i = 0; i < jamos.length(); i++) {
			char ch = jamos.charAt(i);

			int choIndex = indexOf(CHOSUNG, ch);
			int jungIndex = indexOf(JUNGSUNG, ch);
			int jongIndex = indexOf(JONGSUNG, ch);

			// 다음 글자 확인 (범위 체크)
			char nextChar = (i + 1) < jamos.length() ? jamos.charAt(i + 1) : '\0';
			int nextJungIndex = indexOf(JUNGSUNG, nextChar);

			switch (state) {
			case 0: // 초성 대기
				if (choIndex != -1) {
					cho = choIndex;
					state = 1; // 중성 대기
				} else {
					result.append(ch);
				}
				break;

			case 1: // 중성 대기
				if (jungIndex != -1) {
					jung = jungIndex;
					state = 2; // 종성 대기
				} else {
					// 중성 없으면 초성만 처리
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

			case 2: // 종성 대기
				if (jongIndex != -1) {
					// 여기서 조건 추가: 다음 글자가 모음이면 종성이 아니라 초성임
					if (nextJungIndex != -1) {
						// 다음 글자가 모음 → 지금 글자는 초성으로 처리하고 현재 완성
						char syllable = (char) (0xAC00 + (cho * 21 * 28) + (jung * 28));
						result.append(syllable);
						// 현재 글자는 다음 글자의 초성 역할
						cho = indexOf(CHOSUNG, ch);
						if (cho == -1) {
							// 만약 초성이 아니면 그냥 붙임
							result.append(ch);
							state = 0;
							cho = -1;
						} else {
							state = 1; // 중성 대기로
						}
						jong = 0;
					} else {
						// 다음 글자가 모음 아님 → 정상 종성 처리
						jong = jongIndex;
						char syllable = (char) (0xAC00 + (cho * 21 * 28) + (jung * 28) + jong);
						result.append(syllable);
						state = 0;
						cho = -1;
						jung = -1;
						jong = 0;
					}
				} else {
					// 종성 후보 아님 → 종성 없이 초성+중성 완성
					char syllable = (char) (0xAC00 + (cho * 21 * 28) + (jung * 28));
					result.append(syllable);
					if (choIndex != -1) {
						cho = choIndex;
						state = 1;
					} else {
						result.append(ch);
						state = 0;
						cho = -1;
					}
					jong = 0;
				}
				break;
			}
		}

		// 남은 글자 처리
		if (state == 1) {
			result.append(CHOSUNG[cho]);
		} else if (state == 2) {
			char syllable = (char) (0xAC00 + (cho * 21 * 28) + (jung * 28));
			result.append(syllable);
		}

		return result.toString();
	}
}