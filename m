Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDC2EEE96;
	Fri,  2 Oct 2026 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925150; cv=fail; b=D4i2739b16A0Rc2AfVLFsOejBhDPlfZ8eRybbrUqpbl2CFEiBzGcgAm4ZccqAas570oJ8R6bSLuLzInhmb1HUrw2umoFb7mF+t33havrLCn8tqMwUFlLBlkOXfrsGMq5rNWDiLz6f+tHBlbf2VNf/g/UJQXX8k43YUPQXb725gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925150; c=relaxed/simple;
	bh=5DFElU9TBnufE9jWBCNJK1Zz1sHUBB+6niHFJaWucoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulUztI2CRUujUzMN6EupMyI4w2Yp2mqaDVZOklqVhhKiyn6na/zWz3Jkby9uRxeD6LE50nBzVyBnru0Ycdmq4qS1tjuWEn70i3umPkW0FPQVMMiu1gPa5NW7mdcMx4CMD3TcqBQeHjTry0hbOkI2XnylTdWc3cNAHZ6RaILh5Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DwM7rwY0; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DwM7rwY0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuAGFihsvHlK2ym+2ZwMQ0Sec4zjx/JutUeCGCGfiuT2mB1kSxJvO3/6OQGIYjtZzHFvZQltOn6GIyE8+NmsilP34ZV3AFOoJMb1OwrL8uAR0E2cq+iw82Sw6zmpmYubMJjJOS5n4WU6Aw/cJLt+9qwAZjZ2OrtMdiXyrqLWcHkZJs7KzPb9Yr68EnWNS8IiA7IC9zghy5c3o39C07c56Ly0owbYxjjDFnxO3oY0fb0Pf2gEKwez4V6rcLLGovGsQ4oUrM+NwL7X+qKv/aZfIp+5P0Cfjn/k7fPbBC/H7UZP7b7MC0qqY+NLSz8THUDBb+fhf/9H0CudHvPIFbsqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs8nrV4vRdode5GpeLB8E81DF3Y4q+cBrSakT4Kknqk=;
 b=QhhUfIg37BsCJa0BmTnjNNZv4jx+7cOAz7BQ4957cA1AKyESow6QSJJ9Fu3fU1Qv7dYBkAzxE383QWCcdXT5F91NzMEAPFyM0AMTfJnti1y3vXvkIhnt5ErQ+w9Pf2RPG3SDs8YGuVCfsrfdqH/EnpLygoh3zyp+xLQt9fwK+xpmY7jNT6WyXudIjjeOE+wToD8Q27CfDRzJcM3wvmmEdnbXCg6kLfxT1ppstSl12wTSqbqd9UU1vv5lnreJgYNoKMtYmHZY9vzvfqU9RkTgpy4zyI4/fTTG9vRacWwkkYUWBgsdTab5XQoedEJyuxxwikKu7mtdvh7oAZs9jW8D/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs8nrV4vRdode5GpeLB8E81DF3Y4q+cBrSakT4Kknqk=;
 b=DwM7rwY0Af7w65SiTyJ9YQDGKo6/H5wutZDlmi64FaRpb7Nuzu3ASjfF5inkEHlXu7fXIWa23LFXewIQAAfKy5RsXu/wdtvuhnQwORXvu1MYuGDUrSVLXG0qbgy/WFamGdXczec+fOCpAwEKMaBP6bxZnBiO+ycZP+bA02QyA5HX+MwnhSqnYIbXYw/oBT29T1OPgn59favY7/T+cWar8VXo7IYoIuRv7HceGt+WtyFQs2BCPZT6TQxtQwNWGhMi6/1ce7YTRmLFzLtN7t2RdnaQKdbb+t/lFR9MF2j2XJnMCiMWLkjglHogFfMuJ5UMmBCnAousY57IwpQWVzCcqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:12:07 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 07:12:07 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Max Staudt <max@enpas.org>
