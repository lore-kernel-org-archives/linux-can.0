Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011002.outbound.protection.outlook.com [52.101.125.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354946F4B3;
	Wed, 23 Sep 2026 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151544; cv=fail; b=mQ0TvC0n1CInjcksMEWfxZ/ON893q/X/l/PPwcXGX80np4U1GO8zMrcjwIsa68gstY+C69Rl1fXgRmYHEQ1VS3RSwa8aVn4Tbm+t4cfu/9quGYlpnpg+vG392aMK/mR6IrZ20fccwR+Wpcs7bibjxLR0DroIWmr1vjZ3Wv3uNNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151544; c=relaxed/simple;
	bh=j+1Av2+qXWUDTPSNf2A+rqX5/3SPI+iYd1m58mHquGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFJw0KOeee/x/rNkJk/sGsoCULY5dL5YaCytfwnauk+UiWzL5LQYyLg60dtg3dsaPmBxwVrLvu8NVX2NNMUO8mkYIA9vcuyylc4mABQXw7SPJyeDNRuRttIR2w+BAaVsHT9If0u3RalWQbO2b2TQsOGXzfaRS18dG293C6JLUMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qf6pcVJI; arc=fail smtp.client-ip=52.101.125.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qf6pcVJI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLdli1GVOOP1RTmnXYWB8Sn5ReNt/nOybqXej3l1oBI1Mcg8Mr80aJU0XMj2b2+j33+Zv7e0sqeeX/iRJGbDck3qqmDGCU2aOwR7k+47YO2jBU796NgmqZsbukLZFJEzCYiaZXPmJQXuK632e+cvoj5PaiMkp291YbZ8shh/off9KgK2koQ5U1bjKSDEwjpiiTUONbznZ9y64rbgXDVs/x6veEWkHMxcyPsYH1leeO6NxrrpJXMpVVx66FpMVM33LDRntMUTOLnPGsMQEmTLzDYA/+pD2eejZgf/GWefSRsfUvJGAA4Z4QMgKmVIDrgo6OL8hFnhJB6u0Ty7SFMj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+1Av2+qXWUDTPSNf2A+rqX5/3SPI+iYd1m58mHquGQ=;
 b=MvRNBeAqQLM6qvuxSm0iSJS1ZUtX1lAxL+4pocXaUiPhE1Z6/ak/MQdm0/+l35Q//mRKUhsJzctAwKE+qYk4rLsAO9JyKJsRJeH8K43SgE6Oc/HaVuDkNTtDhaGGjgwoLJyGKZa2U0fNN44cP6v6N9ZEOLiy65ccZbgY10d9vNfe0uJEArJUxRbys7CliMMT7g6oIxNn0uv9StnuWI9xnrpJK6+ichJUK3Ca7mb8JRq4u1xPNmdvtTDPwQf85a12u7k8nCu2K81Py3kLGyPHttP0hlvJdzbt6GrXBB5dvkPrjJfuKplWgg7FkERC7OtiMCgApAS0KH9jd+ArWkzcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+1Av2+qXWUDTPSNf2A+rqX5/3SPI+iYd1m58mHquGQ=;
 b=qf6pcVJILcQg45qxiX46JNi6KFngr5bfMFzbOzm0cLcfU0u2umkWGyZThgxlU0GQlR0ghNlxeTB9ziSEvaM6LSwem/5w09CzrStnS0zvMZOz+95ZOg0/vgi2SMFz8NJ+JiTCTP0quEyc/MXPMkmcQyfmTjvZEQexXd4nwlN9RZ8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB15856.jpnprd01.prod.outlook.com (2603:1096:604:3cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:18:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:18:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 2/5] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L
 SoC
Thread-Topic: [PATCH 2/5] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Thread-Index: AQHdScvyKd44zcXOb0aD2Pqcp4J/k7batm2AgAEbASA=
Date: Wed, 23 Sep 2026 08:18:48 +0000
Message-ID:
 <TY3PR01MB11346F23E0C28056BC78DB36B86822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260921131951.187981-1-biju.das.jz@bp.renesas.com>
 <20260921131951.187981-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdUx5-P97CFEH3Dif1g4K=NPfkDkE=3vrzjZB-TsyxqO8Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUx5-P97CFEH3Dif1g4K=NPfkDkE=3vrzjZB-TsyxqO8Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB15856:EE_
x-ms-office365-filtering-correlation-id: e67407e1-0c28-4bda-e64a-08df194b4b81
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|10067099003|56012099006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 3Zi3eWl3xd+2MsbUVIyISK1SOThRyQxPqBmOSoYrlwMH8n3ntQqIJKqzCF0ub00eBb6Kao8+k7WTF2sokNpJkfLZ3LBGguyZRaqB724xa3xsYra1xK1kN1HbsPEvd3+yO6BHyyLMY913/ApuPn8Lhy9nXgacgD9XZIcWCskjBp9zUHhRhEdF6MjON7LnFwc8A45S7AYH0cRyWc7ubB3z/UIzQmj8WgjKDb82qqr5KGIjRso6Iem/6PS9IFGiRmEQYfBn8USQezNAHKh69K5VapX+Zi/8hNo6hEXEu4+W7u9DfnRSD6/mqqkA+qFghab+drJXGP/3mFwqWoCz0TggmWIS2eWZmpC7I53yYG/KXVmZZsKwy2AS4JGhCbhvduLds3dlKqsf/9aMAUCPeCsOkuzrSG25B5x/aUwONEYY6Cf1MocN9XPsaIiOo3OWmZXYV6x9jc7rgHPT689T6TVRCwx24GpjIrTb7v+gPnZEX6yad2D7TFBCOukUjZOtdoB2XZS/nNMF0iBwOVNoYd3VX8VLb52Ii5OQWcbUTyHfMsDLDcmIlhu6ZLd98iZ/OjRjenQOGomq9HhFRW9PDo1YxgKVWQxf4lv3wivyD1BwWN5rOSnuhUY89pJW1LC87ZCKvd3IvQ5ZsMK/9BWOB5TmqKbTfc70RzrBziDABjh1nqDjTbdzEsaV8cTU4OnASD8ubFnpZvC58Tyy/hx1oyJnleMR0v1Lwuk8g7nW9u7YUek=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGpKNllOay9oZkMvcEJ3c25QbHlMT1BpUWxhcGp0VkNNUFpVdE02RkxXTjdL?=
 =?utf-8?B?RHFEbEcxZ0taL096ZVU5T1BiSWhQWFdld21Bak8yUE5YelEzemVtV1pSTGlI?=
 =?utf-8?B?MmR4U3dqNWtxSkNBT2p3N3BnZnRJdDhqRytlZWUxU2c1M01oL09KYk1LTGty?=
 =?utf-8?B?V1VGbzkzK1laeENycENZdzNGbmRCQlFoOHg2dVkxTHNhVGVmdk1ER0c4R1RI?=
 =?utf-8?B?MnBvVHVhclVsNzQwV29ncitlUmI2OGhnQkJaTVlvQmYwMmFWNlA5TDJIcXE0?=
 =?utf-8?B?MnVWSDdYQktTMnJIRm14dGJjaW5JdUQwZ1V2VU5WVWM3OG5WdGhZU29xNHUw?=
 =?utf-8?B?c3RHb2IzSk9ONGFjQm5YWFBYZWV5cllxSjRKUlROVVZiN1ZsR2ZDMzdocng1?=
 =?utf-8?B?UXltSzZqNnlwbHk2Wm10YVdnQjZMSjgzelJhWVdpZ1FQQzd0NHBEY1hOK0RG?=
 =?utf-8?B?WlYxTG9OTzJuWjJSWDVzaTJ2Smh3N24wRThUU1FUaCtoU2g2RCtua1pKaFox?=
 =?utf-8?B?bXpnbHNiWVRTMnM3dHUxYzNYZTRveU9CZlhjVWFEdExFNnN1cERGNEhwemtk?=
 =?utf-8?B?cjlDN0NJYks5TmxJZjRwektMcldzSGlyNGI5YlRsTXArWXBwWWhtNXo0NnF3?=
 =?utf-8?B?UnhUTC9pSE4wczQ1NkRtaHN0K3FQOE1YcThjbzV1bUhQdGEvQ3dZZ0lrVUNw?=
 =?utf-8?B?dWxmTjFxTFpySjlDRTBqLy91cS9IWmNKaTRnSWJDTUFqb2oyY2JBU0EyUFNX?=
 =?utf-8?B?RjJMTHRFbGRra09tQ05QMS8zWEszZ3AyYWtvUW9VZ3lCdzBQOHVDTWlRLzVu?=
 =?utf-8?B?WjkzMU5nNmVZdW45YzNjQlRqT2F5Zm1xZ1F1a3lZQTBCMzRQbVA0TlB6NTVK?=
 =?utf-8?B?RklvV1pWMEpIZmZFWjhqSHFJZHE5OEMrdkRzZUNGa1hCNXFLb0k2dEFZbjhC?=
 =?utf-8?B?RURJNVRwdWxIN3A1NXdzejZwZXhXMnVnZGxDWXlFUElCMXJUeUQ0ckFEZFFP?=
 =?utf-8?B?ZWo2eUtTcHZoSkRsM3AxZi9lei9yN0xrM2t2T3dLMUhkZzJ1cVROZTluSml6?=
 =?utf-8?B?OFh4SVM2UmZVcjRiTThqZWZ5b0FCTERGUm16ckYrMGFKbUIvVXN5ZXhsNkQ5?=
 =?utf-8?B?R2J1QXcwT2Q2YVpxajR3Mm02VVBWOXZMR21qaGhwVDl4RlZQeEppN3Jxcnhh?=
 =?utf-8?B?aW1XK2dtRzJncE5CZURkeVZYa0h1L0QzRFRBMnNWMi94ZHFhZmRzcVkvU2J2?=
 =?utf-8?B?dE5CQUdnN2pRaXc4bDBNUVBLdU1IYWJHTlpyS1dNM25yL2xMZG9oTlF3RFF0?=
 =?utf-8?B?bHJ0RmhLUXdKQmJnbVBaNzFJamFrSFFiM3BFQVRXekltd2lvY0xzdEtCMy91?=
 =?utf-8?B?R3lzUEJ3a0ZTTStQNmc4RlVZQSs1Z0RTUThtT2UvUnp0bkl1eGd1ZCtsUllC?=
 =?utf-8?B?aCtnclltQ0tsRkw4SmtpTkFxL0tjVlNkVm5ac2NyOEorS0tNVHd5RklMV1l0?=
 =?utf-8?B?c3h2WHNYSFE0ZGQvM0ZtTU5MWkpuSFZydFpmdGd5WDN2UndrV1BRa1lzOCs5?=
 =?utf-8?B?d1d2YnduN2swbVIwd2hvSWhReVlaakRhYWxoU1QwR3ZXSXdmd2Z4WUliSWlu?=
 =?utf-8?B?RGx0aWFyNUhrVFBCWjl5dG5Mc0ozL2NlOWRwbm9GRUE5NW9vcEZVdFJ2WGs2?=
 =?utf-8?B?K1NqbjZtVXRodXdzMC9jR3gvYWg4eitMcFFlM3FvbHQyRjBZTElzNnY0MkRv?=
 =?utf-8?B?ZVJ1dUtHMFdNdHRhc0JTQm10OWVscVQvaUhCYnJSMWY4MkxuTEVXUFZoSmEr?=
 =?utf-8?B?Vi9GT1cwbDUwak9nMTZ5VVBLYkRCYU9DKzR1bCt2REgveEdXMzUwaGRwZEw0?=
 =?utf-8?B?ZWwvUzViaUFPSlYrYjNZWFpETjhuYlgzcWg3dmtkbU5mQUhiSVp6Y1RudlZW?=
 =?utf-8?B?Q0RFS1JTSG01MWtGUldPeE9KSUpkNk0wVjQwLzUya3VmeXBpckl4VVQzQ2Q4?=
 =?utf-8?B?aU5RdTR1c0tMemxsbHJHcjZ6WEpNZXliMS8xeDJCRFVBRVRHL3ZXTWdnZ1NU?=
 =?utf-8?B?TDA2eExhWTNlTjkzMnNlTnJORG83ekdjM0QyVURFY28waXhObVpwS3RqeitS?=
 =?utf-8?B?TUt0SmxDdVliZmdqTUZTOXg0bkpueWJ2QVZjMWxWbFJoTTlUdkhiVVgrNkJ1?=
 =?utf-8?B?Uk5Jc084Smo3akw0cTRreXNxM3VRZkgwZ09kMWwvdHowa25iejZOcldPNWVC?=
 =?utf-8?B?U0k4Ni91Y3pkcXBCWWFzdC8vSVhwYnByQUUzckloTmZhY0s3d1Z0ZmlVaWFQ?=
 =?utf-8?B?Z1JGT0FMNnFXS0V0RVZxSTloQ25VVUxnYW5USFA5ZzVVWDA1a0NuQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e67407e1-0c28-4bda-e64a-08df194b4b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 08:18:48.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGKlowxtZsZ9JfL/7Z98v7pUgdTuVr+6+KgRpv9EIZ+ubBo9LXEns3Eh+0n/kpMDZrvz+AM0TVlAYmtFVsIc46FT2jYO9FEgR9X1OKG3jvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15856

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDIyIFNlcHRlbWJlciAyMDI2IDE2OjE0DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMi81XSBkdC1iaW5kaW5nczogY2FuOiByZW5lc2FzLHJjYXItY2FuZmQ6IERvY3VtZW50
IFJaL0czTCBTb0MNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBNb24sIDIxIFNlcHQgMjAyNiBh
dCAxNToyMCwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4g
PiBEb2N1bWVudCB0aGUgUlovRzNMIChSOUEwOEcwNDYpIFNvQyBzdXBwb3J0LCB3aGljaCByZXVz
ZXMgdGhlIFJaL0czUw0KPiA+IChSOUEwOEcwNDUpIENBTkZEIGJpbmRpbmdzIGFzIGEgZmFsbGJh
Y2sgY29tcGF0aWJsZS4NCj4gPg0KPiA+IFJaL0czTCBoYXMgMTEgaW50ZXJydXB0cyBhbmQgMyBD
QU5GRCBjaGFubmVscyBjb21wYXJlZCB0byA4IGludGVycnVwdHMNCj4gPiBhbmQgMiBDQU5GRCBj
aGFubmVscyBvbiBSWi9HM1MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+
IA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9j
YW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWFtDQo+ID4gKysrIGwN
Cj4gPiBAQCAtNDcsNiArNDcsMTAgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgICAgICAgICAt
IHJlbmVzYXMscjlhMDdnMDU0LWNhbmZkICAgICMgUlovVjJMDQo+ID4gICAgICAgICAgICAtIGNv
bnN0OiByZW5lc2FzLHJ6ZzJsLWNhbmZkICAgICAjIFJaL0cyTCBmYW1pbHkNCj4gPg0KPiA+ICsg
ICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogcmVuZXNhcyxyOWEwOGcwNDYt
Y2FuZmQgICMgUlovRzNMDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiByZW5lc2FzLHI5YTA4ZzA0
NS1jYW5mZA0KPiANCj4gSSBhbSBub3Qgc3VyZSBpdCBpcyBhIGdvb2QgaWRlYSB0byB1c2UgUlov
RzNTIGFzIGEgZmFsbGJhY2sNCg0KSSBhbSBhbHNvIDUwOjUwIHRvIGdvIHdpdGggZWl0aGVyIHNl
cGFyYXRlIGNvbXBhdGlibGUgb3IgYXMgYSBmYWxsYmFjay4NCkxvb2tzIG1ham9yaXR5IGlzIGZh
dm91cmluZyBmb3Igc2VwYXJhdGUgY29tcGF0aWJsZS4NCg0KU28sIEkgd2lsbCBzZW5kIG5leHQg
dmVyc2lvbiB3aXRoIHNlcGFyYXRlIGNvbXBhdGlibGUgPz8NCmV2ZW4gdGhvdWdoIGxvdCBvZiBk
aWZmZXJlbmNlcyB3aGljaCBhcmUgc2NhbGFibGUgbGlrZQ0KInJlbmVzYXMscjhhNzc5aDAtY2Fu
ZmQiDQoNCj4gDQo+IFJaL0czUzoNCj4gICAtIFNlbGVjdHMgcmVjZWl2ZSBtZXNzYWdlIGFjY29y
ZGluZyB0byAxMjggcmVjZWl2ZSBydWxlcywNCj4gICAtIFNldHMgdGhlIG51bWJlciBvZiByZWNl
aXZlIHJ1bGVzICgwIHRvIDEyOCkgZm9yIGVhY2ggY2hhbm5lbC4NCg0KSSBiZWxpZXZlIGl0IGlz
IGEgdHlwbyBpbiBSWi9HM1MgSFcgbWFudWFsIGFzIFJOQzBbODowXSBpdCBpcyA5IGJpdA0KRmll
bGQgdW5saWtlIFJaL0cyTCB3aGljaCBoYXMgOCBiaXQgZmllbGQuDQoNClNpbmNlIGl0IGlzIDkg
Yml0cywgaXQgc2hvdWxkIGJlIDI1NiByZWNlaXZlIHJ1bGVzLg0KDQo+IFJaL0czTDsNCj4gICAt
IFNlbGVjdHMgcmVjZWl2ZSBtZXNzYWdlIGFjY29yZGluZyB0byAzODQgcmVjZWl2ZSBydWxlcywN
Cg0KIDI1NiArIDEyOCA9IDM4NCBmb3IgMyBjaGFubmVscy4NCg0KPiAgIC0gU2V0cyB0aGUgbnVt
YmVyIG9mIHJlY2VpdmUgcnVsZXMgKDAgdG8gMjU2KSBmb3IgZWFjaCBjaGFubmVsLg0KPiBUaGVz
ZSBkaWZmZXJlbmNlcyBhcmUgbm90IGV4cGxhaW5lZCBqdXN0IGJ5IHRoZSBkaWZmZXJlbnQgbnVt
YmVyIG9mIGNoYW5uZWxzLiAgSG93ZXZlciwgaXQncyBub3QgY2xlYXIgdG8NCj4gbWUgd2hhdCBp
cyB0aGUgcmVhbCBpbXBhY3QuDQo+IA0KPiA+IEBAIC0yNzAsNiArMjgzLDExIEBAIGFsbE9mOg0K
PiA+ICAgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwOWcwNzctY2FuZmQNCj4gPiAgICAgICAg
ICAgICAgICAtIHJlbmVzYXMscmNhci1nZW4zLWNhbmZkDQo+ID4gICAgICAgICAgICAgICAgLSBy
ZW5lc2FzLHJ6ZzJsLWNhbmZkDQo+ID4gKyAgICAgIG5vdDoNCj4gDQo+IENhbiB5b3UgcmVhbGx5
IHN0aWNrIGEgIm5vdCIgaGVyZT8gWWVzLCBhcHBhcmVudGx5IHlvdSBjYW4uDQo+IFN0aWxsLCBJ
IGZpbmQgdGhpcyBoYXJkIHRvIHJlYWQuDQoNCk90aGVyIG9wdGlvbiBpcw0KDQogIC0gaWY6DQog
ICAgICBwcm9wZXJ0aWVzOg0KICAgICAgICBjb21wYXRpYmxlOg0KICAgICAgICAgIGNvbnRhaW5z
Og0KICAgICAgICAgICAgY29uc3Q6IHJlbmVzYXMscjlhMDhnMDQ2LWNhbmZkDQogICAgdGhlbjog
e30NCiAgICBlbHNlOg0KICAgICAgaWY6DQogICAgICAgIHByb3BlcnRpZXM6DQogICAgICAgICAg
Y29tcGF0aWJsZToNCiAgICAgICAgICAgIGNvbnRhaW5zOg0KICAgICAgICAgICAgICBlbnVtOg0K
ICAgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwOGcwNDUtY2FuZmQNCiAgICAgICAgICAgICAg
ICAtIHJlbmVzYXMscjlhMDlnMDc3LWNhbmZkDQogICAgICAgICAgICAgICAgLSByZW5lc2FzLHJj
YXItZ2VuMy1jYW5mZA0KICAgICAgICAgICAgICAgIC0gcmVuZXNhcyxyemcybC1jYW5mZA0KICAg
ICAgdGhlbjoNCiAgICAgICAgcGF0dGVyblByb3BlcnRpZXM6DQogICAgICAgICAgIl5jaGFubmVs
WzItN10kIjogZmFsc2UNCg0KDQo+IA0KPiA+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAg
ICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgICBjb250YWluczoNCj4gPiArICAg
ICAgICAgICAgICBjb25zdDogcmVuZXNhcyxyOWEwOGcwNDYtY2FuZmQNCj4gPiAgICAgIHRoZW46
DQo+ID4gICAgICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICJeY2hhbm5lbFsy
LTddJCI6IGZhbHNlDQo+ID4gQEAgLTI5Miw2ICszMTAsNDYgQEAgYWxsT2Y6DQo+ID4gICAgICAg
IHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICJeY2hhbm5lbFs2LTddJCI6IGZhbHNl
DQo+ID4NCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAg
IGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAg
Y29uc3Q6IHJlbmVzYXMscjlhMDhnMDQ1LWNhbmZkDQo+ID4gKyAgICAgIG5vdDoNCj4gDQo+IExp
a2V3aXNlLg0KPiBUaGlzIG9uZSBjYW4gZWFzaWx5IGJlIHJlc3RydWN0dXJlZCBsaWtlDQo+IA0K
PiAgICAgaWY6IC4uLiByZW5lc2FzLHI5YTA4ZzA0Ni1jYW5mZA0KPiAgICAgICAgIC4uLg0KPiAg
ICAgZWxzZTogaWY6IC4uLiByZW5lc2FzLHI5YTA4ZzA0Ni1jYW5mZA0KPiAgICAgICAgIC4uLg0K
PiANCj4gdG8gaW1wcm92ZSByZWFkYWJpbGl0eS4NCg0KT2suDQoNCklmIHdlIGFyZSB0YWtpbmcg
c2VwYXJhdGUgY29tcGF0aWJsZSByb3V0ZSwgdGhlbiB0aGlzIGlzIG5vdCBuZWVkZWQ/Pw0KDQpD
aGVlcnMsDQpCaWp1DQo=
