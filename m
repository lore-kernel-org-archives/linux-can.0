Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682E446C17;
	Mon,  7 Sep 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778203; cv=fail; b=AuTc3bB29QFb2FK8xkveo29py9VOK1cb4H+bKEj3zAs2B0GzMIX+bcGZS/2sKpXFc45dFjityIi/UXaT/AYN1u0vEKQUzL1wxw9dY+WjGWeopEziyqvX3eniiSOlyjIEmjVnrJuiQpHtZ6fKoyh8XBuP4Ul4xWQewEjM+7WV4jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778203; c=relaxed/simple;
	bh=LsMMtqRj3M0OWc3uEs6GojWNGvi7dfMNwtUn9xBZoDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1ELG1Hy0hWPap08uDZ6+9TYNvLyUp3tPH4S6zCu+pWatp4aa1zRfBf0SYupagewhUMLMoY5Oa6LpR8QUEeQUvdmUUg2P7o2bYbak61pC94dKkBKLIBR7UhdPgvNN3WEJQOMjdGXkoqmyF15vZYLXHmp70um3nWnx1cx6XnjIGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nlwcCSSP; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nlwcCSSP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4ib7wmIjcE0HWSzpZZPmnTaDo0L1hkvgnfh90q0bnErWTBZKMkubUfHjR3+C1Q+Pu7BaFV/W0pLbpdwcqF+7CGYmGtuxRAUM22RfaxDWr+au6kj1awVIU2GeE/X8yC034k6SJm+V8/pMmTE2nx7FB4jZEgWEXH+lSRpto2fmd9v4cVjJL8v+r2LmfawF5KahxR13ypKRDi7iVBtILOqyhX2iQLvFtXRhWWCdNFlvi7BDD5j9bXCYm4ZAOJgiwz70B6N9lc7pkd+GbHSUsXaZGWye+gn7ZbNhAooaRKFWmvYDMbXB00MMUPDwxLeD/CcicxA5Be/qYn05PoH0YvODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZMRLx2jnL+NjNb1tkWootG7u1lAvnyAwkpLwwFr6LY=;
 b=EgljJ1YhIWuBs5o0RaescVaRleXzLkW1UeaA+YaeWRd0qYvnCX9w97TLSImRwsfFyRjAbXzghWCTIB/Hy6gNLXFJ67GQhUJmUUPPb1wr4l3BK62RCwxYkCxsLiX3ABgaqMmP19Zx58Bsmp1Ugz3EODV0W1UB/0ffcpBX5TPryRocMJTCV5AHXvKe/YzOwtl9vDzNm5Ukq2bDr1AvQcNqcXo4m1YS+JqkcHVPHdi+cbV75Z7IOcySN/dYoXaN6sMaCAknE1Dwq6kx3mQTbp26bEDQOgmXGjIGMg/MPluX0TQWJm5zUm495/Y6WFVqRsiwVy0lH0C08xrcLqw0HrC1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZMRLx2jnL+NjNb1tkWootG7u1lAvnyAwkpLwwFr6LY=;
 b=nlwcCSSPTm1rD+k/65A7TE5Gh39Tu5+9sExQHGfj+PJWiOBC+o+bIgynA4uiTHyi3VnPU4GDK21rPciIyglkvtxKTlJ3ri4zFqy8S74rfADKN7wk4Jo5JyOK+kHRu2Q92gLy4iFG1LbEIfcY2zqFfsxAl0Z0Y4qZmcTSBC7veC7KrI4x/3oQqs6UvUcU6VkAE32BYlAT6YsAGKnhmJH5/Bn3Wcjd16c198YVV+d8BxlffEkgYSxmUcT04pUwczcQ17VAGddLwb35N3kNohYaOlGimUsAgVcmGp/2v/9pQMfH+3Y39gcoUWFKUuw/8fcoO564Zzks+CeK+yhJFNeF7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DBBPR04MB7578.eurprd04.prod.outlook.com (2603:10a6:10:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:49:47 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 10:49:47 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v5 2/3] can: at91_can: fix rx-offload cleanup on unbind and probe errors
