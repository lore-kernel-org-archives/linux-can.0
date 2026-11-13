Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794586703;
	b=j+DT9oylFUSxUJlNtBwFcRqJD1KcjJqqhpNq0MAzLhUo3gt/t0AXi2nPn8EGcIm39mrB
	 fYzep5dm9y18yMjQ3rV1Fzp6Kc4hEcYih6z5sIroIPpEFzr2P2bLtCwdwjWqa4Ytqq3DQ
	 E4SFpAIB2p1v0gyr4OfLwnfI7eHZc6rBOBv11tLVliBe46UJyEO4R9SdBs51w9yoy3NQ3
	 P9HpeGrAz7TBcoJ7SR7P6jrnjt/nklua/gQjHVExPRWNwRQsoPYmHtruQdZtFbE4rGenL
	 m3KlT1NSyvtHH7foFv6gzChdNo6ZYRCyGH+gxAVz8/9PQ/xAgwYXJDlbfKD7ZAIXPsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586703;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=bTvZQ/J3zwV6a9C3C2/3Sw+smxQQBAB7hx36IzcWwnQ=;
	b=naSBUjcE/S504dv4V3TYAZDcXr9aQZmC1TrLeUQrfy3SeMAvulR/zLH3XhKbRWlhbWIC
	 yXgZ+d/QSuVn7icL0D3njEEpBG58ABlcusGQfPkFcD9jBy2LbN9EMJGqhPoStQGxcu/uO
	 tifcdt7G2NWioW9vYG65IRbx7/7cDxZVGV8UC58Ds42DNFmaVSGV/Bq7VMahNprUwvaHG
	 rHZM0Rd/RrWzpyFcGktRH/qT1ocYVxc4aEq6cNpVRl48jeVKf+3UTMU3QE1K+xWXHfsep
	 h7AJxPkLxI4URi/J9FQvfhV1O3dMf+khm7HuJGfQCsapwY35hCuRAxXeQSUzPND52NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SQewAFsY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.40
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE34606B2FD;
	Fri, 13 Nov 2026 16:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BE34606B2FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SQewAFsY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT+Jn+sR4/Q7kwPVC0Q3usOlvY73KWzZHMtXV0lmK97fdTTWNMa52OCi2K2Q32SwrdhFlxJJbPn7pUqcgZVlpAUaaWaZYo13talCJr8Y1ogHonX5oZoSZbew167L9KAqzWIrnzEBRnbjq8qRuYWl2WqLbERZmxmUtaQefUrY+QvfPe3s483k8WQFIOXtHMvVN6nXs2m8j9RTyV+3v+BTutIWQ5XTE1xyehfYy/0Cl+iVYQdAKqbWNG9Rdc2ifmGWMAJkzhMu//6XyGvmlF1D0j7PW0KBdusIaqKXb8sQbPD0YhlTo9r91Yos0x5Kc+DDGRHCUB14uPTPylb8E2acRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTvZQ/J3zwV6a9C3C2/3Sw+smxQQBAB7hx36IzcWwnQ=;
 b=eJ0ubKBtwrhr0Pfq8IdCAWdf5c8U9iT661mB1AZfGDPyl/kZZ0gzvk4tSUZW6O7w5kNPlC42LRSuLTO75O8lDA15obE96z61i7IctIUWNrg1ErweyZ9ufDc6eRaFYeS/1U8X61XOSFCUHfnIyIDzJlkqUzchLV/ZcLlgHjRxVY7gXbUi7+XtWqo6Vl569OWj62hoG2L99nPvVIVK3h2uziLTBBWkjY7lXRUs8bF6HaDrA/Mg7JV0/PnDVjqW6HEMrt+vyakmPKUMEBZl0sAAdG+VsKUcZArdpfP1/J3va6LoLkaVY+SEiDhtQNEBzAzCvTQ+QLSP68l57Apj/m05lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTvZQ/J3zwV6a9C3C2/3Sw+smxQQBAB7hx36IzcWwnQ=;
 b=SQewAFsYFMWWbow9O0WD/Ds5FoO+t5ArvsPNWgvm5VdP4ux506TMzCWWYCbaFfopx7Q+B9/Z+ZsH0gCGHylHBFS0oz5JXmKwlEu/2ZPY5ovUzDv9IEUqyP76uyRzbj+hsa6hkvudc1OapmiqQnNSAy1QP8DNfzUHerYIMCA60B+4BgYWfrSKw2J3RgU/hZgbbwXjnGyba5rpWUsNBfKfGyZfKaSN/Dj17VImc67j8N2mp3WwfLuEyvOa0v/9zatdKsO4VInu/GARxLU+hlKiNgziv1Bx5vGRDfoQbKmd7KLBLWNRzSRB9E9E9CykDb/EeCVp9tJkdZEMXS9CIIsvYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:18:15 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:18:15 +0000
