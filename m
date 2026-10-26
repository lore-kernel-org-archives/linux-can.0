Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793045601;
	b=QtI6crz0znMtUqPlGuFvZkbIxacPhcPpqkBAqyjp4mie39fKT1qePOnMt6ZSa8GKpVkm
	 coWRBND82BY0ugyFBeh+ZeHV+mDjPOBlMvp6Mte/93ice5aIQ1DLKDyleNDW8b5EQUwiU
	 bbSnTHs5t+8cxwjTCXyWr1+Mtx4cxmqPpIWAewjiw3G3pgnGphgAM4Rwh43YHqmrhfjy4
	 NDN/wB6dSzKBXQYB6SegbXjIjEPk2MCBc8Q8gr8FrZAuMIixT7lTYXP0USiBQA7eVDWqn
	 Nl0pcGUqEBD5oxvk+ElPZfQ7e6cjgaVWPVFbhvoQJUmvVh/8F7pE0Xt0tu/36bJ7YVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045601;
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
	bh=DaSgS8wCbRMOgUD5eYeW1O5rgUz89ukPwkQe+2ssJlE=;
	b=EHWUCbJemqWlOuwKy/Mgi9Ukmqev4E2WJpdV2935AfDUjNB5rfkXuphR4XvQqUfjjZ53
	 +oQNbbMfq4Jn2x7xIQVBI/s16kdQ+TcMCfK+hr35bLQZgdoDP+QWeSQ0h8WQaMlsfliNm
	 3YgXHwSjSp10fRGz6yIFddHT48unkfAtR0fDNWNBd4BGz4Jx5LQSHTT/6Bx4JSuOisk1y
	 SKktshP6z27ZlMupNgfZx9M+MuYqRjO5g2fDbqo9CG2yAw9VOAIcLF470zduECbT3P1cs
	 maUHK6w5rl4U+RMZQXsCfJtIGPyLHgXAaKh0aXxAY0Y9Vrxiko5ND/9eGg6fyhdLmVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZOQHymp5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.44
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46F606A31B;
	Mon, 26 Oct 2026 20:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D46F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZOQHymp5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyk8UTLdl+tKpYTxhyAbc3/x0tmxOBhr8n1wZVvt+zJKkY+aIpUUEohL4deILncG5YoU7duM2v3PkZYGMiiN/0ALOCIqzPgieRAwjAa3HXOoLoN+bRB4VUXkydemqxa9sB5ioq6KAT30ME1+BEFFXF/BOYgW7gsnwpRRIhTBv+rBTfYFo6jbM0ms2qDRaacs5lnoYGfhkSmALvNiXK+rgvkFKEhJF9XDSAkMPM+fID7fdRDvyQXzQK/8CpFAG5TRwEi3YEbhovkZdJeuTFVZj2hvhcFCiVXZUkDgROiTkar/VX3EpTLWOnExWWbgTZ9YX62CQGCgzMgD6ef42Lr4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaSgS8wCbRMOgUD5eYeW1O5rgUz89ukPwkQe+2ssJlE=;
 b=r1U+1ue1cyTw5zsalKhrKHdqnieJ7c9coxng1b+XYLPR5jGUbZOnumQzO/sv2c04jEqZi8LnuY1avScc0wZaOWChJ4qANB6EgZBDtsm5HDFsh31LeeQzLf8DpPuGvDaK+yjrswuIUntEPM/EzKinO+oV0pLaayaOtt9qyNhuOuzNBVHbrAicUx92JAIoWSXBYEJRPmll0o077FE3vCAUfqn0JuJ2/1o3Q3dq11wZEj70OevOly0d+S/xBCmD2CtBPr3foxlrYoUryeFap4UiATKsAmJMcpfNNwJhZRI7i9sQKoJPvH1CdFzhbtF7BeJwkWxBCc2kLUTMNYy2q6acSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaSgS8wCbRMOgUD5eYeW1O5rgUz89ukPwkQe+2ssJlE=;
 b=ZOQHymp5fErBdYBK2WUGc8/qBBatKi5HIFDLF59Qt1YChYK/kup838SIbEA29thVh+zT9slnwmfVsYB4oYA7xBXu17orfWQOLM5hxxhuU/dN+vTGMO7X7nETWGzVV66oYDvmNK3Vjs/Lz6BjHbhHBHBjsj3SfH/PLgnQas2ZxurX2DbX7sY5DHSoKQoiD0az9b1qZgQEoWM96MxJU7L/KXVz1+iX87Tx+P/wPmtPRu4qSs3P6y0xq8ThuHdlvzsb1X4Fdl7tr+1S4R744HgWofOrcleZOZe24IisNyZOTRzvCIbPQFNZ4ZpTwFZH3Jc27jA4YxkQYvDllhNKIMgigg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 20:13:18 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 20:13:17 +0000
