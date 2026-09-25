Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD34AB3CC;
	Fri, 25 Sep 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347579; cv=fail; b=r/FXXEIxdy11Zgz+hcj1cox1/gS3YaIoSF9MXYZwaIr10MUkfBxMX9iNQtNIKNWSEeygMOubvFial02oGhom5S0+lc3KDzT9gOepVv3UKYHaeuJeLd8L+XnByIu9g7dhHybgrVv68NKpcjXkbFEBcRLkI4uaNA0D8hbiY+aQk5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347579; c=relaxed/simple;
	bh=H3jIpGSesEg6QH0wEUsZY6zC+lfqp08P0G3mptfimAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8AgtN9LJIFn8QXlaco5nNIWl6boifl7KhMcin5iyWoT502ga+j5XuTUIeCuNOOQdUJJ7k26dnKncVYPXFXF9WCOcPmmEQtu65BtlSlkBi/fiSp0K8lZanbFZf7xsyOAFqiXg3LxR1vU7/WaZoTmkslD1rs31PzYAHM0sdIXTTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kfKSI4FS; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kfKSI4FS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOtVYR8axunJARy8TJ18xelU+e5FVfC+RF4SGLRPn4g+PFtD5hQN2oFbQLj0cuhSOyUHEdIYzSlnQbrw1NZnw7vdlGbDUDmlOHmxfOxHbFU/kAX+Z1UN23vU2HXg7VjsAJ5Lotf4oaSiDliAgfwDH/E6+eqjnaxyFeePGBQ1/kSiwV9NnssjJza5BIGhlYh5+u7WC6j6SWZhEQ/8s7ffdOuBtpejCaU3YpbHYn0IIknt3EspjdOhFTXIY6frKUjXoSvrIfvVdTQncwgQeb2KDLxh3VhZ2I6qGl9kgPE+40EiyGqPYZePNYJAs8eyzFyMVpphy+Ck5lqPa1ELkrwiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4shnvH4TRc/wXpWLdni5SzELRxw7eDYg39GVC+dKmKk=;
 b=XWS03jkAJUEC+iZWAFEbtZHkjzWhIOk8mLF1Q7RdL2kk4GVNyj3hZw1bY8FnmaT7j4LRZFsJNzp9wn2JRyNSjrhl36EQ00c/OOoSJFD5OPLy441tzmpm1/c1bmSL22xnUJg85goWGg2hlIGHu//HMa1YsX8cJZ8DggINPR7skzXyqCWvoG7M8eNgvh/HWYq+s+WL25BlIdZdMZ/K9r1HBONm74a+T5lFPkR1sCrbniNyNTIesy8o2wOMc5kTOStbMNw8/1fhbTsWkLe/xVDsq26P9/VBC++aS15UWuwS4gEpzR1KDBHwCh0dyPjctjSoSVHWq/N5Erl6su6pE6WoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4shnvH4TRc/wXpWLdni5SzELRxw7eDYg39GVC+dKmKk=;
 b=kfKSI4FSoQift/koSTV3xpc2KnmI2xho+a/c1s9nSuvGOuHEDP44lbXAQxetYaaRh66ehStEqpVJi3u5BCbA7TuOfX8I3UC5helZI6bil2WXE0C/HM8ksGCquLVUaDZfMOcJcGKZSktukThmziIYHUUETXPxTwvW/Bn1F2wpQ2s4o6eElxe3aEiU7OfHmxaNcMR5ix0/jrw9ZEUPsEYL+oOPcxWBqrxAUfjG8zT5jVxUpTjxH9pzyCEUiBVlbEaGAwOaS0o9Tfpl4IOill4AV7gQg0w7/zcoI7mVMhx3POdXwi9kB0C70o1mWhvAGKGY1ZxyXeizf92juFJRePRBJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by BR0PR04MB337759.eurprd04.prod.outlook.com (2603:10a6:2c8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:46:05 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:46:05 +0000
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
Subject: [PATCH v6 3/3] can: flexcan: use one rx-offload context per IRQ line
Date: Fri, 25 Sep 2026 16:45:58 +0200
Message-ID: <20260925144558.2909639-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
References: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::11) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 41c7d159-b340-4059-d66a-08df1b13ba6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|921020|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	82Wo45hjKpdl/VhJ+qR+DZ8MEgPTrJN158tjXmuPC5ti1kXXFgM1GzIH+2ITGymwTzXlTH5Vm+nRGh9m3ydZxwoCoFn/qpaWkLUCyXGHh1KWlE13KZxYkg07tBz+hPuPpIyzv6iFBLg8wsYGMlnxCsagdsUnJpnbmUD/8lwtzgZnhQP2uPZyEggF5CvxXs6eVl1e8fvNn/f5jt5+PNDs2pGPpvE8+X6DNFwdcXIlyNh/NrwqIM02pr5AI1ON1CRxUz3hCwhkohkdZxxyBsDhkhGcGQflFwHlKdUENrdK3cHts0iGvYfCsafLwUXP3nN3pTQkH+oMLLEy1/mNOha7Qb50V5BOHQae2bSMvsEXPiOWQw8f5xHZBQeykBpMp6xdl/8BGzkSWLtfZKdzlxYOVWC+vVJ+sPg8FD3BnedZSOFi93FAB1ZEv4jV6ndxVUAyD4VscrSLPEaU6f4/Li9WHqIM4oOnAxcfvcUK0HBT2F4d26cTw+kpZa9HyPBwLJuSxaETbjbISNLe6sFtVl/HmQ963333VailmehrBadH9D/QteX+rAeV+PIKISlc8Q2Yh0lUx06GVxQmG4LpuqCu7r6eURa3hRU0y12vaC7O7diNcEyjPlYtSxkbV1SunlT4Ds6d44z0dlqUtnu5dQK9m6NONyY0E+XoTVWRtCW9X6OSGRgJKSYt4WIKz8gpnXAHAjOkbQm/qg9Buh+6Bpu0GA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(921020)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVObFNpaDk3eWEwLzBWWldtUGxQNDZPcm9DdGhYbmQ0T3JiRTdDT3MyRWlx?=
 =?utf-8?B?LzVJMVhFbGJmTG9Ub0I2VFVVSUpJMGJWbjRGbnFVSnV0NURyV3RSdENVdy92?=
 =?utf-8?B?UXU3S2x3WnhQWUw4OG1nR3Y0M2VXeGJNeEN1TEVKeXo5M1hvYTF3ZGtCWDFU?=
 =?utf-8?B?ODY1empKNVdQWitzSGZTeC9WMFdZUnBlZUVSWnlxQWZzUytxM1p0OEhubGJN?=
 =?utf-8?B?SXBUWGd4SlI5dVdqTTJkNkN3ZTUzc3NmYTc2dVNZS3NGZHFXSGlNY1ZyV3dT?=
 =?utf-8?B?d0VPbHpIZjQzcitXT1EzcWFLdW03Mno2WmphL0xOMzBhcWd6cHlURm5jVG8v?=
 =?utf-8?B?cU9YcWZ4cXpIS0ZCTjNSQzdkQTlhdElXeDdtL1VqSk5lQWdUMy9jenhMMWZn?=
 =?utf-8?B?VGJvWWViV3lEaHRPdEtmeGh2OFZQb0FNWklZZjhJdkdZN3pnQ1NwSVIrYnJE?=
 =?utf-8?B?R0ZXS3ZUMmFtOWh2QU15M2llTHJiVVhwUGZGVDJ5Z1AzNkMyV1gvNG9Sa3dC?=
 =?utf-8?B?M1RsSTAvYXNGelB6QmlzTzc3V1JmdmV3TXM5eFRyUkE2MVlKOGlBQ1ZmWUUy?=
 =?utf-8?B?QndPRExYRXNvRUFMU05iUS9RRVlvcklOMW4rbzIwR3ZIYjEvS0lKbUxRUlpn?=
 =?utf-8?B?cjZ6a2xGbGtlQXhrODFvNVJ2ekJ6S1YyekMrT0cwMzd4Y3FIcW1aZzJDSDVC?=
 =?utf-8?B?QjF4U0drNWN2bUcwTEVHQWI4TU9vMzlrRDN5djhJOEhrRlA1R2ZpajQ1TlFW?=
 =?utf-8?B?RGUxekdBNG91cS9LdHdIR0ZqWHN3d1JSc2FVNksybUhvNWY4dHpuWHNzUm1Q?=
 =?utf-8?B?K3BuQ05xMFNKNkI3TEovc2pOeXdvanlUcnFHK1NKcElaQlltdUxVRTZsMkdG?=
 =?utf-8?B?SHVkKzZvYjFDdXhTRXZmbk1zMmJ3TWJpNXoyYjZxK25TQ0JlakdONFl5TUhp?=
 =?utf-8?B?YkJaNEVJamRncDdRb2JDMm9jVVFhY04wS053a2x3RDlZZ0Rlc05xSmM2QUda?=
 =?utf-8?B?RldFY1ZTNSttamhjcE5xL0EvUGl2MzhyanZGYzNuWHUyanBrOE1oOTNVVzha?=
 =?utf-8?B?WitZUlpRdVZVK1JvcG5nTFhjT240TzRUa1lJTzdXL3daVHk4azhMNExyNE5S?=
 =?utf-8?B?czJIUzBRZnJPL2N5UHRDZWtaVVZwQmo4dVdLNTJTUGcydjVGanhNUWVuSmkv?=
 =?utf-8?B?bkFsc0paMjAxdWtnTm8wbk14djVOSWNXNTJFbXpKUlE4ZEZlcCtpYlF0YVdv?=
 =?utf-8?B?TE02d0hBZWJxOXVNN3VsajdrbWFuQ1IyaE83dStGU3FzdFlnQnNJRFRDbGZQ?=
 =?utf-8?B?YXhFSEpmMTBLNW9FK2Q1NE5JWjNVZ3IzNnV4ZHhxanpJdE1hcUEyeWtJN0xR?=
 =?utf-8?B?NTJYZGhERHZtZ3cxRENKTkZhdUFvRysxWmxPZUtSU09sQ28wcDNMT0JUNjYy?=
 =?utf-8?B?ZGNBU0Q0aVdSbnpMZ2lCam90RVRpV1dxRnRUcFNaZ0R6TFUrZ3VjVVVkNStX?=
 =?utf-8?B?NDJEQ284YVJSUXVWQzk3dkRKOVdXYTdVN0lUMnhSODJMMEltTTZxQWlnN3pM?=
 =?utf-8?B?ZDlxMmNCUXg3bkJ0SGtmdlRTZE5aTTZFSXdTcUIydnJveTNaRjEwTFptSEQ4?=
 =?utf-8?B?c2E1ZjZYalIxSGV2VjRkaGpsdVAxb2pKTXFyajlKRUtNcUN4WXN0Y25yb2cr?=
 =?utf-8?B?VkNOajJiYVFpYXpIc0ljMENac1h4aVk3cjBPb1BDR29iT0Y0QkE1ZEg4Y2k4?=
 =?utf-8?B?RnJjTERPUlpnWll6aXRjdXhGeHlpQ2s5TXZ1UlM5aE45VmdxMTlJS1lTRDhP?=
 =?utf-8?B?VkI3YVNJT243VkhhV2oxUHVLT1Vya1JROHZYbEwxc1FuRlNJRGh3VVFnc2VN?=
 =?utf-8?B?Z1BBbW9UUlU3OUlNY1NqRVNlTVJ3WmJkTmYvSldqTnpQRE9vdGJFT1FQTHBP?=
 =?utf-8?B?OGI2Ujd1eHE2bGNBQ0VGODYyZGw5dXAwb1VvM1ZhYUMxczJhTmFMbCs5SVBH?=
 =?utf-8?B?MC9vcmZJVDkzRGE2UEVNRUs4eG8za2p2c1pLdDdVSmd5Rm1aVmx6OURQOHRG?=
 =?utf-8?B?TEorbUhTZ0FRR2d3L3ptOUp2QitHNjhzby9Oc1VnWUgyTTYwRDU1ZnhISjdE?=
 =?utf-8?B?UUhQTGRDcW5MVkdsdDlMd1FvTWVXc2gzZjZsMWhKMHVFd0ZHSkQrNjhsMEF5?=
 =?utf-8?B?VGRGQVhXeDQyTVBHbmh1ekhNeDNMeWJCVHFVTVUvT1dONFdWR3MvanVUOSs1?=
 =?utf-8?B?b2VyTExiWTFPSjZPL3JvOXFlU2t6ZmFGNzB6cEdIVjQ3SWRSOE80cnM3emxx?=
 =?utf-8?B?bTg5cVJWdmQ3MnNqMERsTUl2ZWV1MHU2WEJuaFp1d0JOaHdqWWNlU3Rxb3Zu?=
 =?utf-8?Q?gZaQgbmCqndKu4U0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c7d159-b340-4059-d66a-08df1b13ba6c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:46:05.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/fHhVsH799mQpYc1CsycF0PVuHNXc1a0JK9t7OChhHP7dUqgEyWZCND/8lU5nPMU7mf/N/r0butJnxIQ49jR0iyxttiUYzcZXOyCCxCYt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB337759

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

