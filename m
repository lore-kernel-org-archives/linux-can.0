Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795704455;
	b=R7hRasxEpmiL/6h5L1tkU5mPUm/Z/d/7etB09j1Lip5Nr+o2IbfMCgsstO116slSyFQQ
	 VNwvuGm91YSEV93/xxchj/qmd2oL6mXvJe+ouOrEMMS6EyOjIpISL1/ZD1rooBTcBa8D6
	 BN7o9MquKUuwqS/alFo91oJgQ3zBlV2DPOmWVvQ8z9bst5a3keDaLnW58MV6p4Eju9jn2
	 lTug9bxgBD6zzqCSV6bznmuhy10YjRGf+YOrSqzg4GjgNRhGWQlHGZwZ7BuwcvoNdeGxh
	 YpwFyFq03aoYjispuaq34QaGZs9lF1mzXiI+8dmfQdcTcwFo2lQJ0ZpdJK+On42KPhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704455;
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
	bh=jNoU614Wpq9CVcJz/pYSIoZs8nHP5rZEdlI72cUPFtg=;
	b=WHD6I7zsmjb/2VDd/sUsELJQfUsBbAWZ4akk2/YndbaSJslyS+7GUK9tI17K6A/hKaVr
	 bgFjUwpt3PR27aq9s4O050p0fl2i6G7c/0RpUqZm4ubY72asU2viuijI11/E2avEsEunn
	 BqHgCxgyIg6u9Pb4YBvFNNz7asxFbb4RIc/MmR/azlGaq+sD46YuDRv/xmgMTo39EAigW
	 dzCOldjWhYElE6Wr12g8xkjDWufGCj3nDH9P3CDOHF/GcjBUofhuYJv8WozeQQsGQ7Ftm
	 cBt9Rg7erTrqrUUh9t9QyK2dcLibR5z+yfBnYpo5c5LbjJKNQVgYUzyXAFzODM74a1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ayv9qBvC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.25
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01448606A329;
	Thu, 26 Nov 2026 14:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01448606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ayv9qBvC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfTNyX6y/h5bwsnviGIF0nwi72xm4Fp0wYPQH8ZOhbgjpfjDekbBYfsZIboKEcDFZt1PF60KffVxueX3lzR92E/aJeQRVhWZWAUBaouSQL3VHbwyWNhorFR2MORmntQ2C2ZGy4l/dkgEM3JPCVs50p4SdLTuGScOeYoI7+apuT+OeSIpDkrYqw5Xd0+5ZjlyWqa6znFUoJXB2tID7x/gjiirethfWOk6ql9JKIHPjA4fKm6lbLw0Rk7IvYKSctdJYXPWXu9q6n9D6SJqw9WqCQb2SCMGRhxT1FxdQYhNvAhQISfuelynag8rwl722QDKmuytH4uadKp9kLRvF9ebSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNoU614Wpq9CVcJz/pYSIoZs8nHP5rZEdlI72cUPFtg=;
 b=anftaC6C8TfWWRt4gAKfrEleueRnbqRi6s2NPVU3t17t+I9tGnl+caNcuCpgTpcB5ZHSsR31uAhbPdktdipT3O8UwXZaz72CRCVd2q8sNGWfddLq1mJ91FsyeJ3HjN9rCmKchQg0piCpzo1mxTYE3D178y2tuBOK8XSS3XiuSgnaOmexQW0leG2fnX2P1qo39t0SVTRQV+8yw7XIw02BgaMSpZ016OJzWbK1id9+0CP2Nu1FmFjiYIhDtv0/SdnMG6Mj6Ot/pQPUvuXta1ViEslpiQ3evVuoF92mc7yITAAQmTb4rxK4/UfuWq8VQurNgEVZF1Jn3oM4lzTkPrl+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNoU614Wpq9CVcJz/pYSIoZs8nHP5rZEdlI72cUPFtg=;
 b=ayv9qBvCLZMzeO3qpzkahPEb5V3EZkOnWFagpZaPbYYncJQVsIgINYt7qxMTBYiZPP47QsJBktHfTk/y7PkjuMOO0UXW3CllemUlvVx1GfAAApfBbJcEZKFcnDrCBz9dNvUynyV5wPnlTJO71UGkNER9VXji4/i2qMDjapZBaVEh7fkile0d+0S/BQPq505Rsj+7bD8TFER5dYpb1eZgAClfjR7Upx/+jwwf2pJeCWDFw6uJ9cdq1UqcKTrDCaCx4v82OxPQbWhbGb2Q7g+FaWf399g3mouuWrWOyB5Wma9GujWsIQU4AdJWOmLwVsZDD2qXbS3/R/Zm10vMLQMLKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 14:47:20 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:47:19 +0000
