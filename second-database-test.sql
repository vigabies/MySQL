create database provatipo1;
use provatipo1;

create table transporte(
empresa		varchar(30)	not null,
modelo		varchar(30)	not null,
rota		varchar(30)	not null,
capacidade	int			not null,
precofrete	decimal(8,2)not null,
periodo		varchar(15) not null,
motorista	varchar(25)	not null
);

select * from transporte;

insert into transporte values ('prata','onibus','estadual',45,3500,'manha','abelardo');
insert into transporte values ('reunidas','onibus','estadual',50,4500,'manha','turbucio');
insert into transporte values ('prata','onibus','estadual',45,3500,'tarde','marco');
insert into transporte values ('reunidas','onibus','estadual',50,4500,'tarde','bidu');
insert into transporte values ('reunidas','onibus','estadual',50,4400,'tarde','hindenburgo');
insert into transporte values ('prata','van','municipal',15,3300,'manha','roque');
insert into transporte values ('reunidas','van','municipal',12,4300,'manha','sidney');
insert into transporte values ('prata','van','municipal',15,3600,'tarde','ronan');
insert into transporte values ('reunidas','van','municipal',12,4600,'tarde','tomejerry');
insert into transporte values ('prata','van','municipal',16,3750,'tarde','sandy');
insert into transporte values ('reunidas','van','municipal',13,4690,'tarde','junior');
insert into transporte values ('prata','aviao','nacional',180,33500,'noite','Julibela');
insert into transporte values ('reunidas','aviao','nacional',160,43500,'noite','Belagil');
insert into transporte values ('prata','aviao','nacional',180,31500,'noite','Gilcimara');
insert into transporte values ('reunidas','aviao','nacional',160,41500,'noite','Gilciane');

-- 1 -- mostrar o valor medio(precofrete) do frete agrupado por modelos
-- mas somente os veículos que fazem a rota municipal ou estadual
-- no período da manha ou tarde
	select modelo, periodo, rota, cast(avg(precofrete) as decimal (8,2)) 'Media do preco'
    from transporte
    where (rota = 'municipal' or rota = 'estadual') and (periodo = 'manha' or periodo = 'tarde')
    group by modelo;
  
-- 2 mostrar a soma dos passareiros transportados(capacidade) agrupados por
-- empresa e modelo, exceto os aviões, ordenado por empresa
	select empresa, modelo, cast(sum(capacidade) as decimal (8,2)) 'Soma dos passageiros'
    from transporte
    group by empresa, modelo
    having (modelo <> 'aviao')
    order by empresa;

-- 3 -- informe a quantidade veiculos agrupados por modelo
	select modelo, count(modelo) 'Quantidade de veiculo'
    from transporte
    group by modelo;

-- 4 -- agrupados por periodo, informe a maior capacidade de transporte de cada periodo
-- exceto o periodo da manha e também apenas com veículos com capacidade superior a 60
-- passageiros
	select periodo, max(capacidade) 'maior capacidade'
    from transporte
    where capacidade > 60 
    group by periodo
    having periodo <> 'manha' ;

-- 5 -- ebalore um script que utilize pelo menos 1 agrupamento e todas as opções
-- de agregação de valor (utilizar campos diferentes - pelo menos 2), 
-- utilizando ainda where, having e order by
	select capacidade modelo, motorista, precofrete,
			count(motorista) 'Quantidade de motorista',
            sum(precofrete) 'Soma frete',
            max(capacidade) 'Maior capacidade',
            min(capacidade) 'menor capacidade',
            cast(avg(precofrete) as decimal (8,2)) 'Media preco',
            cast(avg(capacidade) as decimal (8,2)) 'Media capacidade'
            
	from transporte
    where capacidade >= 10
    group by empresa, modelo
    having modelo <> 'onibus'
    order by empresa, modelo;

    


