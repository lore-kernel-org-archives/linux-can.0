Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795704726;
	b=KGwS9XB6yx8k7XzT6COhTFHIV9IXsy2Z7/gNzNgo5DPbhmpLrIvRb3PhcbW3iME6hdu8
	 v9HXDVRAqqRLa05jK27ek9i/B5IS8A9yGJ9Nq4NHaiX7QeN102D1Zh/GZceApqT7m2sk7
	 pDrakmp1XxMIbkhiEE2JgiWsZwM3mA99vJu3N6ymbOTFzDib2Mkqj7/LUyS0PH5zkYNJc
	 /vx2cuKOMTlCYotm8lAiwuwhSu9wAGVqXO6naTQwSglLxrTIEwgWuYlnclzyjG/96pT8T
	 ikSjIzqVt+CZM05sGuOlQdxBN35J4d3R05WIkLRdcxO+bJ2GL+/E/40fS+jAaXWzrFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704726;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=B7rOVIpCXucw6+7L0u9MzrFuJ+ClBimtbhN9ax+boqQ=;
	b=KdiAxE/+Q+eZGXRE0PXdQfs9IsPmE6LrnJY+VqVWBAcvhvrX/RFiDdS6sNFNVzjQX3VI
	 TSNSPgLslmjtbmMKyOVf5dO37c8bbfsHp8AhQzMKtYpnxIVpzH4UMQUjVU/q0VOKJ0/8x
	 qkYnfjkT/Y8dEQjYRTDtiyXpQCQUUEKB0z74AckT8ruXI3ixan010loZSM8yroI9ZtF6q
	 tfsK3W3zX/uMeCAkQrVjhxNyPG0a2LsTAymiXeKMIpSZqAV010hWvbugUcKawX5gdepI1
	 rLKX5goLLZ1xyOsi1ueOxeQZH/BxMVCmq4huLluO1z0QamCC4u59EDIUQcHZhV8HRZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UQlwqKkn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.20
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519B606A323;
	Thu, 26 Nov 2026 14:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1519B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UQlwqKkn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkcEiZyyP1b2+1Ilp0N/hCgjqKEsrvemfdnCgjiYMm8MDjSuLt4FgXglDlLtkWItCrb2jh9wlksw9DjmF3EbdWD61NBv9dt5zP/y1MCMpmNLQc1vcLI/eqAOjW/YO3sM1939Yf6ESlENo5NRzuU/ZgVYI/BfBbkomktPZbO3nhxo+ukIw91yaoSyMGX8LoGq2CeDhg/eS8qjUQjgTtc+uiULKjfwqXbdqxWBSle5KaHQmiAWTCWzrHdQll0QdDpr4xIb0RKQ7SFRrrbeFLJBtuGlXO34CN7qUqqzomCnO5Vz+YrjwR0ymF/aER6CKB9g5CTHAqOc0g+47ExjzryEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7rOVIpCXucw6+7L0u9MzrFuJ+ClBimtbhN9ax+boqQ=;
 b=SV7bjbVSkP2Wr1eDKwWbNNLvHNwkY0Mv/flnomK0561fUZJ3/L7qWfpe8RpfRMvUCk6MqLZKUFvfCFtyKl+nSBnLkRoPedkW3D5JzYY89p8ACdnrAl+T4tXMTCWT7w6RzeX4r0cHjqr2Fm7NAr6imPoJ6FY4F3SdkNHeGBjdo67lSDa7zhRGpKvp3lw0nGInKah+ZjtIdZ0iV0OQnvZd9Hm3K6w0MGtTzJh4f4wVjQqu8z7XhDV6+qm+T0DUT+O+T6UjfzU/y0cvw6y+K8IO/pSA91NCCXTvKmJEL4rD9vc0MYZoXY78JvbYlWGIT0G/p1TsqdeLSVqR6GChJNXeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7rOVIpCXucw6+7L0u9MzrFuJ+ClBimtbhN9ax+boqQ=;
 b=UQlwqKknK/vPDhUoIUdc8XnFwb368NRQP3u3lHuj+OfQPX6hmzLzI2UqGDbQfVciVrNdsEUCu/6BIWb+ap+OVNnYOJKQLXpEpj2fYpp/eqE5k60Fm1UN4CruyDPrWA+PsCIbRTRMD8vtquJcfadR3QufvR+kM7zLqHn396PgX4Hva4iUurlfx/UhhOWYnN4VEMCzz491lAmbKWnloKos4U59+N2U2tv5Nf5m5IOHo3Nqloxo1SEvAFP5B/Z21n4e9ZOa584DAfIhsAIvS6gABXxIkpM6FRYGalayWwzzwXjO0yHdipLx5uPM/of3OIP4l5HRvKpY+WfZ4Aa/1wuMTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by VI3PR04MB276878.eurprd04.prod.outlook.com (2603:10a6:800:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:52:01 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:52:01 +0000
Message-ID: <b4c626dd-0af9-4b57-8f50-2671a8e2313e@oss.nxp.com>
Date: Thu, 26 Nov 2026 16:55:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/6] ARM: dts: imx28: add alternative pinmux for CAN1
To: Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Vinod Koul <vkoul@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Vincent Mailhol <mailhol@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Manivannan Sadhasivam <mani@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261112130506.12823-1-wahrenst@gmx.net>
 <20261112130506.12823-5-wahrenst@gmx.net>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261112130506.12823-5-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::17) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|VI3PR04MB276878:EE_
