--------------------------------------------------------------------------------

-------------------------------| CHUONG 4 |-------------------------------------

--------------------------------------------------------------------------------


select * from nhanvien;

select hoten, phai from nhanvien;

select luong from nhanvien;

--------------------------------------------------------------------------------

select * from nhanvien order by maphong, luong desc;

select
    hoten,
    luong,
    phucap, (nvl(luong, 0) + nvl(phucap, 0)) * 12 thunhap
from nhanvien
order by thunhap desc;

--------------------------------------------------------------------------------

select * from nhanvien where hoten = 'Le Quynh Nhu';

select hoten, congviec
from nhanvien
where
    phai = 'Nam'
    and maphong in (30, 40);

select hoten, luong, phucap from nhanvien where luong = 2 * phucap;

select manv, hoten
from nhanvien
where
    phai = 'Nam'
    and congviec = 'Thu ky';

select hoten from nhanvien where maphong in (10, 30, 50);

select hoten
from nhanvien
where
    maphong not in (10, 30, 50)
    and phai <> 'Nu';

select hoten, luong from nhanvien where luong between 3500 and 4500;

select manv, hoten
from nhanvien
where hoten like '% Van %'
order by ngaysinh;

select * from nhanvien where hoten like '%ao' and phai = 'Nu';

select * from nhanvien where phucap is null;

select hoten, luong
from nhanvien
where
    phai = 'Nu'
    and extract(
        year
        from
            current_date
    ) - extract(
        year
        from ngaysinh
    ) = 25;

--------------------------------------------------------------------------------

select count(manv) sonv from nhanvien;

select
    max(luong),
    min(luong),
    to_char(avg(luong), '9999.99')
from nhanvien;

select sum(luong) from nhanvien where maphong = 40;

select
    count(manv) sonv,
    to_char(avg(luong), '9999.99') luongtb
from nhanvien
where
    phai = 'Nu'
    and congviec = 'Thu ky';

select
    nvl(min(phucap), 0) phucaptn
from nhanvien
where congviec = 'Quan ly';


--------------------------------------------------------------------------------

select maphong, to_char(avg(luong), '9999.99') luongtb
from nhanvien
group by maphong
order by maphong;

select
    maphong,
    count(manv),
    count(
        case
            when phai = 'Nam' then manv
        end
    ) nvnam,
    count(
        case
            when phai = 'Nu' then manv
        end
    ) nvnu
from nhanvien
group by maphong
order by maphong;

--------------------------------------------------------------------------------

select
    maphong,
    to_char(avg(luong), '9999.99') luongtb
from nhanvien
group by maphong
having avg(luong) > 2700
order by maphong;

select
    mann,
    count(
        case
            when trinhdo = 'C' then manv
        end
    ) sonv
from tdonn
group by mann
having
    count(
        case
            when trinhdo = 'C' then manv
        end
    ) > 8;

--------------------------------------------------------------------------------

select
    distinct a.maphong,
    b.tenphong
from nhanvien a, phong b
where
    a.maphong = b.maphong
    and hoten = 'Tran Thi Thuy Lan';

select a.hoten, b.tenphong
from nhanvien a, phong b
where a.maphong = b.maphong
order by tenphong;

select
    a.manv,
    a.hoten,
    b.trinhdo
from
    nhanvien a,
    tdonn b,
    ngoaingu c
where
    a.manv = b.manv
    and b.mann = c.mann
    and c.tennn = 'Anh van';

select manv, hoten, luong
from nhanvien, phong
where
    nhanvien.manv = phong.truongphong
    and tenphong = 'Phong To Chuc';

--------------------------------------------------------------------------------

select
    a.maphong,
    a.tenphong,
    count(b.manv) sonv
from phong a
    left join nhanvien b on a.maphong = b.maphong
group by
    a.maphong,
    a.tenphong
order by a.maphong;

select a.manv, a.hoten
from nhanvien a
    left join tdonn b on a.manv = b.manv
where b.mann is null
order by a.manv;

--------------------------------------------------------------------------------

select manv, hoten
from nhanvien
where luong = (
        select max(luong)
        from nhanvien
    );

select manv, hoten
from nhanvien
where luong > (
        select max(luong)
        from nhanvien
        where maphong = 20
    );

select manv, hoten
from nhanvien
where manv = some (
        select truongphong
        from phong
    );

select manv, hoten, phucap
from nhanvien
where manv in (
        select truongphong
        from phong
    );

select hoten
from nhanvien a
where exists (
        select *
        from nhanvien b
        where
            a.manv <> b.manv
            and a.congviec = b.congviec
            and b.luong = b.luong
    );

--------------------------------------------------------------------------------

select a.manv, a.hoten
from
    nhanvien a,
    ngoaingu b,
    tdonn c
where
    a.phai = 'Nu'
    and a.manv = c.manv
    and b.mann = c.mann
    and b.tennn = 'Anh van'
union
select a.manv, a.hoten
from
    nhanvien a,
    ngoaingu b,
    tdonn c
where
    a.phai = 'Nu'
    and a.manv = c.manv
    and b.mann = c.mann
    and b.tennn = 'Phap van';
