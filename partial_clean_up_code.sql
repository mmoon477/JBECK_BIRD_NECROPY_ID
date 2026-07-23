with sq as  (   select distinct st.name debriefer
                    , case when COLLYEAR is not null and collmonth is not null and collmonth is not null  
                        then TO_DATE(COLLYEAR || '-' || LPAD(collmonth, 2, '0') || '-' || LPAD(collmonth, 2, '0'), 'YYYY-MM-DD') 
                            else null end collect_date
                    , vp.trip_code
                    , vp.embark_date
                    , vp.disembark_date
                    , b.cruise
                    , b.permit
                    , b.VESSELME
                    , b.HAUL
                    , b.SAMPLE
                    , b.SPECIMEN
                    , b.OBSRSPCODE
                    , b.VERIFYSPCODE
                    , b.COLLMONTH
                    , b.COLLDAY
                    , b.COLLYEAR
                    , b.OBSRSPECIES
                    , b.OBSERVERNOTES
                    , b.MWVCRC#
                    , b.VERIFYSPECIES
                from moonm.JBECK_SB_20260723 b
                    left outer join ols_vessel_plant vp
                        on b.permit = vp.permit
                        and b.cruise = vp.cruise
                    left outer join OLS_DEBRIEFING_SCHEDULE ds
                        on b.cruise = ds.cruise 
                    left outer join ols_lov_staff st
                        on ds.debriefer_STAFF_ID = st.STAFF_ID)
select *
from sq
order by cruise, permit, embark_date, collect_date, haul, sample