X-MS-Office365-Filtering-Correlation-Id: ac021e27-412d-49e5-4047-08df4bccd418
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dcRvdB2YWpfvAb3aU53fKzTCWvYYmjQCyyqS3+fgrPlWRcID6K5J12EHl6vGhCSMLwPIDV0vDIkRIKLurKb7YtYeisPXkSInNa7WKYY86ygA+3wqFA1k5+7F7lsHNaKmTwcPJhFa0FgMt9vrsh9WhDQuWGONZRB5B50q7jcHY5YeeH6W13c2EJB7C6wmBKykj346xaQYj2g0ZGBvW5Ci8y6IigUAopU6usYUKZgTl8SFcwP5jJLRYrG6EP0JQ8EDs7FHQEW+YOGaDk/BVEo9VgtHElgaoil18pd1s3BlmbRwrOJGX0FZnvAZXVHJfKig4mC7pzqNOkNDqcz58Y29kITFtZ612MBkhlZV9tTvAwumCwV8CNG2zhsEwjBhFHnWjdh88erqULnXHDsrrydYVUarKEBSvWuYS4yewyjKEFP7PcFx2LO1amQE++aJx51NVVX9W8WFCdUOS25Eo7YUU82lqyqBsJ1IUQt7SZMt873UvQrcGzbhbybMNwkIhCWApa7uk3jewKSmhgJ0co4OBKlbjXUmw45sYAU5sz4zXJIWh/tzkTtHiqCEDWHy/YxOgM33C7v6ZxuHBFKvXlIo+g5B06RYHZ/hnZLyurU5lsNkXoLNuc4VdMls+xSmqlIV9OgdWo0CgKCnlSsYroWv3EnWag4WYCmk78iJfNNZrqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTFKdTc3U0VpUHM5TDR2RThSd1hZNGVEd3FlcUdhTnk1OVRDdWxCaDlxYnZt?=
 =?utf-8?B?MTJCd0NFQVZjMHBNQ2dDUVlCQko2aDFxdW54YzlvNVFLc2d4dDB1QVk0NVRm?=
 =?utf-8?B?b2s0QTF1dm44RVpRMlZZbnZUOUlmR0dJdk94OTBIdHZVaFp2VjFLNHZIc3B4?=
 =?utf-8?B?blVQYUV3RUwzSGxaQXdueW51THpXb2hRWll2Y0N0dHFSMG1tU0tmekEwK3pJ?=
 =?utf-8?B?NHdkcFZ6azFrVEgzUUJnQ25DcUFUSWZMaHdGOUpENUxHZE02WG0vYlNPSUVz?=
 =?utf-8?B?TzF1SkxsL3VpZFZXVXNPQkU1Q1gwYzljUXBKaEF0S3NEMTdrSWJtTHhjcUJB?=
 =?utf-8?B?ME1YK3dyYVpMeVhZcVFwL2RNU1prY2ovZUVXMmxZNkNWR1R1S2I1REcwbTJK?=
 =?utf-8?B?a01zbjBqcWlYeGljd0loNytLTEFJNDlEMHJNbVNLVi9rOEhPNkl3cFlTUWw4?=
 =?utf-8?B?UUlPZHQ2QzdSTlVyVUNOM2xQMXRVanFieGM0Tk9FTnhnNXFORXZEemh5c2RH?=
 =?utf-8?B?a0Q5aE9vZlI4bWdaRDlwTFByakdlcnhaL1Q5YXFLVGEvOUN5a09wa2thNHNN?=
 =?utf-8?B?Ykx0YnlWS29tcUtSVEZsdm1KaHJLSFBDVWFtcjNGRWZybTN2eEs5c3p6WUY1?=
 =?utf-8?B?YnJTeThRUW5uSUEzcjcxUWVrZlo3Z3ZPbjJ2amh3WUUzcGNySnBHR2FKZTEr?=
 =?utf-8?B?TTRmeGhJaWs0R1Fibllsdi9uMHZpVStScFJjcjVVWU42a21oQmZNcHU0SEpX?=
 =?utf-8?B?NHRXdE1OVm41WElXZVBDV1hUTndkaFQ0blBWZUNXWUdIMkRuOHVMVWxTcHBy?=
 =?utf-8?B?UnkrbmdESndNUVNLVGcxVWFjcWIzL1FRei9DSEU1emdoWXQzM0NVYno2Wnhv?=
 =?utf-8?B?S0FzUVVjNWpzSXZyQXk1aXFJUEE3dngzRHkrT2dhc1RZRDh3THJZUXNJWjhm?=
 =?utf-8?B?Q3MxV2RiQUNzeFcwMHdYd1FsNityWGRKaEJQU0NzVnlLcGpLMVplb2grSDRT?=
 =?utf-8?B?dVJ2VmZ5QjE1R3R5Qzczait4M1pvR1p1Y2o4OWh6SmZtZUd2ei90bnZnczBz?=
 =?utf-8?B?bWxLMkgyRHZFSDhsWm1rSlJRSDBhQXVJZHp0aDVic242UDc3K1o0TW95TExJ?=
 =?utf-8?B?WXQwZUVIZzBzdFRmMGFGYklHeWU2U2hzWVA2OUNYWFN1VUVBTVd2ZEtBdjhV?=
 =?utf-8?B?cXVFWnpHcmNOMzY0M3MxOWNkRHZENUtHTGpSemRGUkZGY1JJOVNNSHEyQlhh?=
 =?utf-8?B?UjQxWHljRUhTcHpVS2wyaGlIZVpWM3ZoQStjZnVTdDRDMlhtalFha0ZXTHpz?=
 =?utf-8?B?NU9mOFVmNmhqR05PYllzeXZ3YThLdDloMjA5TVVFaEJYWDlpZnZJSStpeTRZ?=
 =?utf-8?B?NGZxWm5TRDNJUU5hbVg4V3I0Z2lQanpRMENyQS9kL1N1RmNxV2hmY3E1c25s?=
 =?utf-8?B?eml6dDVPdXUreEFFbDJwajVDSFFVNWZpWTdCTDdKUUZ6Wk5kV2xaZUxsZ3pu?=
 =?utf-8?B?MVVUYkNkbmxWZy9IcDNnbWhrTDdWbVBaa1lTTURqYUNZdDZtZThoV242VGt1?=
 =?utf-8?B?RkdzRlNVK0ZydmxPZm1xWEF6V2R0U2wvSkJyZXk0N0VQSlAvWmhvMDJrWWdv?=
 =?utf-8?B?YzFNYjJTMWljbEVGSGNxUjhKSCt3aEFoUjNBSDNxUTlESXBLS1l2MmoyTFlV?=
 =?utf-8?B?eDd5dFdBM3VBVWtTbU8rOGJNOEVFQ1c0MDhaRzd2VExlSWF6ODB1RVlwTVU5?=
 =?utf-8?B?cElRWVMwTjB6cHdzMjd5U0FkTVAzWWkvMVJhU3FZMHFtUzZ0SnZ5LzZOWVRE?=
 =?utf-8?B?N1YxVmpoN00vcGp6OGJQMVBSUUlyMlUvYlZoK1d2UXVRNDJCMkJGWmpqZndV?=
 =?utf-8?B?RlJqWEZkczhWdUdZTjhOTnZHSlg4MFdTWHJucC9GTFlkQml5dnVVcklhaThp?=
 =?utf-8?B?b3p4VFBkNFcvVlduZUgxVlRpb0gxOEgrdFBuS0xxclljUzVQL2xabDEwcXhj?=
 =?utf-8?B?V2pwWjBTeHk2ZG5XSkV4akFuUXM1c0kva3NkS2VGRjhNTW0vTmg1d2xsNTN0?=
 =?utf-8?B?TmFnYWFFU1BSalpreEljVU9HaGRBVXRxQXFwd3FCTXRzUHNCcjYvNzJwL216?=
 =?utf-8?B?MFhYaFhFdE4vWVB4Mm1WUjZWUXlFQ0ZoMnJjS2x5S1FSVnJlS0tTYzB1elB0?=
 =?utf-8?B?bDBDSXhVbjVWemxOdlNsRlJMQXhKSGN1MFFGTC9aS3h3c2h0Si9QQ3B1TUsz?=
 =?utf-8?B?WU9rN2lMU0l3UTNqcWtoaElPcUNLWHgrS1dXdU9HMk1ucHpLY2pXU3VYaHBt?=
 =?utf-8?B?VzlDM2E1aXUyT1FMSzFNNG1yZEh5TWNtOUZ1d3doazZ0dmljT1hWdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac021e27-412d-49e5-4047-08df4bccd418
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:52:01.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gtq4/JIk2htM6qMoMg/cGBWMasfLhfh4A75pO1fKPnenziDSpAdjrx/pdPfnVGykrAL4z7gfSdJIB0dlbvQLwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR04MB276878

On 11/12/26 15:05, Stefan Wahren wrote:
> Add alternative pinmux setting for CAN1.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

LGTM, although this could have been squashed into the next patch.

 
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


> ---
>  arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
> index ece46d0e7c7f..ee567aa6f561 100644
> --- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
> @@ -885,6 +885,17 @@ MX28_PAD_GPMI_CE3N__CAN1_RX
>  					fsl,pull-up = <MXS_PULL_DISABLE>;
>  				};
>  
> +				can1_pins_b: can1@1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						MX28_PAD_AUART3_CTS__CAN1_TX
> +						MX28_PAD_AUART3_RTS__CAN1_RX
> +					>;
> +					fsl,drive-strength = <MXS_DRIVE_4mA>;
> +					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up = <MXS_PULL_DISABLE>;
> +				};
> +
>  				spi2_pins_a: spi2@0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <

