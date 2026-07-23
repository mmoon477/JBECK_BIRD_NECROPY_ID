with sq as  (   select distinct vp.trip_code
                    , vp.embark_date
                    , vp.disembark_date
                    , b.cruise
                    , b.permit
                    , b.haul
                    , b.sample
                    , b.specimen
                    , b.collmonth
                    , b.collday
                    , b.COLLYEAR
                    , case when COLLYEAR is not null and collmonth is not null and collmonth is not null  
                        then TO_DATE(COLLYEAR || '-' || LPAD(collmonth, 2, '0') || '-' || LPAD(collmonth, 2, '0'), 'YYYY-MM-DD') 
                            else null end collect_date
                    , verifyspcode
                    , obsrspcode
                    , OBSERVERNOTES
                from moonm.JBECK_SB_20260723 b
                    left outer join ols_vessel_plant vp
                        on b.permit = vp.permit
                        and b.cruise = vp.cruise )
select *
from sq
