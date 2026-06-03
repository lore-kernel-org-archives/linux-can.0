Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2B400DE3;
	Wed,  3 Jun 2026 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470849; cv=fail; b=iiCqStTjJQAfA8AJf3eNPY6Fr+qA0NEPPqJDy1Ncm5yUPZq6aQm7DG7FlIGT/sKRQn6ApPghWnL2SvVIBGq+cmaFBRK3oOj47FgGalgDqlEOvWLHmt6DAOskgBrPKXvLrifHINkDTR5lTc3bAA+jJ9zjzsagc3pUDGSvtTqHFw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470849; c=relaxed/simple;
	bh=NjkkmEQvIhu/ukpc3rYoo+G4FDElFzZoJ0lqkJdSKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sCJTWSJke+Dk2rzXeTnuKPitJ1/JgSf8UR124i6PNiCitVx/GrwFnc/FG9tL5CImctQ+uJ/MBr4HjFQhn+sPdYfNM2xd4xTihMO+mGFW1w53HLA2d1s5SiRSKqsxdqhaVxepND8Ct5jLtCY8JEjBT+cxuTMaDCB081Lz8CA6Dyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jyRh3lOa; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jyRh3lOa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgMuco1j6JatuKiGoQDSIV5B2555f2g5/cJOyR/cI8hgj/F1qXVY5Z+t6raVLQjJdQaab9vPa9O0SeFcPefQmKoVWz27NHE5squLpnl+22kHj6zg791mG64UrebJb4pi5dDkgT8ghhpW3/8RXe+li77MZsZdfFAfsfMa0E0dLu/z/Jcy9dC6cdLkxHmpcpZcFRSmxVF/WZzvz7amUAaKrA7LC5t12iYR1YzMs7SqbDXa1f9IETyXpWtRggXRklrMJOINZHjVA6+SH4pxTei5cimkyuNBRUeZA8jW9TtyRy8HHu06uQbmvi5HwZKp3k1Bw0yNhoB6UMCrfc4+qZUMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=gya9EC5ZlcLyjq1ixUeM30/zLTDpwzN/u2qr7cdHw13hiLwg28s7KaNBwDMdYzlxL4x6IJlbfgewcbPM9gUrwhMwdUAUq7nlFrlKWM3G3pZnhmZAg9+y5xwFiCH+N16K3r0rCH+tIbTGgBZLYlvl17rWgfBJp0GN5UcaLhhci+dYxknlHw2fTC1E4fb+PCx7U5aBoXqBDilUgLJUbqPUFAcRd6eShvsOOwYcpvWDConJW02xk2FoCtmSbnO5bPBBHAnhpuY2dmJ/JX9ZFE5rqykSD3EUCNm0EqZPi3CAk0iVYEUe3imd+ej5Fd2NTgWSl1FrpMBcZrvciBC/keDU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=jyRh3lOaTbfVxbx4Tr63g9LP65bMU7YMPGOIvJ8k3BDSRB2GZt8j6EiqooSB90jWRWyWX9VpWHhLo8/BRZ1aF/mCzOITQun0YRGo3uDQwe5UwZlS3vpxU1hQHUySrSnz7wzltghMnAjRzh/nFEp5bo/N3xuJxgDzi7pbNSQhRT6E1OYCWEA2ZCmUSJudyz4wh73ig20y62xM79bvHurnzKQQEgkdF04nHhGLi+BI5Cbn0z7tkGAlz4R4za5yQRzfaJ7hePb0g1ehYS+OJ2ZvQHgeokWXv0rVoFukcgaZueWqsBMTspLZnAemq4qHxRN6g2aEQ6D+y5g9njCJP3rebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:14:02 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:14:02 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH RESEND v4 8/8] arm64: dts: s32n79: enable FlexCAN devices
