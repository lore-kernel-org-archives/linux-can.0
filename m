Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53704582E4;
	Fri, 14 Aug 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698221; cv=fail; b=HX5dHv8NSmenlFlc4Ac/jbwiCm4RQDucM7SzdLEb4XppoAmw7YGWRhx8genJf6UfHvvK6GvIYh403YOMri/8ZmCh4gUZz+IN581ZSWj/t4LHO4TLod1oJ6RJpDq8Wyu5fiM1qIfqW5ShurlTG0SZmgU+uB/SyNb5HRUKm7uU4CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698221; c=relaxed/simple;
	bh=YAexm8pVlZDny8Ten3hso/o/Gvry2HaPfLMK4PB2AjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=niUULprw3tn1lSoNrQrakIJ8R7F0tfHmVMuD3P0TT4KdZ6z1TuD1AVzXWLWgUxGHBDHUJMViYakXADmcaFYLDOHvlGqirKabRnbQ0ZiwaDBV5ucPSHnZUMDvI1Qq9NIdSO8vgGqA38gEHWLE7Cr96PzGIcSTdYUOV6r/SE8ebU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DQ3X3h5N; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DQ3X3h5N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eusXnzYCDIdboiCy/AwvOHuASdM69MS9QhneK1YZY/mrJYppaQ+aopXMtQfHUx6leEnwcCXwaFCBkP1Xjp0Zo7SAr3MnSrKxtKS3YUEFJ5u+wTwIwiliyg+ockYy6RPv25m3t50z2uXYbLis6c3o99gATuUnMVIgBQQ4GCuDIh6HK2jVGoQ/4mq+BNWmb5B2iwy8nVddR8yncX+9/ErFUWrjj7XsyFKhWREtCHWyLacgDn/KEaBNo36di/rrTEIFMXJYy0qplCne5j4+gsNqImbrMLlebIDrug0U3AKJ4ri3prHtqQ6eFSXx9yLjZfR+mkUG8KTZEnkgCN2PIgmO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTZLozdaZejLwtCbU/HyeDKjbs0bUL40fVmInykkfXA=;
 b=Zcui9o0LWUJIYfH2vMwj7yiPEXDdirWqQ0TTQBSzOp44UxXm53L+1iJryWUUTORcp1peDtSScsdhamgMcaREB7hwraWLlhnrtK+xOM4i8ASHOGfZQhdCFXww130UdwG+2/Z5u0ItZMXHrBmHwUh1BCokK7ljpsAChGFo3I57zD+7SV+bVoqf+l9BTbZFBNAJxBN0Os7f9e0dbM69ftvprKoJa02hrDckw9wrUanyNuSM7Dpaq37V3t0EGrA8JGTlacmKfegZte0ae0lZhFVbbhT0teI0gXyDT+ffF5osNwUvkGmiTJB1KoykFD97UfLZJXy/7w7Zdth7/8bOWRFFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTZLozdaZejLwtCbU/HyeDKjbs0bUL40fVmInykkfXA=;
 b=DQ3X3h5NNatyWh+DOqPedrOEDEQz1jeSO/luIXyT1GMysf0AeHacp6KsZ0x5baCpdCBv8LoJfqAqoRmLoHyXwLjhZm9kzc5g86KzOXF/EZgExoZ2lxfShrMyQvYOYJs9pr15tvySQYehk3eeoVS69tqHYQeUV1TVroHMS+9No4EQqIoa8UA7TiDA42j217Vy1PR5uNPz3HssOWTvbHPHIiQMQqpYyF5ov0AkUH8JM+Sqyz6E7w6et4KRkcRE33lygFbwHImBszD+8wztpEXovua8PmUduW2tYQ2v0wleoJ49XqckXOacCQfCI/Xc+0vKYfJtlXPV6hI33yd+yBfhtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AMBPR04MB963705.eurprd04.prod.outlook.com (2603:10a6:20b:75d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 09:03:36 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 09:03:36 +0000
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [RESEND PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ line
Date: Fri, 14 Aug 2026 11:03:20 +0200
Message-ID: <20260814090324.647898-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 97d473f0-efe6-413c-8887-08def9e2ecb0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 pz0TWGjaCdzYnad6S7DGiAUsDeWAI/XbVzQPrsqj5eUey4hJwYaVu7+jHTAszlY8bW+2lsk4bUpLH7F7IEjDW89QaA2iX9TjV4XT0DIAaZo3j7uqzqDqAejgh2NLOHSNV8W3lLtZonSYJORCEx/XF82h0dv0P++rxDujNEFz1kmQevT6LASqktGKbVxMh65j6odBSt0m8CLf4bFQqyLTyo4sipd0/YNWueEPGe+LQbi+NsSdXJOfQGDrd3Ox6dG3KCuXHlUsJ8IayigKGq5eXqkrWYEJ6HFByVPM2hbKeAIBnJ3rYwR8NGAAvrSJe+gH81CRMWhOmkuJNS6RKheKCcQRq1Wu7yxWCLIxh/U/22wc5uNDK1QTMdgzvY4WDU8VTS/RudgPA/rul8DNUTDNYf92eHsbhEWql0HzYKoLyaPQ8TURXV6YIqrMAuEkS9P+bHSau2DWw0UKlhy+0knXRfXWmVIkxOgfr/nveaeqIkMHjtw0iz2Hw8qe6IsS7Ds65nvIFYHtoYtJOS1zNZKkt94tMaFKSJGWOlyGTwnwpJbEWGEDxWUqGxrk0tIyaa06+RaeOQ7wv3nWm7IZkgnlzXAUTXi+R1JG3mA9Zx0spWG7QN3LBIY7xn5lL62Juj43Y49fvn4nVKeobBXJqHhcLqAVhAacSIb9+KQbaySE4vI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UDZKUFNnRy9UQk1VTWpsRUJjTUJXdXB4ZzgwcStDS3ZmaDAyR3ZiT0J3Mlor?=
 =?utf-8?B?RTRnVWQwWUxlWG1LeVU3MlNBMGhja0gzdDZ6TVQ4dE5mRllhelJINXZyamlK?=
 =?utf-8?B?MkJycDhmeFRGeEZpd1EvSHB1Z1hIandtSzQ4SUViWVovNDlrOXhiWTVKTEN5?=
 =?utf-8?B?UEJ1U0tsOHVJc0c5ODgyL0NzOWlMZ1k0Z0NiNXpBeVBkNFNsRGtuenJ1MDNF?=
 =?utf-8?B?Q01KL0RidVlJM1VMTSsrOVI2ZE9EZ1RRSnZDeERpY3A2S01OcllNbWI5eHJY?=
 =?utf-8?B?Z3ljNElaaXdXZjB5eFc2YVRmeUx5SmQwUGg5d2hYMSsvNjBhdWh4ckQzNkRi?=
 =?utf-8?B?bWlkcTNoRGU3empBTzVaZUR1M1JaWDNpS2ZCOHc0cEJUNWpqYmMweXJXcmVp?=
 =?utf-8?B?VHcxN1lmS0loYzRnRHJDRnp1Q29tMlVWWjgrOUo4TVZ2R05TcnkvdkNCTDJO?=
 =?utf-8?B?d2JPb3BNZCtTd3lJeUE0aE1Yc1dQUW5rNXY2U2JpWG4zQVkrZEhiVnVBMnMx?=
 =?utf-8?B?bDVucXRtV0NpdDJoMTJUS1djSkc4cTRCWGdmVlc0cGgxUzFEbitSRVhjR2lv?=
 =?utf-8?B?Z2VtN0svWlM4ZFRnUFdMYTFuRnhvVXJqTHBDYUI5ZlJlMjhBanExb21lbGgr?=
 =?utf-8?B?bGJTZ0ZzTHgvVTduWWNXMC8ycno2T2J2WlFnUjJ2ZUoxOHFWWEIvazdrR3dz?=
 =?utf-8?B?UUx6NDRodk9EbDNrd2UvcDN0QnVDSVcyZXh0emQzNmxKWDlzVGFqc2NuYjVZ?=
 =?utf-8?B?OFlvYUUxUXQyeEU3cXM2SHVveWIxQkN4YVNpeUQ4QXBoMUU2RjBja3RjcWZU?=
 =?utf-8?B?TjRmQWlzWllBOFd6MHcvbHFHMUwxZEZxcFpyeTBpNUR0K3h1RmVkb0xydnEv?=
 =?utf-8?B?ajR2ditCM0s1enE1MXk3SkFlMi9FTXVodHpOaXZvTy9DMmNCSkNCZHhPN09j?=
 =?utf-8?B?ZGgzeE1jdmVHN2lXZVhlclJFQVQ1ekJjekVhNm1GektiazlyVy85aG5hUUQ0?=
 =?utf-8?B?OXpsRnNtUnkyYmtod0ZJb2JqTm8zSVZNTzFYano0dG0vMC9Hdk54WGhSNTls?=
 =?utf-8?B?RXd6QU5HN1c4bzlBU2xZQVJWZFpGd3NLamdBeVg3NDBMSkJGdkpSUVJLTVYx?=
 =?utf-8?B?KzdSU3VTTXNTaHpVOXdvYjJIYURNajNkQVpxL0taaUZtWmRDVTBCQnU3NWR2?=
 =?utf-8?B?cXNNUk1Nckl3bEx3QStqZWJzdXR0VTNTandvSjkrR05oMGFlYWhrWnROQTA2?=
 =?utf-8?B?Nm00WFNxSm1qajFxeEQ0Zlpubkl0UGlrdm5vSkJTaTlONEJlOS9PTHlCRFZQ?=
 =?utf-8?B?Zi9pYVRlNkRQemg5RHNESStjdnBBVlZTVjJGWmxXaUdUZ25ybXAwVVlVSXow?=
 =?utf-8?B?ZzFwK2hmaDlqTHhhUDZhb0RHdnd3NjlHdVo2eGdDU2tHUHorY0loWlJLVzdP?=
 =?utf-8?B?am9PbzM2N0JVeEdIOGR6dFJBa0VWU1FRUUo1dXl3M0VYc1EvT1VvWXo1ajRy?=
 =?utf-8?B?M2hKL3REd2ZiQ3FaQUxiRU5QN3dpT0p2ME1aKzJBc3o0bTRva2llYTgwMlFG?=
 =?utf-8?B?TWJuWnVWM2FTMllwY1AyTEU3ejNEUjJyRmRycGllcVdaT3BIdUNqc1gxdUR5?=
 =?utf-8?B?dFpsUEpNNjVGYWJET2crd1ZvbUtIQmhtRkFNZlhpWmlKTDN2UWh6cEdqeUxq?=
 =?utf-8?B?dDdPRUJiRVh2bExyTm1TODhWblZIT3ZUZ01Ca0JGaDJxZFZIWUc1Q2VlR3JN?=
 =?utf-8?B?MVA2aW11TjRsMVNER3g2RW45WDJCUE9XL0IyTjYzblhvMStmRXdGSy9OL3Vx?=
 =?utf-8?B?bWZaUzBRNnZINFZzWjBHMDFVZjIxS1lmblloSTRvN3FkVGM3aklhb25qWExG?=
 =?utf-8?B?VjFIZEE4ZDEwRlBwUHVFaEFVRmlEMHhMZjJMWjF0SVZjdFBXOTJ0bXVtRWRr?=
 =?utf-8?B?b1hLVHRkNlVSV1d5MTJWMGxFZGtRTGZVQk0rUzNnUHN1cGNIYVVlblpkemJT?=
 =?utf-8?B?bEVRU1U4WERKSUtteFRsL2c4aStLaExjblFTbm5SeWJTN0VNd1EwV0hHaEU4?=
 =?utf-8?B?VTQ3KzQrTzRSSGU0ZjNDMUovOHhyS1VCN1d6VllwR1FGUFJmZUpOUHBPcGo3?=
 =?utf-8?B?V3hlNHUrWTBqVkNBWVZab2FRVjBGOEF6aUtJcTZjbW8zb1VTT3dERmg1RXY5?=
 =?utf-8?B?cGVITjVBWWFtbkpQOFo5RHE0ZWw5VkxKdDJBZjRpVWFLNlpJU0NHVUphcWVk?=
 =?utf-8?B?eDRxTDBMbHJnSlhNbTNqNWVBcnhWZEc1NDNOYzNORWNnclZzbng5MWJwaWtu?=
 =?utf-8?B?NzBQY285b0JFUFBrWEIzelRLVWRjRXR1MitxaG5aTUM2SHVTWkJwQ0NHRExp?=
 =?utf-8?Q?K8Bcp10lBhNwnfWg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d473f0-efe6-413c-8887-08def9e2ecb0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:03:36.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eroyHd7jnd40VRfHmgrAYtGuCJXJPp/FRCs8PC1dbWgGZqouH8N93T4PDqUrLuZ2xQfIdIkoaipFtV2EEie/T3GUGAj8Q35NyuCghRXZWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB963705

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
for MBs 8-63), both handlers currently process the full rx_mask/tx_mask
range.

Introduce FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK and
FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK to describe the split, and pass
the selected mask to flexcan_do_mb() via a new mb_mask parameter.

In flexcan_irq_mb(), the irq argument selects the correct mask: the
primary MB IRQ uses MB0_MASK and the secondary uses MB1_MASK.

For single-IRQ platforms, mb_mask is ~0ULL with no functional change.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 39 ++++++++++++++++++--------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 7dde2e623def..8b70952f7f05 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -182,6 +182,12 @@
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
 
+/* On platforms with FLEXCAN_QUIRK_SECONDARY_MB_IRQ, the MB IRQ lines are
+ * split.
+ */
+#define FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK	GENMASK_U64(7, 0)
+#define FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK	GENMASK_U64(63, 8)
+
 /* FLEXCAN message buffers */
 #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
 #define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
@@ -957,14 +963,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
 		priv->write(lower_32_bits(val), addr);
 }
 