flexcan_irq() is requested on every IRQ line of the controller: the
mailbox line, the bus off and error lines (FLEXCAN_QUIRK_NR_IRQ_3) and a
second mailbox line (FLEXCAN_QUIRK_SECONDARY_MB_IRQ). On NXP S32G2, which
has all four, the handlers can run at the same time on different CPUs and
corrupt the rx-offload queue they share.

Add a struct can_rx_offload_irq for each line, pick it in flexcan_irq()
based on the IRQ number and pass it to the functions that queue skbs.

This only fixes the queue corruption. All handlers still process the
whole mailbox range and the same ESR events. A dedicated handler per line
and splitting the mailbox range between the two mailbox lines will follow
in a separate series, which also removes the lookup added here.

Fixes: 8503a4b1a24d ("can: flexcan: add NXP S32G2/S32G3 SoC support")
Assisted-by: LLM
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 109 ++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |   3 +
 2 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index a81132d3afa8..b600680ed983 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -828,7 +828,9 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *de
 	return NETDEV_TX_OK;
 }
 
-static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
+static void flexcan_irq_bus_err(struct net_device *dev,
+				struct can_rx_offload_irq *offload_irq,
+				u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
@@ -885,12 +887,14 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(offload_irq, skb, timestamp);
 	if (err)
 		dev->stats.rx_fifo_errors++;
 }
 
