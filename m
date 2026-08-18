Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BE39FCDD;
	Tue, 18 Aug 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070248; cv=fail; b=iOHAGiHTPmrSFh6NtiuziExNbBi9WaOsgw7gFDxsaSJeuWPOZaUhg0k36MrEtu8zToCHwpMsqo2gv+vFtAId3ch5pzGYP9kwUS8liHQLydxYN0ZmFDf7pHYfC3kfcADyRrs27898w6/ZVHjyi8sNvbubtfcFViZzCg2jrz8Wc5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070248; c=relaxed/simple;
	bh=vw8mw0ig4KipfJv75xTOKGeX1EVYcwWcBG5MHS8fQvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N8xjm2GbnnA4WhsG2b8tOoESw7BnObEYlMgmnb6CUP0C6SGDRFarx0Xwdke1oeVz6uCItbOr80aGu/JCuHOcLe3ZGTBXb1Z0TmAZhSC1JNh2AfzRS/K9WyY3aiEQT8TuyDmLOgusEz/0NIP4GmUYjW7xay8deS6+mpHtUPum6vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S5zMhttV; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S5zMhttV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMZpjA2GRSB4kgdwoNkSNKGJmSVNv28hMD2xil0liVay2SC8oT4rAmG5gP9FoCqFtHjkX3h6RKMXePSRypfRqeSQBHI3rNjcWAtY9g7eSeYL/xOOyHMPPV6ZRC+HamyKtClIz0ZT+dQTDtbbODI7tgeo+79wi5EFTnTTddSAonT55mE2qySatOErE5MfzkaFI0k6Aogv7AkonPfNyjZu7BG764kq6GFC2OeDL10G4bbwKBkXf66vBXC7XvRIJk3ji+1fIA6auBv/B02A0wWrEQP72jEGm+8xuPuRYLKMxx9SsVBdGaLU3w9Puu3Z+6BsTussquVei1CwNP+LlNhiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/9uq9C0DKWc1aXQQNv3SWRWx7ud2vMql/XjbY4IZ9M=;
 b=OTrfop72wMGcpRczEOl1pDayPnDzDsZCBIt01crgHslqYsJpvsGZjP/SjdYrMtdybvqpt2PdCQ45l2TwQm2O0iLfhnhkjM1gdLhjHjGvKnsOs+8rKqa0JZDVwYoXx+vDgIxdgrQzerwgKvAPRIdr+NETeWgaQ2oiUwMW40MA33ubvozf1xo0GudML/P4kIkWPO9FhyuFrxowRRvVwQYQbnEMxVR+jZVT2DFFIMIaGrCkBgah+XXNpY4YkkUFhR6J+cti0b+6Y6JzIltjIrqjRnAC7ExDkQiSUeRUFpFqc28H9QixTHJF5oukD7PYjYe8HePcWDh4jCv2wynQSqEH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/9uq9C0DKWc1aXQQNv3SWRWx7ud2vMql/XjbY4IZ9M=;
 b=S5zMhttVVYjYle8ZgGXwsXE2QneJvOiuL7zDNhv/xXflN+aIhAlxH0wkRheB1YxbBQSJ553kn1cZmjAZOpDrqYWrVS4LJpvCqHgJa/EH9RoIwnqbaQT1K6QXYZwZTRn9wRalKdTVa3RhM6ob0LVJymLzB8F7R3dcuHeT+EHjj3xOuUyKlm3djwzXF/ZQf/rmznK8kO3XvhYUWHcdcJNxyDRKO4Lsjiu4SPKhYibVcgIrF+rWHhmGvvsghLhm7yidTJHKbzKbgDchdevUHfxii5BcRroSuaWTXdXWlCWysCZblNIVGXFK4QRTXCpbMhoR5zRhXp55XboIsZEA1+GgZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9055.eurprd04.prod.outlook.com (2603:10a6:150:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:24:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 16:24:01 +0000
Date: Tue, 18 Aug 2026 11:23:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 2/4] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip MCP2542
Message-ID: <aoSHGLd-KyShQWOu@SMW015318>
References: <20260818091701.6441-1-wahrenst@gmx.net>
 <20260818091701.6441-3-wahrenst@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818091701.6441-3-wahrenst@gmx.net>
