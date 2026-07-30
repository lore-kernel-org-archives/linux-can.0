Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3D3A0B24;
	Thu, 30 Jul 2026 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388654; cv=fail; b=IS/eSuE7zDfHiGsKf+WBupVcHirfndAB3j5kPONs2LB9HW+iotbWNYObWWsxX1S31dhaf5WmXJBryCUeKdCqr0Mslwa7d6rwwgn/fQXaZzoHLoTx+4nCVPX01c9yrPeI8oj2yDokT8AiGlTQKSnJlvnvGDZnDfHLuepQjcBHplk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388654; c=relaxed/simple;
	bh=e+HaPjwqGXKy9EfDhJyLWn9+L7PMNhjeVEVLkrEoUSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWeeR8NYMECBjaZz42rSxyvqFWDxYDbLaG6pwKWNW8JbEk8NZ1Aqiu68hAFpzHwEh+au+Kiw1LcuvtRX+3GqpHYsE26VnqTbbhYAnyuFYfr0W4muWj0Y+EowDS5SFKOjJw5vD6WDZ6lkn0ELLtFUbCGSqSgJ7tAD9ZCXSXpsgYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S1dCNliB; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S1dCNliB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq0uYOC6vRGwPdL+Fr4hJI268fEljfk0i3Lb6YZzJ+hMkzcybXP8vO+BEx6kXmX85t/FKCZoi3G3h8BRvfA0BU5cdXduDgCE9M43x9Qc8JwPKj9jdlMkpXLKy3O7icJUDdI7nnnjpOXjxwVM5zXBOpsWm+d/AOpmw2qS/ZLPtiIPb9tQxmwnvJwugZFd8muyMU80HJLQ0rdMUY21CybT38ngmobuj7eSGb3l+JqdRvIJjQD9KGdUj3po+Zk9Xl75xtW3z313ULDT7lDIqq73fbDHE8V8+9M/8Pl+EUzLCn7iQ8P9wdD1eXJIY0EHl4A9ua+pcWlWTGXAn5sZpmjWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+HaPjwqGXKy9EfDhJyLWn9+L7PMNhjeVEVLkrEoUSE=;
 b=SLucS5rSvaxHNQ+mJ910yXzA3aszFlMNuUjaURB9Za+/BgNCTHSHIRD190I/lGFZe749Lf0gOQdaDDOFVUxcHYz0QbMeK9Pj4nPAMB2outXHC0AvIovxEYYHDxsVQzrAn6DzmK5/IGAM0hgvKHLHNk0GceS8eCeJQ/NqTcb1STr7rpVEsz6f0yHQ9ZiOkPsAuCzClSSJ+CKGcpxf7gxl/Sa4yynL7YY8apHq7rXf9EhXS1qKpqSdV8EuWbpEhKHzJmeBqEK2GHOUm6Zu7KC1RGYjSNpLa1lai3+eQSG7EIBHq1518Sh89c//ciqoLl/C2WtVHYubpEwLCPz3+TVgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+HaPjwqGXKy9EfDhJyLWn9+L7PMNhjeVEVLkrEoUSE=;
 b=S1dCNliBHcCQPjWLyowDWRHTVTfAdOrU/anYkvbx4jdZ7aGFjaw/BwIdESlN1yLiinvfso2TBikUGUzUfsN68YDQRE7qoD3CiWqRh+JxBchNU5W9LKiF/cTTPokzYYZrmZV+wD2UR3GfYObH9IyasP5ZGCgnMBqVYgIffHWelbuHotfDHEJh05z1Hhjj82CW40xLSBqiBsfh2ZC652j733lBFIFdrNewFnf20Tlt+MccEjTr0wCkQ6ai+nypOBjIJl5rHtClbatipPrxU4CVrybnEG4umYqRI6CDJHmE6iR7IR02GLgaV+xMr1ibk4RCrvJW4rkFeO+mjBTdt3XeoA==