-static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
+static void flexcan_irq_state(struct net_device *dev,
+			      struct can_rx_offload_irq *offload_irq,
+			      u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
@@ -932,7 +936,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(offload_irq, skb, timestamp);
 	if (err)
 		dev->stats.rx_fifo_errors++;
 }
@@ -1070,11 +1074,35 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
+/* The same handler is requested on every IRQ line, so the line it was
+ * called for selects the rx-offload context to queue into.
+ */
+static struct can_rx_offload_irq *
+flexcan_get_offload_irq(struct flexcan_priv *priv, int irq)
+{
+	const u32 quirks = priv->devtype_data.quirks;
+
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ &&
+	    irq == priv->irq_secondary_mb)
+		return &priv->offload_irq_secondary_mb;
+
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		if (irq == priv->irq_boff)
+			return &priv->offload_irq_boff;
+		if (irq == priv->irq_err)
+			return &priv->offload_irq_err;
+	}
+
+	return &priv->offload_irq;
+}
+
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
+	struct can_rx_offload_irq *offload_irq =
+		flexcan_get_offload_irq(priv, irq);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
@@ -1088,7 +1116,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
 			handled = IRQ_HANDLED;
-			ret = can_rx_offload_irq_offload_timestamp(&priv->offload_irq,
+			ret = can_rx_offload_irq_offload_timestamp(offload_irq,
 								   reg_iflag_rx);
 			if (!ret)
 				break;
@@ -1099,7 +1127,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		reg_iflag1 = priv->read(&regs->iflag1);
 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
 			handled = IRQ_HANDLED;
-			can_rx_offload_irq_offload_fifo(&priv->offload_irq);
+			can_rx_offload_irq_offload_fifo(offload_irq);
 		}
 
 		/* FIFO overflow interrupt */