Date: Fri, 13 Nov 2026 10:18:07 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v6 1/3] dt-bindings: phy: ti,tcan104x-can:
 Document Microchip ATA6563
Message-ID: <avc4P65RjTlVnO5d@SMW015318>
References: <20260930214729.809649-1-marex@nabladev.com>
 <179447423905.428303.6835437411622016722.b4-ty@kernel.org>
 <077477f7-3b1e-4ed5-ac53-45ebc01c47d9@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077477f7-3b1e-4ed5-ac53-45ebc01c47d9@nabladev.com>
X-ClientProxiedBy: DS7P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: c43c5473-0558-4154-a832-08df41a1b8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|19092799006|10067099003|4143699003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/3PXbPaDgvJtuQ6Ks/sDcy2iKToXKFCNudKckh8VVASpmE3TyGJ6evZp3WOfcAghVqkLq75/EkVIElysUA9GLe8BxfKAoVGoFtXWAq5ASKg7caofe2m8wKeTftHDsRmp7mEWpge+T97u4KEavLM90SrVoOtMNOvHS4zNc2hlIBV5cqEZgUvPTfonGdMTMuR3hyDJV+Nx2rHVjMNM5/GZ4wtInijSlZ9p2n5Jph/r7meJsI61OJa6lX1t1tdPG3aly4LL1s4U+gvLBREvIyqpAyZ1JOkhlg5BSNuzUkiETqVTsf2lX5DMVZIi6kKYAnqAp7Q96sSgGRnc3kA2k7ZXqTSb+nGyNP7Y8C1D+yFqqcd8MubXKHGlJ+J5+bR0en429DaYmMvPU4MU56OXUuD0qcBOJwqHxXhznTNoEHrMpEzrnMHfWYQNsdwevkl804sqOuynCq0KN9VNPdBVJTUFM6ibaaAsVMRTwUaTMxaEE7YOPc7UfYrd3nOcEzX13yW9lbN2q+LWYzWSb2LSK9HCK2lZRT81d8twT/kJKtxwxb1U7RaJFoQC0goMTgcoVAxMnQnGW0itrNqWXvVsHvDvIA7E+n+X/LEu48DcLBU7x8DTkFqkY3MP1tLMJ3PpZ1vuXSt3ZjN009NQmscDCQjL1GzTeVNxapHbMVXvtglolqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQ6MIWmQDDGmu/aPFzaape9TZrOAYImZieX6oDoAGfLkkeHEtIKQFlP6f3Jz?=
 =?us-ascii?Q?53gexyUav8qt7+YeVCqZ2i9brHr7cziaFGA1j+3r/GPNlWusLpAknJFxRrft?=
 =?us-ascii?Q?4Dh+TJzB6Oreqjyo6ZS4PJ6VAODs02afPdZqeeaNzacSiyMI9eN5775Poofl?=
 =?us-ascii?Q?E8CTH/KEsewTTrYwPfq0iwzfIuQ2oxaxjuZ6I23t92dLLwcrWQluURK8DdFb?=
 =?us-ascii?Q?iQklUiX3I3yb7FQ27yXgGw1cSmuf12WQvg1Z0I8YNvnjqE0CqX/d3S7tIr24?=
 =?us-ascii?Q?CfIOZ1iXfWROZSliGBOXKDOGEpMaM7wuQuOSYR0uNFWDxbnENMWHzrmJSQnJ?=
 =?us-ascii?Q?VlV4g3EnGjDRXvTucLwRmhwjZeCu3s7b9nLQ3JqHae2Lq0Y62ykdwYNPpwvf?=
 =?us-ascii?Q?Vd8oChvyI+oZtV4nqEC0mwQukTL3nYtIkU4a5Hvi3vsA3FD0mlvQD+ivVZRx?=
 =?us-ascii?Q?txl44Vc331o+jlyb69Cbb8xw9TR9d1OzmL5DANDhwI6tX6x00p6pxDtTM5lI?=
 =?us-ascii?Q?Zi8rXBAwf8pU3w8OWSgovDsCkVsAPWdX0rmNbHeiW89HLD2RgGaXUbJqf/Fn?=
 =?us-ascii?Q?2Q/d8pU6iOaGnFmint7S/jWzI8H091dxkGFQTYzLZo93FiudJRNqTC3tD+SU?=
 =?us-ascii?Q?eAFph8/k3k6eJnaKDktn1MxI0iKlyEWAtg0fuM7xIxWdS7R7xcu2diDvzGvh?=
 =?us-ascii?Q?Vgm+7jKY+OHQXYt9n5UJbZhIhkjTOf4dmRAORweExc1beiS+K7OUz8x4vPhM?=
 =?us-ascii?Q?GLusEbwvJaKMFZJDayKvRUGc4xQdj3pwUtsBhyPoA4UBFvs8cq1IB2wY+wiy?=
 =?us-ascii?Q?Hh9K8/hkY3tX+6OzCJ+W5ww/NjZ5N71WKlgZUYHTFEF2bY3FCwomqDbCegO1?=
 =?us-ascii?Q?jr/E8tuL+s/pnYQSsBwA3e6WvxaZgDHfkLMPsYxxE0a2Fhaz7+ak1BdSRdTz?=
 =?us-ascii?Q?aaQy9hc3nigxKCqzdgEEFRUnWBsre1lLGQte7dDtHhQV11QUpWM8l5N5OwW1?=
 =?us-ascii?Q?1oKwCZuz7ltym/II2Yzrsl1k5XR7NIqh7lQtwmrbrBWnbjWmE0Y3n9rX/Yi2?=
 =?us-ascii?Q?usfZH0I9gQXQc8+lkk3PUh/mXdmU1DHfMzqEkpB8N0hoF8Qdj5sQMQCpFA4w?=
 =?us-ascii?Q?pwuenogPEHxSgUtpTZOijAyuFj2QlBpRUkHIoOXUQJnPvawxKH+Qb4yw7BZj?=
 =?us-ascii?Q?hsnlryTzxdpeQf+D7dxs2Rb/QMUIA4vK/Kjwqztlavnnj8srbJxRpRPU1Kut?=
 =?us-ascii?Q?3G+NEAdM3vreaEqEWsoNaTUBdNDEEOSFdq/IPOv35EKxSx/mI0jLRjpUnpYk?=
 =?us-ascii?Q?OPgZBlw5azuE4pi4g67s1Ebn6/gm2v4TIQjoh9qe/lKPeRBcAizwhQn9J9bP?=
 =?us-ascii?Q?43v3sjGnCddRP7DBcrhYiuIHU59jE79IwcpnawpcRAySKrJHTzm5/T4YI/c9?=
 =?us-ascii?Q?IH3yaZ/5W4UEiDlHJzJVulhBMbVw+hHaMalFBIyDh0dfScrnz5LXtyhxOQah?=
 =?us-ascii?Q?WGKg4pLatLDvINXsiJyf8P8XhMpMPjckNVXMwPqLUSTY7VBmKR5G5QPQ7HN1?=
 =?us-ascii?Q?DIXsLBECwuwrejObfse5wV3CNZdqSuymUG9p4AM6F0qdqGC4nLhr5FMwOyl8?=
 =?us-ascii?Q?gyujqoshau8hRjNoSCdJeq9QlDkHvjzNhzTJmIGcuLMDMipJHI0DNlKTFDHQ?=
 =?us-ascii?Q?WoaHfFg/xfeBLbWMFmqXsvQpASKUIICm07mG7ag2jgT7LJ5ZEAlQm+BDXafu?=
 =?us-ascii?Q?RTkbHVkLkGDauf6crZNY9iIccI4ZvgNL3dPQUiSdRbUIxpM2OW5l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43c5473-0558-4154-a832-08df41a1b8ee
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:18:15.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghaS0jxI0gFDe0vUKURxej5ZZ3GfA8+tbyu/l8zep0mEZ5T6iJvG0cXdD4/TIh3395aS2S3cBkzTXpI/WvHwENjVuS+AhlU4dFfYOuirlsOPCiBakJ5AjxSJUZvfZ58m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062

On Thu, Nov 12, 2026 at 01:35:17PM +0100, Marek Vasut wrote:
> On 11/12/26 10:03 AM, Vinod Koul wrote:
> >
> > On Wed, 30 Sep 2026 23:46:38 +0200, Marek Vasut wrote:
> > > Microchip ATA6563 is High-Speed CAN Transceiver with Standby Mode.
> > > It is pin-compatible with TI TCAN1042 and has a compatible programming
> > > model, therefore use ti,tcan1042 as fallback compatible.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [1/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
> >        commit: b338621a7e68bb9dc91d08e1774262deb0db50f6
> Thank you.
>
> Frank, I think you can now proceed with the rest ?

Can you rebase to imx/dt64? There are not base-commit informaiton, I can't
apply.

Frank

>
