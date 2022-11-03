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
