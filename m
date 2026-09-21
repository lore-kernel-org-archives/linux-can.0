Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4164A498E;
	Mon, 21 Sep 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002020; cv=fail; b=cilxQLspW8QDFHY28sxr9Kiuxz4IQbGGwULhceadwX/ZuUdHF28TsltQpM14XtFXEO0nGR1hWbsIz8yhanSUDBwmos6APnAIDPmxxvpmeCAr0Y3qVPKX38AuYFRQessjyYW/D8MYfVXw3TNWvLFwzwS+gUwEoEP/LFQzbvAICR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002020; c=relaxed/simple;
	bh=AFYqz6HAaleOE71vMWGIh4R3tpiJWLS5A4rIz0dwtuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A/pMiRhNpU2tmPaGfYYlUnN05FflHavv7tGlm/VQdBJunfxHEWwsqMyB1qbBTOlGDwLgQNeFOPBWN1HmAMWkpTLQLCajHgjV9gnHL2U5QpDawM0t4OXdM7o5NnR7Qq85DKtqMWtgTaPTRMbRjXcD3VbJ7qTArCaI7Wei1898aqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lQlyZ4j7; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lQlyZ4j7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOOtiEmbkX78RaBosrJw7vnMAfGV7fw33GDnE6NzD7u6Acze5bvKbzYcj/RZrAqaUsMkbWnYgZeeT/HqTr3hMur1nLF1DuLP5Y48pBqie59vx5nkWV/N0oZIKZWZR2/+Z7zPOdoF4e+o7/+N86DBLhFmz0u5z97nK+CXql5HKNNZpiDOv25CeOGWib7vaGsn8rCqQYEWWIEBaTcPhpnFSIm7ixh+WXOv8cUeD6PKRPOFeBOh4NvZaXwSwAPCY88kj/IXVeVSka6Q9AciHSGSd1ZjtTG6QEZ/6HenoiE8L2AR2QEkJTsEZJrXgTd4m7Zigz+2SBfTjJoEWjWUQlhVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFYqz6HAaleOE71vMWGIh4R3tpiJWLS5A4rIz0dwtuE=;
 b=ypv2Vv2LP/gVri6wUctL1gun0xmN+NMUEH5ZEmlaKVB1bhseU61c04PrQdAaQL2181wQUIEtRBw/9qmTorGlFnxnAaXcmJYG9KKJyU+jVEOQVqxsPcT+JhO9lXKM8GhLZziN5TJZ+Ic2eu0c++Zj6MKVW1RR0iZDJJrRefhw9u+gBWSrmUbT8Uom2kPzJfYtPVx7Jn31M8k+VwGOYkxaZQsT8OiV7F27qyvmPEiULu141/+2w+TyPHKwvuf3zgBiktm+f1TPeYIb9lwvAecYIdT43Rv2V/kvTIZBeiavPqYOGqriAL3WXpPsDnB8e+kfxMfRS0v+uRRJmPWU/R/l3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFYqz6HAaleOE71vMWGIh4R3tpiJWLS5A4rIz0dwtuE=;
 b=lQlyZ4j7Mb/yivFHvP3P3mszGn8Pdu1HE5i+KGLBBTnpX+6Isra3Zne+x5eiJxpI7eyzstWm5psKgJPBgL3AXybg4dlKUk0X7n1WJkr9auZDcK39Rkw0y+C4KhkWd3AfBUgxC0UK0kIPmASed2QN1VbRPyIQd/2WXY6yR34FCzJa9g9vdAw3KVshEfQvseXwq7aGlfRgTTGdfzBEfSsMwnbxblFeoGwl3AbURCEe3rsekHOcCo4x+cCsZzj8r02TlQPKKJfXc5073lk7D71j747tLzFJmZxvsDiqw1xWXtwEQdJGzgc5KgcOitSYTl8t2z1ok8MdG0xffQIHTDIAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS1PR04MB9239.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:46:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:46:54 +0000
Date: Mon, 21 Sep 2026 09:46:41 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Frank Li <Frank.Li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
	Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>, Vincent Mailhol <mailhol@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
