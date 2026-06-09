Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEC3546F3;
	Tue,  9 Jun 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015417; cv=fail; b=rDuiEkhb0RIz678m2B9FERnJmtwhytHWZUiD+x76BYp/70AHJfiaE3f3eQl1m+tQe8Go6LUrU0nOE/tYv5DOf8vQudXCt/iDeSn5xnBZdf+4cSiIgi/WWVm5hrCTgrcVMZJDJ6vVqryuGtt9fli6RI++1KdaYXDAKZzXJVUtWbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015417; c=relaxed/simple;
	bh=1cyX6uFLtBowZIySNTzBjl+58AVkrt1vkeXAVmhl1aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eug8kTfYFd78Wd482q2WEqp9OveVweODjHVZpmv39SckkoMTVUfcY5TsW45Bse0tN/beOHqIRGcZM1RHU7dOmCBwYZX6N2L6bRKtSGIcHIE/hpf24pdp78YOFuwZCnKoKrY7WYvqL/Y0Y66o6Otf/klcIcE3yrQBWyu9VHdtyt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YKQ84lpJ; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YKQ84lpJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq7kYfrejSQzvWfnvb4jA1QhgOwEsk0b+weck7xLZwooQNyamYW9YkbGS8HpONpZlWt0ixzNc8D0+eVhBghhiQHuE0CsVMdwzdnC6SzXU4CrP8/+NzSo6nS0DLUohKdgcwHExi4tim8BbSy4CR30iLpnp4i3YiGr9W5HZSBunqXKER7LulE7f2NrRjigrj4fn7cWWMRK6RCga3d7b2S6UJIaLSeMp9mr3hTiophDodgWOf15+4ReE41uFcYoXUaz5PVU7Ut0aY7C/NYVvXZ/Dk5Mokx39BKtKywbSufUaVZeUzDyLYkpMW8ZLZizOocJwh1fWONfcykUxkBg1XOEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqcLfsw8F70o3uvk8F1mD6LDuOiCFjNES80/Ep8mRpI=;
 b=ebqYVMKFm3hTNDtSjibW8lIwrjnDkbl2qrzGfGv+h2epRskNZfMJAcnjI1y4D2EDwnqNwyt7ZoDS048mNjIlNMwmtH7FRPq6EyYJwSPn6t+HwKTGJPyLprIh0F8EvdpCZn8mHQ4rfJuXBi9kMQqCvxFC0cH+mqDXa5xi5xqxJGB3PIv850xbFsqDSsp+aYcNr/W8JUuIvh75apd1ZmJY6vhTnPyWwbQmTQoRHFUBfc+VzsrJcFP8B0WC64uLiKN1Sa7KvKoV/YGC27R5oDaT21c8VJiGqQNOux1WFo8qkhvv8P12Oj+8TmL41pUeEDmk0k+5HD15u+IRjvWzSt1lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqcLfsw8F70o3uvk8F1mD6LDuOiCFjNES80/Ep8mRpI=;
 b=YKQ84lpJ//jwPJfwdI3doQnB5GCcq/wKu3hBJVcZdL2aD0y1qckXffUGVoeJsPrIKMFPA1xBUKtlwfjrihfxIUqYsE2bN7cdEaj3lI5yZjtN5psUTKV17wwViT8OdNZgACMRuwUTI88WL0BO8gQZXRlze8XEWI4ROtKkgkgRrIiftCeMXKQ3ciPJfRU79JQmFD/o1LXxvVw43CgcGNgQxVF2bUt1pD6TGdtW5kaVirpDydbCmZn9rNoLsXRRjH0cabsNyHaqI73kBYT7F+tij7VXl9ctLreCrXxKTfnwdWc7nP3EAg6LXS48EUTILeSQ5dqDLiFIuyIW8I7NJ7q5Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:30:07 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:30:07 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 7/8] arm64: dts: s32n79: add FlexCAN nodes
