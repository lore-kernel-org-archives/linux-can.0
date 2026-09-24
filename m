Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010037.outbound.protection.outlook.com [52.101.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F434483827;
	Thu, 24 Sep 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256026; cv=fail; b=BMYCazi+WudcFACQEe+4ucDll/LvMych3CZO71F3LNgWWabyMO4/WoqVHIUn1+nZS+o1ADJG9x6tf9Id2Kesr6kQdh10FxUcI2wxQZXVBdSEX+fhjrG1DJiKUleGyWEPiZIqlTZGdyz/cJKXCQid2ykSK9fTACdCQC2/6F8yRCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256026; c=relaxed/simple;
	bh=JubtxcZ5duysuH/cL7hm/bOBXKPqXRZAebFvPUzTFic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hya50XNz+Ds6UVFMcXGMdvNVdZf6ewlvwy6BFMfWRTRI1cr19jxCu5lTiv16de7tz2WL/+dhmmNlYf9095im49PxRFMT1hSNCjjRUlyYtMt1a3jIiWE+6b9nruSoTs3ksinUQg0gmDkFJtFDwss58ZczaBXCcBXaaTSxEfeyMT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=h0eT6RlH; arc=fail smtp.client-ip=52.101.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="h0eT6RlH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhurbQE+6iijvI0T2GV3QDUUk1hMObX52BHxHAq0Ge0kHYv8KTjYG0SgNEA59t8iKRa7ijwagom5m24vzDhU8HQpkjR0dArgb3wRsp/DqSHkAQoHMR6KUGsjyqYGUSRcBuJyOMly7q8sfY1xtkbKMpqoqSV/2JocPcB3ZP+xE0AxULH2dIR+tvp6zPnUDIaQmvpCw/dO68P+fL7hyScSOO9DjvaJX1VvBbc/VAU66+ZILUE3Hk08QEB5d/8oaYlhpKMNrImwutl7UaUC8cR4F9UjmysCCqhgBeXvtuL1P591mIV0pZk8BBGZ+wWstFZXYafQJS//luBenIjCGctCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JubtxcZ5duysuH/cL7hm/bOBXKPqXRZAebFvPUzTFic=;
 b=iFVKhri5fBeEa0GyhfgK1OQ3NtN9TSFPYNWTUC5IXJKRxt9ZgQBfcYnZ2I0uLdj0ErzQG/XLs7IMMFV/WN3WM/tMVBqJ2b3RWl9U1xHBGTE7wOgb6xE/+JVBrtrSuQO5YjM/fS5UlRabgV8K49XxrI1hILpzoxdkXB5/1zRlFixnMp06o/CBQcRTPdo7F+JwkVBxVMeG0cJLQ35VlBQBkJL93GaYwmHqOZ0hoHjYTHWxZrzmLJUwlHPzWSwSANs9MutPOlkgHDud+otv900cAs8nr7XQw2NMs0agdvQ2SLXs6y1081GB8Tpb79HbFzmscZVN5XAe4PiWxz79VRr4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JubtxcZ5duysuH/cL7hm/bOBXKPqXRZAebFvPUzTFic=;
 b=h0eT6RlH7QqGes92lf9EWgL5M8qwL6+rdK22r3Fc3Wz2wqfdOK34SFVENE6EKS4t49FtZG8X6IE5lHzo3O4RLXrdCwNU69bjLDdyEjZQGdYns0B3CMpwqxodXUbQyel1IjqF1ZjYonaCEZcfrEvLhyxHKcaKpWFOreM2y4ZjUbc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB16332.jpnprd01.prod.outlook.com (2603:1096:604:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:20:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:20:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Tu Nguyen
	<tu.nguyen.xg@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v2 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
Thread-Topic: [PATCH v2 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
Thread-Index: AQHdS+WDMGfeP2NM70eJgxVEjvgr5Lbds/YAgAABhwA=
Date: Thu, 24 Sep 2026 13:20:09 +0000
Message-ID:
 <TY3PR01MB11346DAF9A3871B6F2EC24B2C86812@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260924052741.130658-1-biju.das.jz@bp.renesas.com>
 <20260924052741.130658-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdUd7=y6H+GP_7eOHSc0Ye0ZB6CgKUvmFrWMsVAK2SW6RQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUd7=y6H+GP_7eOHSc0Ye0ZB6CgKUvmFrWMsVAK2SW6RQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB16332:EE_
x-ms-office365-filtering-correlation-id: 59bcb79d-9b39-4b3d-0354-08df1a3e8eab
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 h30yjJANkSlQ9SUluDa+u0vhZiwqGjXzfTMb4eLDGbk1PMJ0E/WX7o30B1Mkmi8y/5aqlXJ7KUQMkNnSG6HHG4hDkCkG8GanxLWxxnF9FZuiNeLAI+p0vV8kWKf0iBRFZI0Y0w/1upkLO5ZfZ+Hw+T+VjG3MMbPtG1JKVc9Q5jdAWJiNXdYgI4lahkLjKyfLhCIFB7CdvDOTtE60s2ow5GmYHJiWz6oH4Zx31J4w93WbKeC7/vYRU9aHdo8/C+5gvx3JIRcgNKCROG/Xc78xWGGzBhxDt9cnvsg1cbNtJx6iq3j+0xqzUAdvSYBJL0hXMj3DKFXkhGYXdCvjyoT3a3LJTk5ZgQgGlkSYwxFXP/vZSwV+4bY0jPyGDSMgsD4jFeSs8TalYPmp6wZZR6ALEmJ8PaAjEsKweZmNbQ7bWpTgw0irPTAw/qf+8qDliW8GjI7aBjQv50v3J/lAlgf8FRZsPB5M5rnjQoVNHdyzz7loc+wEwsAhLqB9zSfVFmlU5H1pbdjE+1RpUsNAluuvMFR/4SARYUMfBzseIh7mkv6TkdCah55Ze7jQ6P716AiHnpye/sPQVF2PMnQBa+ZsIbcedIWtGv+edmqjt5oMXv1B1OcIxoTi5Dvcxel89wS+Y3Acdjyon0zCx7r+vH/ESwoKErNIjC2cLrR/XaSmqsuF1d7DmdxEUF5BAF1qyowHLKCNo7sx8RR4FeHp6Eps1VUcx0KfH+ZutWYkXZyhIK4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0luYWV4TkVVdkZ0S0ptOXFsaGpwY1NLT09WdlRXRjlBVUdoTDA4NVhYbTRN?=
 =?utf-8?B?aHpZNjVNWkdCdkh3ck5TWWplSlFLWnl0S04wTGkvc29iVTdLVVRaczhsUldV?=
 =?utf-8?B?MUt1LzJ4NUlXajFpaXJxaWIyUDNBUStBOWhrU3pBeTdqb09jR01OR1hIbWtY?=
 =?utf-8?B?cjY4cHloWWNSdko5d01xQnJsVUYrcWtROVVZWXZENGRJeDhBYnRjenA0bHZ1?=
 =?utf-8?B?K0MxOEw4WXhzU3RvRU5MUFVKejV2WlYvNWlmUlJWUzBCRHQzVjhBUG5OZFNm?=
 =?utf-8?B?Ymk1ZWtWYzkvZ2FMeldWdlFuT09kbTdvWnBUOUwrY3E2ZXRUaVBtb0FoNnZX?=
 =?utf-8?B?YkZtVC96MHczb2txYmlRK0IwOG9aN3FDT0xKaFI4bjdNVFFiRFZsUWlSQnZU?=
 =?utf-8?B?dlo4YlBrZTFmSHhWRU4wUjlkaW9kU3o3WmdWd1BvVC90Q1FnUnVwbHdKOTM1?=
 =?utf-8?B?cStuVFRpK1pNc2JqMkJiVXc1VWs3VWFoOVJQTFFkcXB6R0VzWlZHcHZFVjBW?=
 =?utf-8?B?aVdZQkFVWktUZDZ5ZEE0bzNxWVJXdTczS080ZVUvUVgxNnMrQmt3b1FyTEtJ?=
 =?utf-8?B?ZXVXYzBTdFY0KzdHeXJUam5BSkpaMXRaMkNvSExWc0FEM1V0UUhmamwrRStK?=
 =?utf-8?B?WlFESmRIYjNUTlZld0xBdGRtZWQwTTdIMytXTk9GcG9CL0srSVluUlc3R3Vy?=
 =?utf-8?B?NE03Ykk5SDFmejJ2aWNsc2VaQ0wxeUlHNjM3aGVrZjVKbWlmMDl1bjZGMk5B?=
 =?utf-8?B?ODdCck1iY2F4ZTFFdXU1MkFSN01BVkZkeURKZEQxL014b2E1aVNCSklwUWtK?=
 =?utf-8?B?U2U1ejdrSzNabGYzZWY2V2hkQUpGcnlIZFRIZmhhZnhMTXN3VnRhR2lwa01z?=
 =?utf-8?B?NkFIc0JqU2QwNmdNL0l0WTZmSXBnTUphQmE3UFE0QXhUQjlGcURFOVJvemtI?=
 =?utf-8?B?Y1ZsOE02aWVuWDRoaDJnNzJxWHpkeGhhMWFIUC8raGRtNDJsY1k4NDhTajlv?=
 =?utf-8?B?LzlQMGZ3MVIvQ1ZhODRIbC9mUlpHYlVMRjNlYktpb0VIUFk2ODRpNHRCbW8y?=
 =?utf-8?B?TXZ0YmgwTDA2MERmRUVRL2NTaTgyR0VqZkZ5SjhRUk4wREFyZUZPUTJjUXBz?=
 =?utf-8?B?SVFtQzdTUHNMT0NtUFNZeWZ2UTZ5T1Z6L2RiVUpyd2lXeXJMQjJmY2JMTFRl?=
 =?utf-8?B?U21tcUFHaTJKbFV2WmVLbml6TXFEdXBic0FSN3VaYkowRHFJRDZLWHhZOWJt?=
 =?utf-8?B?WXB1L2V3aytGU3RZN0FPNHFiS0hWL29qK0ZHalRCMmxQN2JrQkVyUkIvQUJN?=
 =?utf-8?B?S2pzUnAxamtxTkMrVktva1Qrbll1b0FncWkrQmIwOFlqWmtLQXl5b0NyM3pG?=
 =?utf-8?B?ajBCdmVLNVVIZGtqaUkzN1JVQ3cvZWg2VXgyR2p5dUdHdDd6aVR6ZmthVVZE?=
 =?utf-8?B?eEpxZ0hBcGtFdCtiOStvNGI5MThnS2UrWGpNQjAwL2tSNUZBcWdUdmlDWUhB?=
 =?utf-8?B?eUV0NXo5YWJpOEY4VnpSSXlxY1EzOVNwY1VkMFFhRGxUNGNkNjNwekxXKzVr?=
 =?utf-8?B?MTN2NHBQcjJub0R1bU55V3M2K21KemZiemF0dUNIdkwrOWo0bVBQVG1xbVZh?=
 =?utf-8?B?d1pkUFJQVmNQaUUrUmQyMFBBN3Z3Z3ZrOTJYSzVpRVg3cFordWRFUWlUbUYz?=
 =?utf-8?B?UVp3THhlcE9xMkluaEI4OEZEUkVmOFpZbDRnMytjenZWRmFMeE11cmxaaDlz?=
 =?utf-8?B?cjZsN1d6alQrMFZCZG5hZ3RuVGE2VDJSOCs4dmljcHl0ZmxmeUUyTXpUQ1lE?=
 =?utf-8?B?WjdLenB5M1d1N0NRMFloWHhQdEo0aVF2UnFkNUpHUWFLNlJPa0t0ODlqRjZE?=
 =?utf-8?B?alZoTUlXTjhtNksrcXZ6WW8zdkIxYXI0RWtzWndyanJMUTU3S1B4d0xCNENl?=
 =?utf-8?B?dnZhMEdlekFyNGJpbmZnSjI2bTVWQWxYVXZHZnlpVEpHYlFJcUdVQkhjR0hp?=
 =?utf-8?B?WFpPT3FBdkIwdTkzUkM2REJBaThCekc1bWdwa0J1aythakFONDI2VlNCeSsv?=
 =?utf-8?B?eXhCTU81MXpXTFdiZHNMSGRhL1Z0UDhGdFV2V1RERm02UmlFQW5iUmc4T2ZS?=
 =?utf-8?B?Nktpb3pSZk5xNm1mdy9OVzdYZWlPVHZYMGZrckxIcE1pSVFrVUtTZDBma3oz?=
 =?utf-8?B?OTZZWnVEaUIvQVQ0elJMY3Y2WW9WQldLQlptRVZNTUFHeWEwY3d0eDdlOTgr?=
 =?utf-8?B?YjNZdnNCUmR4T2hUZHpWWmNxcXREWW41dm1MWjNYTFEvWlJKNWxwYzZUYWlD?=
 =?utf-8?B?K0RZVTA4THgzN1BGdUFCcFp2L2ZacjNTS3FsZzVBUjg0R0hSdkJrdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bcb79d-9b39-4b3d-0354-08df1a3e8eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 13:20:09.3343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSIWYcD6nmJVY8lzibiUKvG22UgVt0+htQ9JmTkadIEfMPjvB/jEpkrzQx0mKzEQLHTnsaFjb4UiVfi6SpB2xvE9dYgJbADucJBYrFU71Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16332

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDI2IDE0OjA5DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMi8zXSBjYW46IHJjYXJfY2FuZmQ6IERlcml2ZSBtYXhfY2hhbm5lbHMgZnJvbSB0
aGUgZGV2aWNlIHRyZWUNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBUaHUsIDI0IFNlcHQgMjAy
NiBhdCAwNzoyOCwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToN
Cj4gPiBUaGUgbWF4aW11bSBudW1iZXIgb2YgY2hhbm5lbHMgaXMgY3VycmVudGx5IGhhcmRjb2Rl
ZCBwZXIgU29DIGluDQo+ID4gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mby4gU2luY2UgdGhlIERU
IGRlc2NyaWJlcyB0aGUgY2hhbm5lbHMgYXMNCj4gPiBjaGlsZCBub2RlcyBvZiB0aGUgY29udHJv
bGxlciwgdGhlIGNvdW50IGNhbiBiZSBvYnRhaW5lZCBhdCBwcm9iZSB0aW1lDQo+ID4gd2l0aCBv
Zl9nZXRfY2hpbGRfY291bnQoKSBpbnN0ZWFkLg0KPiA+DQo+ID4gRHJvcCBtYXhfY2hhbm5lbHMg
ZnJvbSBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIGFuZCBzdG9yZSB0aGUgdmFsdWUNCj4gPiBp
biBzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwsIHNvIGl0IG5vIGxvbmdlciBuZWVkcyB0byBiZSBt
YWludGFpbmVkDQo+ID4gZm9yIGVhY2ggU29DIHZhcmlhbnQuIFVwZGF0ZSBhbGwgZm9yX2VhY2hf
c2V0X2JpdCgpIHVzZXJzIG92ZXINCj4gPiBjaGFubmVsc19tYXNrIHRvIHVzZSBncHJpdi0+bWF4
X2NoYW5uZWxzLg0KPiA+DQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBU
aGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQu
Yw0KPiA+IEBAIC0yMTQ1LDE0ICsyMTM5LDE2IEBAIHN0YXRpYyBpbnQgcmNhcl9jYW5mZF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgYm9vbCBmZG1vZGUg
PSB0cnVlOyAgICAgICAgICAgICAgICAgICAgIC8qIENBTiBGRCBvbmx5IG1vZGUgLSBkZWZhdWx0
ICovDQo+ID4gICAgICAgICBjaGFyIG5hbWVbOV0gPSAiY2hhbm5lbFgiOw0KPiA+ICAgICAgICAg
dTMyIGNoLCBmY2FuX2ZyZXE7DQo+ID4gKyAgICAgICB1OCBtYXhfY2hhbm5lbHM7DQo+ID4gICAg
ICAgICBpbnQgaTsNCj4gPg0KPiA+ICAgICAgICAgaW5mbyA9IG9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YShkZXYpOw0KPiA+ICsgICAgICAgbWF4X2NoYW5uZWxzID0gb2ZfZ2V0X2NoaWxkX2NvdW50
KGRldi0+b2Zfbm9kZSk7DQo+IA0KPiBUaGlzIHZhbHVlIHJlYWxseSBuZWVkcyB0byBiZSBjaGVj
a2VkIGFnYWluc3Qgb3IgY2FwcGVkIGF0IFJDQU5GRF9OVU1fQ0hBTk5FTFMsIHRvIGF2b2lkIG92
ZXJydW5uaW5nIHRoZQ0KPiBmaXhlZC1zaXplIHJjYXJfY2FuZmRfZ2xvYmFsLmNoW10gYW5kIHRy
YW5zY2VpdmVyc1tdIGFycmF5cy4NCg0KT2ssIGZvciBzYWZlciBzaWRlLCB3aWxsIGFkZCB0aGUg
Y2hlY2ssIGluIGFkZGl0aW9uIHRvIHRoZSBEVCBiaW5kaW5nIGNoZWNrDQp0aGF0IHZhbGlkYXRl
cyB0aGUgc3VwcG9ydGVkIGNoYW5uZWxzIGluIHRoZSBTb0MuDQoNCkNoZWVycywNCkJpanUNCg==