Received: from AM9PR04MB8681.eurprd04.prod.outlook.com (2603:10a6:20b:43c::5)
 by VI2PR04MB10787.eurprd04.prod.outlook.com (2603:10a6:800:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 05:17:28 +0000
Received: from AM9PR04MB8681.eurprd04.prod.outlook.com
 ([fe80::294d:6f82:5102:ed90]) by AM9PR04MB8681.eurprd04.prod.outlook.com
 ([fe80::294d:6f82:5102:ed90%4]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 05:17:28 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Vinod Koul
	<vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Joseph Guo <qijian.guo@nxp.com>
Subject: RE: [PATCH 3/3] arm64: dts: imx95-15x15-frdm: fix duplicated can-phy
 node names
Thread-Topic: [PATCH 3/3] arm64: dts: imx95-15x15-frdm: fix duplicated can-phy
 node names
Thread-Index: AQHdH9wzbfEysbC4RECJ0GqgrzSrRbaFhTyw
Date: Thu, 30 Jul 2026 05:17:27 +0000
Message-ID:
 <AM9PR04MB8681A8151B95F61A4AB57D1F90C92@AM9PR04MB8681.eurprd04.prod.outlook.com>
References: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
 <20260730-can-share-silent-v1-3-63fd603f943d@nxp.com>
In-Reply-To: <20260730-can-share-silent-v1-3-63fd603f943d@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8681:EE_|VI2PR04MB10787:EE_
x-ms-office365-filtering-correlation-id: e1e77a79-9850-47de-85e9-08deedf9d937
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|23010399003|38070700021|921020|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 B79z26kac9BMiag8apffR6bnNFCHAKuutvJRJr1wWBwZRgoampwrVhikrgfvdiFOh1F1eSmwj0y6/GbV/mpHO7YVqdiS5Gkg6dZQytY6z8gQofX30dBgIj1YbH8SSO11UrklJjf5C9Q2tVmWF/dHBzMS4XK8RIEN2q7OWVpcFJlOgeNSkCx43ILBnkQAuYm8YOZ0ntqjv6LUciBqhs3A4MetHa+8dlvnqamNWL9Kd9er55g/U/4Won7RDPOU1dPhCkJKSbtKBQIJt4ck2Tz1vHiditJ/RUKc5UxhOsj/T4L+IL3JfLfiYld4N3tYjgD72DMvh+kbLBF17T8M9FoiCfF6+k/P66S+JJsr79jIo5fb0EFL57TwhdwwahWbwDGzkqPIxKOxGZsCmrLlahXLFA/1klJkDRQI6FAclDLOUZSjCHUb9M+S7s6lhzQjv8LxUGSSKuT1u0rJCVY1AT27aq3CbT7y/Ui6YNFk1ORbgDiGyasyxcsLuklI7Gpb0El2JxoyrgKofX0+a5plmozagGN5YppHzuUE6ORVELl3NY5vGgZexlH3DH+ykN6ZWX/CYf8jMkzTElVfPjgjuPFxf0vrDjazrcLb+RlYFwX8ACI2Q4RmJvyPpmVD2jGPt32BYJgh5bDANBt+8Yjo12P/zt7OXYcJEy2sLP9Yq2tR5BE1PJKGUo3wBzyB5+4YHd4sNq0z63UrKEx4RnZr7fao3Q/2Sy2MhO7cuHW8N5OlOIPiJZ7v9JfoO6td1dKZznPP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8681.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(921020)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVBPUW5oTjlXNnR4N2pNK0hadlhvZlc0aFVPaldUUElWdWVocklDMlBZeHlJ?=
 =?utf-8?B?MHM2RWU0eko3N2x2bkhKNkM0N1lIWG9ocm5DMm1LZEVSczk0RkRnbVpYRGdP?=
 =?utf-8?B?K1BwTFFESnRkaUhpNVkwZjRvajJKZDdZbmIrN1BvdXpCcm1vYVY4VG1mbXM5?=
 =?utf-8?B?R29zUjdkY1pndG1sTjN2OUhBZm56UElsRVoxYm1qVk80VG1DQ1hjbWY5OTV3?=
 =?utf-8?B?LzVrTmNCNFE0M1VUZGRXRU0yYzlEUGQwa0xrbHJIUzhBdElaMWNiWUtSd3lB?=
 =?utf-8?B?U3dzdDluVWlXRUNRVmx3aXZ1VFFDQzZzdVJjWHBhVEpnaGN6d0VLOEhOMmp5?=
 =?utf-8?B?azY0Zko3NTZ4OUdsbDVPeVhJNU1qUmJvZndZN2hrQy9mRHdFakNqeGNYUjRu?=
 =?utf-8?B?Unc0QjBHRDVNZndCL2lBWkhJTG84QXJWMWUxUWRCQXN1bmFYOC84WG56ZSt6?=
 =?utf-8?B?bEdndU1VaTA4anphaUhPTk42YWozTEVBOWNsRUVKbnl2VFZ3TFE3aVRiZXhC?=
 =?utf-8?B?TU9EMm5FTG9YbVBWam1HVWxqUXJkam1VcEdEZktmQklzbUlCUi8xZE5WcGdJ?=
 =?utf-8?B?eVMwQkpST2dKbDdSTTU5WStmK0ovNndWUHZyejlKdFZHRFZhUytPRGdBcUV5?=
 =?utf-8?B?WnAzejdYaStQN2JNWWt0VnRaMmh3MEtKQnd1WXRySFBKMWN0TkV1MWcwckxO?=
 =?utf-8?B?bWhYeWFtREk0Wm5nSzRLV1d1VXNiWHF3S0VtWTNaVlZRT0RJUjF2M3hPY2pB?=
 =?utf-8?B?cGdFeUJUUTRSRGt0NVAwUGhWYlhDVTBoTGZtR2k5UHpyVmkzR05XR1hIUnZP?=
 =?utf-8?B?bG1IeFd1bGgvMEV4elhzYUZFclhialJ5OVE0RDlYM2lSRTJoSnJFVTRTR093?=
 =?utf-8?B?NnFrdVN2TFFkRU9VQWFoM0lWakhjekJTVmFGUG8vZEJYN1cwRE9peGMxbmVk?=
 =?utf-8?B?UEpMencvRFVvL3BXVGN2d0lGVjB1M29zT3ZjYXlZejVyd1FaWG5VNWpoS2Fy?=
 =?utf-8?B?bnoyT0tGYTZET25HWGNMNnhxZFBkdWFmNHVHQjRrbmhPRi9HS1hFaVg2UG1N?=
 =?utf-8?B?a01WNjFnQmwybXFkSFo2UjU3bjJId0x2aWxWeEl4cWdyU2ZFTERnTjFaM0RP?=
 =?utf-8?B?SlQvblpGTTJQUG5QSCtsVzBpWGFjSlM5aTJQL09mVWkybFRXdTV5OU01T1du?=
 =?utf-8?B?SC9LOTd6bmlJK2E5b0hCV0tqem1NU2o5eXh6eFFLajBPY1I1K29BWDJwSE8w?=
 =?utf-8?B?QXFwNFJ4ak94Qi9UWitCTVRRZndadVQyeGtCd0VYSko3WHdrVDVLL1Fna0Fn?=
 =?utf-8?B?a3hUNVdDbmdqSExsQ0xnWFhuK1d1SGxZTnpGdVE3UzdUck9JemZnS3liMFhY?=
 =?utf-8?B?d0hvNDQzSlUwVEJvcVVYRFNRaENiQ284ckZRU0ZRZHdFWHZoRnU4Z01tODZv?=
 =?utf-8?B?ZWd6Z28vK05IZHFSY0pxbUk2LzdCbWgzNXM1Kzd4ZW5OUENneUFuRGxyRG4x?=
 =?utf-8?B?T0ZwS0t1SlAzdHI2NC9lemRlUXJsK3h5azg0c3JCbXk2WE9MZFBPTUpUTHcy?=
 =?utf-8?B?cTQ2WnVsRFh5Z2s3ZnNTT0h6Ri9Sc004WFQrU2hXM1BYQzNBR2VJT2kzYmZU?=
 =?utf-8?B?b29RQ1g4Wi83dFZLTnE0YnVIem1tcEVJRnJieVp2T1BHTDBRQS9FZWhvYmh6?=
 =?utf-8?B?YWlScHY0VFZYYnZJUkdWZmtHUUVoNC9jTXFZdkdtV1NOVjE3VEVKSXJTa3Uz?=
 =?utf-8?B?bTkycjN0cmF6Ym1mamFrNGd0WUdycHdCL3JGaE9LeVBMSWtMTDdxK09CUm5N?=
 =?utf-8?B?WWtUVkVlaUQvSUhrSVlmSHJBYjNHbU5ackpZYlZVZ1lHVVQxaGQ2MXdrbXBq?=
 =?utf-8?B?SW1mQVFkeUZkVHVuQXcwN0pFc1UwR1FBaVJSNTNzRzV0ekxOQm9IUW1sejRT?=
 =?utf-8?B?K2ZKUWkxUkZ4OGtjeEZkOWpXcjBiRktkTzRuWktPZkNKWkdxZXloSkZMd1Av?=
 =?utf-8?B?bFh3OGdlb2pRUjdjVDRhMFd2bWo4TTE1U2lKSXExTlhtSTlaay9HUnN4YUVS?=
 =?utf-8?B?bFdha0ZBVlRlUEZiS0NrbEZDTDJkeUZMRS82T2dCeTd5SDBDSkVhdFlZNWJ4?=
 =?utf-8?B?aWt2U01QbkpVZ1VZbitSNjYvSTJOU2l4b0pWSHBkWDZwbGRERFdlZlJKeGVi?=
 =?utf-8?B?dEpZWGNpL3l6eitod1RyR2RLS2hxZTdpdVBkb0IzeGJQNWVlQUhFeXJOS25K?=
 =?utf-8?B?YU1uZmxEZzR4ZkptdU14WlB5ZUNFcTMyd01UbkJSQ0RoSUJPN2pPcG42N0xj?=
 =?utf-8?Q?1SxL0Fsc7i7SzGtraG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8681.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e77a79-9850-47de-85e9-08deedf9d937
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 05:17:27.9723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aNxzlr3Ie6LF5Go6DEUwf+YaY0Fkx3hxBKpPxkwTQ/eC+lX7ZQCVIfxQC8sjoPdCwWSpdZKFBZcXyEzbSQKdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10787

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3VnaCBDaGVuIChPU1MpIDxo
YWliby5jaGVuQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI25bm0N+aciDMw5pelIDEyOjMzDQo+
IFRvOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPjsgVmluY2VudCBNYWls
aG9sDQo+IDxtYWlsaG9sQGtlcm5lbC5vcmc+OyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3Jn
PjsgTmVpbCBBcm1zdHJvbmcNCj4gPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+OyBDYXRhbGlu
IE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsNCj4gV2lsbCBEZWFjb24gPHdpbGxA
a2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4g
S296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtl
cm5lbC5vcmc+Ow0KPiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IFNhc2NoYSBIYXVlciA8
cy5oYXVlckBwZW5ndXRyb25peC5kZT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+
DQo+IENjOiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBsaW51eC1waHlAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgaW14
QGxpc3RzLmxpbnV4LmRldjsgQm91Z2ggQ2hlbg0KPiA8aGFpYm8uY2hlbkBueHAuY29tPjsgSm9z
ZXBoIEd1byA8cWlqaWFuLmd1b0BueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMy8zXSBhcm02
NDogZHRzOiBpbXg5NS0xNXgxNS1mcmRtOiBmaXggZHVwbGljYXRlZCBjYW4tcGh5DQo+IG5vZGUg
bmFtZXMNCj4gDQo+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gDQo+
IEJvdGggdGhlIGZsZXhjYW4yIGFuZCBmbGV4Y2FuNSBDQU4gdHJhbnNjZWl2ZXIgUEhZIG5vZGVz
IHVzZSB0aGUgc2FtZQ0KPiBub2RlIG5hbWUgImNhbi1waHkiLCB3aGljaCByZXN1bHRzIGluIGEg
bm9kZSBuYW1lIGNvbGxpc2lvbi4gRGlzdGluZ3Vpc2gNCj4gdGhlbSBieSB1c2luZyB1bml0LWxl
c3MgdW5pcXVlIG5hbWVzICJjYW4tcGh5MCIgYW5kICJjYW4tcGh5MSIuDQo+IA0KPiBUaGVzZSB0
d28gQ0FOIFBIWXMgc2hhcmUgdGhlaXIgc2lsZW50IHBpbiwgdGhpcyBzaGFyZWQgR1BJTyBjYW4g
YmUgaGFuZGxlZA0KPiBieSBHUElPIHNoYXJlZCBwcm94eS4NCg0KU29ycnksIGZvcmdldCB0byBh
ZGQgdGhlIGZpeCB0YWc6DQoNCkZpeGVzOiA5YmRmZWVkOTg5YjEgKCJhcm02NDogZHRzOiBmcmVl
c2NhbGU6IGlteDk1OiBBZGQgc3VwcG9ydCBmb3IgaS5NWDk1IDE1eDE1IEZSRE0gYm9hcmQiKQ0K
DQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4g
PGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg5NS0xNXgxNS1mcmRtLmR0cyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgxNS1mcmRtLmR0cw0KPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE1eDE1LWZyZG0uZHRzDQo+IGluZGV4DQo+IDBm
NDNlM2JlNzA1ODk1MzI3NjNmNjVmMTY5OWYzMWRkMzYxY2M4NDEuLjdlZDlmZjk3ODQzMmVkZWZm
NDE5OGYxDQo+IDg5MjQ3YTE1NGZjMTAxNmI1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgxNS1mcmRtLmR0cw0KPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgxNS1mcmRtLmR0cw0KPiBAQCAtNTYsNyArNTYs
NyBAQCBkbWljOiBkbWljIHsNCj4gIAkJbnVtLWNoYW5uZWxzID0gPDI+Ow0KPiAgCX07DQo+IA0K
PiAtCWZsZXhjYW4yX3BoeTogY2FuLXBoeSB7DQo+ICsJZmxleGNhbjJfcGh5OiBjYW4tcGh5MCB7
DQo+ICAJCWNvbXBhdGlibGUgPSAibnhwLHRqYTEwNTEiOw0KPiAgCQkjcGh5LWNlbGxzID0gPDA+
Ow0KPiAgCQltYXgtYml0cmF0ZSA9IDw1MDAwMDAwPjsNCj4gQEAgLTY3LDcgKzY3LDcgQEAgZmxl
eGNhbjJfcGh5OiBjYW4tcGh5IHsNCj4gIAkJc2lsZW50LWdwaW9zID0gPCZwY2FsNjUyNCA3IEdQ
SU9fQUNUSVZFX0hJR0g+Ow0KPiAgCX07DQo+IA0KPiAtCWZsZXhjYW41X3BoeTogY2FuLXBoeSB7
DQo+ICsJZmxleGNhbjVfcGh5OiBjYW4tcGh5MSB7DQo+ICAJCWNvbXBhdGlibGUgPSAibnhwLHRq
YTEwNTEiOw0KPiAgCQkjcGh5LWNlbGxzID0gPDA+Ow0KPiAgCQltYXgtYml0cmF0ZSA9IDw1MDAw
MDAwPjsNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=
