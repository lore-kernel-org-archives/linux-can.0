Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792484433;
	b=atI4Jqdz17HTkjgkHKp8alTm9td0XuaifiJztBFDNiKKAWcAjoDvgCP5VcG3w0gp8vtt
	 TqFq2vPovxEuR/CmmvsIQ6Bdxca4364g8CJaJWMBE4xM4iAsTaWECBGhpYOc19VGpSPbA
	 nbgLaBpPhP7Lbjc5YTJCQd59szaDCO4F71qj+pBONWNbE6QH2ZUfCz6aW4XpKiI9eHpg5
	 2x4BGTTFpsVXiWSBUG6kkxIoeo7HYRVE/KALTONLhZPmKdFm9IaFXZBAhUpg4CH4MxOJv
	 qh+cyhUjn/iC7la7cu7mJYJR2SKtQEHn0SUxq5/0W1GyuDBpJZuFotbK0yzJHvVYdow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484433;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y3J1psadmDrOtVJOxY9k/FRqHm9s5JWrWk57+Rq9E0g=;
	b=vUNDtALwlpUyChLGliI/lFcAYGt7vdT/vdRLGjWbTubz9s2Y7GaTOgKLTBh7CcREk+pS
	 mMeY9lrYjVJkYr3ZT9vbSi4Lt0SoRwdVmnyoUxANSUJpgSBVBT4uWzvViM3rOcSI3uVWt
	 wkhM0FCRbaEyoixmECfHLv5nyaagbPUplklSAdc49qF8yh9w4GuUI15KLECkkP6ulXhZz
	 Q3VrM3I+lozWa/Qj01niqtoRPxFcNpgyvHsHVNXeft5EoWBy3i0TnRQ+rO57R5qQCxBKN
	 elREkryew4JyrmY55tHQ5YW7lR96QvhjSc4hdOt4Tsi8PJ8VkUlAZNqMGu6DuJcakig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=cq4hDjzS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.43
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010043.outbound.protection.outlook.com [52.101.228.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBE606A31D;
	Tue, 20 Oct 2026 08:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3EBE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=cq4hDjzS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE/utoVav+64sL1vZ1mkq8zYgCo66wfme0wht4k/KR85xMzOo5Vraf7i4xH7HRjHdbidQTAeAXSR61i0ndkzTu6JvtlwRHWXr0QTpYYLxRS6UeFezudKlPXtVJsVaHBsdmgH356SZvEULmIoQveSYSuUpBeBvqGQGNIBpXUxoN7fH9RE0Fvn2k/32vvR4ITk/fS0N5R9y5uv52D1Z/LDBFyGAje0UT6TxciP7IdcZNjDA4urBITZhPHiYF0Jzf8PS0rxxcBjfuc/EMmNU5cXOTU1IBDPZGq34MRatb7d3ki3GaoprsmYNWAGFCIB36bh3MWwishl2BzAHqQh0Ay38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3J1psadmDrOtVJOxY9k/FRqHm9s5JWrWk57+Rq9E0g=;
 b=JaDdlL8F4AqShqcFGSUCfWo5RdLxhWDNBIZpXwtmAd6fm8fURjTAKsvUy2vzUnyzyxe7uDNSWgPkXc8iDoeWLIjxZTSeZhXUQBBTaVl+EqMmBBGpzPZexPoj8z21RJhk5HdkafnBSQpYTB9ZMQ7xwekLjfCzO6NlpJ0NS9EujMQWN5jKuFBr9+RT3uP9PrXQ1GbBzs77YHftSMSsurWYfC2J7hZVslNRpfA6o82OU9/jm49JpvGtiQKuH9Dubp59IFqcSlhvD2/FrNPpJK6a0SyZz5UgnPob3IPR2BsiFulWk5VF2xBNzS5IwsagnbaE9gTP5BtoZRUYc5law7n+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3J1psadmDrOtVJOxY9k/FRqHm9s5JWrWk57+Rq9E0g=;
 b=cq4hDjzSJ6jV04GViAjnxVRJ1NlBJWE0cSLBZLWtd3BGTvE+eYeqk18StvUPLaJ3WJv5wdK6zW37YKI9zkfmsR62LJemvfyR+ay42FL+Vt8xm699CtnDc/I0Okv3Vm5v7KINqcW4ZnA5QQbfP1SzKIUAap/zC1RMVJIpOdq7UDg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14889.jpnprd01.prod.outlook.com (2603:1096:405:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 08:20:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Tue, 20 Oct 2026
 08:20:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "biju.das.au"
	<biju.das.au@gmail.com>
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
Subject: RE: [PATCH v5 0/4] Add support for Renesas RZ/G3L CANFD
Thread-Topic: [PATCH v5 0/4] Add support for Renesas RZ/G3L CANFD
Thread-Index: AQHdX8G33+JWXuwTZkSn31raahBWCLcGFjCAgAAA7BA=
Date: Tue, 20 Oct 2026 08:20:29 +0000
Message-ID:
 <TY3PR01MB113464E13B1CF41931EB3ECD986672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
 <20261020-auburn-kangaroo-of-diversity-dbd8e6@quoll>
In-Reply-To: <20261020-auburn-kangaroo-of-diversity-dbd8e6@quoll>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14889:EE_
x-ms-office365-filtering-correlation-id: ee586f8a-3a0d-435e-8ea9-08df2e830051
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|261009223027099003|10067099003|56012099006|22082099003|18002099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info:
 zArzY5ZDxCd6d/sea2Q3XfKzah4nrd4/rzhftxQFLM8gJe/Ijl7KCcf/fASNihcFyAWEdP2g2xeckpc/DYDrNPrJjCsERVmpWj9CIKjs4u9bz5Gm+XRiSQ9+SEo4MXlQ9G11ax98A3C1ZcOpmKrF3gcLv6RH3omtvONJDSotenoHVBSvGHeiSSpmLccsJ3u2R9K+sQ0Uig/vFsBYGLAKP6uL7EKGYlT4lyeKJPGOCPfjxm7P8Po6Eps+7wU4bxp1Al8m8imKJGznxp1+k9CkR6MNdNI28tflp/b+49ObLEYcH775xKja/cYM3EWNVXZKiY0CYhmt6aa4118mNGNCAfPNJ0AEJrLclg/HnxXF2tgK1/PO6OK/YszjS6+XCzC2khDeNmbJ7ghp370GoPU+qz1bqetMxjRCUrTZRdP+H1YfKEvzWLXJUvAIX/RQgUxPUIUoqkxJ6EiFfH2IPg/APSCxdEjDUW2/zrDHcQOASEIic5THKdlD2qcj+0B8lJKgRFw3fastwTU9hRphW4fz3JMDe72Bbb3SkQqj9Zxm4in0F2cQADW4ngxqvwZNAMPwiEj/4m1OjLJZjHGFr9DG3WgTa7uadOvFFhqBeNHuGNVUCsemRW+u7bO8PTIKri8pu8bRb9jgsQ0XRpGbD81zSuaii4wCHJUs6YEcffNSz1M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REZtVm91WXFGbzg3SE9qekgrL21hdG1qdzhweWZkL1hzR0NTT0JraW5QdHNo?=
 =?utf-8?B?VUExUUkrSWRUYlZiM0RUbWpSdkFvaHBLSWIzbmtqN2UzVmU5MUMzeXhDbThC?=
 =?utf-8?B?NXQramxCbzhwZGJuK1lwOGxFNjJueVJ4Mzl2U3pRQ0x3TTd4cmZoMmdveGRh?=
 =?utf-8?B?SHVwMjRvQ0kxSHpkRGFOdjhWUExJVXZPa0M0ejNOcndwR3RrbnRUZnpWRUxa?=
 =?utf-8?B?bnRmM2U4U2tMSHVBNzRnb3dKTXpXK1l5RThOZm5SaVVmamJ3SnlPeDNMM1pn?=
 =?utf-8?B?dkZLL1YrNzNEODFoWWxyMDhZam90elBJVmdhNktYRkdsR1BiMHZTazYyUUFn?=
 =?utf-8?B?OGhhL2FYOWJyTG82ODhXRjcvdW5rRjVDajZaSGdiNGJtck1JTmViU0s3N21U?=
 =?utf-8?B?QlJEdWxzdGVVcHZLR0pUSEpEWithWi9FK2ZGU2RJTnJnVUc2ZXFIdXJLa0N3?=
 =?utf-8?B?ZVlXQUdEc3BjTHN4dzkzVnZmNnNTMCtBS0xmWHU1eEFpaEN5SXJXY29QM3Nv?=
 =?utf-8?B?Wkp3RVhKeGgyTVp5RHFyMldUWldlRmhaU3g2WWFndE41aWxoY0IwZ1R1V2FZ?=
 =?utf-8?B?L1FaaklLVWJDZ0pEMGVnTGJGQ3VpV3lCc2ZKWTUwMkRXR0tGRm5lcG01MWVr?=
 =?utf-8?B?V3VCejBuV3pvMGNRR3hJZDdsNzA1M0tFT1pPSWlqaitiNFpMRlBJcHVSY09t?=
 =?utf-8?B?ck42ODd4N2w4MHcwY1BDc3dxOEVhMklpdll5ejYxTyt3b2dIb0pYZ05QbVJG?=
 =?utf-8?B?Z1dyaWxLUlBETm1XRlpzaVdzNUk3MnUyS3JheHdpcFhWUm5Zd3p0VHhsL2p6?=
 =?utf-8?B?STZTSmx6OHEwQXFOWFdYbjRtc0xUMDAvSEIveXZtaW1ETUxWSDgrYVlWNFgx?=
 =?utf-8?B?Nk9jTE5OYXpFZFA1RXc1KzE3V2ltN0JKTUI5ZGRTR1RYRFluV0Rvc2RSMXRk?=
 =?utf-8?B?anphSkx2TDZwRFIzTUZhamVyeWxRVzN0NVo5akZacEt5U2tBbzlBWTZPMHll?=
 =?utf-8?B?bEsvZlRmbXM2d0o0Z1haZW52SEhRc29ydTVzeEVLVGQzZFd3Y2o5VW4wNm5B?=
 =?utf-8?B?MG80OUpyR3ZyRmFDbVhSOWc5M2RMdHBjdlJPQ0xVTUdtWnZiNFNwZ3VDaXhn?=
 =?utf-8?B?V0MrWUN5VkJaZ1FLcDAyQTJpaHI1d3c3dkUrRHZWbnlWQ3h2SEdWYjhjSmZS?=
 =?utf-8?B?UnloVlM0OGtjSHVaK2VNT3R2UGo2Ung3VDBIelUwRWp3c0d5dzBmelBtZG9t?=
 =?utf-8?B?a0h2NjcxVjk1UzN6U1FaV2FJTzFRYVdBbndIZFBSa1VKTW5sR2pJZlVBRXk3?=
 =?utf-8?B?MVlyQzZuUlRKVWNkZmhIdk00MXdWSWVWY1NJQ25kb2g4dWNJUkNlQTJ3NHZh?=
 =?utf-8?B?RHhzb1VaRjc2N0xMNFNDbHkxUzkrVlN6N0M2Q0hHemtpdWtDWm15SDZ6RnBP?=
 =?utf-8?B?M3BDNUlBdElpSytwL29mcWRQaDZqb2NyWUtNd2c2bzFqdEpDVXpqMVNRNUlU?=
 =?utf-8?B?ei9kVlFWVEJiR3F5NjIxT0E4K0hGaTUvSWlTVGFWVXo2VUQ2Y2w4MlprTEls?=
 =?utf-8?B?UzJJUUkwL1oxUEcxL0xDZXBvWHBFazFvM3R6Znp2aTF2T1piZjBSb2ZZTG9k?=
 =?utf-8?B?QlJQL3hrSWc3bUFKa3kwNHNaMEd6YmhUY3EyRnZ5amJkTStoeXZ4UmNGN3dM?=
 =?utf-8?B?VW83eW9UdXcwRWRqUEVES2ZsOGgzTDRKSS9ISnh6RkJqSTVRTEhQVWYrc3JM?=
 =?utf-8?B?TFJTMUYwWWxOQmg0U2wrVjVxenJRSVZHcHpVOWM1YTArcVo5ZXduZTlNbmRW?=
 =?utf-8?B?dnZ3bWhObmdIUG5QQTR1cUNyb2F1bWF0eENRWGU2UXU4NGcxQ2dlb1NSL0t1?=
 =?utf-8?B?RkZsOTN4c3NRUFNrTlJUZW1NS3FhWDMvY25sZzEyVVExZVdpeVVhc1h6QVhF?=
 =?utf-8?B?b3ZFcGZwcXlCUGNqWXFQejFaRGdrTHc1SWJNdkpvdDZueEZPQ1pDVEtoZzhS?=
 =?utf-8?B?bWdvekEvVlorQWNvaU5HRG5OMHBMeXk3NHdlVUlIUlRqMU1lNGFpOFJxYnZu?=
 =?utf-8?B?dnF0cU9xTXRYT1RDbG9mSnJ0OERuZzI2Q2F2Y0M3Vm90NURHTXZQbkpYQjEz?=
 =?utf-8?B?SjFVbVZFbmkrVlBtdEg0OUpsQUJ3dnppcTA0c0s5OFZQclBWaGlQUzJ1cUNZ?=
 =?utf-8?B?SGwwUTQ4eFlGdE51REVHS1p3RVZXeEF5TkJnbTZ0TkxOdkFPckN2MnUrMnND?=
 =?utf-8?B?QktnSmllVElOTjByYVpqR3BxWE1HanBMUlYvTzhWdFJWVld6V0hINEpTQ2FF?=
 =?utf-8?B?N3hqLzdCeERDekJuVnVNNjRsdUdsOFZjbUVzRHU0SG8wNnFXN2xjdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee586f8a-3a0d-435e-8ea9-08df2e830051
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 08:20:29.0314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgHfaJGv78c7Xq4CTHRI/SfHmy8d4UwimJoqLvsCrFahBGkvFLokIrCMkZs+fgjt0SbHQFS1byc/D717fsN6wnsids3zeZxlCNsjRbrkFRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14889

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAgT2N0b2JlciAy
MDI2IDA5OjEzDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMC80XSBBZGQgc3VwcG9ydCBmb3Ig
UmVuZXNhcyBSWi9HM0wgQ0FORkQNCj4gDQo+IE9uIE1vbiwgT2N0IDE5LCAyMDI2IGF0IDAxOjAy
OjEyUE0gKzAxMDAsIEJpanUgd3JvdGU6DQo+ID4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gQWRkIHN1cHBvcnQgZm9yIFJlbmVzYXMgUlovRzNM
IENBTkZELg0KPiA+IFRoZSBSWi9HM0wgQ0FORkQgSVAgaGFzIDMgY2hhbm5lbHMgYW5kIDExIGlu
dGVycnVwdHMgY29tcGFyZWQgdG8gMg0KPiA+IGNoYW5uZWxzIGFuZCA4IGludGVycnVwdHMgdGhh
dCBvZiBSWi9HM1MuIFJaL0czTCBoYXMgMjg4IGJ1ZmZlcnMNCj4gPiBjb21wYXJlZCB0byAxOTIg
YnVmZmVycyBvbiBSWi9HM1MgU29DLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgZGVwZW5k
IHVwb24gWzFdDQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbWtsL2xpbnV4LWNhbi1uZXh0LmdpdA0KPiA+IC9jb21taXQvP2lkPTJi
NGE1MDU1ZDUxN2IxMWJmNGE1NjcxY2VmMzJlNGQ3N2JjNDU2MjYNCj4gPg0KPiA+IHY0LT52NToN
Cj4gDQo+IGI0IGRpZmYgJzIwMjYxMDE5MTIwMjIwLjE2NjE2My0xLWJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tJw0KPiBMb29raW5nIHVwIDIwMjYxMDE5MTIwMjIwLjE2NjE2My0xLWJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tDQo+IENoZWNraW5nIGZvciBvbGRlciByZXZpc2lvbnMNCj4gR3Jh
YmJpbmcgc2VhcmNoIHJlc3VsdHMgZnJvbSBsb3JlLmtlcm5lbC5vcmcNCj4gLS0tDQo+IEFuYWx5
emluZyA1IG1lc3NhZ2VzIGluIHRoZSB0aHJlYWQNCj4gQ291bGQgbm90IGZpbmQgbG93ZXIgc2Vy
aWVzIHRvIGNvbXBhcmUgYWdhaW5zdC4NCj4gDQo+IEkgZG8gbm90IGdldCB3aHkgeW91IGtlZXAg
bWFraW5nIHRoaW5ncyBkaWZmaWN1bHQgZm9yIHJldmlldywgYnV0IGl0J3MgeW91ciByaWdodC4g
SSdsbCBza2lwIHRoZSBwYXRjaA0KPiBmb3Igc29tZSB0aW1lLg0KDQpTb3JyeSBmb3IgdGhhdCwg
SSB3YXMgbm90IGF3YXJlIHN3aXRjaGluZyB0aGUgbWFpbCBJRCB3aWxsIGltcGFjdCB0aGUgYjQu
DQoNCkhlcmUgaXMgcHJldmlvdXMgdmVyc2lvblsxXSwgcGxlYXNlIGxldCBtZSBrbm93IGlmIHlv
dSB3YW50IG1lIHRvIHJlc2VuZCB0aGUNCnNhbWUgc2VyaWVzIHdpdGggcHJldmlvdXMgbWFpbCBJ
RC4gSSBhbSBoYXBweSB0byByZXNlbmQuDQoNClsxXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjYxMDAxMDc1NzQyLjIxOTYxLTEtYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20vIA0K
DQpDaGVlcnMsDQpCaWp1DQo=