Message-ID: <arFDUby0v52HSNnU@SMW015318>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <9cb548d3-f3cf-4757-a9ff-5f878479c7d7@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb548d3-f3cf-4757-a9ff-5f878479c7d7@gmx.net>
X-ClientProxiedBy: PH0PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:510:e::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS1PR04MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 71922ea4-5870-4483-1e43-08df17ef2d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|3023799007|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QmJ5fmZ9XCTIkaoqXxdH1OZQw8qoCjzEfMUMTH4uB1+qUiKr6Nmts/vmcazoclp17CfY6t96R2jLdfPWjvMbMUMikvgN0F5iKEda8Z8L51/OWpmjKh7RvCCreLFzeFPTurl4J2ZAMmaZZ1bEaZPsGu2oP58d/dywu7vVjVZfxswithfGWtOFCnaXeyGhXXi4qaIMaIgtFuXfmdWtu/z9VPSgyN3DT0WljkwAwdp+Z0ByjpQs3cLUXJjcv3oYKpd9BvYvgaRSFAjF4YXVPgkWBhRDM2ldpWM0h8NuFpfbKLbHTTAwDFwWijP2N5LOV+sLtluxzdbptT12P1M25EljG6deYM7MEL5FVHNnGgU/4wnDFG5kRcvuAdP+Syrs6Ny8WGSElXTxUpKSif/IjZB8SKqQN3V+AK0u2GsmUx7M7alNY/cyf90754ADU+RljNypEbyBsej5yUZTHbSOf7Zh6wa99d7XJ5BUp56j5Nrz/GiiACSyOo6oCZ4Nke2MeT6pFRdbbXTyNGoJGZfXdsPSOvPh2IxYsmSkRQE0byZ1U0gZfO4i4qOIkCSCenIsnBptthYPSrOBfqH3i++9exgp9bqXTD4ID/cs89M0QOnB4j4aK+/p78TOrG6C6br2I4tQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42pwCZSDTN75vx0gPc8sSQoJgFaAFGuZpqYP6nZiJzsCtRDpbfO9u/J17gUY?=
 =?us-ascii?Q?I4qELnFimCz+KPxwyvE77gJxz1I43zsqyeMm6xtEKtatxqAWrkcCVrue3iMo?=
 =?us-ascii?Q?+8OaTperbc34prNY3FCjT0r3LOZEzLj9nU5N9HbExRXZ/sla3f8G5XcCLjo5?=
 =?us-ascii?Q?c7ck+Ca8BkX7JGa95G4UnRuW2tKxC9IvfManitej6zuvoZtVthfrCl6N8DB0?=
 =?us-ascii?Q?mHIn1NtmKUcRno+8MOuPGLlhKWWg/iTKqdJED97UqmRbIJESyRDi8t1SUiwh?=
 =?us-ascii?Q?SVpBTq7NicwZk2afJKWLq6PWXVJxZgilhhB+cG50M3/aRJG6+ixBuwMnaB6y?=
 =?us-ascii?Q?aWJEbvAxjG912kwTup8ShDFDPm/F9aWwIMW3iSTLl7fMBEfiyQdCJL8JIWBy?=
 =?us-ascii?Q?LFIqCZW4YgEbUN63p/k+N8YpxUKwdLODEycbjcCTVqcjnVU2nNzIpF+N+90R?=
 =?us-ascii?Q?ziq2Mb+5NIXqT72bB2SgjUHnwhJIz/vMpccc7dykcgcbkFo8C2BzE0cEUijl?=
 =?us-ascii?Q?m52tKGsL/WAWaRmKBwSSwQunrEUeqGvhUFzEsqblessGK7d3qUTMe/1KSp+G?=
 =?us-ascii?Q?Gn16WkAFXY2kTKiA5bRMlh8kB7LShb8yacwsDhnHfVWkc+XVhkpbPDDvbtze?=
 =?us-ascii?Q?UgYGdoCNTNa3CSZqKk9/y3hujSl6eBRJcRAIrD4Xxv01XnzA8KiPGiqaz2AM?=
 =?us-ascii?Q?fYxNfhMaClExCm5SVkasLK64oKbti72u3mhZ/DBMJf1iEjsw2MS8r52N3/NK?=
 =?us-ascii?Q?MH0FBq/Uxo+EzruqnI7R9Let3uKkgdpFtm/h/bCd5vBOCezfXp2THrmGVn7z?=
 =?us-ascii?Q?JYT+mwJJqNtvnezw3EpBwa7SETNm8iRTh+IpILQ4K5lSertvqcFZMR3H6HH9?=
 =?us-ascii?Q?B0kk9KnYmXc2prCOf11oinlX0ysbzZS2dvPT+oQwlnFXsGDSyQ02DIZNXzWg?=
 =?us-ascii?Q?0k/A23klbDigpbRRGYK+20U+/niXufvIlMfC8lwYMU0xHAjDFIV+fNzXEU+K?=
 =?us-ascii?Q?bNwV0sENT9QWDvaW9cXcn07LuCrd3/cWhD3paGLzuHMq8lc/7wIt1EslzGyF?=
 =?us-ascii?Q?ETXcfexrXPMPaNZhIcv2J+sQqZmJguG1UyJemYyfBrznBcFrI+dmd1imEDQe?=
 =?us-ascii?Q?OeEVdg4mRJA+LGD7lMrrcSJYNIU72gDJdOly5xOknPWx/21N8GFgIdOWvTOX?=
 =?us-ascii?Q?t+kaahGLFfkLCarqVjS3NjMiqzoXRMob8O2/k57kUCfXWyrEOXGoWtuXPO+o?=
 =?us-ascii?Q?LJwfzNIoz7VDzKpYElcQfSPZA+huq/nHvD0TicHGlLalEO+rss+pUAed1nEq?=
 =?us-ascii?Q?yk8ycG7lyPxfEJe+64+un2n/nTiS95VoTGVFnNJ6+YRX+EbxxHrEXz89wS6j?=
 =?us-ascii?Q?oaOrYw4FllGMWA4uvh10z7NiFoOee9WuziVIoZ6Om6dlMg8G9DRbzewzAECu?=
 =?us-ascii?Q?QRrScKb26x+eQw8zL55ak2sygVnY3/xERqg6Ptzo+2EPJWFJRIJPrA75eGjK?=
 =?us-ascii?Q?AIWaXfTd1uSP+5BnDET3dpRWkLoyl1Ytru8X8QRGhw4G4DSWBfqiN/NQFsWt?=
 =?us-ascii?Q?ESuqdzH+W6wxjjaDupYgAl2/23Q93r9XC6Ovfgp1HbZXWiwhYCW+Ce7rTSvj?=
 =?us-ascii?Q?i5/3FHrpVy+/ca4St0HNv8EVGF+O+OkWglD/Qr38lLdGH5Oni0nrB9ph2Zni?=
 =?us-ascii?Q?JbSmRHkVZPyXYaQGVJkVWH/NjUz0WxLfQn8FI5g1ojxhfFqAeSRKQ/Qj1WUi?=
 =?us-ascii?Q?EaGPGDtqll22hicuAYyVl1hXLt07P9Ftt+3LJh2WasSlD4yyQaTG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71922ea4-5870-4483-1e43-08df17ef2d56
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:46:53.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfZ4pdRvH7bmelojLwsuUXEfwl9vjBQSb3KmBCanSbdBSLCeIPClopWnnK+FhKl4e/YvL2xjoqW5EhYn6Uql2s1cgdn0JnlhIfpsrJBId8KA/giRwTddKfuxZjedQe2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9239

