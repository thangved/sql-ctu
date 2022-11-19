--------------------------------------------------------------------------------

-------------------------------| CHUONG 5 |-------------------------------------

--------------------------------------------------------------------------------



-- 1.1 -------------------------------------------------------------------------

select b.tenct, b.diachict
from chuthau a, congtrinh b
where
    a.msct = b.msct
    and a.tenthau = 'Hong Xuan Truong';

-- 1.2 -------------------------------------------------------------------------

select a.tenthau, a.diachithau
from
    chuthau a,
    congtrinh b,
    thietke c,
    kientrucsu d
where
    a.msct = b.msct
    and b.sttct = c.sttct
    and c.mskts = d.mskts
    and b.tinhthanh = 'TPCT'
    and d.hotenkts = 'Le Kim Dung';

-- 1.3 -------------------------------------------------------------------------

select a.hotenkts, a.noitn
from
    kientrucsu a,
    thietke b,
    congtrinh c
where
    a.mskts = b.mskts
    and b.sttct = c.sttct
    and c.tenct = 'Khach san Quoc Te'
    and c.tinhthanh = 'TPCT';

-- 1.4 -------------------------------------------------------------------------

select a.hotencn, a.ngaysinh
from
    congnhan a,
    thamgia b,
    congtrinh c,
    chuthau d
where
    a.mscn = b.mscn
    and b.sttct = c.sttct
    and c.msct = d.msct
    and d.tenthau = 'Le Van Son'
    and a.chuyenmon in ('han', 'dien');

-- 1.5 -------------------------------------------------------------------------

select a.hotencn
from
    congnhan a,
    thamgia b,
    congtrinh c
where
    a.mscn = b.mscn
    and b.sttct = c.sttct
    and c.tenct = 'Khach san Quoc Te'
    and c.tinhthanh = 'TPCT'
    and b.ngaytg between 'DEC-15-94' and 'DEC-31-94';

-- 1.6 -------------------------------------------------------------------------

select c.tenct, c.diachict
from
    congnhan a,
    thamgia b,
    congtrinh c
where
    a.mscn = b.mscn
    and b.sttct = c.sttct
    and a.hotencn = 'Nguyen Hong Van'
    and 'DEC-18-94' between b.ngaytg
    and b.ngaytg + b.songay;

-- 1.7 -------------------------------------------------------------------------

select
    distinct a.hotenkts,
    a.ngaysinh
from
    kientrucsu a,
    thietke b,
    congtrinh c
where
    a.mskts = b.mskts
    and b.sttct = c.sttct
    and a.noitn = 'TP HCM'
    and c.kinhphi > 400;

-- 1.8 -------------------------------------------------------------------------

select a.hotencn, a.chuyenmon
from
    congnhan a,
    thamgia b,
    congtrinh c,
    thietke d,
    kientrucsu e
where
    a.mscn = b.mscn
    and b.sttct = c.sttct
    and c.sttct = d.sttct
    and d.mskts = e.mskts
    and e.hotenkts = 'Nguyen Anh Thu';

-- 1.9 -------------------------------------------------------------------------

select a.tenchu
from
    chunhan a,
    chuthau b,
    congtrinh c,
    thietke d,
    kientrucsu e
where
    a.msch = c.msch
    and b.msct = c.msct
    and c.sttct = d.sttct
    and d.mskts = e.mskts
    and e.hotenkts = 'Nguyen Anh Thu'
    and b.tenthau = 'Hoang Cong Binh';

-- 1.10 ------------------------------------------------------------------------

select a.tenct
from
    congtrinh a,
    thietke b,
    kientrucsu c
where
    a.sttct = b.sttct
    and b.mskts = c.mskts
    and c.noitn = 'TP HCM'
    and b.thulao > 20;

--------------------------------------------------------------------------------

-- 2.1 -------------------------------------------------------------------------

select hotenkts
from (
        select
            a.mskts,
            a.hotenkts
        from
            kientrucsu a,
            thietke b,
            congtrinh c,
            chuthau d
        where
            a.mskts = b.mskts
            and c.sttct = b.sttct
            and d.msct = c.msct
            and d.tenthau = 'Hoang Cong Binh'
        intersect
        select
            a.mskts,
            a.hotenkts
        from
            kientrucsu a,
            thietke b,
            congtrinh c,
            chuthau d
        where
            a.mskts = b.mskts
            and c.sttct = b.sttct
            and d.msct = c.msct
            and d.tenthau = 'Le Van Son'
    );

