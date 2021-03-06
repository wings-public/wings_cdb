USE [WiNGS_Data_Db]
GO
/****** Object:  Table [dbo].[__Sys_tmp_Sample_Trio]    Script Date: 5/12/2022 11:29:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__Sys_tmp_Sample_Trio](
	[CHR] [varchar](2) NOT NULL,
	[START] [bigint] NOT NULL,
	[END] [bigint] NOT NULL,
	[REF] [varchar](300) NOT NULL,
	[ALT] [varchar](300) NOT NULL,
	[InWhichOneExists] [varchar](3) NULL,
	[Proband] [bigint] NOT NULL,
	[Control_1] [bigint] NOT NULL,
	[Control_2] [bigint] NOT NULL,
 CONSTRAINT [PK___Sys_tmp_Sample_Trio] PRIMARY KEY CLUSTERED 
(
	[CHR] ASC,
	[START] ASC,
	[END] ASC,
	[REF] ASC,
	[ALT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__Sys_tmp_Sample_Trio_ACMG]    Script Date: 5/12/2022 11:29:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__Sys_tmp_Sample_Trio_ACMG](
	[SampleID] [bigint] NOT NULL,
	[rowid] [int] NOT NULL,
	[CHROM] [varchar](2) NOT NULL,
	[START] [bigint] NOT NULL,
	[STOP] [bigint] NOT NULL,
	[REF] [varchar](300) NOT NULL,
	[ALT] [varchar](300) NOT NULL,
	[PRIOR_TRANSCRIPT] [varchar](max) NULL,
	[HGVS_P] [varchar](max) NULL,
	[HGVP_C] [varchar](max) NULL,
	[IS_CANONICAL] [varchar](max) NULL,
	[OTHER_TRANSCRIPT_HGVS] [varchar](max) NULL,
	[GENOTYPE] [varchar](max) NULL,
	[GENE] [varchar](max) NULL,
	[PHENOTYPE] [varchar](max) NULL,
	[MEDGEN_CUI] [varchar](max) NULL,
	[INHERITANCE] [varchar](max) NULL,
	[FINAL_CLASSIFICATION] [varchar](max) NULL,
	[SCORE_OF_PATHOGENICITY] [float] NULL,
	[FLAG] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[PVS1] [varchar](max) NULL,
	[PS1] [varchar](max) NULL,
	[PS2] [varchar](max) NULL,
	[PS3] [varchar](max) NULL,
	[PS4] [varchar](max) NULL,
	[PM1] [varchar](max) NULL,
	[PM2] [varchar](max) NULL,
	[PM3] [varchar](max) NULL,
	[PM4] [varchar](max) NULL,
	[PM5] [varchar](max) NULL,
	[PM6] [varchar](max) NULL,
	[PP1] [varchar](max) NULL,
	[PP2] [varchar](max) NULL,
	[PP3] [varchar](max) NULL,
	[PP4] [varchar](max) NULL,
	[PP5] [varchar](max) NULL,
	[BA1] [varchar](max) NULL,
	[BS1] [varchar](max) NULL,
	[BS2] [varchar](max) NULL,
	[BS3] [varchar](max) NULL,
	[BS4] [varchar](max) NULL,
	[BP1] [varchar](max) NULL,
	[BP2] [varchar](max) NULL,
	[BP3] [varchar](max) NULL,
	[BP4] [varchar](max) NULL,
	[BP5] [varchar](max) NULL,
	[BP6] [varchar](max) NULL,
	[BP7] [varchar](max) NULL,
	[BP8] [varchar](max) NULL,
 CONSTRAINT [PK___Sys_tmp_Sample_Trio_ACMG] PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC,
	[rowid] ASC,
	[CHROM] ASC,
	[START] ASC,
	[STOP] ASC,
	[REF] ASC,
	[ALT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__Sys_tmp_Sample_Trio_Annotation]    Script Date: 5/12/2022 11:29:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__Sys_tmp_Sample_Trio_Annotation](
	[SampleID] [bigint] NOT NULL,
	[CHR] [varchar](2) NOT NULL,
	[START] [bigint] NOT NULL,
	[END] [bigint] NOT NULL,
	[REF] [varchar](300) NOT NULL,
	[ALT] [varchar](300) NOT NULL,
	[EFFECT] [varchar](max) NULL,
	[GENE] [varchar](max) NULL,
	[ENS_GENE] [varchar](max) NULL,
	[ENS_TRANSCRIPT] [varchar](max) NULL,
	[ENS_CANONICAL_TRANSCRIPT] [varchar](max) NULL,
	[RefSeq_map] [varchar](max) NULL,
	[SEQUENCE_FEATURES] [varchar](max) NULL,
	[TFBS_Id] [varchar](max) NULL,
	[TFBS_name] [varchar](max) NULL,
	[EXON_INTRON_NUM] [int] NULL,
	[HGVS_C] [varchar](max) NULL,
	[HGVS_P] [varchar](max) NULL,
	[CDS_DISTANCE] [float] NULL,
	[CDS_LEN] [float] NULL,
	[AA_LEN] [float] NULL,
	[OTHER_TRANSCRIPTS] [varchar](max) NULL,
	[ExAC_AN] [float] NULL,
	[ExAC_AC] [float] NULL,
	[ExAC_AF] [float] NULL,
	[ExAC_isTarget] [varchar](max) NULL,
	[DBSNP] [varchar](max) NULL,
	[DBSNP_VERSION] [varchar](max) NULL,
	[DBSNP_1TGP_REF_freq] [float] NULL,
	[DBSNP_1TGP_ALT_freq] [float] NULL,
	[COMMON_1TGP_1perc] [varchar](max) NULL,
	[ESP_EA_freq] [float] NULL,
	[ESP_AA_freq] [float] NULL,
	[ESP_All_freq] [float] NULL,
	[gnomAD_AF_ALL] [float] NULL,
	[gnomAD_Hom_ALL] [float] NULL,
	[gnomAD_AF_Male] [float] NULL,
	[gnomAD_Hom_Male] [float] NULL,
	[gnomAD_AF_Female] [float] NULL,
	[gnomAD_Hom_Female] [float] NULL,
	[gnomAD_AF_NFE] [float] NULL,
	[gnomAD_Hom_NFE] [float] NULL,
	[gnomAD_AF_AFR] [float] NULL,
	[gnomAD_Hom_AFR] [float] NULL,
	[gnomAD_AF_AMR] [float] NULL,
	[gnomAD_Hom_AMR] [float] NULL,
	[gnomAD_AF_EAS] [float] NULL,
	[gnomAD_Hom_EAS] [float] NULL,
	[gnomAD_AF_SAS] [float] NULL,
	[gnomAD_Hom_SAS] [float] NULL,
	[gnomAD_AF_ASJ] [float] NULL,
	[gnomAD_Hom_ASJ] [float] NULL,
	[gnomAD_AF_FIN] [float] NULL,
	[gnomAD_Hom_FIN] [float] NULL,
	[gnomAD_AF_OTH] [float] NULL,
	[gnomAD_Hom_OTH] [float] NULL,
	[DANN_score] [float] NULL,
	[dbscSNV_AB_score] [float] NULL,
	[dbscSNV_RF_score] [float] NULL,
	[PaPI_pred] [varchar](max) NULL,
	[PaPI_score] [float] NULL,
	[PolyPhen_2_pred] [varchar](max) NULL,
	[PolyPhen_2_score] [float] NULL,
	[SIFT_pred] [varchar](max) NULL,
	[SIFT_score] [float] NULL,
	[PseeAC_RF_pred] [varchar](max) NULL,
	[PseeAC_RF_score] [float] NULL,
	[ClinVar_hotSpot] [varchar](max) NULL,
	[ClinVar_RCV] [varchar](max) NULL,
	[ClinVar_clinical_significance] [varchar](max) NULL,
	[ClinVar_rev_status] [varchar](max) NULL,
	[ClinVar_traits] [varchar](max) NULL,
	[ClinVar_PMIDS] [varchar](max) NULL,
	[Disease] [varchar](max) NULL,
	[GENO] [varchar](max) NOT NULL,
	[QUAL] [float] NOT NULL,
	[GENO_QUAL] [float] NOT NULL,
	[FILTER] [varchar](max) NOT NULL,
	[AF] [float] NOT NULL,
	[AO] [float] NOT NULL,
	[RO] [float] NOT NULL,
	[COV] [float] NOT NULL,
 CONSTRAINT [PK___Sys_tmp_Sample_Trio_Annotation] PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC,
	[CHR] ASC,
	[START] ASC,
	[END] ASC,
	[REF] ASC,
	[ALT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__Sys_tmp_Trio_Variant]    Script Date: 5/12/2022 11:29:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__Sys_tmp_Trio_Variant](
	[var_validate] [int] NULL,
	[var_key] [nvarchar](max) NULL,
	[v_type] [nvarchar](max) NULL,
	[non_variant] [nvarchar](max) NULL,
	[vcf_chr] [nvarchar](max) NULL,
	[chr] [int] NULL,
	[start_pos] [bigint] NULL,
	[stop_pos] [bigint] NULL,
	[ref_all] [nvarchar](max) NULL,
	[alt_all] [nvarchar](max) NULL,
	[multi_allelic] [nvarchar](max) NULL,
	[phred_polymorphism] [nvarchar](max) NULL,
	[filter] [nvarchar](max) NULL,
	[alt_cnt] [nvarchar](max) NULL,
	[ref_depth] [nvarchar](max) NULL,
	[alt_depth] [nvarchar](max) NULL,
	[phred_genotype] [nvarchar](max) NULL,
	[mapping_quality] [nvarchar](max) NULL,
	[base_q_ranksum] [nvarchar](max) NULL,
	[mapping_q_ranksum] [nvarchar](max) NULL,
	[read_pos_ranksum] [nvarchar](max) NULL,
	[strand_bias] [nvarchar](max) NULL,
	[quality_by_depth] [nvarchar](max) NULL,
	[fisher_strand] [nvarchar](max) NULL,
	[vqslod] [nvarchar](max) NULL,
	[gt_ratio] [nvarchar](max) NULL,
	[ploidy] [nvarchar](max) NULL,
	[somatic_state] [nvarchar](max) NULL,
	[delta_pl] [nvarchar](max) NULL,
	[stretch_lt_a] [nvarchar](max) NULL,
	[stretch_lt_b] [nvarchar](max) NULL,
	[gene_annotations] [nvarchar](max) NULL,
	[gnomAD] [nvarchar](max) NULL,
	[CLNSIG] [nvarchar](max) NULL,
	[GENEINFO] [nvarchar](max) NULL,
	[phred_score] [nvarchar](max) NULL,
	[trio_code] [nvarchar](3) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__Sys_tmp_Variant]    Script Date: 5/12/2022 11:29:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__Sys_tmp_Variant](
	[_id] [nvarchar](max) NULL,
	[FileID] [bigint] NULL,
	[v_type] [nvarchar](max) NULL,
	[non_variant] [nvarchar](max) NULL,
	[vcf_chr] [nvarchar](max) NULL,
	[chr] [int] NULL,
	[start_pos] [bigint] NULL,
	[stop_pos] [bigint] NULL,
	[ref_all] [nvarchar](max) NULL,
	[alt_all] [nvarchar](max) NULL,
	[multi_allelic] [nvarchar](max) NULL,
	[phred_polymorphism] [nvarchar](max) NULL,
	[filter] [nvarchar](max) NULL,
	[alt_cnt] [nvarchar](max) NULL,
	[ref_depth] [nvarchar](max) NULL,
	[alt_depth] [nvarchar](max) NULL,
	[phred_genotype] [nvarchar](max) NULL,
	[mapping_quality] [nvarchar](max) NULL,
	[base_q_ranksum] [nvarchar](max) NULL,
	[mapping_q_ranksum] [nvarchar](max) NULL,
	[read_pos_ranksum] [nvarchar](max) NULL,
	[strand_bias] [nvarchar](max) NULL,
	[quality_by_depth] [nvarchar](max) NULL,
	[fisher_strand] [nvarchar](max) NULL,
	[vqslod] [nvarchar](max) NULL,
	[gt_ratio] [nvarchar](max) NULL,
	[ploidy] [nvarchar](max) NULL,
	[somatic_state] [nvarchar](max) NULL,
	[delta_pl] [nvarchar](max) NULL,
	[stretch_lt_a] [nvarchar](max) NULL,
	[stretch_lt_b] [nvarchar](max) NULL,
	[gene_annotations] [nvarchar](max) NULL,
	[gnomAD] [nvarchar](max) NULL,
	[CLNSIG] [nvarchar](max) NULL,
	[GENEINFO] [nvarchar](max) NULL,
	[phred_score] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__Sys_tmp_VariantDiscovery_Public_Variant]    Script Date: 5/12/2022 11:29:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__Sys_tmp_VariantDiscovery_Public_Variant](
	[FileID] [bigint] NULL,
	[var_key] [nvarchar](max) NULL,
	[v_type] [nvarchar](max) NULL,
	[non_variant] [nvarchar](max) NULL,
	[vcf_chr] [nvarchar](max) NULL,
	[chr] [int] NULL,
	[start_pos] [bigint] NULL,
	[stop_pos] [bigint] NULL,
	[ref_all] [nvarchar](max) NULL,
	[alt_all] [nvarchar](max) NULL,
	[gene_annotations] [nvarchar](max) NULL,
	[gnomAD] [nvarchar](max) NULL,
	[CLNSIG] [nvarchar](max) NULL,
	[GENEINFO] [nvarchar](max) NULL,
	[phred_score] [nvarchar](max) NULL,
	[result_type] [nvarchar](50) NULL,
	[ReferenceBuild] [nvarchar](20) NULL,
	[CenterID] [int] NULL,
	[HostID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
