Cleaning data in sql Queries

select * from nashvillehousing


-- Populate Property Address data

select *
from nashvillehousing
order by ParcelID;

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ifnull(a.PropertyAddress, b.PropertyAddress) 
from nashvillehousing a
join nashvillehousing b
	on a.ParcelID = b.ParcelID
	and a.UniqueID <> b.UniqueID
where a.propertyaddress is null;


-- Change Y and N to Yes and No in "Sold as Vacant" field

select distinct(SoldAsVacant), count(SoldAsVacant)
from nashvillehousing
group by SoldAsVacant
order by 2;


select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end
from nashvillehousing;


update nashvillehousing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end;


-- Remove Duplicates


create table tmp_nashvillehousing like nashvillehousing;

alter table tmp_nashvillehousing add unique(propertyaddress, saledate, legalreference);

insert ignore into tmp_nashvillehousing select * from nashvillehousing order by UniqueID;

rename table nashvillehousing to backup_nashvillehousing, tmp_nashvillehousing to nashvillehousing;


-- Delete Unused Columns

select *
from nashvillehousing

alter table nashvillehousing
drop column OwnerAddress;

alter table nashvillehousing
drop column TaxDistrict;








