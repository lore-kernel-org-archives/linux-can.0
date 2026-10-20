Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792516670;
	b=xBiQMlSRY8vlH6QJN6oXzBpp/ogFMgO/ztnNC7aMdtb91ooH2+lsxn5aVmRD18M+Q7xE
	 mjebWGMSlmY6doXzrJEaCYxIG0k5p/Sn9HA0szr0NseCF8Xzjhv1NrCnps+rE2P4dAfll
	 9/Tngy/PfZ+WbuGTSlKm+t2u6fDq6u4SYVKehFq8ghNJUwUETNsL0j/cqG7nBrVBG0djd
	 f+AcQGgrJTnuVCEtDhRfa7yVBayIaaFmrYfRhyIzBZ4Ox+/mCHt9WVOyOwmgQ5pGVasbD
	 SUkgJY95xFhWr93yTQXwKW6Zro45wDbpk+NwQ8XWdUOUOqZ6MbLrtGO1UvBQZNUr7sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516670;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/VhgduyTXcXNKOPMOwZVzcvhtrDpSe30acwqBs4ZFZA=;
	b=Eh75BhqBJq+ae2dxyok5HkHSlHXrvQYjyWJ8ztMAkp5Wj/wZHAfKcqgOm1vLkuRSocOd
	 fTlA7TxNvN9hMVsLQ/r9A8D6SQgz2jJ4vsYLZpHzGLhV1V5+0NnrWb5YRUk3lJQe4bbQu
	 Ns7/PqsWb77YsStunD/tCFUY7GOnk3nhVS9tUNnEV8E3XdHmEWE9LuRc2uoiWlJzjFgY1
	 nts4Ll1+4xnWYhoYN6R3UADVwM39dxjo/oGA7M32JUZ8/CUhJg7m8rDclXKivwoNEjH8Q
	 F+3n+TPD4plBzUaALgBJHWiT3njpyrYomId6trGb++7wBDMXw6CBvJNfmWyBvZlGa2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GeSW4yH3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.14
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011014.outbound.protection.outlook.com [52.101.125.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C0606AA10;
	Tue, 20 Oct 2026 17:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F15C0606AA10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GeSW4yH3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSYXBClMgn2x5AENgsiw5KBeVBppyB56tljUTU2lxPtQ4qXCbp7CX9nHngeOgai3UlQv3oUz2LmU3/Npm4vDzlpob5afHCLKNiRCsawdrRHLAulEfWC1xO4RM6oiRhYVu+JQMpc3R3bpslvYgOEhNjobEyH0iBaT0G2VFLrWFxBKVWTYhzj7nFixrjRX26HfwNHze4uCT4zEFwVACHnPR1QpOH5Dp4knB2YJha1eOeZXivRWcLweouKZR3SI25kQDVcalmI6y+UQ5G4Azn1tfVXonqI0hfxUIgikEJ9X5XpaNBrTOXUftXXXSPlhDnLi/Acc5gikj+sQF8qdc6Ickw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VhgduyTXcXNKOPMOwZVzcvhtrDpSe30acwqBs4ZFZA=;
 b=OpnfPcamoZc7w+RI2qCbByLujz+Hiyn9WT5vAS4x3KZABiTIaOtjCGVSLLl57huNaojsYp9wD2asEk4YJ55eLtuYds1n6MgSA4s81+AM3GTF0ndTHZmlYRfULbek2x4N6pqids0Xp38LnpeHQ+uCFa1sCWtqwOZzSxKPLSU8ZNBmGQFMZQfYxbV/YHT7Qfbx0lZvsD6Swo34pssbTSThy9zSAIoXSPQt5mGKILRvATKlcUIHwGgNo0LYu8pITwR2JvrsClDqK+57ECtgvJco6P0LMaWgRW31F6SBlM6JfKnlE4qQM1Yd6mBo8xpMgtNVsF72Yjh7EqwZymn6jNm2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VhgduyTXcXNKOPMOwZVzcvhtrDpSe30acwqBs4ZFZA=;
 b=GeSW4yH3CbN0E8Prit2ii31gSNi1owJseig+zPMqbak6GUVewhrtNe3OGpppCX4bNPeBKo8TWmzpT0Ya6o1rvgzHJfxo6PCMMpfi5nP8oT4XTJy1/XwxszvOgz5Bc6lKrv05YIxQRgwyyLLswp+BYNjm/k001s+Mu6NROFc2U4Q=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB14300.jpnprd01.prod.outlook.com (2603:1096:405:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 17:17:45 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Tue, 20 Oct 2026
 17:17:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh@kernel.org>, "biju.das.au" <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v5 1/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S has no Classical CAN mode
Thread-Topic: [PATCH v5 1/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S has no Classical CAN mode
Thread-Index: AQHdX8G4aStep/9cyUCThDKyKA/iO7cGpjQAgAAGNDA=
Date: Tue, 20 Oct 2026 17:17:45 +0000
Message-ID:
 <TY3PR01MB11346F23C5532B7D9F23579A286672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
 <20261019120220.166163-2-biju.das.jz@bp.renesas.com>
 <20261020164840.GA4094037-robh@kernel.org>
In-Reply-To: <20261020164840.GA4094037-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB14300:EE_
x-ms-office365-filtering-correlation-id: ae9286a3-0bf2-4605-b957-08df2ece0e8a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|56012099006|38070700021|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 /Q5ZXEI6G8sXgM4o8Xys38M3/YHXDAyNkF0HXaSBeuYmKpNPHap6I8COWqFYibYHnOwooPV8PvUVhvLCRbUiizCEeC21PQhdCN5yvnFx9P/0v01PAjXaM4TLYBjwalWeaoxpSBX3u/b7DlNAJzK2MlteNztD/BaQ54P7hYKMl9XXajRGmNbDmUye1GqL6KY37PUdkjl9udJY8en3qkcWmhumCpIaq7Qu9vMrwLm3Qhdbd9CJPa9ORhack7j1m/X3t3FJ7z+qMyEl3ljuGBCPkF9TOQZFMn7dHVi9EGDI1KftiTFMRDzEF6XVD1rjjgUCBuoH8927CO0zLZxx2GsmmlwWblwIJ42PT5RDJP360lOT+9E4tWugojw9uVHMhrJ1gItwOLCfT1Hb9H1YI5skfExSEYNPnPyUUW0dwdA8jw5CKpxh9QmRfCz5cRh3Lywb+rzx1un18mCdLZbwiySRlUp2MsgrHhD3MaDDTqi8sFPqLHLXea4UzEPd3uQEzbUJqGrre9Dn7LEjwqg1PWvlJ6a4jJVX2rocF/cZW5RchSRfoSwrrAMJfAFDOj+YHmYqaTMpSDTrZHjkf5bCr7OcI0nGMrlx30AS4Ho94bjlwF1Hmt8NEq9qb2/JjQ0yUTyoiVG1bU/xlsOjhcObe+PT0OYnrCax6r0zTiY44gWLKFcmnD6su9C+J4xr5LXM4I636VinB6sJIdEnb+or85+gi/LDE8f32GSUgrSJhZyoZFs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(38070700021)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cVqgEOvaF6JHWvqGJpac29wh5tJOcKiYlxvdxtfHMETnOqgteJiRdOCpvnoA?=
 =?us-ascii?Q?lrOSlQNUXXxx86sVfYoaK1E+elqdNI5lPnblKthiqfPiApO5B08jNpz0sUr5?=
 =?us-ascii?Q?YoGHtuJ3PzTgtY3/yXCa1uvGpXV4GGwZizKu/u4RitkgXIK0ggLsizRRkDLb?=
 =?us-ascii?Q?/6VOYxzsP26K0iaMxR4nbZ3tXaGTcz5xrRK5Fqk53VhXIFOZHqf0HsSmbN9v?=
 =?us-ascii?Q?eor+pE1yaL1wITustXSGWyo/lTHbmdEYrukWwL5DJPAciSHC77w/0UA5i8xF?=
 =?us-ascii?Q?y3gbDNSEjyo4wzL3n9znzmpcPeS/H+uaLenbfrurzeSaSoyzGueffcVpkFRT?=
 =?us-ascii?Q?8zfLqFZbeqKE5zrYXPhzR6P9bt1YaWPvoWO18sgKctDHhNVea9FuB4QE1Fy4?=
 =?us-ascii?Q?n1a8LJzqSfwN50wadMsURNaUHy9H5AjUfTE80b4V+8+P3HE0GALVNUXcaSs/?=
 =?us-ascii?Q?ao8jR9uphKipxMgwlPbNv8DGGlASGDUwJFJAFJuwky8N3xowYgCRn1q2p8q2?=
 =?us-ascii?Q?7Ia6FCSffAzYvl+lo6jWzMrwP4OCB6W+vCWT2u+1AHcDgtiUWSgIynr4QZ3T?=
 =?us-ascii?Q?FDSKKOTRy984I5RAlikxq1mZxeryad5rvgYPGPq65bTXNS3J4U+JAehbrAtx?=
 =?us-ascii?Q?szmyYS11K16YT3l/VAnTGAvuP/FkRVf8z3x1kf8GRWluSozBboz3NS0IZJZM?=
 =?us-ascii?Q?euEcYNM0l724BS2pCIz3OdouvW+cpqaxEco3wGjgrq3ZKmEBqixZ22KrQcaD?=
 =?us-ascii?Q?MOh2WMF8kjCBPhPKaVqM35+6XcfBWkC5w+Jb/gy8yjgZE2XSNzxQlLbcX6Vt?=
 =?us-ascii?Q?pXqPlDUhF5JFv2UWxqRBOqCd6T9khrWwsEumKdX/xcqe2KrQCQVAIJDmY0YI?=
 =?us-ascii?Q?eV59l4lTaCiki0ZJFR9jjr5rEtUiiqJRbFSqPFte6Fu09CcA17hMFwETH5K+?=
 =?us-ascii?Q?6neaXHjg6Fdxe56asEKMxubvTG8x9XkSyWKEQHgWRZp7pvfigrlSdjgVDO1I?=
 =?us-ascii?Q?HFqygS/QXPmSWHM70uskinF9WeUMFHtSjAiNXOeThxpPzWfv7aeU6qBn/snS?=
 =?us-ascii?Q?646IXYspx4Sd5GJTXnPu6PAlxPvPGATriRVqFAvUED+qHwCOeUdG1l8pTFXh?=
 =?us-ascii?Q?Tt8adfI1ZboCBOr8WVwai8Xa2c5dh1KTo/+CzDSGslSeyZLWfmDjSRALGaBC?=
 =?us-ascii?Q?NUM3vZ3/XsINxWIGCxe/ozl4eAYKJoGCkdJdOBBLy2xU6FkiWXH5Xmy5yKjl?=
 =?us-ascii?Q?SBccmAhCQzCT7GZkVqeSebx+KhiH9hE1cy9hkNEgf46MDUprajU2e96jQd+x?=
 =?us-ascii?Q?/alsUA9x7zM0/mlF7KMjvAFo1tSLrOyrM7W4bg+nt1X0P+6vK+14rcZtNH7Y?=
 =?us-ascii?Q?C6CvSUXIkiXn+yGk6TAyJ6n3mYDQBEvm3DYqaoGOIlighA/AA2DlS9AXOpI4?=
 =?us-ascii?Q?VICxVS5eiuai7ZXanZwWRyU9W5LOi5WcrJAbHo3ZrSpw90w78Jlry/dyhrFL?=
 =?us-ascii?Q?hlORrDn7SACRlwa2cVVVqVQuZN8VCa4YxU9F1uX1Ny4TbNneIOYQjT9oG0LT?=
 =?us-ascii?Q?JoF40BR+L0xy5WSrD8UQSLh0ir/3YcAWqsRKEqiiROO+v6IFkw61kuA0ulMX?=
 =?us-ascii?Q?SdRIHoOCEbF/Y0/KEKto3LJSbQyd0rtsZewTzxcEUrjVCBbKGvdG/4eBQNma?=
 =?us-ascii?Q?iqcDCrm3wQgLKlF5GPt6rPmh3p6H1KcJKZw5zcqbiazhrTP8llM2vIV+AU5d?=
 =?us-ascii?Q?5RDKJfMTCQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9286a3-0bf2-4605-b957-08df2ece0e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 17:17:45.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSclax+wWj0TDBAxicZitwtB1rKh+c48IB6SR+H06eIFu/H9Wm/1zv/Za1WI+Gzy0rKGRf1O0JXYFuf0CNcD71YeMHQwrMwVsCL6JIU3sNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14300

Hi Rob,

Thanks for the feedback.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 20 October 2026 17:49
> Subject: Re: [PATCH v5 1/4] dt-bindings: can: renesas,rcar-canfd: Documen=
t RZ/G3S has no Classical CAN
> mode
>=20
> On Mon, Oct 19, 2026 at 01:02:13PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > The description of the property that selects Classical CAN mode
> > implies that every supported SoC can operate in that mode. This is not
> > true for RZ/G3S, whose CAN-FD controller supports only CAN-FD mode.
> >
> > Update the description to say that Classical CAN mode is not available
> > on RZ/G3S, so the property is not mistakenly used for that SoC.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v5:
> >  * New patch.
> > ---
> >  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml       | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > index 1a7a9ce45e97..7d3330f8fc1a 100644
> > ---
> > a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yam
> > +++ l
> > @@ -146,8 +146,8 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:
> >        The controller can operate in either CAN-FD mode (default) or FD=
-Only
> > -      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specif=
y this
> > -      property to put the controller in Classical CAN mode.
> > +      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode(except =
RZ/G3S}.
> > +      Specify this property to put the controller in Classical CAN mod=
e.
>=20
> Can't this be expressed as a schema?

OK.  I'll express this in the schema with an if/then that disallows renesas=
,no-can-fd for renesas,r9a08g045-canfd, and Will update the description as =
"Specify this property to put the controller in Classical CAN mode"
and will remove the unwanted description "The controller can operate in eit=
her CAN-FD mode (default) or FD-Only mode (RZ/{G2L,G3E} and R-Car Gen4) or =
Classical CAN mode."

  - if:
      properties:
        compatible:
          contains:
            const: renesas,r9a08g045-canfd
    then:
      properties:
        renesas,no-can-fd: false

Cheers,
Biju

