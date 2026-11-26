Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795705834;
	b=jrRB7UVxxRWvlyYzMwK3vtboLVOZ9RZ5kiVrSITj1vpb+kSdFwA5p6KlyJZZFedHHeJd
	 ehD6gEyv3SqbzvUbahmkQwp479yTFUG96oDwlhWqYAGMZ1McyT6SXn6oUsa/P7sh85/+A
	 6DTb2OKhFtsqjCTmQosEmJK9nrtNeYNoZnkWEvZAaenacXIow7r6r4BSPLQNUhwPpE0Tx
	 ZGrTEyWK6yW4kVYUoew+8sFtxd7rlWgDxCprVtrknWtjJEnAMwIxFlUNgriQtAvKfPc+t
	 toDmpNdhxshbVez1A4W6rqJwDnvaJ88aZbL3sgMJ3/P56C1dwMNXV7i6WTvwC2OMzQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705834;
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
	bh=XnNMFg3SLzTrLl3b//II3U+b+BfXwLVqkM8J9glUoWA=;
	b=iEjVoSXrOClgNIiVzDp76KG3bJUTPtzXbOkTWWsI4o+upy7eMfDT7falM+0ufoG5OgA0
	 Dw3d2GyMujcSdgLaJDRRD5TIUJ+tt0E1WRSD3bcWSgo/NybScnzNeJE8l7dS9hRvIpLu7
	 KJN5xnmTT8oKz2lcMv7cAZvKLCJf4DPoZnPybqyEq9CAgJn1PtqyBJpp3TfRe0CWfKCa6
	 m29bA7qRi0PuHYScAQTC3aKu404R7Kt4PfPjFBb3MSjBWKjGBaBLIOTcFiXNkLfhXMMur
	 G+Ei+mmrGW98EdoKiQ8+gce4xRYuqrDhNDK1W8Y9OYfrnMcMKSSwr2jCXo0oH98o12A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nIfNf5vh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.14
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235B606A321;
	Thu, 26 Nov 2026 15:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D235B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nIfNf5vh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9nVfSgLXh9xrhZliNQigfGxzU39gb11eBZjL8huFvK3SibOaNrABQJx9ZI5QL/pfarfbDVjoehJkg3iaVN6fujR9VxFUN4+5P6KNFlrWd+9zhX5NwZCvaZ74p1mPa5r6kPealAIWT4HaumvJ23qquHdFRFInA5rYoVM1UMbdTERueP4l0phsZ/s04onfifjp3tVxKJD5HEoyr+ovZ7ve4u2Y3uK60DYi9ZCsTL/uL8lp/sZa3iGGgjiWoZnM/16F2vnWRQRnq0RJQiXytplD0hCAMK61f8ApVU4gQP0tIj8bCNUpWIT8Ojjik97QwUdYpiNGunCEC74+VEhL8tZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnNMFg3SLzTrLl3b//II3U+b+BfXwLVqkM8J9glUoWA=;
 b=bJZo/eyUR4yjMPDq4xEmGVLfh+XcEoSFn66VVScTy4m2uzdpi6AuHG/AzCoOfSUPuqmSkQ0QzBkCYA0ESWCzcnhb2zbREGGTKJJeaDAYozyREWcy4HKKVlGWvm/TdbJkIBQtD7H12TNBeuuUCMB0Q7GwzYJX7EJU4h9/JmLFtpJeu6tSSaMq+JKw0mzkOm79BdDGCBWRPNTK2hdO07FCa+E2xdvYkHO0DDzIWFkn6Rx0cRMAxGCDh82hW2xvOYFcJV8lvTXfJFvq7w2ZgxAv4dDyoc6/0P1Ufj7ZlC2d5HWHQCwpq0i+wp5hP2IRS8lk3dgK0p6tBUhS3dt9otIlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnNMFg3SLzTrLl3b//II3U+b+BfXwLVqkM8J9glUoWA=;
 b=nIfNf5vhORvBc6R9JtyTWqFCT6ESjMtwOyuw7AT9uXJI1YD1LwLKDS5jnz3tf2vAOPEkMTot6ekxzP6DRVHE9Vhc+cGbS6/qWzUZjMnX3XoMYtqmw+5ZiqR8MRVCk7ES1QS3On7o5/mPfI9XFBhjT4HeMFwok3TO//FR6Cr5V6i8i+chU2Fo6OynoQskCnLeHKQnOrp3SK+wueE5buTXkxnwaIDbNYxtvv8/FQOCBOSTLVdNV13WIjy7gq6NoQCmVLnh1Uh/hQ+El6K9GrMKOXBr1VAi63GTuWB0j2f1dRvFhL7+uYYYFDNxt0zhYVM08nGqRra5IhpqGNWzv3iuHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by VI2PR04MB10267.eurprd04.prod.outlook.com (2603:10a6:800:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Thu, 26 Nov
 2026 15:10:25 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:10:25 +0000
