Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D814582F3;
	Fri, 14 Aug 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698231; cv=fail; b=JCXpZpImyoCp+/1CPj1dQEUHpjeoJjYA5uEzlP2e1zFuqpA9zMIMinTXPhbg1diGx1WVnAy17gKiimzwpYtisNnbKBFBjtXmSh/ImIlAtNHOl0aShVjDmVMNwTUsJZ9EeJtLzX59jhCw3ipxc0pu1ZWAyvpFqEjIZfrNV0KYag0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698231; c=relaxed/simple;
	bh=9ygVd/9wOYBvYuQKxlnmXiqG0N3u51+iaQgO8LhlNIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iHisWCC/nYg008ut7L2+rIB6EY+posvIqMlIVBKq4nElhuUuZlM9+PvUfohlk5D25QklEB1mG0awJSJi90UJB1k4DbOmEnRotvPK2G3yxw5Y6aowb7oBCuAtEx0f/NkBDgqJRtHr9hb/PjPYjGlenUPpqq03Envcfv5y+YQJvtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cPq37kds; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cPq37kds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONDDI79pDBFZtsVBIBQ9z5pwAxgCZNM+T5eJnwUhThTBPT8EYvpJEQ7m9G2xoVkFZUMd1Z5OJmHOkcpvzKFai0KqDFeftkQLSNxk3MAb14gEKLnSDDHoxQhqqecYvYpn0U1kcH87n+Szg/RG3kPLARL4gNzUOHTXX+6c36cLCa6GB5pyomBU+x6Y3QNxk0QKsZEUnyJS9TApJAmt3L9QySJ6gZj/26eaoBPlc5OnC4Bw/b+1E2j9+lNiNwIcivNw4OB3zOymWF3oukx+lkdE44wB9rzYIZ2W2yS107uw8ovzMZI6RxFV6krShHxSYCowSp86BCJUAc46plEDi0W2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BICuwCHVHi03s3I2/r7mErJ4O70LPSuo2IX7EewVGyE=;
 b=s5DM/UGNCRVsEtsXBmHCga9c5yiIO/uggHEXYJvyM4NYpslT+PW5zujlq33Xgv8E6Gg3kzF/cnv9VLdhJtTbXgnjFncAvD7I3QIFsdpVR/g1NXQH5a7E2sEC7vB5XvlnGnxzc4rBmoe7kZgPosi7YtwJIEVY71UYsXn9PwWz3ZjFFOzxapvCJofi23TaAaLjbtUUWjKnhRqYLAqcm3dUcJPzauQaIZfGO7e8lUbP1NHKbr3ON+sXWkLZ3Psag6UT+iUFO/w4cUyVkR9N7/sXT87xYvWPbz8YYWl/7x9SQJa93SbB9aYeilLEw5138I+cv1kPqjYdl4xWeZTDWsdarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BICuwCHVHi03s3I2/r7mErJ4O70LPSuo2IX7EewVGyE=;
 b=cPq37kdsCEgPxH/OTx8MLy70wwKXR6QXD8xps4rWPIZH6yiGL613tnQR1S6pQsapuh+mNXRhNz9LpWrTsYPeLrM5WRdsJur21PBWxCt3j1TUwUgZQxbuZ5IWoCU4EtJ8kyaiiEbfXEuF/JDLCyQutCaVq97aT7beBbt6UfPjwgpQJ/PVxtRsX1ltcFAcPUmCyJouAGeJtl05sPXWgN3YX+IIlmJ/q2iLT3vWyMgN0Mcus/DV0YCK+CIhPESXOntAq1TdLIHf83lPnoOcqZ3eLI1AsLNU8gPU/ikLi1XQtYE8AuKfnXNnA2a9mw2uDeQzP8KQbszFaqXM2fWnn8zzcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AMBPR04MB963705.eurprd04.prod.outlook.com (2603:10a6:20b:75d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 09:03:41 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 09:03:41 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [RESEND PATCH v6 6/6] can: flexcan: add NXP S32N79 SoC support
Date: Fri, 14 Aug 2026 11:03:23 +0200
Message-ID: <20260814090324.647898-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AMBPR04MB963705:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9151d9-92ea-4ec3-068e-08def9e2ef84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 +efTMXY4BGmfbMbANHt89haVNsA677KuICfBHySVmWBnkggffADj2AUbP7qZEElV4g5i+pnpnWpok4fUPnBnd47DbT8sZdT62clF4B3B9S1ZmGUdHrGoXncbHactCv1FPHufHiS3XaYiqRqsFVyqdC9KC98AuDwyOprZkzRMJpB2WA7ccjAslhQKfK4kqfrbUNa3pElIMFG/D5VVqUccmSCwlvuZyTdhO4/awpEHsb/LxjC9JWazyRwmUBQRJWYIT0cc0qMhfgble8M/mNzIclXGu764ckIOs5rUSY+apyl7seyt9dFgaxN889KWOhl7FjI6GLONxanpaYLeb/HY4Ovnn5DD5JouLirQyKKHfDuQPIuLoxTwJy0vsCH7kdtAJIx44jnSq2TQnIRddF1mYKCQMbkB1N3svl7RunZicfQGzuXVgi7ATPlujsEsbuaJ9pGtA5CM1glPqYC4wL1Z5i5Af7UmJVjLjgJcciU/t3L4tdpcN9Rqlu6W7GuVCNVodKtdISKJq1kbgpKddu+WTQh3tfUXemqPX3hf8D6wm0kVT9aD90nFrT9+MKXszaQED7NWKFYa7C6fQ9dfgt9ZdI7ZdAy3pMtgHKsnDrMj4gTEYy19cqI2jQRA8a/UQrFGXnOaw8Nq0T6T1nh7+NwbcItmFqA4mHAON75ynrgNpuc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VnJJemJrZDMwVXA3S0YvaUtDd0diMWNIYW9ZeDJrTnl0TVNwankxUXJFcElI?=
 =?utf-8?B?S01rVWxka2lqamQyYThnQ05Qc0pRdjRTM3JNWnBXQ3hmMEdPYmxUWGIyZldE?=
 =?utf-8?B?T1NReXFBdkd3elJmWlNNZDk5TEszWDVLNXFldjVNb2VXdGlRaDV6Rk53L2Nl?=
 =?utf-8?B?dnprNW9QUTdlYlJ6b2tROVVpb2JWeGJwTUozRGNPUVZheVN4b20xVGE0UmpS?=
 =?utf-8?B?cjhPMnJTc2FTazRSOVN1ZkZpd2VwcitHT3Vkd0RYejN3VzNoTGlCd3hpU1ox?=
 =?utf-8?B?MVE2dGt0clkzUVZjY1N5RFlYNUZqTzJGS0VaMlFjZTNEV1I2RU96UEkvcXk1?=
 =?utf-8?B?UHFrcmoyMEh0ZDI0RGhtWnFNQlFPOEdlLytOalBtUmNQbmhYcnRrcm4zTXJn?=
 =?utf-8?B?YzJHbGIyd1VCazg2cVJ1MlFVaFpZQU5waXRKVkI3RU4xUlVSKytOcm8vZXB4?=
 =?utf-8?B?Wm44Vzk0SXVyRkNsWlpySXVmSHZjNW5nTlFUbmQ3TWZmTU9FdDNjMzZXY1F3?=
 =?utf-8?B?YkFkS1A3Zlo1Rll2N1lxNzU2Y2pjNldsT1BEOHYwWGdZVWNTWnZ2N1p4dFVS?=
 =?utf-8?B?SHJaL0YxSnVMMFNmT1VqemhiQ0JreTRPdzZvZG1hSWVQSUpMZ1J0Y1lnTnZk?=
 =?utf-8?B?TGNEdGljRWM0Sml5ZzFVQXNmOEphSVYyL3RXUzYwclhRUG5XcVNWY3BDV0tj?=
 =?utf-8?B?amlmSHJBSVF4VHJBbUlya1ZzYUd2eUMxWDBRSW5iR3NjSllEdU5FdmIrZ2dn?=
 =?utf-8?B?TEJtTWE4Vk9kNEZYRjdRNHNGWXJQZ3dDNnlOOWdiU0VEdk9wRjYxVVhNTzFj?=
 =?utf-8?B?eUtTTldYWU4vV2o0UWVyTEtXZ2RTTllZRzNTWVJrMlV3QkMyTkFoTDdMdENv?=
 =?utf-8?B?QTZwdzd4TmRVT0tZL1FTdzY5SmRJSXgvVTMwNE9WYUE3QTEzaW1MR0dOSTNs?=
 =?utf-8?B?T2IyQTR5RGZzdklJRnVJNk9OQUFEekV0QU9zYWhHVTg5Qkk2RTZJRGs3NXdp?=
 =?utf-8?B?V2VycHRqeUVhaFp1VHNSbGQrK3hEZXNzNGtnbkwyY3Q1anJPMitTaG5WUVp0?=
 =?utf-8?B?MlpSeWpqQ2ljdS9SQ2xGWmtWNGU3RFZnZTl4OTVCY1k3UDRSQ0NneVJNRTRV?=
 =?utf-8?B?WDBLMTIyZ3U1NUtDVVQ3ZlBYSCs3RDExQ011VU9qbldEZjJMeVlvMHF2QlEy?=
 =?utf-8?B?YVZGYmNZUjhVbWt5eXdvNjRBRVpxNWJjZEs2bkloS3k5Smo3UGtHQTVUb05C?=
 =?utf-8?B?aVhML0pYcDlBYkxsRjN5SnpOVmxJVEFWRUhwMHE0eVF1ZkRmanBsUEl5T1RD?=
 =?utf-8?B?RWgrTHBablNURWtxM2N0WTh5Rm02STd3VEY5dVlvbUc3ZlRTbVBrblpuUEt6?=
 =?utf-8?B?L2FxajAyRm5ENEJIVEVnWlZzRFFOaGdNNWxHbDYvUFhNQ2Mwa3ZuTVA0Wndz?=
 =?utf-8?B?QXJ3OVF3TGVLd3RBSTd0WGFMUnU5c2QzMGpHandweUQyL1FGOENWYVg0dm0x?=
 =?utf-8?B?MDFodDA0RDhDem1lWlR5cUtvQVBjMlI4QUYzQk5DaFV2c0xJVjBLRmxjQUlo?=
 =?utf-8?B?S3lRWERUdjJ1S1pkQjdPRnJhY2xnYmZuMUpXUkFSVnJ1bkdWNGlxWTdzL0xM?=
 =?utf-8?B?RUpEYWZYMHZYQXNjOGZrT1EzdnJ1UzdyK2Z2RWdacnMzMEtLUHZCMDFuNWlB?=
 =?utf-8?B?NmhqL0JyaVpWbUpNd2NGcHBrU0dxRTFuT2tLWVJROTZ3Z1lqcUtmSFF4T1hX?=
 =?utf-8?B?UkxnbG91bytkWFBBQ0paV0pJNWZYZTZMOUVsRUN2TEZ2eEhSMW9xN2FaaDVt?=
 =?utf-8?B?ZE9DVkQ4eGZseGE3TlVEakREV1YrUHNNR2ZxazF2S1pSMHhkUDNTQ3NEeC9H?=
 =?utf-8?B?bldQM0pSME5XenA2bHNqUUc4VTZ2S1Jjd05FRlVFSTlkOURxMlVmNGljT0M4?=
 =?utf-8?B?NkQ3Z0d4UFBtdFZ2a1dSR3AyRk1LUk1Gd3NqZGJaLzZSSm5vbWU4YWhkNFFH?=
 =?utf-8?B?MC9QV1d0aGhqZlUwWVlXM2ZmcXRBTjlZLy9zY0RJaUdZSVV1R3kyNjBuUStS?=
 =?utf-8?B?YmVaOWMyMkRlWVRIMzNDUzFoVmpJd2p5YVhwMlBlUTdtWEZpcXY1NFpGeVBp?=
 =?utf-8?B?dHNnNytsWlN3NHYwZTB3bTNxdFlDY0NmUG1WZzhVODZzeElwelBHZWZ0NnJ5?=
 =?utf-8?B?ZUk2NjR2eUgrN2xyUit3dUVBOVJDNnFxQkgxa3BFYzE4a0szQkdZaXlvaHFR?=
 =?utf-8?B?MWxxc3AxNytGQW9YSjNtSndlOUo3bndIbDVvNnRSd1ZONVlyUHA1V0hNcFpz?=
 =?utf-8?B?b3FJbGFCSjRSUEtMTjJrRkhkV0JEVStoNTJkeW5mYlF4Q1dOY1hveXBJdmdx?=
 =?utf-8?Q?VtSNAreIRhOUXT7g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9151d9-92ea-4ec3-068e-08def9e2ef84
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:03:41.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S41xQt0V+SpYpS255el+nJcwe3LCBOWTNiiEMvyzYRmCYndOauAb1on/MBcI/BaFR8MTSbGbbE53CKzdZNnSz0RAYAYrF7jKn03j5u4YOlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB963705

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for mailboxes 0-127
- one for signaling bus errors and device state changes

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index e7e3fb41f55e..54279b91cf5e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -403,6 +403,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_IRQ_BERR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2222,6 +2231,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0