Subject: [PATCH v7 1/4] can: at91_can: release the rx-offload on teardown
Date: Fri,  2 Oct 2026 09:12:00 +0200
Message-ID: <20261002071203.1287650-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
References: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::29) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 344ba89c-733e-4900-9f0b-08df205477e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pniot0LnD0AbqGIyMIxA28hsXVKUF1OcJHAZLdbjea2k3/639MA7PHSKBqZc/a6sjPtFQP2Bp6LTohQfLF/4novL2oKNudBA7biXNSMH1b/h4FFV9uLY2jurksKRv+GqjckS+BC1eLmDrXUOzFCBdtbm6l2xMD/16VPqqTDdJL/kH27uAQ0s55LlBd4F/5y5RrmtpsPQE5Hmr2XjB+/j+SVwpbEYBteyesPdSyud9Ly7X8GQ9e5ZxkwaONskN8R54/9qs6Rrkm2wKUj6geyn4VAjpQzyRMkd+FrSyv3EabWd5Tm8kj6d1aYyBG6Mi9CPBRH17inmGsfhg1gESy7pRO5t+2qpcIixpsVPgu1/xHs0hS7GaZHMKPXTaOeN2IWG5JWnWt3X+2iyv1MnuJFiNreQIhjaJZoar3KxwVXp8dig4EWy0QELUZgp49Vj7jRhyb71yuxpgAe3CVfbkRdvNDGcv3hhCNJcBhfUaIwGlgEWxjU5F+Mz7AgwI9NPZOGSS9CUtDT/giguQ4ttjk9fSh0P0+jgwfzAjeXebxUNCaSdRnftivNE3Cy3BBpP6wcXtb/nw7MMcMxByzIqm9alWrIowzgrp/u/X+4yF4kWjXhWF3Mh/X0UiJGc+HbYJFXbhaAEtNik+mDkGXq3o48QsvnSdRZ/1Y+03fmsv4UKoNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUhya244U1Z5alo2dmRFUkVwcmM1bWxyU3JHQWkzZjArbEhHVWxTVitNR3N0?=
 =?utf-8?B?aGxISXYxZGR0NVZFaXJMQjVmdUpxc2l3dzdCd2FHTHBmS1I5akFsNVRkTXdt?=
 =?utf-8?B?VGczcXlLN05GbHZicmlTZDNwVEE3Z0dPR1ZLaFNLaWdJaG1OekhKcjFoaFFY?=
 =?utf-8?B?NUtXZVB4R0UyUXlyTGFOdXFLd0VqcThBaC9TVWtINzRzdzVCTDdBNEVZWWJn?=
 =?utf-8?B?ZTRmd01HWVB2QUQ0d1lLUDl0TWtIMjVuTUtiempTeEtnZEYyS3dNb3RiRGIv?=
 =?utf-8?B?aGNvZ09Zb3k0NmNiL1JFRVNRZVA5Y1k2Y2tnUWpoWmxRd2hOM2ZyU2RNU1hK?=
 =?utf-8?B?ZkY2OE1RVDB1UmQyR3dvczlrZDNIaE94OUFhdlRwUXVSLy9XSUlTSmwxdi9a?=
 =?utf-8?B?all1eVZlSlYrakkyU2Y0SWJFRTUwVXpFQVZwbTJVT01tM1RpTmFSZUtTcXZI?=
 =?utf-8?B?ZzJUUXFYRGpCWGs0WkUrRDdIRDNtNGRxM0JIYXFCM2toOWU1bUpVNHZFckp1?=
 =?utf-8?B?SDMvWjhYS3JQTm1IZUNGM3FzQlNzY05QVWsreHBoYmZCeGJZUmZ2T3l6Tkx6?=
 =?utf-8?B?YzVtSG9JUG96TXdKR2R0a0VTWkxZU0JFaFpiWTV6UnRBNWhlZGRvZzJXdzBw?=
 =?utf-8?B?RDgrV01Ib2E4ZSsxREE5ME9Mc3UzWE1wODJveVVoV0s4T1BwdFBlNVoya3g3?=
 =?utf-8?B?TG9EWk5ueHdPZlp2YjRES0JEWTRlTVBtTkl1dGdCTXpKcHAxQTFkdlB6aC9P?=
 =?utf-8?B?UlNQYXNTUjd0Yi9XSGpXWFBSOGptRXhKVkNCUHQ3cHlrTmFUQ2ZtZllFTWkv?=
 =?utf-8?B?aEpIeG5sWTVzcS9LNUdtSzJ6RFY0eFBEdUdSMWVxeTl0c0V0ZSt6MTlpMVVs?=
 =?utf-8?B?c0YySDR1S3hRbzlsME93N0RQOTFqOUhHQ2FHVHFqMVBua1BrLzRwRTU0QXQ0?=
 =?utf-8?B?bUJldG9vbTRDL294dTlhQ1h5dGl5N3pHK09KUG9wVmJvUms1S0VLWTlnWVlW?=
 =?utf-8?B?V1l2bXhmRnhlaEFpM0VET0RWNTNYUjRwdkZZSXQvZ2JUYk1CTUdDQnpZTDR4?=
 =?utf-8?B?ZFZSZVZWay8ySHNhYllkME1xb3I3Vk5TYWpVMVBOeWRPQWNaU1B0ZCt2b0xS?=
 =?utf-8?B?WGRSK0owUEZTMFVhMjVwOEF5U2JwKzhJR0F1WlRjcVZ5WWFRb3kvNWVkamha?=
 =?utf-8?B?RHg4WElBbkVvR0kzdFdSSm9hQUVGZ0QvNGMyY0pOclBTTUY5ZldadDBEUTJE?=
 =?utf-8?B?WnZJU1hoaG85cTB6RXFvUjlOVFVRenlHRzhqZTNUaDE3VHUwKzRxdHl2dHhH?=
 =?utf-8?B?a2lwR01GWFYybm04WDRTckZwSXd4RnJONWNXL29IK085RVB4S2sxcmE4R3Bi?=
 =?utf-8?B?UjBSVWFUbHBObDNDWCtDS1YwYW93Nmd0ek5McXVZL3BmdUZBNzVldkpNSGMr?=
 =?utf-8?B?NkhmdGhuV21tbXFaQlFFWXJVWU5XSXdDWTdOelJzYUpLenJqNXBjNTFzTm5D?=
 =?utf-8?B?b3hjWjlueFZNa3R5RnRYV2VmeW5vRm5Ta3NMa1FzU3JDN0NncDNlSUduNHBo?=
 =?utf-8?B?TWRnVXdNV2pRbm4zVUZOT1NOVWE1SDdLNXZYZTlKT2d5T01odis1aDdSL3ZK?=
 =?utf-8?B?bWl4ejVxc3doeEdhVjdxaU1tK0c4WldyZWlVRWZHN0hWdmo3TWZBUHJmQllt?=
 =?utf-8?B?RVgwT0paVEtxSHFpblN2ZklQWUVlYXVhYS9FY3N5eURKN0gzRVArUysxNE4z?=
 =?utf-8?B?RU5OaTJJVlA4RmpUUEEvanRpMEo3Wlh6V2JRSVB5MC83M3NMemVsLzN6dmpn?=
 =?utf-8?B?NGxPZkErbjdOOTZHeWVlZ1h4TkV6RytCZ0RoaXluNXUwS1NqMHlseHUzUUdD?=
 =?utf-8?B?bnlDbDhRcXY2ZXUxNm5jcEluUHJhQUc5eDhwN1ppcGtRUTc1SC8rTjZ1WkFm?=
 =?utf-8?B?bDhCRXI4bzNMQ25Od3drVzJISU1reFpOeXZQR1dlaVlxWlZzWG0yUkZWZ1hh?=
 =?utf-8?B?cCs0M3pvbHE2R20zdkVHY1RzYVNkMlBGMHUyUnR4MzBwTjhBblovcTRwZFUw?=
 =?utf-8?B?aThZTDMzVlBwN1ZpOHArT2RVdS9kU2JhZFU1RWptaitodXRqZFlNazJrVm8w?=
 =?utf-8?B?dmViVXJWZmhhbW9Jd1Y5N0VwbGdVUXI0L0o0SWk0V3JubTZvUkRWMFZRTER3?=
 =?utf-8?B?SFAxNnA1K1pqWTZZOWJITFV6YWlhYUpySEQycGFBK1dyTXBVQ2MvZ2ltZHJJ?=
 =?utf-8?B?ZFg3NzcxdDNjdFRXUjFUNXdBd1kwM3RIVTNieTM5ZlBKTUVTSnhZcDBBbEMw?=
 =?utf-8?B?Y0JZWnM0Vld2d2V6QnpFUExnTjQ1bTJUZG12R2VXOFBueFovS2RTZ3hyL2lP?=
 =?utf-8?Q?6m+Y4XTDiHU0Xwcg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344ba89c-733e-4900-9f0b-08df205477e8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:12:07.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L43osdv3FMHvO+jcpxSubh6CIoUafaIEmr1xCCrCVVMxrf7owMwavcjyT1XmiVN+HzIWBlqw4WGEDEbOaP40a4jGRBW8Sf9bCC3EougLocU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

