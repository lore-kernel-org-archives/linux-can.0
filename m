Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383914A261B;
	Mon, 31 Aug 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186900; cv=fail; b=YmSji4YB5Fyb7gtyAt1g2xgy/np8HHc3DxZDWKYZXMVPwV9Wc6cY/b0N7bdpSIgtJdK0cCcXftAevBalyNbUAcJU4ETgIv7sMxNMjcnBXh9CWiWBxKbvLbd2nWQqGv/QGjwo1n7Oil3OTHEE39+0pUCeWpqCwl1zRNt5S/0rXxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186900; c=relaxed/simple;
	bh=roz1rum9uLNdrthtqTZNB7Z75DOO8Iy9b5dAa18Xt5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=db8dseNbQTbT30+AWkidK2QgJLBxiKWR4BTUQZ+awZefoSek2Q/tHQBWWttyLmWwiSm+DtkwT2fpZBdUj1erdcJmoKRZ7Y4K8kvqcPqmN1z8x02ocUvpNyezqnugHfITwUKT/2wuyAgF4+zipgQmi2NPiPT2HjLBix7hKLjt7Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aus3KhFh; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aus3KhFh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPyDDZfl8lrKwt4YuklUda/aOOktlR2QGjCulFIjWOvhz/5NFCdmed7vALRGadCbnnHqu2trk6s2ZTmkKjY0KZC6juJL3sEUVKZzV6AElSoRPdOhopRleXSUyMnhQYIj43B+bAsNp6vzKZYpgRXzf8MRXhDU8waOv04isr3zA/U9UYlxcremiTC1OjAEEBNtiTwkxYVM7qr19CC5Sl1UKpUFWlg6ilZY6a/TmT8hhOHJSOeS5ZwgFULPioZdDDvJMphqSWDQgus68PjeKRu1H/N4Ud7JCPp5fZ4iLzg65jn1SpX9P2kIcEQyvtxYDz7V4vzrzJgU02sdGU7l8mFlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqP8Qna4JdTPE0opoUblvvINg6VI6z1RbJlJUtX7NRs=;
 b=jOzZaZS70rzub4wOU3SPqigwdONt+yLC46ZdbTUxNksCQ4QFgP8zquwCJ3KiZPyXLqjoBwChGhf/EOFjefL1URHst0DaJ7hXNMRhjvk/SoJSotp4VuSnJDR0xovVG9ouIIGxfqghTHExL2iVQwG689z4wehHgNOyV14k+eDQ1G8OnFygkeL7uLy+1emW8PbCaE9HknVdSI9L4av6DKMQkbQsmR1+JMR+/D8vbodNoegvFbEkm9kI6aLmOD9doEGANseMxnJPlsCuNPLvqHVBT3aqxKNqEfZjSTL2a6C6UxUBGKsWLHUyHmvqVyoVURoX9E/JkKFHhDczJNbLPShX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqP8Qna4JdTPE0opoUblvvINg6VI6z1RbJlJUtX7NRs=;
 b=aus3KhFh2p0Qsw+3DglH+XPxn+cgKp2m9yiMIqx76gpqRyYcVpOLky8VCSPzYDCy3foNOtTCHTN9EtKehBtrngeaGoMbn+EoLn+rz5AhgQUiJN649BMBm2R7fLgJP6iIbVro4chnTxSZAY2aPXKzwVRYA0TL87kOg71fLR2+qIOg3GLwYhcysO77CQ8m7sNpOXXxa6kEpDEsPUIMIzBrF+MktppRJJrNX0A0t6dr3+axtm6ggB23XopdVc1WUV3Euu29mGQkt7Jv4L2zHi5ZUNvZUr3BrFDl0zZIW2IkGCXL9AuhXw2rWDzrcd9DyBaKKqsIhT1hOVnJJ5cy+fnDyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:34:55 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:34:54 +0000
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v7 3/6] can: flexcan: split rx/tx masks per mailbox IRQ line
Date: Mon, 31 Aug 2026 16:34:46 +0200
Message-ID: <20260831143449.12828-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0173.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::10) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: fa5a202f-a724-45b0-fd0a-08df076d063f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 VenoeSIcne3+uCFjVpmRhQu6pp3Zgwz/LsDhz7V9hgzC39VdyLwC5SLKe96TF2Jjv/6JqnKj+8gnid0/gaeYpK+8WV9Cj+ehUzn0FXjdJGA6/j+NC+9mOcqxlUGI0vuQD/jw7nNo7PkjA4dpvZSoM4MweoXxBTeY8U3djZydXvh+3TYdKDvl2Dovt50pgdQRl/kaxa7oADr+SOKHqRj+jpKu7qaQQppKEZNRtT9qFEQtmknca+e/ouZd4RDV/bfzxWSEfuNTZzqbRXuWpDXuTRfBqDurijBAGQFOhx5mmAYSFPtDL9ScEcyKIPYMPUIwa82vzyiGQVIB88QV7GdVAdR5V7XJAAwakc1FcBUjmCcFvuBvLtx89ctNuCBlC3dXukr+6gmaeKtiBHtI45CN4KoyYzD/LAbsvgzu6tBiwkI/6IPMosN+uX+4Q6C6G9J/HLbNt/TY5RfrNxxn5WEegio1h+DfrT5064VxrBtfUhCeT5zcKrH+KlElx0ff/7k67knm1T6YpX+sliM+1nFWsQzVcC7qmsc9uxj1kXYEEtkuSvx15gcmhqA9mvkHi/yFYLpz0Sgyc8Lnc5CjdKOx+vds1wPbXAbo83CSKORg3TaPM7iMRtiiI08suDX1ZLjDnnGUzH54sAg9KfslfXP1AJS+Y+a0rtEnXXohMj0U5+8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UjRWUlZLdGxMYzM1TkJIdC9TWUpuSVZLRGJTOWRNVFlkNksrZ25xcHdRTkth?=
 =?utf-8?B?ajVLTFRpK0pFRjRTdCtYQWloYUlja1kwc3N6SW1ldmN0c3dpcjdQMUZVSTdt?=
 =?utf-8?B?a3RGaG1XazZucmRZTUNGSzZBcHo2RWFBR0hMUWJiUC91cWVtWExOaUY1ZG9V?=
 =?utf-8?B?WnFLUDQ4dUxtaElHNm5XUWNwM08xT1F5djBRMVZNc1BnSEluNGFFckQzL1Fk?=
 =?utf-8?B?SXd3K2NUTzcydmZiWWRLTThtZHlGT09LczluMWdzWmk4cm1kWTFwUWpwcGNL?=
 =?utf-8?B?cTNHZ2prWnNtOHVqRzlPVHpkNVhmUzBLcFVPNGRnYlVpNldQcDhZNjVpeHRF?=
 =?utf-8?B?OUJlUjd5MnVEVGpqK2NQbUtiTGd5bWM1dkVpWTdKUUllbTVIckxsNkswUkZE?=
 =?utf-8?B?eHd4S1FEUzNiZVZPWmpPL0FWYXV2OHZXcHhCMHc5REpPSWVHelp3QVlmWGxp?=
 =?utf-8?B?RG8rZG9RZ2xCVTZadzZyRnpuWDA2azJxUW81WTVtRXFFaGRHSG0zSjZpZ0xk?=
 =?utf-8?B?c0wyTWsrRFlhRm95c2hYaWlGMlovWWlVbmhyL1o3OWlxc29GUTdZZ2hBTXhj?=
 =?utf-8?B?SFNDZGV6alFCRkc2a1E3bk5LZVV0QmpYSVM0dENreG9zTmpsUXFmMFppSXZK?=
 =?utf-8?B?eHNVNEt4MzBWeXFUM2Exc1lZb01nTkRSWUswS010aERCNEVHRldabFI5LytL?=
 =?utf-8?B?cjZEbFdOWDdRU0tsbnBzajFUZng0ZzZlbjFtK3Bsc2VtNm5VTmwyd1pzMFZV?=
 =?utf-8?B?cnAvUk01M3lzd0FLUTE1Q0xEeEgyckpnK2k2QzhHK0hFOWc1TzdodXdzWHhC?=
 =?utf-8?B?YXNDaG41dFBxaThPNDRhRy9WNENkWHNQbnZtYk5YVVpVbVBMTUR4Vk00OTFW?=
 =?utf-8?B?K01XV1U1a0F5elBXKzRlZkNJUnVvYWNXVy9BMFcyNzFYNW9mMlZNWkdEb2l1?=
 =?utf-8?B?U1duNHdzdEo3RlVlcGFBT01IM3lTem1QWFFndnpSajNVTDRVemdSTkw5aURq?=
 =?utf-8?B?SzdYY28xVDQ3RkRNL0VvRS9VV3ZrVGNwZzN6Z2J0RlZlbThwWm1Vd3hVT2hX?=
 =?utf-8?B?SW0wYnVqdEdPN0lUY3d5cHluc3dhRDB6d3pKMDFibWdReVhxUmQ4Ny90M3VK?=
 =?utf-8?B?aVZlSDMrSXlweFMxc21XVWIvZHROOUZCcEN6ck93ZDhTV0pqM095OXM2cXVp?=
 =?utf-8?B?MzZXYjBwVkhYSDdFc0xHUHhmVkJ2WHJRcEdwRlJKZnhIY3Nud2VINTF3cVNF?=
 =?utf-8?B?dmtHaVF1bWxOcUVDMnVVS1l0WHBqaFNkS284Y09ObVVWUFRUR3Z1SEF2cEJX?=
 =?utf-8?B?U0JCVUQwUTBmeTllTTZmU3RWbWZjTFBxcEJlbkUxVFgvd2tYeDl6eUtWeUx5?=
 =?utf-8?B?a0pubTVQUkprVHJDVjFHZGVsMVl2NFhqeFpHTVQyMHZ3a1F4UU9UcUwzdEMv?=
 =?utf-8?B?OWlXQVJEek1iak9CbW8xTnVSYmRxc2dyc1Nyb09rUnkyY0lTVTNTTHA2WHhZ?=
 =?utf-8?B?SnNza1ZzMWVNTkZ6RHZtUDdBUmNZb1dIMXZRYjF2N1VxRHRoYUpTVHdvMFA3?=
 =?utf-8?B?YXFSQURsM00waUY1cStKSlpaR043K1ZlTk9qanJUb1N2UHF4dEZ3cVA2cjQ1?=
 =?utf-8?B?WkF4WkptTXM4SS9CSVpVUUlYc1pWY08xV201VGIyOW9sMTNxVEdKQ3E0R09P?=
 =?utf-8?B?ekF1WDNUYlk5UEt5NmdSRTAwKzVJTXJUNll3S1ZhcERZM0RqVFFzTXd3MjZq?=
 =?utf-8?B?ZEp1bE5SRUp1UDhlQStQZ1o0RFNpRmNXUmdKcDNnV3RneDhtZjNTcVJsb0VU?=
 =?utf-8?B?azVPWktaZHZVSEZSc0JUWStnUnExMVY3ZWd4WkRaR2RESytpZFB2OTV4b01O?=
 =?utf-8?B?c2daLzRRVFcySHJVRGtTSzZxcnhjSWlSaU1oSHZTQWFKaFRpcG5nK2x2ZGdX?=
 =?utf-8?B?eVR5Wk4vSVVFei9MeHJSVFovV3ZGeHBkNHEvdDdGTGFadjZyd0psM3lxZk4v?=
 =?utf-8?B?YXg1WDdUYmZTUVRZRlFuaFNYTXR6RlhaSU4rU2RVTDFxTWJWcmpNaDIwU0Jk?=
 =?utf-8?B?ZXNoNWxNV0xxMWxtTnFuYVh3NTlwb0tsZ085ckxuVWNXemEvWHpJUU1TZjNW?=
 =?utf-8?B?aWNONWY0RGFBRWVncWRid3E0aEo2VjliS0xiSVRsWEVlN0JQVmRyUThLVjVH?=
 =?utf-8?B?WnVtTThrRlFOSXBKbnZmTk9TM0FvbnB6UmZUWWxZZnMxZzRYN1RpU2MxQWsw?=
 =?utf-8?B?VFNrdGNyRVB4TTBQajlsbFFLZkVHTEhadVBOTWNnbE9oN3BkVGRRYWhPUDg0?=
 =?utf-8?B?TENjNUpxVWlLbUtoRTBzb2NjNk5LTGZXdjdhb3ZBbWt1dXgvUm4zTE4rV05r?=
 =?utf-8?Q?38xPpUWuzXa5yRJE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a202f-a724-45b0-fd0a-08df076d063f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:34:54.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7ohL+E837HRubpGVFwbti6sMH9MEJ2q4Rs0v0FrjhdyqDnP651rXXJ81uwvjAE9Ai22NmvRnGzjvD6kkYu6OISvq2LPHfybHWVxcMncA/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606

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
index 4eda54d2169e..f28ff0e95b74 100644
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

