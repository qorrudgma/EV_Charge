//package com.boot.elasticsearch;
//
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.io.InputStream;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.io.ClassPathResource;
//
//import kr.co.shineware.nlp.komoran.core.Komoran;
//
//@Configuration
//public class KomoranConfig {
//
//	private void copyFolderToTemp(File targetDir, ClassPathResource resource) throws IOException {
//		if (!targetDir.exists()) {
//			targetDir.mkdirs();
//		}
//
//		// resources/models_full 폴더 내 파일들을 임시폴더로 복사 (단순 예시, 하위 파일도 복사하려면 재귀 필요)
//		String[] modelFiles = { "morph.ko.dic", "pos.simple" }; // 필수 모델 파일명 예시
//
//		for (String fileName : modelFiles) {
//			ClassPathResource fileResource = new ClassPathResource("models_full/" + fileName);
//			File targetFile = new File(targetDir, fileName);
//
//			try (InputStream is = fileResource.getInputStream();
//					FileOutputStream fos = new FileOutputStream(targetFile)) {
//
//				byte[] buffer = new byte[4096];
//				int read;
//				while ((read = is.read(buffer)) != -1) {
//					fos.write(buffer, 0, read);
//				}
//			}
//		}
//	}
//
//	@Bean
//	public Komoran komoran() throws IOException {
//		// 1. 임시 폴더 경로 생성
//		File tempDir = new File(System.getProperty("java.io.tmpdir"), "models_full");
//
//		// 2. 모델 폴더 복사 (이미 복사되어 있으면 건너뜀)
//		if (!tempDir.exists() || tempDir.listFiles() == null || tempDir.listFiles().length == 0) {
//			copyFolderToTemp(tempDir, new ClassPathResource("models_full"));
//		}
//
//		// 3. Komoran 초기화 - 절대 경로 사용
//		return new Komoran(tempDir.getAbsolutePath());
//	}
//}