at91_can_probe() ignores the return value of can_rx_offload_add_timestamp()
and can_rx_offload_del() is never called, neither on the register_candev()
error path nor in at91_can_remove(). Any skbs left in the offload queues
are leaked.

Check the return value and call can_rx_offload_del() on both paths.

Fixes: 137f59d5dab4 ("can: at91_can: switch to rx-offload implementation")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Max Staudt <max@enpas.org>
---
 drivers/net/can/at91_can.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..09aa676a03fb 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1123,7 +1123,11 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->offload.mb_first = devtype_data->rx_first;
 	priv->offload.mb_last = devtype_data->rx_last;
 
-	can_rx_offload_add_timestamp(dev, &priv->offload);
+	err = can_rx_offload_add_timestamp(dev, &priv->offload);
+	if (err) {
+		dev_err(&pdev->dev, "can_rx_offload_add_timestamp() failed\n");
+		goto exit_free;
+	}
 
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
@@ -1137,7 +1141,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	err = register_candev(dev);
 	if (err) {
 		dev_err(&pdev->dev, "registering netdev failed\n");
-		goto exit_free;
+		goto exit_offload;
 	}
 
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
@@ -1145,6 +1149,8 @@ static int at91_can_probe(struct platform_device *pdev)
 
 	return 0;
 
+ exit_offload:
+	can_rx_offload_del(&priv->offload);
  exit_free:
 	free_candev(dev);
  exit_iounmap:
@@ -1165,6 +1171,8 @@ static void at91_can_remove(struct platform_device *pdev)
 
 	unregister_netdev(dev);
 
+	can_rx_offload_del(&priv->offload);
+
 	iounmap(priv->reg_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.43.0

