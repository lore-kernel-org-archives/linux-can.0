Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F84EBAE8;
	Mon, 31 Aug 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186908; cv=fail; b=NUhUnDZVyMLgDpKPzVw+hdyaT70OvXIPiyAUzbMpPRzaIE9W05btC7oZVCr+dwIgkQSOtDVnlFe+s4cJIGOAFnTXWQSY1SoKEG28+mCNYyXrMDHZdAWDSQoKh30K5hfPSmtlg+i/eGh6QJlj4nagMN4JUigaXL/92e+u3zH3tTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186908; c=relaxed/simple;
	bh=DKVNyMhcGaZwqbUU6Zeg3cD6LOr37WFHlNqZVEwKX/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tu0/P08OgV3hPU2Z0z70RfHGRoHCtXIC6I+pRHk1d8oViwUDzVcEjmgvucofZimrdxuoCgIf4a96Dyxr8qgryljVOSIhs/w5SYamINjueLIoI73VqXMQ85KZtj6oIlAZfA4JszPIzy6cAulErAuNHHuyZQLT8r10D8rKhznTdTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OiFbnvFn; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OiFbnvFn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d882wR7U5E22GrN77a9YPMsgLHAg1oDrPKm6PUtVjTl5nxxHOXSq4fh6zeZCxt5CQiQKugIirqqfZdRd4r3aaHof6HT18lruEsA4j7eyTt+hUpr14CorrLr5FtsWEUVW9PHsL+sg05/CcGJMlxROdenmx63jwdbuZjdERlIjtQWIeItcIyF9Jq87MZZH9sYIrh5AGPdi4mfUhkA6v3CR2pSWJcI88d1Q2cwLghYkH5aeeNj529B8RjfnuidP6q/FSQZaPkxhEk1sMH3lftQP21R9z2SCU78V6ayjxEmZtv8qoek8X06Kgl/LjS3A6ZnoRwfzqVG3bzvpJNRpk7jrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYD3+F0uERBlL+FwhIv90oSAF08EjMt7o73FpJQsUwo=;
 b=P8j6hCZ/7HmOO9oGpKfmiqJ+NwTPBTgYVLVUSHMgPJ/VuVLFtf0FHSa0KEFgpfHeT5XTd362fVY7tBwLcsuaD6TrV1AqR+YGA5klpoOyTXQ3d2tOtvLCZf2GTMiGic1c9HGo+pDmaNFFsxMHKnAZYz6h7mSW0y3J/JPtJM0HIRwKUgDcCC8ApM9eoYjwAmEf2c8dlbu3rjT3trgYIlN3GpNT8HGijmeZzWEfl9nu8aP86eCc2uKgX5KycU3ke+U8DwKWP0mZpdPutR4H7AokOJ78ZTIus44CLG+scuMTmNaiSlplWm2UmLgX5HB9k/Bo0yv3z+oSG6vF7YvWeGCRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYD3+F0uERBlL+FwhIv90oSAF08EjMt7o73FpJQsUwo=;
 b=OiFbnvFn1XrIQ0b1skDW9ksFQgzER3hgLuX0ljNaeDUUJYDO9jP+aKY+d/3lnSsQ6vPCRlsqAeGY+fY0bDFHErZGbT7CnI70IeDDExBobG7/nMLTrsz8drqvL3CUNDgTzQ1rBYw2zj9KpadtKnQgu+XGCFQwFWCn6O8V0pRL/zzTvDDGeZKpJ9yoFQRRHE5ZOY1BWRI49Yl5Q39xuE43hEefZggBS66m4m30wH2kbbaY/D0MhgZ/mjquBP2BoNNfDA2331mAlhlmJjl2FoQ4tO2BQlvQP0bZWc3OPpfsizAhDI6Ij1/1+kyPuwxP5ueThiRMFk8iGgr5/GfqyN9U6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:34:58 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:34:58 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>,
	Frank Li <Frank.Li@nxp.com>
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
Subject: [PATCH v7 6/6] can: flexcan: add NXP S32N79 SoC support
Date: Mon, 31 Aug 2026 16:34:49 +0200
Message-ID: <20260831143449.12828-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a99f61-3aa5-4ac2-b249-08df076d0866
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 8myZN/Wg3yjnmqCoBpT4vVsBgGAoNg6jUfd6ilY/5VP6290YLntXobSZzBVORfDx0mQvARJHXsZwVvL4j9/KDoz4xQ4jo+sTYR3bIjlyYen3VK2Wk7w/a0NuoJvsJ4K+WqdysfudwydqK2qr8CJosM6L66eCN0SP98SG4TWTijnAFXjVZiTpBEA4NnXOPw95ASLYrHcAL2GZrlrcH64tRDCRdqrflIlyk/hAHXNFVE6sFVZ7FabgT91YF+cCrE/fE6ocdb91YpB+OONMYVVlV7eqwJ0eg2OX70lnJa0S94KyAneeCbGKcqZXUG5ryIZEfwqc7Gfoqnpz44SpJGbbs5MbPv10Yzkcf6Vths+6BtBCAOQZyc4/ftOVbbtfPiXXuVDmPNrgTs+cuKuF591vzB1HzYnaW+ihZ7GIn7PSM43ZWvA3EqJ2eCLazhcCZZbYgXKkrXjq9fXwH9riwYMhF3g45rXp2OX69icEjeezg6nqOW2Vr3I93GgEEyyMnRHehtqJYtYv0mZgOZW8dqbyUGw6LccLdBsn+9zZWjHW4ee9iKHivN1daInnIsOOQ1+ISeAgt5dahGfslO0Zn8otmp8PxHzKiOex1fiIg1rSASpRXLWh00eQnuNingNpeFRCgDF5/4n1W+U0k+EgaRG9jFIQbprlxZjBq67+HZdbrpI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SzA0ZEJCeWMzbmFjalB0Smd0dStSbFJKQ3ZrclliWWNvOHh0U283NEQ3d3BR?=
 =?utf-8?B?cHg1eFh4aldkeW1lWWNnQjlIRklJcllROXZzeHMyWGxFR2NYTFZKOFh5ZFFO?=
 =?utf-8?B?bDJCenI0TWhEdDFtb3RWVVRiQ3BpYmtIUGJUQnJlZ1FkWTJ1QzVibUxqYStl?=
 =?utf-8?B?MU84Z21QcEorYmdwcVdoNkRhTTFzWUFtNk5zNzdaNmpBQVpvcGxuN2RKV1ZO?=
 =?utf-8?B?eEZQR0hxZThuWmJFVUNiallDVHhNTld6enN5U0tYN3BheEJ3eUQyaEFkRXUv?=
 =?utf-8?B?Y3JSeTZUYTNxTUVsUDhqdkl4cDk2R0c2T29WWEhibnZYaVJmc0xjalhkTjFi?=
 =?utf-8?B?MjJ6ejRscGYvNzQyWGxwVnFFSUhjcHJWbFk5SVBmckJWZlAvRTFpQTNycXBG?=
 =?utf-8?B?STRhdm9hYWZwL1NwVnFNSGNoVVp5dGpYT1p3TjBVdmRtMDl4Zkt0VUkyR0th?=
 =?utf-8?B?L3diUkh0R3dqN3lLcy8yN3dvZ3lBaUdYcXdhMHVNOVQ4ck8zRTYvNXVpRWpB?=
 =?utf-8?B?OEVlclplNW15T1hHOVp2NWN6OXNHaVQvSVVnRVhVa0pZT1BjZlRLOFphOHhi?=
 =?utf-8?B?RFFHVHc2c3hTM0dIY1BGRW9KS0xRZUlPL2NsYmNZLy9kN0dWWCtDdHp2My9u?=
 =?utf-8?B?N3NGWnJJWVdlbE92VGU0V0xGNmFzS2J5YXRROXBVYVBENWd5YWliYlZLanNa?=
 =?utf-8?B?T01lb0FzVjNVenZxd1R1NjRXSml5dU9xNEZLMHBoVTZaY3hRZU9aNzNsZ2p2?=
 =?utf-8?B?WitjOU52M2F0aEJoVzBRbzdZRHlKdmpPN0RBRmFad25iL05WSTNOTmJMbGpm?=
 =?utf-8?B?NVRXeEptWXdjcVQySVY0SU85MlJObEprcVQ4a3NEL1RsQkttS0o3dldrZmcr?=
 =?utf-8?B?VDYyQVRGbWE3dldmVElmNWRYZWZ2ZE50SFc4V2FDdWxHZ3VGMDQwNms1b1lU?=
 =?utf-8?B?cDkzL1NGc2o4R0V6SUoxaEVoSHB2VEZ0b0RmTjd6OXJBdEJwSEpRZGhsWk5y?=
 =?utf-8?B?cmNiNUh5K0RnZmxhcExUUFAzcEc4eE00MnM0b2tQWXh2R2dsaXBwenJnazJo?=
 =?utf-8?B?My9XcmRSYU9TaGZ3dUozQjQ5NmRzWkRFcUFaT2V0dW95ck01bEpsQ2tyZXVH?=
 =?utf-8?B?NHE0dzFqOWhmZVJ0cXZuQmtPcitpZjhTS2lEWkRLMHVROHFJazY4ZmNucEZN?=
 =?utf-8?B?OHlwUE40Z3RnTGZEWE9CdnovSmlTVUx5cGZjRWN3dEw0QVUwUFRqaGNIQ0Jv?=
 =?utf-8?B?b3hGSE10ZmtmaVdqRnNtR3dSOXFnNjI5TWhTQUY1TlAvVXBscTQ0dkZLZ1U5?=
 =?utf-8?B?MnBLUi92d2hTcEJtZ2tTM1oyWmhSWnN5cXhhYkpNOS9aUmxzOWI0Q2VNdG1Y?=
 =?utf-8?B?MERheFlWOHlKUmI5MTRZSHh4R2tJOGtwL2MvbGEwQ1JrYlZ1UjdwUkJZU1NU?=
 =?utf-8?B?U1J1SHo4M3daeUYvSW9aV05FcERrcmh5OE1hVHRhTE8rZ1dwOTc5eWJhVlk0?=
 =?utf-8?B?Vml1Mi84c2JINTF2bzBhRlpRK2FQSGw1SlNsZFpPOHVOb3ZQNU5FRTNxYkJK?=
 =?utf-8?B?ZVYvMGU1NmpXWmVCS3I5bW1LUXF4M1dxbmt0M0pVdWdhbVRwV3R4ODJsZFNS?=
 =?utf-8?B?R3J2OThxc2UwQ3V4a3VBSGJRR1pyVGtQdUZORVdIemVjSzliSEVySWVQckV5?=
 =?utf-8?B?dFZsR2dWU0lmT0ljbVp6OUs4UnNjcHVWV1FrYnJtZmRwTWZhMVEvVHFWM1ZO?=
 =?utf-8?B?UmowL3JiY3duWkFwb2lkRUdTbXJVOVRPUUhidkxmVTlHMm1zSlR5SUtjVFZX?=
 =?utf-8?B?V0E1M1pHSmdXSWluNGxxZC93bkg4NVlGWWx5c2IwSlgrWVZJc2RTaTVObzE4?=
 =?utf-8?B?eStVcnQwZVhpN2lBT3FWVElEcTJJLzh5MkhmOGExbEV6QlhoVHYwQTNBNzRJ?=
 =?utf-8?B?NVNqVlF6MUpyM05vQW5aV1I4Q2JWRUZENEVDS283REpWc3BsRDhub0lEblVM?=
 =?utf-8?B?Q2szNnZYa3BaL0FsQ3Q4OG5XTk1ZZHlINHFHWk0rTThqa0ZIYjgyaUM2dXov?=
 =?utf-8?B?U0t4WXhYbldWUzRnWDJtbC9udjd4elVIem92Q2VUS29OMERzeEI2UG5PRGlN?=
 =?utf-8?B?bmZNSkFGT0Y0ZnRTdmtiNm5UWnVwRm9rMEkzSDAxSE1BcWR3dTFsUFpXcTRo?=
 =?utf-8?B?Rzhla2lTKzE2OGNQZDVESG9Vck10MWExaWljbnhJY3ZZQWQwcmlDcnU2dlZ3?=
 =?utf-8?B?U0pNT2dvVmk5Wjl2bUVmQnZpRmJwNFVwQ0ptRHlSRWk1K3UyaFFPU3pxczBE?=
 =?utf-8?B?RW1XTTU1M2hqN0VCTlgwV1VDOXJKWUZxVFlxcXlCdGI2UnRLQUNWNmpTbXJK?=
 =?utf-8?Q?qFnKDOIzRwD56wBU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a99f61-3aa5-4ac2-b249-08df076d0866
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:34:58.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJwqJkPk9oSsw5ekVRRXTEiKkuFAH8K/sO4OVbnwpQcuIzALEVFXV7jnWhplwj2nsELpDu2k65c9WFtAfMUzD3IgxSZ5oybmV9hQWt148n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606

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
index 601d88bfcfeb..0533cdf969b2 100644
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
@@ -2225,6 +2234,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0

