Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011024.outbound.protection.outlook.com [52.101.125.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001E48422C;
	Thu, 24 Sep 2026 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256159; cv=fail; b=oyEhtP03EEFd8GNbQcjVIT8EISJTcEfPOqZjynkvldoPH/T3T3zo67060JZzlgwjatJGidoutOTsz5auWstphqtgJaBL3trpVi2wrPVCQMzSGhIUlWZaezBhYLdzZEgZMsNmOxQRxzcJETy9Jye4tB/cqO9kT+vKgRWfsq98+Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256159; c=relaxed/simple;
	bh=rMS/N3iU6hkEKISnrXf5FGPd6LkHmOLiKQKPOM66HvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZr6lKMIyxDEkWw19UohrMhjihOIUobzhZ83L1BhCHNKnFW8qFyK1hkAqBPYhJmlPed62h9nRUpsbBpqs64va1WFNW9dr38WOKlmIotvozycXXIpC0ZbL1n3ebHLhjxFjBk9OnZBfDyhSiuWUfulXcS9SbMlQ/iejsQG/7/m3hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XwRJK4Xu; arc=fail smtp.client-ip=52.101.125.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XwRJK4Xu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCKebEGQ5MeifIkX98+5HC93tzptGGoTL2G2BD0EEQpX8tx0CbO7fAq9y7AmYjbrtRuCt5vmv9pVmaEOONHJTk9nzcN8IukQVyi2rvgSSKXk8RKE8hpl9cstXz542Zbf1I3OL68UEhIp3/j9iGSrpzfL9g3hrOunk/+fLy+Ej2UDlQyuBeyvJt0N5Z1tGteedPvIh+S/9n2C/QiW1X2c5/m2MSrQBokOBbVizIykZEPLLinfcMCLyOF9tsrkwBxGK9ModvDlc54c3GZjy7HT5ODLywsrOV524Y2zOh+AiLhAVCazSMFHfPR+FkN2fqsEjVM/vc4tfdlTMY6MdQav0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMS/N3iU6hkEKISnrXf5FGPd6LkHmOLiKQKPOM66HvU=;
 b=tEn1QLy39ciV2EIqj9pndS+rVIcRkbkC3guDa3AnALS+tsngk8vgMvj+aqY3Ef8wo2OPQqntMPSvQ/YYeHHsZSYhSwIeK3R9kbUVAE+SOCLQ6YO3pWAtTugpQx0MKZYGjQcR9Zu4h+7KryawMzWluQ4sOWq7h6tZTEfQldy2mPaZOt0YY8V6/TDYxwlUqtBozL07Q8HdV7wyRNU09o9mLIamUecuLrVa40k9i5BZoIRiZN1B/1cnIy/oTNW232o+93gDZ3dG+Hfqhg8uqj+JfNU1yqedbp0rzVTO2cE+n0cS9YbvdLembpk+q6O+A6F4JF6aCBq06sUWFrjj/PoXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMS/N3iU6hkEKISnrXf5FGPd6LkHmOLiKQKPOM66HvU=;
 b=XwRJK4Xuoi2CJKuJ0UdyU9fBZEbQqrkNDcmEoSsre1rFwKV2lrREmrhPLoVdkfobOHLwga1XUeO4iXWCwa1v5Ko+f1Z9YJKD+mrFylK164V8Q8UN4bTayqLRLQfy/x8KwLAeD3Vp3sWZmCIBiaX1Nyi5YS19hg5XtgQf+60tIGQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB16332.jpnprd01.prod.outlook.com (2603:1096:604:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:22:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:22:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Tu Nguyen
	<tu.nguyen.xg@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v2 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
Thread-Topic: [PATCH v2 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
Thread-Index: AQHdS+WHdsgTHXQeFEuho0F5z214jbbdtbOAgAABZqA=
Date: Thu, 24 Sep 2026 13:22:28 +0000
Message-ID:
 <TY3PR01MB11346E9532E1701678107BDDF86812@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260924052741.130658-1-biju.das.jz@bp.renesas.com>
 <20260924052741.130658-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdXVTyEROEciPgNuEjbnwEmm2+ah69x-aXEuhJxyn7Aq5Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXVTyEROEciPgNuEjbnwEmm2+ah69x-aXEuhJxyn7Aq5Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB16332:EE_
x-ms-office365-filtering-correlation-id: e6e7f839-b309-4a33-248d-08df1a3ee1cb
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 ++SRY0Ce9c5j+eb0Iox4hQRctFpN0UnY8mW1TIICI0tW5C1bT3OdTvLRZ/begH+wgvoVbGrqGXg0o2uwW7DCHwqnRovcvrT1/lSAneq80oum5sah5buzZlZLEN6Tbeud/422s+ilcxETwbiDkQVpgnNGibpWE+3rIezRlst5ke9vzpZ56waPBoh8w0mOQDGIdTlV7MEZltUnrCDGB1fdtWbWNgCIuMcAALwoC+50Lw19+mB6HSao147IBK8ZB6cza2jigC1ZgzOMsdE8LstG6RRhjPA80MQseLvV5E70LxW8yOMSD3th12qPy1Roz/jxjFXHmfpiwRVIRKnJEfnz8EypneYgyp0CCtLCnsQzVgOj2CA+4rPcwL4Y5gO9ye2574Cx0HPHiA7pu61FcfRBj+xOrQb4ouxP52k3JErufviSSuU2jTnnW20yihhPqkxYaBKIwWmDNz+O/oY+VuV2lsFrsgEg1VbUEO3FE2W9NgofJ2jqGxAYORYYDIKWGc2HqTfoHpI1ggmYiTKEUhjfunAhLMDvC+CexqnP8v68Tlvi6dy2jeDQpnGGAes3TKuzPZELyvFArad4Kc3FgIyQ30/64uqo5KM5832AdTGqXOefBpsmqWjcx8gWlakZMrXbDw+lyBhbjuG09SZqC7rVhZ6SaJqt7DRsyF+2HWXLsKqMXrYngZ6hrS3dYMPyFqpwXkNRZYtRTC0K5R88MeYKMdKc3o39nBQaC2yZ9UrkHP0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rmg5eVFXNUdiVlZQNXN4a3krTGdyM3Fsd1FpNGYvYlgrK2ovVG04THJUaUtD?=
 =?utf-8?B?eURORlFoTWRDbjhzVUduZWtJQW00bVBSeHlOaURyS0NTMjVhaDhrWklSKzJ0?=
 =?utf-8?B?ZHlYcHJlRnJlUUdKRW5zNktOc0c1a2haWmJsN0tZeFhHeCtZakc2d3BBQzk0?=
 =?utf-8?B?K29uZHh6bU1OcHlkNFlXdmNvY3VXY3UvMmdVWXlVT0EwL2c0NE15SjFZODhS?=
 =?utf-8?B?TmVuUDFRSmlyK1ZGM0dmUTh5bXhJZG1KQzNPa2JvSmtpdkVJWFBESzBsTCti?=
 =?utf-8?B?Sm9mUnhTSXV5MTRqS1Foc2FEcFlGekRGTnU4c2x3U1Y4VDRTTStpeUxnM2lk?=
 =?utf-8?B?dEw4V3h5eGF3VnVCSllhNEFYSzRQMWJ5M08yVWhjZGxQdTdKdk1BSEtSZ1gr?=
 =?utf-8?B?S2dYWkxIRG5lL2dicEw3WlIvQmx2RndsQjNmdjdhMFVraXdnK29wdVZtT2lT?=
 =?utf-8?B?YU5TczJHSjJsZEFEbCsvZlcvcVpQa2kzZ3BkbVg1ZHM1UHpZbkl0VmxaTXhY?=
 =?utf-8?B?bmtvaWMrV1JRTFQ5M0k5RTZRbWZhVXk5Q1YvR0I4bkR5Sk9lMGQ5VXdoSnVD?=
 =?utf-8?B?dzJFaXpWQUgybDFtSHg3V1BQdElEMmZxd3dnaGhDRXZPUnBVTXFRNm1PeTVI?=
 =?utf-8?B?QmUzaGtnL0ZVdysvNXhxZ091Yjl2ZTdENCtJNm4rMXlZQ0dxYlZpV2wvejc5?=
 =?utf-8?B?T3pUZ1FZWkpnS2xaYzJXZnJKWVZRTnpVVkY2dEZ4NmF4blphRWlVa2kzZk5x?=
 =?utf-8?B?UHg4Y0pKZCtlOGhXdDVRR2RkV1F3U2phOElMajE1Z0pOYnUxYkIvMXdzSUZk?=
 =?utf-8?B?bEordHQ5bk9LZmFDbzdHMnN4RHhwdVlmTlNZQUhrRURqRkNLVzVScU1WLzEy?=
 =?utf-8?B?WFhhRU80K2RQclhaYkZHMFovQTZtU1BxemFTeklWazZiZVFOeERqa3dDSGpR?=
 =?utf-8?B?dWdrZXpKTjRyZ0hoQUJZVTRvU3d5RU5tQ0h0L1ZQeWMvWC8rUzBsb2s4QkdL?=
 =?utf-8?B?M0hvQ1J0R0tGeHZQYlh4UU9LdTRXYnF6K2REa1Y0VlU4Wmd5YjBoZU1mMng0?=
 =?utf-8?B?cXhvcmZXL0lJdno4T2ErMWZ1UHBpTiswaTNSVXBTS3BBa0tCZkFGak52d0RO?=
 =?utf-8?B?M3Rud0RkV2NYbGMycUcvRFpEcVM3NGhObUFXdi9mQ0VpOWNHa2p5UFVITUdV?=
 =?utf-8?B?cFRYUi9yWHhabDQ0d0Q3QlNGSVdUZy9FeEJiZnNObnJBeHNzcXBTZnljazJI?=
 =?utf-8?B?NnJDT1VkNTlwYlFOMlQ3eHdQMEoySktjaThuMC9vbkh6ZHRwYytKUEw0bzVq?=
 =?utf-8?B?WnhBTTVkYXJ2aGkrdi8ydnZGWlMxVXBIMTgvdFd2Yi8ySURoZFZvd3hqTThp?=
 =?utf-8?B?Z1lsNEEvd3lPem1VOHNyRFh4cXkvVUF5U29uYVVERGE2bGZuUjc5TDhnM2ZT?=
 =?utf-8?B?WVJ3RU84VzBvc1RRelpXWmdhaWR4RVZBWUg4MDh5eWhydllDNjFzOTlnaW9S?=
 =?utf-8?B?TEVraGNxYmhoT0Q0cHpWMG80aTNRcFBqaVBLY2ZFYUhDSStDUjNjV2puNHl3?=
 =?utf-8?B?Um16bHhxZ3ZBbVprR25uZjRINGwzWHFSRHFpT3BVZGlRVm00ZHptM2V6RkxL?=
 =?utf-8?B?L1BkUjBObGliZzkvaHdQSVp6b3J5MFhFU0hTNDk0MUhiMUx6Vzh1WmZib0ds?=
 =?utf-8?B?RVdPaUFtakhjMlJOT2ZJYjJURU5UZm4yTWpyeUxIMFg5WXFiZVlqcEFtQVRi?=
 =?utf-8?B?WHJySWU2RkwwVGhlbG1wZjJONnQ2dktucGc0UmNibldncnBrMlhEbGVJeU1L?=
 =?utf-8?B?TXdRLytwOFBBeTV1aXlPdnJRNTJNZU1JOHo4U0lXOFhCaU1ubHBNYW9WSENt?=
 =?utf-8?B?SUFMTWxOWElSd1EyTnFwRE56WW94Umo5NWdTRUpGSFJkSloxYnFFWXJGd0NQ?=
 =?utf-8?B?OEV3YWRoOWE0U1BWRmY0QVNON0l2U1VtRmZKVENyRFlhdkh5SDdtMEJlUjdF?=
 =?utf-8?B?dlR3Y04vSHNDR2daZFI1S1ljZkg5WHFKcnRkWVUybDVIRktTWWNJNTBGQjRw?=
 =?utf-8?B?WU5tam11U2U1SU9PTFRMQ052VzNJdTU5UjdQcHFWK016OEMzUTRpektLclFU?=
 =?utf-8?B?QjZXNnF4Wll5R3dySEZWZC8vb0kxd1Q5MGM1TENsWmdlU09RdksycTJBamlU?=
 =?utf-8?B?UnFicmxKbVRMaHRwcnJHc1k4L01xTjB5SWR3MC9tQjkxZjE1M254Y2xPd1B6?=
 =?utf-8?B?Y0o3SlNzQTNTNFpkY0JWd3pPME9UbjlCSTd1aFZwcVpDRGxKWkQyREMxWkdU?=
 =?utf-8?B?ZkR3Ty9xUkVjQmNwc01sQzF0OHJYSTVjcXRRYlZvK1hKd1JXWnViZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e7f839-b309-4a33-248d-08df1a3ee1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 13:22:28.7846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M623USpEcNN57jt+WaI/YZmiJtQaOrkC9zyn4Vekp/aew3SFewD9TOdxNBQ4VXRJsbcXmjDobTWhCEd+zZ1ZPmZcG8wrqp8WMUb/Huye2JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16332

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDI2IDE0OjE1DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMy8zXSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBzdXBwb3J0IGZvciBSZW5lc2FzIFJa
L0czTA0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFRodSwgMjQgU2VwdCAyMDI2IGF0IDA3OjI4
LCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IEFkZCBz
dXBwb3J0IGZvciBSZW5lc2FzIFJaL0czTCBDQU5GRCBJUC4gUlovRzNMIGhhcyAzIGNoYW5uZWxz
IGFuZA0KPiA+IDExIGludGVycnVwdHMsIGNvbXBhcmVkIDIgY2hhbm5lbHMgYW5kIDggaW50ZXJy
dXB0cyBvbiBSWi9HM1MuDQo+ID4gUlovRzNMIGhhcyAyODggYnVmZmVycyBjb21wYXJlZCB0byAx
OTggYnVmZmVycyBvbiBSWi9HM1MuDQo+IA0KPiBXaGVyZSBkbyBJIGZpbmQgdGhpcyAiMTk4Ij8N
Ckl0IGlzIGEgdHlwby4gV2lsbCBmaXggdGhlIGNvbW1pdCBtZXNzYWdlIGluIG5leHQgdmVyc2lv
bi4NCg0KQ2hlZXJzLA0KQmlqdQ0KPiBUYWJsZSAzMC4xICJDQU4tRkQgU3BlY2lmaWNhdGlvbnMg
KDEvMikiOg0KPiANCj4gICAgIFRvdGFsIDE5MiBidWZmZXJzICh3aGVuIGZyYW1lIHNpemUgaXMg
NzYgYnl0ZXMpDQo+IA0KPiAxOTIgLyAyIGNoYW5uZWxzID0gMjg4IC8gMyBjaGFubmVscy4NCj4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiA+IC0tLQ0KPiA+IHYxLT52MjoNCj4gPiAgKiBVcGRhdGVkIGNvbW1pdCBkZXNjcmlwdGlv
bg0KPiA+ICAqIERyb3BwZWQgUlovRzNTIGZhbGxiYWNrDQo+IA0KPiBSZXZpZXdlZC1ieTogR2Vl
cnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gDQo+IEdye29ldGpl
LGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0t
DQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlh
MzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlv
bnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQgd2hl
biBJJ20gdGFsa2luZyB0bw0KPiBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0tIExpbnVzIFRvcnZhbGRzDQo=
