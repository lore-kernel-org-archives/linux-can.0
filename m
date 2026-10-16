Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011035.outbound.protection.outlook.com [52.101.125.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B434DAFB3;
	Fri, 16 Oct 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159993; cv=fail; b=lfcD+dHqerVIXHJYjkl4y9IQKLFcEHlmj3XSgqIh/P6tJ4JrfOxUBgqblDJNkw+94RPUseBGh50BmYmpYaL07TeWd93v0D5YJ0VEgKKTZxAK7WokFCM8QGomyC1GkQGdXG8zqSQLRjRrSPrVqOYRHYyZqaFcTS7lMgrxRAHtCDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159993; c=relaxed/simple;
	bh=AzKqC1k47EuIIR/k3bN9LQAZj4Iist/M/VUROyksOgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QBjeUSg3Httmws124/hgiMKNSseyINP8ynqTFfmGjrlD3kRmxMVvQdg/tc8Tx7AQG8MpAQ7hbRgCyrjCmmTpQUJGLf78zj5t9ACAieALvGEMs1CtjIibJnJjRYRGakqy3cBEPCg8EZSi+02fiBLI0m4DYl2dNYUdsWBs9Vh23/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=djru1SF3; arc=fail smtp.client-ip=52.101.125.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="djru1SF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1gxtU7U/ulEm1ENxHq3ooxrpi7aoYWiSCafTuZMS1t5Q5x+AjbJ/rFC/hF+XecgfZ8pKE3mJeadpc/QFSE674zRmCYlxK062KNuESmbImgy0nmvRGM94wU53HDE1Wj1cW+guUjCYGWi0fU0vlChuC413A30zn61UYbFYH4Bv6LO9TXYww4YJ2hj6dgUt3r2KFIziYJ/9IDEgPFwoDo78gpCY0F3xkaLs5w6SOdNLXNzE64YJjNHmedHxnaXvoTih9IjC00WxWPiN3UpCM+ErfMG0WuxbopZcVQO/E9c9jLC43yTXzjGlLux8r0qFCTLKZ5FBfA8wBoscbCiu1idtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzKqC1k47EuIIR/k3bN9LQAZj4Iist/M/VUROyksOgI=;
 b=RsTEhXquwR+ym5bMBsDskpf4N+rWi0kxQQ7J+fLWU8iL78rKVjLHWGsyxSpLjinwH1uebxilF16pVHaL35PfzkGWgazwQggTycnhZ+RDOV/dWUWf/DDOEYK1lx8ctKl2AQpV0VvHEbdOHBpxCsNRTuv3HXlZa9FQduloPmE/Afm+uB/AKiviyqFNs0vlHT69n5YCjEv2uqQuOXacAFxmHeh5Yf7bRwkCPkrHa0PbqCsNt6T0a0sEKMjWjXWfQt3ry/5/eA8h2dpgQz4/CL3ovwRWgVbNcixI0Jpx0DD4Z6WfKxplotGsCDP8xZlnYbpLjEHEx6K48qhmdbsybwp/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzKqC1k47EuIIR/k3bN9LQAZj4Iist/M/VUROyksOgI=;
 b=djru1SF3+B5AjPXl04GsBIfZtYuGmDMRyw9vFz8t/uiuxIvsPSdbUcmPwHgPrHQWyoQAt7uCCaN+CGgw/70/SiVvYwBn5GhOiiRg0Z50h5o3uZx4vjVwNWkg9UFZuMtsxBS/CsoarxgVSGetHPm/Fg6yQjCnXo+B5qBKkU8p44I=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10693.jpnprd01.prod.outlook.com (2603:1096:400:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:12:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 14:12:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Thread-Topic: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Thread-Index: AQHdUXqWGJYcQwxreka0VFtI2IFYOLcAS3kAgAABusA=
Date: Fri, 16 Oct 2026 14:12:58 +0000
Message-ID:
 <TY3PR01MB113465234171180FFB5F1B6FD869B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-2-biju.das.jz@bp.renesas.com>
 <20261016-rebel-ostrich-from-vega-f759c8-mkl@pengutronix.de>
In-Reply-To: <20261016-rebel-ostrich-from-vega-f759c8-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10693:EE_
x-ms-office365-filtering-correlation-id: 4d66d6c3-489f-434c-3ce7-08df2b8f94e3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 fXf70G3zdohaUpyJ68kckGLQLX7cC5/PU3hAlhjXMsdjsu45Mx1RHFxeHyVKtQagDDcQQaWPQ+KsHqwl6xybXj/CfugP9Ps7ae45TEEheWroJ4+VDSBSGm+x96eSts/UVbhgkVC6Zgys8r15i+w3gepadhcbya6qPupJdmgLGskLOKt9VQE+mmOn6ri7dFxHyoCBQjCs9KSfVkw56WxqAcj3RaZuqGPlqob0xFjTQ/FkEy9iXvvUdakPsOMtQulCOjiJuIM8o2vCgK9m1xXPjxtqVBV+MQ8eLAsMYxQxD14VHzsc0qKL9XPNvU5xoMSnY3QAjrR70MYj1h0R5NHCFiadeJ7gfLB8rr2kE4wMUwP4hm+cViGj0pnhH7ysXUBIZhPGDT3gRAuev894Oiz6ztW9uXhYcP/ozYFPp6VQAVAKKCb4U7K7J4Rxg7HDrCrr/3JiK3c4V5Of8BLSLOafoTXP/Y6clwjN8/tldScD4PAUUxmQrH9xMo4B1I+TSHxovbV8BVlggZVL31AOiGafWBwQSAPNNYO1VoEPy4ptqyZZIJCOWNK5pc4vvloUMu9J2spKk8kxFiSPK/iVQQBYh85x8ihhZOCSHzXZaQozzmNOmoHCKLp7gs4Slf+AJ9Vbmvvj+b3hQti1S/ZyrfFgxv7S1FJawpckLY0v3yyarPY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWo2Y2NwZnJ1OFFTcUxEUUdQdnBhYlVJY0ZycjJWNldDYWV3TWF0NkpFUUVn?=
 =?utf-8?B?TnJlWUxqdGo5UFo4TjRwVDdXUlJjdkNpVkdxbzV3WVVVcS9lcWhiNHk5cEds?=
 =?utf-8?B?eDBSR21VQ1JGUEFBcG9nNDBEbTRGMVE0UXVSY2cyTjdzMUVVQ1MzVS9SYWRU?=
 =?utf-8?B?Rk1iL0EydWpyc3FLQzR5TjRNUWJ4TDlkUlkrL0Iya2NjUUJXdVNMZjErMXRN?=
 =?utf-8?B?UGl3S2VTRkJNWExJVnNQSHhSRk1rNHZ3dEx5K08rS3duYm9zVHFSNEhSS05X?=
 =?utf-8?B?VnJyT0MxRkUvZXp0bm9YdW5MeWY5endQeXFLaEZKalVpVUgrcmlVMDdudG1K?=
 =?utf-8?B?SHFJaUU3VXNSVnJaK1BnOVFFMUgzYjUvL0llaVhwZis1amJFb3doV0NmL1hx?=
 =?utf-8?B?a1o2WHFQN29iVEUxUDAxczVYS0ZmdFJ3Vk9nOEFLZ2VKN2tpelNFY290SFRS?=
 =?utf-8?B?djY2L01nYWFjc3JjOTIyYUdqdE8zblRiVlNiSi9PVksrUlRoWTFpbXNnQm9V?=
 =?utf-8?B?eVl6YmRncmNtSGJEVXRBS3dSdTRnNTF2MzdVajd4dkprbFp1MDhwaEhmcWt0?=
 =?utf-8?B?UjBTVXVQZkRNY0IyL1Y2ZGdoR3VVdHFRVzk2SlZHTGk2aW50M2JkUmR4M2V4?=
 =?utf-8?B?UGhTOHVHQzhvMlBVSlNEalFWN0QxazJWc2RzNm5Velk3WTlzN3RSQTJoRlZw?=
 =?utf-8?B?Y0pNN3hHa1d5bld5YjlaWFE0WlorY2dsQmFvMzRuNDRyTkJHbVhJQ0JYUEhX?=
 =?utf-8?B?OVlZTkV1M0NSVmFTMnhqVUc3VzVsd2ZrVVdTVE9TOExBSHMwMmw0RFVBa1o2?=
 =?utf-8?B?MDA1NHRYc2ZyS1B4c20yUzFHTEtlRysyRXMyQmZpVmVPOHp0K1kyWlRCSVk2?=
 =?utf-8?B?YU9DNEtUWWFWSkV1K3o2OXlYM05NUVFWQnliNVlCWVgybms2eGM4eU1IU1A5?=
 =?utf-8?B?T1V2bTF2YWV5UXYwRlVPdnc4SURMblhRcVNsd09GU1NpWkpFaGpnd21VRDJI?=
 =?utf-8?B?UzAxdm1RTHE3MnZ2SmlYdTRjSVY0clNKZlhFM2NLVGVLK3A2ckMxZ3VkblBh?=
 =?utf-8?B?YUlIdXFncjZVWGFZT2FZS21vNGpCWUYzdmVvMzVMdEZ3SjhpcEwzY0tjTTAx?=
 =?utf-8?B?SkFQUFA1aGRYY0xKQ2VXRk80U3M0d2cvZnJWWEpLQWh2MHBwUXdWR0s2Y3JQ?=
 =?utf-8?B?V2Rucll4cmhSUXRrQkZWMW1iV0djc2VDQlpuRjhycjV4dHUvcUZJL01Za3NF?=
 =?utf-8?B?MmZ5d2ltRmxMZjdBMEordjNjNnZGcHA0VmdNRERTY0ZlSHAzUkl1N0lLaHNp?=
 =?utf-8?B?VFdqK2VIcnhDbWxyQmh6cnBJQnk0ei8xVE1lRFhOS2pkOHY4YWNKczhuUlhY?=
 =?utf-8?B?VURDUTJvVGE2RHZxYWNsK2VZZTdQcW5XcWkrWVlKc1MyNHp3QytTTkJIb3hK?=
 =?utf-8?B?Ymx4RHI2OElUcG1VRlJzUHU2T0NlT0FpR0NPUVdTWWFYZm83SFc4ZWt0MEEv?=
 =?utf-8?B?SDd2ajNsZkNTRENHeEZxSmEvOFpsSWlXcDNrdGpjeTJObzFTb0JQb3lrQlM2?=
 =?utf-8?B?OStHTUhxVVhkQWQ4TGtUQ0FWOWRQRGMyOUhjd25seDRaa2NPU1ozbXh6L2NK?=
 =?utf-8?B?bjZJYmxLck5vY0hPK0pqRTBTQWhpTTk2ek1tamFrMVJmaUZhSnVQWTZjM1pt?=
 =?utf-8?B?V040MjlWQlFWQ2ViTzMxN0xlZm5jcWl2MHFrbmc2VXN0SWxvU1RvUjZsT1pG?=
 =?utf-8?B?cmNvV3pMNUU5OCswdHh3bWczN3MzQnpucUtDdjI0SmNWaG1jRmZDY1gwcG1y?=
 =?utf-8?B?LzRSZEptOUYyL3lMTmowM1ZsNjVCSGI3cjAxVG1sN0R5MFFRNmcxbHhLOUVC?=
 =?utf-8?B?UlBwUXV0K2NnRUM1VWtVRVFxanYwazB1dEVyTU53dlJJakJpbDdoRGdDdzhs?=
 =?utf-8?B?cm54ZnVtQ3VBMmlOalNBdVdXM2JCQTNKWktMQTRCV0JTODhwRXlJbVM2N0Fk?=
 =?utf-8?B?WEc1K3Y1KzYyVWptVDl6ZkYrcW4ycjFiYkhFT1VuV3Rwa0lzNUR1Sy9kTDRy?=
 =?utf-8?B?K2JLeVZjTjN6TU9SVXEwdWJZcGJDRlRsb3ZzbmxVNGNpZElMYlEyU0x3R1NN?=
 =?utf-8?B?ZUFFSWdjbFFQRGU2REFCQjRZdGNYQ0svZy9WbEd4aVdZa2JxRXpkZXRhZUt1?=
 =?utf-8?B?eFUzbkEvenVXTjRnenpkY0k4RjVKWEw4VUpFWklvck1zYWN2bkRsUWcwUkdh?=
 =?utf-8?B?bUlxM3NTVWt0TkZobGc3M0RLbjh1V0N3ZE9rYkluSHpoSDZFN2RaL0dEYlVJ?=
 =?utf-8?B?bExVMGJjTjNoT2FCZnJjZUw5YVNXZ2hYNzZ3cStaUGdOU0R6ZS9vZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d66d6c3-489f-434c-3ce7-08df2b8f94e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 14:12:58.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmN6tfBRnHTJrcrMAY9/l3ZdSTmUHIjwCWWeRboEKCMoaL8sSmhvW4oqOOa4RtZLMZucoLYMGXOIV/5V6EBxUFvKuhI4LJqMRj1vfengHFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10693

SGkgTWFyYy8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDE2IE9j
dG9iZXIgMjAyNiAxNTowNA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvM10gZHQtYmluZGlu
Z3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOiBEb2N1bWVudCBSWi9HM0wgU29DDQo+IA0KPiBP
biAwMS4xMC4yMDI2IDA4OjU3OjM3LCBCaWp1IERhcyB3cm90ZToNCj4gPiBEb2N1bWVudCB0aGUg
UlovRzNMIChSOUEwOEcwNDYpIFNvQyBzdXBwb3J0Lg0KPiA+DQo+ID4gUlovRzNMIGhhcyAxMSBp
bnRlcnJ1cHRzIGFuZCAzIENBTkZEIGNoYW5uZWxzIGNvbXBhcmVkIHRvIDggaW50ZXJydXB0cw0K
PiA+IGFuZCAyIENBTkZEIGNoYW5uZWxzIG9uIFJaL0czUy4gUlovRzNMIGhhcyAyODggYnVmZmVy
cyBpbiB0b3RhbA0KPiA+IGNvbXBhcmVkIHRvIDE5MiBidWZmZXJzIGluIFJaL0czUy4NCj4gPg0K
PiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVy
LmJlPg0KPiA+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpDQo+ID4gPGtyenlzenRv
Zi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBuZXRkZXYncyBzYXNoaWtvIGlz
IG5vdCBoYXBweToNCj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4gDQo+IHB3LWJvdDogY3INCj4g
DQo+IC0tLSBQYXRjaCBbMTldOiBbUEFUQ0ggbmV0LW5leHQgMTkvMzddIGR0LWJpbmRpbmdzOiBj
YW46IHJlbmVzYXMscmNhci1jYW5mZDogRG9jdW1lbnQgUlovRzNMIFNvQyAtLS0NCj4gY29tbWl0
IGZjNjk1MDc5YTFkMjdlNGYzYzIyZGI4ZjVlMmY0NGUyY2FhNDRkYjUNCj4gQXV0aG9yOiBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBkdC1iaW5kaW5nczogY2Fu
OiByZW5lc2FzLHJjYXItY2FuZmQ6IERvY3VtZW50IFJaL0czTCBTb0MNCj4gDQo+IFRoaXMgYWRk
cyB0aGUgUlovRzNMIChSOUEwOEcwNDYpIGNvbXBhdGlibGUgdG8gdGhlIHJlbmVzYXMscmNhci1j
YW5mZCBiaW5kaW5nLiBJdCBhZGRzIGEgY29uZGl0aW9uYWwNCj4gYmxvY2sgZm9yIDExIGludGVy
cnVwdHMsIDIgcmVzZXRzIGFuZCAzIGNoYW5uZWxzLCBhbmQgcHV0cyB0aGUgbmV3IGNvbXBhdGli
bGUgaW4gdGhlIGJsb2NrIHRoYXQgZGlzYWxsb3dzDQo+IHJlbmVzYXMsbm8tY2FuLWZkIGFuZCBy
ZW5lc2FzLGZkLW9ubHkuDQo+IA0KPiBMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAy
NjEwMDEwNzU3NDIuMjE5NjEtMi1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbQ0KPiANCj4gPiBk
aWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nh
bi9yZW5lc2FzLHJjYXItY2FuZmQueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbWwNCj4gPiBpbmRleCAxYTdh
OWNlNDVlOTcuLjRiOTRiYzhkOTExYiAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW1sDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNh
cyxyY2FyLWNhbmZkLnlhbQ0KPiA+ICsrKyBsDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBAIC0y
OTQsNiArMjk1LDI1IEBAIGFsbE9mOg0KPiA+ICAgICAgICBwYXR0ZXJuUHJvcGVydGllczoNCj4g
PiAgICAgICAgICAiXmNoYW5uZWxbNi03XSQiOiBmYWxzZQ0KPiA+DQo+ID4gKyAgLSBpZjoNCj4g
PiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAg
ICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiByZW5lc2FzLHI5YTA4ZzA0
Ni1jYW5mZA0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAg
ICAgICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDExDQo+ID4gKw0KPiA+
ICsgICAgICAgIGludGVycnVwdC1uYW1lczoNCj4gPiArICAgICAgICAgIG1pbkl0ZW1zOiAxMQ0K
PiA+ICsNCj4gPiArICAgICAgICByZXNldHM6DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogMg0K
PiANCj4gRGlzY292ZXJlZCBieTogc2FzaGlrby1nZW1pbmkgwrcgTWlzc2VkIGJ5OiBvcHVzLTUt
NSwgZ3B0LTYtYXN0cmEgwrcgQ29uZmlybWVkIGJ5OiBvcHVzLTUtNSBTaG91bGQgdGhpcw0KPiBi
bG9jayBhbHNvIGNhcCBpbnRlcnJ1cHRzIGFuZCBpbnRlcnJ1cHQtbmFtZXMgYXQgMTE/DQoNCkty
enlzenRvZiwNCg0KRG8geW91IGFncmVlIHdpdGggc2FzaGlrbydzIGNvbW1lbnQ/IEkgZHJvcHBl
ZCBtYXhJdGVtcyBiYXNlZCBvbiB0aGUgcmV2aWV3IGNvbW1lbnQgWzFdDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjEwMDEtY2h1YmJ5LXRvbWF0by12dWx0dXJlLWUxYTY5
Y0BxdW9sbC8NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5
cyBSWi9HM0wgaGFzIGV4YWN0bHkgMTEgaW50ZXJydXB0cywgYnV0IG9ubHkNCj4gbWluSXRlbXM6
IDExIGlzIHNldCBoZXJlLiBUaGUgdXBwZXIgYm91bmQgdGhlcmVmb3JlIGNvbWVzIGZyb20gdGhl
IHRvcC1sZXZlbCBpbnRlcnJ1cHRzIGFuZCBpbnRlcnJ1cHQtDQo+IG5hbWVzIGl0ZW1zIGxpc3Rz
LiBUaG9zZSBhbGxvdyB1cCB0bw0KPiAyMCBlbnRyaWVzIHRvIGNvdmVyIHRoZSBzaXggY2hhbm5l
bCBwYXJ0cy4NCj4gDQo+IEFzIGEgcmVzdWx0LCBhIHJlbmVzYXMscjlhMDhnMDQ2LWNhbmZkIG5v
ZGUgbGlzdGluZyBhbnl3aGVyZSBmcm9tIDEyIHRvDQo+IDIwIGludGVycnVwdHMsIHdpdGggdGhl
IG1hdGNoaW5nIG5hbWVzIGZvciBjaGFubmVscyAzIHRvIDUsIHBhc3NlcyBkdF9iaW5kaW5nX2No
ZWNrIGFuZCBkdGJzX2NoZWNrLiBUaGF0DQo+IGlzIGluY29uc2lzdGVudCB3aXRoIHRoaXMgc2Ft
ZSBibG9jayByZWplY3RpbmcgIl5jaGFubmVsWzMtN10kIiBmb3IgdGhlIFNvQywgc2luY2UgdGhl
IGV4dHJhIGludGVycnVwdHMNCj4gZGVzY3JpYmUgY2hhbm5lbHMgdGhhdCBjYW5ub3QgZXhpc3Qu
DQo+IA0KPiBXYXMgdGhlIGludGVudCB0byBhZGQgbWF4SXRlbXM6IDExIG5leHQgdG8gbWluSXRl
bXM6IDExIGZvciBib3RoIGludGVycnVwdHMgYW5kIGludGVycnVwdC1uYW1lcz8gVGhhdA0KPiB3
b3VsZCBwaW4gdGhlIGNvdW50IGV4YWN0bHksIHRoZSB3YXkgdGhlIG90aGVyIHZhcmlhbnQgYmxv
Y2tzIGJvdW5kIHRoZWlyIGludGVycnVwdCBjb3VudHMuDQo+IA0KPiBTaG91bGQgcmVuZXNhcyxy
OWEwOGcwNDYtY2FuZmQgYWxzbyBiZSBpbiB0aGUgZXhpc3RpbmcgYWxsT2YgYmxvY2sgdGhhdCBt
YWtlcyByZXNldHMgYW5kIHJlc2V0LW5hbWVzDQo+IHJlcXVpcmVkPyBSaWdodCBub3cgdGhhdCBi
bG9jayBsaXN0cyBvbmx5IHRoZSBvdGhlciBSWiB2YXJpYW50czoNCj4gDQo+ICAgLSBpZjoNCj4g
ICAgICAgcHJvcGVydGllczoNCj4gICAgICAgICBjb21wYXRpYmxlOg0KPiAgICAgICAgICAgY29u
dGFpbnM6DQo+ICAgICAgICAgICAgIGVudW06DQo+ICAgICAgICAgICAgICAgLSByZW5lc2FzLHI5
YTA4ZzA0NS1jYW5mZA0KPiAgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwOWcwNDctY2FuZmQN
Cj4gICAgICAgICAgICAgICAtIHJlbmVzYXMscnpnMmwtY2FuZmQNCj4gICAgIHRoZW46DQo+ICAg
ICAgIHJlcXVpcmVkOg0KPiAgICAgICAgIC0gcmVzZXRzDQo+ICAgICAgICAgLSByZXNldC1uYW1l
cw0KPiANCj4gVGhlIG1pbkl0ZW1zOiAyIGNvbnN0cmFpbnQgYWJvdmUgb25seSBhcHBsaWVzIHdo
ZW4gcmVzZXRzIGlzIHByZXNlbnQuIFRoZSB0b3AtbGV2ZWwgcmVxdWlyZWQgbGlzdCBoYXMNCj4g
bmVpdGhlciByZXNldHMgbm9yIHJlc2V0LW5hbWVzLiBBcyBhIHJlc3VsdCwgYW4gUlovRzNMIGNh
bmZkIG5vZGUgd2l0aCBubyByZXNldHMgcGFzc2VzIGR0X2JpbmRpbmdfY2hlY2sNCj4gYW5kIGR0
YnNfY2hlY2suDQo+IA0KPiBUaGUgZHJpdmVyIHdpbGwgbm90IGNhdGNoIHRoZSBtaXN0YWtlIGVp
dGhlci4gcmNhcl9jYW5mZF9wcm9iZSgpIGdldHMgYm90aCByZXNldHMgYXMgb3B0aW9uYWw6DQo+
IA0KPiAJZ3ByaXYtPnJzdGMxID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNs
dXNpdmUoZGV2LCAicnN0cF9uIik7DQo+IAkuLi4NCj4gCWdwcml2LT5yc3RjMiA9IGRldm1fcmVz
ZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRldiwgInJzdGNfbiIpOw0KPiANCj4g
SWYgdGhlIERUIGxlYXZlcyBvdXQgdGhlIHJlc2V0IGxpbmVzLCBib3RoIGhhbmRsZXMgY29tZSBi
YWNrIE5VTEwuIFByb2JlIHN0aWxsIHN1Y2NlZWRzLCBidXQgdGhlDQo+IGNvbnRyb2xsZXIgaXMg
bmV2ZXIgZXhwbGljaXRseSB0YWtlbiBvdXQgb2YgcmVzZXQuDQo+IA0KPiBUaGlzIGlzIHN0aWxs
IHRoZSBjYXNlIGF0IHRoZSBlbmQgb2YgdGhlIHNlcmllcy4gVGhlIHJlcXVpcmVkLXJlc2V0cyBl
bnVtIGRvZXMgbm90IGluY2x1ZGUgcjlhMDhnMDQ2LA0KPiBldmVuIGFmdGVyICJjYW46IHJjYXJf
Y2FuZmQ6IEFkZCBzdXBwb3J0IGZvciBSZW5lc2FzIFJaL0czTCIgYWRkcyB0aGUgZHJpdmVyIG1h
dGNoIGVudHJ5Lg0KPiANCj4gPiArDQo+ID4gKyAgICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+
ICsgICAgICAgICJeY2hhbm5lbFszLTddJCI6IGZhbHNlDQo+ID4gKw0KPiANCj4gWyAuLi4gXQ0K
PiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWlu
ZS1CdWRkZSAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwg
aHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgfA0KPiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAg
ICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhp
bGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy05ICAgfA0K
