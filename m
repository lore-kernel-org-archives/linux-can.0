Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB253914E0;
	Wed, 30 Sep 2026 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751285; cv=fail; b=lLKecynIEcEC3NFfYrASQ+vd8X51pbqu/cEnYYXOOB01dtDejh1aNMaf6j66mdBBGVBcwAVPO6dJYqKhkfVgsnGIzr1Yh29RYKiI6EgJmaOIY1BBzxIMq4/6aqBaUlkz930E6mHpqZpNMclMr8eEc9ySuoeg2551PwqIpJClTDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751285; c=relaxed/simple;
	bh=eXm7tLC7YQXxDuB6R2TQu306CIEWU+j6z/TgjjIv5dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=plPNx22umSj+I2hj+rl8rv6ek6BLXj1B/+y6zmG5VaysUpbQYV4vuyHCzy0nRdQ/bruvW0ei0A61zxJYr/MAl/EYwFy3ql7r48g0c2JoxtoHGUZjaMyjRr5TbJvJxS8laATJPhXrf6mhermVZZ5ryuHqlnQGYHj9EmklEt/vlbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=td0jKMfz; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="td0jKMfz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlYpKfWBmcsw7EglvbIyd8K3kk0g3CxOGuZUCmfxb9PFjtbnGnk93RcH8kCW31FYFJn3yrOryjl/TAgFMZJsrkGYpCZrsaFu8cICD63O50ivo+KQk9OGlMdBlnJ7lJ6ZGxayxOorc/uQAye//S0XTcJKy2CQM4ELxz67AeUgJ8AM2DShNxvDAGG/KkOW3bdKkc/wu5/V43VERbfvmcsABRhHEnwbSX66Jeqk0vTqtxz7mYhcSY0DNJopVQJF6jJDicY2BeCAK85HDtE4WVC/GJOEKIeaGZb8CWfDmDUPJb0nHqOsIdPhndWrduQF8hWlHLiH8R9YmpfT/lgB8d+pBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgsncTSPWNqxZYhheW5IrObsrKywZlJYyA31wkiGSgQ=;
 b=pNRbMK7SztB8b3ammmZosUzdLFLf6LXTLpG2SGhA31x9O3OQ9eVlWqQ9WKKGB0c9NasEFUyiiMLhc2Ubm86lpWAjkapnKu4fri6GpYOQxG9kd+lBLSOzWfFMbUe7RNSIcviKG5sIVY/cLIkRk1HBW3wdwGJwJUPOH5RuYWNwkWRJQQki5Awib0PTM7XhMryuJcpwGNhFVa4PrfPbOFbl/RlLmfEPyBEQQj4V1mcjOqrGfEMKm3PAt2RUqmimy5hg97WhfT0jPPIypaArB86BIE4zzkdnMiPXKs+tfWs8puNLUH1NuOGXWME7JAKXs2CfFPbn1u9rrqMpHXUJMIjhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgsncTSPWNqxZYhheW5IrObsrKywZlJYyA31wkiGSgQ=;
 b=td0jKMfzUua/rzuIs8iSGHUPwXFtfiz3c8E4IJtkyTeva03ARrzrlzF+Hikb1sdoa4Hn265d2Br858BtrGLEN4aaHxUq3IdEY5HxvIan5TiQaAV0PstuYGFp3Cn64ukyxlXJXYh8eq6Zieo9fp5WtE0jglUX/5mpxQuu+M2AgA6HPnQj0eM6RhFf3Iz4zi8w+pp3hVMJhLuPrap2McjMLCR74wXKmKoUpfvMRSen1JX32LmsaY07twj4h1Z6HfpkmXdyOcWw3vuEsjjZY1B0+ZcsZPu6REylab49eUUfPIVw9zKqYzTBcPet9RfyTIlIMjXjUXWhuLLsrIH0TWxpTw==
Received: from PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18)
 by VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:54:35 +0000
