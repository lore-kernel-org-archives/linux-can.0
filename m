Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011044.outbound.protection.outlook.com [52.101.125.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F93EFFD1;
	Thu, 23 Jul 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793743; cv=fail; b=nW0l+NXQBC2mi9/bwLFFStd1jxC0macf0gqEx9Nr1+t8u4Nu/LRFiDg5PU3GpikoEoKlY2YfkxT1Imp73FXetlsZFZQZdpUIOm+viDBoRxJEfFehBTl5+CftEfNx1lZ7PgOeaRbohD7RF2G7+emJyESaOz9vFcU12YQGwawu7Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793743; c=relaxed/simple;
	bh=M4lSbFNwbDR2jnanmOPMK+c4fT/Ck8P3C8WGedayRXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+ieuIDklWXXWpU0ojuTV6jeXuq68UN5RFg2G1lYh48hBfpOiYVNq0nbdHnoxHZS7j++m7kkUSFZTg/XWoFINYfBZHAQKLj/WGOE/WVScxVF6960TO68sqliU2jUN8r+sr+6SYbzwFd8ptZ3EH2MEo2/vOzpUHLECKt9hQb6LNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qRhuRLzv; arc=fail smtp.client-ip=52.101.125.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qRhuRLzv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuLGBywhNPv3WOMpk2SpbaChLY42OVa16T5OF4z8KaCSHsOVzMMv3B7bE5X2XyOHlxzaXZ6koiKwJatvz0IU0zohLwqHbVbDMX8ELfM/vu9dTKoZ13V9zPjVqgY/UdBMFHJwGi2zmzoVSgIZmRGcFY9vYvM3jub7MuhbihPdxJE7ForzNvtfj1jX3Paazde7LyN4u1AUWK0YlWKI519JK1uAiHnPsxkyS9hA3a+KOKTenigEbWO+mkOtTjgez1x6YCdQA0xN2D2LbkOPpO66y2GSUDgyzThLE73PGsEdk0o04TSvP9mhwqtsHifgVUpqbYr0ezH3U7+iPjGdUps5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD1oX5Ovxx9YcqKbYngesy4xaovQXLflngwEaSodP1M=;
 b=GxSNVIt3GpRH4hxNtruw6OqM67k/RVQBTikMAVEYMrehDiM5dpxVH8L7JW+5tJPntSZE1EKcm0iG5RvDRVpC1MjtCFQMvYe9gm/ronzZ2wy840T7ur+W4rqNJl8L3Zir1hkfR3e95m2h2XBkMuE/0kVeZ0sZaz/wX5U8O3xivRDd2BolzzV7NVLky4jer+aGNZqvBoAjd8l9VYcrUf553Lff9KzMSImZectx2nsY3IGnICxcYUyZP0lyYXPt8tH0+VoJMOLYX2YnzI8Kq6dyRap2Ve8G7bZt/MFShC55cTdRUYrSRG9e74PFxdqJ38skJt/xPaIWUQF4l0Cd6OhorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD1oX5Ovxx9YcqKbYngesy4xaovQXLflngwEaSodP1M=;
 b=qRhuRLzv2ruCq3T5Ax0ZWWRe4KTT667yB2Sdf+3x++Mij5mgdzmjrCHNwanU2zoeRnJCeow48pRDnSWZp4F/RcLSfKvt8cm6mNH5BOnGdyxglzpiI8o9nXn5Yo6bnyTtYF/8xZODZtBJpCblrEP0tvDAC2uNKsXsPETxsq2TaAs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB14153.jpnprd01.prod.outlook.com (2603:1096:604:361::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:02:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:02:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: Tu Nguyen <tu.nguyen.xg@renesas.com>, Duy Nguyen
	<duy.nguyen.rh@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, biju.das.au <biju.das.au@gmail.com>
Subject: RE: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Topic: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Index: AQHdBKnahRscR7xhqUa4HQBpTADRvbZ66ZWQ
Date: Thu, 23 Jul 2026 08:02:08 +0000
Message-ID:
 <TY3PR01MB113465FDE69A565A731E9238586C02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB14153:EE_
x-ms-office365-filtering-correlation-id: dd3637f0-1873-458f-bd5c-08dee890b1d6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 UCg6w24tAAJX7mxU4XCbzs5V3AKiEy+6QPCEq5vwHuqzl6KBqjoIZpsAg0IYc2zTLGeTSG1bPSEz2QcU1IF2YYlUGFxHLHvqOreanTsS1tDdEE2rUU2UiNl+Zg5O5CVNkfTSHDCb8HHFdsVxsnL7g/y4SOu9NVQRp+56WX0tNtWUrNTb8K08jsqqL186p691WhdMyTZ7bObTpTsWec6Sss/WyN697NZhO+2+9SA1pM87Jy0+xzuvbmkeh1Z5Nsgjsy4L7N409ExJsVc3xcS38alhVy56om/qzLDmAhS6sccu0FS/eWhAa1rB023AXD4TZEztDm7+64Dk7GRTzU+fZAW7gJqAdGRogtFw2alMoX0yroNtV3ze3UYgPzVkFiL92Sa/1IlE5LqwdYQ+E/PWFnACT9ncg1v+Y9S4CDhAq24D6mj81kMTLfQLkeb6Yz3N4wjH39xRSLt8MTTLyMzXS96S7jYZLDMFT3v3uwv6oFi3gq3EjU4oQKk4UUaUVLGLwGla2CQetx3sgWoQOb42Fdq7xj7jZd0P8os1EQIq4EFdaRO1BlXb7bvLUoQpapV6K0kK8qaybKh1J9m/PXl5tivJzHgyqMZKckJU7FHgsqX4UUQDRPuAdzpWDCEUSLFAYIldgXY0K3NX2I2H+pWM82atdGYCr/djmZThcjzd3hlRVV/4k3KLWlBrKTYgy/0xLix70RO/ZNRN00UgNzZOypLxuk1fOaN7RtcdDOHtUMM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KNNKqpvKfSRnkeCMZXD1dqKFNKKCxbvF45YszI8tbHN6jPMjjkdbFvVEEAZV?=
 =?us-ascii?Q?VEMMVPI2I749SZsA4Q/8AYd8Zj2N/qx4HmLVMv2R3/PMBNSriRJdToaxQqLf?=
 =?us-ascii?Q?QASdAXoLSKsCAkL57HcVR6Kdp4Mm0/2l+4Lcm2ePnN9zqAT5OZh1fhO8dzqX?=
 =?us-ascii?Q?ViolvVCvmYe826WQUaiHhC+YZ/l7S2ZE8S5Mog5Xef+6vSmEkLNUmfJFjLw2?=
 =?us-ascii?Q?QNHNaVXDMnhfoMKdPdlRbQZ6teSRXDQj/5GD9II4g9c/pKpa6E+yJ5Cn5SRK?=
 =?us-ascii?Q?NB6P1IY73D4KY7y5T2Oo/GdmCZJaGtpSdIU48RSz0I8zUI5Vx1pqiTSKCX7w?=
 =?us-ascii?Q?aoCTLsoZxzLEwPRRnYkmh0IsXLAVo8dS0lhRkv0e2W7qLc+uCGrvZKP056oe?=
 =?us-ascii?Q?k8s8Kb8kXvwhwGzv97Q9Nutcvuo1rPfrTF1CD1dDfbEfBLN/GhUefSCCyaiO?=
 =?us-ascii?Q?POIluyAvqebqgAuQL05RANq69Y+YFxbDkZDyHsrKemuYpXMWSEw5Nvm7M1cy?=
 =?us-ascii?Q?Csv8qOzVdlwwAGtsM8KyRmzoxz1XfL6oMtiVk4HE8Q+fP19uv5/KniabeXc7?=
 =?us-ascii?Q?U3cz+hzI4qtXwC6OrnI6QUBsQRTrJA+KdZ7rxoFK5t2/3SHrl2UucOynuo53?=
 =?us-ascii?Q?FUY8BEEANZ9bu9SKNJMFO0KQs/KSGwySXsygGZo6WNKybgvEiojSb/jrQ1rO?=
 =?us-ascii?Q?vtIAmBM3d6LsXzbTMPPlzTbGrqgP586P3ZbS/u7wMzrZ5rJbyiI0x1B9pWEI?=
 =?us-ascii?Q?KPaeF2rURaaT2YYvFFZPJupD+yfTANYXIxba+hGnDeJeg5GayoWPmyawU8KA?=
 =?us-ascii?Q?OnE/B5rFYzPlhhBpWQvpF9TsKzVvAjRjUlvOSM/yz6gC1sz2Z0R/bMMbLvpX?=
 =?us-ascii?Q?EK8HcDFCAs54wiSdxS8JFytsGFkyxLPNlJnLCWT5VLP7c+T5brcBY3uOBB2e?=
 =?us-ascii?Q?koFFi41uqoLS27D3BBPXqgzWZPjWN2AhuFM9+RIBNdbOfgn1lmM6HRuuEuMw?=
 =?us-ascii?Q?6YhCzrJJfGuNmOp9S/XA/uGa9oopPkPdX87a37NptO74rOm5u0MNOj3JILwU?=
 =?us-ascii?Q?vMCGdNmjb8tJ1AhigstULpnskUci0TZHBxbVMbLjWU80IM7Qv5MQTTdgNB0F?=
 =?us-ascii?Q?J9xP1tkW242fRAAkRcz1vBRy7dfHUhu0iDSQD+BC2hbzBlCObB7vwf14PbPX?=
 =?us-ascii?Q?eRCPEWqyucs0upsJ7oG2gsl/QoG/YB2N6NI7CtiIDZi+NUEm7N4sx+cBAlge?=
 =?us-ascii?Q?7FkJ4mR53P+sZBg3kzNGyR2dMwnMz2WJ+3+pVM5hiAVcoBM5k/3vs3VAroAf?=
 =?us-ascii?Q?vDUWM1OAlYXwQY6h/+GjlxEYBDNjRLLIq0QHXzc1ylzZsPgao7pH7Ng4hGSD?=
 =?us-ascii?Q?AL1JpzdMh63VroNKputPW5kL9PnLJCq5Pmw7Pq+j880dazzhkZhWaHWiZMWi?=
 =?us-ascii?Q?qr6rgiWA2kaDl6KsN6Xzae8pwdJb2kQnI0HqGJCpZUQik4SVZQg8Nb2BmKxR?=
 =?us-ascii?Q?KGJ1SL62VYOT4hS3lfE1NLTEkPRe3D586XPI3UsCuVlJDAVS44VDxC4vRv7h?=
 =?us-ascii?Q?COJdD+JBH8mioo2tKKAuooQFezme+VaeXHCqt8mGPqAe8RHsrCXgLRGhRusM?=
 =?us-ascii?Q?o+dO6mNokaECiL/uT/AMVbHAn55hlzdI838KoLUOIFFobzNhrTJSJPHtcgJk?=
 =?us-ascii?Q?QvFu396uWzAFwIbnYuPSZsSfPl+3kXdFRQvyoh1wGUBgxDGLQcnA8+bKOmyN?=
 =?us-ascii?Q?8gTp0Q/w2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3637f0-1873-458f-bd5c-08dee890b1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 08:02:08.9374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pYYmmMJ+GQLYGYNT+NzNC7YepY20yNbNHcuwC0hK8W3Q60/JVPcQm2r2DtRI3XOOl3SKp/lCct3SSzjd97Hy9hLUkTQi9Uz6PjLATjxvZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14153

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 25 June 2026 14:52
> Subject: [PATCH] can: rcar_canfd: Change the initializing flow for clocks=
 and resets
>=20
> From: Tu Nguyen <tu.nguyen.xg@renesas.com>
>=20
> Testing CANFD on RZ/G3E shows that many registers do not reset to their i=
nitial values with the current
> flow of deasserting resets first and then enabling clocks.
>=20
> Based on the HW manual, clocks should be supplied first and the resets de=
asserted afterward.
>=20
>  section 7.4.3 Procedure for Activating Modules: RZ/G2L  section 4.4.9.3 =
Procedure for Starting up Units:
> RZ/G3E
>=20
> So, update the order of the initializing flow for resets and clocks to ma=
tch the hardware manual,
> resetting all CANFD registers to their initial values. Also update rcar_c=
anfd_global_deinit() to assert
> resets before disabling clocks, so the teardown path mirrors the new init=
 ordering.
>=20
> Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
> Signed-off-by: Tu Nguyen <tu.nguyen.xg@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 32 +++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index eaf8cac78038..fcc37b73ed43 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2003,20 +2003,12 @@ static int rcar_canfd_global_init(struct rcar_can=
fd_global *gpriv)
>  	u32 ch, sts;
>  	int err;
>=20
> -	err =3D reset_control_reset(gpriv->rstc1);
> -	if (err)
> -		return err;
> -
> -	err =3D reset_control_reset(gpriv->rstc2);
> -	if (err)
> -		goto fail_reset1;
> -
>  	/* Enable peripheral clock for register access */
>  	err =3D clk_prepare_enable(gpriv->clkp);
>  	if (err) {
>  		dev_err(dev, "failed to enable peripheral clock: %pe\n",
>  			ERR_PTR(err));
> -		goto fail_reset2;
> +		return err;
>  	}
>=20
>  	/* Enable RAM clock */
> @@ -2027,10 +2019,18 @@ static int rcar_canfd_global_init(struct rcar_can=
fd_global *gpriv)
>  		goto fail_clk;
>  	}
>=20
> +	err =3D reset_control_reset(gpriv->rstc1);
> +	if (err)
> +		goto fail_ram_clk;
> +
> +	err =3D reset_control_reset(gpriv->rstc2);
> +	if (err)
> +		goto fail_reset1;
> +
>  	err =3D rcar_canfd_reset_controller(gpriv);
>  	if (err) {
>  		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
> -		goto fail_ram_clk;
> +		goto fail_reset2;
>  	}
>=20
>  	/* Controller in Global reset & Channel reset mode */ @@ -2068,14 +2068=
,14 @@ static int
> rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
>=20
>  fail_mode:
>  	rcar_canfd_disable_global_interrupts(gpriv);
> -fail_ram_clk:
> -	clk_disable_unprepare(gpriv->clk_ram);
> -fail_clk:
> -	clk_disable_unprepare(gpriv->clkp);
>  fail_reset2:
>  	reset_control_assert(gpriv->rstc2);
>  fail_reset1:
>  	reset_control_assert(gpriv->rstc1);
> +fail_ram_clk:
> +	clk_disable_unprepare(gpriv->clk_ram);
> +fail_clk:
> +	clk_disable_unprepare(gpriv->clkp);
>  	return err;
>  }
>=20
> @@ -2090,10 +2090,10 @@ static void rcar_canfd_global_deinit(struct rcar_=
canfd_global *gpriv, bool full)
>  		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
>  	}
>=20
> -	clk_disable_unprepare(gpriv->clk_ram);
> -	clk_disable_unprepare(gpriv->clkp);
>  	reset_control_assert(gpriv->rstc2);
>  	reset_control_assert(gpriv->rstc1);
> +	clk_disable_unprepare(gpriv->clk_ram);
> +	clk_disable_unprepare(gpriv->clkp);
>  }
>=20
>  static int rcar_canfd_probe(struct platform_device *pdev)
> --
> 2.43.0

Gentle ping.

Cheers,
Biju