Date: Mon, 26 Oct 2026 15:13:08 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-arm-kernel@lists.infradead.org,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <at-0VK3LQ5c7rVmF@SMW015318>
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com>
 <arvPDq8sjjv7na01@SMW015318>
 <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>
 <20260930174413.GA2463938@francesco-nb>
 <ar1bhpji35CbArtY@SMW015318>
 <17f240e5-9c65-4562-ba51-535b0c69c5fd@nabladev.com>
 <ar19W4wX07p8u3_5@lizhi-Precision-Tower-5810>
 <4efdcea6-a099-46a6-8d07-dd5c583b962a@nabladev.com>
 <eca44457-d3d3-4732-977d-d30a408b7b66@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca44457-d3d3-4732-977d-d30a408b7b66@nabladev.com>
X-ClientProxiedBy: PH8P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ff2255-0842-47ea-2a90-08df339d92e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	iEtwddky9eZsMUmYMuolhKHOt5q9RH5u17bwcdWBNj0CNz6QQTq13ezVhe1HAAkRzYP0j+UKK6borgpEtQMRKkzmYa8TicezQV9WPCWRAVZ93NXzFGkKDlmIMEFv1xqd+eiRVzr7YqMUapF1VyoW2oU4H4ab2eQnbiaOkqIAAL3ZmaWJSdi41+v1ShxvOUBEHha30ytT0s2I3htpmeDGBfNQO1GmdUWNEZq/T2o4IyYgsVkxvh5Wq5MzYAjK6F0iUBJL1GvZrozzbXBY/tU8j9BR1m6/pErmqdIQfe/vVvupH+EHXEIt6CIPJRTnOGg7hLCVm+gHb+mBcytRI35BfKjE/Yiwqp3EtdpzZJ9jDR2urQ90Ke8D5Rsw/uxYJyKB4cfFtREblHKpsIwxxyl3AqNj8gSkb8PKviHAFWLtdHYJ2g2YieHQJBO8NlYd43SuUu3Ivdh5PgFLkZ4G7YyWJL9Px7d9wepEqdH2gc2p0xQucU/v8QxPwf0YJDX9j35+yfnSfey1sjg8Gkce8cY7hJJK/5i8JXLs2DciloW1z9kUmsdOlxf3bjCrQ91UHMu/fainIUCsC6pVGttszxlCyxrmW7oUHoBEyvCWTKlnyahVMo94btjY9NJ7a1OsTdrf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7dVEAll+q9MyUvxdWtgLr/kWtG02ULA2GQHoN1umPG43yQbiJsWAIqrHZog?=
 =?us-ascii?Q?76//nZkE+0Pu+Q9ZDhBqlRwLvg9FrPOgiIOiWLAiv0nei/e+j1ux2pmpO9Jv?=
 =?us-ascii?Q?GqSFLt9kGgrVu3lNRLrfzcvpnpSYU3l1V0R3X8Ut543gT97ghoB+E/LC6mxy?=
 =?us-ascii?Q?exSD1kHK5m18MX0V4yHmfvsLQcI5dMeaEu+jx7sM73xAEeHGxi6sJrCiv7wd?=
 =?us-ascii?Q?5M+zjz4SVuyPiGNimwZimmETLXunU7fyUkM+WVtTEmHlBS478oGVy5bEWQmn?=
 =?us-ascii?Q?7LCwnC9ztlhkuAITsDCHzvzNiID78uaVU2lQ7Rpcr5M5iuiNqziv1936dYaf?=
 =?us-ascii?Q?kXO2QvcFZHOIv3Gtv4widWo/+/HJj0qp1PJK3YBLZR40joi7FK44yrHp7IsI?=
 =?us-ascii?Q?GgI4E4Zmg3OBdF0tPppBg5S3i6PVxPf33trtoQL1bGUwRRnvTtUcZybGL+AB?=
 =?us-ascii?Q?gR2ANzfTXbqAHQFEY2xU9/IRi+cD3M5BCcM/xZiTf9rhiOpG1zmL5DUrdDBF?=
 =?us-ascii?Q?ChCfnK+TOP73hhwmW+cjJUKvZWC6coYloYzsBT8MIeXArspKH6OM5kLddTuT?=
 =?us-ascii?Q?FY/BN4it7BJKv6PaYu/zOL6gybvzgTYuY7rPhzQyv+MvsXfd/4CeEOlondbw?=
 =?us-ascii?Q?nVUyzZ/mzP3Nu40cMSqWP/5PbAextD0vKSGX4VKskx4zbl+nhggl2V7mZzS4?=
 =?us-ascii?Q?TzsWOmaNCNSE4Sz5fMb/DEcrtlHF0WVn3w6B88CjTCwaD3RgVjQ68WiLObn2?=
 =?us-ascii?Q?7a/m+8AuRT1PMAiuRnVptHz0ua2Gu2ILp2Ky9YgkbSdFLpeau4sbqHNO7z8s?=
 =?us-ascii?Q?YzEo6et+cQM8fWOA/tLNl4J2ClfUxYOvZT958CwAKCiRFPwcaeNnJWd0ROBo?=
 =?us-ascii?Q?YbhGgqGSaD66UUQnjc280MPfshJUl6EcjqkLDUwPBkvLlnKD9k1WUneNvZAA?=
 =?us-ascii?Q?ikHlOCXHSoie7LIG2235Sm1cdvVru0gwN7C4i7cOcDR6zMFILec4JfHu7EeC?=
 =?us-ascii?Q?pIY9UnwZcQS25EW7swaBo6PBwMb0AmsCuAK8kQEQhLYgl/IAss3GaTGzRXQe?=
 =?us-ascii?Q?TNwqLkoWG7e+00U05C9dxp4kRfdlM2YzCxGuOmEFk12ujLQona4vTdvK9Ih5?=
 =?us-ascii?Q?zZBlSq/+kGJ7UrUfXIK+pO1ulq/oTBJkFCxrXIZQQI5vlKzYqPFoyCO1HkEa?=
 =?us-ascii?Q?BBBLHN7C0KGkxcdJPXc/ItSQHf9RdeyF/UZMq1Szo28G0fJrJ72hiEvBe6yB?=
 =?us-ascii?Q?XSlVJdjJS7QLNTuI4gd2z4SiqgVYUFI7z2qxZUSVqiawOPVmfEiU3Ok75u1o?=
 =?us-ascii?Q?K63wK6a6qnl6C94tONxTBqUAwmfd2FHwnUuagdG+IGKO6cBH8PPxUTyD73Qi?=
 =?us-ascii?Q?cXxy8RDv8Bant0mLHpsY3T2XTLpAWrGcibQqlfczerlgts6RnCGKkancVOZy?=
 =?us-ascii?Q?mkG/8HcrwPtpP+RtN96wp3VzagcgPx1u0eq9aSTm9AHkMD0AnIy0L7OZmtQT?=
 =?us-ascii?Q?eQDhrYS0B2Alj73lm7GCwCAOKzdm9Ujn1yX75hspzAwlyGpW2GjBdGANvNh3?=
 =?us-ascii?Q?XXAqxtCUUvItUpke9pA7t4+GZKblkbtG91+o6w4pryd4raT4zSh+nmEpO2c8?=
 =?us-ascii?Q?aqPD9MgOcv7DTn+SIW+4MG1sEu78x5ciodGdEy2PlsWGpY2NDU1+964ehEzN?=
 =?us-ascii?Q?nK73Er8d0S4YYW86oUzYnvJNxZgwTX16RejddLZ/oWSisyWcG8G8LCeZ4EOj?=
 =?us-ascii?Q?PjCP3gYLtIS5lCdEd2zhRj8kUPpweDySHJb1AxDdOZOsmhwOl18i?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ff2255-0842-47ea-2a90-08df339d92e5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 20:13:17.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/WI3S9Sdm1B1eC5/r/yaTTChNBTUxmhJ/5AsdMM5sQ2QmYD5rw9/kb4lrLI3ACB0p9v0bbcKVM0wehZkUHV4EhQwiWdItweUSPe2EtzUQ+pmbHSvzA8y3/te2TohSOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

On Mon, Oct 26, 2026 at 04:04:02PM +0100, Marek Vasut wrote:
> On 9/30/26 11:49 PM, Marek Vasut wrote:
>
> Hello Frank,
>
> > > > > So I suggest remove it now and add it when need.
> > > > Can we please go with consistency between these boards from one vendor ?
> > >
> > > Yes, I am keeping consistency, then ask remove it. I applied alex's v2
> > > version. I put v1 link to show krzy's concern.
> > >
> > > https://lore.kernel.org/imx/20260319125013.2421621-3-
> > > alexander.stein@ew.tq-group.com/
> > >
> > > Changes in v2:
> > > * Changed commit message to imperative form
> > > * Remove (currently unused) display and backlight nodes
> > I sent you a V6 with those nodes removed.
>
> Have you had a chance to handle the V6 ?

Does first patch picked by vnod?
 dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563

Frank

>
> Thank you !
