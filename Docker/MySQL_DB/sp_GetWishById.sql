USE BucketList;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetWishById`(

IN p_wish_id bigint,

In p_user_id bigint

)

BEGIN

select * from tbl_wish where wish_id = p_wish_id and wish_user_id = p_user_id;

END
