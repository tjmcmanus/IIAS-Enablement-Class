------------------------------------------------------------------------------
-- Licensed Materials - Property of IBM
--
-- (C) COPYRIGHT International Business Machines Corp. 2014
-- All Rights Reserved.
--
-- US Government Users Restricted Rights - Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
------------------------------------------------------------------------------

--
-- intermediate-12.sql
--

select  ascending.rnk
      , i1.i_product_name best_performing
      , i2.i_product_name worst_performing
from(select *
     from (select item_sk
                 ,rank() over (order by rank_col asc) rnk
           from (select ss_item_sk item_sk
                       ,avg(ss_net_profit) rank_col 
                 from store_sales ss1
                 where ss_store_sk = 1
                 group by ss_item_sk
                 having avg(ss_net_profit) > 0.9*(select avg(ss_net_profit) rank_col
                                                  from store_sales
                                                  where ss_store_sk = 1
                                                    and ss_hdemo_sk = -99999
                                                  group by ss_store_sk))V1)V11
     where rnk  < 11) ascending,
    (select *
     from (select item_sk
                 ,rank() over (order by rank_col desc) rnk
           from (select ss_item_sk item_sk
                       ,avg(ss_net_profit) rank_col
                 from store_sales ss1
                 where ss_store_sk = 1
                 group by ss_item_sk
                 having avg(ss_net_profit) > 0.9*(select avg(ss_net_profit) rank_col
                                                  from store_sales
                                                  where ss_store_sk = 1
                                                    and ss_hdemo_sk = -99999
                                                  group by ss_store_sk))V2)V21
     where rnk  < 11) descending,
item i1,
item i2
where ascending.rnk = descending.rnk 
  and i1.i_item_sk=ascending.item_sk
  and i2.i_item_sk=descending.item_sk
order by ascending.rnk
 fetch first 100 rows only
;