Received: from PAXPR04MB8831.eurprd04.prod.outlook.com
 ([fe80::f70e:8acd:d9e6:9102]) by PAXPR04MB8831.eurprd04.prod.outlook.com
 ([fe80::f70e:8acd:d9e6:9102%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 06:54:34 +0000
From: "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH net v3] can: flexcan: flexcan_get_berr_counter: don't
 wakeup controller if interface is down
Thread-Topic: [PATCH net v3] can: flexcan: flexcan_get_berr_counter: don't
 wakeup controller if interface is down
Thread-Index: AQHdUKV51KMWOsffbUKA22oDooSzuLbmr8sw
Date: Wed, 30 Sep 2026 06:54:34 +0000
Message-ID:
 <PAXPR04MB88319D93FF0CBBE63E2C1194908B2@PAXPR04MB8831.eurprd04.prod.outlook.com>
References: <20260930062738.30145-1-chunyuzhiqiang@yinhe.ht>
In-Reply-To: <20260930062738.30145-1-chunyuzhiqiang@yinhe.ht>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8831:EE_|VI1PR04MB6991:EE_
x-ms-office365-filtering-correlation-id: 3e337bb0-3a40-4929-31fc-08df1ebfafdd
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|22082099003|18002099003|38070700021|6133799003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 6RjpevL31M6gNiWT67l6UrbnOlPOwlC4wuH2Apdv0VBS8eAjy/tobKmQ48VrrSsxyiTpSbuAKL55v5MtgDw439DFDdX5tkY6C+ndxSMO1gZIH6viMufLy9OVWD7EXgxKp5i2LB67LykPEtIK3cvHfcsgNbxXu8EiPuwkirW1qjHXVbuigtO5TaVqTsl/xgyUG13UufXj2vMpuYfgcBeVHfgb6PiNSJeB8QKlky1bFzcCmi7b1VzUX9EuENPNzCeEqHXpVJdeVw+1wpphhkUwu3fvsHzqA0/zHxdyWiZ18vxwkDnMsMhL9aA69XeR0eKOtbstcRXMwbbbs+wnwr+3kNBsHhgYjOE8rnf7fYyro/wzvF9SrkfKoQLGr5VlmAe/3Gxun9XcmWviK97CMLIu6j0II8RgddJTFZfcPz7aRJtnBokF5+9224tdPqTzaeb+0tson6vT+0NI1OikBQya1NXCCGxxFv2T+siMymXjDm/u7GjpbjMW+XNBveGByErhqLqzZcepUaLhNclpxqKyrsPy2ftqJy/XgUiuTkr2ajxG2LYuAxdexROJss4WrePCg2vu6PP+c356shlB4O6DaTJvpvC4W9UVelBNwtqGSuP24MyTPrI4vBSWQ4kHz9qv/BAt8dq63SGvEIgRxozLKTC8c0yUPsY9/s25oByVKAc6qoXS5PayhG8WSSxJr51Pnxthjc2m336LHNNz88sVx/WBZ5LaBARP+uTLIR+JKzw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8831.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(22082099003)(18002099003)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1U8+hh8sFzak8Z4zjpwbC9vQ2i4g+2CYTcocWeWm4Uey9IgyFqgFkXto21SY?=
 =?us-ascii?Q?lqxY6P9kUmfrsU0gG3PIFuGg0/I5EGvF4u0wWvj8L8QwT4ZgHO6BPc/mqE10?=
 =?us-ascii?Q?hmgW3uJr7w1Nr2FyomDD6q6yipFAqsGZ+xSXv5mUsBivS9zB7dQkMSwN/MGT?=
 =?us-ascii?Q?UhpO/6Mw07crFetr4V0QFI+LrYp2iMh8Hq6NfGh3kaA0ABRdH0C0DcSmQ3da?=
 =?us-ascii?Q?w/4prrBd8kUpY8+SJ9HplCQdOQ8uuJLRMcVhw0onjJ0NWLMzCZ5zBE6SGw87?=
 =?us-ascii?Q?4ryLc1LxpXJD9KML6vfKHm3ftVKE4S8ngN0P4RWH0JcOBQlaykb1u5UaqrUC?=
 =?us-ascii?Q?L9S07PHylBfEX6we7eFFbEORH4yjYz843tS4g+pdioasW0FOByElHlPo5mmx?=
 =?us-ascii?Q?1S8gNK9aXEcMkWnFbV+hZ6OWVuiiOkgfLFlLeQ+UEio/Oztj3Pns/7Pjtm6a?=
 =?us-ascii?Q?RWfkiMmBfpRxskqepQiDPVgxxMK6yy0B9Dp0oLd9UOMvypmtqutoadJS1Qre?=
 =?us-ascii?Q?v3BvU/B5x8XyjTSsXno4M+rKocBXqlmREipEeO5o5Fn9+cDl6ZGils7m8yZ7?=
 =?us-ascii?Q?sco0wpOWXB0POmWbgvJCtsDMV2ubHOKkEv1mfBc8dJx/i2gCDfEMftZ6RhMn?=
 =?us-ascii?Q?meNQdZZ9ooNPVr85gBJ9+XrhItsLubm97QuvaTY9AvvAnC/DDlQhpd/rZuKq?=
 =?us-ascii?Q?RCzFPdiMxjZoVoYmjjl5cnD/OGl3SUOR2/LFJa0U7Cv/N5/LDu7iO6vY95XD?=
 =?us-ascii?Q?CEcY5hz8GxrZVxb18rj5OKV9OWwMKtn8oSqvzfzMIaGuwOLlyuywGXBL8sYq?=
 =?us-ascii?Q?lBrVeiF06v4RjmWvkYlqhobV4YDK/b6TVI4z9XfvYC01kETTMlASdDOq47SL?=
 =?us-ascii?Q?ZJ4YVQ636sCrCquUJzrLz27ieIbupvSxaIZJU+rjK1Ae073RMdkClolYVM3h?=
 =?us-ascii?Q?YwiSISBSHjNK+k67+/myOe2T0i22Wyjomc8FjTBObZyYuZ2v8M7ayw/TufvW?=
 =?us-ascii?Q?C+YO7f6Bw+tOJgQ3NdaGSn+p+ZCU3U5y01Do5+uR+IDU7PVUZxFow9xckHNq?=
 =?us-ascii?Q?MWYiXKbvIoSAgvGke/JMq9KkX5xvoGO4qdZbQVpcNgc6vJjYEn/x/K79lHKZ?=
 =?us-ascii?Q?3c/DbIZEmnEEzeUc4SjXIjtS1ahxn3t2ZYuDR+1SvNYz7nfpUguS0XRhrJVJ?=
 =?us-ascii?Q?lUdPLmQkOnHg/GDHbEXzVqpOW+8iI47bLNViJbfeBcfsRzulBb7F78g3Z3ap?=
 =?us-ascii?Q?LZ+i/5M0XyLIz4h/UNcn1z79DDWOgnX8+mFDe9HL1LPabdQGL1N78qBBMUeA?=
 =?us-ascii?Q?xMLGObQ/kHEX85Wh9hTtJBXleZKNDffugxR9IVqiat2rwcdrI6VpsAJRTt5a?=
 =?us-ascii?Q?17NEMDEe27w8LFgy9605nL3FKnUa9oWmoU9EanNgva5CCmqLf2FhavjnZyTd?=
 =?us-ascii?Q?y2dLSawu+NYKtByU3TaWFBgNkIF/wwwuAUWMtr7owe7dAIi9RkwjLsHixdcD?=
 =?us-ascii?Q?kCqaHLy7mpw/t156SxMhaDTeeFUCU25HwkEFbtcYtzKonWmgdiOWxlacaMWM?=
 =?us-ascii?Q?ZLhJfzDlHanz+FYnnYLubv1FoMS2YfRcvsPozayMw//2Gp4NLiQD6IwLNbGP?=
 =?us-ascii?Q?XN2XrX8jCl/wd1vD9sp88G81IVvg7ousw4t9U1Fmw9SAVJaZsuMFScku+hSd?=
 =?us-ascii?Q?enzok9+7r2ZOVhANX4lLXSwW/Dl9YIjg40fgpVoLTZ+zEoar?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8831.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e337bb0-3a40-4929-31fc-08df1ebfafdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 06:54:34.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IewJmQhRbm0JPTQ/AWMIR2bKDu652YgN76qTUJ2BqZeZbVuZILPDObWhqnqSnEi4nnkg/eEghUYiehmQgv9Ung==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6991

> -----Original Message-----
> From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> Sent: Wednesday, September 30, 2026 2:28 PM
> To: netdev@vger.kernel.org
> Cc: linux-can@vger.kernel.org; mkl@pengutronix.de; kernel@pengutronix.de;
> Bough Chen (OSS) <haibo.chen@oss.nxp.com>; shawnguo@kernel.org;
> imx@lists.linux.dev; ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> Subject: [PATCH net v3] can: flexcan: flexcan_get_berr_counter: don't wak=
eup
> controller if interface is down
>=20
> If the interface is down, the CAN controller might be powered down, the c=
lock
> disabled, and/or it's external reset asserted.
>=20
> Don't wake up the controller to read the CAN bus error counters, if the
> interface is down.
>=20
> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch o=
n
> clocks before accessing ecr register")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen
> ---
> v1 -> v2:
>   - Reword the commit message to drop the MDIS reasoning.
>   - Add Fixes: tag.
>=20
> v2 -> v3:
>   - Use the title and commit message suggested by Bough Chen.
>   - Drop the i.MX8QXP-specific crash dump and erratum explanation;
>     the fix addresses a generic logic problem that exists on all
>     platforms.
>   - Drop the m_can reference.
>   - Drop the Link: tag (added by the maintainer at merge time).
>=20
>  drivers/net/can/flexcan/flexcan-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c
> b/drivers/net/can/flexcan/flexcan-core.c
> index 06d5d35fc1b5..b08779ee2a0a 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -765,6 +765,9 @@ static int flexcan_get_berr_counter(const struct
> net_device *dev,
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
>  	int err;
>=20
> +	if (!netif_running(dev))
> +		return 0;
> +
>  	err =3D pm_runtime_resume_and_get(priv->dev);
>  	if (err < 0)
>  		return err;
> --
> 2.47.3

