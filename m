Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010034.outbound.protection.outlook.com [52.101.228.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D425228D;
	Tue, 29 Sep 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691972; cv=fail; b=rrYxkMNT+iTan19aZ32GFwhGo0LfnMhjIzFzTvbK3oy9rH945nCOcnlbZFo4cJvhTPl5VnqfMF6Jwqij94naneItuUd8bLetg+H7xYFNcciNAD6K9kBb8ZcUbtW8ZrPfS2+BznJ9bPeNim4qA/I6dUyA525oVDVtzBOFbTA6KZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691972; c=relaxed/simple;
	bh=eLqS+RxAfFbukeN6UzgQZMA7azI0mvLb70lMRLpThpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWDKhXHNh1kxJlPct5ggXdbn5mLfgLfgGuWynYtNGptd5ec1cfO9VMOI48R7+bGgbXf/k92JACHvzl90Q1Y/gz7l3dmEZ182G+2z+fM2ApyVWTH4nG3hWh5U3vXzqY5C81xjphX2h7NPkGBNLrqZOV9Gy2o+yYL+h/K17mYqmk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kPn0jOjX; arc=fail smtp.client-ip=52.101.228.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kPn0jOjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDU/oGKBqQL0wzlxzxsvkgSjhPVAqpQsLuyiWuodaXcZOTZDDOEZnNqQbjGkRg3l+wdt6oPdtnQVf6xIjRDrLOnMyLx5nU/JOSh1wxDEWjqqMaJ5n36ljaM+F8e+L8p0RWd7E1kIo0YZWL6cOZDLjQaXCKCLxcR0de6aA/+jBRgPOcEI6KHuwFSbbKGQwPYjQyysMB5FmNqdXhcNnkz161pEb98nsJqI3vPzOO3OuGleQ6QXXMr6HCl+7x6mUo5qivmal8IFdxMduFrXLexCx2nvmwFexIVWEc0gSVuHGhgIDpLo6GeIcNw/ERytONAO3eQXPF74mj5hE2s9Qq2AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLqS+RxAfFbukeN6UzgQZMA7azI0mvLb70lMRLpThpc=;
 b=e8B6E1WtDzzW8F/YubEMzMOM/XZT7ZGBrR11ToSErkLoSr0XCgOI3ScIOJX1fjE+viQylO9KRFRZ6tZf5ZzrOyoRmOBbnOIopO1N4f2RUg2N2saEsST4mkCFJ3yhU9kkmtIGWJlE4Iz9iqCAv4CPAPl0yaaiumtuvcQrh5Hz+G3D7ALaxgrk1ql3S6uj7KV38A0v65A6XaLHDFK0c4QjPGvDoktlIqFzg5GhzA2WdRz5i9C9zlFdxoBCg+f7kHojVfi483Pbh/GVDZz0qfRk95ma+dIgSWRQXysXpjuaZ0YA0t4pchQl4q0wfkxY3KuCF7VJ5v3gF8wJRp3xS3pyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLqS+RxAfFbukeN6UzgQZMA7azI0mvLb70lMRLpThpc=;
 b=kPn0jOjXE41iYpb5uudUFbemfntcKN01WOaQUoEK6LY9qeniQM3h/ax3hqp4Lya5L9Zmz3ymwluHJ8HptO5WX1LedmwPXhScjBWid0+7fycOWnA2Jd5FU5PhscGAaC+M/BG3J/t1oFHOtZHnbgvaGbVabA4DtazMQ9Ag+hh8fvk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB14117.jpnprd01.prod.outlook.com (2603:1096:405:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 14:26:06 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 14:25:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 0/3] Add support for Renesas RZ/G3L CANFD
Thread-Topic: [PATCH v3 0/3] Add support for Renesas RZ/G3L CANFD
Thread-Index: AQHdTMbpeDO64SCKIU6wjmZln5mk77blosIAgAAAN2A=
Date: Tue, 29 Sep 2026 14:25:49 +0000
Message-ID:
 <TY3PR01MB113464CEBA3FBB41959D6C84F868C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
 <20260929-friendly-magic-grasshopper-1c11ac-mkl@pengutronix.de>
In-Reply-To: <20260929-friendly-magic-grasshopper-1c11ac-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB14117:EE_
x-ms-office365-filtering-correlation-id: e599657f-d98a-47d7-0769-08df1e358f17
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 +K51bpzeQYo98W5MjZBY8xrEzYzaQvx9h4exRQNMrvTsGor9XY45vhiKHF2NjjV944nd5SzcAEcz/jLTJ80/h6Zd94mbYrGXxHybAQhiHPD1iisChZvaI4AbUYTqHNl4IAAJvvdAtd8c/JlkuvqiKzRUgnWpBW/xRvOLOki60unAv6eCsW68CGkJl2pjqhArHAzccXFXfs1+MX8QQPBdbyu0nl077eJuVB3fR1lV1ELu/MQfI3t33BIfRRLpdwSXlm5YHupUgHS0T2uEiNmRjfTetyaQB7jWKYrhyD5vlwdI+6Bf0d6kCYAfubrZClnz1Vhh1cm+5Ri+EZSanWx2jdQNagk1L7WN66/AzFKPdzt5lQPr2l0x5D4lX89s1n8X5xyX/aDVUPEv674In4Cei6oioWfEC48kP8c1Il8YgRcH6ORGlv4G82nv2J55pjcDiHjzt3gdcP6c8raAcTnZ6vFnv5s89sleknR7YWnuO9TMo1Qd3zTJ4GxjosTvS//qM0HXoWt1ka5LsO2e5qpxuElCo/hRfOyy7vb21OcbvMXkMqGKGrQpPvzKZ7V08fd57RR4VVGUr/LU86//KOg2/raEpvYdbKf9RUwKvfMeTcyXyglm/8d0posUl+BtxuRfOG1JQDl6sHCeYVSyBOrmOYxXLAW2Tv+PWy0ulNMTbxQU1WMmvXbl4m5ZGaatntAVgvpw1CJ/DfkIXwjk6eXtwAkJMZbX9HAb7U9T5nG/U44=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkdheGprYWhNMWZQanNVSzdKZ0tjc1JsWEQzbjdhUU1YY040Sk5FVjJPdkM4?=
 =?utf-8?B?QUtnNzI5UC84ZE5xL0JMZ2ZZYmZSUldUUCtkQjJ2UnQzTmJEYXVJYXVmUExu?=
 =?utf-8?B?ZmtrYkFPTis1dCtiQ0lDbnlIOTZnVXhBZUZVQzlpSlE0ai90Q25BeWZ5Wmth?=
 =?utf-8?B?VW8zazdmb3pwUUZnWkxpMVQxNlRvR3hlU21lN0NyTVk0QThHL0NlTHAwNnZs?=
 =?utf-8?B?SVVRSUdoMkpEUGhjRWlZM1g3TjhpYnNkbVBBQ1JGcDBlYzlKQlhBZFRqeWxL?=
 =?utf-8?B?emdTYmdEckcxcEYxbDluTDVUZ0Y3SUNGcEptTm1qbFFBVWpWUjQ4NGJ1UDV4?=
 =?utf-8?B?RG14cVdoaTNnZStUTHd3RkRKUHMrTTVjVGNaNERMQUpHVHVjYlZBWlVSTER0?=
 =?utf-8?B?YnBSRGgzckdzd3BTZWtZZ3huVHl5NE9IanVXaGcvcWlSVnhnRGw3M2craUho?=
 =?utf-8?B?anFGK0toaDhhTkpvbDFnOGRDZmZpYU5RSVMwRkh3dzZBVXg0eDRzdTRuL1pK?=
 =?utf-8?B?MTZkcFp5MmlrcU5RSzI4bzhzOHMvVDJFYXhaR0w4and5RHFGdGkzaWNOQkd0?=
 =?utf-8?B?YkpkKzdUaW5ubGFSY1VMendkRG1RSU5NTHJvTXRXOG92Vyt4VVJyTVdrb0ha?=
 =?utf-8?B?U1J3MUsrU1Q4cWh5Q09PaU1mTkNpUXFpblhuK2JiQlBrYlZmRE4xNFZ5Z2J6?=
 =?utf-8?B?b0RNTVVURXowSkU0SGRtL2R5RWZhYjUzZHFNT05sUHhCcTlpcFJvaGwwUzIx?=
 =?utf-8?B?MnpwNzh6M1REMkxYcWd2c1ViVWJWZm1RM3BJdXR1WjRJWW8rOEh4V1dCSmJs?=
 =?utf-8?B?NmxrOTBwbGdvOHNSTU1kSURpOUtFM0E0Z3pYdTU1WDROS0VQUWNST25JdkYy?=
 =?utf-8?B?bmVPZ2Z5T3FFTnhsYkdLUXk0aTh4MWhEM2syUDI4REFRL1RkbTFEcWlzbFVR?=
 =?utf-8?B?Mzh1RW9ZK0ZWemlReStpRlVQb2hFcFE5YWxyVGN4aE5HUko0WlFQcXZQUENj?=
 =?utf-8?B?dEhhdUFsOHl4ZFZGL0dQK3NHWTBkN0I5UUEwN1MxeHlBTUxKRXNENTNQMjFE?=
 =?utf-8?B?YnRBV1dHMUpYR2w5Z2UweDlpenNTc2o5NTd5SWRaWUtoeEErTS9YaVFvM0FT?=
 =?utf-8?B?NnQ5TmgrZmxwMUpzR0ZZV0Z0MzhHd2xTbGJ4NlhkNHIyaDRvRDBVTU9CUGh0?=
 =?utf-8?B?Y3BWeXZIbzZBNTZFRkRYTjF2YWdJYW9Sa09LM29OQ2kwcllKVi9XY01XanA0?=
 =?utf-8?B?RFVpYi9TVEFrRzFiN0ZMNnFuZ3RXclJ3ejJnaFAxV0Vob3lXQ3NGbmJnNkJW?=
 =?utf-8?B?aWZ3dHd6TmNtZnZwVGFVNGhuR3V6bHBJdUp2R3pxSFJxUE9EYnNYKzZrSnBO?=
 =?utf-8?B?KzNKci94S3Bramk0Umw3cUNoQzBJQnA2bDJDK29EQnFUcmdUWUIxR25QWkY3?=
 =?utf-8?B?citSOVJOU1BwWndRY3J5VlUvYUVxYjN4blllbjdncDBsSk1MK1JsS1U3ZlN1?=
 =?utf-8?B?ZCtwbHNQR3RJaVUwczJVbjFkZmRpanpENG9XVmhsMmY4UGVQckxMQkgwWTYx?=
 =?utf-8?B?MFg2MnJZM0RiUGhCOHFhc0hvMjhtWW9TT3NpRWE3eUExUUh1QWkwWk45VTg4?=
 =?utf-8?B?ZkJpaGFvVFg5a3dJT1hhamtDZGZRNkpwblhUbWtncEowZDhQMlB3VnQrOU5y?=
 =?utf-8?B?Rk9FM01BRExRUWIwY2dVV3NCTDRaN0hRa2ZoSlEyYUNCUEdOYjA2dGZNR1dr?=
 =?utf-8?B?Y1BSTFdHbTNId2RITkJuMzBoUjJ5djZBSEsxV0t3eGNkbkNXSWh4bGlzVm1M?=
 =?utf-8?B?K2Zydm8zcUtheTVtMXBqRU9RSk1oYTdQWlo1NytmNFdKdTVVZERHT3grKzdz?=
 =?utf-8?B?MHRPNTBrSHZZTFZCU0VmSUFmdytFQzgvbW9QMmJJVzhRK0dwTktzbC90amVF?=
 =?utf-8?B?U0tpcFNxQ0lydUFqL1VQN1V1Y3oyZzIwREl6Y0JpWjQxODF3RjRoT2FyaWVS?=
 =?utf-8?B?NEorc0ZuSUpsUHBpOFpKUi9SUWhyVnZPZU0vUGxLZHZRUHFiTUpHcE9sRTlR?=
 =?utf-8?B?Qis3dEFveXlUTGJTMlhGYnloU1M0RFE2a3JzOEt6eHJjc1NsaEhEMHNRUXdW?=
 =?utf-8?B?WnMwcjNQTEwwVVRWMWI0bjBNWUNGS1RyUFcxdW9qL1JCcFhsZlY3VmVwejdv?=
 =?utf-8?B?NWhtelBtaTlqLytwV1ZTM3UvdzhSNjRnSTdsbmZsMTAwelRIVUlZT0VJelhI?=
 =?utf-8?B?a3pGd1V6RDdoNmpDbmg1dGNrNWdIOWF3aTBoSVhlK0R2NHAza0grb214cmVB?=
 =?utf-8?B?TVRORlFRcG14ZWZmRG5BU01sbERpTVpaVTB1c2VvOFdySHJSMlN2QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e599657f-d98a-47d7-0769-08df1e358f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 14:25:49.2178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7G1bscVVY9GyP+xMxmMO8uJzR+ttvkSmL/IT0MfqXVhuydHoGFkvmeUrkTOyq45v5SiWzBqrvR2Kg+T2WGy6Bs9+PcMoyILp72I+lNxh9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14117

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyOSBTZXB0ZW1iZXIgMjAy
NiAxNToyNA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvM10gQWRkIHN1cHBvcnQgZm9yIFJl
bmVzYXMgUlovRzNMIENBTkZEDQo+IA0KPiBPbiAyNS4wOS4yMDI2IDA5OjIxOjI3LCBCaWp1IERh
cyB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9HM0wgQ0FORkQuDQo+ID4g
VGhlIFJaL0czTCBDQU5GRCBJUCBoYXMgMyBjaGFubmVscyBhbmQgMTEgaW50ZXJydXB0cyBjb21w
YXJlZCB0byAyDQo+ID4gY2hhbm5lbHMgYW5kIDggaW50ZXJydXB0cyB0aGF0IG9mIFJaL0czUy4g
UlovRzNMIGhhcyAyODggYnVmZmVycw0KPiA+IGNvbXBhcmVkIHRvIDE5MiBidWZmZXJzIG9uIFJa
L0czUyBTb0MuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBkZXBlbmQgdXBvbiBbMV0NCj4g
PiBbMV0NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA5MDIxNDE1NDQuNTY1
NzYzLTEtY2xhdWRpdS5iZXpuZWErcmVuDQo+ID4gZXNhc0B0dXhvbi5kZXYvDQo+IA0KPiBJcyB0
aGUgRFQgYmluZGluZ3MgdXBkYXRlICgjMS8zKSBnb2luZyB0aHJvdWdoIHRoZSBSZW5lc2FzIHRy
ZWU/DQoNCk5vLCBJdCBpcyB0aHJvdWdoIENBTiB0cmVlLg0KDQpDaGVlcnMsDQpCaWp1DQo=
