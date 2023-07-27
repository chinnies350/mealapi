
declare @data nvarchar(max);
declare @data1 nvarchar(max);
DECLARE @WakeUpTime Time;
DECLARE @userId Int;
DECLARE @TotalCalories INT;
DECLARE @fromDate DATE;
DECLARE @toDate DATE;
SET @WakeUpTime ='06:00'
SET @userId =1
SET @TotalCalories=30000
SET @fromDate='2022-11-06'
SET @todate='2022-11-07'
set @data=((SELECT DISTINCT ud.userId,dt.dietTypeName,dt.dietTypeId,b.fromDate,b.toDate,b.branchId,b.branchName,
							ISNULL((SELECT f.foodItemId,f.foodItemName,f.protein,f.carbs,f.fat,(cf.configName) as servingIn,(f.servingIn) as  servingInId,f.calories,(fd.uniqueId) as dietTimeId,(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME)) AS fromTime,
							(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME))AS toTime
							FROM Mstr_FoodItem as f
							INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=f.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName ='BreakFast'))<=@TotalCalories
							FOR JSON PATH),'[]') AS breakFast,
							ISNULL((SELECT f.foodItemId,f.foodItemName,f.protein,f.carbs,f.fat,(cf.configName) as servingIn,(f.servingIn) as  servingInId,f.calories,(fd.uniqueId) as dietTimeId,(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks1')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME)) AS fromTime,
							(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks1')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME))AS toTime
							FROM Mstr_FoodItem as f
							INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=f.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks1') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName ='Snacks1'))<=@TotalCalories
							FOR JSON PATH),'[]') AS Snacks1,
							ISNULL((SELECT f.foodItemId,f.foodItemName,f.protein,f.carbs,f.fat,(cf.configName) as servingIn,(f.servingIn) as  servingInId,f.calories,(fd.uniqueId) as dietTimeId,(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME)) AS fromTime,
							(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME))AS toTime
							FROM Mstr_FoodItem as f
							INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=f.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName ='Lunch'))<=@TotalCalories
							FOR JSON PATH),'[]') AS Lunch,
							ISNULL((SELECT f.foodItemId,f.foodItemName,f.protein,f.carbs,f.fat,(cf.configName) as servingIn,(f.servingIn) as  servingInId,f.calories,(fd.uniqueId) as dietTimeId,(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks2')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME)) AS fromTime,
							(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks2')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME))AS toTime
							FROM Mstr_FoodItem as f
							INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=f.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks2') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName ='Snacks2'))<=@TotalCalories
							FOR JSON PATH),'[]') AS Snacks2,
							ISNULL((SELECT f.foodItemId,f.foodItemName,f.protein,f.carbs,f.fat,(cf.configName) as servingIn,(f.servingIn) as  servingInId,f.calories,(fd.uniqueId) as dietTimeId,(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME)) AS fromTime,
							(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME))AS toTime
							FROM Mstr_FoodItem as f
							INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=f.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName ='Dinner'))<=@TotalCalories
							FOR JSON PATH),'[]') AS Dinner,
							ISNULL((SELECT f.foodItemId,f.foodItemName,f.protein,f.carbs,f.fat,(cf.configName) as servingIn,(f.servingIn) as  servingInId,f.calories,(fd.uniqueId) as dietTimeId,(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks3')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME)) AS fromTime,
							(SELECT CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks3')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME))AS toTime
							FROM Mstr_FoodItem as f
							INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=f.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks3') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName ='Snacks3'))<=@TotalCalories
							FOR JSON PATH),'[]') AS Snacks3
							FROM  Mstr_FoodItem as f
							INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId
							INNER JOIN Mstr_UserDietTime as ud ON ud.dietTimeId=fd.uniqueId
							INNER JOIN Mstr_DietType as dt ON dt.dietTypeId=ud.dietTypeId
							INNER JOIN Tran_Booking as b ON b.userId=@UserId FOR JSON PATH))