-static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
+					    u64 rx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
 }
 
-static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
+					    u64 tx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
@@ -1071,12 +1079,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 }
 
 /* Process mailbox (RX + TX) events */
-static irqreturn_t flexcan_do_mb(struct net_device *dev)
+static irqreturn_t flexcan_do_mb(struct net_device *dev, u64 mb_mask)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
+	u64 rx_mask = priv->rx_mask & mb_mask;
+	u64 tx_mask = priv->tx_mask & mb_mask;
 	u64 reg_iflag_tx;
 
 	/* reception interrupt */
@@ -1084,7 +1094,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		u64 reg_iflag_rx;
 		int ret;
 
-		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
+		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
+								 rx_mask))) {
 			handled = IRQ_HANDLED;
 			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
 								   reg_iflag_rx);
@@ -1110,10 +1121,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		}
 	}
 
-	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
+	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, tx_mask);
 
 	/* transmission complete interrupt */
-	if (reg_iflag_tx & priv->tx_mask) {
+	if (reg_iflag_tx & tx_mask) {
 		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -1125,7 +1136,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
+		flexcan_write64(priv, tx_mask, &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
@@ -1228,7 +1239,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, ~0ULL);
 	handled |= flexcan_do_state(dev);
 	handled |= flexcan_do_berr(dev);
 
@@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
 	struct net_device *dev = dev_id;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
+	u64 mb_mask = ~0ULL;
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		mb_mask = (irq == priv->irq_secondary_mb) ?
+			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
+			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, mb_mask);
 
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
-- 
2.43.0

