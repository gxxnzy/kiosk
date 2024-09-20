package io.kiosk.kioskPrj.admin.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class S3Config {

    // AWS S3 액세스 키
    @Value("${cloud.aws.credentials.access-key}")
    private String accessKey;

    // AWS S3 시크릿 키
    @Value("${cloud.aws.credentials.secret-key}")
    private String secretKey;

    // AWS 리전
    @Value("${cloud.aws.region.static}")
    private String region;

    @Bean
    public AmazonS3Client amazonS3Client() {
        // AWS 자격 증명 객체 생성
        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);

        // AmazonS3Client 인스턴스 생성 및 반환
        return (AmazonS3Client) AmazonS3ClientBuilder
            .standard()  // 기본 설정으로 클라이언트 빌더 생성
            .withRegion(region)  // 설정된 AWS 리전으로 클라이언트 빌더 구성
            .withCredentials(new AWSStaticCredentialsProvider(credentials))  // 자격 증명 제공자 설정
            .build();  // 클라이언트 인스턴스 생성
    }
}