On Mon, Sep 21, 2026 at 03:09:23PM +0200, Stefan Wahren wrote:
> Hi Frank,
>
> Am 07.09.26 um 17:04 schrieb Stefan Wahren:
> > This series adds support for the chargebyte Charge Control Y, which is
> > an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
> > Charging System) charging stations.
> >
> > sashiko reported in the first version of the series [1] that X_nRST_LAN
> > is available via GPIO line names, but there is no reset mechanismn in the
> > device tree. This finding is valid. Since the reset line feature isn't
> > implemented for LAN8651 driver yet, I like to proceed with the current
> > version. The LAN8651 handles reset via SPI commands and in rare cases
> > we still have the possibility to control the reset from userspace.
> > Btw the pin has a pull resistor in hardware, so it's not floating.
> >
> > sashiko complained in the fourth version of the series [2] about the
> > reset polarity of ethphy2 and the different drive strength across the
> > data lines. Both is intended.
> >
> > [1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F000E9@smtp.kernel.org/
> > [2] - https://lore.kernel.org/linux-devicetree/20260903082122.A777C1F000E9@smtp.kernel.org/
> >
> > Changes in V5:
> > - fix delete-node for pinctrl_leds (reported by sashiko)
> > - add Krzysztof's Reviewed-by
> I didn't received any feedback for V5 yet. Do you have any comments or could
> it be merged?

Wait for vinod pick phy binding part.

Frank

>
> Best regards
>