X-ClientProxiedBy: SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ab7c92-dbd2-41d9-d33a-08defd451d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|7416014|376014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kA9KiG+/hGSbURcDlMquQ1kRze6ANHu1pQQ1Bt26oE4meOefQPTQHx/3WeLfG1KrKVd/xlxBdAkOR3hRk/r0sAeEfTULDUgxzfVDlxnB2JBBr2O+K3rcjO42FxiGxWrt7Q0LobbwlipcRNNQjgAn5hpHWTn0fzlSA1JsHrufcnPEgJR+9+N4lFm9CT+UdqQAolv+4vb48rzWYZPQNjO19t7qGXJX+W30fJObSoGCfiSbtsoO6f8C6vT2ZUSL9jaXf7eK3X0NtF80PVsE9ycXpIOqXazaYG/CVrOKvXyaLBQU3Tv8S/TddNan+L4DQRIzsX2lwUfo+FSLUEWX0nS/4QJ/6lO7W3HVl9/rBrlNUgSrw6j/8iNY+xm2AXj2y4jTAPQacDV+3K0WFXs3Z0fe0twdIw+dqjlX2BL12lTfRXroSLkC5i0/IMvFWKZvk8b5/bWmdkvnjlkrwOtXOq/9cpbtKJz4AK0ogtCFYCnwfZ54DHlaNC46RQXretO4tAaY7wIpxXhmeWu2os+Ls8clyGT1trDyrhD7KXj92KIIgkHGEAxiMKhSSSoAh+3ZJ38cx+zz1v1d7SmQVNZKUZgart5a8vqG5XRCFq9mavF78Ric4VmYBpHwXzJTMDN+0fMn2lcSNCNbT9/3uG9LkyscmRGxbBRbhEDCLPOKxIgSQ1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(7416014)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJ4U7aEaB4GtJ97V8VuGgx0njEoYJzYIA+FuQtgtxBN5T+LMr9k8beHPs1Lk?=
 =?us-ascii?Q?rxN2QCH6+IpU9YYpAJPcuAwviM3m3vho+14oelvAotNUs09TOE1ZVOy0dn0l?=
 =?us-ascii?Q?qx1z+Ym4dBk/ul8frhVmSASEcyk/mCJZXxVq0/28MABcZDbBFvpWniB6Pdy4?=
 =?us-ascii?Q?Hc5ChKKMQ8uGXfuMIpvsaMYOTqO8kDY9RjSR++ljpgv1hxaFbvS+wvo4+Gi3?=
 =?us-ascii?Q?5LlPlqimCdjNyBUR005N1dBgBhloLfANEZcPjm04xlLuBtzRimi+vBVMJbxg?=
 =?us-ascii?Q?QiIQSbI4UlhSxuNcED+06NbPGAuS/NoC4dLAG0B7lQrPUx/G77CBGeeJXWiJ?=
 =?us-ascii?Q?gGVQArf+Rr3X+R9YouUEnlmpMnxGX9JGU97ReUx1IrYgevn49c88hst48bWl?=
 =?us-ascii?Q?6lqZQ5OZz8BjgOzX3ULXAxzxdJd9Psbl4VnFkRPP05EZtodTxwNguz66+35V?=
 =?us-ascii?Q?mi8eyTINQ8pNEPsT/l0t17zGDm10ypb+ADjZWlYoes/7omJniP0iHfkp2WpT?=
 =?us-ascii?Q?Ancnw4LUVhNbgBHGu6l3W+qW5QifHw/NgvIo17yhvj3nD3ObEP6L+El+no3u?=
 =?us-ascii?Q?XrErQ24YlSylJk/Vn7Dpowkd6occI8IGOUD5Jci+oXQRVnrbh5DC9eI9nnpn?=
 =?us-ascii?Q?bqIAYx1iUeW+2hy9f3rJSWtk7EGbVsOVkDXMBtKoo6i4IM/nScFHnIU1n3Ai?=
 =?us-ascii?Q?eGHbWikOXXldGgbrwcCzTO1exuD6q6CU3bAJg6G+AHM/HddsGrKCvHWIkdl4?=
 =?us-ascii?Q?6XbDAmCzEBliuq1bYxmxxvZS8VdDbOfMs0ujXBvjYq8yNf31jFNKr6HfVorI?=
 =?us-ascii?Q?9DD2dtC6MzDBc8YFCG9pwEEVucM+kYYgr7RjrcUNizFIClVWh6DZzkQ3HxxP?=
 =?us-ascii?Q?M0oLVs6FSMtTr10iPf7b+S1cEgxpmYWBdbvn4ynKWBp+01EyFgsagJSWWE/t?=
 =?us-ascii?Q?HanJNmRtVJPK8aBxTJoKKGCyZPW6RWEJqHWN/dIMrHcGHqtX61+oPHguF887?=
 =?us-ascii?Q?sRtxhzarFAg9RCFZzw7DtswXmMqgJP7D8e4ZLt1bipFVrOUtK972clVAIpYk?=
 =?us-ascii?Q?/cXWQW0Q63peqrukkqFA0HM6xgqEV1aUdBbz8Ch0qDMyU8uKQGHKrhIJmXjO?=
 =?us-ascii?Q?o5m3spo/H/QldGcuD4h2gwvhlk4gakfkIFarlSoQdpc3LBAMzKgwadhB6NRl?=
 =?us-ascii?Q?IOgKHmEu2HIpDnVNObIWLqLEUo9zIKZijvTy2Tzo5MX2vsHoyOH4ASqJSmPe?=
 =?us-ascii?Q?9pJpjmCF/FikCUdrmKPDmEjz2sKF6TbW3r2gbrIHGAFw+97PeBiKRR6KB6Vt?=
 =?us-ascii?Q?tI2412Wu/GHCO9UEONAL54BVpip9XcIoFvBYeRc92uJPu052Yv+3/viF3ODh?=
 =?us-ascii?Q?cadulJZ2krQb756GFCENHk3+hbxFutPRFlmQS909VJcWkDoij+ahGIo4+UdP?=
 =?us-ascii?Q?jR4OmO4Di+VAzjc9YU0FBT/JTikvmg9HJc1uIhe+uEAHsc56NXAPeDx/7eQd?=
 =?us-ascii?Q?PAHsOhDbiMUsB3YcCCfIppB92N82ZdokHdiRxA0WxPsw5bi55ZUm6oBEPug4?=
 =?us-ascii?Q?Tm0coGRDRzavy81t5ff95SlMRQ+vihBwPnTm/2CYGB+547SHuuvT60VtJDaY?=
 =?us-ascii?Q?/pBbserM+jV9WxN3QQyuYUSEpkvq+fux3Aw6iTDxGYqJeWOk3qxkW+IwdVzS?=
 =?us-ascii?Q?XBphEmk0hDHSuHCtz3E+hIYjI2l5llNTCw3ot/bQ6pskoJ4j97oY9Lpqheit?=
 =?us-ascii?Q?khnHTav+DAWR504vp4TUD0sRkNWk9sxvQwsvAXtLnFZZDgHwL2pr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ab7c92-dbd2-41d9-d33a-08defd451d13
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:24:01.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwJ99BFnhwcCKlY36O6oUEx9rImDBpZB1HfkCj3xY65lKFOPDBK8/39M75cpX9ZSaHBrW2SI5o7dxtaSYyLC3L8eE9WBZi98lvZnVysEgMHkzWE6ffPlabH4ZAVEQX4a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9055

On Tue, Aug 18, 2026 at 11:16:59AM +0200, Stefan Wahren wrote:
> [You don't often get email from wahrenst@gmx.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
> pin-compatible alternative for the TI TCAN1042.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 9f5c37ca6496..2ebc954ce769 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -24,6 +24,7 @@ properties:
>            - const: ti,tcan1046
>            - const: nxp,tja1048
>        - enum:
> +          - microchip,mcp2542


which compatible with ti,jia1042 according to second patch.

so just add microchip,mcp2542 after microchip,ata6561

          - enum:
              - microchip,ata6561
              - microchip,mcp2542
                ^^^^^^^^^^^^^^^^
              - ti,tcan1051
          - const: ti,tcan1042

use
	compatible = "microchip,ata6561", "microchip,ata6561" in dts

Frank

>            - ti,tcan1042
>            - ti,tcan1043
>            - nxp,tja1048
> @@ -72,6 +73,7 @@ allOf:
>        properties:
>          compatible:
>            enum:
> +            - microchip,mcp2542
>              - nxp,tjr1443
>              - ti,tcan1042
>              - ti,tcan1043
> --
> 2.43.0
>
>
