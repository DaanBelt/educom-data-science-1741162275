--Drop constraint queries:
--mhl_detaildefs
ALTER TABLE mhl_detaildefs DROP FOREIGN KEY group_ID
ALTER TABLE mhl_detaildefs DROP FOREIGN KEY propertytype_ID

--mhl_properties
ALTER TABLE mhl_properties DROP FOREIGN KEY idx_propertytype_ID
ALTER TABLE mhl_properties DROP FOREIGN KEY properties_supplier_ID

--mhl_yn_properties
ALTER TABLE mhl_yn_properties DROP FOREIGN KEY yn_propertytype_ID
ALTER TABLE mhl_yn_properties DROP FOREIGN KEY yn_supplier_ID

--mhl_suppliers
ALTER TABLE mhl_suppliers DROP FOREIGN KEY company
ALTER TABLE mhl_suppliers DROP FOREIGN KEY membertype
ALTER TABLE mhl_suppliers DROP FOREIGN KEY city_ID
ALTER TABLE mhl_suppliers DROP FOREIGN KEY p_city_ID
ALTER TABLE mhl_suppliers DROP FOREIGN KEY suppliers_postcode
ALTER TABLE mhl_suppliers DROP FOREIGN KEY suppliers_p_postcode

--mhl_hitcount
ALTER TABLE mhl_hitcount DROP FOREIGN KEY hitcount_supplier_ID

--mhl_contacts
ALTER TABLE mhl_contacts DROP FOREIGN KEY contacts_supplier_ID
ALTER TABLE mhl_contacts DROP FOREIGN KEY department_supplier_ID

--mhl_suppliers_mhl_rubriek_view
ALTER TABLE mhl_suppliers_mhl_rubriek_view DROP FOREIGN KEY rubriek_view_supplier_ID
ALTER TABLE mhl_suppliers_mhl_rubriek_view DROP FOREIGN KEY rubrieken_rubriek_view_ID

--mhl_cities 
ALTER TABLE mhl_cities DROP FOREIGN KEY commune_ID

--mhl_communes
ALTER TABLE mhl_communes DROP FOREIGN KEY district_ID

--mhl_communes
ALTER TABLE mhl_districts DROP FOREIGN KEY country_ID




--Add constraint queries:
--mhl_detaildefs:
ALTER TABLE mhl_detaildefs 
ADD CONSTRAINT group_ID
FOREIGN KEY (group_ID) REFERENCES mhl_detailgroups(id)

ALTER TABLE mhl_detaildefs 
ADD CONSTRAINT propertytype_ID
FOREIGN KEY (propertytype_ID) REFERENCES mhl_propertytypes(id)

--mhl_properties
ALTER TABLE mhl_properties
ADD CONSTRAINT propertytype_ID
FOREIGN KEY (propertytype_ID) REFERENCES mhl_propertytypes(id)

ALTER TABLE mhl_properties
ADD CONSTRAINT supplier_ID
FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id)

--mhl_yn_properties
ALTER TABLE mhl_yn_properties
ADD CONSTRAINT yn_propertytype_ID
FOREIGN KEY (propertytype_ID) REFERENCES mhl_propertytypes(id)

ALTER TABLE mhl_yn_properties
ADD CONSTRAINT yn_supplier_ID
FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id)

--mhl_suppliers
ALTER TABLE mhl_suppliers
ADD CONSTRAINT company
FOREIGN KEY (company) REFERENCES mhl_companies(id)

ALTER TABLE mhl_suppliers
ADD CONSTRAINT membertype
FOREIGN KEY (membertype) REFERENCES mhl_membertypes(id)

ALTER TABLE mhl_suppliers
ADD CONSTRAINT city_ID
FOREIGN KEY (city_ID) REFERENCES mhl_cities(id)

ALTER TABLE mhl_suppliers
ADD CONSTRAINT p_city_ID
FOREIGN KEY (p_city_ID) REFERENCES mhl_cities(id)

ALTER TABLE mhl_suppliers
ADD CONSTRAINT suppliers_postcode
FOREIGN KEY (postcode) REFERENCES pc_lat_long(pc6)

ALTER TABLE mhl_suppliers
ADD CONSTRAINT suppliers_p_postcode
FOREIGN KEY (p_postcode) REFERENCES pc_lat_long(pc6)

--mhl_hitcount
ALTER TABLE mhl_hitcount
ADD CONSTRAINT hitcount_supplier_ID
FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id)

--mhl_contacts
ALTER TABLE mhl_contacts
ADD CONSTRAINT contacts_supplier_ID
FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id)

ALTER TABLE mhl_contacts
ADD CONSTRAINT department_supplier_ID
FOREIGN KEY (department) REFERENCES mhl_departments(id)

--mhl_suppliers_mhl_rubriek_view
ALTER TABLE mhl_suppliers_mhl_rubriek_view
ADD CONSTRAINT rubrieken_rubriek_view_ID
FOREIGN KEY (mhl_rubriek_view_ID) REFERENCES mhl_rubrieken(id)

ALTER TABLE mhl_suppliers_mhl_rubriek_view
ADD CONSTRAINT rubriek_view_supplier_ID
FOREIGN KEY (mhl_suppliers_ID) REFERENCES mhl_suppliers(id)

--mhl_cities
ALTER TABLE mhl_cities
ADD CONSTRAINT commune_ID
FOREIGN KEY (commune_ID) REFERENCES mhl_commune(id)

--mhl_communes
ALTER TABLE mhl_communes
ADD CONSTRAINT district_ID
FOREIGN KEY (district_ID) REFERENCES mhl_districts(id)