-- 2.2 -------------------------------------------------------------------------

select a.tenct
from congtrinh a
where a.kinhphi = (
        select max(kinhphi)
        from congtrinh
    );

-- 2.3 -------------------------------------------------------------------------

select hotencn
from (
        select
            a.mscn,
            a.hotencn
        from
            congnhan a,
            thamgia b,
            congtrinh c
        where
            b.mscn = a.mscn
            and c.sttct = b.sttct
            and c.tinhthanh = 'TPCT'
        minus
        select
            a.mscn,
            a.hotencn
        from
            congnhan a,
            thamgia b,
            congtrinh c
        where
            b.mscn = a.mscn
            and c.sttct = b.sttct
            and c.tinhthanh = 'Vinh Long'
    );

-- 2.4 -------------------------------------------------------------------------

select distinct a.tenthau
from chuthau a, congtrinh b
where
    b.msct = a.msct
    and b.kinhphi > (
        select max(b.kinhphi)
        from
            chuthau a,
            congtrinh b
        where
            a.msct = b.msct
            and a.tenthau = 'Hoang Cong Binh'
    );

-- 2.5 -------------------------------------------------------------------------

select distinct a.hotenkts
from kientrucsu a, thietke b
where
    b.mskts = a.mskts
    and b.thulao < (
        select avg(thulao)
        from thietke
    );

-- 2.6 -------------------------------------------------------------------------

select a.tenthau, a.diachithau
from chuthau a, congtrinh b
where
    b.msct = a.msct
    and b.kinhphi = (
        select min(kinhphi)
        from congtrinh
    );

-- 2.7 -------------------------------------------------------------------------

select a.hotencn, a.chuyenmon
from
    congnhan a,
    thamgia b,
    congtrinh c,
    thietke d,
    kientrucsu e
where
    b.mscn = a.mscn
    and c.sttct = b.sttct
    and d.sttct = c.sttct
    and e.mskts = d.mskts
    and extract(
        year
        from
            current_date
    ) - extract(
        year
        from
            a.ngaysinh
    ) < 40
    and e.hotenkts = 'Le Thanh Tung';

-- 2.8 -------------------------------------------------------------------------

select
    distinct a.tenthau,
    b.tenthau
from
    chuthau a,
    chuthau b,
    congtrinh c,
    congtrinh d
where
    c.msct = a.msct
    and d.msct = b.msct
    and c.tinhthanh = d.tinhthanh
    and a.msct < b.msct
    and substr(
        a.tenthau,
        1,
        instr(a.tenthau, ' ')
    ) = substr(
        b.tenthau,
        1,
        instr(b.tenthau, ' ')
    )
order by a.tenthau;

-- 2.9 -------------------------------------------------------------------------

select
    distinct a.hotencn,
    b.hotencn
from
    congnhan a,
    congnhan b,
    thamgia c,
    thamgia d
where
    c.mscn = a.mscn
    and d.mscn = b.mscn
    and c.sttct = d.sttct
    and a.mscn < b.mscn
group by
    a.mscn,
    b.mscn,
    a.hotencn,
    b.hotencn
having count(c.sttct) >= 2;

-- 2.10 ------------------------------------------------------------------------

select
    distinct a.mscn,
    a.hotencn
from
    congnhan a,
    thamgia b,
    congtrinh c
where
    b.mscn = a.mscn
    and c.sttct = b.sttct
    and c.kinhphi > (
        select avg(kinhphi)
        from congtrinh
    )
order by a.mscn;

--------------------------------------------------------------------------------
-- 3.1 -------------------------------------------------------------------------

select a.msct, a.tenthau, sum(b.kinhphi) tongkp
from chuthau a, congtrinh b
where a.msct = b.msct
group by a.msct, a.tenthau
order by a.msct;

-- 3.2 -------------------------------------------------------------------------

select a.mskts, a.hotenkts, sum(b.thulao) sotien
from kientrucsu a, thietke b
where a.mskts = b.mskts
group by a.mskts, a.hotenkts
having sum(b.thulao) > 25
order by a.mskts;

-- 3.3 -------------------------------------------------------------------------

create view temp3 as
select a.mskts
from kientrucsu a, thietke b
where a.mskts = b.mskts
group by a.mskts
having sum(b.thulao) > 50;

select count(mskts) sokts
from temp3;

