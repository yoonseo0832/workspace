package com.kh.test.aspect;


import java.util.Arrays;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect			// Aspect 선언
@Component		// 빈등록
public class LoggingAspect {
	// 롬북 없이 로그 객체 사용하는 방법 : Logger 
	private final Logger log = LoggerFactory.getLogger(LoggingAspect.class);
	
	// 기본 패키지 경로 내의 모든 메소드를 대상
	@Pointcut("execution(* com.kh.test..*.*(..))")
	public void pointCut() {}
	// 호출 전 메소드명, 파라티터 정보 로그로 출력
	@Before("pointCut()")
	public void beforeAdvice(JoinPoint joinPoint) {
		//MethodSignature methodSignature = (MethodSignature)joinPoint.getSignature();
		//Method method = methodSignature.getMethod();
		
		//Object[] obj = joinPoint.getArgs();
		
		log.info("method  :: {}", joinPoint.getSignature().getName());
		log.info("param   :: {}", Arrays.toString(joinPoint.getArgs()) );
	}
	
	@Around("pointCut()")
	public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		
		long start  = System.currentTimeMillis();	// 실행 전 시간 측정
		
		Object execute = joinPoint.proceed();
		
		long end = System.currentTimeMillis();		// 실행 후 시간 측정
		
		log.info("execution time :: {}", (end-start));
		
		return execute;
	}
}
