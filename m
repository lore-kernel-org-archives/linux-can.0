Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03837A827;
	Fri, 25 Sep 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347569; cv=fail; b=QhUd2BxOfXK6w7lHOkxA+HkM/OrGsROYFlqHc0tGG9Jl0sG5YvnuIJ0cK3Vba1ROM4iAz82oKtxOtspukUz1S97OUN3cM0LSI7w8WCtwCetE244pTcka+tgE/XzVQdjZUWRk6JxQEzAtT/yGZ1w+3cCGvuEOS2f3d4cpFFO+g78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347569; c=relaxed/simple;
	bh=PI//p/SlMu7HZ5yWsFpFBdclUiA5BsIgQskAlFcZNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MS8JU82DNw1Jtty+qLr8DviZ4cgLT29TbrAcnMuv+L1SYjpkwKb7uUY14dSrxfOH5snZW9UKau9MjyU+M/Yg96+Lq5kwok40kephU9SEV/iA1wXqq4dnebsSNKFtgTj1Oj4zmQwiSNbEz3X9qyIN2Esw6tv1lMmd+r8GFK1HnXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ECNHNTUi; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ECNHNTUi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmygaAzxqOlBJh5lxe28maphkY+MHg61x2QYNviz+aIiCn/k9gDZWILZU7e3pirta8d0PR+OhPVc9jm8hnlaZypqyOJ1oNLsRO/z0F5HYsT/gVjXrE+cpDkj8YbiN9zNZtpqxFZaNioqbgLinpaDR+OUqr9R5K/1xDbvtmygrlVFlt3A6HZ1QQNQnUUnk6bdvCDsaY+GBUxFi/KyFc8wKyS5GRJoiqMQADQoXl64qFvcpiZ2TzMTstr/B+oZUHaNe3xiZSuCR2YM8agDNkTjpZ3QkcuWbhCN0dOEFCzrGanlNPTNzhQ2q7HCqWZGaBqCUCMeKwx6I2AY71EcwgSN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MA0k+3mveGHc+nGxOtY1m+F3VyDL5HcGhSEDpsr7D4=;
 b=s7qZa19acvSr6aQcYmEflLz2juQ16lmF7RU4PL+7tIJLDeHN8yEJ0wElj46dJh6DeM2JPk5RpkFJQl3EkVJWr+rOCFlMTfzunl/pm3D/xdf1VVjlZjZTk1qfupDVYuJSukNkGC5YXXf4YlZvWfdwCkrrqsv0KyRLjLlK+a/LEy2SiyiO9twf7ImT8wbCAG/N3o+vPv/Rija5bVCVu4uFCh6M8nf2USWTSNUR57SKBsyC15NTema4JNb3cRepLaK7hQ1BbMvoyeJ3Mb+wcWb8ds1i0D+ll5LWONgTS1jKTeqSBKlFS415fUIUzhSw10LZiiomJ8a5Rt2r/TyvuQEbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MA0k+3mveGHc+nGxOtY1m+F3VyDL5HcGhSEDpsr7D4=;
 b=ECNHNTUiEtu5rbpqZvX6YvGjQKGf9ZhUY6C4HgHkEUklB3zNuFEbsegWUsrk4sDJzfBgkmNNoDKp0NOEiEW4JqDqFPKz/wmo11GQN8BjRIzgAJoDKcFrCLwPXdLZRZ5m9UnenlKsphrwr51Lkdy6dNBFA/owfHsTmtZxfuHElvqPILqGINMehxE/4MrQsESQU8m8Bt05OH/Bl1tqwRDVbhKPbaQucuAYWXCW4vcch4B210Jz1bQr8gO9fIQtkhOFUvX8gUiZMXGgX7v4bAsDeLTHt/usmIhBSoiFFAjZCraQgr6ALmpIi72Q8qLKg/ybWEviDZrK58PP7yjGXiOf3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by BR0PR04MB337759.eurprd04.prod.outlook.com (2603:10a6:2c8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:46:03 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:46:02 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Max Staudt <max@enpas.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Ming Yu <tmyu0@nuvoton.com>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v6 1/3] can: at91_can: release the rx-offload on teardown