Date: Wed,  3 Jun 2026 09:13:42 +0200
Message-ID: <20260603071342.641874-9-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: c849be3f-ec43-417b-11f1-08dec13fb04f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 MUxvbKa8l1axHp/TFfiGMc8eNiUTsPhtGduozyhaZRuwmrtIhpjDxVs7m7ZQ+XRHv7atqTb1eszTj3etBvXHcXkfp3jvBSyrwGRTm7n+Ty/bEqgMFKKHlmIjIgeC+eWm9bumLSa/6L0TH1lf8rq1ccTZukRHHnjWY2EQgbHx1LaPzogQ78PNfUP5J/WCIol54S9t3b67HptC7R7ZeIwOMT2t5VIJ399r3isy2sWT+TlM0PIFi72oCAqd7xiX1DWjZpx6uF2V+BJEAJyZK8V1VCZ+8AwedDFnPWP4fqpSTjDYkKKXv73PrLufhkRXIU/VDHkmIRuP/6NXuq0G1pk3cbFnD40RLY4H+xtn33PlrqtBsWQMbJ1pSFSNt2rHbWMMc5TsGskc/TIqBh+XtHKHTG7JgxeivdNQEiAJjuCyjUP+NCdM7sgJtD9oa7rgGErxneGE/Sq/6Rz6Rrdf6O+RvobrMFEYbsH5ai4g2FOPDUFNLKL63EvLfMN0ZWGELN0wZ6dOzdGRRwPZ0opTx95C51fvJ7zWRZvO2qcrv5c8+VaSS6F5kxrApgV4WAeczw8QxiP60a0S/cO+WkLQZHEXkUayd9LsPf+ZLkX1RrBOj0umwMAnnSyecb7oeirBBscljsttpaII2lLKVcVuh7a2yUBu3eHuTN+dfB4HrWwEiY0M1guppGowEK+GUJcCSR7J
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UmY1WmphcVNGNFVZdVlXUzFTMXJYOW5TTFE1TE1YWGJoMDV1ZmhTbVMvM1hB?=
 =?utf-8?B?aHdIQjVwanZNOUVodHhPa05KRURaU09lM0hzckc1V2x3MTJtdmxLZzZuNGMz?=
 =?utf-8?B?L3dJQndxUERTQm5BWWRkRVArcFlLa3dhcmxMYU43endJcDZNVkYyZ0FKS2R2?=
 =?utf-8?B?WEpPNis3ZWRicWNRTU4wWHo4WjR2U0J6UTVhQlMyK01xd2QyRDJROENSQ3Zm?=
 =?utf-8?B?eW9nU0p3cXFHcEIva05KZGFaRG41eEhmYkFIWnV2NmRrY3MyU0hWRUQyZ0Q4?=
 =?utf-8?B?cE01RDN3d2Y2STIvT3JXN25adWN3ZUZoVzJ0a1hlTW94cVg2U2tBNHhWYXRP?=
 =?utf-8?B?VHVVcFlSNzJDODdKSTdwbVBZOVZuSU0vMUNqdUdxSExxTE9VOVZaUW9UQ0pI?=
 =?utf-8?B?Y2hIbnR1Q0JLRFQrVHBveUZOZ1djck5lQjhrZ25xSTM5bitGMGFnTW14REhD?=
 =?utf-8?B?VHhiek1iSXQ5QnR2a2dmMnM3M0hzZk4zTk1aTlloR1ZHbkJjWWl4R1FvMHBp?=
 =?utf-8?B?aGl5MmpSZGcwWVNobTRob0R1N1BhSjBNQ1BSSzFKbnhzOHpvQ0VraUFkd2pS?=
 =?utf-8?B?NHVhNkdjOEVlU3hTNFE0ZHprMTYrRU1CakpDRStKZFRCdWI0SnBqTDVIUTdP?=
 =?utf-8?B?VDUyUW9JbFhZOXZTRXMzSVVwQ2lUQ1Naa0NuNFhUQTZrVlZ2MzVQMklyOWxM?=
 =?utf-8?B?REFEQ1VrcXBQdU5keWxRRWV5Y25mRUpHd3FpcHUxNC9zUnNqam5mdkRuamRm?=
 =?utf-8?B?L1M4NTV0Mjh3TjdZTEluUjVaUHdndXpoNFR1MnM0aWxpT0hqVzVLaThyMWFW?=
 =?utf-8?B?b0RuTUhpVjI0WVpXRFk1K2ozejdDN3l2TlNXUmFpb2dhRi93UFZ1VmlUdmhQ?=
 =?utf-8?B?Y1cwUGxVSm5uc0xyR2tOM3pyTHZOOXkzZ3NLT09WMmltVjdaS1JjdHcrNmdX?=
 =?utf-8?B?NGxDL0s5cWJCRzArMWZXeVpKZVN3YjcwMEN0R3A4U1dtSXBIZStab2NOYUFC?=
 =?utf-8?B?eGtxdTZsTVlMSnByVlJ2WHl5Q0ppbnowSGQydUlVT3dlS1dCWVUyN1hISFNJ?=
 =?utf-8?B?djNHT1h1REhsUW52R3p3RzJkbHRhVU9rQUtRdmtUbXhudy9RejdZaS85anJt?=
 =?utf-8?B?YUdjdytqSnZHSDhCVG1YbW13dVVyRE1oU1Z3cjl3bStrUkttZ0srQmRNWitu?=
 =?utf-8?B?a0hUV0o4Rkwxb1JPUmIzYkpDbXBFNGxqTzhBMUxYWGVOQTNQUUVBRGFMbExU?=
 =?utf-8?B?L3JRNFM0MWFtK1hhUWUxSVdJRU54ZVNwZC9JeGg4MkVmMUM3U3NsMmVPZFI4?=
 =?utf-8?B?U2JMaERVKzFSdkJZeGRFOEc4VThBbGxQcElrY0ptaVF1ck5tNXl1RGZYdytq?=
 =?utf-8?B?NjhkU1RwSFJMWUVGUFJIUnZPV3NDb0x6MDBWbXlId05PS0dtaUtCZTNwUzFV?=
 =?utf-8?B?TkkzTThXMkpNQk9XcmpMc2c2a0Ntakprbm9KVWVhbldITlAxSDFsbnlQak9F?=
 =?utf-8?B?dFRmeitNSFk4d0o2OVdyUmZYa1p1aGR6QU1KU1lXMHVNcXRoTjhyamxFaHMz?=
 =?utf-8?B?QnZZWWhqYUQ2NDRZNmcxTU5tOHJGRzJsM25LZWwyN3JuUHUrY1VNWVBJY2cr?=
 =?utf-8?B?WnIwS29YWlAxcXRQS1Q1NjErZFlMampCL0doc0hrcG9jRzR2OWdTYklVNG11?=
 =?utf-8?B?NTF6NGI2MjF5OXJCeW1tRi9Oc0NoWlRPNWxXbFVvaUp0RUJyWmREZ25vb2Nx?=
 =?utf-8?B?UWR4QlhkNzNxaGdSM1RuMWdlc0lRdThqYW0wM2JRMk5iUmQycW9JNFJoeE9y?=
 =?utf-8?B?dnIweGhlbmU3VC96NmUyWHQ2ZlUwMFFBbGJEUmxuNzQyb25vcjRwZlR4Tmd2?=
 =?utf-8?B?VDAyY2dTbzlKOURoQWYrQTBnU2xpRnY1KzhrTE53dzFPdm9KWWMycUhIWTBs?=
 =?utf-8?B?U0lNSVp1dHlBbzFnTVRGVnhZNHVZeFBWTWgxR0ZxZmFVU05OWTFqaE1vWDRh?=
 =?utf-8?B?U0ZFdTBzQkNsWThSeWlYanVsdkRIUDdkd09RU3pXdEtyd2lDWmZIRDhucmZM?=
 =?utf-8?B?Zk91VThDMUF1ZTBIUWU2MTVNWnN2akFZQ0YweUV2TE84TkRiREo2YldlT3Mv?=
 =?utf-8?B?bWxIT09lcURIZWdTbHpBR3hrS3dmNmZIUjlORXhFNm9jeG5lZVRaOXhNb2NV?=
 =?utf-8?B?K1dRNHlYYisxODhCclMxV2NWOUlTaS9PcjlwM0hTaUw4akJlWDF1OXYxem9C?=
 =?utf-8?B?cVJxc0F2UkFVTVBFejV6TGZVRzYzWmhGeDlQdHM5YjQwSlVieUdlYUIrVFNJ?=
 =?utf-8?B?K1pSeUhYVGVTajkvSzQ3RDVpSFEzZGs1NThTTDByMmVlNTlDdHVBR3RlWGhL?=
 =?utf-8?Q?P6qt6CyKMkp6gLXE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c849be3f-ec43-417b-11f1-08dec13fb04f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:14:01.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjZbwdZhH6tXCMN9BstBAp90v5ilLj9aD9aZ//3SITrdEComh5cHvHToqyIwJeAdHv1TW94chp9YW+r6BNeB2t8+UvYFJ7fXFw3vLjpR3Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Enable FlexCAN controller instances (can0 and can1) and the required RCU
irqsteer interrupt controller on S32N79-RDB board.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
index 1feccd61258e..65a595d7535f 100644
--- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -43,10 +43,22 @@ memory@80000000 {
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &irqsteer_coss {
 	status = "okay";
 };
 
+&irqsteer_rcu {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0