Message-ID: <4493a909-075e-4636-a792-f84dadd3a018@oss.nxp.com>
Date: Thu, 26 Nov 2026 16:51:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/6] dt-bindings: arm: fsl: support chargebyte
 EVAcharge SE
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
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261112130506.12823-1-wahrenst@gmx.net>
 <20261112130506.12823-2-wahrenst@gmx.net>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261112130506.12823-2-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::28) To GVXPR04MB12316.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|DB9PR04MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 10190e8b-3d66-48df-4eeb-08df4bcc2bec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|261026121527099003|261102123227099003|261021121427099003|261009223027099003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Albpt9n19VIKLCHpDXRuyOApsMacrwOEHacKJCwBd/spjGbhf1bvA7RL62Q+/OraJTrSS+fa6mvjFl/sP1j7jZKj5CAB2pJSB/HZ71sdfhp/INItQnFfLuZS6v5+QM2AVRf71l0aThKjDd4mODMUXqrp07qlD9peyxNEqbBiF3cM4CVvX3PqV1X6nTsW7jx1CpDID3kcPgGEsxitHZfaocQolwgMysBJuHHOvLeofdF5TzaLazsGbnpXtEAvFgUTylpgPsB56VbbAgiH15iYW7f8P030NjaOS8CKVRJGxHWou8GhPfs5kKkwx6BP+gmWKzJX/Rs+fV8CgwdlDIJaBWq8C8PlrsO9QAyFufG0+Rhx3bNpdLsKYciKeSj80Kgcg7H25U1XfxihIQEujvqxAOHCgnTV2q4QooFHn2buPnKhjWeSQHWywLF/szKuy+YOWwb8uezp8xYSJxcNlX+vyN31a4vFub5wicBxMkIGNpySa8MoJPiqgysH8YwOpl6ftd+gw6mSF0xrLhuh1IEw7MTxgDjdKPmhb3wrpzJA4njX9Q/3H7KuaNAI3pywF2mfAu1DHnMdiYBScRS/DXBy7LjWcwajahUPG5vtolTSQDQSvE2iZz+aKKWYPoEhzjPx2eafzmhqNFojBH5HkN34gpPaJH6/YVF+9jvnTfHXtdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(261026121527099003)(261102123227099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzVLRGJGL1l2UEFTY0Y3all6Z2F0OVE4RzhPenlIeDI1ay9adlR4MGNabVhP?=
 =?utf-8?B?N0ZkQjJ2U01oVXRqMld0RDBaV3FlTUQrNitHZm1mUUV5RXlNd0djRmJMSVlE?=
 =?utf-8?B?YnNsbE9WdHBpQnY0ZjdOUHVJc0loUy9lUS9hZ01GelB5VkE2b1RrN2hUdnRC?=
 =?utf-8?B?UTg0RkpkSXArL0JVUGpFeWFuR0x4Vkp5RW43RVZrZ3J2NHdYVERDcjlyTVJj?=
 =?utf-8?B?ekh6QlRtSFBCQ1k5WVRldml4dFdDdmRZVXQ2K3VZTlFLOVdXYSt3Mlh2U2RF?=
 =?utf-8?B?dTZ3azFkZ0NjVEg4eVFJT0VKeHo1anhXMmRpS0tjSzd6ZHVnUUxiSE95Wi9I?=
 =?utf-8?B?UitVTUo3NWFrNlljWEhJYU5kVStrYUlLYzc1YzdKY2NRQ1oxZmtQM2ViQ0Yz?=
 =?utf-8?B?NlVoTUF4UFpsRHIzemxFdDJHVmVldm1xZituV2pXNDd4SkdreGFrQUtWTElT?=
 =?utf-8?B?c1M4a0kwN24yV3d1dWlxUy9xVklab0k2eXFTVHBWRmgwaVZsMVdWOEZRbllz?=
 =?utf-8?B?MzFPSkFsTFRCUlZRKzExa2dJYzBTK0dvRDlyenBpMmFoZzBoSlg3Z1c3ZEto?=
 =?utf-8?B?enN4WFFrcTNmdU8yUTBteDlJOWdDMVpFVWMxZ0E4dG5iM3N6YzBzZ2Zqd0NS?=
 =?utf-8?B?a0svVWhSanh2ZHBLb1d5dmhWenNXVFFHWTVnR2JMZVlUa0k3c1F2bXJoeEw0?=
 =?utf-8?B?WXpIU0k4UUhjUjB0Qzg5N2dqSnN1QXdDM2ZYR1JTSmw3UXEzRmMxV3YxMll1?=
 =?utf-8?B?aUZXRml0NmRNdkdRbEhHUzRoQ2sxSDJLZVNLN3NmdWNOYXVvdnpUM1lBZFBD?=
 =?utf-8?B?K0VoSDBPbW51MWNyQXpDalNlb1VaaDhuRGNFbVhWQXNEODJaQVpNVURzWlpN?=
 =?utf-8?B?ZStVWVE3aC9sMmRscFd0NWMzbzhva0w2Y2p6eDhjd29VY041U1ZSZ2hLdUEw?=
 =?utf-8?B?V01OOUVLUitIUzNqQlRJSHNwTXQxdjkySWZLaFdESkRWUml6Z251RVpDdTB1?=
 =?utf-8?B?dDc3UGNBVjZ0TWlheGZlTEkyM2EybkRYdmR4UWxueCtua0tZMjB3YmNNdmdW?=
 =?utf-8?B?elBHZUlBU0JlMS9iSW9OYm1LTkJFaVFmNGxwSTR1ZlMrVkFJWlB3U2lRdkFp?=
 =?utf-8?B?M0FyTzF1UUQ5bVNBcm9TRzRaQStrbHB6R1BmSzYwNUNJR1JyYmpRVm1WQ1B5?=
 =?utf-8?B?M1pKcXV5QmQ3dUxnaER6b1ZJY2hCMVhPd2MvZ3gwck5pU3dCVng0N3N1ZHl2?=
 =?utf-8?B?MHkwajk4OWhocFQ2QWFhKzlwbTZTNDhlQzZ1c0ZFSDQ3a2VIb0VUSU5hbUV5?=
 =?utf-8?B?bUZLb1hoVU94cmYrUndtQ0hGanVtLzdnM3YyTUc1RVpaSDdpVkFTOTdJOGhD?=
 =?utf-8?B?T093cWxZQkc2M3VJSDNsYzV4WmlSSmxNWE13NEtYMVJVY1U4S0k3UjJHYnRt?=
 =?utf-8?B?NEdmNUI0QTlUMHlmMDRpaHBJc0xobUk4Y09lcTlva3NOZ3JUWjMvVU1keTkz?=
 =?utf-8?B?SFRnNmlLYXNvbFF2a3dDLzJlNmRsc2ROUGx4c1J5VVpjeCs5U3hyVUZTMUpp?=
 =?utf-8?B?T2dpbm1MVnFjS1FmdjAzdU40MStPNm8yTGlha1lTWDcxZXNiQ0tqR2doOVFq?=
 =?utf-8?B?Mjh5aFMwNlFPRWpobCtRN3hwb2hqN3E2bFlma1g1azhrUFpsSnZrR0I3Ymk4?=
 =?utf-8?B?TGx0aVk1UjYvVU9USUM4NEUwc096czhkL215dTkrSWFHSHluQzlSVXBOVUZy?=
 =?utf-8?B?cklLMHM0eFBpZ01DTFhZdjR4TUI5bWRRYXBSamtOTmgxNUdFaHJLbHRVUmor?=
 =?utf-8?B?RGZEZVRMZ3NuSDBnNUl0ODZwOW5DbTkrekx6bHNLRnZwY0hFZS9CcTAxVXF2?=
 =?utf-8?B?NjFBNjQxVUQyRXJuc0Z6TVBBNTF5bkpxVXFEcFpmQXBmL29pZFNPV1dFbUtJ?=
 =?utf-8?B?U1ZaVGFqSzN0RkJzUHp6OTc5cmFPYUMwUytiRWNPeDBadnY3KzErS2NpUWxC?=
 =?utf-8?B?aGM4NitqNXF1dXBLY05jVE05VlpGVkVBckZoeGVGN01mWC9kWVV4NEQzOHFS?=
 =?utf-8?B?UzF4Nm83YmRIZmlrU3lSdEJOOFMwa0NESUlQT1RSdDVsM1ozaTJCdDAyOEVl?=
 =?utf-8?B?MzVxZURsMmF5Z093LzJkTU5xQ2ZRZFlnVzN2eDRJQitMN09DQ2VYQzcxdWVM?=
 =?utf-8?B?eXhiRTdkeDFidHJzUGZSQ3orM0ZHdm9TMHF5ZWtYR0RyN0YwUVRQR3dsWGhN?=
 =?utf-8?B?MjFqNmIxSkgyc0F3TVdJdXpLNm9xQjluTVQxT0tpVXhveS85cXA0TFRYMXNH?=
 =?utf-8?B?NnQ1TmFEd1dQdDRJd0hoaWhQVndLK0FTUXpOUlpBUVBWdjRtVkFHQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10190e8b-3d66-48df-4eeb-08df4bcc2bec
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:47:19.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ceg9lw6pFO7XTT1KqoioQGs9ScJXxA9SWcdgHyXQo7iOR80xrMkr9F45CbD17n8itTqEgeYNm8kJh35zMfMWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9236

On 11/12/26 15:05, Stefan Wahren wrote:
> Add devicetree bindings for chargebyte EVAcharge SE board.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index d0126f54b387..65cfaf5ef6d8 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -92,6 +92,7 @@ properties:
>                - amarula,imx28-rmm
>                - armadeus,imx28-apf28      # APF28 SoM
>                - bluegiga,apx4devkit       # Bluegiga APx4 SoM on dev board
> +              - chargebyte,imx28-evachargese
>                - crystalfontz,cfa10036     # Crystalfontz CFA-10036 SoM
>                - eukrea,mbmx28lc
>                - fsl,imx28-evk

