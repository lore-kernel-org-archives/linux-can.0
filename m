Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795704496;
	b=BRh7kSbA1SbKkf+pDOWbrl73NF6eo/dWXLJ8bDvR8tRJ5Ey84LXhK1INibGgMFPKz72Y
	 fHii5DGrbGAMFYxygcNyDt8yOk5g9npzjfZo30DknORI/i5diXsB+hrSFR+vGROAmevVI
	 c6QOGUstRlxmDqkk+c34zwonFyFQXrgv8ZfOmp3VjwriQbj/tGwvG7UTHLhiZI51OE0CU
	 pInVTSCtFcprbUJjDgWAI7AVXYEP5F05dZSx+EcpiLlyznWcZx2SVGiTDSsSNpBGN45wS
	 DTaWKztZFZnScRKwHOJkSBJqKWmyo4HAVIgq5kw3EfObIEVm/9kdsgMgid6MpVagEDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704496;
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
	bh=5LO7RPiT3DMJHtUYujvYA7ct7TJFBwGTtV7kXuOlLrU=;
	b=YixLkZFzTZWIT3XdEj5qe9xdtvWOF/hU9pAlGt7YHecEeneuTKL9Scr57ohAH0+ergHJ
	 SAKC1LvWnDCoigcRRmC8jl++t1EN1ziRqryv4XRHtDXr5dhMyx6HsSU5gmgDeoo9HQHfr
	 WYGnD9GHMuOCMBw6JC6u61yI/nQzzaint/36RVKvo2rTHue4hg2dMJjS197LRtGFbhdRV
	 Ph8o0s4WUIXmOUfQJ5SHyOHKamqDx920BnDLvzLjlSbVSN9wtvUXqB0LgNZ/L0Ku4ylyg
	 Y80fjK46aNh4/dtweDdGJRv2/mX26lmM/Vtk1yEiSAO2MjG1wehChWRfAvS3mI/MkWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jT1q3LqS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.53
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64002606A329;
	Thu, 26 Nov 2026 14:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64002606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jT1q3LqS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdThtQfyfy63U380VSQ/Ev6b77y6spAIsZC/ilJ60/2I7XbGGQCrFODGBWxeeIKAQfrFAKcjhi+zRSQ8qOl6kiIRXy6/orRCBHkOkLUwi9dE1qc/lL1gZUGprwPeltq22QqxclY1c6tdYl5jfRXOF8U0QdXmXg0GocPvq5fuB6suqjAh66zOWIjjacSRRyKUizsbJ6J4b3f7Ln1tY+kC8/FYBwxj7vcbZfmZ/mWUZnWno4HxHKu3j05lmoVvbeuL/P0qb3Poqhw2uHGfX8kr3lQ8Yadp5WktIPLheVTg8uaMz0cgV4xapQeH1BGEEAfkfhsbLa/nb0SuZnf9k9GxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LO7RPiT3DMJHtUYujvYA7ct7TJFBwGTtV7kXuOlLrU=;
 b=QSbPa/2xAf0hWZShRn4Q0+vhjklK4tb7PE/Px74m5ptRUhZw7opmCOHhKwCJBq9PHEUb00OgAZvuaxWaIxN3GDrzPgDikAqS/Gcx2iTvmdQCQkKXd20qzJrpO7pecyaf3JPCgEETYdpN5VkeU+fLKWTx9YvgN60/Pb+ieUpBoY++ezxBG96XP7p1NyNu+MQo53O2cFOpfjWKKnLSujSlos80y+2IG7LMC0yyF0h5A2SXFa/T9Yp4TCCqqiSxzg8/c1FQmulNYZWPJIAZftQdkeuKjicwJUPFMr5Abl4YJV1ClAIUr1ii0IdN5gV2bWZ4GBSVxZM50qVVm/citcQi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LO7RPiT3DMJHtUYujvYA7ct7TJFBwGTtV7kXuOlLrU=;
 b=jT1q3LqSWZA+yBBoqZYUIC1vnkge58QwnK5p7zYzsrDykQ0aGYjBSzwNELMFvvuMRsaXCA9mwWnYxbSw5eD1ZVbsA3XX/VMDhPFlnh7VXQVkBHOBtbRKE7yfZHIscnK7XnBchebDGSxTvXg9MeiVXXJIlCaP8cUVvW8DLtJXYbCVLKFI5aGJ+hbtFQvm+Mf+ZRBGc/aHhqwHLy6WVIMR+uHoI344ls9oKCkfIqq/5YMyal5LZf/kaZ4WyrdpSqcBuf2VmFrmQmCVNl49Qp3snYALxQlmMjQpC8YhJwLdq23Z7hDEMErmIkEW/rz3vrde5ZP8yR2NBi8LBUqPnqDb7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:48:08 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:48:08 +0000
