USE [WiNGS_BaseInfo_Db]
GO
/****** Object:  Table [dbo].[Tbl_Chromosome]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Chromosome](
	[GBid] [varchar](50) NOT NULL,
	[Chr] [varchar](2) NOT NULL,
	[totallength] [bigint] NOT NULL,
	[ucsc_colorcode] [varchar](50) NULL,
	[Chr_Numeric] [int] NOT NULL,
 CONSTRAINT [PK_Tbl_Chromosome] PRIMARY KEY CLUSTERED 
(
	[GBid] ASC,
	[Chr] ASC,
	[totallength] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Viw_Chromosome]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Viw_Chromosome]
AS
SELECT        TOP (100) PERCENT GBid, Chr, totallength, ucsc_colorcode
FROM            dbo.Tbl_Chromosome
ORDER BY CASE WHEN ISNUMERIC(chr) = 1 THEN CAST(chr AS FLOAT) WHEN ISNUMERIC(LEFT(chr, 1)) = 0 THEN ASCII(LEFT(LOWER(chr), 1)) ELSE 99 END
GO
/****** Object:  Table [dbo].[Tbl_OMIM]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_OMIM](
	[OMIMID] [nvarchar](11) NOT NULL,
	[OMIM_Name] [nvarchar](145) NULL,
	[OMIM_Alt] [nvarchar](max) NULL,
	[Prefix] [nvarchar](max) NULL,
	[MIM_Number] [int] NULL,
	[Included_Title_s_symbols] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_OMIM] PRIMARY KEY CLUSTERED 
(
	[OMIMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Phenotype_to_Genes]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Phenotype_to_Genes](
	[HPOID] [nvarchar](10) NOT NULL,
	[HPO_Name] [nvarchar](150) NOT NULL,
	[GeneID] [int] NOT NULL,
	[Gene_Symbol] [nvarchar](15) NOT NULL,
	[G_D_source] [nvarchar](10) NOT NULL,
	[DiseaseID] [nvarchar](12) NOT NULL,
	[OMIM_Name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Tbl_Phenotype_to_Genes_1] PRIMARY KEY CLUSTERED 
(
	[HPOID] ASC,
	[GeneID] ASC,
	[DiseaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Viw_HPO_OMIM]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Viw_HPO_OMIM]
AS
SELECT dbo.Tbl_OMIM.OMIM_Name, dbo.Tbl_OMIM.OMIMID, dbo.Tbl_Phenotype_to_Genes.HPOID, dbo.Tbl_Phenotype_to_Genes.HPO_Name
FROM  dbo.Tbl_OMIM RIGHT OUTER JOIN
         dbo.Tbl_Phenotype_to_Genes ON dbo.Tbl_OMIM.OMIMID = dbo.Tbl_Phenotype_to_Genes.DiseaseID
WHERE (dbo.Tbl_Phenotype_to_Genes.G_D_source = 'mim2gene')
GO
/****** Object:  Table [dbo].[Tbl_HPO]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_HPO](
	[HPOID] [nvarchar](10) NOT NULL,
	[HPO_Name] [nvarchar](100) NOT NULL,
	[HPO_Desc] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblhpo] PRIMARY KEY CLUSTERED 
(
	[HPOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Viw_Individual_HPOs]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Viw_Individual_HPOs]
AS
SELECT WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_HPOs.*, dbo.Tbl_HPO.HPO_Name
FROM  WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_HPOs LEFT OUTER JOIN
         dbo.Tbl_HPO ON WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_HPOs.HPOID = dbo.Tbl_HPO.HPOID
GO
/****** Object:  View [dbo].[Viw_Individual_OMIMs]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Viw_Individual_OMIMs]
AS
SELECT WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_OMIMs.IndividualID, WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_OMIMs.OMIMID, WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_OMIMs.UserID, WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_OMIMs.DateAdd, dbo.Tbl_OMIM.OMIM_Name
FROM  WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_OMIMs LEFT OUTER JOIN
         dbo.Tbl_OMIM ON WiNGS_Db_Dev.dbo.Tbl_PhenBook_Individual_OMIMs.OMIMID = dbo.Tbl_OMIM.OMIMID
GO
/****** Object:  View [dbo].[Viw_His_PhenBook]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Viw_His_PhenBook]
AS
SELECT WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.IndividualID, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.HPOID, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.HPO_Status, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.Onset_Year, 
         CASE HPO_Severity WHEN 0 THEN 'Mild' WHEN 1 THEN 'Avarage' WHEN 2 THEN 'Sevier' END AS HPO_Severity, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.Onset_month, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.Operation, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.DateUpdate, 
         WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.UserID_Update, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.DateAdd, WiNGS_Db_Dev.dbo.AspNetUsers.UserFullName, WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.UserID, AspNetUsers_1.UserFullName AS User_Update, dbo.Tbl_HPO.HPO_Name, dbo.Tbl_HPO.HPO_Desc
FROM  dbo.Tbl_HPO RIGHT OUTER JOIN
         WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs ON dbo.Tbl_HPO.HPOID = WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.HPOID LEFT OUTER JOIN
         WiNGS_Db_Dev.dbo.AspNetUsers ON WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.UserID = WiNGS_Db_Dev.dbo.AspNetUsers.UserID LEFT OUTER JOIN
         WiNGS_Db_Dev.dbo.AspNetUsers AS AspNetUsers_1 ON WiNGS_Db_Dev.dbo.His_Tbl_PhenBook_Individual_HPOs.UserID = AspNetUsers_1.UserID
GO
/****** Object:  Table [dbo].[__Sys_tmp_Variant]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__Sys_tmp_Variant](
	[_id] [nvarchar](100) NOT NULL,
	[sid] [bigint] NULL,
	[v_type] [nvarchar](50) NULL,
	[non_variant] [int] NULL,
	[vcf_chr] [nvarchar](50) NULL,
	[chr] [int] NOT NULL,
	[start_pos] [bigint] NOT NULL,
	[stop_pos] [bigint] NOT NULL,
	[ref_all] [nvarchar](200) NOT NULL,
	[alt_all] [nvarchar](200) NOT NULL,
	[multi_allelic] [int] NULL,
	[phred_polymorphism] [float] NULL,
	[filter] [nvarchar](200) NULL,
	[alt_cnt] [int] NULL,
	[ref_depth] [int] NULL,
	[alt_depth] [int] NULL,
	[phred_genotype] [int] NULL,
	[mapping_quality] [float] NULL,
	[base_q_ranksum] [float] NULL,
	[mapping_q_ranksum] [float] NULL,
	[read_pos_ranksum] [float] NULL,
	[strand_bias] [int] NULL,
	[quality_by_depth] [float] NULL,
	[fisher_strand] [float] NULL,
	[vqslod] [int] NULL,
	[gt_ratio] [float] NULL,
	[ploidy] [int] NULL,
	[somatic_state] [int] NULL,
	[delta_pl] [int] NULL,
	[stretch_lt_a] [int] NULL,
	[stretch_lt_b] [int] NULL,
	[gene_annotations] [nvarchar](max) NULL,
	[gnomAD] [nvarchar](max) NULL,
	[phred_score] [float] NULL,
 CONSTRAINT [PK___Sys_tmp_Variant] PRIMARY KEY CLUSTERED 
(
	[chr] ASC,
	[start_pos] ASC,
	[stop_pos] ASC,
	[ref_all] ASC,
	[alt_all] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_bands]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_bands](
	[key] [varchar](31) NULL,
	[chromosome] [varchar](24) NOT NULL,
	[band] [varchar](7) NOT NULL,
	[start] [numeric](10, 0) NOT NULL,
	[end] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_hsapiens_bands] PRIMARY KEY CLUSTERED 
(
	[chromosome] ASC,
	[band] ASC,
	[start] ASC,
	[end] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_gene_main]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_gene_main](
	[gene_stable_id] [varchar](16) NOT NULL,
	[biotype] [varchar](40) NOT NULL,
	[description] [varchar](373) NULL,
	[gene_chrom_start] [numeric](10, 0) NOT NULL,
	[gene_chrom_end] [numeric](10, 0) NOT NULL,
	[chrom_strand] [numeric](3, 0) NOT NULL,
	[chr_name] [varchar](40) NOT NULL,
 CONSTRAINT [PK_hsapiens_gene_main] PRIMARY KEY CLUSTERED 
(
	[gene_stable_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_gene_xref]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_gene_xref](
	[ensembl_gene_id] [varchar](15) NOT NULL,
	[external_gene_id] [varchar](42) NULL,
	[entrezgene] [varchar](179) NULL,
 CONSTRAINT [PK_hsapiens_gene_xref] PRIMARY KEY CLUSTERED 
(
	[ensembl_gene_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_supergo]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_supergo](
	[ensembl_gene_id] [varchar](255) NOT NULL,
	[features] [text] NULL,
 CONSTRAINT [PK_hsapiens_supergo] PRIMARY KEY CLUSTERED 
(
	[ensembl_gene_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_supergo_terms]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_supergo_terms](
	[term] [varchar](255) NOT NULL,
	[description] [varchar](250) NULL,
	[freq] [numeric](25, 24) NOT NULL,
	[nbGenes] [numeric](5, 0) NOT NULL,
 CONSTRAINT [PK_hsapiens_supergo_terms] PRIMARY KEY CLUSTERED 
(
	[term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_superomim]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_superomim](
	[ensembl_gene_id] [varchar](255) NOT NULL,
	[features] [varchar](1166) NULL,
 CONSTRAINT [PK_hsapiens_superomim] PRIMARY KEY CLUSTERED 
(
	[ensembl_gene_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_superomim_terms]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_superomim_terms](
	[term] [varchar](255) NOT NULL,
	[description] [varchar](164) NULL,
	[freq] [numeric](25, 24) NOT NULL,
	[nbGenes] [numeric](5, 0) NOT NULL,
	[iid] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_hsapiens_superomim_terms_1] PRIMARY KEY CLUSTERED 
(
	[iid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hsapiens_xref_combined_final]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hsapiens_xref_combined_final](
	[ensembl_gene_id] [varchar](15) NOT NULL,
	[xref_id] [varchar](18) NOT NULL,
	[xref_source] [varchar](27) NOT NULL,
 CONSTRAINT [PK_hsapiens_xref_combined_final] PRIMARY KEY CLUSTERED 
(
	[ensembl_gene_id] ASC,
	[xref_id] ASC,
	[xref_source] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[non_alt_loci_set]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[non_alt_loci_set](
	[hgnc_id] [varchar](1000) NULL,
	[symbol] [varchar](12) NULL,
	[name] [varchar](84) NULL,
	[locus_group] [varchar](19) NULL,
	[locus_type] [varchar](25) NULL,
	[status] [varchar](8) NULL,
	[location] [varchar](13) NULL,
	[location_sortable] [varchar](13) NULL,
	[alias_symbol] [varchar](42) NULL,
	[alias_name] [varchar](223) NULL,
	[prev_symbol] [varchar](50) NULL,
	[prev_name] [varchar](1000) NULL,
	[gene_family] [varchar](max) NULL,
	[gene_family_id] [varchar](max) NULL,
	[date_approved_reserved] [datetime] NULL,
	[date_symbol_changed] [datetime] NULL,
	[date_name_changed] [datetime] NULL,
	[date_modified] [datetime] NULL,
	[entrez_id] [int] NULL,
	[ensembl_gene_id] [varchar](15) NULL,
	[vega_id] [varchar](18) NULL,
	[ucsc_id] [varchar](10) NULL,
	[ena] [varchar](24) NULL,
	[refseq_accession] [varchar](12) NULL,
	[ccds_id] [varchar](110) NULL,
	[uniprot_ids] [varchar](6) NULL,
	[pubmed_id] [varchar](37) NULL,
	[mgd_id] [varchar](25) NULL,
	[rgd_id] [varchar](11) NULL,
	[lsdb] [varchar](288) NULL,
	[cosmic] [varchar](8) NULL,
	[omim_id] [int] NULL,
	[mirbase] [varchar](max) NULL,
	[homeodb] [varchar](max) NULL,
	[snornabase] [varchar](max) NULL,
	[bioparadigms_slc] [varchar](max) NULL,
	[orphanet] [int] NULL,
	[pseudogene org] [varchar](17) NULL,
	[horde_id] [varchar](max) NULL,
	[merops] [varchar](8) NULL,
	[imgt] [varchar](max) NULL,
	[iuphar] [varchar](13) NULL,
	[kznf_gene_catalog] [varchar](max) NULL,
	[mamit-trnadb] [varchar](max) NULL,
	[cd] [varchar](6) NULL,
	[lncrnadb] [varchar](max) NULL,
	[enzyme_id] [varchar](19) NULL,
	[intermediate_filament_db] [varchar](max) NULL,
	[rna_central_ids] [varchar](max) NULL,
	[lncipedia] [varchar](11) NULL,
	[gtrnadb] [varchar](max) NULL,
	[agr] [varchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_AnalysisType]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_AnalysisType](
	[AnalysisID] [int] NULL,
	[AnalysisDesc] [nvarchar](50) NULL,
	[AnalysisName] [nchar](10) NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Clinvar]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Clinvar](
	[ClinvarID] [int] NOT NULL,
	[ClinvarName] [varchar](200) NOT NULL,
	[ClinvarDesc] [varchar](250) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Effect]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Effect](
	[EffectID] [int] IDENTITY(1,1) NOT NULL,
	[EffectName] [varchar](100) NOT NULL,
	[EffectDesc] [varchar](250) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ex_diseases_to_genes]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ex_diseases_to_genes](
	[DiseaseID] [varchar](20) NOT NULL,
	[GeneID] [int] NULL,
	[Gene_Symbol] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ex_genes_to_diseases]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ex_genes_to_diseases](
	[GeneID] [int] NOT NULL,
	[Gene_Symbol] [nvarchar](50) NOT NULL,
	[DiseaseID] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ex_hpo_ALL_SOURCES_ALL_FREQUENCIES_genes_to_phenotype]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ex_hpo_ALL_SOURCES_ALL_FREQUENCIES_genes_to_phenotype](
	[GeneID] [int] NOT NULL,
	[Gene_Symbol] [nvarchar](15) NOT NULL,
	[HPO_Name] [nvarchar](max) NOT NULL,
	[HPOID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Tbl_PhenBook_ex_hpo_ALL_SOURCES_ALL_FREQUENCIES_genes_to_phenotype] PRIMARY KEY CLUSTERED 
(
	[GeneID] ASC,
	[HPOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ex_hpo_ALL_SOURCES_ALL_FREQUENCIES_phenotype_to_genes]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ex_hpo_ALL_SOURCES_ALL_FREQUENCIES_phenotype_to_genes](
	[HPOID] [nvarchar](10) NOT NULL,
	[HPO_Name] [nvarchar](max) NOT NULL,
	[GeneID] [int] NOT NULL,
	[Gene_Symbol] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Tbl_ex_hpo_ALL_SOURCES_ALL_FREQUENCIES_phenotype_to_genes] PRIMARY KEY CLUSTERED 
(
	[HPOID] ASC,
	[GeneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ex_OMIM_ALL_FREQUENCIES_diseases_to_genes_to_phenotypes]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ex_OMIM_ALL_FREQUENCIES_diseases_to_genes_to_phenotypes](
	[OMIMID] [nvarchar](11) NOT NULL,
	[Gene_Symbol] [nvarchar](10) NOT NULL,
	[GeneID] [int] NOT NULL,
	[HPOID] [nvarchar](10) NOT NULL,
	[HPO_Name] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Filter_OMIM_to_Genes]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Filter_OMIM_to_Genes](
	[DiseaseID] [nvarchar](12) NOT NULL,
	[OMIM_Name] [nvarchar](150) NOT NULL,
	[GeneIDs] [nvarchar](max) NULL,
	[Gene_Symbols] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_Filter_OMIM_to_Genes] PRIMARY KEY CLUSTERED 
(
	[DiseaseID] ASC,
	[OMIM_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Filter_PopulationFrequencies]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Filter_PopulationFrequencies](
	[Population] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_FunctionalScore]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_FunctionalScore](
	[FName] [varchar](100) NOT NULL,
	[FValue] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Tbl_FunctionalScore] PRIMARY KEY CLUSTERED 
(
	[FName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_GAP_Filter_Item_Category_WhereClause]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_GAP_Filter_Item_Category_WhereClause](
	[Item] [varchar](40) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Gene_Counts]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Gene_Counts](
	[GENEID] [int] NOT NULL,
	[HPO_Count] [int] NULL,
	[OMIM_Count] [int] NULL,
 CONSTRAINT [PK_Tbl_Gene_Counts] PRIMARY KEY CLUSTERED 
(
	[GENEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Genes]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Genes](
	[hgnc_id] [varchar](20) NOT NULL,
	[symbol] [varchar](50) NULL,
	[name] [varchar](1000) NULL,
	[locus_group] [varchar](1000) NULL,
	[locus_type] [varchar](1000) NULL,
	[status] [varchar](1000) NULL,
	[location] [varchar](1000) NULL,
	[location_sortable] [varchar](1000) NULL,
	[alias_symbol] [varchar](1000) NULL,
	[alias_name] [varchar](1000) NULL,
	[prev_symbol] [varchar](1000) NULL,
	[prev_name] [varchar](1000) NULL,
	[gene_family] [varchar](1000) NULL,
	[gene_family_id] [varchar](1000) NULL,
	[date_approved_reserved] [datetime] NULL,
	[date_symbol_changed] [datetime] NULL,
	[date_name_changed] [datetime] NULL,
	[date_modified] [datetime] NULL,
	[entrez_id] [int] NULL,
	[ensembl_gene_id] [varchar](1000) NULL,
	[vega_id] [varchar](1000) NULL,
	[ucsc_id] [varchar](1000) NULL,
	[ena] [varchar](1000) NULL,
	[refseq_accession] [varchar](1000) NULL,
	[ccds_id] [varchar](1000) NULL,
	[uniprot_ids] [varchar](1000) NULL,
	[pubmed_id] [varchar](1000) NULL,
	[mgd_id] [varchar](1000) NULL,
	[rgd_id] [varchar](1000) NULL,
	[lsdb] [varchar](1000) NULL,
	[cosmic] [varchar](1000) NULL,
	[omim_id] [varchar](1000) NULL,
	[mirbase] [varchar](1000) NULL,
	[homeodb] [varchar](1000) NULL,
	[snornabase] [varchar](1000) NULL,
	[bioparadigms_slc] [varchar](1000) NULL,
	[orphanet] [int] NULL,
	[pseudogene org] [varchar](1000) NULL,
	[horde_id] [varchar](1000) NULL,
	[merops] [varchar](1000) NULL,
	[imgt] [varchar](1000) NULL,
	[iuphar] [varchar](1000) NULL,
	[kznf_gene_catalog] [varchar](1000) NULL,
	[mamit-trnadb] [varchar](1000) NULL,
	[cd] [varchar](1000) NULL,
	[lncrnadb] [varchar](1000) NULL,
	[enzyme_id] [varchar](1000) NULL,
	[intermediate_filament_db] [varchar](1000) NULL,
	[rna_central_ids] [varchar](1000) NULL,
	[lncipedia] [varchar](1000) NULL,
	[gtrnadb] [varchar](1000) NULL,
	[agr] [varchar](1000) NULL,
 CONSTRAINT [PK_Tbl_Genes] PRIMARY KEY CLUSTERED 
(
	[hgnc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Genes_to_ChrBand]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Genes_to_ChrBand](
	[tax_id] [int] NOT NULL,
	[GeneID] [int] NOT NULL,
	[Symbol] [nvarchar](max) NOT NULL,
	[LocusTag] [nvarchar](max) NOT NULL,
	[Synonyms] [nvarchar](max) NOT NULL,
	[dbXrefs] [nvarchar](max) NOT NULL,
	[chromosome] [nvarchar](max) NULL,
	[map_location] [nvarchar](max) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[type_of_gene] [nvarchar](max) NOT NULL,
	[Symbol_from_nomenclature_authority] [nvarchar](max) NOT NULL,
	[Full_name_from_nomenclature_authority] [nvarchar](max) NOT NULL,
	[Nomenclature_status] [nvarchar](max) NOT NULL,
	[Other_designations] [nvarchar](max) NOT NULL,
	[Modification_date] [int] NOT NULL,
	[Feature_type] [nvarchar](max) NOT NULL,
	[Bands] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Genes_to_Go]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Genes_to_Go](
	[tax_id] [int] NOT NULL,
	[GeneID] [int] NOT NULL,
	[GO_ID] [nvarchar](max) NOT NULL,
	[Evidence] [nvarchar](max) NOT NULL,
	[Qualifier] [nvarchar](max) NOT NULL,
	[GO_term] [nvarchar](max) NOT NULL,
	[PubMed] [nvarchar](max) NOT NULL,
	[Category] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Genes_to_Location]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Genes_to_Location](
	[feature] [nvarchar](max) NOT NULL,
	[class] [nvarchar](max) NULL,
	[assembly] [nvarchar](max) NOT NULL,
	[assembly_unit] [nvarchar](max) NOT NULL,
	[seq_type] [nvarchar](max) NOT NULL,
	[chromosome] [nvarchar](max) NULL,
	[genomic_accession] [nvarchar](max) NOT NULL,
	[start] [int] NOT NULL,
	[end] [int] NOT NULL,
	[strand] [nvarchar](max) NOT NULL,
	[product_accession] [nvarchar](max) NULL,
	[non_redundant_refseq] [nvarchar](max) NULL,
	[related_accession] [nvarchar](max) NULL,
	[name] [nvarchar](max) NULL,
	[symbol] [nvarchar](max) NOT NULL,
	[GeneID] [int] NOT NULL,
	[locus_tag] [nvarchar](max) NULL,
	[feature_interval_length] [int] NOT NULL,
	[product_length] [nvarchar](max) NULL,
	[attributes] [nvarchar](max) NULL,
	[refBuild] [nchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Genes_to_Phenotype]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Genes_to_Phenotype](
	[GeneID] [int] NOT NULL,
	[Gene_Symbol] [nvarchar](50) NOT NULL,
	[HPOID] [nvarchar](50) NOT NULL,
	[HPO_Name] [nvarchar](100) NOT NULL,
	[Frequency_Raw] [nvarchar](50) NULL,
	[Frequency_HPO] [nvarchar](50) NULL,
	[Additional_Info_from_G_D_source] [nvarchar](50) NULL,
	[G_D_source] [nvarchar](50) NOT NULL,
	[DiseaseID] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Host]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Host](
	[HostID] [int] NULL,
	[HostDesc] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_HPO_Counts]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_HPO_Counts](
	[HPOID] [nvarchar](10) NOT NULL,
	[OMIM_Count] [int] NULL,
	[Gene_Count] [int] NULL,
 CONSTRAINT [PK_Tbl_HPO_Counts] PRIMARY KEY CLUSTERED 
(
	[HPOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_HPO_Tree]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_HPO_Tree](
	[HPOID] [nvarchar](10) NOT NULL,
	[HPOID_Parent] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Impact]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Impact](
	[ImpactName] [varchar](10) NOT NULL,
	[ImpactValue] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Tbl_Impact] PRIMARY KEY CLUSTERED 
(
	[ImpactValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Mutation]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Mutation](
	[MutationName] [varchar](50) NOT NULL,
	[MutationValue] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Tbl_Mutation] PRIMARY KEY CLUSTERED 
(
	[MutationValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_OMIM_Counts]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_OMIM_Counts](
	[OMIMID] [nvarchar](11) NOT NULL,
	[HPO_Count] [int] NULL,
	[Gene_Count] [int] NULL,
 CONSTRAINT [PK_Tbl_OMIM_Counts] PRIMARY KEY CLUSTERED 
(
	[OMIMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_PanelType]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PanelType](
	[PanelID] [int] NULL,
	[PanelTypeID] [int] NULL,
	[PanelTypeName] [nvarchar](200) NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Phenotype_to_Genes_Tmp]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Phenotype_to_Genes_Tmp](
	[HPOID] [nvarchar](10) NOT NULL,
	[HPO_Name] [nvarchar](max) NOT NULL,
	[GeneID] [int] NOT NULL,
	[Gene_Symbol] [nvarchar](max) NOT NULL,
	[G_D_source] [nvarchar](max) NOT NULL,
	[DiseaseID] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ReferenceBuild]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ReferenceBuild](
	[ReferenceBuildID] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceBuildName] [varchar](50) NULL,
	[Textcode] [nvarchar](20) NULL,
	[status] [int] NULL,
	[UserID] [int] NULL,
	[DateAdd] [datetime] NULL,
 CONSTRAINT [PK_Tbl_ReferenceBuild] PRIMARY KEY CLUSTERED 
(
	[ReferenceBuildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SampleFileSource]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SampleFileSource](
	[SourceTypeID] [int] IDENTITY(1,1) NOT NULL,
	[SourceTypeName] [varchar](50) NULL,
	[UserID] [int] NULL,
	[DateAdd] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SampleFileType]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SampleFileType](
	[FileTypeID] [int] NOT NULL,
	[FileTypeName] [varchar](50) NULL,
	[ImportAPI] [int] NULL,
	[Analysis] [int] NULL,
	[InputOrOutput] [int] NULL,
	[Active] [int] NULL,
	[ReferenceBuild] [int] NULL,
	[UserID] [int] NULL,
	[DateAdd] [datetime] NULL,
 CONSTRAINT [PK_Tbl_SampleFileType] PRIMARY KEY CLUSTERED 
(
	[FileTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SampleImportStatus]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SampleImportStatus](
	[StatusID] [int] NULL,
	[StatusDescription] [nvarchar](50) NULL,
	[Stage] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SampleType]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SampleType](
	[SampleTypeID] [int] NOT NULL,
	[SampleTypeName] [nvarchar](50) NULL,
	[Creator] [int] NULL,
	[DateAssign] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SeqKitModel]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SeqKitModel](
	[SeqKitModelID] [int] IDENTITY(1,1) NOT NULL,
	[SeqKitModelName] [nvarchar](50) NULL,
	[UserID] [int] NULL,
	[DateAdd] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SeqMachine]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SeqMachine](
	[SeqMachineID] [int] IDENTITY(1,1) NOT NULL,
	[SeqMachineName] [nvarchar](50) NULL,
	[UserID] [int] NULL,
	[DateAdd] [datetime] NULL,
 CONSTRAINT [PK_Tbl_SeqMachine] PRIMARY KEY CLUSTERED 
(
	[SeqMachineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SeqToolType]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SeqToolType](
	[SeqToolTypeID] [int] IDENTITY(1,1) NOT NULL,
	[SeqToolTypeName] [nvarchar](50) NULL,
	[UserID] [int] NULL,
	[DateAdd] [datetime] NULL,
 CONSTRAINT [PK_Tbl_ToolType] PRIMARY KEY CLUSTERED 
(
	[SeqToolTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_SeqType]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SeqType](
	[SeqTypeID] [int] IDENTITY(1,1) NOT NULL,
	[SeqTypeName] [nvarchar](50) NULL,
	[AllowRepeated] [int] NULL,
	[UserID] [int] NULL,
	[DateAdd] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_YesNo]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_YesNo](
	[Name] [varchar](10) NOT NULL,
	[Value] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Zygosity]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Zygosity](
	[ZygoName] [nvarchar](50) NOT NULL,
	[ZygoValue] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Tbl_Zygosity] PRIMARY KEY CLUSTERED 
(
	[ZygoValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_ReferenceBuild] ADD  CONSTRAINT [DF_Tbl_ReferenceBuild_DateAdd]  DEFAULT (getdate()) FOR [DateAdd]
GO
ALTER TABLE [dbo].[Tbl_SampleFileSource] ADD  CONSTRAINT [DF_Tbl_SourceInputFile_DateAdd]  DEFAULT (getdate()) FOR [DateAdd]
GO
ALTER TABLE [dbo].[Tbl_SampleFileType] ADD  CONSTRAINT [DF_Tbl_InputFileType_DateAdd]  DEFAULT (getdate()) FOR [DateAdd]
GO
ALTER TABLE [dbo].[Tbl_SeqMachine] ADD  CONSTRAINT [DF_Tbl_SeqMachine_DateAdd]  DEFAULT (getdate()) FOR [DateAdd]
GO
ALTER TABLE [dbo].[Tbl_SeqToolType] ADD  CONSTRAINT [DF_Tbl_ToolType_DateAdd]  DEFAULT (getdate()) FOR [DateAdd]
GO
/****** Object:  StoredProcedure [dbo].[Compressing_Tbls]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[Compressing_Tbls]
AS
Begin
DECLARE test CURSOR
READ_ONLY
FOR Select name From sys.TABLES 

DECLARE @name varchar(40)
OPEN test

FETCH NEXT FROM test INTO @name
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
--		PRINT 'add user defined code here'
--		eg.
		DECLARE @message nvarchar(max)
		Set @message = 'ALTER TABLE [dbo].['+@name+'] REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)'

		PRINT @message
	END
	FETCH NEXT FROM test INTO @name
END

CLOSE test
DEALLOCATE test
END

GO
/****** Object:  StoredProcedure [dbo].[Sp_HPO_GENE_OMIM_COUNTS]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[Sp_HPO_GENE_OMIM_COUNTS]

AS 
DECLARE @GENEID int
DECLARE db_cursor  CURSOR LOCAL FOR

SELECT distinct GeneID
FROM  [dbo].[Tbl_Phenotype_to_Genes]


OPEN db_cursor


FETCH NEXT FROM db_cursor INTO @GENEID


WHILE @@FETCH_STATUS = 0  
 
BEGIN


-----------<<HPO_counts>>------------
--DECLARE @OMIM_Count int, @Gene_Count int
--set @OMIM_Count = (select count(distinct(DiseaseID)) from [dbo].[Tbl_Phenotype_to_Genes] WHERE HPOID = @HPOID)
--set @Gene_Count = (select count(distinct(GeneID)) from [dbo].[Tbl_Phenotype_to_Genes] WHERE HPOID = @HPOID)

--INSERT INTO [dbo].[Tbl_HPO_Counts]
--VALUES(@GeneID,@HPO_Count,@disease_Count)

-----------<<omim_counts>>------------
--DECLARE @Gene_Count int, @HPO_Count int
--set @HPO_Count = (select count(distinct(HPOID)) from [dbo].[Tbl_Phenotype_to_Genes] WHERE DiseaseID = @DiseaseID)
--set @Gene_Count = (select count(distinct(GeneID)) from [dbo].[Tbl_Phenotype_to_Genes] WHERE DiseaseID = @DiseaseID)

--INSERT INTO [dbo].[Tbl_OMIM_Counts]
--VALUES(@GeneID,@HPO_Count,@disease_Count)

-----------<<gene_counts>>------------

DECLARE @disease_Count int, @HPO_Count int
set @HPO_Count = (select count(distinct(HPOID)) from [dbo].[Tbl_Phenotype_to_Genes] WHERE GeneID = @GENEID)
set @disease_Count = (select count(distinct(DiseaseID)) from [dbo].[Tbl_Phenotype_to_Genes] WHERE GeneID = @GENEID)

INSERT INTO [dbo].[Tbl_GENE_Counts]
VALUES(@GeneID,@HPO_Count,@disease_Count)

	FETCH NEXT FROM db_cursor INTO @GENEID
END 


CLOSE db_cursor  


DEALLOCATE db_cursor 
GO
/****** Object:  StoredProcedure [dbo].[Sp_Update_Tbl_Filter_OMIM_to_Genes]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[Sp_Update_Tbl_Filter_OMIM_to_Genes]
As

----Step one
--INSERT INTO [WiNGS_BaseInfo_Db].[dbo].[Tbl_Filter_OMIM_to_Genes]
--(DiseaseID, OMIM_Name)
--SELECT DiseaseID, OMIM_Name
--FROM
--(
--    SELECT DISTINCT DiseaseID, OMIM_Name
--    FROM [WiNGS_BaseInfo_Db].[dbo].[Tbl_Phenotype_to_Genes]
--)DT

----Step Two
CREATE TABLE #tmp( 
    DiseaseID nvarchar(12),
	geneIds nvarchar(MAX),
    geneSymbols nvarchar(MAX)
);

insert into #tmp select DiseaseID,
  stuff((SELECT distinct ', ' + cast([GeneID] as varchar(10)) 
           FROM [WiNGS_BaseInfo_Db].[dbo].[Tbl_Phenotype_to_Genes] t2
           where t2.DiseaseID = t1.DiseaseID
           FOR XML PATH('')),1,1,'') geneIds,
  stuff((SELECT distinct ', ' + cast(Gene_Symbol as varchar(10)) 
    FROM [WiNGS_BaseInfo_Db].[dbo].[Tbl_Phenotype_to_Genes] t2
           where t2.DiseaseID = t1.DiseaseID
           FOR XML PATH('')),1,1,'') geneSymbols
from [WiNGS_BaseInfo_Db].[dbo].[Tbl_Phenotype_to_Genes] t1
group by DiseaseID


----Step Three
UPDATE tbl
	SET 
	tbl.GeneIDs=tbl2.geneIds, 
	tbl.Gene_Symbols=tbl2.geneSymbols
	FROM [WiNGS_BaseInfo_Db].[dbo].[Tbl_Filter_OMIM_to_Genes] tbl
	INNER JOIN
	 #tmp tbl2
	ON tbl.DiseaseID = tbl2.DiseaseID

DROP TABLE #tmp
GO
/****** Object:  StoredProcedure [dbo].[Y_get_crossdatabase_dependencies]    Script Date: 5/12/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Y_get_crossdatabase_dependencies] 
@tableName nvarchar(max)
AS
CREATE TABLE #databases(
    database_id int, 
    database_name sysname
);

-- ignore systems databases
INSERT INTO #databases(database_id, database_name)
SELECT database_id, name FROM sys.databases
WHERE database_id > 4;	

DECLARE 
    @database_id int, 
    @database_name sysname, 
    @sql varchar(max);

CREATE TABLE #dependencies(
    referencing_database varchar(max),
    referencing_schema varchar(max),
    referencing_object_name varchar(max),
    referenced_server varchar(max),
    referenced_database varchar(max),
    referenced_schema varchar(max),
    referenced_object_name varchar(max)
);

WHILE (SELECT COUNT(*) FROM #databases) > 0 BEGIN
    SELECT TOP 1 @database_id = database_id, 
                 @database_name = database_name 
    FROM #databases
	

    SET @sql = 'INSERT INTO #dependencies select 
        DB_NAME(' + convert(varchar,@database_id) + '), 
        OBJECT_SCHEMA_NAME(referencing_id,' 
            + convert(varchar,@database_id) +'), 
        OBJECT_NAME(referencing_id,' + convert(varchar,@database_id) + '), 
        referenced_server_name,
        ISNULL(referenced_database_name, db_name(' 
             + convert(varchar,@database_id) + ')),
        referenced_schema_name,
        referenced_entity_name
    FROM ' + quotename(@database_name) + '.sys.sql_expression_dependencies';

    EXEC(@sql);

    DELETE FROM #databases WHERE database_id = @database_id;
END;

SET NOCOUNT OFF;

SELECT * FROM #dependencies where referenced_object_name = @tableName;

drop table #databases,#dependencies
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Chromosome"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_Chromosome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_Chromosome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AspNetUsers (WiNGS_Db_Dev.dbo)"
            Begin Extent = 
               Top = 226
               Left = 1836
               Bottom = 473
               Right = 2221
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "His_Tbl_PhenBook_Individual_HPOs (WiNGS_Db_Dev.dbo)"
            Begin Extent = 
               Top = 54
               Left = 980
               Bottom = 481
               Right = 1255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AspNetUsers_1"
            Begin Extent = 
               Top = 334
               Left = 290
               Bottom = 581
               Right = 675
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "Tbl_HPO"
            Begin Extent = 
               Top = 12
               Left = 76
               Bottom = 225
               Right = 351
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 750
         Width = 750
         Width = 750
         Width = 750
         Width = 2265
         Width = 1710
         Width = 750
         Width = 750
         Width = 750
         Width = 750
         Width = 750
         Width = 750
         Width = 750
         Width = 750
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_His_PhenBook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_His_PhenBook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_His_PhenBook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_OMIM"
            Begin Extent = 
               Top = 140
               Left = 1178
               Bottom = 531
               Right = 1843
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Phenotype_to_Genes"
            Begin Extent = 
               Top = 192
               Left = 555
               Bottom = 439
               Right = 1026
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 750
         Width = 1230
         Width = 750
         Width = 750
         Width = 750
         Width = 750
         Width = 750
         Width = 750
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_HPO_OMIM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_HPO_OMIM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_PhenBook_Individual_HPOs (WiNGS_Db_Dev.dbo)"
            Begin Extent = 
               Top = 50
               Left = 820
               Bottom = 497
               Right = 1727
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_HPO"
            Begin Extent = 
               Top = 12
               Left = 76
               Bottom = 225
               Right = 351
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_Individual_HPOs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_Individual_HPOs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[21] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_PhenBook_Individual_OMIMs (WiNGS_Db_Dev.dbo)"
            Begin Extent = 
               Top = 250
               Left = 898
               Bottom = 525
               Right = 1955
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_OMIM"
            Begin Extent = 
               Top = 12
               Left = 76
               Bottom = 259
               Right = 457
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_Individual_OMIMs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Viw_Individual_OMIMs'
GO
