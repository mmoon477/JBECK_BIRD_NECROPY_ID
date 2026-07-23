with sq as  (   select distinct vp.trip_code
                    , vp.embark_date
                    , vp.disembark_date
                    , b.*
                    , case when COLLYEAR is not null and collmonth is not null and collmonth is not null  
                        then TO_DATE(COLLYEAR || '-' || LPAD(collmonth, 2, '0') || '-' || LPAD(collmonth, 2, '0'), 'YYYY-MM-DD') 
                            else null end collect_date
                from moonm.JBECK_SB_20260723 b
                    left outer join ols_vessel_plant vp
                        on b.permit = vp.permit
                        and b.cruise = vp.cruise )
select *
from sq
order by cruise, permit, embark_date, collect_date, haul, sample
