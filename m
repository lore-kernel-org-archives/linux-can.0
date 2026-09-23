Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010058.outbound.protection.outlook.com [52.101.229.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA546C4D0;
	Wed, 23 Sep 2026 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167093; cv=fail; b=Yws5C24pcWOKBTYcGCVxmn3gZYTcRLOjtMgKnFVXjCBTNGwypdAd5Q8/zqn2epG5on0WxVG7xPDQFdZdduoCw+XT09ETayzK56vvz+G7hCExpAebyBonndJKnGJNf7RZgEWSZDQXFzarD0y/evn+y5oS+6ck18MLBdANUXbtX2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167093; c=relaxed/simple;
	bh=AeDwq3VkSqyKs0/NB52vwYW2RAXtTHxHBugIr+eUtHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kpdsbncUzdLZKqhSk/p/sx44lyQ1A0h4rHQHIiN+Q6b/rEpTL6tPKifC/hROEO5oSXY5QUwmPWpSQ11OvVip9k1WokeGDoc3hctI+4T3jRefmVuJp9SY2rRiv+TEmg7YYj0PJcOsaegtqfVRfgiFK8a3o/ULQBYEwC5NWWN4yD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=DaqZy/39; arc=fail smtp.client-ip=52.101.229.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DaqZy/39"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxBg2WPKO5yDxRjN6Xy0sN4dKJ9w1j21U3hfrtX2PIZDJ7k7YushiaCx4EPZePE6Q05GLOpMkFFkOuIgCejUr698fGswQ1Xmw/RB6aLxdzGcRQeoR0NR+XRM1hL4NeAfnPuum+YvcCpSXJTmnwoxkC7shbdDOwjd2KIJzaw+mf6zb12ZT0m2p7YkcKIt9JyF2zZDYtNlIgsQ1X1/8PjbvdcLUDIjeumhp96oc7bNT/COUpmEHSKRr8XCfrE7qOv9nW88y7tOGA3cX5jUYdeHZSWP/gBEi6VjsBBTmT8Y9W1zkjdVC5XwuorZN+FVOgAK0XkCa3dl3arH30pJuRhldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeDwq3VkSqyKs0/NB52vwYW2RAXtTHxHBugIr+eUtHo=;
 b=JHcJuCI6wo54GIQ4TyKdjVdq50GIz0o/s+G7q/9FVT8TDIH7SShsJRul2/biXzaJYiIIJJ4mgikfcW2b8/kZ69TUbcBh/Rij/QNfLEUsqdPXWGv79IzExvMCHwlbskCVJ5DsEHkTfvEpl9/refKfMqH1B1e9N/YuJx1PtJThcgJ/hBoC36ysWg1eSq2iVkqIXpAe2jkWYYA0KJm8FmIsASOo5mZ6+U51ml1zPimI/rUDYCtVx1bkBABJT1tIggoMppWAr1/eHosXqKV5QErBlH7SC3ah7DMWvz3QKea6DHXuhtNbj+n0FFuYrDTXHce/80AvlAPJnbX7O/PJbedyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeDwq3VkSqyKs0/NB52vwYW2RAXtTHxHBugIr+eUtHo=;
 b=DaqZy/39Ut1rlktmmeJf9IV5m9cCyt0A9r9L9dZe9DnF2GLc7NodGei61WWAbt0ZYyJw0x3nut8HOhy6PYiwARnHzAByIOZdrUPa/8ZIvx4891r0woI8AsG8XXbKb17hV863eYKJj9BcU4MJKFfnTLtl/CJZj1p/g/qWemoKwz4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB8127.jpnprd01.prod.outlook.com (2603:1096:400:101::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 12:38:07 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:37:54 +0000
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
Thread-Index: AQHdScvyKd44zcXOb0aD2Pqcp4J/k7batm2AgAEbASCAAAljgIAAQe4A
Date: Wed, 23 Sep 2026 12:37:54 +0000
Message-ID:
 <TY3PR01MB1134600F9DA9CFB565863616386822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260921131951.187981-1-biju.das.jz@bp.renesas.com>
 <20260921131951.187981-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdUx5-P97CFEH3Dif1g4K=NPfkDkE=3vrzjZB-TsyxqO8Q@mail.gmail.com>
 <TY3PR01MB11346F23E0C28056BC78DB36B86822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdVUEv6721mZZ4k4hNoGViOMH2-MZjihUMMD3Lzgjx3ZXA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVUEv6721mZZ4k4hNoGViOMH2-MZjihUMMD3Lzgjx3ZXA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB8127:EE_
x-ms-office365-filtering-correlation-id: 91e6c308-9730-4955-e0d3-08df196f7d78
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|38070700021|18002099003|11063799006|10067099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 MK7qytJLCZPGBZXMNCrMchJglHyRZxajX1tDef6sTCCXr9sXs8xTygpDlKEVs5cfB3qxV0EpPO+S3XtlnGH7fmmVp40YKnek4lYra6B+u1SZKrPZORVi8b+tQMMK2NNZaWTqgd9Ns2h7VB1JrKihFQcGdcsgGMcXdo4yuMT835tCfQzqBfeYQGsl8d+WyH0oxfpjf9g8IMzFv9UKtke6xalr2kTQxXZePuniM0Ep7uiCOcxoahHA5zMuXLpX66yrGz9JYasRpwHGwy4UgAYwTC++v5xp6jR98p470b1/1K0mRbp6vNBWU1nBGtC71XdGF4FRvf+jvG1zfsozziY9h3AZvZMReRPI/u+odVli1XfLFrNYy1prSdVDQxORWxWs9h4ffTVHZmVnqQtqtRaDSEfQPqFu3nTOEnrNS1U5z2M5VKhQV1c9iH9snPVEdVB9P7gjlqHCmZGXiGCd7VCWPEAclYzBpil8LcggUoyeHhE6Yy+qOUu8u85FAF4EOc7Jj9GwerRQvtM816GeQH0s2cyyQsxuBzrj3hFKyp0fER+vdh5mmrG8p6zI9DV1LB0td6RcborSAtJxGhtudTqI0ltoumB0+B+W0ocz06IssWU6n/X+5oexCyQftDys3du2eKHx2W7cUWPmb05sQFOuboOevxh7NYpugTKj90HBOD6cBOoLr65aa0VFdh3hzedM05Typusq+I8zfD+EIFFuA9dzQ9rpEXNxNL1Jind88VE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(38070700021)(18002099003)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2JPeWZoZXVjNjVNS2FsRnB0K0c0UVNzelI5dHZnY0FYOVROMFlNcEpwbGZ1?=
 =?utf-8?B?YWlkYnhTT2VYYzFuZEtCRDc4NEdlZEJGem5OK1Y5NGFMUDVENU9LNm5wSnJX?=
 =?utf-8?B?STI1UUxjRnhtVzcvRlFueno3L3ljek9VVE5jd0JrSE9BSzNYRzhURm1PeHBw?=
 =?utf-8?B?Q3N6bWdBdFc3TXJtSERsMmdlVWNtelErd1NaTzdLSzgzSXhPcXRvNU5YVFV6?=
 =?utf-8?B?SmJjNFBNN0Z3OFI0bmwyUUk4VDAwT2ZLYTAvdllRSjBMVi9LZkF4U1Ewb3Rs?=
 =?utf-8?B?aW5ady9mSFU2VDdmaTNTU3NpZ3dON0djb21yUE9lWGc2ZTJXTXZFdXUxakRJ?=
 =?utf-8?B?QWR6VHhHamxPMjlsSVVLbVpvNXlOcmIyT3cyeUpFcmV6VnE0amY5QTdINmpt?=
 =?utf-8?B?ZkZKY051VEJGRDFCWTB6VUJMWlJ2SUJrT0Z6ZWZydnpHZ2k5N3AyR0xPS0N5?=
 =?utf-8?B?b1lPcFJ2R0NodWU2ck5pRjdWc05WQ3NkVGM1QTF6WE0xMjBhVGFRSzc1ek84?=
 =?utf-8?B?a1NMZXA2WlNUa01HTDEzYWdaZUxRQzErR21PYjlhNGVGQThaampHQlJ4ZFQ5?=
 =?utf-8?B?M3R0UGZoV2h5SFJYYTJoeEc4WXhUM0F1UzA3enRMQlh0ZStxempaQVk5b2wz?=
 =?utf-8?B?Uk5mKzFGNTBMdFJqVll4RnBVQjRXMkJyZllCZ3RiOTVHZUdkVlFYTmpaU0Zv?=
 =?utf-8?B?eDBVVzhET3k0NlpPYzVJK1ZWRlVmNmhmZ2t5cy9sS0xKaHR3Y1liUUlweUZZ?=
 =?utf-8?B?SVRvd2lqczBiQW55Y2dqMzJmM2NxUVUvekgwOW02dHZxTDJhLzJUcTFCNUg5?=
 =?utf-8?B?VWwrd2ppcFhoV2JYSGlGVjFhVFdodXFHakx0RXo5Q0Q5TTU0eXU4dkpGR0tY?=
 =?utf-8?B?MjBvOVJLcE9kR2VNc2NMY3RGM2FkZHRZYTFsNHU2dFM4NzZRdDdCVjdNUzBN?=
 =?utf-8?B?VkRsNEV6Skc3ZGJWZjNzZlRhMFl2Y2NIQUM3UnBXQlI0V0svWE83OTZpcisw?=
 =?utf-8?B?ZmhGN1g4aUs1UDAwMWZRQmc2dVdvNFF6WlJ4V0NiYzUrbkloMGdzL0JneXgr?=
 =?utf-8?B?SzB2Q0UwZnUvbEJBUVB0aVU3K25ETEE3emU3Q05YQkZPcExKczQxZWxVdmtJ?=
 =?utf-8?B?bmFxZzExZGc5QmhHSWtXbXROTjhxdXJHRXZjK0xaSm1xRE5HNEFsdktGNGVn?=
 =?utf-8?B?VkFLSTBVNy9RY240UDZZOGtNTWFOdWJWWStMQmVRUFpCUnJzckMxODVyRGpm?=
 =?utf-8?B?VkhUaEk1amhZWnE0enBLcG0zUklGblk4TkFCbGpscFhKRmN4U1E2Z29HSXVq?=
 =?utf-8?B?KzMzSW83MXBmdXNsc2RlNkVOc3VZdW9DQUw2YUYxdTUwOEJYUzR3RkQ1RlZR?=
 =?utf-8?B?UTZVNnNhL0N6eTVtZVJiTmxFS3dVOVBNYTM4cThyMTdNajBaUmV6VXZ0NHg0?=
 =?utf-8?B?UWZPdzFVWFZza1JGTnRuMStkbUE4TnA4SitVY0dJR0RvY3g0c2NxakMwT0M5?=
 =?utf-8?B?TUY4d2ZiUW9MamxHbUo0NUpya2NRemhLRHRNbXhJKzNhWHVyclFNckdOeGps?=
 =?utf-8?B?UFFMSFVIMlV2VmtNeVY1dGQwRG1IelVVendyTEU2OXlSaDUvWVVtNnhDRm0w?=
 =?utf-8?B?WUNNRmxGMEdSRzZNaWNxK1cxa0tPcitrQTVwK0ZuY0E2eVdXMExWa3ptdkox?=
 =?utf-8?B?azRtRkFsT01ac2tzZ2k4eVRuTnBkOXdMQ2JGNjU2NGRmNXY2eVNIdlZkRnNP?=
 =?utf-8?B?OHhsd09WQ01hYnU2V3hXUXhNWXJ5RTdQNk1aSEFXdU1nT1RVM0s4YkNyZGFl?=
 =?utf-8?B?bUdEMjl1bTFKUmtKaStzbCt6SkFxNkhPL3k4cGxuK29OVVFDOUdlZExsQUZo?=
 =?utf-8?B?UEl4c2pKd1oxaFBkOWp1bXBrRjBXeE5CQzVDZjFLNDZ2b2dEWWw5T2NlMi9i?=
 =?utf-8?B?aDNGbU1Penl4OUhERVNSb0dhRjExZTF5YVlPZ2pkejZWWTVDZ015cTR2Zk5v?=
 =?utf-8?B?ZW5rODhKQ25pb0R5eW9MSmJNblFvMFdnNjljdkdvUWQ4amlzWUtpZ2hDVEs2?=
 =?utf-8?B?WTJ0MTlzcHBLSE9RdWt6ZmsyMzc0bVI5WVBUWGE0QnhhdnVyR0MwUGlVaFRU?=
 =?utf-8?B?SlFoK3pBU2dZOGgySjE2THFXSElJZlJkOENqeWVuZHlPUktrYUFIdzhVZnRN?=
 =?utf-8?B?dkhKRmhtNjdRcTFhZXZWSmtiTVgxU3Q5VUtpVS85NDRkK2R2QndkMjhGNEcy?=
 =?utf-8?B?VUZCc0JTdEhwaHgvOTFsaXZaazR2UEtKWmxWZ3JyNjlPdlJSNytMYzdJeU9I?=
 =?utf-8?B?UXcxbTVQeEk2UlJkNEYzQ29vTjllMlRtOStXQ1daM2daak0rODgzZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e6c308-9730-4955-e0d3-08df196f7d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 12:37:54.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35Nl3bR3rbX4Ex8aD28wCEoBhFJ8tuPhhMnNqLsLQh6K5T2H2T2aPUBY9cYFJqTZIZ26/73Mfh3o4MkLTRltZjMkEOVjLbBWuT27XmY1VxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8127

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMjMgU2VwdGVtYmVy
IDIwMjYgMDk6NDENCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzVdIGR0LWJpbmRpbmdzOiBjYW46
IHJlbmVzYXMscmNhci1jYW5mZDogRG9jdW1lbnQgUlovRzNMIFNvQw0KPiANCj4gSGkgQmlqdSwN
Cj4gDQo+IE9uIFdlZCwgMjMgU2VwdCAyMDI2IGF0IDEwOjE5LCBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVu
IDxnZWVydEBsaW51eC1tNjhrLm9yZz4gT24gTW9uLCAyMSBTZXB0IDIwMjYNCj4gPiA+IGF0IDE1
OjIwLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4g
PiBEb2N1bWVudCB0aGUgUlovRzNMIChSOUEwOEcwNDYpIFNvQyBzdXBwb3J0LCB3aGljaCByZXVz
ZXMgdGhlDQo+ID4gPiA+IFJaL0czUw0KPiA+ID4gPiAoUjlBMDhHMDQ1KSBDQU5GRCBiaW5kaW5n
cyBhcyBhIGZhbGxiYWNrIGNvbXBhdGlibGUuDQo+ID4gPiA+DQo+ID4gPiA+IFJaL0czTCBoYXMg
MTEgaW50ZXJydXB0cyBhbmQgMyBDQU5GRCBjaGFubmVscyBjb21wYXJlZCB0byA4DQo+ID4gPiA+
IGludGVycnVwdHMgYW5kIDIgQ0FORkQgY2hhbm5lbHMgb24gUlovRzNTLg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+ID4gPg0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW0NCj4gPiA+ID4gbA0KPiA+ID4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQN
Cj4gPiA+ID4gKysrIC55YW0NCj4gPiA+ID4gKysrIGwNCj4gPiA+ID4gQEAgLTQ3LDYgKzQ3LDEw
IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cw
NTQtY2FuZmQgICAgIyBSWi9WMkwNCj4gPiA+ID4gICAgICAgICAgICAtIGNvbnN0OiByZW5lc2Fz
LHJ6ZzJsLWNhbmZkICAgICAjIFJaL0cyTCBmYW1pbHkNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAg
IC0gaXRlbXM6DQo+ID4gPiA+ICsgICAgICAgICAgLSBjb25zdDogcmVuZXNhcyxyOWEwOGcwNDYt
Y2FuZmQgICMgUlovRzNMDQo+ID4gPiA+ICsgICAgICAgICAgLSBjb25zdDogcmVuZXNhcyxyOWEw
OGcwNDUtY2FuZmQNCj4gPiA+DQo+ID4gPiBJIGFtIG5vdCBzdXJlIGl0IGlzIGEgZ29vZCBpZGVh
IHRvIHVzZSBSWi9HM1MgYXMgYSBmYWxsYmFjaw0KPiA+DQo+ID4gSSBhbSBhbHNvIDUwOjUwIHRv
IGdvIHdpdGggZWl0aGVyIHNlcGFyYXRlIGNvbXBhdGlibGUgb3IgYXMgYSBmYWxsYmFjay4NCj4g
PiBMb29rcyBtYWpvcml0eSBpcyBmYXZvdXJpbmcgZm9yIHNlcGFyYXRlIGNvbXBhdGlibGUuDQo+
ID4NCj4gPiBTbywgSSB3aWxsIHNlbmQgbmV4dCB2ZXJzaW9uIHdpdGggc2VwYXJhdGUgY29tcGF0
aWJsZSA/Pw0KPiA+IGV2ZW4gdGhvdWdoIGxvdCBvZiBkaWZmZXJlbmNlcyB3aGljaCBhcmUgc2Nh
bGFibGUgbGlrZQ0KPiA+ICJyZW5lc2FzLHI4YTc3OWgwLWNhbmZkIg0KPiA+DQo+ID4gPg0KPiA+
ID4gUlovRzNTOg0KPiA+ID4gICAtIFNlbGVjdHMgcmVjZWl2ZSBtZXNzYWdlIGFjY29yZGluZyB0
byAxMjggcmVjZWl2ZSBydWxlcywNCj4gPiA+ICAgLSBTZXRzIHRoZSBudW1iZXIgb2YgcmVjZWl2
ZSBydWxlcyAoMCB0byAxMjgpIGZvciBlYWNoIGNoYW5uZWwuDQo+ID4NCj4gPiBJIGJlbGlldmUg
aXQgaXMgYSB0eXBvIGluIFJaL0czUyBIVyBtYW51YWwgYXMgUk5DMFs4OjBdIGl0IGlzIDkgYml0
DQo+ID4gRmllbGQgdW5saWtlIFJaL0cyTCB3aGljaCBoYXMgOCBiaXQgZmllbGQuDQo+ID4NCj4g
PiBTaW5jZSBpdCBpcyA5IGJpdHMsIGl0IHNob3VsZCBiZSAyNTYgcmVjZWl2ZSBydWxlcy4NCj4g
Pg0KPiA+ID4gUlovRzNMOw0KPiA+ID4gICAtIFNlbGVjdHMgcmVjZWl2ZSBtZXNzYWdlIGFjY29y
ZGluZyB0byAzODQgcmVjZWl2ZSBydWxlcywNCj4gPg0KPiA+ICAyNTYgKyAxMjggPSAzODQgZm9y
IDMgY2hhbm5lbHMuDQo+IA0KPiBPSywgc3VjaCBhIHR5cG8gd291bGQgZXhwbGFpbiBpdC4NCj4g
DQo+ID4gPiAgIC0gU2V0cyB0aGUgbnVtYmVyIG9mIHJlY2VpdmUgcnVsZXMgKDAgdG8gMjU2KSBm
b3IgZWFjaCBjaGFubmVsLg0KPiA+ID4gVGhlc2UgZGlmZmVyZW5jZXMgYXJlIG5vdCBleHBsYWlu
ZWQganVzdCBieSB0aGUgZGlmZmVyZW50IG51bWJlciBvZg0KPiA+ID4gY2hhbm5lbHMuICBIb3dl
dmVyLCBpdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IGlzIHRoZSByZWFsIGltcGFjdC4NCj4gPiA+
DQo+ID4gPiA+IEBAIC0yNzAsNiArMjgzLDExIEBAIGFsbE9mOg0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAtIHJlbmVzYXMscjlhMDlnMDc3LWNhbmZkDQo+ID4gPiA+ICAgICAgICAgICAgICAgIC0g
cmVuZXNhcyxyY2FyLWdlbjMtY2FuZmQNCj4gPiA+ID4gICAgICAgICAgICAgICAgLSByZW5lc2Fz
LHJ6ZzJsLWNhbmZkDQo+ID4gPiA+ICsgICAgICBub3Q6DQo+ID4gPg0KPiA+ID4gQ2FuIHlvdSBy
ZWFsbHkgc3RpY2sgYSAibm90IiBoZXJlPyBZZXMsIGFwcGFyZW50bHkgeW91IGNhbi4NCj4gPiA+
IFN0aWxsLCBJIGZpbmQgdGhpcyBoYXJkIHRvIHJlYWQuDQo+ID4NCj4gPiBPdGhlciBvcHRpb24g
aXMNCj4gPg0KPiA+ICAgLSBpZjoNCj4gPiAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAg
Y29tcGF0aWJsZToNCj4gPiAgICAgICAgICAgY29udGFpbnM6DQo+ID4gICAgICAgICAgICAgY29u
c3Q6IHJlbmVzYXMscjlhMDhnMDQ2LWNhbmZkDQo+ID4gICAgIHRoZW46IHt9DQo+IA0KPiBIbSwg
ZW1wdHkgYmxvY2ssIFBlcmhhcHMgaXQgY2FuIGJlIGNvbWJpbmVkIHdpdGggdGhlIG90aGVyIFJa
L0czTCBjaGVjayBiZWxvdz8NCj4gDQo+ID4gICAgIGVsc2U6DQo+ID4gICAgICAgaWY6DQo+ID4g
ICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICAgICAg
ICAgICAgIGNvbnRhaW5zOg0KPiA+ICAgICAgICAgICAgICAgZW51bToNCj4gPiAgICAgICAgICAg
ICAgICAgLSByZW5lc2FzLHI5YTA4ZzA0NS1jYW5mZA0KPiA+ICAgICAgICAgICAgICAgICAtIHJl
bmVzYXMscjlhMDlnMDc3LWNhbmZkDQo+ID4gICAgICAgICAgICAgICAgIC0gcmVuZXNhcyxyY2Fy
LWdlbjMtY2FuZmQNCj4gPiAgICAgICAgICAgICAgICAgLSByZW5lc2FzLHJ6ZzJsLWNhbmZkDQo+
ID4gICAgICAgdGhlbjoNCj4gPiAgICAgICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICAg
ICAgICAiXmNoYW5uZWxbMi03XSQiOiBmYWxzZQ0KPiA+DQo+ID4gPiA+ICsgICAgICAgIHByb3Bl
cnRpZXM6DQo+ID4gPiA+ICsgICAgICAgICAgY29tcGF0aWJsZToNCj4gPiA+ID4gKyAgICAgICAg
ICAgIGNvbnRhaW5zOg0KPiA+ID4gPiArICAgICAgICAgICAgICBjb25zdDogcmVuZXNhcyxyOWEw
OGcwNDYtY2FuZmQNCj4gPiA+ID4gICAgICB0aGVuOg0KPiA+ID4gPiAgICAgICAgcGF0dGVyblBy
b3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgICAgICJeY2hhbm5lbFsyLTddJCI6IGZhbHNlDQo+ID4g
PiA+IEBAIC0yOTIsNiArMzEwLDQ2IEBAIGFsbE9mOg0KPiA+ID4gPiAgICAgICAgcGF0dGVyblBy
b3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgICAgICJeY2hhbm5lbFs2LTddJCI6IGZhbHNlDQo+ID4g
PiA+DQo+ID4gPiA+ICsgIC0gaWY6DQo+ID4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4g
PiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ID4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+
ID4gPiArICAgICAgICAgICAgY29uc3Q6IHJlbmVzYXMscjlhMDhnMDQ1LWNhbmZkDQo+ID4gPiA+
ICsgICAgICBub3Q6DQo+ID4gPg0KPiA+ID4gTGlrZXdpc2UuDQo+ID4gPiBUaGlzIG9uZSBjYW4g
ZWFzaWx5IGJlIHJlc3RydWN0dXJlZCBsaWtlDQo+ID4gPg0KPiA+ID4gICAgIGlmOiAuLi4gcmVu
ZXNhcyxyOWEwOGcwNDYtY2FuZmQNCj4gPiA+ICAgICAgICAgLi4uDQo+ID4gPiAgICAgZWxzZTog
aWY6IC4uLiByZW5lc2FzLHI5YTA4ZzA0Ni1jYW5mZA0KPiA+ID4gICAgICAgICAuLi4NCj4gPiA+
DQo+ID4gPiB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0KPiA+DQo+ID4gT2suDQo+ID4NCj4gPiBJ
ZiB3ZSBhcmUgdGFraW5nIHNlcGFyYXRlIGNvbXBhdGlibGUgcm91dGUsIHRoZW4gdGhpcyBpcyBu
b3QgbmVlZGVkPz8NCj4gDQo+IFRydWUuDQoNCk9rIHdpbGwgc2VuZCBWMiB3aXRoIHNlcGFyYXRl
IGNvbXBhdGlibGUgYXMgdGhlcmUgYXJlIGxvdCBvZiBTb0MgZGlmZmVyZW5jZXMuDQoNCkNoZWVy
cywNCkJpanUNCg==
