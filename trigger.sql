-- trigger ; gatilho
-- trigger é uma memoria do pc, sempre que alterar tem que dropar a tabela

create database shoptime;
use shoptime;
-- --------------------------------------------------------------------------------------------------------------
create table pedidos  (
	dtcompra datetime, 
	produto varchar(40),
	qtdade int,
	valor decimal(7,2),
	vendedor varchar(40),
	comissao decimal(6,2)
);

insert into pedidos values ('2022/11/03', 'notebook dell', 1, 3570 , 'Anpolino', 275);
insert into pedidos values ('2022/11/03', 'hd ssd 1tb',2, 2550, 'Gilcimara', 150);
-- new insert's
insert into pedidos values ('2022/09/28', 'mouse com led', 2, 395, 'Louis', 80);
insert into pedidos values ('2022/09/28', 'teclado com led', 2, 642, 'Hazz', 90);
-- --------------------------------------------------------------------------------------------------------------
-- 2 produtos a ser separado para entrega
-- expedição
create table entrega (
	produto varchar (40),
	qtdade int
);
-- --------------------------------------------------------------------------------------------------------------
-- 3 quem vendeu hoje
-- vendas por dia/vendedor
create table vendadiaria(
	dtcompra datetime,
	vendedor varchar (40)
);
-- --------------------------------------------------------------------------------------------------------------
-- 4 comissao diaria dos vendedores
create table comissaovendedor(
	dtcompra datetime,
	vendedor varchar (40),
	comissao decimal(5,2)
);
-- --------------------------------------------------------------------------------------------------------------
-- 5 valores vendidos por dia
create table valoresvendas(
	dtcompra datetime,
	valor decimal(7,2)
);
-- --------------------------------------------------------------------------------------------------------------
-- 6 vendas por produtos
create table vendaprodutos(
	produto varchar (40),
	valor decimal(7,2)
);
-- --------------------------------------------------------------------------------------------------------------
-- 7 caixa
create table caixadia(
	valor decimal(8,2)
);

insert into caixadia values (0);
-- --------------------------------------------------------------------------------------------------------------
-- DELIMITER
-- Ao utilizar o DELIMITER, você diz ao mysql, onde seu script tem início, e onde encerra. 
-- O uso do Delimiter deve ser acompanhado de algum símbolo que seja reconhecido pelo mysql. 
-- O mais comum é utilizar dois cifrões $

delimiter $$
create trigger Tgr_ItensPedidos_Insert after insert
on pedidos
for each row
-- o begin serve tipo como uma chave
begin
	insert into entrega set produto = new.produto, qtdade = new.qtdade;
	insert into comissaovendedor set vendedor = new.vendedor, comissao = new.comissao;
	insert into vendadiaria set dtcompra = new.dtcompra, valor = new.valor;
	update caixadia set valor = valor + new.valor;
	insert into comissaovendedor2 set vendedor = new.vendedor, comissao = new.comissao * 0.1;
END $$
-- --------------------------------------------------------------------------------------------------------------

-- 2 expedição
insert into entrega values ('notebook dell', 1);
insert into entrega values ('hd ssd 1tb', 2);
	-- new insert's
insert into entrega values ('mouse com led', 2);
insert into entrega values ('teclado com led', 2);
-- --------------------------------------------------------------------------------------------------------------
-- 3 vendadiaria
insert into vendadiaria values ('2022/11/03', 'Anpolino');
insert into vendadiaria values ('2022/11/03', 'Gilcimara');
	-- new insert's
insert into vendadiaria values ('2022/09/28', 'Louis');
insert into vendadiaria values ('2022/09/28', 'Hazz');
-- --------------------------------------------------------------------------------------------------------------
-- 4 comissao vendedor
insert into comissaovendedor values('2022/11/03', 'Anpolino', 275);
insert into comissaovendedor values('2022/11/03', 'Gilcimara', 150);
	-- new insert's
insert into comissaovendedor values('2022/09/28', 'Louis', 80);
insert into comissaovendedor values('2022/09/28', 'Hazz', 90);
-- --------------------------------------------------------------------------------------------------------------
-- 5 valor das vendas
insert into valoresvendas values('2022/11/03', 3570);
insert into valoresvendas values('2022/11/03', 550);
	-- new insert's
insert into valoresvendas values('2022/09/28', 395);
insert into valoresvendas values('2022/09/28', 642);
-- --------------------------------------------------------------------------------------------------------------
-- 6 produtos vendidos
insert into vendaprodutos values('notebook dell', 3570);
insert into vendaprodutos values('hd ssd 1 tb', 550);
	-- new insert's
insert into vendaprodutos values('mouse com led', 395);
insert into vendaprodutos values('teclado com led', 642);
-- --------------------------------------------------------------------------------------------------------------
-- 7 atualiza saldo caixa
update caixadia set valor = valor + 3750;
update caixadia set valor = valor + 550;
	-- new update
update caixadia set valor = valor + 395;
update caixadia set valor = valor + 642;

-- --------------------------------------------------------------------------------------------------------------
	select * from pedidos ;
	select * from entrega;
	select * from vendadiaria;
	select * from comissaovendedor;
	select * from valoresvendas;
	select * from vendaprodutos;
	select * from caixadia;