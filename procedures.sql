/*

Mediante una vista obtener los empleados que en el día de la fecha han realizado
algún intento de ingreso fallido a un área sin contar con un ingreso exitoso posterior
para la misma. Incluir el área donde intento ingresar en las columnas que devuelve la
vista.

*/

CREATE VIEW EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA AS 
select p.id_persona from `IngresaAbandona` p

	where p.fecha >=  CURDATE()
	and p.autorizado = false

and not exists (
			select i.id_persona 
			from  `IngresaAbandona` i 
			where i.id_persona = p.id_persona
			and p.fecha > i.fecha
			and p.n_area = i.n_area
			and autorizado = true  
		 )


/*

Obtener el nombre, apellido y número identificatorio de los empleados No
Profesionales que pueden ingresar a todas las áreas del nivel de seguridad asignado.

*/

CREATE PROCEDURE obtenerEmpleadosProfesionalesConAccesoATodasLasAreasDeSuNivel()

BEGIN

(SELECT count(distinct t.n_area) cant_area, t.id_persona id_persona
		FROM `TieneAccesoA` t
		group by (t.id_persona)
		having count(*) = (select count(*) from `Area` a, `PersonalNoProfesional` p where p.id_persona = t.id_persona and a.nivel = p.nivel));

END


/*

Obtener los datos personales de los empleados que en los últimos 30 días cuentan con
una cantidad de intentos fallidos mayor a 5 o con al menos un intento de ingreso en
un área cuyo nivel de seguridad sea superior al que tienen asignado.

*/

DROP PROCEDURE IF EXISTS obtenerIngresosSospechosos();


CREATE PROCEDURE obtenerIngresosSospechosos()

BEGIN

(select id_persona from (select i.id_persona, count(*) c
FROM  `IngresaAbandona` i
where fecha > DATE_SUB(NOW(), INTERVAL 1 MONTH)
and i.autorizado = false
group by (i.id_persona )
having (c >= 5)) x)

union

(select i.id_persona from `IngresaAbandona` i, `Area` a
where i.n_area = a.n_area
and a.nivel > ( select max(b.nivel) from `Area` b, `TieneAccesoA` t
				where t.n_area = b.n_area
				and t.id_persona = i.id_persona
			  )
);
END

DELIMITER ;

/*

Implementar un control en la base de datos que impida que a un empleado se le
asigne un área si no está capacitado para el nivel de seguridad de ese área.

*/


