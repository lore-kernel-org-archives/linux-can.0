Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485045;
	b=LgDyD9onJeGT7hk5xDKTaYsw1pmQ/y4cKZ1cATTnJCeArv3LeNhoCenkT9obic7EFM+A
	 JKugtNnWoHMo/mttS1kptgUEJcJtvY/3cFG4JWp9P4OwY/hYvKx/IclxMcDXDDRd15lpk
	 SG1zdD4XOXDTWi9q4dUQ49omD1drG3bGZFwOBSh+6P92DK6mnINZt+6o2IY4P1z7KwgiJ
	 a79PsK3K7IxUO/DBum2uPvsWWu/+W8I0VVN+zdRgvTGu+J3phvy2gV9TGrytFHvG/aeKL
	 lb86dGjbPyA/aq4x2XWpuvouS4CnT2F9VcXSgq3Q+7zi2ybyly/8CvfSmtzI9D8nVQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485045;
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
	bh=r2RbBGW5VhjWCTmRrhNx7wPkrO+sdHBGgw+rnHeG+ac=;
	b=cB6TZ3mbQCpvAvzY2wbZHMSMEBejTuYqOqjoqQz1bN0EDwEA0vpWbdlVce7aId4EkUEa
	 B42jfmj6PZP3urV61TvK+yLoWT8c39MPUF5RI6dEC6jGtxV20FAWY3FHkdvV1utLCWI6L
	 9PK9c2SrxgB88DYxkGAFBTcNHOvb6mZV3nRbvzMp38fgQwP+qEQ8cv/fIYWAqnoNEFrwb
	 CRfR1CrokO515Hvuk6m+Au4fcKG4lSPSbmpIn61HtWET5vymNmOb1mmTa/BRBzVQgpXoq
	 JmTBrN26nqh2ZJ0xlViIwB0jK66S7PMzmDUkB+/Nw+zKDG2cCG3TmJjw2Fy9tBgLMZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=DGOc5W8j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.27
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010027.outbound.protection.outlook.com [52.101.229.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3EB606A319;
	Tue, 20 Oct 2026 08:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3EB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=DGOc5W8j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNHGwppxTfzVfvmVz+DCdO0NaVeASwv0axSLehKyB3znb3lIXnaPMfchzFHCJRj23PTJ4P/exxitbWIUfXCSFr7SQ6I5PnUWNwmTfbJEgRNbXt6VoS5Rv0Nfz6trB17+4+j1XzdwWjSDjbo5ksDJPhpEtuiFQxgfI2rZe3swR/7pD84FxMdqWfSwfNpKgeLlNEk9Rwii5rD9tgrYBFISEM0Jeo6KShspzSlJfyR2bFGUjKawtSM2rDldPfv+6cAx4mzfFvKyJf1fPGzPFpLvzZMAazz8gB81YBn9eDJleYPm4gBNxa7+Q+Pw4RyyHEQU7lrbk+q3LsH/YqykAOVSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2RbBGW5VhjWCTmRrhNx7wPkrO+sdHBGgw+rnHeG+ac=;
 b=vt15TdF/36d2gDyYwqofANictZmvxEJxAfWaCeP+g2eLYnAqj/QpVzI0WKWYNp0BfW3fmQuKmiW4UAP4bs+JhrBRhjcZ/fZZBjOfGjFAp4qolELS5MZ6fxNfjk3UM7WlZjkGbqteWBJaE4hkcRIDZnYhrXbUk6oTRnPGI9eWWXrPlyyObpSiE5rbAErcUc4mHBA2/xy2TovPLQpJgX/1oxMS+EYsvRdTC7rwn4wIL3g4ZB44rBuJW0TcaEzFOIENLfQUh1vEjxQWUvcGdKqTuEzlR/4DVUiXInMzV8NsfDtPoODR6Cpt8oVM7z5wAd5eiI61YGKma0GHp3GToF5k7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2RbBGW5VhjWCTmRrhNx7wPkrO+sdHBGgw+rnHeG+ac=;
 b=DGOc5W8jMnESdrUSg1gfN/3OjPMKS+oe47GOXnZY6pp4PCrGAhk+l2mLsTEpWvKWWklHBLUc6LbfSh00OAayUBgkhCRyhXbld2sBW4pNWQJja4lQLRUXzB3mWuvjkFp9EHPHUKDaEp/1Bxnv7Gyf6O4aZgzRku9aOZGpCGlWpvA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB8328.jpnprd01.prod.outlook.com (2603:1096:400:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 08:30:40 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Tue, 20 Oct 2026
 08:30:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: "biju.das.au" <biju.das.au@gmail.com>, Vincent Mailhol
	<mailhol@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v5 0/4] Add support for Renesas RZ/G3L CANFD
Thread-Topic: [PATCH v5 0/4] Add support for Renesas RZ/G3L CANFD
Thread-Index: AQHdX8G33+JWXuwTZkSn31raahBWCLcGFjCAgAACNYCAAAHkgA==
Date: Tue, 20 Oct 2026 08:30:39 +0000
Message-ID:
 <TY3PR01MB1134698B07654C48820BCD41986672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
 <20261020-auburn-kangaroo-of-diversity-dbd8e6@quoll>
 <20261020-bold-wealthy-wyvern-891012-mkl@pengutronix.de>
In-Reply-To: <20261020-bold-wealthy-wyvern-891012-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB8328:EE_
x-ms-office365-filtering-correlation-id: 2d8e5246-7bd0-4e39-6b51-08df2e846c79
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|22082099003|38070700021|11063799006|4143699003|10067099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 wNiF/kkZ4z2KPWwXJnBLWw3vK0nRFbW/HjVVr2nWQZ08WDbDq7WZGW41Q1AaPqadxDyP3UeeySNqfshiegYYvS2TIO3ElEwkL0PxNskmFkGjUUlozGhhl7psx5f9fccWC5pm08lkPdQTTjf/fXkJzUo20umMZ6rlDW2TO2kcVYOP2WUmm1BC7btAJWEOMLdrzW+Dz42kKwzTqIKTbjb2RrwGt1/PC98HLhgXukGsS7M+MEUdcAKRI7WESHxhnChm42LjBb1dxRx6Wt+FqQfElt1n5bVRfI0vhZRX4fGIXOj/99nIhAfrHMmG+NOTRT5vhdcdWI7vX3zBHQ6t6C6xDSS3Iazzd0yIc/Rhu3t84la33J9/cLwDj3dRHbEfzDY1SdScZaUBNsw6dwYpw6gbi5LVsUZrgS8upDeTa4K9lOpzpUR0UDMamlENVbhoLXk2HqvQRIv+5nDZn0RhNUxwsW0DioGGv9g2Ff9rFC4z+h2LYMkZIdVs0TCmXp3N3St55N/rvHJ2+1wgvL+dC1ohVy3Z22ZcgmcCU6FBXyFuDmEcP042Nd7dkb+48mkSvrSc0RcPwmJKkAD/w5BausWNC6IINy5bfj5yAzW2nb2Zj+9VM/OEegGLV8VVBlUJMBl/2Ealw68WssZMHCmrvAOMHZIH9oqWCjVx8JWzLq3oPmU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEt0TjJmYVlwZlZCOHpvdFVNZ1p0T09uSUl4dXI3TVNFVStkYmhNVWY5Z2Rs?=
 =?utf-8?B?MTRwRzFjR0ZKaXFzOUpsN3ZUQ1NndGViS2d5bkwyTEd3dXp2V0FtdHFZeTBE?=
 =?utf-8?B?eDZhUmMzakdIQWJNUm1HKzNjdmwzdmlGTTdsUGhsT3lSU093RTNoMjc4RzNk?=
 =?utf-8?B?MHFUMW9Jdlk4V2o1bm9OZUUvdjhuTnRnRXlxc3NLVS9YVHRHKzF0alZjM0ZK?=
 =?utf-8?B?YjUybmVmT1J5VmFsdlFYWjhJYjJmYWRTMnU4NjhvcGR6dHY1M0pNOEFuR2x5?=
 =?utf-8?B?UFhtUWxkZVNkSElrYkVISkRLMGpET3VVU0FoaDN4Y09oanBzVVdpSDlPSFg0?=
 =?utf-8?B?RWFGT0EyRXVDNjFWSmVNSGE4enJwMXVIaFVYbDVvelN1UzhUUEdhNW1mbHkz?=
 =?utf-8?B?bTRsdk9xeWhhRUtQejJUN09GZFBGTVhxNGl4MmNVU0haeDJEeVBiQ29tc1hz?=
 =?utf-8?B?bDVaZHBHOExncHhaR3FJU3dtazJYdUdwSVA5S1RROHNjUG1scXZCWUM4Rkkz?=
 =?utf-8?B?a3RESHFHWFE2amFlNXgxN2hxTERKK1E2OFVMSzNWQ0tMdTUyUWVLU3ZPWk5u?=
 =?utf-8?B?LzdCdWx0ZzQwMGZpNnRvOG1SaExua0pmRjZWMXh3ckN1djN5ZEtxMDRhUXVz?=
 =?utf-8?B?blBNU3lzcmxtWDB2Y3dxUFJ4dzduVW5sN00zS29rS2M0RGdWRVlxV1hKZHA3?=
 =?utf-8?B?Q0NQOUdBcVdCMXBZOTdmNzZiY1pVdXZsRkZkRndKKzZQbHJmdXplZFVNeS8w?=
 =?utf-8?B?OURJZmtaL2w0N0QwMVpWSWRGM0UwYkJLZFg0VGxBU3JXcFR4R2V6dEhtL1Ji?=
 =?utf-8?B?Slc4MUdydTVLUElZNS9VOEZQalliR1Y1VTdwdmZzamJrVzB5M1RrcENpYlFl?=
 =?utf-8?B?VUVVSVNhczd3TGRsV01PVllYdG5LYlVXRmlKLzJuS0k2bWM4eHFzcTRndnZI?=
 =?utf-8?B?cFZrZi9xVXdHUU1tVWRCYnJqbG9UenJyS3ZDSVBNMlVtckRYbDBndTRWekU1?=
 =?utf-8?B?MzUyb2hyWnJvbVhpejE0bEg5VE5aTGhwblNLSVBoc1BINk1oY251VjQ1dks4?=
 =?utf-8?B?M1dQNUMrekhFM3dDZHNXU2pza3NjU3BySkxkOTBIYXlVQjZYR01ZQjBQT3Iv?=
 =?utf-8?B?eVZXcC9aS0gzaVVERmpPK0tLTjc0eUYyNktvMkVtNnNaNGR4RDNsTkczNXdR?=
 =?utf-8?B?SWtpaW4vNlBKSThZUFQ2RkhBOVFtdzNKZXFzK21zNUdXeEkrOXltTitlT1dM?=
 =?utf-8?B?TnVTNGE3dU51OHFuV2dJR2NscUJTcDV6Rks4aHJ2WkdidFRpOFBmQUhCenVU?=
 =?utf-8?B?aTJvdDBNd0N5MHE1NTZOMWJvVitGOGFQb2hrbnF4Z0d4SFUxUVViNk9uTUd1?=
 =?utf-8?B?eU9XL0RXK01TN0greTBod2VrZjBnTzhVZnlKeWVpYmxLR2szbUhuUXpXOGxr?=
 =?utf-8?B?d2xaUE9WUWRwNk5LOW1kVFp1YlIxTUR1TzdFNXNIUC9wdXRQTjYyVXdCTG1T?=
 =?utf-8?B?NERWd2FRZmdWZ3lwald6aU93a3NEY1h2L0xCdzZtVDJpZE5EZE0zOFlURm1y?=
 =?utf-8?B?WW9tc2ZsMVhQSThrSE1nUUdpRmVNSnZXNHhNaUw5dHZtQ1crNEk5RHZHWFA4?=
 =?utf-8?B?UmdPM1JxR0xyTFJvQi9sQVp5OFhFWHZIb29TMm1zamExbkpFa0NJWm53NmNn?=
 =?utf-8?B?cmIrS3ZYd3BGRlZLc1dpWGNMdTRPcjNqMGJpNDM5SzZCQ2dvdjU0amc4dHd6?=
 =?utf-8?B?T1pmdkl0MWpGclBXWmgzaUtRc29yUTBFNWN4ZS9lYjYwZmJJQTBtV3QwWHFs?=
 =?utf-8?B?SXBlTmRtZ2NlSU8xOEUxcFBiNGJ5RkxCYzVrT0dpS2xQVTdGQkp3NFIxOG9t?=
 =?utf-8?B?TUsvRGRwR0MxMzFCbitWU0x0WGd4K0lhQ2ppWWhza3NMVHZiNmU0SFI4QWtW?=
 =?utf-8?B?bkdwUTRwRHp2dlovWnhLWXkwaEoySmlNYjhYQW1NbUNuTWdxV3NWWU1LcXND?=
 =?utf-8?B?VXdxTGNucjNVaEdDRlVhTXJmdnFHYWY4WXdTMzlGQnQ2QW5qNXY5bHNqZ1NS?=
 =?utf-8?B?bWdQeWJqY21ySWQ4dExYMWZsVmx1a1FUcDVoYlJNdlFwd1BOU0RLdVZXWWVG?=
 =?utf-8?B?REhRQmZQRTRjRStIRllod1lTODJDY2xhTXBCYjM3WnZDQ3ptbHJ1NWE2NTZH?=
 =?utf-8?B?ekZzU3FWNDFxaWlWbGJVRitRbHdrTnhIVXBzZUs4MGNQWEhvanJITkpkaklM?=
 =?utf-8?B?dGt5cVFpMVdBbjNtQmlxZXdOSkFhejBENGRHU1ZWNTZKZm9PVTZWT2pxeTdQ?=
 =?utf-8?B?dS92S20wTzJQd2hNOHFUd0xSVkt3VTZqMWV1LzA2czhzTUllRWhLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e5246-7bd0-4e39-6b51-08df2e846c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 08:30:39.9923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pZSdE4e8Kd+QYshC+eMmh4m8sWrUW5qzOk1fTJ+nIrLfwcbY9zx+2AgzBC/+MsnPbCRrGvaweTm9zGVxO/8fcB6mwIr0szMeMbgP7pOQ2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8328

SGkgTWFyYy9Lcnp5c3p0b2YsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAgT2N0
b2JlciAyMDI2IDA5OjIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMC80XSBBZGQgc3VwcG9y
dCBmb3IgUmVuZXNhcyBSWi9HM0wgQ0FORkQNCj4gDQo+IE9uIDIwLjEwLjIwMjYgMTA6MTM6MTMs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gTW9uLCBPY3QgMTksIDIwMjYgYXQg
MDE6MDI6MTJQTSArMDEwMCwgQmlqdSB3cm90ZToNCj4gPiA+IEZyb206IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+DQo+ID4gPiBBZGQgc3VwcG9ydCBmb3IgUmVu
ZXNhcyBSWi9HM0wgQ0FORkQuDQo+ID4gPiBUaGUgUlovRzNMIENBTkZEIElQIGhhcyAzIGNoYW5u
ZWxzIGFuZCAxMSBpbnRlcnJ1cHRzIGNvbXBhcmVkIHRvIDINCj4gPiA+IGNoYW5uZWxzIGFuZCA4
IGludGVycnVwdHMgdGhhdCBvZiBSWi9HM1MuIFJaL0czTCBoYXMgMjg4IGJ1ZmZlcnMNCj4gPiA+
IGNvbXBhcmVkIHRvIDE5MiBidWZmZXJzIG9uIFJaL0czUyBTb0MuDQo+ID4gPg0KPiA+ID4gVGhp
cyBwYXRjaCBzZXJpZXMgZGVwZW5kIHVwb24gWzFdDQo+ID4gPiBbMV0NCj4gPiA+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21rbC9saW51eC1jYW4tbmV4
dC5nDQo+ID4gPiBpdC9jb21taXQvP2lkPTJiNGE1MDU1ZDUxN2IxMWJmNGE1NjcxY2VmMzJlNGQ3
N2JjNDU2MjYNCj4gPiA+DQo+ID4gPiB2NC0+djU6DQo+ID4NCj4gPiBiNCBkaWZmICcyMDI2MTAx
OTEyMDIyMC4xNjYxNjMtMS1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbScNCj4gPiBMb29raW5n
IHVwIDIwMjYxMDE5MTIwMjIwLjE2NjE2My0xLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tDQo+
ID4gQ2hlY2tpbmcgZm9yIG9sZGVyIHJldmlzaW9ucw0KPiA+IEdyYWJiaW5nIHNlYXJjaCByZXN1
bHRzIGZyb20gbG9yZS5rZXJuZWwub3JnDQo+ID4gLS0tDQo+ID4gQW5hbHl6aW5nIDUgbWVzc2Fn
ZXMgaW4gdGhlIHRocmVhZA0KPiA+IENvdWxkIG5vdCBmaW5kIGxvd2VyIHNlcmllcyB0byBjb21w
YXJlIGFnYWluc3QuDQo+ID4NCj4gPiBJIGRvIG5vdCBnZXQgd2h5IHlvdSBrZWVwIG1ha2luZyB0
aGluZ3MgZGlmZmljdWx0IGZvciByZXZpZXcsIGJ1dCBpdCdzDQo+ID4geW91ciByaWdodC4gSSds
bCBza2lwIHRoZSBwYXRjaCBmb3Igc29tZSB0aW1lLg0KPiANCj4gSWYgeW91IHVzZSBiNCBbMV0g
Zm9yIHNlbmRpbmcgcGF0Y2hlcywgeW91IG1ha2UgdGhpbmdzIGEgbG90IGVhc2llciBmb3IgdGhl
IHJldmlld2VycyAoYW5kIHlvdXJzZWxmKS4NCg0KVGhhbmtzIGZvciB0aGUgcG9pbnRlci4gU28g
ZmFyLCBJIHVzZSAiZ2l0IHNlbmQtZW1haWwgLS1hbm5vdGF0ZSAqLnBhdGNoIiB0byBzZW5kIHRo
ZSBwYXRjaGVzLiBJIG5lZWQgdG8gZXhwbG9yZQ0KaG93IHRvIHNlbmQgdGhlIHBhdGNoZXMgdXNp
bmcgYjQuDQoNCkNoZWVycywNCkJpanUgIA0KDQo+IA0KPiBbMV0gaHR0cHM6Ly9iNC5kb2NzLmtl
cm5lbC5vcmcvZW4vbGF0ZXN0Lw0K
