Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011008.outbound.protection.outlook.com [52.101.125.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9F494805;
	Mon, 19 Oct 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398405; cv=fail; b=Ta6U0JQuo8e0vnEB2fkcDbGRy57HhmqRxU/hjOyQe0kv+RHcxpD09QAETVc5HSIqxPQCkzX00JW2iGqe74m7kMBKCJkrzA+MfwiziNI0PscAe7QUCMX/8KF117n/M3dy3v5dwCJSxoo5DcPfUtC67Lm2ZsQLWCPmjztTNTytaZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398405; c=relaxed/simple;
	bh=4nez3DeCVNN7zVZQZ9RQTqP/0O+muuvwN9vZkiJZ/Lk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BMoifqAECawk3ycEy5NTiMzuqIzrOI7TeN5or8JTjiJgnta0EIsxTh0yyrjPDwYLifLAj2wjhl2OsyAvD3QaFdPLDf3VHeacxt2qkwaKApAQyZEGpk93Q2tcHfZz/DNvxBCqlMCCE01RGbh88Wmbf/unR5w7Ne6Quy/ll6ibSG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UctkqEm/; arc=fail smtp.client-ip=52.101.125.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UctkqEm/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8vYkGDuwQbCLBlM/A7bElS/Q8ITsPFqoMJEhAa4yxQN+BIVuGrnWl4ulJjiewVnpnQ8+JF1Tj6w1ADqy97X9cbzMGLDUkUPjgTbh1i+4+EDHVpC76SUlIQ5AgcNL8JqaelLESmhLYcf/yD97uYJOUw6PUKDrvZTEysmUwi2eTW4YldGxIIRcUcckzCVcmZpCzeSHgydlh9lXKuRAUqgbPSZH45bEBWLVZLe3gFNflXUlxBUeF94clrEHzsBZ8uWi8TdjUEhrRcgW1ItqdPiiZiUE2bd9QtKwb195oSMM49ENbNVDQnmZSND8E0MJZNPGrid0bM7swB+5J2I/Gnhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nez3DeCVNN7zVZQZ9RQTqP/0O+muuvwN9vZkiJZ/Lk=;
 b=zVfBo4mSaOzg2/Yhb+wVhXxSsQXXh920+fIZJnywR/Y7MD4r2URXzlGMzvUGNBuR6sVk8009Xh0L3+v1tQ1TdETYLWuhXPabS2jRjpiMaJny6Ag8OKSbXD8w7y6JO++hc+sC7LSJxZF5lCD43GXoSuKHA+Pk0lvs9KPDrOoDt03dpRpmVBtUfDFIsBtC5W+sms0yUHIj95dMx2oOY+6eOxe/oYOWyIqjisbWjLYyR/23uEEnX5ro5E+PIK0Pote48LJPIuIRh4Ncpdr7gOVmswTC1XKY6bX67RpeBmr8Ao3rvY9dCylp7ovBDNkBJPsE5m7xeNa9ObfCJKwQl2mCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nez3DeCVNN7zVZQZ9RQTqP/0O+muuvwN9vZkiJZ/Lk=;
 b=UctkqEm/Lhc2895VHlyTavjZHbv1izM+EHWShlkDv+OSea/6UOet1Q6GWjy945ZoLr5mOyW9xAIiOUbf00wP8KNoa2WQxj5gGIpzTjf8rcKydvJG87WzHpnx7xHVtAOpOQEPWpHNmuC3X4nQ7A5zxn38KPivyFPzVqf6k1IdvjE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB12118.jpnprd01.prod.outlook.com (2603:1096:400:3d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:26:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Mon, 19 Oct 2026
 08:26:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "Claudiu.Beznea" <claudiu.beznea@tuxon.dev>, Marc Kleine-Budde
	<mkl@pengutronix.de>
CC: "mailhol@kernel.org" <mailhol@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, "Claudiu.Beznea"
	<claudiu.beznea@tuxon.dev>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v4 1/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Thread-Topic: [PATCH v4 1/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Thread-Index: AQHdXXMSsMwpnwM8V0+/50zGaKzocLcEenrwgAAK1oCAAAW5gA==
Date: Mon, 19 Oct 2026 08:26:39 +0000
Message-ID:
 <TY3PR01MB11346BB7B48E311542BD7226A86982@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev>
 <20261016-elite-feathered-rook-5dcf2b-mkl@pengutronix.de>
 <TY3PR01MB1134682A7E8AEDB860F02752D86982@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <3ac7b72a-3468-49f6-b4d3-6b33e252ffc6@tuxon.dev>
In-Reply-To: <3ac7b72a-3468-49f6-b4d3-6b33e252ffc6@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB12118:EE_
x-ms-office365-filtering-correlation-id: 6f27cbf6-6fe0-41bb-d478-08df2dbab2bc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 MsJPvdw97MpUb1wQZqfOH/Hs/xSOc1RavwEw34KDrtLwBNNP48Dfk8jgqxnGYgn4x7aUsFWeSVuo9SHkZAu8g+i3p4O2qz/Sm+oQBL8GZejMRcQoq77ntJrL/i4EkpwTVrnB82UX77KPzbC7sR06ka6ssGk1uDwhwXelopCK6LzoJGdUGVbAFE24e9DJk/qMGXHdDkJJFYvRVVbDeLOyZdp2O/K5TcD3FoQclfpVV76iptOwGhzu+EeOgJVKiL01EokAAg0sBtfdW0NoFXGOFkMXHsQOQTIM3tV+HKiV6MNKRf6jMRyk3LOlGIpDVoVEgoVqlJFoIXjTraW9kN6i/+L4RguBnrnySp6mbFEwM3dCcTvodkq09Plw1MTFN/jtRS2dEFa3J24972KLgYKcum2AmL1ab24B3jZYYh8rjo9O96uQlWU9i3GRDlQYL4F9PATOJc1NcUGxAmvlpmych928f2U3kA/9SYB7QCmebV66vwvdKWzyD9Cn5zzNb5GGjqe7f1sXW/fibjSXbXKoLoRvonjmAioLeLZtrkW9P0G0z7e+XTT+Ir0JCy27HqV8UWOR1RqbZgSkuSRg9mTaCnOe86zySNXoHmhqL3W5PtF8sZl5VxPaxcMlhVUoVRb9UMKmvL8cRkWcbsgrNCejrDrvJNZQJbrJxPlhC7yDfA0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWh4TEI2STY5RjFDMXBrcEJBVmQ3cE8xejJtOHRHWkNWWExMNCtBc3JXb3VS?=
 =?utf-8?B?LzllTThkTWY1aGlaa3RaZHAyQnVlZmIxRTE2WG8zeHN5Q1cwcVNDL2ZhTzF1?=
 =?utf-8?B?bjdHbUgxWVJTckI2a0pkVkkrYzJJZ0grRFl2L1Ixejk3RTZDU05wNUdZUVor?=
 =?utf-8?B?UkFMUzlpbFRVVDRuZHdCUUo1bHBSakl5M3NzdmFOT2FOTENxdWFka2NZY24w?=
 =?utf-8?B?Tld5T3JTRjJ6bHY2cThyd2syZ3VJOGQra2hFSCtiTjJPRlRyUWJCcGR6cE1u?=
 =?utf-8?B?SmFRci90WUJIbHgrb283Z0JVMnFhcWZBRU1JV3dLdGkrMEI5VmxpQ1FQb01L?=
 =?utf-8?B?bU1ET3VPZjdTV2VSdXJQVFdVUXROVkdIbGlVcmhhSVNVekg1aHd6WUZsOGtM?=
 =?utf-8?B?dm1BblUvV1ptbTBhR2phYWF0aHlJWURzbXhxR0llWk4yMXRrdnVXZitodm5W?=
 =?utf-8?B?NHhzZmVRTjR5eGVzcWdNWUhJbFlybGtUOXJpOVluWElQMzBrT0gvWHlhM2xZ?=
 =?utf-8?B?MDIrbG05UlFTV25kcGxVa1JRMnREY2t6U2h5UENwMU1tbEtLOXBRbUlJN0hh?=
 =?utf-8?B?VWxYeUFMVytTUzZZT2FGdWtVM3FzZThMUEpVOG0vN0xCVmNjN0NiU2ZFMlRU?=
 =?utf-8?B?Mm9EMndOR0M2OXV6cTBTbnlJMG9pOUhoUzF2WURaYUVzaGFYbDQ4RDBzK0Rx?=
 =?utf-8?B?ckxUdUdxaUhCM1lrM2JJanN6ZnpET3NVU2tOMDFnbFhwMjJSZnllWEtEa3Q4?=
 =?utf-8?B?VEovaFBLbXB0T2NmbENJL1pCOE1Mamp1Q2YxcjZJQWNjazRCZHdVNlR0dnJH?=
 =?utf-8?B?UXN0M3JWR25vdWdhNDhJLy83T05DUjZDV2ZUVE5HQTVqeFIxQ3MzOVVOSExC?=
 =?utf-8?B?QUhZckJaQlk2bzZhZkkwQ0pnRXNYUGtaUU0xWnMzZ2ZDaE12U0kvZkhlbFpr?=
 =?utf-8?B?Ry9lWjhVUlo1TnFDWDNQTVBrVkM5SStRc0FleEtHVVozTVJEYXJWQ053OUU3?=
 =?utf-8?B?M1Y3MkhzdGdWOEN6bVAyR3NSazJabHI3dWVuWjMvMWtGTzV6N2ZqaWd6czhl?=
 =?utf-8?B?TTBCQTlzK2dVdHR4Z2ticzMyWnRzdWdvSlBYMFYydmNENVMwQWJEc3FKMWRT?=
 =?utf-8?B?QUd1aDdPODNFV1BxMWdzamd2dlpGZ0J4WVQxWTdBS0tMSXJma1ZZQzU2Snlt?=
 =?utf-8?B?VXdRZE5pQjZSa29FM0pydkRNazQwcXpSbE1MVnNiSVNpSE9TVTI5aFZNUnVS?=
 =?utf-8?B?UU9nNVQwUThzb2EyeXJ0NXEyN09LUVU1UWFSbFY4eUZJaXRrV0U2RmMzMGMv?=
 =?utf-8?B?TzV6VHUxQ0ozeHBMSzdEemI5T0FEQWpNbXJGMHRWNEJPdTljM2l3K3VlM3R6?=
 =?utf-8?B?cDAyRy9FaVhvQTRQUENrYm1HTllNWDdTVW03c2huSkFVWExWVThJMFhLRnVK?=
 =?utf-8?B?VGFmNWpkOEVVK2djNWVVWlU5ZFZsUUc5WGpXV25lUCtKR09YYlo2VWpTRVNL?=
 =?utf-8?B?L1ordk5iaTZ6d1RXamNWTElVczFWcm91MjhjVXdNQjd4NHRxRFR1Lzd6SnJm?=
 =?utf-8?B?ekJCTEpkK09CN3dxTFZjZ0tWOHFoVkRIQVE3ejl1ZGsrVFh0U0F2dUwrRThC?=
 =?utf-8?B?VHVIZnZKQkpxa0hxZEp2NzRuOU9jdGxMdFBJYlVZcFpMSkJxZHZPdkxuRThK?=
 =?utf-8?B?Tk1YQnc2dHQwMWNCUU5LRWJtcytId0dYR3JsUDVMcEV4SXZjclBCakpWL1Jk?=
 =?utf-8?B?S21BYTdNeXQrbmJnazFZd1hkUnFvY000WVJ0Qlg3RHA2Vm5nc2ZmVW9BWFpo?=
 =?utf-8?B?VkVxYUprSHdyRktVMUM2TE1sL0Fpa0NRSzZGR3hlamsrTzVVT2M5SXlLRkhm?=
 =?utf-8?B?c3VlWlF6TXloZmVwL3ZFakxKeUgvMHpBYk1pZnpDNUt0aUdrVzJiN1BVcmZD?=
 =?utf-8?B?aHRDZytVcFE5cFowS0dBOHBOWGM4S0NRUEFGRWZJYjBDWm9meEJWZDUrVCsy?=
 =?utf-8?B?aXJZVkhNWW9qcU1MbWRraGNUa2luV1RmN29vN2t0NE5MK0xyNEJVZ0hna2tU?=
 =?utf-8?B?c3JwUHNUWHdhaVhmc2xwa2ZDMTJaUm10ZGRuYUhrWlhnT2ZpaklJUGZwNDVY?=
 =?utf-8?B?L0wrN3Z4ditJb2hQV2JRc28rMTNNRUpIcHVzUjJmRDk2dTBUdEIrZ3p1VVhR?=
 =?utf-8?B?cGJOUUpsUXMxT2JZSldVQWs5TTFIQy9vUEFWQzF5ckRTekVMYTJ0N1lPTEts?=
 =?utf-8?B?UzF6Y1RxV2dXSUo2ZXhOM0RpUWgxcmhUMS9VMDg2U1FjdVlOckFpZGxGSk91?=
 =?utf-8?B?WWpwM2VQR3FqVDZrR2hTOTBUV0FJdHpNZlhqMjJvTEVYZlFNeWJiQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f27cbf6-6fe0-41bb-d478-08df2dbab2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 08:26:39.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bugjT3zUuRwXuKychlQ4r5KI+BkdllK45vrqkHgBvw771B7c5+HFkI9xx1p+IK7KN5R+oHfEpizVNIG/GxOCVGv1m6OOLqwKtLrx5Ez3yKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12118

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAxOSBPY3RvYmVy
IDIwMjYgMDk6MDINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzddIGR0LWJpbmRpbmdzOiBj
YW46IHJlbmVzYXMscmNhci1jYW5mZDogRG9jdW1lbnQgUlovRzNTIFNvQw0KPiANCj4gSGksIEJp
anUsDQo+IA0KPiBPbiAxMC8xOS8yNiAxMDoyNCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQ2xh
dWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBN
YXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiA+PiBTZW50OiAxNiBPY3Rv
YmVyIDIwMjYgMTQ6MzQNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzddIGR0LWJpbmRp
bmdzOiBjYW46IHJlbmVzYXMscmNhci1jYW5mZDoNCj4gPj4gRG9jdW1lbnQgUlovRzNTIFNvQw0K
PiA+Pg0KPiA+PiBPbiAwMi4wOS4yMDI2IDE3OjE1OjM4LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToN
Cj4gPj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2Fz
LmNvbT4NCj4gPj4+DQo+ID4+PiBUaGUgQ0FOIEZEIGNvbnRyb2xsZXIgZm91bmQgb24gdGhlIFJl
bmVzYXMgUlovRzNTIFNvQyBpcyBsYXJnZWx5DQo+ID4+PiBjb21wYXRpYmxlIHdpdGggdGhlIHZh
cmlhbnQgcHJlc2VudCBvbiB0aGUgUlovRzNFIFNvQy4gVGhlIG1haW4gZGlmZmVyZW5jZXMgYXJl
Og0KPiA+Pj4gLSB0aGUgUlovRzNTIHByb3ZpZGVzIG9ubHkgdHdvIENBTiBGRCBjaGFubmVscw0K
PiA+Pj4gLSB0aGUgUlovRzNTIHN1cHBvcnRzIG9ubHkgQ0FOIEZEIG9wZXJhdGlvbjsgdGhlIENo
YW5uZWwgbiBDQU4gRkQNCj4gPj4+ICAgIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgZG9lcyBub3Qg
aW1wbGVtZW50IHRoZSBiaXRzIHVzZWQgdG8gc2VsZWN0DQo+ID4+PiAgICBjbGFzc2ljYWwgQ0FO
LW9ubHkgbW9kZSAoYml0IDMwKSBvciBDQU4gRkQtb25seSBtb2RlIChiaXQgMjgpOw0KPiA+Pj4g
ICAgY29uc2VxdWVudGx5LCBiaXQgMzEgKENBTiBGRCBGcmFtZSBEaXN0aW5jdGlvbiBFbmFibGUp
IG9mIHRoZSBzYW1lDQo+ID4+PiAgICByZWdpc3RlciBpcyBhbHNvIG5vdCBpbXBsZW1lbnRlZA0K
PiA+Pj4gLSBzb21lIGJpdHMgaW4gc2V2ZXJhbCByZWdpc3RlcnMgKG1haW5seSByZXNlcnZlZCBv
ciBzdGF0dXMgYml0cykgYXJlDQo+ID4+PiAgICByZWFkLXdyaXRlIG9uIHRoZSBSWi9HM1MgYnV0
IHJlYWQtb25seSBvbiB0aGUgUlovRzNFOyB0aGVpciBiZWhhdmlvciBpcw0KPiA+Pj4gICAgb3Ro
ZXJ3aXNlIGlkZW50aWNhbDogdGhlIGJpdHMgcmVhZCBiYWNrIGFzIDAgb24gYm90aCBTb0NzIGFu
ZCBzb2Z0d2FyZQ0KPiA+Pj4gICAgaXMgYWxsb3dlZCB0byB3cml0ZSBvbmx5IDAgdG8gdGhlbSBv
biB0aGUgUlovRzNTDQo+ID4+PiAtIHRoZSBSWi9HM1MgcHJvdmlkZXMgMjU2IGFjY2VwdGFuY2Ug
ZmlsdGVycywgY29tcGFyZWQgdG8gNzY4IG9uIHRoZQ0KPiA+Pj4gICAgUlovRzNFDQo+ID4+PiAt
IHRoZSBSWi9HM1MgY2FuIHVzZSBQQ0xLIGNsb2NrIGFzIHRoZSBDQU4gRkQgY2xvY2sgc291cmNl
IHRocm91Z2ggYW4NCj4gPj4+ICAgIGludGVybmFsIGNsb2NrIGRpdmlkZXIsIHdoaWxlIGFsc28g
c3VwcG9ydGluZyBhbiBleHRlcm5hbCBDQU4gRkQgY2xvY2sNCj4gPj4+ICAgIHNvdXJjZQ0KPiA+
Pj4NCj4gPj4+IFNpbmNlOg0KPiA+Pj4gLSB0aGUgU29DIGNsb2NrIGdlbmVyYXRvciBwcm92aWRl
cyB0byB0aGUgQ0FOIElQIG9ubHkgdGhlIHBlcmlwaGVyYWwgYW5kDQo+ID4+PiAgICB0aGUgUkFN
IGNsb2Nrcw0KPiA+Pj4gLSB3aGVuIHNvdXJjZWQgZnJvbSB0aGUgcGVyaXBoZXJhbCBjbG9jaywg
dGhlIENBTi1GRCBjbG9jayBpcyBvYnRhaW5lZA0KPiA+Pj4gICAgaW5zaWRlIHRoZSBJUCBpdHNl
bGYgYnkgZGl2aWRpbmcgdGhlIHBlcmlwaGVyYWwgY2xvY2sNCj4gPj4+IC0gdGhlIGFzc2lnbmVk
LWNsb2NrcyBhbmQgYXNzaWduZWQtY2xvY2stcmF0ZXMgcHJvcGVydGllcyBhcmUgc3BlY2lmaWMg
dG8NCj4gPj4+ICAgIHRoZSBDQU4tRkQgY2xvY2sNCj4gPj4+IHRoZSBhc3NpZ25lZC1jbG9ja3Mg
YW5kIGFzc2lnbmVkLWNsb2NrLXJhdGVzIHByb3BlcnRpZXMgd2VyZSBkcm9wcGVkDQo+ID4+PiBm
cm9tIHRoZSByZXF1aXJlZCBwcm9wZXJ0aWVzIGxpc3Qgb2YgdGhlIFJlbmVzYXMgUlovRzNTIFNv
Qy4NCj4gPj4+DQo+ID4+PiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIFJlbmVzYXMgUlovRzNT
IFNvQy4NCj4gPj4+DQo+ID4+PiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhA
a2VybmVsLm9yZz4NCj4gPj4+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiB0aGUgbmV0ZGV2
IHJldmlldyBib3QgaGFzIGZvdW5kIGEgbml0cGljaywgaXQncyBhYm91dCB0aGUgY29tbWVudCBp
bg0KPiA+PiAicmNhcl9jYW5mZC5jIi4gQ2FuIHlvdSBmaXggaXQsIGlmIHlvdSByZS1zcGluIHRo
ZSBzZXJpZXMuDQo+ID4+DQo+ID4+IHJlZ2FyZHMsDQo+ID4+IE1hcmMNCj4gPj4NCj4gPj4gcHct
Ym90OiBjcg0KPiA+Pg0KPiA+PiAtLS0gUGF0Y2ggWzExXTogW1BBVENIIG5ldC1uZXh0IDExLzM3
XSBkdC1iaW5kaW5nczogY2FuOg0KPiA+PiByZW5lc2FzLHJjYXItY2FuZmQ6IERvY3VtZW50IFJa
L0czUyBTb0MgLS0tIGNvbW1pdA0KPiA+PiA2OWI0ZTM3ZDE4ZTUyMjllMWM4MDBiNDVhNWRmMDYx
YWY4YTk4ZWI5DQo+ID4+IEF1dGhvcjogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVq
QGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBkdC1iaW5kaW5nczogY2FuOiByZW5lc2FzLHJj
YXItY2FuZmQ6IERvY3VtZW50IFJaL0czUyBTb0MNCj4gPj4NCj4gPj4gVGhpcyBhZGRzIHRoZSBy
ZW5lc2FzLHI5YTA4ZzA0NS1jYW5mZCBjb21wYXRpYmxlIGZvciB0aGUgUlovRzNTIENBTg0KPiA+
PiBGRCBjb250cm9sbGVyLiBJdCBhZGRzIHRoZSBjb21wYXRpYmxlIHRvIHRoZSBleGlzdGluZyBj
b25kaXRpb25hbA0KPiA+PiBibG9ja3MuIEl0IGFsc28gZm9yYmlkcyByZW5lc2FzLG5vLWNhbi1m
ZCBhbmQgcmVuZXNhcyxmZC1vbmx5IG9uIFJaL0czUywgYW5kIG1ha2VzIGFzc2lnbmVkLWNsb2Nr
cyBhbmQNCj4gYXNzaWduZWQtY2xvY2stcmF0ZXMgcmVxdWlyZWQgb25seSBmb3IgdGhlIG90aGVy
IFNvQ3MuDQo+ID4+DQo+ID4+IExpbms6DQo+ID4+IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8y
MDI2MDkwMjE0MTU0NC41NjU3NjMtMi1jbGF1ZGl1LmJlem5lYStyZW5lcw0KPiA+PiBhc0B0dXhv
bi5kZXYNCj4gPj4NCj4gPj4+IGRpZmYgLS1naXQNCj4gPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbWwNCj4gPj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNh
bmZkLnlhbWwNCj4gPj4+IGluZGV4IGI5ZDlkZDdhNzk2Ny4uYmJhYWVmOGY0MjgyIDEwMDY0NA0K
PiA+Pj4gLS0tDQo+ID4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW1sDQo+ID4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueQ0KPiA+Pj4gKysr
IGFtDQo+ID4+PiArKysgbA0KPiA+Pg0KPiA+PiBbIC4uLiBdDQo+ID4+DQo+ID4+PiBAQCAtMzUw
LDYgKzM1MiwyMCBAQCBhbGxPZjoNCj4gPj4+ICAgICAgICAgcHJvcGVydGllczoNCj4gPj4+ICAg
ICAgICAgICByZXNldC1uYW1lczogZmFsc2UNCj4gPj4+DQo+ID4+PiArICAtIGlmOg0KPiA+Pj4g
KyAgICAgIHByb3BlcnRpZXM6DQo+ID4+PiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAg
ICAgICAgICBjb250YWluczoNCj4gPj4+ICsgICAgICAgICAgICBjb25zdDogcmVuZXNhcyxyOWEw
OGcwNDUtY2FuZmQNCj4gPj4+ICsgICAgdGhlbjoNCj4gPj4+ICsgICAgICBwcm9wZXJ0aWVzOg0K
PiA+Pj4gKyAgICAgICAgcmVuZXNhcyxuby1jYW4tZmQ6IGZhbHNlDQo+ID4+DQo+ID4+IERpc2Nv
dmVyZWQgYnk6IG9wdXMtNS01IMK3IE1pc3NlZCBieTogZmFibGUtNS0xLCBncHQtNi1hc3RyYSwN
Cj4gPj4gc2FzaGlrby1nZW1pbmkgwrcgQ29uZmlybWVkIGJ5OiBmYWJsZS01LTEgVGhpcyBpc24n
dCBhIGJ1ZywgYnV0IHNob3VsZCB0aGUgcmVuZXNhcyxuby1jYW4tZmQNCj4gZGVzY3JpcHRpb24g
YmUgdXBkYXRlZCB0byBtYXRjaCB0aGlzIG5ldyBjb25zdHJhaW50Pw0KPiA+Pg0KPiA+PiBUaGUg
cHJvcGVydHkgZGVzY3JpcHRpb24gaW4gdGhlIHNhbWUgYmluZGluZyBzdGlsbCBzYXlzIHRoYXQg
ZXZlcnkNCj4gPj4gY29udHJvbGxlciBjYW4gcnVuIGluIENsYXNzaWNhbCBDQU4NCj4gPj4gbW9k
ZToNCj4gPj4NCj4gPj4gICAgcmVuZXNhcyxuby1jYW4tZmQ6DQo+ID4+ICAgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+PiAgICAgIGRlc2NyaXB0aW9u
Og0KPiA+PiAgICAgICAgVGhlIGNvbnRyb2xsZXIgY2FuIG9wZXJhdGUgaW4gZWl0aGVyIENBTi1G
RCBtb2RlIChkZWZhdWx0KSBvciBGRC1Pbmx5DQo+ID4+ICAgICAgICBtb2RlIChSWi97RzJMLEcz
RX0gYW5kIFItQ2FyIEdlbjQpIG9yIENsYXNzaWNhbCBDQU4gbW9kZS4gU3BlY2lmeSB0aGlzDQo+
ID4+ICAgICAgICBwcm9wZXJ0eSB0byBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gQ2xhc3NpY2FsIENB
TiBtb2RlLg0KPiA+Pg0KPiA+PiBXaXRoIHRoaXMgcGF0Y2ggdGhlIHByb3BlcnR5IGlzIGZvcmJp
ZGRlbiBmb3INCj4gPj4gcmVuZXNhcyxyOWEwOGcwNDUtY2FuZmQsIGJlY2F1c2UgUlovRzNTIGRv
ZXMgbm90IGhhdmUgdGhlIG1vZGUgc2VsZWN0IGJpdHMuDQo+ID4+DQo+ID4+IFRoZSBoZWFkZXIg
Y29tbWVudCBpbiBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgc2F5cyB0aGUgc2Ft
ZQ0KPiA+PiB0aGluZzoNCj4gPj4NCj4gPj4gICAqIFRvIHN3aXRjaCB0aGUgY29udHJvbGxlciB0
byBDbGFzc2ljYWwgQ0FOIChDQU4gMi4wKSBvbmx5IG1vZGUsIGFkZA0KPiA+PiAgICogInJlbmVz
YXMsbm8tY2FuLWZkIiBvcHRpb25hbCBwcm9wZXJ0eSB0byB0aGUgZGV2aWNlIHRyZWUgbm9kZS4g
QSBoL3cgcmVzZXQgaXMNCj4gPj4gICAqIGFsc28gcmVxdWlyZWQgdG8gc3dpdGNoIG1vZGVzLg0K
PiA+Pg0KPiA+PiBOZWl0aGVyIHRleHQgaXMgY2hhbmdlZCBsYXRlciBpbiB0aGUgc2VyaWVzLiBC
b3RoIG5vdyBjb250cmFkaWN0IHRoZQ0KPiA+PiBzY2hlbWEgZm9yIFJaL0czUywgYW5kIGZvciBS
Wi9HM0wgb25jZSBpdCBpcyBhZGRlZCB0aGUgc2FtZSB3YXkuDQo+ID4+DQo+ID4+IENvdWxkIHRo
ZSBkZXNjcmlwdGlvbiBleGNsdWRlIHRoZSBTb0NzIHRoYXQgb25seSBzdXBwb3J0IENBTiBGRCBt
b2RlPw0KPiA+DQo+ID4NCj4gPiBEbyB5b3UgcGxhbiB0byB1cGRhdGUgZGVzY3JpcHRpb24gb2Yg
cmVuZXNhcyxuby1jYW5mZCBpbg0KPiA+IGJpbmRpbmdzL2RyaXZlciBleGVtcHRpbmcgQ2xhc3Np
Y2FsIENBTiBtb2RlIGZvciBSWi9HM1M/IE9yIGRvIHlvdSB3YW50IG1lIHRvIHVwZGF0ZT8NCj4g
DQo+IEkgaW50ZW5kIHRvIHNlbmQgZm9sbG93IHVwIHBhdGNoZXMgdG9kYXkuIElmIHlvdSBhbHJl
YWR5IGhhdmUgc29tZXRoaW5nIHByZXBhcmVkIGZvciB0aGlzLCBwbGVhc2Ugc2VuZA0KPiBpdC4N
Cg0KT0sgSSB3aWxsIHJlYmFzZSBvbiB0b3Agb2YgdGhlIGNvbW1pdCBbMV0gYW5kIHdpbGwgc2Vu
ZCBuZXh0IHZlcnNpb24uDQoNClRoaXMgaGFzIGdlbmVyaWMgYmluZGluZyBjaGFuZ2UgZnJvbSBL
cnp5c3p0b2YgKyBSWi9HM1MgYmluZGluZyBzdXBwb3J0Lg0KDQpbMV0gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWtsL2xpbnV4LWNhbi1uZXh0LmdpdC9j
b21taXQvP2lkPTJiNGE1MDU1ZDUxN2IxMWJmNGE1NjcxY2VmMzJlNGQ3N2JjNDU2MjYNCg0KDQpD
aGVlcnMsDQpCaWp1DQo=