Date: Mon,  7 Sep 2026 12:49:41 +0200
Message-ID: <20260907104942.17089-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DBBPR04MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb6e9d9-3fd1-45c5-348b-08df0ccdbbf4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|7416014|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EhAcUarTbJPiXfK7Q3wPkGgnWMGn/vxnc/E9/JbXZ81T01U+dQEFi+9xaz5bQJ5hrjUkrX/wWOvdjarUYzEig2NsHB7nQeUkVEMCnmFsCZOS8oaKUM2tncGe/QRCfLjb1c3i6B1DDbWde4YyAUlZYW8tqy5hzNeboWSBpia/0FJtPt3QFjMEAvkoU7pYuJBSsciwZ8bN/ePgfYWGtyd74a4EoZk1I3QF734W5LH+J3GU2SS+jYj+/L6BnqqInPxUiN7LKZqwqMr+I5kf9C9QskTJb+sCCeIdWz60k9zIfud35LTVx6VmGCMqVJ3kUKsUDyLSzfmK8uZGn1P4DpDvl96pA/C5W2vQF7tisQtutAjxqvdz77lsvP+cmKoaD4Ko2ZB97J86f1sT8CVdsnvj1JI4s4bzo7key0q9OJC+Q4oRGyFZf7yCFhY4rUTd6vIElpWxzo6qrvFSSLqXlIY+O4pH236wew80wUaaSBVrRB2nxdqnoylPAwU/MDhn2A+XjkrwTqWYw4DI7NYe5pvYxh6f13URou1eA9lvfjrw894GB+L8CrtNY1j8+LsapqAtF2zowq79QQQCdvMB8YP4oRJzsrIQb4e6dXWMBjjFWhPFTV9JKmGMrL6vLCtDzl9sZe6lnl8OtJT5g91i0xfBRRxhgbWEndCwXdVNHRq22js=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(7416014)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTFEbGFtVGczZHViM2F0VWNCaHdvTWVXTHVBbWxPNHQxNXFGTlR5RUM1SS9H?=
 =?utf-8?B?UmVaVTRMK1NoaC9FdVdPaStLWWJLTGxTb1NtRkdVVFhRckN3RmhBQlRKcFJj?=
 =?utf-8?B?OXpGeWttOHpZRi9wL1h3NXl5MUdHbFZOR1hDNXFBUHI2NnJMaVk5Z3ZBUy9n?=
 =?utf-8?B?Z0ZoeVprZ1hnNkk0ZW9EYzQ1cFRodlMwMkVkbTVVdDRKeld2UmJacDZGNnl0?=
 =?utf-8?B?NzNWTm1BSi9VUU9rKzNxMUpWYm1aWXp1Q1V1ZUJhVHp4NVpONlI3bnhadjRK?=
 =?utf-8?B?TFdtQ0c1cEJiMzEzYnNxYm1OKzNFQzZsUTZ3cVJQdC92Ykt4Uy93dmdMU1Yy?=
 =?utf-8?B?MGhBZG53aG5MUjUyMGpKMVBLL0JleldVR3hlRDFzbUZIWEtobi9rWjhGKzlp?=
 =?utf-8?B?cmdOblpEY3hScTE0ZkY4c3NwVkIxY1puZXlZTEljckFvajNEK3VFcGQ1dnFN?=
 =?utf-8?B?WDREaVFNZmQ2dlNSNTJuZVVQazRuSEM3Vk5CdjVBS0paWWhTL3NzcENnTlFS?=
 =?utf-8?B?dUNLaUVjbEF2Yk5lWjBEUmIycXhlRVlsVzQyNFZGRGhmZ09reGNUM3AzQk9T?=
 =?utf-8?B?a3VlenJSVkd2V1FaWDJMVVk3cTVaWHV4RS85eDNlY2I3OWJsYThGa1NoQ0RR?=
 =?utf-8?B?Q3kzek5wdDdRbjVPK3BNdVpjK3Jldk1CbHpnNm90OWh2WFYwV1p4Vy9ZVDMw?=
 =?utf-8?B?d0Y0cmRNMVJKTGRUdWpCY3B5SFlJenpIZlAvbXlCNjRsRk9ibGJwUVFVWlJ0?=
 =?utf-8?B?cithNFVzU0RXREJIM012eS9Ldmh4LzM3MkFUTktpL1g1UmhiK09JRS9PYk16?=
 =?utf-8?B?cTBCVFdHNmlmRHpaOU5aN3JWUytqb3NVU2hucnNFUGg5M0xyR2doTUV4amR4?=
 =?utf-8?B?S0ozaERQSDBaMThuZXNHUnJsdWt1RWpjM1dXZFJWYXZTMU1kT3l1cEVWQkhh?=
 =?utf-8?B?citoMThRNmlLend6UTR3Ui8zd2JDeTdYTHBOZktYOVBCa0lpSzhvdEp2ZTFO?=
 =?utf-8?B?V1NWVFhxWTRsU2ZraFdHOVRDRFBrVTFaMXBLc2dFZ0VrWmpxTUpZTzhnSkZ1?=
 =?utf-8?B?UVZZd2xiSlUycE5LRTVjeHR5V0Q5bGVWdWd2VUNsTGFKeVozb3NpOS9RSFI5?=
 =?utf-8?B?aWxNSnliUUd4aHhxdzRRa0tJNFRoRXhYOUx3cFNURFlLWjdVZHVmZVBGTUgv?=
 =?utf-8?B?blI5SkIya1NpeFhiNDlJb1JHYlZtWmtSWm5HM3NLYlVBcWZUemttaTdoOUU4?=
 =?utf-8?B?R2VSME83OWc5R1FwWk5RcVowWkNhVVZURFRTMlVpSWsxOXZNSitJdEpPR1NS?=
 =?utf-8?B?Wm11Y1ZscXRlR3FsNXVCdjRMWFl3R2FmZk5hQ0s0UGtnZThGbmthcXJsNnNm?=
 =?utf-8?B?amtHMk5BWHFhQlE0d1J1UVhVU1B4NDV3ZDJrb01TZGZSY2lBZjh6bUFmcWgz?=
 =?utf-8?B?bThZb0tmV0NZNExtcVMyWlRwTHk3ZkU2cGphUjRKZUVLbWJRdk1pTmhSc1U1?=
 =?utf-8?B?TlZ1Qk05WDVVN1ZyN3BGUmtibUpocWQ2NUF1KzRjZ2x2VC9lbzc2M3FvUGdp?=
 =?utf-8?B?RnBlUjFXWVJtTDZ6U3gwVXR2MUVKN3lBT09HdGFHTGErME5ZbVpsdytxVnpm?=
 =?utf-8?B?d1E1VnozL1VqM2lsSjRQZ3VnOVF2aXJ5VVVJYmRpME5aYVV1UVNvWDRhY1Qx?=
 =?utf-8?B?Mm9xcFlGYlJIYzVvOUFiM0xNSWVGKzkrQmh3cmRMajlaejMybmg4WmV1SEMy?=
 =?utf-8?B?dk1EWFZ6ZXN1MHV2c1lvd3p6UmREYk8yQjFiVXlPbTdjYkw2S0dmbGo1d0NL?=
 =?utf-8?B?bTVjL1JmWEMwTXQ1QmltUTRRY0pISzNKa2F6N0ZOT1dlRG1SeUZwcldrY3dz?=
 =?utf-8?B?cGtqanMwbkhXVExXbmxubzV3NjJxK244T3h4WWR5VmtsZzRycWgxNGxuenhY?=
 =?utf-8?B?NzBaR0NJbkNSZXVIWFBRTUhRRmlPcUpRc2orUGl0cDBaR1ZsRnhNUXJ3b3E4?=
 =?utf-8?B?c21CRkxUU3FtZHI4WmNHZjRaT3NDRGdqQmJteUxIYnlFNEhaMXV2a0V2OTcx?=
 =?utf-8?B?OFE4cmFrZXBLQU9lbTR1NHZQQ3VYczUvYmNEemxneVhSeE5NWmxrMXM4Z3hZ?=
 =?utf-8?B?dGNRNVhTQ0t5NktUZDZDbVlUNW1ka2NRZ0lQUlNZcUR2eGRNLzVpUzJnZzcz?=
 =?utf-8?B?K0hJbERvUDFFNlh2cXhrNms1bUVMWWZiVmdhWEcwdlZvK2pJcy9PY3IwTXNG?=
 =?utf-8?B?ajh3U1k0MTdPangzdGZsRG8rd2c2dCsvdDdwTzNhVFUxNit3dkgwNjdNUGNG?=
 =?utf-8?B?WVNoM08zRkc3WTRzSkJXZDRZTFdMYXVYSkt4RHRTMmt4OHZNL3lsV09DMWhI?=
 =?utf-8?Q?V0srWtr4DSnWSb3o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb6e9d9-3fd1-45c5-348b-08df0ccdbbf4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:49:47.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN+9cyzOwFf4WfTnuqR1ymSPT8R/eGXrXb+fGG4Z1GfPmX4TQwlN0i2g3+TcA8JKTpKXqOZQ6wvpMMYZ/jPvkVGvg17KUgTaUGTGQyvt6JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7578

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Making can_rx_offload's skb_irq_queue per-CPU (previous patch) adds an
alloc_percpu() to can_rx_offload_add_*(). That allocation has to be freed
on teardown and can fail with -ENOMEM, which exposes three problems in
at91_can:

- at91_can_remove() does not call can_rx_offload_del(), so the NAPI
  instance and the per-CPU queues are leaked on unbind and module removal.

- The probe error path after a failed register_candev() jumps straight to
  free_candev() without can_rx_offload_del() and leaks the same objects.

- The return value of can_rx_offload_add_timestamp() is ignored. It can now
  return -ENOMEM with offload->skb_irq_queue == NULL, probe still succeeds,
  and the first RX interrupt dereferences that NULL pointer in
  can_rx_offload_irq_offload_timestamp() via get_cpu_ptr().

Check the return value and call can_rx_offload_del() from at91_can_remove()
and from a new error label taken when register_candev() fails.

Fixes: 137f59d5dab4 ("can: at91_can: switch to rx-offload implementation")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/at91_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..3f6c5bb373d3 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1123,7 +1123,9 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->offload.mb_first = devtype_data->rx_first;
 	priv->offload.mb_last = devtype_data->rx_last;
 
-	can_rx_offload_add_timestamp(dev, &priv->offload);
+	err = can_rx_offload_add_timestamp(dev, &priv->offload);
+	if (err)
+		goto exit_free;
 
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
@@ -1137,7 +1139,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	err = register_candev(dev);
 	if (err) {
 		dev_err(&pdev->dev, "registering netdev failed\n");
-		goto exit_free;
+		goto exit_offload;
 	}
 
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
@@ -1145,6 +1147,8 @@ static int at91_can_probe(struct platform_device *pdev)
 
 	return 0;
 
+ exit_offload:
+	can_rx_offload_del(&priv->offload);
  exit_free:
 	free_candev(dev);
  exit_iounmap:
@@ -1165,6 +1169,8 @@ static void at91_can_remove(struct platform_device *pdev)
 
 	unregister_netdev(dev);
 
+	can_rx_offload_del(&priv->offload);
+
 	iounmap(priv->reg_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.43.0

