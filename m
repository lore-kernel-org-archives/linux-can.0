Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011005.outbound.protection.outlook.com [40.107.74.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAA492E2E;
	Mon, 19 Oct 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398946; cv=fail; b=crq69mri51NhunV9c7Om6tbUVvi+eYg2mdYqO3uI6WC71kvvtO8C/NI7PAb20cYkt522j/8DIb7payJN8c1TLfRxklzwulwPYSJrp6pzBdyXnkfitNZr5UmRL/SrG6XWjLDytAh5ZSp5EZp/56aGr7aUr7slByBk1nX1tzwuvVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398946; c=relaxed/simple;
	bh=G6+IgdWTlWUiCBp+HfpAg5M6P6RD5fMcX4ySaCtr3zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lx6wSQqM79MNpw+e/5x6JYCdcpqTjWP5fUD5fzQLEmk9Od8XpDCrPNONQ1qUsVMsGhmWdkxfujPd0NmjBRNQUVAQ4ZyVstJqVuVPEldb4VWTrhmzL84gdCgSNv+7e6P8kgenztKAzHHFMACOq5XYwYthTypabjd6ftqVHmMhLR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Pa8eBPoW; arc=fail smtp.client-ip=40.107.74.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Pa8eBPoW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2molG7jkIZZ7endC8ORW59Ca1YSJNZDgBldax3OYS8ejaGAU7Oax4rsDhOPmqLN8HpsXyg6bElwU8YsL75B/dYSIdxvs29ofrSwhv8kRSNa2T0pZ+Zf5ltuthcs4jdE3w1wgIMW0aRpdeVz9JLDB+BadO4sd2a/MnQCHqPuHsTMGGJP3cdZv9s7yFL/00UP5g9TZAl1ploKo2BOkQ8tKRYBXvaXB7LaQFgHzDqDwkD445fteZ0a5BdM3M8lhbFCsiqTglgp0us4GYZuuSMEE7ifEXWT3N2rcgJ9AcE0HQ1x2FWOYfswjzjukG1wUHx9QOpa8U9yoIEtm//t1x+51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6+IgdWTlWUiCBp+HfpAg5M6P6RD5fMcX4ySaCtr3zw=;
 b=ec1scmJvwPhvN//rPdNXJc6mVGz65u8Or7pk2AZcOiYy9oiM1v4nMCIqPOyW4ke78luXMircafTPhaf82PwEyqF4uRh5GxrjcO75QsCI6zAdtmhm8ISx9HoqiKdxzZdJndEHKhfPHqzm4NYu2IK3Ujb6knFggOSPeuRbj/ASfRRb2yvjzt63zzVmJQTUe53II6S7GBmO6FVYAqbNMFmIfOdE/OIy5pH0qbgwiYKrX2z4QwxNO50hfPVYnHyCnPWYwX2/OK+O+Cx9BWerx26/+WSvzFHlioOVeogxYpoWy5rUiYU+DloVQlQd+ly3mNMoxCaiwqKz0fPz4yt+B3PQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6+IgdWTlWUiCBp+HfpAg5M6P6RD5fMcX4ySaCtr3zw=;
 b=Pa8eBPoWjZ9T5UL15wg/hiKBO2n4dqRlF9DUS714nAzAIDQViE6r0miK76VlOoTZMJ/oPnzCn6egOdMczcznmoYGkXrQxDwnYb4OmWLZuPoyoYPbd/hnmljCHuEd7oHycTouBgaxS5o2f8wmLaf8edOSyg5y/SdWvOLtmbK9k2k=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB9786.jpnprd01.prod.outlook.com (2603:1096:604:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:35:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Mon, 19 Oct 2026
 08:35:41 +0000
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
Thread-Index:
 AQHdUXqWGJYcQwxreka0VFtI2IFYOLcAS3kAgAABusCAAS3QgIAAAZIAgACbvoCAAo40kA==
Date: Mon, 19 Oct 2026 08:35:41 +0000
Message-ID:
 <TY3PR01MB11346AD7649DBAA2E9E065FFE86982@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-2-biju.das.jz@bp.renesas.com>
 <20261016-rebel-ostrich-from-vega-f759c8-mkl@pengutronix.de>
 <TY3PR01MB113465234171180FFB5F1B6FD869B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <c624d8d5-3362-458a-96db-0457b25cad53@oss.qualcomm.com>
 <TY3PR01MB11346ACB35A041309BCFA744F869A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ce03d3ce-da47-4435-8c98-d86b2816c5c0@oss.qualcomm.com>
In-Reply-To: <ce03d3ce-da47-4435-8c98-d86b2816c5c0@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB9786:EE_
x-ms-office365-filtering-correlation-id: 0d0d7f2e-aa36-400a-7ad3-08df2dbbf5cf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 jhKpaMHsSkaQy5vtQV1MTaAwrLdMQLFcuhTRLRpsHv+rc/1W/GMYfP8/nrYeYLkaAkbrwKwPFH8/AdammMGbhlPgqrXoivxj6Fw+80C1mUNT8wlC4O8+KrF4rJjBzh3D+iuygfg/uDyLHpjF2g7laF64aQhB/i8inTPaI0xgdXBNjolVa3BZI3Sdr/T2pHdj4Nd0e6Iiwr29PvsbNE0bQFW5aOYh+zpbg5iq1mPXRFg3X5ojvKtC3BRmCogucv6ySaFmmSM3S4O7laEM4tNU0aYrWV86nHZFJMj2xR0LuSVoY5dmzCdcKuJUg4/WSQXMlDl1jEOpixttNxMyeaGkvzFyYy+3omEjCiIBTpE7IafOout6AuDXxaz/VzCXeHua1RjuaNRs6yDRQ3tApE0QvSa0+3SxVAZRAbOk0P8OKED7dXPmeguuvDBasnZlp4ZbG4iVXetNHmOa0e/s4mOSCOzWoVLiAn2xP18xzFGFCOFOR+Gok5upXJyP2wPmKsp7WBJzVUgmKz7Qey8+2jJA8NMaKpRczGgC+paW90IHjUepukgepdA9zLoo4tph3cYqb+uuxmrBFa8cCW0sTNstQ7IceyYnr7FJBTHFgctX0Q+/PLknHbdxWtzosv4MCQ/kK0ZtMILbstIa8c0p9GHanMUgi5p6nnoBODGYPWcgLqFR+XcAqEJtQNECobktyea0bmTs3P3D3eAV7dZGskULYqrOSy4WI9nRq12yqHE662o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUV6YW9LYU1BQ3ZrSnVSQ3g0ZXhPL2xQRE5lK0krcFJmN0NtRURwMTJBZ2lt?=
 =?utf-8?B?VU51ZE1XSFB2M3lGdG16R1QvQkJTRlBuTmt6RzY2Y0NnUFNJRTAyem9LZ1pZ?=
 =?utf-8?B?VVpZWnB3UGlEUHdldkdyWm5kRlM0Sm9tb1IrSSt3cFNncEhqQU8wRkxuaGRl?=
 =?utf-8?B?T2JHdUhkTXJDVXhxTUVrcGp5eFNxUGZrVk1hMXBySEdoMy8vYnh5ci9Ld3cr?=
 =?utf-8?B?T0pqMnEyMEJHbTVoR0VZNkVRVWh1cDdKQzBlU3prR3Z1d0JJYmFvL0ZKOFV6?=
 =?utf-8?B?NTczZkNZVlZQakNOYmRaSUtwam52bytCZlRMbkdpUGl2NmRYdURxaXNxeDlz?=
 =?utf-8?B?VytHcjNKSVlpUnBNM1VKVzQxTXV6VHhxNk0vdmJVMGRXaTA2dUdydFhkSEY4?=
 =?utf-8?B?azFDY1dKTzNJbTlRYWsrVzhBTHRZelFkVUZPdUE5ZG5CaUpQM2ZvR09haVVj?=
 =?utf-8?B?TldxR0hscmV4alFKd1NMek5jL0p4SmVXZUlqdis4SnpMd3I1ZFpHZmNDZEZl?=
 =?utf-8?B?cFA4akJCenZvaE1acFdWQ2pMU1M3TER1U2lPb0ZreXRyeC90MGc1c0oyZm80?=
 =?utf-8?B?M0tIUmw0YW5EbkdMKzdqaHpoS1l0b2FhdGFoN0pGdkhuNEtTL21CWHE5NDBn?=
 =?utf-8?B?Uk5uOC9NYzI5SmppZjNDTHdZODhqZnV1NmxIUHJqZUd5K2VoNG56dlpkS0M1?=
 =?utf-8?B?dXE2RUR5QzVCMlBSRi8zR3Iyd3d0RHVQYTQrMGtxTTIra3dJSDJtVlFlZmh0?=
 =?utf-8?B?VVRRM0dzZG5VdDBJL1F0RHhHRGEwNFh1dS95TlNIbU93OFZIejlCMHZ1ZXdG?=
 =?utf-8?B?bjA3bGR5MFVzdzR3NHUzdzB4eWZWdk5yTjFuek1zZnpGRmlnMlhKMHczQTl2?=
 =?utf-8?B?alZ6alczeUVFV084Q1dQeDBhdGNBMzZNSzBmSWpFa2phTS9STHpGY2xiTSsr?=
 =?utf-8?B?c1J3ZjNla3g3NXgwQi9LZ1VxWURmTTF1d0ZJWElydHk2Y1ZiUS9lMTMvaFV2?=
 =?utf-8?B?czUyemZ0S0dxYlI4c25mYWRoMHZmc2VEMGorZmliZk5rZkd1L1F5aVpJWmxQ?=
 =?utf-8?B?L3Z6aHcydW1xNnk5bVpRTFBQakE2YUs2THlHbGtiaUVqQm1YWWdObXQyRyt3?=
 =?utf-8?B?NVI5VlNhaGFRRDUrTElrZmtYMWdnaXpZb2JoWTRHY3hDV1psdlEwc1FFWVVj?=
 =?utf-8?B?KzJzd2M0elUwRGFKdHZmQVgrV2Q4TFBxQ090T2RYaXA5bVhZTW5hRFRBNnNB?=
 =?utf-8?B?ckw1Y0VycGdJWGpEazJ6eFpWWktNMnNWdHd1Z1VrQURZMHo4TlAzMHdEcGha?=
 =?utf-8?B?ZDF5TTA0L0RjTlpQcGZPdVBkZ2FXK2M5aVJKY0phYmRPT3JpSE54ajE5am85?=
 =?utf-8?B?Vk91UnVua0FlR2hkdWl4MEdtZlczRlEyVGdmMXJPb0ttNm9zcFRoYkw3Vmk0?=
 =?utf-8?B?eDRsMXcvQ2dYMDR4OUZ0c0E3VnlodEw4eVlVOEg4RTQ2ekdYTTZnRmZ5YWs5?=
 =?utf-8?B?Z0IyWXZVMzRvSmFqVmVIWWJOK3lrNG1WdVcrS0lLc0gycDZsQlgyaHVNb1hy?=
 =?utf-8?B?Zkt5THpYN004RUswVytKZGxPNkxzWWFVVi9ZNmlkOUtqZVVHMnlmUDg4OEh3?=
 =?utf-8?B?cEpTNk1TeDd6bHJqbVVlV3RsYnZ2a3A3UTgzKzEzYjJ2eEl5YUdwSG1yWUQv?=
 =?utf-8?B?SGNxNVBpRGhNcVZ2K3FiUmpuRkFuRE5ta0ZzcEpIdy95UStyMmlucm9vbHpl?=
 =?utf-8?B?K3l0Tks0TmZlTENiT2lEZVBXYldNOHJGODlWUTBibWZXelhSK1Bmb2JqZG5T?=
 =?utf-8?B?bENIbll1dEViOWM5TW5US293YTVHZmJCUHU1RnpQWmVWbU9yMG5zNGZUWGQ4?=
 =?utf-8?B?cUpaYkdGUjVtcndyekEzZjAwQVNIUjRCRGQraUNFWk5PRXM4WW9kWk5BdFpV?=
 =?utf-8?B?c2RBQXREcHp1dElFR3VFV0RPdXJ3TmhjM0lqS1lDVUljc1BHdVIwYTdkczFH?=
 =?utf-8?B?YS9seHJEQUp4VUlPWHN4SklzZzhZYUJsK2Q3VU5RREpSeXFQK2g0bG51WkJs?=
 =?utf-8?B?TFFzZVA3QlFScWx1MzlpVEhCdG56T1ZidzVvenhvcXA5cGlvOWN4MzE1cHNG?=
 =?utf-8?B?bWhrRDNsR2xnQjI0OGtzS05PUEs3WkExZWE3TkRXNU9HZkxYbnlMV25yZ2k1?=
 =?utf-8?B?b1FuYzB1YzVyUmo5ZmlURnppZFczMXdTWDR1U3NHVXlOYXdha0JyaG8yNGxl?=
 =?utf-8?B?TUdYWVVOcHdiSlNtV0FScFRQa3lqM3JPNUlvS3llZWlBUkJZZ0VxS2xVYzF2?=
 =?utf-8?B?VHJmZldxWVNjVHdOako4UkFPTTNUanJ4cnNKNHJjSGcrM1c4STVZQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0d7f2e-aa36-400a-7ad3-08df2dbbf5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 08:35:41.5849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OL7oxIAmBr5ph3v7GBoC8KOfmT83y3jhfM9gJa/+KyQK9NKecHX/fzhSnrXmwcQTWzzn9/ogFhnDjXtlSVY/qaixg+gbjfisC5fbYirOhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9786

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4N
Cj4gU2VudDogMTcgT2N0b2JlciAyMDI2IDE4OjM0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQg
MS8zXSBkdC1iaW5kaW5nczogY2FuOiByZW5lc2FzLHJjYXItY2FuZmQ6IERvY3VtZW50IFJaL0cz
TCBTb0MNCj4gDQo+IE9uIDE3LzEwLzIwMjYgMTA6MjMsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEkg
d2lsbCByZXN0b3JlIG1heEl0ZW1zIGluIEludGVycnVwdHMvaW50ZXJydXB0LW5hbWVzIGluIHRo
ZSBuZXh0IHZlcnNpb24uDQo+IA0KPiBZZXANCj4gDQo+ID4NCj4gPj4NCj4gPj4gV2hhdCBpcyB0
aGUgdXBwZXIgY2FwIG9uIGludGVycnVwdHM/DQo+ID4NCj4gPiAyMC4NCj4gDQo+IFRoZW4geW91
IG5lZWQgdG8gc2V0IHNwZWNpZmljIHVwcGVyL2xvd2VyIGJvdW5kLCBzaW5jZSB5b3UgaGF2ZSBs
ZXNzIHRoYW4gdGhhdA0KDQpPSy4gQWdyZWVkLg0KDQpDaGVlcnMsDQpCaWp1DQo=