Date: Tue,  9 Jun 2026 16:29:53 +0200
Message-ID: <20260609142954.1807421-8-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b38941-96d2-425f-f1b5-08dec6339a58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 l5unLY5cXoIW1+aWQrJg6fNfI27CUmcsyTzXeUPSQ5PoLF1WqqaTUJuYiPjJORMcGJRhPMXw9ZP1mvvEg97Tn2rIoQrttdDay3c2SKGdz5Vlw4a7GhvcA/G/E6mF/8ePJIIBOwPQkUk0b2gL1KqNjGrmtmFoD24b8eyi5b5/c4c6dssrd/v8dZCN506Tq7gxCR8Gj1MQzUfrQNY8fXpiyDAvwxjtMT4t/oYRRYLC3w6bXBQhoedSHmhMU6BcR6NGfg/dcbHxw/3/YVHjXbSgqddT6jVvyg+bXkH6+W2qanoqntVdBj/I7PSBwa8fZq7OH4yPx7amHGRP6tDk2UIkdBECRymfAHwaB2fbAtSpDx1BTVy6HFlZOqSt0wksIMJKqzJu713iki31e7PwjX4JLi8Pkiet+4/3FxUHjVSwy3wsJZuVWWr8VokMAV55lyDpHLHsSLkxACelDXQqv9LSjg4kALnGOPB7HYf+EVsDUooEMtWVR5cI5hk4CPb/NKA+z9yiiFZa+Cr60XrcDtytqgqmrU4mye0kJlyEQzjBc2Pl5h+HFAqVNAhp7WWogo4qPK7iQCyNmZzFoM4j7d5BpOU1LUiieebavJyTpktXQQDmK5AB2d8BnNOFG0I19F3S2UzSynOod8TsOxFpwthEI3sxVQqAIhR9GpNIJvROvXAZBg6OhYJO6dN/jbNRHqYN
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Zzc2YjgvdUF3VjlobUlCT0NMY1R6MjhCZERvTnoxT3pZdUVZRUh3VVVlWldO?=
 =?utf-8?B?RUtOY1lOODM3eW05bnB1WkFEY3daS0lDb3dxS1U5WjBGK01ycURKdWNDOTZW?=
 =?utf-8?B?eDJPeUFBUHpvSXNZQ2RZcmpJQ1p3SXlXOGowUTRUd3liUEphSXNJeXdPaUxm?=
 =?utf-8?B?Q1diaWx6RkZmclNNaThrVklqUWdoNkR4MkFqOWt0SjVLYTNpZ1JDV1F2eTdO?=
 =?utf-8?B?WHEyM1VuVUlFOVJzVHAyMjRLMlNjbHQ5Mk1aYU94amtOY05JUU9tMW5zVFdt?=
 =?utf-8?B?OVBkcWlXMWxNdnFhU1RkWWFmWDZ4b0syRVpxZ1hrNTV4R1JqamZESnN6TzdP?=
 =?utf-8?B?R3FLdy8wWkNRdSt2dWd4dHV6dk1ZbUNzS01rdHB2NDJaeWtzVm9hQk82bVhK?=
 =?utf-8?B?NElLeENxc2tYdHY0MVN4cXlJUks3bUR2c3RhUzFTT3FtWDUrZHJLN08xUklk?=
 =?utf-8?B?RUVqejFFUzdnWGdPKzNCa3cxTTBOQkNmbk92Q1IxaFlhQ0xPMnJnSC9HSXNY?=
 =?utf-8?B?QWxYQVZqcXNvMjhRYkFzYVdhQ0NFejdmQ3FFa0hLb1UvbmdqMW91UVpQSHIx?=
 =?utf-8?B?a1hoM2xBZytLZGdiaG5vMnJGU1ZYUWN2cHhrYVg5T3BnQnl1eGt1S01ySXJn?=
 =?utf-8?B?VzN1d1piSi9HVmNNZ0x2YkZNdnJjUGMzandIT0pGa2hpVWVZM21EQkIyZGF1?=
 =?utf-8?B?WUFDL3ZIeDRia3k4Nnp3TVlpU0N4R2h3cGRub1c4eUVPb3FHMGp0dFEvdURo?=
 =?utf-8?B?bGlIUURtSkJKWjlMbng1cHRQOTN2V3BrN3IyUXAyVVRZMjhHNjViSWg2V1gy?=
 =?utf-8?B?c0tKVU9pU29jNi9DMUJON2hKcGMwZWhYQmpkZWFNTnhLUzk3SE1sS2tvM0JK?=
 =?utf-8?B?Si83SDcwdWlDLyttYWxYR1RiTDdLWFZGRGc3alJPeFRCS3p3WnNQdloxcGpE?=
 =?utf-8?B?dFErVWw2WnAxN1NLUVk1TE1kYTAvNkZGY2NoMGVKdlRFbmYycVBwS2NURWds?=
 =?utf-8?B?Q2Eyd2N6dDJoaTU5Q0c0bHhuNk1GYUtSRlBpV3VOb1BwUDRjaER5VndRRWR6?=
 =?utf-8?B?WlFpcXYxNmRyZmlIYnVLd050MDcyYmNGbDNBenovQ0dnd0FTMVoyb2E0c1VO?=
 =?utf-8?B?UjkxaUg3MnIzMWwzYk4rcmppMmdtdWZSQzlBVncwTlFraUtPVjRTazVNU0lr?=
 =?utf-8?B?cVkzWWJBWHpoRFV3V2VxRm5uVlJ3dGxwS2RwT3JPVWFETkZFanREU1Q1Yitn?=
 =?utf-8?B?L2RWNDlhQUFQdzRDYktVL2xVOElLZy9QdWQ5cjBSOVk1eUVYc3RLQmtCaVZZ?=
 =?utf-8?B?aGJoUVRtbVo0cXI4bUk0bVNpWWhUQm0xZis3V0pmSWtWcUw2aHFFcGE5ZmhG?=
 =?utf-8?B?NU1LNWV1cVFvSGNXZERHNWJEM2hkdW0xRHJybHc3SVVKSnFvc0VYUVR5K2cv?=
 =?utf-8?B?RHJZZmtHUXZkTmtic0pxK01Hd3NVNndySEszd1h5akNVUFFOWUswMVowU2ZD?=
 =?utf-8?B?TWttSnVDZzN0VjJSMk13amJtbXlaQXZKMyszdW5IUVhvOUtmaG1HM1lpRytX?=
 =?utf-8?B?K3d6UzJJT25ydUp6bGczVmw0NmQzRGcxdzJNRTM3bE9xeFhGemdBSFNlaDJm?=
 =?utf-8?B?Tkc1WXBVdVpmWXVrRXdMaEtRQmxQU2o5cms3NnpnbDlnNE5QcHBGSnduMlVw?=
 =?utf-8?B?K1JlSldKK1JNVEZ5bndlT2xFbnl6SFRxdlBia1pKbDBPVmNqTWUvWWVORm1k?=
 =?utf-8?B?RHYyb0NKUHhKRXN1QnJKZnJMaHFndXR0RUhNZDdOa2pHbE5qT1VsakNnWG1t?=
 =?utf-8?B?UGlhOHZvZ2NGemVIUGFGRnZ0cjNVNkFhQ2VIck9tOFA4bE96TTNQa2tDSHM4?=
 =?utf-8?B?eVZHSXBKc1gxdjgwMTd1Yy9yZkdNeEFNeVdDZmt0eUJrV1Jxdytrd2xkWU1Q?=
 =?utf-8?B?MnE4ZitkWS8rY0h5K1NGMjJMV1BpaTdsTnhoREc4TjBxTm9IaXlUV2p3VExZ?=
 =?utf-8?B?UlFoUEQwTExiVjhNYXdrbjhMV01iWVBJTU1FNVpEcXFhaVM0QUJZWldUSldU?=
 =?utf-8?B?S3VsR1NVc2F3RHBJRWpicGJGa2lZVjR1SUhhYUdBM3lNQUdXQW0zTXN4eVY0?=
 =?utf-8?B?bmF1SkloK2tnbm9oTSsyTFkvem5SMzdRODYxV21tbnQ3QUhJZU4xbmhkVGZm?=
 =?utf-8?B?Y3JLZlduek1ianl4dUZ5bjdkRjZvN3RCV3RCc0lVQ0JNSnp6VDZzOEZXMHJq?=
 =?utf-8?B?aGErTFRqOG5UcGVjLzdBTm15Q3dLZHNvVWVSamsyZWlPYWdrZFNhajQ4Z0R2?=
 =?utf-8?B?VUJMMlBWOCttWW5sSHpNb3hodmxHMWZrQW90QnlQSVpkOEM3N2YyU29odG91?=
 =?utf-8?Q?uiGstDCcYgkzHHi8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b38941-96d2-425f-f1b5-08dec6339a58
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:30:06.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHShwN/UZDL31KtAbtX+CiIwGk+UgJmD/COKZ2joA8HIM9AuXaCO3F71kejYnP8olgBmEASPUQRfkQAvgu5e086PGggTqjZzXQGF3T7tSS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The S32N79 integrates multiple FlexCAN instances connected through the RCU
irqsteer interrupt controller.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..c1a4fdead91d 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -352,6 +352,56 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rcu-bus {
+		compatible = "simple-bus";
+		ranges = <0x54000000 0x0 0x54000000 0x4000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		irqsteer_rcu: interrupt-controller@55101000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x55101000 0x1000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0xf9>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+
+		can0: can@55b60000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b60000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <0>, <64>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@55b70000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b70000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <1>, <65>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0

