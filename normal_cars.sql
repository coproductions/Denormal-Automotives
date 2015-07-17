CREATE TABLE car_makes(
id serial primary key,
  make_code character varying(125) NOT NULL,
  make_title character varying(125) NOT NULL
);


CREATE TABLE car_models(
id serial primary key,
model_code character varying(125) NOT NULL,
model_title character varying(125) NOT NULL,
year integer NOT NULL,
make_code character varying(125) not null,
car_makes_id integer
);

INSERT INTO car_makes (make_code,make_title) SELECT distinct make_code,make_title From denormal_car_models;

INSERT INTO car_models (model_code,model_title,year,make_code) SELECT distinct model_code,model_title,year,make_code FROM old_car_models ORDER BY model_code,year asc

UPDATE car_models SET car_makes_id = (SELECT id FROM car_makes WHERE car_makes.make_code = car_models.make_code);

ALTER TABLE car_models DROP COLUMN make_code ;

ALTER TABLE car_models ADD CONSTRAINT car_makes_id_fk FOREIGN KEY (car_makes_id)
REFERENCES car_makes(id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;

--NOT NULL references car_makes(id) MATCH SIMPLE
     --\i  ON UPDATE CASCADE ON DELETE CASCADE;,