Message-ID: <2b4b05aa-93f2-48f7-a0b5-f26e10cd8a2c@oss.nxp.com>
Date: Thu, 26 Nov 2026 17:14:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] ARM: dts: mxs: add EVAchargeSE board support
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
 <20261112130506.12823-6-wahrenst@gmx.net>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261112130506.12823-6-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::28) To GVXPR04MB12316.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|VI2PR04MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: f97c001d-90d6-47c4-ce4c-08df4bcf6631
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|22082099003|18002099003|261009223027099003|11063799006|4143699003|56012099006|261022075727099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uA/wUhFvRTIHvzr7UI9lJlKLP8GtSD/h5AOmH7ERs58bdBvZfjWRMTBH54eQZXaSEGXIv+fXCg5TwYMzk3VRBcGyPU3nmquPw5BMNpBnKBHJ8sbyi+D2jzIw7N3r1I13fW9YwJyNaf70cLwpG/MzzPUC7EOtFbTILWObpTI+BQyVecs87fARHsef16263HSFd1GrPPMpn21UpfX+P1TLEdue1/LQATyxk/nn3WRznxSW8/jhD51YeeECYFLaPIeOqXQqHBpwiUPeIiZuoZRbKGNF5UalA5rNz1V31Oj2PwcV8Ysec3q7H6hcP1nxNyIB+0rsIoNUNMhztnBC4CX8TH5uyq/zhP5wQYmNSNC8/g1VzGCJzetEOJwFxgDmvyyqkw8STfdT+JLJZrR6hZLrivCqvwg/U/Dw20YLG13LcWHB5BaZDw84KFVsam7KAaccas4Mv93/5qhSt/HGxruymjgOLMiOEnDRNniw4xZ2UMm3erHzyBTKWtdaMWLin3UC3ITE7LJgWKpjDjztIw12IdBC4jfTk+HrU2XtBLJw9TjdwR44WbZ4lEkKRdh54r2013pdsifZ7JHrzz+C+ZAKFz6SxfMOrcfAbK9VY0L7DAl9SnZnO675y4LKStdQwJDE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S28zaTJyeFBrc0hZdmVZbFlnUUY2NkNrT3czQWtQMHJGUE1lV2tUVHRnQnJG?=
 =?utf-8?B?SGk5Zzd6cXRqUXhSME5OK0h5V0REamhsYlJOS1E0LzVydHlyWFRQVDZQbFFm?=
 =?utf-8?B?U0R4Wm5aOUhMZTF6M012NFpXKzlpS1pIYzBxc2dIa29EcnY1bnJpd2RGbzNv?=
 =?utf-8?B?UjBOMlphSzluclRaK01FR3VKMDdqZytzQmNBV29reVFpZ3hTN0QvYVBWRzhS?=
 =?utf-8?B?anJJa2JiUmxxQU1ZTGNNcFpraDZ4M3dUSlVVQ2c4YTl5OU84UDFkaW5wU0Q4?=
 =?utf-8?B?amFNUzNiVDRyVXdEU00rVy9aMnRNWTVoMXE3Y0wrbnYrZjRxTXFEQ040UUc0?=
 =?utf-8?B?VzlFWFZSZHAwaHFsbDFUMEt1VjJtVmoyemc0UjFWOXF6eXFDQmdkMU9WVlRQ?=
 =?utf-8?B?Y1dpYjhYQklCeFYwNnp4bWZmbTJJUjZQZ1d6VlZvS0QreG1IVW9LUnQvQit1?=
 =?utf-8?B?d094Wm8xZGtyM3lSTHFRcmFxUFQ1S05OZUxSd2dYV2x3cTBic2xCeEJQd0xy?=
 =?utf-8?B?ZUJaTFhtWGVmOTFnb2VCY091OWNYekt0ZUVYNFM5b21Oeng4ZldGSG5aUUdD?=
 =?utf-8?B?enhxK202YkpkL2dpczYyQTdmUWVEK3VGZTdQSVhwRXZDMGEvVzZ4azR4Unk1?=
 =?utf-8?B?bzNpVGk4b0tRTU1xV1NRREpHQ3VUcEY1bHkwQjZDQTZLNVp0eC9EUExkN201?=
 =?utf-8?B?WGZOTWlJRi9Wd2FOalZWcXBrMVNHTmwyYUdSOE84NEI2TGk3c1MzMURYMWRh?=
 =?utf-8?B?U3lTWGxJZnE2UWc0Zk5hWVRCSHIrb1hGZUZsMk5TTFM2ZHFoUnFJL1RJa3FX?=
 =?utf-8?B?eHN4K0NKa3hYVGc4WXcxMjdHd2Q3aUt2bE9hQjBmeCs1QjBBZEJVT2JhUU1m?=
 =?utf-8?B?VElvTmR5UUVKUERwcTlwd0ZLMldNQ1JvU1VoTUY3VFpvV1BxKzYxbXU2cGVI?=
 =?utf-8?B?L3RnWFpSVlFkRys0bzhFRHlLc1I2RVBqUDVXZVVVNWNYc2hucDcrOVZWT1RT?=
 =?utf-8?B?RlVFVUoxSWc5QXJVY0JpaHBQVTI0RDhzWU5nSmRGYTVva3NhY0hqZGRKMDlD?=
 =?utf-8?B?ODUxMWtqYmRKQWtCUzZXTjhFRkIxTDdDcS91SE1RZzZSUnNCcUdXSlQzRlRj?=
 =?utf-8?B?THdLNU1XMDZZTncwbFduZ09Ca0d6U3lkSkdXQStDanVxSTlSUU8reWU0MWlC?=
 =?utf-8?B?MjRkUkYwSk5zdk9OeEJHbElITE1tL3NFSHA3OWFGSE5tT2dlVGx1dDNyMW5H?=
 =?utf-8?B?MHVCT2grN2ZUanQ5OTBqUG1kbTlZMnJLUG84TG9KeVliQUNJQUI0UnYwcTBk?=
 =?utf-8?B?ZjdBaDUvbXFZaXRNQ1Z6dmsrSno4eHpmRUc3RHNObGJsVXFNOHZlUmJKdjcx?=
 =?utf-8?B?UFRlTlY1ZExOU1NZNHErNldvblM0dlNhbDhyeWxSaVlrTmVnR1JCYTRpTG1q?=
 =?utf-8?B?cjkzVWtGNmFETUNiaVZGWlJ2cEFWV1UvWUNyWHhjTXNiYzB0ZDlhM1AyYkdh?=
 =?utf-8?B?bVM0UitWbDdNdjRvNTR0amxxV3pYZ2ZpbjJVN2wrdk85Ujc1WXZMRWxtS0FN?=
 =?utf-8?B?ZGJob2RsK0hOQmJNWWRQUmhnUHIvRllnYkszbHBQSTFrWSszTjVHQkFxYnRi?=
 =?utf-8?B?bWxWcElrSFBpTWJoVzlvSzBOLzdZNGNONjlJUW5iNHFGbC8yWDFuNVREc1lI?=
 =?utf-8?B?T0FXaVhGTlZKVkMzN1FvdEpyNWFPbmdRQmsrQlNrYXdCbWwwYTRuS2JVUHNx?=
 =?utf-8?B?Z1N5YzRjYUNNTHlXRlNVNS9JRklHUDR3bWdNTy9URmt1cDNhdXc1bGpwTkVQ?=
 =?utf-8?B?TWp3UjJsZFBxeThUeERRQjBRRkFrYTFGRDB3NTRuZ1dTMDZVUkNBL1owdk80?=
 =?utf-8?B?enhqVjFBWFprL0hWaXBiNTRPQnFlVzFWcGhQdWxJNlZmRmV1Nnp6b1F0aXFX?=
 =?utf-8?B?NGF0TmNTVWtsUVgrZVBmVDNiaGI3bm1jeXdhYzNnZUx4VXd6L1RTUmdjbmph?=
 =?utf-8?B?b2MvV0ZnRmpieWd4YlZHN29iV0VneXhVVVJzYkxid0s0Slkyb2xjMkxYTHQz?=
 =?utf-8?B?WEhJQXBWSGpYdXkvY0NSYXdzWVJxN3NNdnJYYlplajlLOXRvQVp6eSt3TEZo?=
 =?utf-8?B?SjZQOGN0TGgyb1pBWkJDTTArMTFhZ0t5V3FKMWVmaFdmMVdCS3NEeVBpK0Jl?=
 =?utf-8?B?VE15YkVlVGtUMFdwdmhPaGNxUVErMnIyaHFscStYWGZtb29mZi9BZ1ZNL04z?=
 =?utf-8?B?WVpRU3QxNUt4YWxQV2FtYmxIcndHQ1FjWHhQL3JXd3Zxc0trTytFZXRRVFlE?=
 =?utf-8?B?d0pGYzV2eGtiZEpNZ0J0WE1LQW1zUm5rQzcwUkpkbTBzc2hxMzVnZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97c001d-90d6-47c4-ce4c-08df4bcf6631
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:10:25.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVKFGclp+qE94L0Br5APtL0Y35trj3YxEIPgRT9fVA4pjOrH+b/Q3z4DeDXU6THLRrS55ZVKkzo/QCYiSBPXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10267

On 11/12/26 15:05, Stefan Wahren wrote:
> The EVAcharge SE is a ISO 15118 compliant controller for electric vehicle &
> charging stations.
> 
> Supported features:
>   * 128 MB DDR2 RAM
>   * eMMC
>   * Debug UART
>   * 100 Mbit Ethernet
>   * USB 2.0 Host interface
>   * Powerline communication (QCA700x)
>   * CAN/RS232
> 
> Link: https://chargebyte.com/products/controllers-modules/evse-controllers/evacharge-se
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