Date: Fri, 25 Sep 2026 16:45:56 +0200
Message-ID: <20260925144558.2909639-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
References: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::6) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|BR0PR04MB337759:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a29d14-7f39-4056-ab15-08df1b13b8b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|921020|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e/CYTrIm00RS/jbsfyWvYKc821DQGtUGtVIlgKKHlE7qQeXaGnAra3usQeSu13h6DoAdtWEYOlstrJZR/g23SMe6QHvlmGbScsK3JVoT/K5HBB95+GWMHiqSqzKsGKZ//pNK69z7VoUF0vqsRl4++SpYtkjcRxCHUUyCgd64NkWU8BDSeH6NxtoNbqfaXwhOB7VLFLktcmK7AoW1AMZhCcL+o7kFGJ2dDi9St6DBkOwGsxxpTEXD2SNduCE1UmEHRvGUM+VGLY6UcuobB+q9/9yFmm/Ss6UfxP81dReY/UESM2kzzOLMd/VYGBSPIAYpTO2s6Pru7lD1g/l6Vi+bk7VCwk0VSwrlerzD2mS5uVC1iX4zMSgNnRF4GWCr1XDyZ3M7PU42/p6tbeIe167pEVsxr+fJC4tmhKdFNxukxsFbgPRGHII8BK39i4VxhFdKBeOzWS2ouM7YD8l46zSCRSxIy2fDjpCHmNKBVfNjyViiRCe5mBOpPgoair9vFz3SuFYFKC/rGgj6b86RQFawPTkWQ2cAfCq7PXUZY6Jth/SAxP+7r3VdxfaUqih7M8p6xx+HylOroaarlyRGpCcBrRSyQTzLcJkeAZq5SwIjB9brwb8tdhEQrTbfwwBChg46bMMJ1m0XiHr0bX4i6SUa27g3Hsbpn28T6In1U3XjXGFo6UCoDmJyzMqUSAsDbYc7Xca0zcrB7oSEYZxSFwcAOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(921020)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnBucEgzV2d3TVBwcXJSck1NT2drRnJXNjNqYU11VVRSaXR3bitnNE8waGZw?=
 =?utf-8?B?Z3NxWFBrek9CdmtkRVk1dSt2YVFkYlNtYTRrOTFvemZJWHVvWlFsVnczak12?=
 =?utf-8?B?NDRvQVRYeVZYM1hndzVHc3VoZkJEdEZGNlEzSVZxSC9MSkJqSXRwYlZUSm16?=
 =?utf-8?B?WU5odCtoaVluZDNCdVlYZ0NSdmh2Q1NlOXVjY3g3TFFRYTBsYVhzb1JCZWln?=
 =?utf-8?B?dU9QZCswK3dUeVRnVUFYd2pOVUZXZm9PU05sOEV2YnJuREtCdk51WTc0MXFa?=
 =?utf-8?B?Vnc0NTBKanJtVHRWVWdBVTZmNVN2QlpkNitsNGJqdDZ6TzZhTnJtM1VxYWRT?=
 =?utf-8?B?b0J3UFlJZjFzV2t2ckxFanB4UGEyaDJPT2NwSnR6V2ZrejRrVFpSTWNNS1ds?=
 =?utf-8?B?VnpyTWRIdE5tVTJRZU12ZDAwbEcwWVNCZXhIakFoQkk4TStFdFJFZEFGVkF0?=
 =?utf-8?B?T3dtL2lyQjlHRk9wVU14VmVEUDBveVB5YVR2emlJQy9hZks1THhhV2h3dGk0?=
 =?utf-8?B?SGNyWVFzdUV6elVqVHlUZ1dseWZJbm4rRWtmVWcyczFSWUQ1aEZKZFZmWmVY?=
 =?utf-8?B?ZVMxc0FscFFrTVdaRWdnWXZyaXpJSlV4NTUyVHl3WGpIQnN2dEFDMlFsakgv?=
 =?utf-8?B?ajFwV25OOUdaaFFyYmh5TWZ2Mk1iRDZEVzJqUmhGYkhBb0p5Wlo5MmcycGQz?=
 =?utf-8?B?aHhUUElid2Q3cDB2MVdRSUk1VlRRVmZEUU91cGFUMERGeS9DM2ZMMjNWODd5?=
 =?utf-8?B?TE8wSkR5WTBXcUVDR0pReDdsUzE4NGZ3cGJ3RVhZRWZ5cDJQM3FobkZPQ1Rp?=
 =?utf-8?B?RFZobWNlM0o4K2dJcC9kM1FXZjFJWC9Ib1NmZTRDbC82ZWl5WFZCaDU5RnJ3?=
 =?utf-8?B?TVl5N2RCc05KOWJQUmVJa0tXY2pSOWREd050dkxxem1wUDZNR0liRXNhSFRh?=
 =?utf-8?B?VE5rdEV6SllJZmU3c2lWbGc3WXNJVFU1YXc5SllDdHQxWXBQZFlNQWRUd3dn?=
 =?utf-8?B?MDR6Q1VXTGpXOWxrYVloYzQ5YzVMNzR6cldIckN1WGl4L1RiUUdDa2t6RjA5?=
 =?utf-8?B?bHJBT1Y5VERLa3JZQVNFbHpDcU96WHV5aDBaV05aMnl4WS9WVVRIdEdmVGNv?=
 =?utf-8?B?US94K2czeHVhMzNqUzdSL1dDS08zZnhvemZBTUpvVmdGV3NVZVplUmJlR2J4?=
 =?utf-8?B?aXppYzM3MlZYVzNXK2FZVk9sY3VEdHpQL2oveUlHTGV6TnJ3aEZ5VHFUakNE?=
 =?utf-8?B?Z3VlQkxUQzNRRTU0Wm9veFYrVUpBRzBxMWtsSEl6ZVIvTTFqY1EvQnUrN20x?=
 =?utf-8?B?c3RsZVc4MkZVa1c5TGkxZFc3cmNsVWpWWUZrNmRML01PTHBYcnFjVGhmWHVX?=
 =?utf-8?B?UXNxUHFFZmdJekVHVk1IckdQVkNlNWpzWEl6RVkxQjhZdkp3K2ZJYk5RRzhk?=
 =?utf-8?B?Z0xJZnhQdm9hRG54SUx4MzY4Q3EzVXhqMkx3VHcrc3ZxMmtCUTF5U0txQTZl?=
 =?utf-8?B?U1ZtRlh4aWxweDVBL0dkOWNjQWthU2xCWEtDZ1FyTEdDbEZncHY0OW8wam1E?=
 =?utf-8?B?WHEwS2F3bStmL2F0QnBOWnhFNGszaDM2djJ2UlJhMTBSM3craEJTSnU1VXFK?=
 =?utf-8?B?aGlNWm1IVjRkVjd6Slg4ZmNPNzRYZC9nSTJCOXQ3S2FtTWt2OGVPcTBVRGNw?=
 =?utf-8?B?emdFYWgxRGNLZzJtcmhZMmsyM2tydEFWUUpKRnhZL0c2NWljZ09rMVFEUnZF?=
 =?utf-8?B?VzRJM2plSU5QWkFoZjdQTWhEU0NaOVBmNVk0VnhrRzZqRjk1KzljNjVERXYr?=
 =?utf-8?B?bENZRGlzNlF0c0ZwcVphbTRnTlpMMW13LzVjSnFnRnJKYVFGclF3VlNiSTB2?=
 =?utf-8?B?WVc1U2RxaVczZk5halFBck9XMGFrZG9zV0VyS1ZCb1p3aDJDblFsZVNZZURS?=
 =?utf-8?B?UVlrSzZvNHBtNk0vUnFJRnhETWV6cktCbnZEbDBHVFRETHNUNVNtTWxYZkd1?=
 =?utf-8?B?R0ZWdno3eXZnLzNyeU8raThuU2ppdEh2bWlkbEtUejdqL2dQdG5ocmI3WUJ0?=
 =?utf-8?B?MHFDUXJlb0lWdG1zei9aUWlXb2RvYjkvT3J5bHduZDZCbWlwQ1RXbEpSdXJX?=
 =?utf-8?B?UHJBdWlBWUZnaUJxU0pFdGk4byt5WXdjdXo5ZUI4dUd4Z1NDTFJ2VkM0VkU5?=
 =?utf-8?B?dnJEelp3N09kM3FzVk5pK0ljMUJ0OFFrMWcyNUJYNUFDQWJxV1RtdUVKQXFs?=
 =?utf-8?B?d1h5SWJuWWVaM3N0Sk1kc2hBNmFTWUxNOFdZU1pZR2l1ajZPZGhjbjl1eHE1?=
 =?utf-8?B?OHdFOG04cytiaVF1aDVsRVJzWmtmR3BhNmhBWXg5RDNBb3hIVy9leTRxSFNr?=
 =?utf-8?Q?52Z7t9+6M+Fk6J1E=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a29d14-7f39-4056-ab15-08df1b13b8b0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:46:02.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3i8HXAZJVUQYQvCdmA04/GXH5yjh0BD16jI/gja4fIcASfKf0gp1yCVsdgPFr1LdeRDdzOvcvDnv4zmug1YMJI4n6rA0CqtBTNnu+m+j8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB337759

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

at91_can_probe() ignores the return value of can_rx_offload_add_timestamp()
and can_rx_offload_del() is never called, neither on the register_candev()
error path nor in at91_can_remove(). Any skbs left in the offload queues
are leaked.

Check the return value and call can_rx_offload_del() on both paths.

Fixes: 137f59d5dab4 ("can: at91_can: switch to rx-offload implementation")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
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