drop view temp3;

-- 3.4 -------------------------------------------------------------------------

select a.sttct, a.tenct, count(b.mscn) socn
from congtrinh a, thamgia b
where b.sttct = a.sttct
group by a.sttct, a.tenct
order by a.sttct;

-- 3.5 -------------------------------------------------------------------------

create view temp5 as
select a.tenct, a.diachict, count(b.mscn) socn
from congtrinh a, thamgia b
where b.sttct = a.sttct
group by a.tenct, a.diachict;

select tenct, diachict
from temp5
where socn = (
  select max(socn)
  from temp5
);

drop view temp5;

-- 3.6 -------------------------------------------------------------------------

select tinhthanh, to_char(avg(kinhphi), '9999.99') kptb
from congtrinh
group by tinhthanh
having avg(kinhphi) > 1000;

-- 3.7 -------------------------------------------------------------------------

select a.mscn, a.hotencn, sum(b.songay)
from congnhan a, thamgia b
where a.mscn = b.mscn
group by a.mscn, a.hotencn
having sum(b.songay) > (
  select sum(d.songay)
  from congnhan c, thamgia d
  where d.mscn = c.mscn
  and c.hotencn = 'Nguyen Hong Van'
);


-- 3.8 -------------------------------------------------------------------------

select b.msct, b.tenthau, a.tinhthanh, count(a.sttct) soct
from congtrinh a, chuthau b
where a.msct = b.msct
      and b.tenthau like '% Van %'
group by a.tinhthanh, b.msct, b.tenthau
order by b.msct;

-- 3.9 -------------------------------------------------------------------------

select a.mscn, a.hotencn
from congnhan a, thamgia b
where a.mscn = b.mscn
group by a.mscn, a.hotencn
having count(b.sttct) > 3;

-- 3.10 ------------------------------------------------------------------------

select a.hotencn, b.hotencn
from congnhan a, congnhan b, thamgia c, thamgia d
where a.mscn < b.mscn
      and a.mscn = c.mscn
      and b.mscn = d.mscn
      and c.sttct = d.sttct
group by a.mscn, b.mscn, a.hotencn, b.hotencn
having count(c.sttct) >= 2;
      
--------------------------------------------------------------------------------

-- 4.1 -------------------------------------------------------------------------

select distinct a.hotenkts, a.noitn
from kientrucsu a, thietke b, congtrinh c
where a.hotenkts like 'Le %'
      and a.mskts = b.mskts
      and b.sttct = c.sttct
      and c.tinhthanh = some (
        select d.tinhthanh
        from congtrinh d, chuthau e
        where d.msct = e.msct
              and e.tenthau = 'Hoang Cong Binh'
      );
      
-- 4.2 -------------------------------------------------------------------------

select a.sttct, a.tenct, a.kinhphi
from congtrinh a, thietke b, kientrucsu c
where c.ngaysinh = (
  select min(ngaysinh)
  from kientrucsu
)
      and a.sttct = b.sttct
      and b.mskts = c.mskts;
      
-- 4.3 -------------------------------------------------------------------------

select a.mskts, a.hotenkts
from kientrucsu a, thietke b, congtrinh c, chunhan d
where a.mskts = b.mskts
      and b.sttct = c.sttct
      and c.msch = d.msch
      and d.diachichu = '101 Hai Ba Trung';

-- 4.4 -------------------------------------------------------------------------

select distinct a.mskts, a.hotenkts
from kientrucsu a, thietke b, congtrinh c
where extract(year from current_date) - extract(year from a.ngaysinh) < 40
      and a.mskts = b.mskts
      and b.sttct = c.sttct
      and 3 <= (
        select count(d.sttct)
        from congtrinh d
        where c.msct = d.msct
      );
      
-- 4.5 -------------------------------------------------------------------------

select distinct a.mscn, a.hotencn
from congnhan a, thamgia b, congtrinh c, thamgia d, congtrinh e
where a.mscn = b.mscn
      and b.sttct = c.sttct
      and a.mscn = d.mscn
      and d.sttct = e.sttct
      and c.tinhthanh <> e.tinhthanh;

-- 4.6 -------------------------------------------------------------------------

create view temp6 as
select a.tinhthanh, count(b.mscn) socn
from congtrinh a, thamgia b
where a.sttct = b.sttct
group by a.tinhthanh;

select tinhthanh
from temp6
where socn = (
  select max(socn)
  from temp6
);

