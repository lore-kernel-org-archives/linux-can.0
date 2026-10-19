Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010032.outbound.protection.outlook.com [52.101.229.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D947AF6B;
	Mon, 19 Oct 2026 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394672; cv=fail; b=eX+F1fNGduw80tdA4zCqKkzG/DvHmfwRjb64zPpGo3eH5OJqNy4D0CxUbakke0wICN9DGyEkv5L7XV8yzRvneDnwiUrfe/ql6ho6MjQr+3JuwVxJBaWBWaBPDPf/Oaa2/Q1r+P/l9sNfgkAdI4Ti4hWcflJBvKaRmEZl+w8XHzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394672; c=relaxed/simple;
	bh=GX2g9fF1HnDdGvXpSFzN+Um+fQsR7rWreZMEyeE5/CI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sAqIBaF6lbgr3nmT93XEw5hk3YvXJBfXkuca+lRtcPlwI7wXAnpKT9icru7VttKP2d0zfoQkq0JvlC3tymoPKu/GwNedlqbRSI8rwlOvspVv4EmKqfVTe4L8auhDmOpkTMpeWyHNHinnGNGGsjETBcdPy2cEjPGs9XZYgMtJ1I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=N3p7LFdf; arc=fail smtp.client-ip=52.101.229.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="N3p7LFdf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu9XRb1b3kPDaAIgLds0YAB2QJK6Vsl7UmsJfzKoZS0fa5/9A07b2ASJ1v7pRiANq43lMt1yOgA+qBxn2PUo0SDlAp4ypfJn9AIi6ECDp3Z7f6ChKVjrCiAYAX5ItS0IZy57RxTDLmbNKFw30jhZZbsI0EiF4R5JhFCihLZwPbGkrGwmQ39C0fCeX4zbfpILtxnRgAUDJXOLgpVeLkFabZDz++ph8wuv00n6S6YzFYD/rrSto8Lv/Pas/7zhMiGkXIZKp91QWgqgbGFQu/QxCmw9LXfhmSrD1yI20bkm9iecRMyFhTVeB69YK9/kOflpuOzc4yYGJc4dZjHLzWQi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX2g9fF1HnDdGvXpSFzN+Um+fQsR7rWreZMEyeE5/CI=;
 b=Qt1J+abLnoAENWLJDrclb5UB0HhQc4LhIVUqOsQDx1C6GSJmcPnT/ufP7TrXoBj+V5gQ2txo1dXH4F1ZQuYhMGFD4Qb+Uphx1PWOA5qmBOXrHPYa1Egnf3gorIObrvMofycx+v5yfAJxyOt6MLOI3BQtdTtQ+qXro1d5lnWCQr65dhOyB88tZM1283nS3VqvxM6GiXbKzhwDezfJjkSAJ9UtGckBpBpA5KTGqgmpM0vkpIWsKVQ8EqX+JQNNCemwHErTLh7gKtPnWZpqJbNmyeg/fDGeUCRoHYLcvyFjsqTHn+EYwdfNRksiRsz61VBZvgXwdb10qFALww4zoIWheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX2g9fF1HnDdGvXpSFzN+Um+fQsR7rWreZMEyeE5/CI=;
 b=N3p7LFdfXmXX12FVMnXwC0Xmg6MWf5jM41yP9+7H+3CUoAKJvCQeTZ3MMcNY0VNIgXmkveScR2HQKDTvqrSHPRePbp8jr27kFs9AVWi7BaMMt0ey83YQ5sNF9+HMZq/SGK88H9NRnlCmxry5wU86TGZJChtZgUieo8jscO97js0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB6674.jpnprd01.prod.outlook.com (2603:1096:604:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 07:24:27 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Mon, 19 Oct 2026
 07:24:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Claudiu Beznea
	<claudiu.beznea+renesas@tuxon.dev>
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
Thread-Index: AQHdXXMSsMwpnwM8V0+/50zGaKzocLcEenrw
Date: Mon, 19 Oct 2026 07:24:26 +0000
Message-ID:
 <TY3PR01MB1134682A7E8AEDB860F02752D86982@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev>
 <20261016-elite-feathered-rook-5dcf2b-mkl@pengutronix.de>
In-Reply-To: <20261016-elite-feathered-rook-5dcf2b-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB6674:EE_
x-ms-office365-filtering-correlation-id: 6401d193-97b7-444e-d836-08df2db201f2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 8RCDKx5qWOnh/VSq3SNfbcSzyTp5zfXwckFQkk3FCI6oLH+2/WS+ANx+bafSyRy+BbD1+9xMKFju/WixpTYCTcoxSazi905m6+JLkU8JJ3lj/JyPOKoTfDX3CTpuzAzXhy9Y5dTFX/RztS2BcHdDYHIRGxXzmfCBDzRQymsW4yBcmISiUJjfX7O6kQyRxGr6/dzxDZDkpmM6LXLWGHnoA4cSt/QSdOrDlf/ZIKpsgK40Ec0oGgm8catUTrDtx+Be2ClQI8LQOM29lUJorvlmvivV7MKgtcpAKmo/INvawO8M0Z/Ulm/Hjw1Bd2J8sunIHp5vdE3AGP0RzPzc0c9s+gmlMu/RIRKW/++VVBUGgPSmXuvQTI7mBu/DbRaka3XI3YIEU2vQTbBHB1jdleR2lqBIO9id8+CwjsYPpFcNaBqNWEab2TY4EGr5dlUfsLfWt6A2D06YkLxsPGmM486kt+RCrv4IqMcxk2VV+YOFabiZR60+t+DspGwlmzKDkgcoZFr9L46ncLzl06lTShrSFXAsCkwGoekwp/dtOSgjzIV8pXgWiRrH4uWBvoi/tmwmdzIwVLuTmwg/3v/3PP96kiP+owvTUgB8UBzA60r62OL9WG6eYDBIP6pQsfO3+TRueOxFVQY8bO4xYOaraRgRU1agBvU2U2YM0XOrRHqYkjk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGJWc21HSE51Qk1KNTJESVIwbGFyRklSaEZ6VWw3Y0ZNQzdwZi8rQ1pKRlV4?=
 =?utf-8?B?ZklqeDdTWTZRQTc2YUxQSXNUbytHR3g4MHFac0FFR0E5YVZTKys5b0hYWUhl?=
 =?utf-8?B?cW9OQWU0M0ZSbE5SZGxuWkhPQktIdUo0cGlLekVxOFFHbWZ2Y244YjBCNXdy?=
 =?utf-8?B?bzZIWmVEMTM2UnBWS3Bua1A3SnNNcmJ0Z3E0bmhXQS9uVWlXRkNSNFJ3UWZa?=
 =?utf-8?B?U1I2dmJZRWd0S0U5enNUNGQ5ZTR2N0IyQmFtTUxKU2xZQk5ZdVlydzlPbTh2?=
 =?utf-8?B?TExqWjN3WHNwRFZYczRHcjZOTmlmUE5qVGt0elpEc29hbXpJc2IwL0hmUUZM?=
 =?utf-8?B?TTVZOFBDWlBhVW1zYnJXMlNwQzVuY0JDV0tSQWRWODhiTWlRcTcrTURpcjNI?=
 =?utf-8?B?RkExN2ZDOE5INVRoWTlZZnJySkdBWElwclBQMW01b0VCZVplK1V3dkcwNVZ1?=
 =?utf-8?B?ZXowYXdIdEF1WjBKaVVkWk0vbnlFR2xaTmlYdERWUVg3K2tuSzhoUTIxRHQx?=
 =?utf-8?B?UUsrZ05OMkE3TXhPSGdlbU1GT3VyT1gyY3UvZmFQLzFsa2tGS3RsR1p4alY5?=
 =?utf-8?B?a1h0YVlIcThmOElZRWVCR1JUT2VGa3RuUGpWVm1iLzUvQm9YaVZNYmplMldo?=
 =?utf-8?B?YjdBSDIwNXltdDNGNFppbG9Nd3VMNENLcjU4OWVGNEVzazl2b3dJayt0Yy9h?=
 =?utf-8?B?M3pHTzQ2azVLTk92RlBxenhKbWh5cTVpU3RIY29XSnlhMDZUeEpXWFNvcWpU?=
 =?utf-8?B?NnF0TjV3dThYeUhRRzFTdlJ3VFprVUtUOUZtV0lvY3VMOFZ1a1QzS3dUWG1C?=
 =?utf-8?B?ZE5vOFV3c0I2eS9KelVwVVQ5OVVZYkNLU0YxQWtrajYxVGcxVSt0TGJMUjg2?=
 =?utf-8?B?OFVKbzFKa3I4cU00eTlZVnFhazdZai9LbTB2OG95QkRzR0p4cy9IdlR3UnR5?=
 =?utf-8?B?VS9zQWN5RXhHRTc1QXZBTW1CWHdraEdZMTNhYzNoL2hhTFpZanFPVjhwdkI5?=
 =?utf-8?B?NEk0THdRMnZlUUQ4MVVsRnkvR05wMUFCbTA0eThkZDZqU25EdnRvM0ltYWVI?=
 =?utf-8?B?a1JNME9jekUrUUZDbGZ2SzdldXZZSUNCWEZvb3ZnTGxPcFhweEtJejFsWFB1?=
 =?utf-8?B?U3JkdmZxUzlNVUlYVWdjNFJ4S21tN1UzdzZBMkp6QmE2K2F5QlFVR0JYQmxu?=
 =?utf-8?B?dlVzSHVtVzdiV3hmdmtRUy84MTA2bzlPYVY5Q0orWHcvczFTUmdTUWVndCtm?=
 =?utf-8?B?cTJqd1VncTNuRVpSbDZBUXhyMC83RGZOaG04Qjg2ZU1oWUpIYURESkRYM3Ns?=
 =?utf-8?B?Y1E5S3BHSmVreUtTUHpuRnlTcDBiNVpzdi9yVlNiVXlOeERsR2k0UERjLzh1?=
 =?utf-8?B?Nk1nUWx2VWp2VktCajNUNkppQ3JqRnBEamlpRnpCM08wcFFUS2lPeTEwNnBu?=
 =?utf-8?B?U1pFZlR6a0pGaXplaXQzZWwvOW91ZzlyYy9GMkRGYkdTL3ZZZmMwS0dqdkhV?=
 =?utf-8?B?RWVtNE02bGtvODV1QVVoOC9PZ3U2YXloclZKdFJrN3JnVktnM2ErSTRaWXhk?=
 =?utf-8?B?SHdCeEl5WHpWYUNQNy9sZlk1dzJkZmkxRHFDSk9UQVFhc3d1aWtiRnhSN3ZP?=
 =?utf-8?B?YTh2Mi82cC9pY0dReTdBbVJ0VFVKdEhwRitaUlhHTU1yT2tuaUNBY2FxT0J5?=
 =?utf-8?B?bkRYSWFHbVBPTWRQaTgrenBuUUdMUHJIRmcvcTJQZklIWHFsMVhNaFllYzY0?=
 =?utf-8?B?U2g3b0Z2MDh5VHp1dVJiQVZGWU1LZk16cTVESzlFeUpKNFZKYXpyNHF3ZERq?=
 =?utf-8?B?SkhFU1FsdUZzeGdGcWh3S252VTkxOE1ybDZWU2pYY3RoTUVidjdiSkNpVGRu?=
 =?utf-8?B?TzBaRGNLYzFyUW5XQy95eDM4VVZGYmNDdXhjWHAxY2U4bWpaSVE1RkVCM0Ns?=
 =?utf-8?B?a3lkOW15T0F4UHJTNDQ2Q2NmcXl0dmpYcUpXMjNrLzZ1VVZvZmFiQ1RBMGZ3?=
 =?utf-8?B?Yk82dWpBQVR5UVNUMndKbG1CYmI0UnQySjRGbU1keS9FWksyaEwwelIvdFFm?=
 =?utf-8?B?MlRGUjErYUMrVjZQNG5WRmpKL2xoSFdkcGl6WFlQalBPT0JGWGJNVktSZFZa?=
 =?utf-8?B?aC93SHh1SnpTRlRQWUpZZzU0NXlCUnJCQmxoeXBVZlFYVFQ2MTFEMVZCdkZ5?=
 =?utf-8?B?V3ZGUmRET2liTHV3QXlhdE9veTgyRTFxbWRwSEtldjBhRG8xb2o3SUhCRXk5?=
 =?utf-8?B?SFYwbU93VkZEVVp4WDFQU2lCWlNRL0plQjhoZ2pjekM5R2phVzZUNFFCT0dw?=
 =?utf-8?B?THZRbjFQa2xtYnoxZGYvYTUwcXBUQndCcUlMSEVrb0haemQvZG1Bdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6401d193-97b7-444e-d836-08df2db201f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 07:24:26.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqygLEcncwLgHtyw0Hpf2R3XO8sgKRq2t3i+Qb4g1OOF+5ov3lYSmGCJTcwnWlR1I+YeppuqBZxAjc1yZMMc/hskSbYJAyoV/XG0/kmQi8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6674

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJj
IEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAxNiBPY3RvYmVyIDIw
MjYgMTQ6MzQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzddIGR0LWJpbmRpbmdzOiBjYW46
IHJlbmVzYXMscmNhci1jYW5mZDogRG9jdW1lbnQgUlovRzNTIFNvQw0KPiANCj4gT24gMDIuMDku
MjAyNiAxNzoxNTozOCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+ID4gRnJvbTogQ2xhdWRpdSBC
ZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gVGhlIENB
TiBGRCBjb250cm9sbGVyIGZvdW5kIG9uIHRoZSBSZW5lc2FzIFJaL0czUyBTb0MgaXMgbGFyZ2Vs
eQ0KPiA+IGNvbXBhdGlibGUgd2l0aCB0aGUgdmFyaWFudCBwcmVzZW50IG9uIHRoZSBSWi9HM0Ug
U29DLiBUaGUgbWFpbiBkaWZmZXJlbmNlcyBhcmU6DQo+ID4gLSB0aGUgUlovRzNTIHByb3ZpZGVz
IG9ubHkgdHdvIENBTiBGRCBjaGFubmVscw0KPiA+IC0gdGhlIFJaL0czUyBzdXBwb3J0cyBvbmx5
IENBTiBGRCBvcGVyYXRpb247IHRoZSBDaGFubmVsIG4gQ0FOIEZEDQo+ID4gICBDb25maWd1cmF0
aW9uIFJlZ2lzdGVyIGRvZXMgbm90IGltcGxlbWVudCB0aGUgYml0cyB1c2VkIHRvIHNlbGVjdA0K
PiA+ICAgY2xhc3NpY2FsIENBTi1vbmx5IG1vZGUgKGJpdCAzMCkgb3IgQ0FOIEZELW9ubHkgbW9k
ZSAoYml0IDI4KTsNCj4gPiAgIGNvbnNlcXVlbnRseSwgYml0IDMxIChDQU4gRkQgRnJhbWUgRGlz
dGluY3Rpb24gRW5hYmxlKSBvZiB0aGUgc2FtZQ0KPiA+ICAgcmVnaXN0ZXIgaXMgYWxzbyBub3Qg
aW1wbGVtZW50ZWQNCj4gPiAtIHNvbWUgYml0cyBpbiBzZXZlcmFsIHJlZ2lzdGVycyAobWFpbmx5
IHJlc2VydmVkIG9yIHN0YXR1cyBiaXRzKSBhcmUNCj4gPiAgIHJlYWQtd3JpdGUgb24gdGhlIFJa
L0czUyBidXQgcmVhZC1vbmx5IG9uIHRoZSBSWi9HM0U7IHRoZWlyIGJlaGF2aW9yIGlzDQo+ID4g
ICBvdGhlcndpc2UgaWRlbnRpY2FsOiB0aGUgYml0cyByZWFkIGJhY2sgYXMgMCBvbiBib3RoIFNv
Q3MgYW5kIHNvZnR3YXJlDQo+ID4gICBpcyBhbGxvd2VkIHRvIHdyaXRlIG9ubHkgMCB0byB0aGVt
IG9uIHRoZSBSWi9HM1MNCj4gPiAtIHRoZSBSWi9HM1MgcHJvdmlkZXMgMjU2IGFjY2VwdGFuY2Ug
ZmlsdGVycywgY29tcGFyZWQgdG8gNzY4IG9uIHRoZQ0KPiA+ICAgUlovRzNFDQo+ID4gLSB0aGUg
UlovRzNTIGNhbiB1c2UgUENMSyBjbG9jayBhcyB0aGUgQ0FOIEZEIGNsb2NrIHNvdXJjZSB0aHJv
dWdoIGFuDQo+ID4gICBpbnRlcm5hbCBjbG9jayBkaXZpZGVyLCB3aGlsZSBhbHNvIHN1cHBvcnRp
bmcgYW4gZXh0ZXJuYWwgQ0FOIEZEIGNsb2NrDQo+ID4gICBzb3VyY2UNCj4gPg0KPiA+IFNpbmNl
Og0KPiA+IC0gdGhlIFNvQyBjbG9jayBnZW5lcmF0b3IgcHJvdmlkZXMgdG8gdGhlIENBTiBJUCBv
bmx5IHRoZSBwZXJpcGhlcmFsIGFuZA0KPiA+ICAgdGhlIFJBTSBjbG9ja3MNCj4gPiAtIHdoZW4g
c291cmNlZCBmcm9tIHRoZSBwZXJpcGhlcmFsIGNsb2NrLCB0aGUgQ0FOLUZEIGNsb2NrIGlzIG9i
dGFpbmVkDQo+ID4gICBpbnNpZGUgdGhlIElQIGl0c2VsZiBieSBkaXZpZGluZyB0aGUgcGVyaXBo
ZXJhbCBjbG9jaw0KPiA+IC0gdGhlIGFzc2lnbmVkLWNsb2NrcyBhbmQgYXNzaWduZWQtY2xvY2st
cmF0ZXMgcHJvcGVydGllcyBhcmUgc3BlY2lmaWMgdG8NCj4gPiAgIHRoZSBDQU4tRkQgY2xvY2sN
Cj4gPiB0aGUgYXNzaWduZWQtY2xvY2tzIGFuZCBhc3NpZ25lZC1jbG9jay1yYXRlcyBwcm9wZXJ0
aWVzIHdlcmUgZHJvcHBlZA0KPiA+IGZyb20gdGhlIHJlcXVpcmVkIHByb3BlcnRpZXMgbGlzdCBv
ZiB0aGUgUmVuZXNhcyBSWi9HM1MgU29DLg0KPiA+DQo+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9y
IHRoZSBSZW5lc2FzIFJaL0czUyBTb0MuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJp
bmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVy
aG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiB0aGUg
bmV0ZGV2IHJldmlldyBib3QgaGFzIGZvdW5kIGEgbml0cGljaywgaXQncyBhYm91dCB0aGUgY29t
bWVudCBpbiAicmNhcl9jYW5mZC5jIi4gQ2FuIHlvdSBmaXggaXQsIGlmDQo+IHlvdSByZS1zcGlu
IHRoZSBzZXJpZXMuDQo+IA0KPiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiBwdy1ib3Q6IGNyDQo+
IA0KPiAtLS0gUGF0Y2ggWzExXTogW1BBVENIIG5ldC1uZXh0IDExLzM3XSBkdC1iaW5kaW5nczog
Y2FuOiByZW5lc2FzLHJjYXItY2FuZmQ6IERvY3VtZW50IFJaL0czUyBTb0MgLS0tDQo+IGNvbW1p
dCA2OWI0ZTM3ZDE4ZTUyMjllMWM4MDBiNDVhNWRmMDYxYWY4YTk4ZWI5DQo+IEF1dGhvcjogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiANCj4gZHQt
YmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOiBEb2N1bWVudCBSWi9HM1MgU29DDQo+
IA0KPiBUaGlzIGFkZHMgdGhlIHJlbmVzYXMscjlhMDhnMDQ1LWNhbmZkIGNvbXBhdGlibGUgZm9y
IHRoZSBSWi9HM1MgQ0FOIEZEIGNvbnRyb2xsZXIuIEl0IGFkZHMgdGhlIGNvbXBhdGlibGUNCj4g
dG8gdGhlIGV4aXN0aW5nIGNvbmRpdGlvbmFsIGJsb2Nrcy4gSXQgYWxzbyBmb3JiaWRzIHJlbmVz
YXMsbm8tY2FuLWZkIGFuZCByZW5lc2FzLGZkLW9ubHkgb24gUlovRzNTLCBhbmQNCj4gbWFrZXMg
YXNzaWduZWQtY2xvY2tzIGFuZCBhc3NpZ25lZC1jbG9jay1yYXRlcyByZXF1aXJlZCBvbmx5IGZv
ciB0aGUgb3RoZXIgU29Dcy4NCj4gDQo+IExpbms6IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8y
MDI2MDkwMjE0MTU0NC41NjU3NjMtMi1jbGF1ZGl1LmJlem5lYStyZW5lc2FzQHR1eG9uLmRldg0K
PiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbWwNCj4gPiBp
bmRleCBiOWQ5ZGQ3YTc5NjcuLmJiYWFlZjhmNDI4MiAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5m
ZC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9j
YW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbQ0KPiA+ICsrKyBsDQo+IA0KPiBbIC4uLiBdDQo+IA0K
PiA+IEBAIC0zNTAsNiArMzUyLDIwIEBAIGFsbE9mOg0KPiA+ICAgICAgICBwcm9wZXJ0aWVzOg0K
PiA+ICAgICAgICAgIHJlc2V0LW5hbWVzOiBmYWxzZQ0KPiA+DQo+ID4gKyAgLSBpZjoNCj4gPiAr
ICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAg
ICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiByZW5lc2FzLHI5YTA4ZzA0NS1j
YW5mZA0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAg
ICByZW5lc2FzLG5vLWNhbi1mZDogZmFsc2UNCj4gDQo+IERpc2NvdmVyZWQgYnk6IG9wdXMtNS01
IMK3IE1pc3NlZCBieTogZmFibGUtNS0xLCBncHQtNi1hc3RyYSwgc2FzaGlrby1nZW1pbmkgwrcg
Q29uZmlybWVkIGJ5OiBmYWJsZS01LTENCj4gVGhpcyBpc24ndCBhIGJ1ZywgYnV0IHNob3VsZCB0
aGUgcmVuZXNhcyxuby1jYW4tZmQgZGVzY3JpcHRpb24gYmUgdXBkYXRlZCB0byBtYXRjaCB0aGlz
IG5ldyBjb25zdHJhaW50Pw0KPiANCj4gVGhlIHByb3BlcnR5IGRlc2NyaXB0aW9uIGluIHRoZSBz
YW1lIGJpbmRpbmcgc3RpbGwgc2F5cyB0aGF0IGV2ZXJ5IGNvbnRyb2xsZXIgY2FuIHJ1biBpbiBD
bGFzc2ljYWwgQ0FODQo+IG1vZGU6DQo+IA0KPiAgIHJlbmVzYXMsbm8tY2FuLWZkOg0KPiAgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiAgICAgZGVzY3Jp
cHRpb246DQo+ICAgICAgIFRoZSBjb250cm9sbGVyIGNhbiBvcGVyYXRlIGluIGVpdGhlciBDQU4t
RkQgbW9kZSAoZGVmYXVsdCkgb3IgRkQtT25seQ0KPiAgICAgICBtb2RlIChSWi97RzJMLEczRX0g
YW5kIFItQ2FyIEdlbjQpIG9yIENsYXNzaWNhbCBDQU4gbW9kZS4gU3BlY2lmeSB0aGlzDQo+ICAg
ICAgIHByb3BlcnR5IHRvIHB1dCB0aGUgY29udHJvbGxlciBpbiBDbGFzc2ljYWwgQ0FOIG1vZGUu
DQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2ggdGhlIHByb3BlcnR5IGlzIGZvcmJpZGRlbiBmb3IgcmVu
ZXNhcyxyOWEwOGcwNDUtY2FuZmQsIGJlY2F1c2UgUlovRzNTIGRvZXMgbm90IGhhdmUgdGhlDQo+
IG1vZGUgc2VsZWN0IGJpdHMuDQo+IA0KPiBUaGUgaGVhZGVyIGNvbW1lbnQgaW4gZHJpdmVycy9u
ZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jIHNheXMgdGhlIHNhbWUNCj4gdGhpbmc6DQo+IA0KPiAg
KiBUbyBzd2l0Y2ggdGhlIGNvbnRyb2xsZXIgdG8gQ2xhc3NpY2FsIENBTiAoQ0FOIDIuMCkgb25s
eSBtb2RlLCBhZGQNCj4gICogInJlbmVzYXMsbm8tY2FuLWZkIiBvcHRpb25hbCBwcm9wZXJ0eSB0
byB0aGUgZGV2aWNlIHRyZWUgbm9kZS4gQSBoL3cgcmVzZXQgaXMNCj4gICogYWxzbyByZXF1aXJl
ZCB0byBzd2l0Y2ggbW9kZXMuDQo+IA0KPiBOZWl0aGVyIHRleHQgaXMgY2hhbmdlZCBsYXRlciBp
biB0aGUgc2VyaWVzLiBCb3RoIG5vdyBjb250cmFkaWN0IHRoZSBzY2hlbWEgZm9yIFJaL0czUywg
YW5kIGZvciBSWi9HM0wNCj4gb25jZSBpdCBpcyBhZGRlZCB0aGUgc2FtZSB3YXkuDQo+IA0KPiBD
b3VsZCB0aGUgZGVzY3JpcHRpb24gZXhjbHVkZSB0aGUgU29DcyB0aGF0IG9ubHkgc3VwcG9ydCBD
QU4gRkQgbW9kZT8NCg0KDQpEbyB5b3UgcGxhbiB0byB1cGRhdGUgZGVzY3JpcHRpb24gb2YgcmVu
ZXNhcyxuby1jYW5mZCBpbiBiaW5kaW5ncy9kcml2ZXIgZXhlbXB0aW5nIENsYXNzaWNhbCBDQU4g
bW9kZQ0KZm9yIFJaL0czUz8gT3IgZG8geW91IHdhbnQgbWUgdG8gdXBkYXRlPw0KDQpQbGVhc2Ug
bGV0IG1lIGtub3cuDQoNCkNoZWVycywNCkJpanUNCg==
