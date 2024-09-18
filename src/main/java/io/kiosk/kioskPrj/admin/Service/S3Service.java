package io.kiosk.kioskPrj.admin.Service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class S3Service {

    private final AmazonS3 amazonS3;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    public String saveFile(MultipartFile multipartFile) throws IOException {
        // 파일의 원본 파일명 가져오기
        String originalFilename = multipartFile.getOriginalFilename();

        // 파일 메타데이터 설정
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(multipartFile.getSize());  // 파일 크기 설정
        metadata.setContentType(multipartFile.getContentType());  // 파일 MIME 타입 설정

        // 파일을 S3 버킷에 저장
        amazonS3.putObject(bucket, originalFilename, multipartFile.getInputStream(), metadata);

        // 저장된 파일의 S3 URL을 반환
        return amazonS3.getUrl(bucket, originalFilename).toString();
    }
}