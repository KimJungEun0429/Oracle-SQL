--������(������, �ּ�)�� ������(������ �������)�� ������ �׷��� ������ = ������ ����
--�ٵ� �亯�� �Խ��� ó�� ������� �׿����ϴ� ������ ����� �����ϴ�

--��1����ȭ�� ���̺��� �ϳ� ���� ��, ������ �ʵ�� �ٸ� �ʵ忡 ������ ���� �ʰ� �������̾���Ѵ�
--��2����ȭ�� ����Ƽ���� ������ ������ �߻��ϸ� row�� ���̰� ������ ���谡 1:�ٸ� �����ϰ� �ǵ��� �����ؾ��Ѵ�.
--��3����ȭ ���̺� ���� �ִµ�(ex.����) �ڵ强 ���̺��� ���� ����� ���� �ڵ带 �־ ����ϴ� �� �̰͵� 1:��
--��4����ȭ, ������ȭ
    
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
    
  
    
    