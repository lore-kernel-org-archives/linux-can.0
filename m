Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96353A397;
	Tue, 29 Sep 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693162; cv=fail; b=OSsGZ3Wm6/8sOlnFw2VT9/ka8RtUPownnuK5AY8x6eqsVapFgZ/r2Ih27ncDfw4z9amysQ4BBSPXHFYfOvu/g7pT5gsA3O70YlEhQ1+wzVydNu31/hIB4mDUHSsD9w8U06LD2inD20gYDtmZO/F6olh9VQYdTTklglckd6LHgFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693162; c=relaxed/simple;
	bh=fUIfRWCSyGVRrvUO1g8nKPq6rjZj6MXSTGf56FUggN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B58ebUAX6DHaf/dDehZ8bfcqyUtNDhhVg7s3VO8gNKzq8LBC81Cc+IrSTSDlPmh/d646KCc+cmc/7LzvZeSsD4F40Z2lPoZ1EWpBTZapPtHEiAE2te1EWvWTlTV59ylT6k6rE3+7dJ3qBNw31VgE+3pxczKniIfhzEweyAp/ESs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RgVfoO4e; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RgVfoO4e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9JWYUe3ySBxfsz1ToEnx/WwNhLks7xmt5+50YRR9HCJ+bk9+uCGBoVs3g5LUYS5QXSid+8sI7qtv+CjP8UjCJp6UEvMZ53PI6zVNBN7XWwfEh4PTOr/AXrd1HTiJWu1CDOx29pp4eAQDDRzhPSXRMbOuBcG+HRCqiSxHBhYSrLx/DcUnE3VTa2O0nKrDhjTxKPbc8htwn+Y6jpsG6BLXy1Bci8yvMgIj15yVyCPpi8oU1avX+7hT/6BIYu9ePqe5rG4qhhaoqQ61UeLiP8IrEVG3cKNgxxghTql5IwvTFDEJ6ldhjLdEqNhZhawCXHYjdqMaNeB6cIl7NkQKn/c0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOj3wXgZh/LVsrmyZr/iQzxavaoVv+BHd2SeeIlxex8=;
 b=xIjKYx3tc08VvsoN5Sm/5uXy0CKHqaHFJST4WJqyVVhlv9GL3JnMkWi9fh9/m96lVzRpTg/Lr6kz2asGj0SpVnU0yuvWC+jGUuOqpzH/pN+/hzid9+uNrIRvvnVVSPRYNHvAgSMB7ZvAIDjoQgrY5A6NF//akwBdXQUR8evEPoUyJA2ZISAciC4F2rSyIcSMafEYmAj/WbX134dIvYV9arJxbC6drpOXP3LdxrQ6two0BsVbvjG2uM+7fDKu4iLZhmDvBZWuNpAFZjnNaSUboeMtyPWdW8B6DBXzSgkdACpeVVyxWNuWzrBaj/fI0rM0P3B0YpKHI1bIAjia2Dog/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOj3wXgZh/LVsrmyZr/iQzxavaoVv+BHd2SeeIlxex8=;
 b=RgVfoO4enDwVGl1HrrGzJZZ3Ts1hvP8VTLnCZQ2ZUdqE/zxzj+7Tfak97e43n2rMsrGqgJUaXxtCQX40rDKszo4ysIuChtqqJhq05aGQaIgtdwqphGmTcuH2frVO6odMswWDPdW8W+9J+2ui0aDmvdjIgYv9wV9BpMiKc8D0E9rFqO0OpRohqpZVN8riFfGxZIU5LSHPaSHRF5jRtXwJdvKNRE+sqAdYkkCUS1nXMYzzSBcmot6VtmHY708gBv7BP74SCNDwZ2tNWTaihjmKrgyLw4i+Lq5TSYctdkDQau7Cn1u/NIJjc07jMQ9npPbR5OucIEbS+t9ra8iEb360Mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11613.eurprd04.prod.outlook.com (2603:10a6:800:2fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 14:45:43 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 14:45:43 +0000
Date: Tue, 29 Sep 2026 09:45:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-arm-kernel@lists.infradead.org,
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
Message-ID: <arvPDq8sjjv7na01@SMW015318>
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928204741.175754-3-marex@nabladev.com>
X-ClientProxiedBy: CY5PR15CA0212.namprd15.prod.outlook.com
 (2603:10b6:930:88::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11613:EE_
X-MS-Office365-Filtering-Correlation-Id: ac055e32-a281-421a-1c23-08df1e3856df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|1800799024|376014|366016|4143699003|260925021911599003|3023799007|10067099003|260925021311599003|260925022911599003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	92hnkc+oxlYshERMVTxU+CpQUrQZvMH2nibDrtd05M4jpZuKMmEY4YgXeYZPB2WS+UxzRhP4bjsoozul/XXA/9xaXStY1hr27hvEDpLJdYtxOpD2xM0vhF1qgaoJsq57KDKL+JgKlMNfFGRs8AADLnaw5M8JejHQ1Th7pwXWszqmDX2X84F0q8Npt0RgV9iIoi+GSwIijuWhHciWUouiWqhC/HiI9deln6A2awgsru8ATi4F49D8UkwHh7vXaykqR7ddL/H3xwIMkLoMDLkt2jeiQF8EZ0DueyDxGEoCmHmUM58Th1xli1CVFFXqCPBE565t5By/MdngNrafa6s6qnvInlvM5pQjz0MwTueNmBItqYdo7IXnVsVtwQegWy2HW3a8mvYt7BD3hviVGLmZDSfTF6OfnDQmTv7THiSeMdUjqIw/txrgd4ca1YXoxyYhHzRhFRE/F1eEEHlUpe2DOYAzNAweohe6KEgFKxF2OTBG9hpcX4W+/2vvZ5DO+l1N13x7ILs0a7YzO+UIMsJXuCXwpN9d1ymfYhRFAo6koshtp7bQb/bIbA1D0HsrCM0+2r1TUWdiGN993q6udF/YjelaY13CW5QW90Hc5VKqhGd8OJjAtmEBZIfJPNVu1TuCPcocwo3lw53tHDen8Uhuk8HO7cKZZLG1JE8fOcjVRnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(1800799024)(376014)(366016)(4143699003)(260925021911599003)(3023799007)(10067099003)(260925021311599003)(260925022911599003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CobUsvrsg5R0dcOxNPtqzqHEzW1yhwZr64V8zLQzTraRBRxF0lqWGTDI4C3Y?=
 =?us-ascii?Q?IR67YSDTUcAzGzgQSJO/NPS4c6cX342fP3pQVTu0Zzq9x3JH70pB7lonBGm7?=
 =?us-ascii?Q?56uKLwqxxg2gfc3gSs61btRMzvtVPLj5FE2Uldh4HwKR1eYcVclTlYxyKYGr?=
 =?us-ascii?Q?VBi1u/1/4IJQDYFdVCIDNtwmzPl9d60PL0rhuXpBj+zqvZBpTxHCKMalmEiG?=
 =?us-ascii?Q?bzKvoH7idp3G5A2w94wzuO/eVE4lt4wMTKkf0SWMoXVki/sQJf/M6ilTkUSH?=
 =?us-ascii?Q?6rJjdgBCSeYC7FRDrFll5lcAckz7H06QmfIV+YejXE/cc3WImb5+4MXrQqWk?=
 =?us-ascii?Q?3El2rU6Rxg/AtcGnHjgIWPjAk7clfDt5kf2/p4Xf0lq6Y/+IXWcOUlAaOdAJ?=
 =?us-ascii?Q?0JSPNVdCufU1+gOVBNZz1hIIn349pM5nGRgCf3pFc86HVJu1unsLnHCj7igj?=
 =?us-ascii?Q?tM03XS1qAeyVRLRc0JDFEbAB1oy6y6Z/dPWjOM7uKvF4zgBH/YtOwmzNSQLl?=
 =?us-ascii?Q?PcWxeWbc6new/5QmsO7/G+rgyXqrTDjJtZYWxyMjRsXDIFNvpsssDwKIlVPz?=
 =?us-ascii?Q?dcPZLZPhO/33pK0TKe38L22RcGl9zSxwgmCzy4GtPRZ8HjmLwf6h40kvPOuX?=
 =?us-ascii?Q?mqX2HxouUpKqYhHl8Vh9GB5lAMFXNJbNZKLS0iGArGzd6txaxse+VnkebkU0?=
 =?us-ascii?Q?gGroVGuVKfHQhM95EvtkQqTeeR7r28PnSkhn/tTj31Byb3kDNzICj7+bdB3C?=
 =?us-ascii?Q?2AcOKiqYpe/R4bK/y4kIbbzoa5/bUitVEjidbFX/SLt9Xbv/IO6ZHzX2qrMs?=
 =?us-ascii?Q?+WqLFmb1yILLv0tyvzNC3CJVzXDM43JSRhOaROBLtvvYcYBhwcClKZFaeN7V?=
 =?us-ascii?Q?hW1RE6rdOrZEnvw+GDVjOENGcAB/o08TiSGcfR7X+p6+GZATrXLD6YjvjjqR?=
 =?us-ascii?Q?KiLVyiyZhPgVsPMUhR70io3s6xlVNmGK9WFY0zcDTgQ/qIVf9VURcYenx91i?=
 =?us-ascii?Q?p8EPzWXed7ch4kZJCoVngUWW1CDnxcPPd+XcNRI16R3LEPji5nM4a250BVTC?=
 =?us-ascii?Q?7cgdeVYGYvDA3C23ox7NGRo798hyqcJ2tZAzwQMz23ah73ZGtXBNfDCWmz1F?=
 =?us-ascii?Q?yKgpGajrCiA4WfFBJ01EL98YdVmFOsgPBCg6xuHYKxgy7krwV9ucQw9zZEbt?=
 =?us-ascii?Q?KN5HOCT3pFdkYQ4UjXFsFiquKuq7JdHBfkFsBG6H68g5JtmfWzfS81LNSoJm?=
 =?us-ascii?Q?1gtlUjCfIcbP1HxcKCAD+Ybxs8YZLn1gkW3ZavFwbX6vKHH2WI1Z7kP0U4Dr?=
 =?us-ascii?Q?ykNcdswEKoP+Q5yLG4ZrrVjzdGTaqeZht44L/R6chENUg6p6/kzmYZnSYU8U?=
 =?us-ascii?Q?O1syaWCAFh/MRkktAtfv/T98O0MD+X/WfBzGf4kmFnUDoy64Yjya9Dv77wo5?=
 =?us-ascii?Q?Cs2Kg16IUfkbMn6YDRSmdf9d7lWCtXy+ql3ER3RRtmW1X2tEVv38fdiuK+J/?=
 =?us-ascii?Q?8Nf7jXHEyR8DSzZ2eRVpdXywmK5cypaPcfBp0Wl3oqVURmtAg9KlUo8H4Doz?=
 =?us-ascii?Q?6a0AWxar6ieFe0a45P5oR2RrLq63dQgBNpTJbGx76LSbphkovs5ZC25qLOxj?=
 =?us-ascii?Q?U4D8Yt0MVbqVzUqq0E/rdPzzEKboanieGG1eonj/SOmyWtGWhn0vZSaW6UZL?=
 =?us-ascii?Q?CMVprBi3YHFPbcaNUH2PNMfb9ftJnJ2Q6OFHMK2HswhwlPGueb2GUUHLMFSZ?=
 =?us-ascii?Q?uT6uvv1GXL1Q91bWE3rrvCH65vfcOomhLgp0cvDezWq7HZffJnhi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac055e32-a281-421a-1c23-08df1e3856df
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:45:43.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fxFzgv/0MijE0WXVt04QHBKVsjqcNtr6X4KB4FjiySuGQs+wwbpsQIy2QC0it1RBpSNQaatEdN3EVVE4RbGPpoNINr9oMUmI4UdMCLDBJa+fZeByIG1WdfvzsBlrJke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11613

On Mon, Sep 28, 2026 at 10:47:14PM +0200, Marek Vasut wrote:
> Add support for Data Modul i.MX95 eDM SBC board. This is an
> evaluation board for various custom display units. Currently
> supported are serial console, ethernet, eMMC, SD, SPI NOR,
> USB host and PCIe.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Aswath Govindraju <a-govindraju@ti.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-can@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> V2: - Rename PCIE_M2-E_EN to PCIE_M2-M_EN
>     - Fix the PCAL expander GPIO reset
> V3: - Fix regulator-5p0v node name
>     - Use reset-gpios consistently
> V4: - Replace gpio with gpios DT property
> V5: - Rebase on next-20260928
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |    1 +
>  .../freescale/imx95-data-modul-edm-sbc.dts    | 1111 +++++++++++++++++
>  2 files changed, 1112 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 9971b34f73019..19d46797f73a8 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -957,6 +957,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-frdm-pro.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-aquila-clover.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-aquila-dev.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx95-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-osm-dev.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-smarc-dev.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-tqma9596la-mba95xxca.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> new file mode 100644
> index 0000000000000..0181262eb8a98
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> @@ -0,0 +1,1111 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025-2026 Marek Vasut <marex@nabladev.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/i3c/i3c.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "imx95.dtsi"
> +
> +/ {
> +	model = "Data Modul i.MX95 eDM SBC";
> +	compatible = "dmo,imx95-data-modul-edm-sbc", "fsl,imx95";
> +
> +	aliases {
> +		ethernet0 = &enetc_port0;
> +		ethernet1 = &enetc_port1;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c5;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc2 = &usdhc3;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart5;
> +		serial3 = &lpuart7;
> +		serial4 = &lpuart8;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0 0x80000000>;
> +	};
> +
> +	backlight_dsi: backlight-dsi {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <0 1 10 20 30 40 50 60 70 75 80 90 100>;
> +		default-brightness-level = <7>;
> +		enable-gpios = <&i2c2_gpio_expander_21 12 GPIO_ACTIVE_HIGH>;
> +		pwms = <&tpm4 3 5000000 0>;
> +		/* Disabled by default, unless display board plugged in. */
> +		status = "disabled";
> +	};
> +
> +	backlight_lvds: backlight-lvds {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel_backlight_lvds>;
> +		brightness-levels = <0 1 10 20 30 40 50 60 70 75 80 90 100>;
> +		default-brightness-level = <7>;
> +		enable-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
> +		pwms = <&tpm3 3 5000000 0>;
> +		/* Disabled by default, unless display board plugged in. */
> +		status = "disabled";
> +	};

The both backlight is not used in this dts, can you remove it and
add these when it real use.

Frank

> +
> +	bt_sco_codec: bt-sco-codec {
> +		compatible = "linux,bt-sco";
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	flexcan3_phy: can-phy0 {
> +		compatible = "microchip,ata6563", "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&i2c2_gpio_expander_20 15 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	flexcan5_phy: can-phy1 {
> +		compatible = "microchip,ata6563", "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&i2c2_gpio_expander_20 16 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	led {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pinctrl_led>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <0>;
> +			gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "off";
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <0>;
> +			gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "VDD_1V8";
> +	};
> +
> +	/* PF09 SW1, but the PMIC is controlled by CM33 */
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "VDD_3V3";
> +	};
> +
> +	reg_5p0v: regulator-5p0v {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "VDD_5V0";
> +	};
> +
> +	reg_panel_vcc: regulator-panel-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "PANEL_VCC";
> +		gpios = <&i2c2_gpio_expander_20 17 0>;
> +		/* Disabled by default, unless display board plugged in. */
> +		status = "disabled";
> +	};
> +
> +	reg_pcie0: regulator-pcie0 {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "PCIE_M2-B_EN";
> +		gpios = <&i2c2_gpio_expander_20 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_pcie1: regulator-pcie1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "PCIE_M2-M_EN";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&i2c2_gpio_expander_21 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usb2_vbus: regulator-usb2-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB2_VBUS";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpios = <&i2c2_gpio_expander_21 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "VDD_SD2_3V3";
> +	};
> +
> +	sound-bt-sco {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,bitclock-master = <&btcpu>;
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,frame-master = <&btcpu>;
> +		simple-audio-card,name = "bt-sco-audio";
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&bt_sco_codec 1>;
> +		};
> +
> +		btcpu: simple-audio-card,cpu {
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <16>;
> +			sound-dai = <&sai5>;
> +		};
> +	};
> +
> +	sound-micfil {
> +		compatible = "fsl,imx-audio-card";
> +		model = "micfil-audio";
> +
> +		pri-dai-link {
> +			link-name = "micfil hifi";
> +			format = "i2s";
> +			cpu {
> +				sound-dai = <&micfil>;
> +			};
> +		};
> +	};
> +
> +	sound-tas2552 {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&cpudai>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&cpudai>;
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,name = "tas2552-audio";
> +		simple-audio-card,routing = "Speaker", "OUT";
> +		simple-audio-card,widgets = "Speaker", "Speaker";
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&tas2552>;
> +		};
> +
> +		cpudai: simple-audio-card,cpu {
> +			sound-dai = <&sai3>;
> +		};
> +	};
> +};
> +
> +&enetc_port0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enetc0>;
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&enetc_port1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enetc1>;
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&flexcan3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan3>;
> +	phys = <&flexcan3_phy>;
> +	status = "okay";
> +};
> +
> +&flexcan5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan5>;
> +	phys = <&flexcan5_phy>;
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +		"", "", "", "",
> +		"", "BOOT_MODE0", "", "BOOT_MODE1",
> +		"", "", "SYS_WAKEUP", "BOOT_MODE2",
> +		"", "BOOT_MODE3", "", "";
> +	status = "okay";
> +};
> +
> +&gpio5 {
> +	pcal6524-reset-hog {
> +		gpio-hog;
> +		gpios = <10 0>;
> +		output-high;
> +		line-name = "IO_XPNDR_RST_1V8";
> +	};
> +
> +	pewake0-hog {
> +		gpio-hog;
> +		gpios = <14 0>;
> +		input;
> +		line-name = "PCIE_PEWAKE_M2-B";
> +	};
> +
> +	pewake1-hog {
> +		gpio-hog;
> +		gpios = <17 0>;
> +		input;
> +		line-name = "PCIE_PEWAKE_M2-M";
> +	};
> +};
> +
> +&i3c2 {	/* Feature connector I2C/I3C */
> +	i2c-scl-hz = <400000>;
> +	pinctrl-0 = <&pinctrl_i3c2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&lpi2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	status = "okay";
> +
> +	i2c2_gpio_expander_20: gpio@20 {	/* U12 */
> +		compatible = "nxp,pcal6524";
> +		reg = <0x20>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupts-extended = <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;
> +		vcc-supply = <&reg_3p3v>;
> +		/*
> +		 * reset-gpios cannot be used because the reset
> +		 * line is shared by multiple PCAL6524 consumers.
> +		 */
> +		gpio-line-names =
> +			/* Port 0 */
> +			"UART8_RS232-485_MODE0", "UART8_RS232-485_MODE1",
> +			"UART8_RS232-485_Term_TX", "UART8_RS232-485_Term_RX",
> +			"UART8_RS232-485_EN", "VDD_3V3_M2-E_EN",
> +			"VDD_3V3_M2-B_EN", "M2_I2C_ALERT",
> +			/* Port 1 */
> +			"M2-B_FULL_CARD_PWROFF", "M2-B_W_DISABLE1",
> +			"M2-B_W_DISABLE2", "M2-B_RESET",
> +			"M2-E_W_DISABLE1", "M2-E_W_DISABLE2",
> +			"M2-E_SDIO_RESET", "CAN3_STBY",
> +			/* Port 2 */
> +			"CAN5_STBY", "V_LCD_EN",
> +			"V_LCD_SEL_3V3", "V_LCD_SEL_5V0",
> +			"V_LCD_SEL_12V0", "V_12V0_CC",
> +			"V_12V0_PG", "AUDIO_EN";
> +	};
> +
> +	i2c2_gpio_expander_21: gpio@21 {	/* U14 */
> +		compatible = "nxp,pcal6524";
> +		reg = <0x21>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupts-extended = <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;
> +		vcc-supply = <&reg_3p3v>;
> +		/*
> +		 * reset-gpios cannot be used because the reset
> +		 * line is shared by multiple PCAL6524 consumers.
> +		 */
> +		gpio-line-names =
> +			/* Port 0 */
> +			"V_BKL_PWM_SEL_5V0", "V_BKL_EN_SEL_5V0",
> +			"UART7_RS232-485_MODE0", "UART7_RS232-485_MODE1",
> +			"UART7_RS232-485_Term_TX", "UART7_RS232-485_Term_RX",
> +			"UART7_RS232-485_EN", "VDD_3V3_M2-M_EN",
> +			/* Port 1 */
> +			"TOUCH_INT", "TOUCH_RESET",
> +			"CAMERA_PWREN", "CAMERA_LED",
> +			"MIPI_DSI-CSI_BL_EN", "MIPI_DSI-CSI_RESET",
> +			"MIPI_DSI-CSI_INT", "LVDS_PANEL_GPIO",
> +			/* Port 2 */
> +			"USB2_PWR_EN", "USB2_PWR_OC#",
> +			"VDD_1V2_USB_PG", "PF09_PG",
> +			"USB_HUB_RESET", "PF09_FS0B",
> +			"PF53_VDD_ARM_PG", "PF53_VDD_SOC_PG";
> +
> +		usb-hub-hog {
> +			gpio-hog;
> +			gpios = <20 0>;
> +			output-high;
> +			line-name = "USB_HUB_RESET";
> +		};
> +	};
> +
> +	i2c2_gpio_expander_22: gpio@22 {	/* U13 */
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupts-extended = <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;
> +		vcc-supply = <&reg_3p3v>;
> +		/*
> +		 * reset-gpios cannot be used because the reset
> +		 * line is shared by multiple PCAL6524 consumers.
> +		 */
> +		gpio-line-names =
> +			/* Port 0 */
> +			"eMMC_RESET", "WDOG_IRQ#",
> +			"FAN_ALERT", "VDD_1V2_ETH_PG",
> +			"ENET1_RESET", "ENET2_RESET",
> +			"TPM_IRQ", "TPM_RESET",
> +			/* Port 1 */
> +			"FEATURE_CONN_GPIO1", "FEATURE_CONN_GPIO2",
> +			"FEATURE_CONN_GPIO3", "FEATURE_CONN_GPIO4",
> +			"FEATURE_CONN_GPIO5", "FEATURE_CONN_GPIO6",
> +			"", "",
> +			/* Port 2 */
> +			"", "", "", "", "", "",
> +			"UART5_SEL", "EEPROM_WRITE_ENABLE";
> +	};
> +
> +	fan_controller: fan-controller@2f {
> +		compatible = "microchip,emc2301", "microchip,emc2305";
> +		reg = <0x2f>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#pwm-cells = <3>;
> +
> +		fan@0 {
> +			reg = <0x0>;
> +			pwms = <&fan_controller 26000 0 1>;
> +			#cooling-cells = <2>;
> +		};
> +	};
> +
> +	tas2552: audio-codec@40 {
> +		compatible = "ti,tas2552";
> +		reg = <0x40>;
> +		#sound-dai-cells = <0>;
> +		avdd-supply = <&reg_1p8v>;
> +		iovdd-supply = <&reg_3p3v>;
> +		vbat-supply = <&reg_5p0v>;
> +		enable-gpio = <&i2c2_gpio_expander_20 23 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	temperature-sensor@43 {
> +		compatible = "ti,tmp110", "ti,tmp102";
> +		reg = <0x43>;
> +	};
> +};
> +
> +&lpi2c5 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpi2c5>;
> +	status = "okay";
> +};
> +
> +&lpuart1 {	/* A55 Debug */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&lpuart2 {	/* M33 Debug */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "reserved";
> +};
> +
> +&lpuart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&lpuart7 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart7>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&lpuart8 {	/* M7 Debug */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart8>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&lpspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpspi1>;
> +	cs-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	flash@0 {	/* W25Q128FVSI */
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
> +
> +&lpspi6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpspi6>;
> +	cs-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&micfil {
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pdm>;
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_PDM>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>,
> +				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>,
> +			       <3612672000>, <393216000>,
> +			       <361267200>, <49152000>;
> +	status = "okay";
> +};
> +
> +&mu7 {
> +	status = "okay";
> +};
> +
> +&netc_blk_ctrl {
> +	status = "okay";
> +};
> +
> +&netc_emdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_emdio>;
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy@1 {	/* KSZ9131RNXI U20 */
> +		compatible = "ethernet-phy-id0022.1640";
> +		reg = <1>;
> +		interrupts-extended = <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us = <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us = <120000>;
> +		reset-gpios = <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	ethphy1: ethernet-phy@2 {	/* KSZ9131RNXI U22 */
> +		compatible = "ethernet-phy-id0022.1640";
> +		reg = <2>;
> +		interrupts-extended = <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us = <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us = <120000>;
> +		reset-gpios = <&i2c2_gpio_expander_22 5 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&netc_timer {
> +	status = "okay";
> +};
> +
> +&netcmix_blk_ctrl {
> +	status = "okay";
> +};
> +
> +&pcie0 {	/* M.2 Key-B */
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	pinctrl-names = "default";
> +	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	vpcie-supply = <&reg_pcie0>;
> +	status = "okay";
> +};
> +
> +&pcie1 {	/* M.2 Key-M */
> +	pinctrl-0 = <&pinctrl_pcie1>;
> +	pinctrl-names = "default";
> +	reset-gpios = <&gpio5 16 GPIO_ACTIVE_LOW>;
> +	vpcie-supply = <&reg_pcie1>;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI3>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>,
> +				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>,
> +			       <3612672000>, <393216000>,
> +			       <361267200>, <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&sai4 {
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI4>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <12288000>;
> +	#sound-dai-cells = <0>;
> +	pinctrl-0 = <&pinctrl_sai4>;
> +	pinctrl-names = "default";
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&sai5 {
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI5>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <12288000>;
> +	#sound-dai-cells = <0>;
> +	pinctrl-0 = <&pinctrl_sai5>;
> +	pinctrl-names = "default";
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&thermal_zones {
> +	pf09-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 2>;
> +
> +		trips {
> +			trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	pf53arm-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 4>;
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&pf5301_alert>;
> +				cooling-device =
> +					<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +
> +		trips {
> +			pf5301_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf5301_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	pf53soc-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 3>;
> +
> +		trips {
> +			pf5302_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf5302_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +};
> +
> +&tpm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_tpm3>;
> +	status = "okay";
> +};
> +
> +&tpm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_tpm4>;
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	dr_mode = "host";
> +	vbus-supply = <&reg_usb2_vbus>;
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usb3_phy {
> +	status = "okay";
> +};
> +
> +&usdhc1 {	/* eMMC */
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status = "okay";
> +};
> +
> +&usdhc2 {	/* SD-Card */
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc2>;
> +	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&usdhc3 {	/* M.2 Key-E */
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc3>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&scmi_iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			/* PCIe 0 PEWAKE */
> +			IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14			0x4000031e
> +			/* PCIe 1 PEWAKE */
> +			IMX95_PAD_GPIO_IO37__GPIO5_IO_BIT17			0x4000031e
> +			/* BOOT_MODE2 */
> +			IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11		0x4000031e
> +			/* IO_XPNDR_RST_1V8 shared by multiple expanders */
> +			IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10			0x40000b9e
> +			/* IO_XPNDR_INT_1V8 shared by multiple expanders */
> +			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_emdio: emdiogrp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC		0x50e
> +			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO		0x90e
> +		>;
> +	};
> +
> +	pinctrl_enetc0: enetc0grp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e
> +			IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e
> +			IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e
> +			IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e
> +			IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK	0x58e
> +			IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e
> +			IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x50e
> +			IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x50e
> +			IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x50e
> +			IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x50e
> +			IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK	0x58e
> +			IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_enetc1: enetc1grp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0		0x57e
> +			IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1		0x57e
> +			IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2		0x57e
> +			IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3		0x57e
> +			IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK	0x58e
> +			IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL	0x57e
> +			IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0		0x50e
> +			IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1		0x50e
> +			IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2		0x50e
> +			IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3		0x50e
> +			IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK	0x58e
> +			IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_flexcan3: flexcan3grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO28__CAN3_TX				0x39e
> +			IMX95_PAD_GPIO_IO29__CAN3_RX				0x39e
> +		>;
> +	};
> +
> +	pinctrl_flexcan5: flexcan5grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO30__CAN5_TX				0x39e
> +			IMX95_PAD_GPIO_IO31__CAN5_RX				0x39e
> +		>;
> +	};
> +
> +	pinctrl_i3c2: i3c2grp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET1_MDC__I3C2_SCL				0x40000186
> +			IMX95_PAD_ENET1_MDIO__I3C2_SDA				0x40000186
> +		>;
> +	};
> +
> +	pinctrl_led: ledgrp {
> +		fsl,pins = <
> +			IMX95_PAD_XSPI1_DQS__GPIO5_IO_BIT8			0x14e
> +			IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9			0x14e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL		0x40000b9e
> +			IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA		0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c5: lpi2c5grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO22__LPI2C5_SDA				0x40000b9e
> +			IMX95_PAD_GPIO_IO23__LPI2C5_SCL				0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpspi1: lpspi1grp {
> +		fsl,pins = <
> +			IMX95_PAD_SAI1_TXC__AONMIX_TOP_LPSPI1_SIN		0x3fe
> +			IMX95_PAD_SAI1_TXD0__AONMIX_TOP_LPSPI1_SCK		0x3fe
> +			IMX95_PAD_SAI1_RXD0__AONMIX_TOP_LPSPI1_SOUT		0x3fe
> +			IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_GPIO1_IO_BIT9	0x3fe
> +		>;
> +	};
> +
> +	pinctrl_lpspi6: lpspi6grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0			0x3fe
> +			IMX95_PAD_GPIO_IO01__LPSPI6_SIN				0x3fe
> +			IMX95_PAD_GPIO_IO02__LPSPI6_SOUT			0x3fe
> +			IMX95_PAD_GPIO_IO03__LPSPI6_SCK				0x3fe
> +		>;
> +	};
> +
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B		0x4000031e
> +			IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13			0x31e
> +		>;
> +	};
> +
> +	pinctrl_pcie1: pcie1grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
> +			IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16			0x31e
> +		>;
> +	};
> +
> +	pinctrl_panel_backlight_lvds: backlightlvdsgrp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO27__GPIO2_IO_BIT27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO04__AONMIX_TOP_PDM_CLK			0x31e
> +			IMX95_PAD_GPIO_IO05__AONMIX_TOP_PDM_BIT_STREAM_BIT0	0x31e
> +			IMX95_PAD_GPIO_IO06__AONMIX_TOP_PDM_BIT_STREAM_BIT1	0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai4: sai4grp {
> +		fsl,pins = <
> +			IMX95_PAD_XSPI1_DATA0__SAI4_TX_BCLK			0x31e
> +			IMX95_PAD_XSPI1_DATA1__SAI4_TX_SYNC			0x31e
> +			IMX95_PAD_XSPI1_DATA2__SAI4_TX_DATA_BIT0		0x31e
> +			IMX95_PAD_XSPI1_DATA3__SAI4_RX_DATA_BIT0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai5: sai5grp {
> +		fsl,pins = <
> +			IMX95_PAD_XSPI1_DATA4__SAI5_TX_DATA_BIT0		0x31e
> +			IMX95_PAD_XSPI1_DATA5__SAI5_TX_SYNC			0x31e
> +			IMX95_PAD_XSPI1_DATA6__SAI5_TX_BCLK			0x31e
> +			IMX95_PAD_XSPI1_DATA7__SAI5_RX_DATA_BIT0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK			0x31e
> +			IMX95_PAD_GPIO_IO17__SAI3_MCLK				0x31e
> +			IMX95_PAD_GPIO_IO18__SAI3_RX_BCLK			0x31e
> +			IMX95_PAD_GPIO_IO19__SAI3_RX_SYNC			0x31e
> +			IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0			0x31e
> +			IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0			0x31e
> +			IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC			0x31e
> +		>;
> +	};
> +
> +	pinctrl_tpm3: tpm3grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO24__TPM3_CH3				0x51e
> +		>;
> +	};
> +
> +	pinctrl_tpm4: tpm4grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO25__TPM4_CH3				0x51e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX		0x31e
> +			IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX		0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX		0x31e
> +			IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX		0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			IMX95_PAD_DAP_TDO_TRACESWO__LPUART5_TX			0x31e
> +			IMX95_PAD_DAP_TDI__LPUART5_RX				0x31e
> +			IMX95_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B			0x31e
> +			IMX95_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart7: uart7grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO08__LPUART7_TX				0x31e
> +			IMX95_PAD_GPIO_IO09__LPUART7_RX				0x31e
> +			IMX95_PAD_GPIO_IO10__LPUART7_CTS_B			0x31e
> +			IMX95_PAD_GPIO_IO11__LPUART7_RTS_B			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart8: uart8grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO12__LPUART8_TX				0x31e
> +			IMX95_PAD_GPIO_IO13__LPUART8_RX				0x31e
> +			IMX95_PAD_GPIO_IO14__LPUART8_CTS_B			0x31e
> +			IMX95_PAD_GPIO_IO15__LPUART8_RTS_B			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x15fe
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x13fe
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x13fe
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x13fe
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x13fe
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x13fe
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x13fe
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x13fe
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x13fe
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x13fe
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
> +			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
> +			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
> +			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x158e
> +			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x138e
> +			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x138e
> +			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x138e
> +			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x138e
> +			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x138e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x158e
> +			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x138e
> +			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x138e
> +			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x138e
> +			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x138e
> +			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x138e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x158e
> +			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x138e
> +			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x138e
> +			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x138e
> +			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x138e
> +			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x138e
> +		>;
> +	};
> +};
> --
> 2.53.0
>
>