set @data1=(SELECT(SELECT DISTINCT up.userId,dt.dietTypeName,dt.dietTypeId,b.fromDate,b.toDate,b.branchId,b.branchName,
							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME), 100))+' - ' +
							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME), 100)) AS breakfastTime,
							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast'))<=@TotalCalories
							 FOR JSON PATH),'[]') AS breakFast,

							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast_Alter') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='BreakFast_Alter'))<=@TotalCalories  
							FOR JSON PATH),'[]') AS breakFast_Alter,

							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks1')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME), 100))+' - ' +
							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks1')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME), 100)) AS snacks1Time,
							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks1') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks1'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS snacks1,

							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks_Alter1') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks_Alter1'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS snacks_Alter1,

							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME), 100))+' - ' +
							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME), 100)) AS lunchTime,
							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS lunch,

							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch_Alter') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Lunch_Alter'))<=@TotalCalories
							FOR JSON PATH),'[]') AS lunch_Alter,

							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks2')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME), 100))+' - ' +
							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks2')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME), 100)) AS snacks2Time,
							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks2') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks2'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS snacks2,

							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks_Alter2')  AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks_Alter2'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS snacks_Alter2,

							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME), 100))+' - ' +
							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME), 100)) as dinnerTime,
							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS dinner,

							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs)  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner_Alter') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Dinner_Alter'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS dinner_Alter,

							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks3')) , CONVERT(VARCHAR(10),@WakeUpTime,108))),108)) AS TIME), 100))+' - ' +
							(SELECT CONVERT(varchar(15),CAST((SELECT CONVERT(VARCHAR(10),(DATEADD(HOUR,(SELECT DISTINCT mc.timeInHrs FROM MstrMealTimeConfig as mc INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=mc.mealTypeId  AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks3')),DATEADD(MINUTE, 30, CONVERT(VARCHAR(10),@WakeUpTime,108)))),108)) AS TIME), 100)) AS snacks3Time,
							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks3') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks3'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS snacks3,

							ISNULL((SELECT uf.foodItemId,uf.foodItemName,ft.protein,ft.carbs,ft.fat,(cf.configName) as servingIn,uf.calories,(fd.uniqueId) as foodDietTimeId
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Mstr_FoodDietTime as fd ON fd.uniqueId=uf.dietTimeId
							INNER JOIN Mstr_Configuration as cf ON cf.configId=uf.servingIn 
							INNER JOIN Mstr_ConfigurationType as ct ON cf.typeId=ct.typeId
							INNER JOIN Mstr_FoodItem as ft ON ft.foodItemId=fd.foodItemId
							INNER JOIN MstrMealTimeConfig as mc ON mc.mealTypeId=fd.uniqueId
							WHERE (DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))<= mc.timeInHrs OR DATEDIFF(HOUR, @WakeUpTime , CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,108))>= mc.timeInHrs) AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks_Alter3') AND (SELECT SUM(f.calories) FROM Mstr_FoodItem as f INNER JOIN Mstr_FoodDietTime as fd ON fd.foodItemId=f.foodItemId AND fd.mealType=(SELECT c.configId FROM Mstr_Configuration as c WHERE c.configName='Snacks_Alter3'))<=@TotalCalories 
							FOR JSON PATH),'[]') AS snacks_Alter3
							FROM Mstr_UserFoodMenu as uf
							INNER JOIN Tran_UserDietPlan as up ON up.userId=@userId
							INNER JOIN Mstr_UserDietTime as ut ON ut.dietTimeId=uf.dietTimeId
							INNER JOIN Mstr_DietType as dt ON dt.dietTypeId=ut.dietTypeId
							INNER JOIN Tran_Booking as b ON b.userId=@UserId
							FOR JSON PATH))
SELECT @data1
BEGIN TRAN

 IF @data IS NOT NULL
  BEGIN
		INSERT INTO Tran_UserDietPlan(branchId,branchName,userId,fromDate,toDate,generatedBy,createdBy,createdDate) SELECT branchId,branchName,@userId,@fromDate,@todate,'ML',@userId,GETDATE()
		FROM OPENJSON (@data)

		WITH(   branchId INT '$.branchId',
				branchName NVARCHAR(100) '$.branchName'
				)
		IF @@ROWCOUNT >0
			BEGIN
				INSERT INTO Mstr_UserDietTime(userId,dietTypeId,[dietTimeId],fromTime,toTime,createdBy,createdDate) SELECT @userId,dietTypeId,BrTable.dietTimeId,BrTable.fromTime,BrTable.toTime,@userId,GETDATE()
						FROM OPENJSON (@data)

						WITH(   dietTypeId INT '$.dietTypeId',
								breakFast NVARCHAR(MAX) AS JSON,
								Snacks1 NVARCHAR(MAX) AS JSON,
								Lunch NVARCHAR(MAX) AS JSON,
								Snacks2 NVARCHAR(MAX) AS JSON,
								Dinner NVARCHAR(MAX) AS JSON,
								Snacks3 NVARCHAR(MAX) AS JSON
								) AS TableA
						CROSS APPLY (SELECT BrTable.dietTimeId,BrTable.fromTime,BrTable.toTime
										FROM OPENJSON(TableA.breakFast)
										 WITH(
											   dietTimeId INT,
											   fromTime Time,
											   toTime Time
										 )BrTable
									UNION ALL
										 SELECT BrTable.dietTimeId,BrTable.fromTime,BrTable.toTime
										 FROM OPENJSON(TableA.Snacks1)
										 WITH(
											   dietTimeId INT,
											   fromTime Time,
											   toTime Time
										 )BrTable
									UNION ALL
									SELECT BrTable.dietTimeId,BrTable.fromTime,BrTable.toTime
										 FROM OPENJSON(TableA.Lunch)
										 WITH(
											   dietTimeId INT,
											   fromTime Time,
											   toTime Time
										 )BrTable
									UNION ALL
										 SELECT BrTable.dietTimeId,BrTable.fromTime,BrTable.toTime
										 FROM OPENJSON(TableA.Snacks2)
										 WITH(
											   dietTimeId INT,
											   fromTime Time,
											   toTime Time
										 )BrTable
									UNION ALL
										 SELECT BrTable.dietTimeId,BrTable.fromTime,BrTable.toTime
										 FROM OPENJSON(TableA.Dinner)
										 WITH(
											   dietTimeId INT,
											   fromTime Time,
											   toTime Time
										 )BrTable
									UNION ALL
										 SELECT BrTable.dietTimeId,BrTable.fromTime,BrTable.toTime
										 FROM OPENJSON(TableA.Snacks3)
										 WITH(
											   dietTimeId INT,
											   fromTime Time,
											   toTime Time
										 )BrTable

						 )AS BrTable
				IF @@ROWCOUNT > 0						
					BEGIN
						INSERT INTO Mstr_UserFoodMenu(dietTimeId,foodItemId,foodItemName,servingIn,calories,alternative,createdBy,createdDate) SELECT BrTable.dietTimeId,BrTable.foodItemId,BrTable.foodItemName,BrTable.servingInId,BrTable.calories,'N',@userId,GETDATE()
								FROM OPENJSON (@data)

								WITH(   
										breakFast NVARCHAR(MAX) AS JSON,
										Snacks1 NVARCHAR(MAX) AS JSON,
										--Lunch NVARCHAR(MAX) AS JSON,
										Snacks2 NVARCHAR(MAX) AS JSON,
										Dinner NVARCHAR(MAX) AS JSON,
										Snacks3 NVARCHAR(MAX) AS JSON
										) AS TableA
								CROSS APPLY (SELECT BrTable.dietTimeId,BrTable.foodItemId,BrTable.foodItemName,BrTable.servingInId,BrTable.calories
												FROM OPENJSON(TableA.breakFast)
													WITH(
														dietTimeId INT,
															foodItemId INT,
															foodItemName NVARCHAR(100),
															servingInId INT,
															calories INT
													)BrTable
											UNION ALL
													SELECT BrTable.dietTimeId,BrTable.foodItemId,BrTable.foodItemName,BrTable.servingInId,BrTable.calories
													FROM OPENJSON(TableA.Snacks1)
													WITH(
														dietTimeId INT,
															foodItemId INT,
															foodItemName NVARCHAR(100),
															servingInId INT,
															calories INT
													)BrTable
											--UNION ALL
											--SELECT BrTable.dietTimeId,BrTable.foodItemId,BrTable.foodItemName,BrTable.servingInId,BrTable.calories
											--		FROM OPENJSON(TableA.Lunch)
											--		WITH(
											--			dietTimeId INT,
											--				foodItemId INT,
											--				foodItemName NVARCHAR(100),
											--				servingInId INT,
											--				calories INT
											--		)BrTable
											UNION ALL
													SELECT BrTable.dietTimeId,BrTable.foodItemId,BrTable.foodItemName,BrTable.servingInId,BrTable.calories
													FROM OPENJSON(TableA.Snacks2)
													WITH(
														dietTimeId INT,
															foodItemId INT,
															foodItemName NVARCHAR(100),
															servingInId INT,
															calories INT
													)BrTable
											UNION ALL
													SELECT BrTable.dietTimeId,BrTable.foodItemId,BrTable.foodItemName,BrTable.servingInId,BrTable.calories
													FROM OPENJSON(TableA.Dinner)
													WITH(
														dietTimeId INT,
															foodItemId INT,
															foodItemName NVARCHAR(100),
															servingInId INT,
															calories INT
													)BrTable
											UNION ALL
													SELECT BrTable.dietTimeId,BrTable.foodItemId,BrTable.foodItemName,BrTable.servingInId,BrTable.calories
													FROM OPENJSON(TableA.Snacks3)
													WITH(
														dietTimeId INT,
															foodItemId INT,
															foodItemName NVARCHAR(100),
															servingInId INT,
															calories INT
													)BrTable

									)AS BrTable
								IF @@ROWCOUNT > 0
									BEGIN
										COMMIT
										SELECT @data1,1
									END
								ELSE
									BEGIN
										ROLLBACK
										SELECT  'Data Not Added',0
									END																	
					END
				ELSE
					BEGIN
						ROLLBACK
						SELECT  'Data Not Added in UserDietTime',0
					END	
			END
		ELSE
		   BEGIN
				ROLLBACK
				SELECT  'Data Not Added in userDietplan',0
			END



			
			
END
IF @@TRANCOUNT>0
	COMMIT	



