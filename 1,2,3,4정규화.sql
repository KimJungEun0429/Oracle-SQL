--계층형(조직도, 주소)인 계층형(순서가 상관없는)은 로직이 그래도 괜찮음 = 계층형 쿼리
--근데 답변형 게시판 처럼 순서대로 쌓여야하는 로직은 상당히 복잡하다

--제1정규화는 테이블을 하나 만들 때, 각각의 필드는 다른 필드에 영향을 받지 않고 독립적이어야한다
--제2정규화는 엔터티끼리 만나서 행위가 발생하면 row로 쌓이고 서로의 관계가 1:다를 형성하게 되도록 설계해야한다.
--제3정규화 테이블에 값이 있는데(ex.지역) 코드성 테이블을 따로 만들어 놓고 코드를 넣어서 사용하는 것 이것도 1:다
--제4정규화, 역정규화
    
SELECT * FROM SALES_TBL;
SELECT * FROM PRODUCTS_TBL;

    SELECT T1.PRO_ID,(S_PRICE * S_QTY) * T2.PRO_POINT
    FROM SALES_TBL T1, PRODUCTS_TBL T2
    WHERE T1.PRO_ID = T2.PRO_ID 
    AND T2.PRO_ID = 'P00001'
    ;
    
    SELECT *--(S_PRICE * S_QTY) * T2.PRO_POINT
    FROM SALES_TBL T1, PRODUCTS_TBL T2
    WHERE T1.PRO_ID = T2.PRO_ID 
    AND T2.PRO_ID = 'P00001'
    AND T1.C_ID = 'C00001'
    ;
    
    SELECT T1.C_ID,(40000 * 1) * T2.PRO_POINT
    FROM SALES_TBL T1, PRODUCTS_TBL T2
    WHERE T1.PRO_ID = T2.PRO_ID 
    AND T2.PRO_ID = 'P00001'
    AND T1.C_ID = 'C00001'
    AND S_IDX = '1'
    ;
    
  
    
    