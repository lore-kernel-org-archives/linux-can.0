Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010028.outbound.protection.outlook.com [52.101.229.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6953C4B91;
	Sat, 17 Oct 2026 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225390; cv=fail; b=skMa26lC+1Ho7DCkgKSVi/mbxH5GF0E90kx4Pp5f6ueMT2K4vs5dSkcW/MREGQ4Yz87HQ3hKRRsGQu4nNOna4Y9xmWWnxijphj2IQlbfmgoXazGr1BYGYXt4xvuqraXH0Q7MTX5asQ6UzNZ4N+VORuMD1atHOByW7/EjBAtr5Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225390; c=relaxed/simple;
	bh=rh2qvi8SFHOaT1JpDE0HDX44Uegw8G+B5eAaj+Vgg+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rzkaaBABLevYJRT0y2OLryAXdaNDqEt+NiLqiIxyiLhbdpbqJJrdaiA7DBOUuKsX+/cWNgOD+MP0DwX5biSyjhZbRLEbUXgf88Lh5/lBpE6wPtkI+R9HX/uUlpNKS1x9TF9pqhnJurHHUKh/Q8SUkErG6VC1ZRlm6b5JMV9wAI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=gxMrQ+FY; arc=fail smtp.client-ip=52.101.229.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="gxMrQ+FY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wludo6SwXReKqxZkdlNKobFpropFijycx2tOwPh7n20QnoucCKZyFtX4RxmMKOMFRBBJnV+OvpszniSK/ofG3A5NSQR83baoQVwqmKh+Xh29nf+jW8vKJFTVU+WdkNwUt6EasWmkBc9m5eqTeZz+you+DsHuv0ukigoeF2zSxPSgzCEH2BRur6eHWMSw22xlM3Thcg2axC09weTuRFMfboYoD95JZhBW0mH6N4dUpm35ID1nfxxDowj114NnwxzDZr7bPRsItUeadggVlE7VZkYzYJREd1O953ejTtZlYlIAxmFCJWPirg7lOzCdLHVyP1Dk2KSlDYCcX/oHTUDboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh2qvi8SFHOaT1JpDE0HDX44Uegw8G+B5eAaj+Vgg+Q=;
 b=Ppayt0+2tUy+SJvzAHhkBvTqnxGBUnd7vhNyu3uWrABhFJEC6SiTMtjz75TyA/HKG1JVtgqThedOBk6WamPB3YG+env4GTv/e9XE6OxbuTJOYdFbEb0fXl1HhWJytuiDJKBQv9b/Ya+mWR0tHfMVKnzyax3JVsmW8k9SA+iUTHSr8ohUA6HcxXDseFcrh9LrISZSiH9MXkjVBVqOYNifnk536naw1ywaMcp/SH2WmHsTcVfHx1TYq44HIweJe5jBMKi8VsI13XULvHq9P7wffvMXHEfwEHwb2DGYGuQo6aob7rhwJPKA9uWJpuoJcDirAg0ju3o3YJm6l55YoggvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh2qvi8SFHOaT1JpDE0HDX44Uegw8G+B5eAaj+Vgg+Q=;
 b=gxMrQ+FYbSJD4IdAgih2/3Q5nVJTn+z+JUUmfGCjdgcjEp21JHpcvSWoozPXO1AV+S9P0mLBFFbQ/+JW+eVMS4HR8H8qN49A4N+MgzDNN8IqBDwyOrrsn7G5LUMTeK+mGsmlpkGx8s4LDRc17AM47kwB08wnOFebaRt4EJEFWSo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB10125.jpnprd01.prod.outlook.com (2603:1096:400:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 08:23:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Sat, 17 Oct 2026
 08:23:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Thread-Topic: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Thread-Index: AQHdUXqWGJYcQwxreka0VFtI2IFYOLcAS3kAgAABusCAAS3QgIAAAZIA
Date: Sat, 17 Oct 2026 08:23:03 +0000
Message-ID:
 <TY3PR01MB11346ACB35A041309BCFA744F869A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-2-biju.das.jz@bp.renesas.com>
 <20261016-rebel-ostrich-from-vega-f759c8-mkl@pengutronix.de>
 <TY3PR01MB113465234171180FFB5F1B6FD869B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <c624d8d5-3362-458a-96db-0457b25cad53@oss.qualcomm.com>
In-Reply-To: <c624d8d5-3362-458a-96db-0457b25cad53@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB10125:EE_
x-ms-office365-filtering-correlation-id: a9859956-a48e-477f-5c35-08df2c27dd63
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 /1NNCl8B8ZkVslipJ2sqTymSvY7ve2oNM+4U+JbvzYgx+bDpAC0GA2GC/QdnzlTu1dm9zKEhqXhUJBgBybIfHfBetxWHPlXdCSvDsSk5Xa+DOZK2w8iQTp+ZMnvCvZphLuiCK2ubEfD7ZZbWjLNS6fzxFPaT1uVhm4GyOJuitbTK/BYHdOCGPZnj/FrADyghkspwhwTs65vO0YBk/OA/p0G9/GRsFZ1Dq3+lzVZB/Kv+q9adOSLcu6PTcAdBHwt2bm8n0WNFqnpYW/4FkgrOfnGts7DXOvdvVH5X8Qw/Q/LdYsXEVrdpYQ+qwXtiVmkT2RqbeI4dBo7mEqPf9XE9tqXboBdG4tFZJLDFhD75fJhG4U+sEImX+cKmBqQpEyJIz4YkTzWJmE38Rsr+V8PZ3Gvxm+GVz252/XS9GOpNJn8U8KCYMtxMmR/sfm1E4tGIwz2U5giJBEfdzQRPai3KIQsCbl12sCZrfGS5v1BjmO/X9wAT1o1IadB030VZWWP3MQkBeqsu8LOsvVPJy+oDb5hpaw8CFwWz/cWZf93UOfSqOPgRh4VPsC6lnKZKoZWwEeSoPn5w5ckL30tarvZfcmdEBAlU/PKiktuNYSXTKZ+BptNOWRKaNf9nBsr/PsNN1WTjH4jDGmODQn0saA9iyZ9xrmx9H/vts+jkpXgrOY1TpzH5lh+SsPWpCA1sNWwSrkAhc3QWLmzSkUsgPWH9vJWtWGWQtDgwCNSuzhLvYhA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1I1MC9vdkwzd0dNZW44UW1kSys2OE5vQlJHbHA3L1JENkJwTVg4RnFtbDR0?=
 =?utf-8?B?OHRSemE0a1BYUFRnd2RCTEtqMG1oKzJEei9VSW05bUVGeVM0SUZkNk9RZ0d0?=
 =?utf-8?B?ZndYb2pUSWtPN1cxM1U2M1ZnVkc0Mkc4U2ROZnVSTUlvdnFGSFJCcXV2UEd5?=
 =?utf-8?B?WEZOcCtpQUZyQ1hJOTB4Z2xRbDBhQU9vMm4yb0hSeUwyRm1PQlgzaW5lK1gz?=
 =?utf-8?B?aDBqbm5GSFAwcVFwNzFtdTdEOWl6emd5RE9BRWdMSk9OWGRUbkV4b0ZGV01D?=
 =?utf-8?B?ME5jV3JtdGdGZUFiL0xmdGdLNXRHRXd2di9QejVKT05KUUhWT0U4WmM0Tk5y?=
 =?utf-8?B?S29nS0hmNlE5UkNuQ1RNR2k2dWVWWGpzclFQRGxaREFlcysxWUhEaDBVOFRp?=
 =?utf-8?B?VnNhUHlIWDc1cUdTNzV5c1BOeVFHek9IMy9oRm9hblNzcGtWMUdrSDdCZVNw?=
 =?utf-8?B?NXduSkpYMGJUOWk0RkRlbmtzVmJsc1A1YlBPd0wzZVlaMG0wdzlxV2NqQnhE?=
 =?utf-8?B?NGNVOWhEVFF6bWlBbjl6ZmRwR0F2WjAvdGtzS2QxQmNkc3ZycXlkSWdxNFQ5?=
 =?utf-8?B?RWJicFNDYkhycXZDVUVLS1YwcWM2SWxSVE5sZ0FYdDJQQkZ0R0N5WFNNYzQ5?=
 =?utf-8?B?MDNCdGlWNk5rVnR1S2pPeENJa1g2TnhlOFdHbkdkT0VHdExFRUQvbll5VlQ0?=
 =?utf-8?B?MFVxVW96NmNHMWpTdHhFMGF2UXFYRVBKeGFoUzY2SHAzVTVZNXovdmw1Q0l6?=
 =?utf-8?B?aTF6Rk5rTDB6WUpJcDZIQmZYbDVGdUx6RTJOTUdEZVgwU1padEYxUzFvNFBE?=
 =?utf-8?B?YnpqdFJtZE9aaElyUkswS2szL0JwSmN1cE40UWRscmcyMVh2R3NQbTdFSElQ?=
 =?utf-8?B?Vi9DbnUzeFpWZ2JBV2N3NnM4ZEVhZk9KZ1ZVSUdna1NrQ1M2bWN3WE5IKzl1?=
 =?utf-8?B?OHdTL0xRYmg3cUpvei9SQjBlS2kzQ2pGN0Z0a3JJUzhTcTYvYXhpOENaUlVQ?=
 =?utf-8?B?ZnE2dUlDalJvZjVHWFBzUnRKY3p1RHpMZk92dkxudllsdUd1ZUllYks5UHE2?=
 =?utf-8?B?Umg4dWM2TUQxV3l0S0psQXZGZlg5TkZqdDJhRlJWeFBRZlRoT1FraDRxK3ZO?=
 =?utf-8?B?RjhDcVkwbXltOVgzOVN2NlJORzVJS1Z5VVFLYm9UR0w4YzFQdWJ0QnVYZE1u?=
 =?utf-8?B?UmxlandIU2tMTTZwTDQybTZxSnkrVDMra293ZjhDRm1abkhNSU9DdnFJbTU5?=
 =?utf-8?B?ZFZoaXdza1p6ZkxqNlJRaXB4aExlSkNVWmZURytpYlFUZjNEeGZnNU8rUnhS?=
 =?utf-8?B?TlliR0grbkhRdlkwKzdSMm5jSVZqWnRCZGk3cUcxREs3dTlVSUtLU2N1NXRr?=
 =?utf-8?B?bmtZdWd6VWY0ajAwNGhqTHJ4Mk9obDBFdFBNUVcyZXVmNndhbk93eUc1N1Rw?=
 =?utf-8?B?bUU1RVhlNnlleHNobW8zK0dzTnZ4Umc3QjIxZnMwYTRjV1FIRFFDbm1kRGhL?=
 =?utf-8?B?aG1YOHl3L1JtT1gvbHV3ZE1wUUk2YUlOUjlqaU55dXdUdnd2UTA3SzBNazJ5?=
 =?utf-8?B?eWVLckl0WVR2U3RtRkpZZFZEWFgrbGsvYWQ2NEFvdStwaDl1aUhrV0cyZGhC?=
 =?utf-8?B?QnhCcGVvWXduc0V5YUZzOEE4WVBUMnZZdDkzZVZDN1NHWWZaT2VtZk44YklJ?=
 =?utf-8?B?T1FhZmYrTjJWL0dqNmtCRXhSL3p1Rk52dlJLNXNwL2ZXKzJVdEpmZGM5eFRC?=
 =?utf-8?B?SmhpaTljODhlUmQxSlYxZTFkUHRXTTBFY1QwS1R5U2ZRSFN4RW9wdEo3MEti?=
 =?utf-8?B?a0hxQllXZDYzTU11MnExN3FsWEh3NmNCeTMzcE9aajV3ZGZUT2hXTkloNCtV?=
 =?utf-8?B?bXZKMHB4SWw4RU42Z3FRblpRUDl3bm1rdUhsQXVBandBSTRQS0dIT0RSRTFN?=
 =?utf-8?B?a3ZROHlEWWpydzB5WFVkWTNBZ1FmbzhRcCtLYWdXZ29GWnh6RkVpck13YXpL?=
 =?utf-8?B?d0pMTm40NEl6eHBZMWpjcnVzUm9kTFd6cnNPQkhrUXNxTDR6YTUrb1dvZUkr?=
 =?utf-8?B?SUR3d2ljNWdSYkpvSzBuTU1TVWk5eHlxcTZOd1FBejdpTUtLdWpFOFFZbldO?=
 =?utf-8?B?WHBwNi9lbHA3ajJGUExSSk9FZDBDRDM3bHoyT2FuVmZVU1h4MFkrQWtpNHZq?=
 =?utf-8?B?Y2VoTmJXa0lES1Zua01lR21pWHUycnErekErMmxINS9DYVl1K2hVRmdyRUJH?=
 =?utf-8?B?TFAyMU56MGxWWmpYai8wQno4Z0QzYTljdWc5Wk1valBlUHZndldLQ1c1L1Fw?=
 =?utf-8?B?WlFqK0U3SCtZVC84b2NwSUs4VjQ2RTRzRk92KzU0dlZkMXBrbkFBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9859956-a48e-477f-5c35-08df2c27dd63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 08:23:03.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieFf9CcWTcnroLVuqQxtyMbsQGluVb8nEbCKUqTsXzAlOCGvrljG6vWEppiRQyGp+Eol/p1/sNmWYtoNCWe++ETwSM/Oz+YbnDCgsHEphfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10125

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+DQo+IFNlbnQ6IDE3IE9jdG9iZXIgMjAyNiAwOTox
MQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvM10gZHQtYmluZGluZ3M6IGNhbjogcmVuZXNh
cyxyY2FyLWNhbmZkOiBEb2N1bWVudCBSWi9HM0wgU29DDQo+IA0KPiBPbiAxNi8xMC8yMDI2IDE2
OjEyLCBCaWp1IERhcyB3cm90ZToNCj4gPj4NCj4gPj4+IEBAIC0yOTQsNiArMjk1LDI1IEBAIGFs
bE9mOg0KPiA+Pj4gICAgICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+Pj4gICAgICAgICAgIl5j
aGFubmVsWzYtN10kIjogZmFsc2UNCj4gPj4+DQo+ID4+PiArICAtIGlmOg0KPiA+Pj4gKyAgICAg
IHByb3BlcnRpZXM6DQo+ID4+PiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAgICAgICAg
ICBjb250YWluczoNCj4gPj4+ICsgICAgICAgICAgICBjb25zdDogcmVuZXNhcyxyOWEwOGcwNDYt
Y2FuZmQNCj4gPj4+ICsgICAgdGhlbjoNCj4gPj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+Pj4g
KyAgICAgICAgaW50ZXJydXB0czoNCj4gPj4+ICsgICAgICAgICAgbWluSXRlbXM6IDExDQo+ID4+
PiArDQo+ID4+PiArICAgICAgICBpbnRlcnJ1cHQtbmFtZXM6DQo+ID4+PiArICAgICAgICAgIG1p
bkl0ZW1zOiAxMQ0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICAgcmVzZXRzOg0KPiA+Pj4gKyAgICAg
ICAgICBtaW5JdGVtczogMg0KPiA+Pg0KPiA+PiBEaXNjb3ZlcmVkIGJ5OiBzYXNoaWtvLWdlbWlu
aSDCtyBNaXNzZWQgYnk6IG9wdXMtNS01LCBncHQtNi1hc3RyYSDCtw0KPiA+PiBDb25maXJtZWQg
Ynk6IG9wdXMtNS01IFNob3VsZCB0aGlzIGJsb2NrIGFsc28gY2FwIGludGVycnVwdHMgYW5kIGlu
dGVycnVwdC1uYW1lcyBhdCAxMT8NCj4gDQo+IENvcnJlY3QuDQo+IA0KPiA+DQo+ID4gS3J6eXN6
dG9mLA0KPiA+DQo+ID4gRG8geW91IGFncmVlIHdpdGggc2FzaGlrbydzIGNvbW1lbnQ/IEkgZHJv
cHBlZCBtYXhJdGVtcyBiYXNlZCBvbiB0aGUNCj4gPiByZXZpZXcgY29tbWVudCBbMV0NCj4gDQo+
IEkgYXNrZWQgdG8gZHJvcCBtYXhJdGVtcyBmcm9tIHJlc2V0cy4gV2h5IGRpZCB5b3UgZHJvcCBp
dCBmcm9tIG90aGVyIHBsYWNlcz8gQ29tbWVudHMgZnJvbSByZXZpZXdlcnMNCj4gYXBwZWFyIGlu
IHNwZWNpZmljIHBsYWNlcywgbm90IHJhbmRvbWx5Lg0KDQpPb3BzIEl0IHdhcyBteSBtaXN0YWtl
LiBJIHRob3VnaHQgSSBuZWVkIHRvIHVwZGF0ZSBvdGhlciBibG9jayBhcyB3ZWxsDQpzcyBpdCB3
YXMgc2ltaWxhciBwYXR0ZXJuIHdpdGggbWluL21heCBJdGVtcy4NCg0KSSB3aWxsIHJlc3RvcmUg
bWF4SXRlbXMgaW4gSW50ZXJydXB0cy9pbnRlcnJ1cHQtbmFtZXMgaW4gdGhlIG5leHQgdmVyc2lv
bi4NCg0KPiANCj4gV2hhdCBpcyB0aGUgdXBwZXIgY2FwIG9uIGludGVycnVwdHM/DQoNCjIwLg0K
DQpDaGVlcnMsDQpCaWp1DQo=