Message-ID: <ff28c797-5b3a-4bd9-884f-cfb64cde0330@oss.nxp.com>
Date: Thu, 26 Nov 2026 16:51:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/6] ARM: mxs_defconfig: Enable EVAcharge SE
 peripherals
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
 <20261112130506.12823-7-wahrenst@gmx.net>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261112130506.12823-7-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::18) To GVXPR04MB12316.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a91a276-77b0-467e-324e-08df4bcc4925
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|19092799006|56012099006|10067099003|11063799006|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qUltapPZhUWWP1Y4znn+SSqjH+vBezzMkunIqHXlrGbsZgX64W8+Gr9l7twMZZ7lsemu36DKVtNAC0+FPXFubRJbsoagkuutUzoPkUYabY4l+TbqUiHhYQYZ5T01WauxJIw1c7qo6/4o6O3FloqfW4K8oHm7EWTFIyDXnfCTOtZXmVVt8S57Abe8z67c/8h6aXlv2RPs6BIN9BosgA4OspaZ5OIfJ7z9EbootduUA3P5wshrpYIABmrsQ/LKLmEpGNoH9tBH3h8027xfTDc3Xe2rKOtq9W/KtbnugRxpkDXhOhCt0Ecsixp09OsuEAVfx8pmGsuF6hNdlgpnGJvG/vCWmi83vZ8XAqSMxDNLC5R0BOjfutZHtlCjBrtNk/5d38rkCIwDQqaflSlsW90bS0xeVsPvkz9/j0ZLbC/eFV5LDC10HOAhGrmPSB2d5iZ/2HtTFgtH8GpSrgiNA4bIECsQy6x1g4rkiD6c4xY3J827SAgV+0/O1ErvYfGSSAJd7Dken1YtSkj9rYMMjpnPrPFqhkC0Qrpg6pTqg4wvGqVVsxibVvzpCR55HWpdeJjEO/HnSwPvI+cv4hy4qeoV9f5kFbcpYUZJ3C8T3wFeIyDn2VYqIPNSW60u/+bt2NicSSidbVl1yHa5KsYLvNIx0wt7HBxiBM4ZbpMhu4fg8pY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(19092799006)(56012099006)(10067099003)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ozQy9sRmVTRzY3eER0TGtBVGo4c1FVcGlEUjhWald0dG01a2k5ZHhCaSt3?=
 =?utf-8?B?ZWlEY2tKNERaVDMxRWZ6WTdTcTFzNFFvaWxzZ0NWR0NObjRzQmZxY3JPNE9N?=
 =?utf-8?B?NzZsNU9OVXZMSHRsYnk4U0t6YTErRlp6V3JMZ21TS2R4NU1NMEpKQlZWVFBL?=
 =?utf-8?B?eTdFbWJMczJ5YTkzS3VJdGZMYm5qbTcvOW02eERkUXVOb2pxc3U1MWR0SGl1?=
 =?utf-8?B?bWVOREM5bS9qV1AwQ2tmRmFWS3pqa0xQU2lDZ2pqZ3ZLYWQrOGxjVGZuckxC?=
 =?utf-8?B?OGowRHdoRUkyekpoOUErbVBlT0N2WDhVWWNRczJ1S2tXNmVWMkg1cGhuMC9C?=
 =?utf-8?B?Ti9nNHN5WTEwY3BGYXRpbU1QZjR4ZnBHRm5IL2ltT0oxcFJWNUozWTI3VWI3?=
 =?utf-8?B?YnVlVlo5azhKeW81NG51YzZ5YzlsUW5xRFVPWG5nVU04OCsrTVRtdzRLUEZI?=
 =?utf-8?B?Wm0wUGZ2eU8yaU05OWV1K3ZrSG5qTVNUTHhPVGlhbWF1RHpaNktsb2ZML3FK?=
 =?utf-8?B?MytadmF0UTZBZGQrV3VBODllYktFNktzd1Nyay9laDVmV2hFZ1lKQzFKZXIz?=
 =?utf-8?B?dFEwODRJL0xBM3pvRXoxUUhoSzdYamFFclltZVhEVUdrQUtNQzkzckFoT25S?=
 =?utf-8?B?UTI0bnBBcEV2ZDg2djJxRStuRFhqNE95Mk1UUEcyTWdrK0xEeDZxMFozdENz?=
 =?utf-8?B?NnhvWTdEZlh3bk03aHNpblJJU2w4TmlXUHF5TWZEVVRIWnJDV2pXZWNlQ3dE?=
 =?utf-8?B?amhoUmlJRExqQlIvQ09za1lVS0srTXBrMTFTQ3NPTW9UUnJHMDdOQ2k0Z3ds?=
 =?utf-8?B?ZmxUakFoYTFuWHAwcTJ3eEQ5ZjBSczRSVitJaG1IUHlOYkczaE5tV0x5aE1i?=
 =?utf-8?B?amlxbmhkQWpQZ3Zjc0xUelAwQlc2R3VpYzczelFYcDhzS1A4SmNaQmJpdGlk?=
 =?utf-8?B?YTZrRmRZUDhlRXM2OEZCUUNrbzJ1eS9QTHZWWUlzTWh3RXBtWldvbDM4clVS?=
 =?utf-8?B?R3o2NTBoT1gwOFB2UFdPZ3hJMkRDdzFsQVdWMTdFMG4zU1FkbjZBQUJtQTBO?=
 =?utf-8?B?cXVvazVsalo2dVpOQnRhYzFTUS9ZWWFMQmVPbUNzWWhzRGlzTzlJOXUxZytZ?=
 =?utf-8?B?UGIwTVZiLy9ValZJZHY5VGpXZTlUVFdGVlU4NjBkYmFQWDlHd2xBd0w4WFlw?=
 =?utf-8?B?eFQvcTJFTmlQRUFnQ3VLWEp3ZW91VENLQktGRFRLT2d1UVBIdURKTlVTUmU1?=
 =?utf-8?B?MytCNE8wN1o2NGdFNjZ6T3drdzRZNUtqb3l2QUliR3hWTkZBVG5rbTAza0RR?=
 =?utf-8?B?NHM3d1RvSW8wZFlweG1OYUFWbktGMWs2M0tPRzhxNU44MUdyZHJpWjR3d0xZ?=
 =?utf-8?B?MEFYUnhCV1NsQVI4YWppcU1DbVozNktHckZsZDg3TDR6YzlQUC9vZDNSWU9P?=
 =?utf-8?B?dnpCTGk0Wm0vUG8xeFFhajFsdmlnU1FOSVJmb1QrOVRqZ3NDdm55am1FVHJr?=
 =?utf-8?B?ZmNaNTkwMG5sbURDNWFiekV2MnRna3hwZXRzTnFrSW54b2lQWTVvai8vMCt0?=
 =?utf-8?B?dkhLU0NyOVRDTnlVd2UzY2xJMDl3V2FTRTVXMk5nZGttRit6OGZqZHlWSHp6?=
 =?utf-8?B?MUNHcmpxUWd2R3pteTROdC9QaWs0SlNPV0E1SFlkd1lwOEY3QW9VL3NkVDc0?=
 =?utf-8?B?cjFhTkM3MmtrQnZSdi93YzZlL09GeHJrOUJNRUoxMDhDbXk3ckM4eWtwaDMx?=
 =?utf-8?B?Nm40dk5QSEdlTCt6UStxdmpDOFQ2RllweEFHamwxL3F2dlAyUkEvZXNVSnpG?=
 =?utf-8?B?V0ZMUEpGcnBTbzJSNTZIUnhXSUwxL1FkQlpQeEJoRURlVlkyT3JHTlhzN1M3?=
 =?utf-8?B?QTc0Q3VyYXFncWkzdThkZVY1YThzK0J0QU1MOU9KYWZWMkt2L0VLTVFZckV1?=
 =?utf-8?B?TG1Jck5LQlZhUVRYTGhaQzV0MEhLTjh1b0lwZS81VFZEMk5Cc3JCOFVHSGF2?=
 =?utf-8?B?dm9XWWF3N0NMT09PYzZrQld2RFVvbUthbEJmWTM4UEJXeE5hU1NLb1JYa29G?=
 =?utf-8?B?TVlmZkI2RnRMbHlGK2FnRG9sWGE4Q1hhS0J0YlRJdE03ZFJMRDlJcDk5UElD?=
 =?utf-8?B?L3NuS0l1emh1T1duUUFndTBVdU5ZU3h3REpyckZHcUJFZEZ3Tkc1MExkdzVX?=
 =?utf-8?B?dVdXNE1JanpiSTdIZ3BOaFUxQ0x4UEYvamxObmNNR085cmdsK01wb0VYWDlw?=
 =?utf-8?B?a1lud2Uwb2VWbUJPQVVaR3lGZWJvWmd4ZnNBZFZaZ1N3K2pPT3pTWkxxTCtG?=
 =?utf-8?B?c2hvVTUvUkNCWm84T2JFRHNMQzMwZG1sUFZPL0xoSC9NZWo1SThIQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a91a276-77b0-467e-324e-08df4bcc4925
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:48:08.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF6T1zRpqp878yPG82gTlxsqudjC5Pxo9z5LMmDmbA/SSef1Sm7sNO7L4LhXCzNa40ci/NpAJ8oq5FYiOSMIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386

On 11/12/26 15:05, Stefan Wahren wrote:
> We need to build the PHY CAN and the QCA7000 SPI driver in order to use
> the peripherals of EVAcharge SE.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  arch/arm/configs/mxs_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
> index b0b5eb33d01e..456378a53ea0 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -52,6 +52,7 @@ CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_NETDEVICES=y
>  CONFIG_ENC28J60=y
> +CONFIG_QCA7000_SPI=m
>  CONFIG_ICPLUS_PHY=y
>  CONFIG_MICREL_PHY=y
>  CONFIG_REALTEK_PHY=y
> @@ -132,6 +133,7 @@ CONFIG_MXS_LRADC_ADC=y
>  CONFIG_IIO_SYSFS_TRIGGER=y
>  CONFIG_PWM=y
>  CONFIG_PWM_MXS=y
> +CONFIG_PHY_CAN_TRANSCEIVER=m
>  CONFIG_NVMEM_MXS_OCOTP=y
>  CONFIG_EXT4_FS=y
>  # CONFIG_DNOTIFY is not set