--mhl_districts
ALTER TABLE mhl_districts
ADD CONSTRAINT country_ID
FOREIGN KEY (country_ID) REFERENCES mhl_countries(id)




--Transformaties:
--mhl_detaildefs:
--create dummy for propertytype_ID 0 in mhl_propertytypes
INSERT INTO mhl_propertytypes (id, name) 
VALUES (470, 'Dummy id')

--Set ids to corresponding dummy:
UPDATE mhl_detaildefs 
SET propertytype_ID = 470 
WHERE propertytype_ID = 0;


--mhl_properties
--create dummy for supplier_ID 0 in mhl_suppliers
INSERT INTO mhl_suppliers (id, name) 
VALUES (9620, 'Dummy supplier')

--Set ids to corresponding dummy:
UPDATE mhl_properties
SET propertytype_ID = 470
WHERE propertytype_ID = 0

--Set ids to corresponding dummy:
UPDATE mhl_properties
SET supplier_ID = 9620
WHERE supplier_ID NOT IN (SELECT id FROM mhl_suppliers)


--mhl_yn_properties
UPDATE mhl_yn_properties
SET propertytype_ID = 470
WHERE propertytype_ID = 0

UPDATE mhl_yn_properties
SET supplier_ID = 9620
WHERE supplier_ID NOT IN (SELECT id FROM mhl_suppliers)


--mhl_suppliers:
--Create dummy for company 0 in mhl_companies:
INSERT INTO mhl_companies (id, name)
VALUES(211, 'Dummy company')

--Create dummy for membertype in mhl_membertypes
INSERT INTO mhl_membertypes (id, name)
VALUES(11, 'Dummy membertype')

--Create dummy for city_ID in mhl_cities
INSERT INTO mhl_cities (id, name)
VALUES (5889, 'Dummy city')

--Create dummy for postcode and p_postcode in pc_lat_long
INSERT INTO pc_lat_long (id, pc6)
VALUES (8333, '000000')

--Update company 0 to 211 in mhl_suppliers
UPDATE mhl_suppliers
SET company = 211
WHERE company = 0

--Update membertypes 0 to 11 in mhl_suppliers
UPDATE mhl_suppliers
SET membertypes = 11
WHERE membertypes NOT IN (SELECT id FROM mhl_membertypes)

--Update city_ids 0 to 5889 in mhl_suppliers
UPDATE mhl_suppliers
SET city_ID = 5889
WHERE city_ID NOT IN (SELECT id FROM mhl_cities)

--Update p_city_ids 0 to 5889 in mhl_suppliers
UPDATE mhl_suppliers
SET p_city_ID = 5889
WHERE p_city_ID NOT IN (SELECT id FROM mhl_cities)

--Update postcode and p_postcode to 8333 in mhl_suppliers
UPDATE mhl_suppliers
SET postcode = '000000'
WHERE postcode NOT IN (SELECT pc6 FROM pc_lat_long)

UPDATE mhl_suppliers
SET p_postcode = '000000'
WHERE p_postcode NOT IN (SELECT pc6 FROM pc_lat_long)


--mhl_hitcount
-- Created new primary key ID
ALTER TABLE mhl_hitcount
ADD COLUMN id INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY(id)

--Set ids to corresponding dummy:
UPDATE mhl_hitcount
SET supplier_ID = 9620
WHERE supplier_ID NOT IN (SELECT id FROM mhl_suppliers)


--mhl_contacts
--Create dummy for company 0 in mhl_companies:
INSERT INTO mhl_departments (id, name)
VALUES(9, 'Dummy department')

--Set ids to corresponding supplier dummy:
UPDATE mhl_contacts
SET supplier_ID = 9620
WHERE supplier_ID NOT IN (SELECT id FROM mhl_suppliers)

--Set ids to corresponding department dummy:
UPDATE mhl_contacts
SET supplier_ID = 9620
WHERE supplier_ID NOT IN (SELECT id FROM mhl_suppliers)


--mhl_suppliers_mhl_rubriek_view
INSERT INTO mhl_rubrieken (id, name) 
VALUES (1579, 'Dummy rubriek')

--Set ids to corresponding rubriek dummy:
UPDATE mhl_suppliers_mhl_rubriek_view
SET mhl_rubriek_view_ID = 1579
WHERE mhl_rubriek_view_ID NOT IN (SELECT id FROM mhl_rubrieken)

--Set ids to corresponding supplier dummy:
UPDATE mhl_suppliers_mhl_rubriek_view
SET mhl_suppliers_ID = 9620
WHERE mhl_suppliers_ID NOT IN (SELECT id FROM mhl_suppliers)


--mhl_cities
--Create dummy for commune_ID in mhl_communes:
INSERT INTO mhl_communes (id, name) 
VALUES (789, 'Dummy commune')

--Set ids to corresponding commune dummy:
UPDATE mhl_cities
SET commune_ID = 789
WHERE commune_ID NOT IN (SELECT id FROM mhl_communes)


--mhl_communes
--Create dummy for district_ID in mhl_districts:
INSERT INTO mhl_districts (id, name) 
VALUES (30, 'Dummy district')

--Set ids to corresponding commune dummy:
UPDATE mhl_communes
SET district_ID = 30
WHERE district_ID NOT IN (SELECT id FROM mhl_districts)


--mhl_districts
--Create dummy for district_ID in mhl_districts:
INSERT INTO mhl_countries (id, name) 
VALUES (251, 'Dummy country')

--Set ids to corresponding commune dummy:
UPDATE mhl_districts
SET country_ID = 251
WHERE country_ID NOT IN (SELECT id FROM mhl_countries)