drop view temp6;

-- 4.7 -------------------------------------------------------------------------

select a.tinhthanh
from congtrinh a, thietke b, kientrucsu c
where a.sttct = b.sttct
      and b.mskts = c.mskts
      and c.hotenkts = 'Le Kim Dung'
      and b.thulao = (
        select min(d.thulao)
        from thietke d, kientrucsu e
        where d.mskts = e.mskts
              and e.mskts = c.mskts
      );

-- 4.8 -------------------------------------------------------------------------

select distinct a.hotenkts, e.hotencn
from kientrucsu a, thietke b, congtrinh c, thamgia d, congnhan e
where a.mskts = b.mskts
      and b.sttct = c.sttct
      and c.sttct = d.sttct
      and d.mscn = e.mscn
      and a.ngaysinh < e.ngaysinh;
      
-- 4.9 -------------------------------------------------------------------------

select a.mscn, a.hotencn, count(b.sttct) soct
from congnhan a, thamgia b
where a.mscn = b.mscn
      and extract(month from a.ngaysinh) = 5
group by a.mscn, a.hotencn
order by a.mscn;

-- 4.10 ------------------------------------------------------------------------

select a.sttct, a.tenct, count(b.mscn) socn, sum(case when c.phai = 'Nam' then 1 else 0 end) socnnam, sum(case when c.phai = 'Nu' then 1 else 0 end) socnnu
from congtrinh a, thamgia b, congnhan c
where a.sttct = b.sttct
      and b.mscn = c.mscn
group by a.sttct, a.tenct
having count(b.mscn) > 2
order by a.sttct;

-- 5.1 -------------------------------------------------------------------------

select a.mscn, a.hotencn, c.tenct
from congnhan a left outer join thamgia b on a.mscn = b.mscn
    left outer join congtrinh c on b.sttct = c.sttct;

-- 5.2 -------------------------------------------------------------------------

select a.mscn, a.hotencn
from congnhan a left outer join thamgia b on a.mscn = b.mscn
where b.sttct is null;

-- 5.3 -------------------------------------------------------------------------

select a.sttct, a.tenct, count(b.mscn) socn
from congtrinh a left outer join thamgia b on a.sttct = b.sttct
group by a.sttct, a.tenct;

-- 5.4 -------------------------------------------------------------------------

select a.mscn, a.hotencn, count(b.sttct) soct
from congnhan a left outer join thamgia b on a.mscn = b.mscn
group by a.mscn, a.hotencn;

-- 5.5 -------------------------------------------------------------------------

select a.mskts, a.hotenkts, a.noitn
from kientrucsu a left outer join thietke b on a.mskts = b.mskts
where b.sttct is null;

-- 5.6 -------------------------------------------------------------------------

select a.sttct, a.tenct
from congtrinh a left outer join thietke b on a.sttct = b.sttct
where b.mskts is null
    and a.kinhphi > 3500;

-- 5.7 -------------------------------------------------------------------------

select a.msch, a.tenchu, b.tenct
from chunhan a, congtrinh b left outer join thamgia c on b.sttct = c.sttct
where a.msch = b.msch
    and c.mscn is null;

-- 5.8--------------------------------------------------------------------------

select a.mscn, a.hotencn
from congnhan a left outer join thamgia b on a.mscn = b.mscn
where b.sttct is null
    and a.ngaysinh = (
        select max(c.ngaysinh)
        from congnhan c left outer join thamgia d on c.mscn = d.mscn
        where d.sttct is null
    );

-- 5.9 -------------------------------------------------------------------------

select distinct a.msct, a.tenthau
from chuthau a, congtrinh b
where a.msct = b.msct
    and (
        select count(d.sttct)
        from chuthau c, congtrinh d
        where c.msct = d.msct
            and d.tinhthanh <> 'TPCT'
            and c.msct = a.msct
    ) = 0
    and b.tinhthanh = 'TPCT';

-- 5.10 ------------------------------------------------------------------------

select a.msch, a.tenchu
from chunhan a, congtrinh b left outer join thamgia c on b.sttct = c.sttct
    left outer join congnhan d on c.mscn = d.mscn
where a.msch = b.msch
    and a.tenchu like 'Nguyen %'
    and a.diachichu like '% Hai Ba Trung'
group by a.msch, a.tenchu
having sum(
    case
        when d.phai = 'Nu' then 1
        else 0
    end
) = 0;

