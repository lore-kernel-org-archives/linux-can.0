Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010066.outbound.protection.outlook.com [52.101.228.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5C3F107E;
	Thu,  1 Oct 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840471; cv=fail; b=Hj7lAOBUXNzxEGjBa78F4iuNuh0wtzi3Y8yTZNx+7UvEJmOfbK7lte2LwaUfgRW4D/ZS+IIagq5YcMWJJFCDA3WrNAt1m0O1TGKOfV1NCkJKd9m8tMJpXjXD3ZjFtAGU9X/wDS0R2hb9iP6QEgVgAX51bQGDnozBuw62QEpQmIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840471; c=relaxed/simple;
	bh=30vJdTmqhCTQcXRxTjhS/+BsMaNkyTjmL8mZchoxkiw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sEFTaCFiLOEn62KdBVmvu3nDZ+h77ZzBIzZolJwJV4/fub2lMpXK3sj5sh84kgdCyNfxG6WzNAip6P2Q7T2BjdR/EkM6CdxrGXkj52EjphF+QfMBUBAxm26mBNqPF3sZ3y0gCjIegR8vlKHP1jNkWlqmUmvozJBeSJoziUSDToA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XF6Mjgxq; arc=fail smtp.client-ip=52.101.228.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XF6Mjgxq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0Zydc++AwWS12peLDtcVh9GeIW4yGZJOO6rjGF4hbE6jsmY6AsJWwnxftlIdaKbMEPhL0FFY9rAgcuD1XLSoC43msb5hFlzbLO3DDrhc1U44YlTHtxZIu4gIp2SWJl1iwi4TgUGFMC9hkAtmTj5oVRJN95NrtkapaX/kl5dW9cO4QIbMGTwgMc4Dpf0/jTYOsgTLxk/8sJmIzdMglBQPRcAzTwPOZPCxzBlXato0y3XbE2hxVDUBax0GZT76Go9OMWe21K0ppa48xCb3VUANGu0LEcAcIz5j48zjJW/MEofUl35WPznCxwO5YEIMNS1vQYCjnbOh/QonPN6ytmeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5AugtXzz63pnVzuTPPuGkSAfGEN7tPfDvMKaXC8wrI=;
 b=bG4RtLOAxN5ldM4KVLzGDJyCJUYjEDeD3cUXzqhEfCNGrzNUyecxoegMujbm4g9HHb9rDjolMdXQkYjVPxHXR6//gEF9yzPZCx9k+vqHBHyxNkfk/A8V6tK+nQLd0La7fN4wj7eQbpEgniI3Ijrie1GQIAIxsFW7ef9wP1fCquQk3lBvRaSZj4ku5XQCjQVcWNTgfK004Ny5qmTKbLZ7jWpj+jmJVGZF1RsuHsYwd71tcLdjJvAkZHFRfm0FU+vyJ/Z5ZTERpzr6ByvNzejfZrWQfoxX2uxi7Y3yD9yj4L0ohRyVNpJhpQyszlph9NmZjMB0izKrSPLwUKg6pg/Yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5AugtXzz63pnVzuTPPuGkSAfGEN7tPfDvMKaXC8wrI=;
 b=XF6MjgxqYbyBLOMjJSDGyylxV7Sm9TTQ1cFSdQT5N4h0vOpAVbkvpNArNTZtJcABwLlSyJUmf7IFQfxwdE6vogcuDyMkLNjJvXPGDdbkhJPwJQkppIzwlGVfl4x+cpMdH8clpIgjTj87PpozLs8bzfMQTsbn1R1X9DPNMNgFdJ8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB15629.jpnprd01.prod.outlook.com (2603:1096:604:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 07:41:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 07:41:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict resets in
 top-level
Thread-Topic: [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict resets in
 top-level
Thread-Index: AQHdUWtR+xjFVOXGnEOnACmSWso6QbboTVTg
Date: Thu, 1 Oct 2026 07:41:04 +0000
Message-ID:
 <TY3PR01MB113464BDF987612E3B13173FC868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB15629:EE_
x-ms-office365-filtering-correlation-id: ec5656a2-64a2-4a46-6b0a-08df1f8f5960
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|11063799006|921020|3023799007|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 tb1ofXvWj3YV6IoaFMwA8XRMo8+LJM0AE7qgKUbWEkKyRnbIwqZlxHPlzI1xDOc8Rgvkt4V/Xm5rJawLp3C1f5PkI+zruXMe4ISozFN2kFxE8AXJ0rA2zX+BDzmymhj3ATZZNMaAhkSX1eUq0KkE/gvpctdvAP4hkwXK4WW4pogaoSd4mumAMSi9chMjr7g8o0PDGrFcDX2pLJztaklUxUFZn/ZFFVm4GMa6d0U/QQkjAltkcV9c4TVeA9FahQhBTSKMAjiLtz3JGQe2ECNNuGdXI30ubFdXdr9AroTLdUpCt/ohffCfJ6Y3OmPeHhugY4Fa7hGMkCcTDHrOcixg5cl7D1R2OpM/3pCkQfjh4MObbQLy4A3JE15SzvvoGME4Tmbq/UPYIIzJ8Vz0dG5d1p8zqHaQS2Z+rV+56gF7SFcP+DCQH4VmzCx83ysHhC35LHVM1L9IwJuXBjCiFHI9FjU4WewM5Rup+8vVNzLO5B17019KvlKg/I5SKGNZJTqBMzcoFEiVHkbWSQjBy+pHPunKBPd/kdRCMvv97y+XTlBnS7KxxeIH6zCpPNdBug+9fdXSLj48rwxeBietOBNyr/xn+IPWq96cacmFN4rBTzWAKIM5UpskzK5YaQHY8zGelZwozwPykXYzoDXATVVuUp7IaI/ouzAvRKN7IY1UIxDIReRk+SXT3l+91P80dYQEs7/jcoTXcBp2MH48Y36jo4XwWwWsOEXD+1VJwx5XPfAfXIr04lG87XHtDbImbpdh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(921020)(3023799007)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1zZw2znhZG5o2OGAMrMJOv0Y/miHfc793QEPAyAr4lBiKQN1A+6GhBJqb0/f?=
 =?us-ascii?Q?UvPDocJ40fY0Fq5Z5OuuiVxqvDwb9XShksS/uu3LoDNehpZEDsEJLXPHjvBY?=
 =?us-ascii?Q?yLTJcxnVhIYfc0ZtnDtTZQK8CsRtFTceWeZfg8DRcABuvvzlfaBdJBUi0va4?=
 =?us-ascii?Q?ijZUp1+vbf2+HqN+T4XwBjEYY9msZkasH/WiVEQ2Too3icmOw+UVbTYAnUCK?=
 =?us-ascii?Q?6BmM/5UDCXfgnphaxigVqj1RYN2i02rucPEeFGr4OYJcmYKuk5VqWcmJANIW?=
 =?us-ascii?Q?sQTa4z8ZExPhDd05535wWzaynrHj8r7iMSG7ZBr49nQJshMxc4aDnkQ+Tq1I?=
 =?us-ascii?Q?PHmPdhB0cF/eO6VxA0ChyBmIp4fRDxyNY0cNZmVqLF8/vrPL7aBil37zZhx/?=
 =?us-ascii?Q?jNN+7xfa7XLkyID0T0jfQxNn2vFRA/TyFYzKWEtW476YeTdW1x0m44Jlxg5k?=
 =?us-ascii?Q?zQqhdXfdwSO0CGhkyWjADfwwSjmdU1TkRBkCrUPIfP7mzRh0hTeih909GHXF?=
 =?us-ascii?Q?ucUerX5BFH2RYVo2o5EUcMPxkWWPQXEohV+knJSl4VpvZlHVueRW3fyaAPo3?=
 =?us-ascii?Q?ZmlANNDC/RbmbEi4WIGVwM+q61Zh4yeFaeX1y0hWDf2RroGnFwOAMVOOnQRe?=
 =?us-ascii?Q?+mh0SjOF7DDX4nC80IHngZ/1rLjyzh/2bYuocD7eWmA2uog2oGdCOyxmu9he?=
 =?us-ascii?Q?zaBYkrTgFM9QNm2tqy03LucDI5Ju/ejz3rRXvtMlR3xFszmWqJgMIpq9dp2i?=
 =?us-ascii?Q?yfKCeUDQZ5RzQGbOkyYodpBAowSchU3j9O53blTEHXDy+T9DrBkpFCMDEelf?=
 =?us-ascii?Q?WpON7A82uQWdbwg0hTTn+sPl4a7HJ94h3Ne34d2VVudIxsmX0O0BW4j5sJKw?=
 =?us-ascii?Q?OXQFY2ee7pMNfcY9PIi27bGTXorNJxf8NYGixZhlPYiFkoLGVhhXypeHC3KS?=
 =?us-ascii?Q?4d5exbNL0KFIhOda6R7v8VKH9yf4Y22KrO4kCRzaAj7/DZdX8sfL50D05uN4?=
 =?us-ascii?Q?FB6+xoTA6pmTfxM/KAfRgJbIcMtiWQcIgSGIJZgTTSXNFqRTKAx+tId9C/1R?=
 =?us-ascii?Q?XS3Tm0ssHHdRFq8o5dL030fLoZ1FMabk5YDZC7d60S6uZWSnlv2i+JjNA37H?=
 =?us-ascii?Q?W53Y4UNAwLqxGW/ImrUbKpaUU7BYz3xf5/qcTUXpY6s6rBHMOk0hGkLmopsM?=
 =?us-ascii?Q?x1s7IdGpGFFrwaBoM/wPwG+59LLaEzE5aPdUA7EuG7qBtG2bm5wI4gl6pk9Q?=
 =?us-ascii?Q?rtiSKej2Ym8KOTn6sslYvr3C2KYGYNjTs3l0BJfuCUd5wrssAOHVc4k0bP6+?=
 =?us-ascii?Q?Irt32+JAXgYYK6XmbN5CcZPEmyKFB5abb11DD5zie1djtLZDBToZcBQg2Jim?=
 =?us-ascii?Q?HQzQKhbLLojLdNzfNyMOAaEE3xofGO68Piko3IdY1PCAhLHsYhO4e8EPMnFo?=
 =?us-ascii?Q?eOyOgtjT0K0oE4o4q+JXMvskGoCGkMdGZy77FpRc4afU9wI52OWCOQ/OxO60?=
 =?us-ascii?Q?mUKbglfGp5XJgz/CYlkqQpy+T9FvLe2INJGPCQD4WUIeyWCsbDPKrXoO4vMR?=
 =?us-ascii?Q?2k6KPvE2wcqPb0qYcQ05xNDx4Wm6Y/MDGfYBoQIedhJjw8Bt6gHHltsyhsbe?=
 =?us-ascii?Q?gCeqfw6rCnIPgURpK7jbRLfE9Giq6/N+qWFo6Gos+rrbMLkbcR6K+E6mFtXu?=
 =?us-ascii?Q?8yMif5VwnFwk4MbCjxj20nX7gicFdX4IzhTeB8IQLBQakPhKRfbEHkmq4lT4?=
 =?us-ascii?Q?YJYshdRmjA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5656a2-64a2-4a46-6b0a-08df1f8f5960
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 07:41:05.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLSgbNJn5p7GpiVLM3JBHTVg9aQHXjX2rLgTR2pKIWCNV99r/eH0AoYQbxL7mj4SBwyxr/0+ciAh/j0LN/bqnEY/rG4d33vLEr8QgF2fabo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15629

Hi Krzysztof Kozlowski,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Sent: 01 October 2026 07:08
> Subject: [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict resets in=
 top-level
>=20
> Properties varying per variant of the device should still have the broade=
st constraints set in the top
> level, so add such for the "resets".
> Since top-level part says "reset-names" cannot accept one item, disallow =
it for the two variants which do
> not use it in practice.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml   | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml
> b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index b9d9dd7a7967..ca92e1a9a051 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -132,7 +132,9 @@ properties:
>    power-domains:
>      maxItems: 1
>=20
> -  resets: true
> +  resets:
> +    minItems: 1
> +    maxItems: 2
>=20
>    reset-names:
>      items:
> @@ -209,7 +211,6 @@ allOf:
>=20
>          resets:
>            minItems: 2
> -          maxItems: 2
>=20
>    - if:
>        properties:
> @@ -231,6 +232,8 @@ allOf:
>          resets:
>            maxItems: 1
>=20
> +        reset-names: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -246,7 +249,6 @@ allOf:
>=20
>          resets:
>            minItems: 2
> -          maxItems: 2
>=20
>    - if:
>        properties:
> --
> 2.53.0
>=20

