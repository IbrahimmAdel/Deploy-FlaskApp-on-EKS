USE BucketList;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addWish`(

    IN p_title varchar(45),

	IN p_description varchar(1000),

	IN p_user_id bigint

)

BEGIN

	insert into tbl_wish(

		wish_title,

		wish_description,

		wish_user_id,

		wish_date

	)

	values

	(

		p_title,

		p_description,

		p_user_id,

		NOW()

	);

END$$

DELIMITER ;

;