@@ -1120,7 +1148,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		handled = IRQ_HANDLED;
 		stats->tx_bytes +=
-			can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload_irq, 0,
+			can_rx_offload_get_echo_skb_queue_timestamp(offload_irq, 0,
 								    reg_ctrl << 16, NULL);
 		stats->tx_packets++;
 
@@ -1143,12 +1171,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
 					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
+		flexcan_irq_state(dev, offload_irq, reg_esr);
 
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
-		flexcan_irq_bus_err(dev, reg_esr);
+		flexcan_irq_bus_err(dev, offload_irq, reg_esr);
 
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
@@ -1189,7 +1217,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	}
 
 	if (handled)
-		can_rx_offload_irq_finish(&priv->offload_irq);
+		can_rx_offload_irq_finish(offload_irq);
 
 	return handled;
 }
@@ -1381,6 +1409,23 @@ static void flexcan_ram_init(struct net_device *dev)
 	priv->write(reg_ctrl2, &regs->ctrl2);
 }
 
+static int flexcan_rx_offload_add(struct net_device *dev,
+				  struct can_rx_offload_irq *offload_irq)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
+		offload_irq->mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
+		offload_irq->mb_last = priv->mb_count - 2;
+
+		return can_rx_offload_add_timestamp(dev, &priv->offload,
+						    offload_irq);
+	}
+
+	return can_rx_offload_add_fifo(dev, &priv->offload, offload_irq,
+				       FLEXCAN_NAPI_WEIGHT);
+}
+
 static int flexcan_rx_offload_setup(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -1409,22 +1454,42 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
-		priv->offload_irq.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
-		priv->offload_irq.mb_last = priv->mb_count - 2;
-
-		priv->rx_mask = GENMASK_ULL(priv->offload_irq.mb_last,
-					    priv->offload_irq.mb_first);
-		err = can_rx_offload_add_timestamp(dev, &priv->offload,
-						   &priv->offload_irq);
-	} else {
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
+		priv->rx_mask = GENMASK_ULL(priv->mb_count - 2,
+					    FLEXCAN_RX_MB_RX_MAILBOX_FIRST);
+	else
 		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
 			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
-		err = can_rx_offload_add_fifo(dev, &priv->offload,
-					      &priv->offload_irq,
-					      FLEXCAN_NAPI_WEIGHT);
+
+	err = flexcan_rx_offload_add(dev, &priv->offload_irq);
+	if (err)
+		return err;
+
+	/* Every IRQ line queues into its own context, the shared skb_queue is
+	 * only touched by can_rx_offload_irq_finish().
+	 */
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = flexcan_rx_offload_add(dev,
+					     &priv->offload_irq_secondary_mb);
+		if (err)
+			goto out_can_rx_offload_del;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		err = flexcan_rx_offload_add(dev, &priv->offload_irq_boff);
+		if (err)
+			goto out_can_rx_offload_del;
+
+		err = flexcan_rx_offload_add(dev, &priv->offload_irq_err);
+		if (err)
+			goto out_can_rx_offload_del;
+	}
+
+	return 0;
+
+out_can_rx_offload_del:
+	can_rx_offload_del(&priv->offload);
+
 	return err;
 }
 
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 90f9c2b9fed8..443ad5237ba0 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -89,6 +89,9 @@ struct flexcan_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
 	struct can_rx_offload_irq offload_irq;
+	struct can_rx_offload_irq offload_irq_secondary_mb;
+	struct can_rx_offload_irq offload_irq_boff;
+	struct can_rx_offload_irq offload_irq_err;
 	struct device *dev;
 
 	struct flexcan_regs __iomem *regs;
-- 
2.43.0

