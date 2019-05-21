#Stored Procedure

#RETRIEVE PRODUCT INFO
USE warehouse;
DROP PROCEDURE IF EXISTS warehouse.SP_productInfo;
DELIMITER $$
CREATE PROCEDURE warehouse.SP_productInfo(IN productId_p INT)
BEGIN
	SELECT 	A.productId,
			A.productName,
			C.productTypeName,
            A.unitCostprice,
            A.unitSellprice,
			COUNT(DISTINCT B.orderid) timesOrdered,
            COUNT(DISTINCT D.shipmentId) timesOrdered
	FROM warehouse.inventory A
    LEFT JOIN warehouse.orderDetails B
    ON A.productid=B.productid
    LEFT JOIN warehouse.producttype C
    ON A.productTypeCode=C.productTypeCode
    LEFT JOIN warehouse.storeshipments D
    ON A.productid = D.productid
    WHERE A.productid = productId_p;
END$$
DELIMITER ;

CALL warehouse.SP_productInfo(2);


#RETRIEVE Store Product Report given Store ID
DROP PROCEDURE IF EXISTS warehouse.SP_StoreReport;
DELIMITER $$
CREATE PROCEDURE warehouse.SP_StoreReport(IN storeId_p INT)
BEGIN
	SELECT 	A.storeId,
			A.storeLocation,
			B.productId,
            C.productName,
            SUM(productQty) QtyLastShipped
	FROM warehouse.stores A
    LEFT JOIN warehouse.storeshipments B
    ON A.storeId=B.storeId
    LEFT JOIN warehouse.inventory C
    ON B.productId = C.productId
    WHERE A.storeId = storeId_p
    GROUP BY A.storeId,
			 A.storeLocation,
             B.productId,
             C.productName;
END$$
DELIMITER ;

CALL warehouse.SP_StoreReport(3);
