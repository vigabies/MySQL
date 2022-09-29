create database prova2;
use prova2;

create table imoveis(
imobiliaria     varchar(30)    not null,
tipo         varchar(30)    not null,
localizacao     varchar(30)    not null,
metros         int            not null,
valor         decimal(8,2)    not null,
visita         varchar(15)    not null,
proprietario varchar(25)    not null
);

select * from imoveis;

insert into imoveis values ('farina','casa','bairro',245,333500,'manha','abelardo');
insert into imoveis values ('lider','casa','bairro',250,334500,'manha','turbucio');
insert into imoveis values ('farina','casa','bairro',245,333500,'tarde','marco');
insert into imoveis values ('lider','casa','bairro',250,334500,'tarde','bidu');
insert into imoveis values ('lider','casa','bairro',250,334400,'tarde','hindenburgo');
insert into imoveis values ('farina','apto','centro',115,123300,'manha','roque');
insert into imoveis values ('lider','apto','centro',112,124300,'manha','sidney');
insert into imoveis values ('farina','apto','centro',115,123600,'tarde','ronan');
insert into imoveis values ('lider','apto','centro',112,124600,'tarde','tomejerry');
insert into imoveis values ('farina','apto','centro',116,123750,'tarde','sandy');
insert into imoveis values ('lider','apto','centro',113,124690,'tarde','junior');
insert into imoveis values ('farina','sitio','rural',3180,550500,'noite','Julibela');
insert into imoveis values ('lider','sitio','rural',4160,450500,'noite','Belagil');
insert into imoveis values ('farina','sitio','rural',5180,381500,'noite','Gilcimara');
insert into imoveis values ('lider','sitio','rural',3160,410500,'noite','Gilciane');

-- 1 -- mostrar o valor medio dos imoveis agrupados por tipo
-- mas somente os imoveis localizados no bairro ou centro
-- e o período de visitas de manha ou tarde
	
    select localizacao,tipo, cast(avg(valor)as decimal (8,2)) 'Valor medio por localizacao'
    from imoveis 
    where (localizacao = 'bairro' or localizacao = 'centro') and
    (visita - 'manha' or visita ='tarde') 
    group by tipo;
    
-- 2 mostrar a soma da metragem dos imóveis(metros) agrupados por
-- imobiliaria e tipo, exceto os sitios, ordenado por imobiliária
	select imobiliaria, tipo, sum(metros) 'soma metros dos imoveis'
    from imoveis
    group by imobiliaria, tipo
    having tipo <> 'sitio'
    order by imobiliaria;

-- 3 -- mostrar os imóveis agrupados  por imobiliaria,tipo,localização e visita
	select imobiliaria, tipo, localizacao, visita
    from imoveis
    group by imobiliaria, tipo, localizacao, visita;

-- 4 -- agrupando por imobiliarias, informar o total de proprietários de cada imobiliária
	select imobiliaria, count(proprietario) 'Total de proprietarios'
    from imoveis
    group by imobiliaria;

-- 5 -- qual o valor medio dos imóveis agrupados por localização
	select localizacao, cast(avg(valor)as decimal (8,2)) 'valor medio por localizacao'
    from imoveis
    group by localizacao;
    
-- 6 -- qual a valor medio da metragem dos imóveis agrupados por horário de visita
	select visita, cast(avg(metros) as decimal (8,2)) 'medio da metregem'
    from imoveis
    group by visita;

-- 7 -- informe a quantidade de imóveis agrupados por tipo
	select  tipo, count(tipo) 'Quantidade de imoveis'
	from imoveis
	group by tipo;

-- 8 -- agrupados por horário de visita, informe a metragem do maior imóvel de cada periodo
-- exceto o periodo da manha e também apenas com imoveis com metragem superior a 240 metros
    select visita, max(metros) 'Maior imovel em cada periodo'
    from imoveis
    where metros >= 240
    group by visita
    having (visita <> 'manha');

-- 9 -- agrupados por imobiliaria qual o menor valor de cada grupo
	select imobiliaria, cast(min(valor)as decimal (8,2)) 'Menor valor de cada imobiliaria'
    from imoveis
    group by imobiliaria;
    
-- 10 elabore um script que utilize pelo menos 1 agrupamento e todas as opções
-- de agregação de valor (utilizar campos diferentes - pelo menos 2), 
-- utilizando ainda where, having e order by

	select imobiliaria,visita, tipo, 
			count(*)'Quantidade de proprietario', 
            sum(valor)'Soma dos valores', 
            max(metros) 'Maximo metros',
            min(metros)'Minimo metros',
            cast(avg(valor) as decimal (8,2)) 'Media valor', 
            cast(avg(metros) as decimal (8,2)) 'Media metros'
            
    from imoveis
    where (valor >= 25000)
    group by imobiliaria, tipo, visita
    having visita <> 'noite' 
    order by imobiliaria, tipo, visita;
    


		
