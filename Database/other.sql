CREATE SCHEMA IF NOT EXISTS "public";

CREATE  TABLE etat ( 
	id                   varchar(20) DEFAULT custom_seq('ETAT'::character varying, 'seq_etat'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	CONSTRAINT etat_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE groupe ( 
	id                   varchar(20) DEFAULT custom_seq('GRP'::character varying, 'seq_groupe'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	CONSTRAINT groupe_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE site ( 
	id                   varchar(20) DEFAULT custom_seq('SIT'::character varying, 'seq_site'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	CONSTRAINT site_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE typemvttstock ( 
	id                   varchar(20) DEFAULT custom_seq('TYPSTK'::character varying, 'seq_typemvttstock'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	CONSTRAINT typemvttstock_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE catproduit ( 
	id                   varchar(20) DEFAULT custom_seq('CATPROD'::character varying, 'seq_catproduit'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	idtypemvtstock       varchar(20)    ,
	CONSTRAINT catproduit_pkey PRIMARY KEY ( id ),
	CONSTRAINT catproduit_idtypemvtstock_fkey FOREIGN KEY ( idtypemvtstock ) REFERENCES typemvttstock( id )   
 );

CREATE  TABLE entreprise ( 
	id                   varchar(20) DEFAULT custom_seq('ENT'::character varying, 'seq_entreprise'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	email                varchar(100)  NOT NULL  ,
	idtypemvtstock       varchar(20)    ,
	idgroupe             varchar(20)    ,
	idsite               varchar(20)  NOT NULL  ,
	CONSTRAINT entreprise_pkey PRIMARY KEY ( id ),
	CONSTRAINT entreprise_idsite_fkey FOREIGN KEY ( idsite ) REFERENCES site( id )   ,
	CONSTRAINT entreprise_idgroupe_fkey FOREIGN KEY ( idgroupe ) REFERENCES groupe( id )   ,
	CONSTRAINT entreprise_idtypemvtstock_fkey FOREIGN KEY ( idtypemvtstock ) REFERENCES typemvttstock( id )   
 );

CREATE  TABLE produit ( 
	id                   varchar(20) DEFAULT custom_seq('PROD'::character varying, 'seq_produit'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	prix                 decimal(15,2)  NOT NULL  ,
	idtypemvtstock       varchar(20)  NOT NULL  ,
	idcatproduit         varchar(20)  NOT NULL  ,
	CONSTRAINT produit_pkey PRIMARY KEY ( id ),
	CONSTRAINT produit_idcatproduit_fkey FOREIGN KEY ( idcatproduit ) REFERENCES catproduit( id )   ,
	CONSTRAINT produit_idtypemvtstock_fkey FOREIGN KEY ( idtypemvtstock ) REFERENCES typemvttstock( id )   
 );

CREATE  TABLE "admin" ( 
	idadmin              varchar(20) DEFAULT custom_seq('ADMIN'::character varying, 'seq_admin'::character varying, 6) NOT NULL  ,
	nom                  varchar(250)  NOT NULL  ,
	logins               varchar(250)  NOT NULL  ,
	mdp                  varchar(250)  NOT NULL  ,
	identreprise         varchar(20)  NOT NULL  ,
	CONSTRAINT admin_pkey PRIMARY KEY ( idadmin ),
	CONSTRAINT admin_entreprise_fkey FOREIGN KEY ( identreprise ) REFERENCES entreprise( id )   
 );

CREATE  TABLE depot ( 
	id                   varchar(20) DEFAULT custom_seq('DEP'::character varying, 'seq_depot'::character varying, 6) NOT NULL  ,
	nom                  varchar(50)  NOT NULL  ,
	identreprise         varchar(20)  NOT NULL  ,
	idsite               varchar(20)  NOT NULL  ,
	CONSTRAINT depot_pkey PRIMARY KEY ( id ),
	CONSTRAINT depot_idsite_fkey FOREIGN KEY ( idsite ) REFERENCES site( id )   ,
	CONSTRAINT depot_identreprise_fkey FOREIGN KEY ( identreprise ) REFERENCES entreprise( id )   
 );

CREATE  TABLE dmdachat ( 
	id                   varchar(20) DEFAULT custom_seq('DMDA'::character varying, 'seq_dmdachat'::character varying, 6) NOT NULL  ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idetat               varchar(20)  NOT NULL  ,
	idfournisseur        varchar(20)  NOT NULL  ,
	idclient             varchar(20)  NOT NULL  ,
	CONSTRAINT dmdachat_pkey PRIMARY KEY ( id ),
	CONSTRAINT dmdachat_idclient_fkey FOREIGN KEY ( idclient ) REFERENCES entreprise( id )   ,
	CONSTRAINT dmdachat_idfournisseur_fkey FOREIGN KEY ( idfournisseur ) REFERENCES entreprise( id )   ,
	CONSTRAINT dmdachat_idetat_fkey FOREIGN KEY ( idetat ) REFERENCES etat( id )   
 );

CREATE  TABLE dmdachatdetail ( 
	id                   varchar(20) DEFAULT custom_seq('DMADET'::character varying, 'seq_dmdachatdetail'::character varying, 6) NOT NULL  ,
	qte                  integer  NOT NULL  ,
	iddmdachat           varchar(20)  NOT NULL  ,
	idproduit            varchar(20)  NOT NULL  ,
	CONSTRAINT dmdachatdetail_pkey PRIMARY KEY ( id ),
	CONSTRAINT dmdachatdetail_idproduit_fkey FOREIGN KEY ( idproduit ) REFERENCES produit( id )   ,
	CONSTRAINT dmdachatdetail_iddmdachat_fkey FOREIGN KEY ( iddmdachat ) REFERENCES dmdachat( id )   
 );

CREATE  TABLE mvtstock ( 
	id                   varchar(20) DEFAULT custom_seq('MVSTK'::character varying, 'seq_mvtstock'::character varying, 6) NOT NULL  ,
	entre                decimal(15,2) DEFAULT 0   ,
	sortie               decimal(15,2) DEFAULT 0   ,
	idorigine            varchar(20)    ,
	prix                 decimal(15,2)  NOT NULL  ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idproduit            varchar(20)  NOT NULL  ,
	iddepot              varchar(20)  NOT NULL  ,
	identreprise         varchar(20)  NOT NULL  ,
	CONSTRAINT mvtstock_pkey PRIMARY KEY ( id ),
	CONSTRAINT mvtstock_identreprise_fkey FOREIGN KEY ( identreprise ) REFERENCES entreprise( id )   ,
	CONSTRAINT mvtstock_iddepot_fkey FOREIGN KEY ( iddepot ) REFERENCES depot( id )   ,
	CONSTRAINT mvtstock_idproduit_fkey FOREIGN KEY ( idproduit ) REFERENCES produit( id )   
 );

CREATE  TABLE proforma ( 
	id                   varchar(20) DEFAULT custom_seq('PROF'::character varying, 'seq_proforma'::character varying, 6) NOT NULL  ,
	validite             integer DEFAULT 3   ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idetat               varchar(20)  NOT NULL  ,
	iddmdachat           varchar(20)    ,
	CONSTRAINT proforma_pkey PRIMARY KEY ( id ),
	CONSTRAINT proforma_iddmdachat_fkey FOREIGN KEY ( iddmdachat ) REFERENCES dmdachat( id )   ,
	CONSTRAINT proforma_idetat_fkey FOREIGN KEY ( idetat ) REFERENCES etat( id )   
 );

CREATE  TABLE proformadetail ( 
	id                   varchar(20) DEFAULT custom_seq('PROFDET'::character varying, 'seq_proformadetail'::character varying, 6) NOT NULL  ,
	prix                 varchar(50)  NOT NULL  ,
	idproforma           varchar(20)  NOT NULL  ,
	idproduit            varchar(20)  NOT NULL  ,
	CONSTRAINT proformadetail_pkey PRIMARY KEY ( id ),
	CONSTRAINT proformadetail_idproduit_fkey FOREIGN KEY ( idproduit ) REFERENCES produit( id )   ,
	CONSTRAINT proformadetail_idproforma_fkey FOREIGN KEY ( idproforma ) REFERENCES proforma( id )   
 );

CREATE  TABLE bc ( 
	id                   varchar(20) DEFAULT custom_seq('BC'::character varying, 'seq_bc'::character varying, 6) NOT NULL  ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idetat               varchar(20)  NOT NULL  ,
	idclient             varchar(20)  NOT NULL  ,
	idfournisseur        varchar(20)  NOT NULL  ,
	idproforma           varchar(20)    ,
	CONSTRAINT bc_pkey PRIMARY KEY ( id ),
	CONSTRAINT bc_idproforma_fkey FOREIGN KEY ( idproforma ) REFERENCES proforma( id )   ,
	CONSTRAINT bc_idfournisseur_fkey FOREIGN KEY ( idfournisseur ) REFERENCES entreprise( id )   ,
	CONSTRAINT bc_idclient_fkey FOREIGN KEY ( idclient ) REFERENCES entreprise( id )   ,
	CONSTRAINT bc_idetat_fkey FOREIGN KEY ( idetat ) REFERENCES etat( id )   
 );

CREATE  TABLE bcdetail ( 
	id                   varchar(20) DEFAULT custom_seq('BCDET'::character varying, 'seq_bcdetail'::character varying, 6) NOT NULL  ,
	qte                  integer  NOT NULL  ,
	idbc                 varchar(20)  NOT NULL  ,
	idproduit            varchar(20)  NOT NULL  ,
	CONSTRAINT bcdetail_pkey PRIMARY KEY ( id ),
	CONSTRAINT bcdetail_idproduit_fkey FOREIGN KEY ( idproduit ) REFERENCES produit( id )   ,
	CONSTRAINT bcdetail_idbc_fkey FOREIGN KEY ( idbc ) REFERENCES bc( id )   
 );

CREATE  TABLE bonlivraison ( 
	id                   varchar(20) DEFAULT custom_seq('BL'::character varying, 'seq_bonlivraison'::character varying, 6) NOT NULL  ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idbc                 varchar(20)  NOT NULL  ,
	CONSTRAINT bonlivraison_pkey PRIMARY KEY ( id ),
	CONSTRAINT bonlivraison_idbc_fkey FOREIGN KEY ( idbc ) REFERENCES bc( id )   
 );

CREATE  TABLE bonlivraisondetail ( 
	id                   varchar(20) DEFAULT custom_seq('BLDET'::character varying, 'seq_bonlivraisondetail'::character varying, 6) NOT NULL  ,
	qte                  integer  NOT NULL  ,
	idproduit            varchar(20)  NOT NULL  ,
	idbl                 varchar(20)  NOT NULL  ,
	CONSTRAINT bonlivraisondetail_pkey PRIMARY KEY ( id ),
	CONSTRAINT bonlivraisondetail_idbl_fkey FOREIGN KEY ( idbl ) REFERENCES bonlivraison( id )   ,
	CONSTRAINT bonlivraisondetail_idproduit_fkey FOREIGN KEY ( idproduit ) REFERENCES produit( id )   
 );

CREATE  TABLE bonreception ( 
	id                   varchar(20) DEFAULT custom_seq('BR'::character varying, 'seq_bonreception'::character varying, 6) NOT NULL  ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idbl                 varchar(20)    ,
	idbc                 varchar(20)  NOT NULL  ,
	CONSTRAINT bonreception_pkey PRIMARY KEY ( id ),
	CONSTRAINT bonreception_idbc_fkey FOREIGN KEY ( idbc ) REFERENCES bc( id )   ,
	CONSTRAINT bonreception_idbl_fkey FOREIGN KEY ( idbl ) REFERENCES bonlivraison( id )   
 );

CREATE  TABLE bonreceptiondetail ( 
	id                   varchar(20) DEFAULT custom_seq('BRDET'::character varying, 'seq_bonreceptiondetail'::character varying, 6) NOT NULL  ,
	qte                  integer  NOT NULL  ,
	idbonreception       varchar(20)  NOT NULL  ,
	idproduit            varchar(20)  NOT NULL  ,
	CONSTRAINT bonreceptiondetail_pkey PRIMARY KEY ( id ),
	CONSTRAINT bonreceptiondetail_idproduit_fkey FOREIGN KEY ( idproduit ) REFERENCES produit( id )   ,
	CONSTRAINT bonreceptiondetail_idbonreception_fkey FOREIGN KEY ( idbonreception ) REFERENCES bonreception( id )   
 );

CREATE  TABLE facture ( 
	id                   varchar(20) DEFAULT custom_seq('FACT'::character varying, 'seq_facture'::character varying, 6) NOT NULL  ,
	montantreste         decimal(15,2) DEFAULT 0   ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idclient             varchar(20)  NOT NULL  ,
	idfournisseur        varchar(20)  NOT NULL  ,
	idetat               varchar(20)  NOT NULL  ,
	idbr                 varchar(20)  NOT NULL  ,
	CONSTRAINT facture_pkey PRIMARY KEY ( id ),
	CONSTRAINT facture_idbr_fkey FOREIGN KEY ( idbr ) REFERENCES bonreception( id )   ,
	CONSTRAINT facture_idetat_fkey FOREIGN KEY ( idetat ) REFERENCES etat( id )   ,
	CONSTRAINT facture_idfournisseur_fkey FOREIGN KEY ( idfournisseur ) REFERENCES entreprise( id )   ,
	CONSTRAINT facture_idclient_fkey FOREIGN KEY ( idclient ) REFERENCES entreprise( id )   
 );

CREATE  TABLE facturedetail ( 
	id                   varchar(20) DEFAULT custom_seq('FACTDET'::character varying, 'seq_facturedetail'::character varying, 6) NOT NULL  ,
	qte                  integer  NOT NULL  ,
	idfacture            varchar(20)  NOT NULL  ,
	idproduit            varchar(20)  NOT NULL  ,
	CONSTRAINT facturedetail_pkey PRIMARY KEY ( id ),
	CONSTRAINT facturedetail_idproduit_fkey FOREIGN KEY ( idproduit ) REFERENCES produit( id )   ,
	CONSTRAINT facturedetail_idfacture_fkey FOREIGN KEY ( idfacture ) REFERENCES facture( id )   
 );

CREATE  TABLE payement ( 
	id                   varchar(20) DEFAULT custom_seq('PAY'::character varying, 'seq_payement'::character varying, 6) NOT NULL  ,
	montant              decimal(15,2)  NOT NULL  ,
	daty                 timestamp DEFAULT CURRENT_TIMESTAMP   ,
	idfacture            varchar(20)  NOT NULL  ,
	CONSTRAINT payement_pkey PRIMARY KEY ( id ),
	CONSTRAINT payement_idfacture_fkey FOREIGN KEY ( idfacture ) REFERENCES facture( id )   
 );

INSERT INTO etat( id, nom ) VALUES ( 'ETAT000001', 'Cree');
INSERT INTO etat( id, nom ) VALUES ( 'ETAT000002', 'En attente');
INSERT INTO etat( id, nom ) VALUES ( 'ETAT000003', 'Valide');
INSERT INTO etat( id, nom ) VALUES ( 'ETAT000004', 'Annule');
INSERT INTO etat( id, nom ) VALUES ( 'ETAT000005', 'Proforma envoyer');
INSERT INTO etat( id, nom ) VALUES ( 'ETAT000006', 'Livrer');
INSERT INTO groupe( id, nom ) VALUES ( 'GRP000001', 'Groupe Industries');
INSERT INTO groupe( id, nom ) VALUES ( 'GRP000002', 'Groupe Commerce');
INSERT INTO groupe( id, nom ) VALUES ( 'GRP000003', 'Groupe Services');
INSERT INTO site( id, nom ) VALUES ( 'SIT000001', 'Antananarivo');
INSERT INTO site( id, nom ) VALUES ( 'SIT000002', 'Toamasina');
INSERT INTO site( id, nom ) VALUES ( 'SIT000003', 'Antsirabe');
INSERT INTO site( id, nom ) VALUES ( 'SIT000004', 'Fianarantsoa');
INSERT INTO site( id, nom ) VALUES ( 'SIT000005', 'Mahajanga');
INSERT INTO typemvttstock( id, nom ) VALUES ( 'TYPSTK000001', 'FIFO');
INSERT INTO typemvttstock( id, nom ) VALUES ( 'TYPSTK000002', 'LIFO');
INSERT INTO typemvttstock( id, nom ) VALUES ( 'TYPSTK000003', 'CMUP');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000001', 'electronique Grand Public', 'TYPSTK000001');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000002', 'equipement Informatique', 'TYPSTK000002');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000003', 'Mobilier de Bureau', 'TYPSTK000003');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000004', 'Fournitures de Bureau', 'TYPSTK000001');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000005', 'Materiaux de Construction', 'TYPSTK000002');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000006', 'Outillage Professionnel', 'TYPSTK000003');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000007', 'Textiles et Vˆtements', 'TYPSTK000001');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000008', 'Produits Chimiques et Peintures', 'TYPSTK000002');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000009', 'equipement de Protection', 'TYPSTK000003');
INSERT INTO catproduit( id, nom, idtypemvtstock ) VALUES ( 'CATPROD000010', 'Emballage et Conditionnement', 'TYPSTK000001');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000001', 'Industries Malagasy', 'contact@industries.mg', 'TYPSTK000001', 'GRP000001', 'SIT000001');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000002', 'Textiles Tana', 'textile@tana.mg', 'TYPSTK000001', 'GRP000001', 'SIT000001');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000003', 'Acierie Mada', 'acier@mada.mg', 'TYPSTK000002', 'GRP000001', 'SIT000002');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000004', 'Plastiques Toliara', 'plastique@toliara.mg', 'TYPSTK000003', 'GRP000001', 'SIT000003');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000005', 'Madagascar Commerce', 'info@madacommerce.mg', 'TYPSTK000002', 'GRP000002', 'SIT000001');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000006', 'Super Marche Tana', 'supermarche@tana.mg', 'TYPSTK000001', 'GRP000002', 'SIT000001');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000007', 'Import Export Mada', 'import@export.mg', 'TYPSTK000003', 'GRP000002', 'SIT000004');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000008', 'Services Pro Mada', 'service@spmada.mg', 'TYPSTK000003', 'GRP000003', 'SIT000001');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000009', 'Logistique Malagasy', 'logistique@malagasy.mg', 'TYPSTK000002', 'GRP000003', 'SIT000005');
INSERT INTO entreprise( id, nom, email, idtypemvtstock, idgroupe, idsite ) VALUES ( 'ENT000010', 'Transport Antsirabe', 'transport@antsirabe.mg', 'TYPSTK000001', 'GRP000003', 'SIT000003');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000001', 'Ordinateur Portable Pro 15"', 1500000, 'TYPSTK000001', 'CATPROD000001');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000002', 'Tablette Android 10"', 600000, 'TYPSTK000001', 'CATPROD000001');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000003', 'ecran LED 24" Full HD', 400000, 'TYPSTK000001', 'CATPROD000001');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000004', 'Smartphone Haut de Gamme', 1200000, 'TYPSTK000001', 'CATPROD000001');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000005', 'Tissu Coton Premium 1m', 20000, 'TYPSTK000001', 'CATPROD000007');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000006', 'Tissu Lin Naturel 1m', 30000, 'TYPSTK000001', 'CATPROD000007');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000007', 'Uniforme Professionnel Complet', 80000, 'TYPSTK000001', 'CATPROD000007');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000008', 'Rouleau Tissu 50m', 750000, 'TYPSTK000001', 'CATPROD000007');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000009', 'Barre d Acier 6m 10mm', 75000, 'TYPSTK000002', 'CATPROD000005');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000010', 'Poutrelle IPN 6m', 120000, 'TYPSTK000002', 'CATPROD000005');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000011', 'T“le Acier 2x1m 2mm', 55000, 'TYPSTK000002', 'CATPROD000005');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000012', 'Fer … Beton 12mm 6m', 45000, 'TYPSTK000002', 'CATPROD000005');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000013', 'Bidon Plastique 20L', 15000, 'TYPSTK000003', 'CATPROD000010');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000014', 'Caisse Plastique EMP1', 8000, 'TYPSTK000003', 'CATPROD000010');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000015', 'Film etirable 500m', 25000, 'TYPSTK000003', 'CATPROD000010');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000016', 'Sacs Plastique 1000 unites', 18000, 'TYPSTK000003', 'CATPROD000010');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000017', 'Papier Copieur 80g 500 feuilles', 22000, 'TYPSTK000002', 'CATPROD000004');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000018', 'Classeur … Levier A4', 12000, 'TYPSTK000002', 'CATPROD000004');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000019', 'Calculatrice Scientifique', 35000, 'TYPSTK000002', 'CATPROD000004');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000020', 'Stylos Bic Pack 100', 25000, 'TYPSTK000002', 'CATPROD000004');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000021', 'PC Gamer RTX 3060', 3500000, 'TYPSTK000001', 'CATPROD000001');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000022', 'Clavier Gaming RGB', 150000, 'TYPSTK000001', 'CATPROD000002');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000023', 'Souris Gaming', 80000, 'TYPSTK000001', 'CATPROD000002');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000024', 'Casque Audio Gaming', 120000, 'TYPSTK000001', 'CATPROD000002');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000025', 'Disque Dur SSD 1To', 450000, 'TYPSTK000003', 'CATPROD000002');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000026', 'Imprimante Laser Multifonction', 650000, 'TYPSTK000003', 'CATPROD000002');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000027', 'Scanner Professionnel A3', 850000, 'TYPSTK000003', 'CATPROD000002');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000028', 'Serveur Rack 1U', 2500000, 'TYPSTK000003', 'CATPROD000002');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000029', 'Chaise de Bureau Executive', 750000, 'TYPSTK000003', 'CATPROD000003');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000030', 'Bureau Directeur 180cm', 1200000, 'TYPSTK000003', 'CATPROD000003');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000031', 'Armoire Archivage 4 portes', 850000, 'TYPSTK000003', 'CATPROD000003');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000032', 'Fauteuil de Reception', 350000, 'TYPSTK000003', 'CATPROD000003');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000033', 'Perceuse Visseuse 18V', 250000, 'TYPSTK000002', 'CATPROD000006');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000034', 'Marteau Piqueur', 450000, 'TYPSTK000002', 'CATPROD000006');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000035', 'Scie Circulaire', 300000, 'TYPSTK000002', 'CATPROD000006');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000036', 'Niveau Laser', 180000, 'TYPSTK000002', 'CATPROD000006');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000037', 'Casque Securite Chantier', 45000, 'TYPSTK000001', 'CATPROD000009');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000038', 'Gilet Securite Fluorescent', 15000, 'TYPSTK000001', 'CATPROD000009');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000039', 'Peinture RoutiŠre 20L', 85000, 'TYPSTK000001', 'CATPROD000008');
INSERT INTO produit( id, nom, prix, idtypemvtstock, idcatproduit ) VALUES ( 'PROD000040', 'Huile Moteur 5W30 5L', 55000, 'TYPSTK000001', 'CATPROD000008');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000001', 'Jean Rakoto', 'rakoto', 'mdp123', 'ENT000001');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000002', 'Marie Randria', 'randria', 'mdp123', 'ENT000002');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000003', 'Paul Rabe', 'rabe', 'mdp123', 'ENT000003');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000004', 'Sophie Rajaona', 'rajaona', 'mdp123', 'ENT000004');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000005', 'Andry Ratsiraka', 'ratsiraka', 'mdp123', 'ENT000005');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000006', 'Lalao Ravalomanana', 'ravalo', 'mdp123', 'ENT000006');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000007', 'Tiana Razafy', 'razafy', 'mdp123', 'ENT000007');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000008', 'Marc Andrian', 'andrian', 'mdp123', 'ENT000008');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000009', 'Nirina Rajaonarivony', 'rajaonary', 'mdp123', 'ENT000009');
INSERT INTO "admin"( idadmin, nom, logins, mdp, identreprise ) VALUES ( 'ADMIN000010', 'Hanta Ramanantsoa', 'ramanantsoa', 'mdp123', 'ENT000010');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000001', 'Dep“t Principal Industries', 'ENT000001', 'SIT000001');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000002', 'Dep“t Secondaire Industries', 'ENT000001', 'SIT000002');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000003', 'Entrep“t Textiles', 'ENT000002', 'SIT000001');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000004', 'Stock Textiles', 'ENT000002', 'SIT000003');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000005', 'Dep“t Acierie', 'ENT000003', 'SIT000002');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000006', 'Stock Metaux', 'ENT000003', 'SIT000004');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000007', 'Usine Plastiques', 'ENT000004', 'SIT000003');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000008', 'Dep“t Toliara', 'ENT000004', 'SIT000003');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000009', 'Entrep“t Commerce', 'ENT000005', 'SIT000001');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000010', 'Stock Marchandises', 'ENT000005', 'SIT000002');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000011', 'Super Dep“t Tana', 'ENT000006', 'SIT000001');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000012', 'Reserve Super Marche', 'ENT000006', 'SIT000001');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000013', 'Dep“t Import', 'ENT000007', 'SIT000004');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000014', 'Dep“t Export', 'ENT000007', 'SIT000005');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000015', 'Centre Services', 'ENT000008', 'SIT000001');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000016', 'Bureau Stock', 'ENT000008', 'SIT000002');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000017', 'Base Logistique', 'ENT000009', 'SIT000005');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000018', 'Entrep“t Logistique', 'ENT000009', 'SIT000001');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000019', 'Garage Transport', 'ENT000010', 'SIT000003');
INSERT INTO depot( id, nom, identreprise, idsite ) VALUES ( 'DEP000020', 'Dep“t PiŠces', 'ENT000010', 'SIT000003');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000003', '2026-01-26 02:13:08 PM', 'ETAT000001', 'ENT000009', 'ENT000001');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000001', '2026-01-24 10:49:12 PM', 'ETAT000003', 'ENT000008', 'ENT000001');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000005', '2026-01-27 03:14:42 PM', 'ETAT000001', 'ENT000004', 'ENT000001');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000006', '2026-01-27 03:16:15 PM', 'ETAT000001', 'ENT000005', 'ENT000001');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000012', '2026-01-27 03:34:18 PM', 'ETAT000001', 'ENT000006', 'ENT000001');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000004', '2026-01-26 02:31:49 PM', 'ETAT000005', 'ENT000001', 'ENT000006');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000002', '2026-01-24 11:10:59 PM', 'ETAT000005', 'ENT000009', 'ENT000001');
INSERT INTO dmdachat( id, daty, idetat, idfournisseur, idclient ) VALUES ( 'DMDA000013', '2026-02-02 02:02:14 PM', 'ETAT000005', 'ENT000007', 'ENT000001');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000001', 5, 'DMDA000001', 'PROD000008');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000002', 3, 'DMDA000001', 'PROD000013');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000003', 5, 'DMDA000002', 'PROD000017');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000004', 2, 'DMDA000002', 'PROD000012');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000005', 6, 'DMDA000002', 'PROD000013');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000006', 3, 'DMDA000003', 'PROD000010');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000007', 1, 'DMDA000003', 'PROD000017');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000008', 1, 'DMDA000003', 'PROD000001');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000009', 8, 'DMDA000003', 'PROD000016');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000010', 6, 'DMDA000004', 'PROD000006');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000011', 1, 'DMDA000005', 'PROD000017');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000012', 1, 'DMDA000006', 'PROD000018');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000013', 5, 'DMDA000006', 'PROD000016');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000020', 1, 'DMDA000012', 'PROD000017');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000021', 6, 'DMDA000013', 'PROD000013');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000022', 5, 'DMDA000013', 'PROD000012');
INSERT INTO dmdachatdetail( id, qte, iddmdachat, idproduit ) VALUES ( 'DMADET000023', 4, 'DMDA000013', 'PROD000010');
INSERT INTO proforma( id, validite, daty, idetat, iddmdachat ) VALUES ( 'PROF000002', 3, '2026-01-27 03:55:02 PM', 'ETAT000001', 'DMDA000004');
INSERT INTO proforma( id, validite, daty, idetat, iddmdachat ) VALUES ( 'PROF000003', 3, '2026-01-27 03:56:42 PM', 'ETAT000003', 'DMDA000002');
INSERT INTO proforma( id, validite, daty, idetat, iddmdachat ) VALUES ( 'PROF000004', 3, '2026-02-02 02:03:34 PM', 'ETAT000003', 'DMDA000013');
INSERT INTO proformadetail( id, prix, idproforma, idproduit ) VALUES ( 'PROFDET000001', '30000.00', 'PROF000002', 'PROD000006');
INSERT INTO proformadetail( id, prix, idproforma, idproduit ) VALUES ( 'PROFDET000002', '22000.00', 'PROF000003', 'PROD000017');
INSERT INTO proformadetail( id, prix, idproforma, idproduit ) VALUES ( 'PROFDET000003', '45000.00', 'PROF000003', 'PROD000012');
INSERT INTO proformadetail( id, prix, idproforma, idproduit ) VALUES ( 'PROFDET000004', '15000.00', 'PROF000003', 'PROD000013');
INSERT INTO proformadetail( id, prix, idproforma, idproduit ) VALUES ( 'PROFDET000005', '15000', 'PROF000004', 'PROD000013');
INSERT INTO proformadetail( id, prix, idproforma, idproduit ) VALUES ( 'PROFDET000006', '45000', 'PROF000004', 'PROD000012');
INSERT INTO proformadetail( id, prix, idproforma, idproduit ) VALUES ( 'PROFDET000007', '120000', 'PROF000004', 'PROD000010');
INSERT INTO bc( id, daty, idetat, idclient, idfournisseur, idproforma ) VALUES ( 'BC000002', '2026-01-28 05:12:22 PM', 'ETAT000006', 'ENT000001', 'ENT000009', 'PROF000003');
INSERT INTO bc( id, daty, idetat, idclient, idfournisseur, idproforma ) VALUES ( 'BC000003', '2026-02-02 02:03:57 PM', 'ETAT000006', 'ENT000001', 'ENT000007', 'PROF000004');
INSERT INTO bcdetail( id, qte, idbc, idproduit ) VALUES ( 'BCDET000004', 5, 'BC000002', 'PROD000017');
INSERT INTO bcdetail( id, qte, idbc, idproduit ) VALUES ( 'BCDET000005', 2, 'BC000002', 'PROD000012');
INSERT INTO bcdetail( id, qte, idbc, idproduit ) VALUES ( 'BCDET000006', 6, 'BC000002', 'PROD000013');
INSERT INTO bcdetail( id, qte, idbc, idproduit ) VALUES ( 'BCDET000007', 6, 'BC000003', 'PROD000013');
INSERT INTO bcdetail( id, qte, idbc, idproduit ) VALUES ( 'BCDET000008', 5, 'BC000003', 'PROD000012');
INSERT INTO bcdetail( id, qte, idbc, idproduit ) VALUES ( 'BCDET000009', 4, 'BC000003', 'PROD000010');
INSERT INTO bonlivraison( id, daty, idbc ) VALUES ( 'BL000004', '2026-02-02 10:11:05 AM', 'BC000002');
INSERT INTO bonlivraison( id, daty, idbc ) VALUES ( 'BL000005', '2026-02-02 02:04:15 PM', 'BC000003');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000007', 5, 'PROD000017', 'BL000004');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000008', 2, 'PROD000012', 'BL000004');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000009', 6, 'PROD000013', 'BL000004');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000010', 5, 'PROD000017', 'BL000005');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000011', 2, 'PROD000012', 'BL000005');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000012', 6, 'PROD000013', 'BL000005');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000013', 6, 'PROD000013', 'BL000005');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000014', 5, 'PROD000012', 'BL000005');
INSERT INTO bonlivraisondetail( id, qte, idproduit, idbl ) VALUES ( 'BLDET000015', 4, 'PROD000010', 'BL000005');
INSERT INTO bonreception( id, daty, idbl, idbc ) VALUES ( 'BR000004', '2026-02-02 10:11:05 AM', 'BL000004', 'BC000002');
INSERT INTO bonreception( id, daty, idbl, idbc ) VALUES ( 'BR000005', '2026-02-02 02:04:15 PM', 'BL000005', 'BC000003');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000007', 5, 'BR000004', 'PROD000017');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000008', 2, 'BR000004', 'PROD000012');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000009', 6, 'BR000004', 'PROD000013');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000010', 5, 'BR000005', 'PROD000017');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000011', 2, 'BR000005', 'PROD000012');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000012', 6, 'BR000005', 'PROD000013');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000013', 6, 'BR000005', 'PROD000013');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000014', 5, 'BR000005', 'PROD000012');
INSERT INTO bonreceptiondetail( id, qte, idbonreception, idproduit ) VALUES ( 'BRDET000015', 4, 'BR000005', 'PROD000010');
INSERT INTO facture( id, montantreste, daty, idclient, idfournisseur, idetat, idbr ) VALUES ( 'FACT000002', 1000000, '2026-02-02 02:04:15 PM', 'ENT000001', 'ENT000007', 'ETAT000001', 'BR000005');
INSERT INTO facture( id, montantreste, daty, idclient, idfournisseur, idetat, idbr ) VALUES ( 'FACT000001', 200000, '2026-02-02 10:11:05 AM', 'ENT000001', 'ENT000009', 'ETAT000001', 'BR000004');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000001', 5, 'FACT000001', 'PROD000017');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000002', 2, 'FACT000001', 'PROD000012');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000003', 6, 'FACT000001', 'PROD000013');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000004', 5, 'FACT000002', 'PROD000017');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000005', 2, 'FACT000002', 'PROD000012');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000006', 6, 'FACT000002', 'PROD000013');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000007', 6, 'FACT000002', 'PROD000013');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000008', 5, 'FACT000002', 'PROD000012');
INSERT INTO facturedetail( id, qte, idfacture, idproduit ) VALUES ( 'FACTDET000009', 4, 'FACT000002', 'PROD000010');
INSERT INTO payement( id, montant, daty, idfacture ) VALUES ( 'PAY000001', 85000, '2026-02-02 04:12:45 PM', 'FACT000002');
INSERT INTO payement( id, montant, daty, idfacture ) VALUES ( 'PAY000002', 90000, '2026-02-02 04:15:34 PM', 'FACT000001');
