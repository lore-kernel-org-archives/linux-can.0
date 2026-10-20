Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499618;
	b=bq8dH3fezo3KnPwMeEhIB/MwoX8ytcRV4C74APutTVPVFWHWGJeCjZqRMB5l4CnNStoV
	 pzz+4t89MxOsOY2ej9WB+plYYQJciKTG/ONN61RuRoynYE4auogWno1YWQCSnVYCEXxwd
	 qh62xNC16xFhLCY/i8yBor30yNVFxAVTTymNfVo/7HQZiKI0V3jDNxzj4V2hDx+fCKPIG
	 EVs9BNhKobgadraSLJkb8RKQsM2ffZ0vY5BtulJmx7lfLZmC9gtLJYmbyE8OzrKICOKKz
	 b3UV12lKrwDnC3JW94UTNpka7OWXz1cFvJhpuQUO9qV8LmfsK0dsK5MNV4n1aL1C8KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499618;
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
	bh=xtrNnj4a3jNtExyOCynjASq4/0VisGx00kygUj8thBs=;
	b=gbZdN3QalMaPsMKEaLKczZv0AG+blwyDGeOtXS7nznsoPm4Va4ejybjlbPXz/UTdkZtu
	 QecVz0kxGAByPWUg0+RGp0sGyxxDogtQeIHK1q6pkJZcwq5pWeuqLpgUhPCPjj3/4pQMk
	 irCj63+tqaIsGoxBiTm1XTiL5ZTemuZBoK0nlkBvJxDlAmAuynRgTvdlxagaANS7iWx1y
	 JRQiBjxp+cJGF5RZrjrE0Ah+r9V9S1Fa9YXXOJa+XuHZkeGoqLZ1B0JZUG10gxWzQLZlo
	 DSm4ToJHQLvXXFzETi9EksWs6LgvY0TuRuRIiijeSLogeytRaDNCFmHZ0BOHB3URBVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Nv+W2J+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.51
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011051.outbound.protection.outlook.com [52.101.125.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D8606A320;
	Tue, 20 Oct 2026 12:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 341D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Nv+W2J+6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRPYw9EyL+A8IwE58c3U3xJoEqlM7NPBj60MPCzLNAGwv0DoLCevj/Y2b5Sm/CWLu+rHL7dVj9c1hXIklposq+M1tXsmmpzgeGQL2Y3f7E3HaxLk0SeOhBZOFoW/B0j34EuCfQVkjHd03pDHmrKV62S0rPCRXwCmr/BbxdSaf1K6xni/h4fEnkjcBAYf0v/nn9bE9AyG0HwPsRajkOm8DU3ZK7tfa0d4J89a/PQIECvhpWAt7GPe1IQI66fjIV8dYXTZL152w8tfIony+cME9Ww4dyxU3kqstA7B5xluLtpoAYAVFs87DiKYBPLqlKuO2tbVZl2d2R1H7cUirLi0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtrNnj4a3jNtExyOCynjASq4/0VisGx00kygUj8thBs=;
 b=C8TD8KjjScCZTvgXYPUZ/XlyBTkp+sf2lzNNsPFbTjaMVZm7zicS0b0xX0haw2oikBM3VjtUAvfQuSBGNzw2W0siIUs2Iig5/8Cn7YZEGeToMtJ3hIQ1jNQvwAtOVp6howoXbYG0YNu8F9bd7O9fKM9JZhfun2Z/u/FjZRl+5JFSc0WgQ0eJqxYbLyyZ/LsNr1HstKwTyuhO+0r91db5K1uHrD5czpZSqPKRc0Ug++1Wz8ssJotS2Cam/Fq46R7vcvimmj/7eSp3xY/Luvh806mAVIg1IGLCGPAvnVMWTvKEQ0vEPU290qtCx5wCYqVo//jrkMtOrZ6CPKyW7uM/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtrNnj4a3jNtExyOCynjASq4/0VisGx00kygUj8thBs=;
 b=Nv+W2J+6qQH3jyPnaoMfeo0c6suW+Kh/byFEzaWY9Zi/SD3RiGF/x0tQqvXWliepwLEqIarYEJThfHGBeOvUQ2Df0D6OSCo32zeEtzWqR1Y41VuruT23wFaEGc7g7TR59zYITlf/GTPXVeSyZu62ScsH0T3/6byguhO4HF8Wa3w=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12923.jpnprd01.prod.outlook.com (2603:1096:405:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:33:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Tue, 20 Oct 2026
 12:33:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: "biju.das.au" <biju.das.au@gmail.com>, Vincent Mailhol
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
Thread-Index: AQHdX8G33+JWXuwTZkSn31raahBWCLcGFjCAgAACNYCAAAHkgIAAQRrQ
Date: Tue, 20 Oct 2026 12:33:08 +0000
Message-ID:
 <TY3PR01MB113468FBC526A79B0709866F086672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
 <20261020-auburn-kangaroo-of-diversity-dbd8e6@quoll>
 <20261020-bold-wealthy-wyvern-891012-mkl@pengutronix.de>
 <TY3PR01MB1134698B07654C48820BCD41986672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB1134698B07654C48820BCD41986672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12923:EE_
x-ms-office365-filtering-correlation-id: 8344adb1-0868-4db5-3b66-08df2ea64c00
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 GrEnlEd+GspqLGCE2yUpvICcqBxFER9jc8HBpY0nt2CfEYlcSpNRMJzP7BTbC4amHenhlzBGLlTKM26OIxf/tWOoI1uwyTn384Yj0pcTmVNW+xEp+H8bea5qjgWGlIpBmWFsfmxc5eaxQqsfxc1N4lS1M92Jf7Xzo/nP1wUhrnIlNC0mKO0AL7l9IO9hnR8YZE7wa8eFErCmatbI3mqUjM34vw/jIpkyLfDtlL0G0mxXYM8gFLL1cQIt0qL/mRF7ob0rK2UB4fBvU1rAP74VuaXl/I1LHM7DNWYKIiMD7jpnSFGbNFhxEn+aW4uMutGCsYsPT2ABeCxwmK10erkb2esDJ2D5HPtDQosLXVBLRFkLbVlncV042zwiAEieLHzsnJf0VMvs/xoGn+NDMRRkndMCT4cdDXA78XYD1/C9FNDWVkmKmBV55QimruG7La3rYvOzzbEjtceXWxWVCiXpbbiDs0u1l0VTmCWt3lPnxN8eJFWJCoSF+/iExBrOt3+KIa+TxTr2OmKBCqm9y8Rg5WBPyiW+ndetiVVjn4vBTXb0gyKzIGlvxTtKD456RgH2qaD7/GMJ+QzjhJxEmhY2Hy5smL/6EnHih50uc5IsBj/ZustAxumCnq7bpo8y+1ZgT4+Wgst5MIs+P3Fs5IgiWP2zXsNTJBY0kyaynArk9m8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW5PRXdVeVZxeHVJcUlUMk9IanJQanBnS1RTbzlvU2s0M29mR0ttN3VnTENq?=
 =?utf-8?B?ekpRVTBMSU40NlVNbVhlTjBXbDQ1Y0ZFV2xZSmFOMURTQXVNcW5rVGppcVhO?=
 =?utf-8?B?dzQ3OS9iNzRwN1VVMkRFVTEzeEVLcWhPLyszQ1hqallnU1RpbHI2WkJhMzNV?=
 =?utf-8?B?eExTbXZMZkJFQlJYOFZlZnQxbDNIaFVHRytVM2cwVDNicHBQTE5xbjJ2eFpV?=
 =?utf-8?B?TzNMaW1pK3VjTWxEUmRibnN6OFJPK2NTZ0VheEhnWWUvNTE3RzVZR01FRDF2?=
 =?utf-8?B?My8vVHd0dld2T0dJM1R6QTZ1OVJ2SlRNUUdGQ241SVd5ME13ZXFOM25XNVZW?=
 =?utf-8?B?bEJ3SHdVYWNnZ0IyVmxiZDVydWFJeXc1QXhYanM3V0IwUlQzRzJaOFdLWDZK?=
 =?utf-8?B?elJSZDRCRGRkUitYRndPSW5vci9YdWV3d0hmVlkzTDArVWdjVEYvaFh2a1Vs?=
 =?utf-8?B?MTFWR29vM2FxeVZpNHc0Znc2a3BUSWF1YVl2T2J6T25aK0VaZjhZRnZXTEdv?=
 =?utf-8?B?b1VDTmNISVVHaCswOEVsRlNHcE5xYmZPOVREbUs4dEhVVGlEdEs1dHU2Mkw5?=
 =?utf-8?B?S2t6d01LVk51RXcrWkUxWnc5QVRUR0V5RlBjUmdieHRnditjR2lpVitBSHM2?=
 =?utf-8?B?eW0xRUl6VEJVNEVtNUNUb09yU2JCd1EzYmlHSVNUV2VnS0xGVGlNNTYrZG80?=
 =?utf-8?B?b3d6RWIvdXVLSEJQUXVudE9OZkFDcXNGcStuRW9Dak81aWg2VFZOSG1wUkJD?=
 =?utf-8?B?NXZPSVo5d2IvWWtPVmRqa0FsTHRRNUJrQXBQT3ZXRHEweWRrNHh0RWVoVkw2?=
 =?utf-8?B?SUJpakNsbTJqa3g0MkUwZmlrVTRmQ3d1ZitVZU95bC9jb3phSUtoSXQ1bXNB?=
 =?utf-8?B?bGZISUl2eUlaL1dJU20vMEdzdHF4Q2RpSmN6T3BUL3AvMmFMc25CMkdXcG4r?=
 =?utf-8?B?S1djSC9iUFhNVHA0ZXNQWUNEc0d4bE8yVU5pRmgyKzd1RFNFNzhHT1gydi85?=
 =?utf-8?B?UmNjOUpVNldOT0NNQjRxOG9oOTRNMWt3cDc0ZWFHempMOFRMWmhEVWpJaHBV?=
 =?utf-8?B?b2dRd2E4RGI5Uk9JdkpIemk4c2dldTlOcXlLWS9vbHNpazlYYUVkTkVXaERJ?=
 =?utf-8?B?aGFnTUEra0s2SUdCMUZnM1d4R0YyK3hmNktkQkV4aU5uU2dRU3RaNE9pbEg5?=
 =?utf-8?B?bnhmS3p2d0dHeVp6Qk04d2NrQ0xpdDlyZUZ2TlluYU43K2Q3ZCtIeFY3Szdk?=
 =?utf-8?B?Z2JjbU9BZWhwb05NeUZLQ2w2c3N0TGVTZ0FLYU5tVnR6eU1jUTFpUEN0U0xL?=
 =?utf-8?B?MnpBUXUxbW41VENiSGlzRjRxSTFjdERnRjRPdkJVeFRqZmdTdTQvc1M5Zk5Q?=
 =?utf-8?B?ZkpYc1p3OEdSMXhpeUlSTUVYRTQ5eUNFVENrSC8vcEo1aVZOaExXMytXVVNv?=
 =?utf-8?B?bTNLY1ZMSWJuY1QwY2JKM3YrRXhMZUZGTVlDS0ZlbVRYdFZHWFpSZHBpYUNQ?=
 =?utf-8?B?K1p4bGNMZGIxSFpoYms2VWtRMmJuSWJRZkdlbnVFRHBjcUpIQkptVEg0OXNo?=
 =?utf-8?B?d2tzVnVDNzhiRXhrcHFIZ0JzUWQxZHJhREJzSjBoRWk3NGpkTXlpRzU4WUJ0?=
 =?utf-8?B?bGd3TkhZTkpINnZFVTFoU2NNc2xKcDhYOEY2OWpvdFVsbFhIcXRFQStIaTQ4?=
 =?utf-8?B?dEJTbVcxWGUwYk9mcWY1OWFHZGQrdUJSSjArK3BtazVOMExCdUVVYWxiZ0VF?=
 =?utf-8?B?TjJ0eHljb0NCS0J1NXlYTXhmT0Zibmpub3IxYnFZbi8ydFJlVVB4Sjc4dDcv?=
 =?utf-8?B?V0hpRXBSZlBlRWJQSFhhOTNhVkdmTlhEUWo1VStDMHJRSTZJSUo3UFVGdjgw?=
 =?utf-8?B?a1RXazFEUVIzdjNHbFg0ZCszT0xkM296bFI1ZHEwajFvcmFiZitoa0ZUeGtt?=
 =?utf-8?B?VWF4S1dkWXB1NTgvUkxwYWx1YU5RL1UreWpaTHRUT3RSb3RzeGtJcVdkNE42?=
 =?utf-8?B?SXQ3aVkyZVczSVFVSFg3MFBnQ1QyVEh3aFR2MUdGZUNZUlRqemlNSXJubWdy?=
 =?utf-8?B?RjZzUkZhYWVNR0FEV0c5RmxXVFkxdlYwS2RiR3dHS3UwNms2ZHlaQktCa1Jq?=
 =?utf-8?B?NG9aY1RVYSt3TGlacG8zc0ZkWXNUM2FIdCtmMmwxNDZOZWZCUk5tc3Bidkxm?=
 =?utf-8?B?SXVweklQUExWcEdoZG1UNm1FWE1UdFNMUjE4dndxaTdNcitrbkVNSGE3ek9O?=
 =?utf-8?B?RU5SeS9yVWkxNmt4TllnUVEzY3U5TStFUmw5YklpclBrOVpvTEpUQTltVUdx?=
 =?utf-8?B?UGFPVmk3UGI3RDhUTjY2aHlWWExJdDhUQUhTUlE4bTJ4dCtvckpmdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8344adb1-0868-4db5-3b66-08df2ea64c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 12:33:08.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQ2nSXcUaP11h76zCZEfs3JmfRPXeI+ZA4ZGEDnU8D161BL2HQvBQNa9W/Uk1mhzVjXJvagBDKMXqphWTPuS80FXlGArLxNr4Q4BUcngnqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12923

SGkgTWFyYy9Lcnp5c3p0b2YsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQmlqdSBEYXMNCj4gU2VudDogMjAgT2N0b2JlciAyMDI2IDA5OjMxDQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggdjUgMC80XSBBZGQgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9HM0wgQ0FORkQNCj4g
DQo+IEhpIE1hcmMvS3J6eXN6dG9mLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+ID4g
U2VudDogMjAgT2N0b2JlciAyMDI2IDA5OjIxDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAw
LzRdIEFkZCBzdXBwb3J0IGZvciBSZW5lc2FzIFJaL0czTCBDQU5GRA0KPiA+DQo+ID4gT24gMjAu
MTAuMjAyNiAxMDoxMzoxMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIE1v
biwgT2N0IDE5LCAyMDI2IGF0IDAxOjAyOjEyUE0gKzAxMDAsIEJpanUgd3JvdGU6DQo+ID4gPiA+
IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4NCj4g
PiA+ID4gQWRkIHN1cHBvcnQgZm9yIFJlbmVzYXMgUlovRzNMIENBTkZELg0KPiA+ID4gPiBUaGUg
UlovRzNMIENBTkZEIElQIGhhcyAzIGNoYW5uZWxzIGFuZCAxMSBpbnRlcnJ1cHRzIGNvbXBhcmVk
IHRvIDINCj4gPiA+ID4gY2hhbm5lbHMgYW5kIDggaW50ZXJydXB0cyB0aGF0IG9mIFJaL0czUy4g
UlovRzNMIGhhcyAyODggYnVmZmVycw0KPiA+ID4gPiBjb21wYXJlZCB0byAxOTIgYnVmZmVycyBv
biBSWi9HM1MgU29DLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIHNlcmllcyBkZXBlbmQg
dXBvbiBbMV0NCj4gPiA+ID4gWzFdDQo+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L21rbC9saW51eC1jYW4tbmV4dA0KPiA+ID4gPiAuZw0KPiA+
ID4gPiBpdC9jb21taXQvP2lkPTJiNGE1MDU1ZDUxN2IxMWJmNGE1NjcxY2VmMzJlNGQ3N2JjNDU2
MjYNCj4gPiA+ID4NCj4gPiA+ID4gdjQtPnY1Og0KPiA+ID4NCj4gPiA+IGI0IGRpZmYgJzIwMjYx
MDE5MTIwMjIwLjE2NjE2My0xLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tJw0KPiA+ID4gTG9v
a2luZyB1cCAyMDI2MTAxOTEyMDIyMC4xNjYxNjMtMS1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bQ0KPiA+ID4gQ2hlY2tpbmcgZm9yIG9sZGVyIHJldmlzaW9ucw0KPiA+ID4gR3JhYmJpbmcgc2Vh
cmNoIHJlc3VsdHMgZnJvbSBsb3JlLmtlcm5lbC5vcmcNCj4gPiA+IC0tLQ0KPiA+ID4gQW5hbHl6
aW5nIDUgbWVzc2FnZXMgaW4gdGhlIHRocmVhZA0KPiA+ID4gQ291bGQgbm90IGZpbmQgbG93ZXIg
c2VyaWVzIHRvIGNvbXBhcmUgYWdhaW5zdC4NCj4gPiA+DQo+ID4gPiBJIGRvIG5vdCBnZXQgd2h5
IHlvdSBrZWVwIG1ha2luZyB0aGluZ3MgZGlmZmljdWx0IGZvciByZXZpZXcsIGJ1dA0KPiA+ID4g
aXQncyB5b3VyIHJpZ2h0LiBJJ2xsIHNraXAgdGhlIHBhdGNoIGZvciBzb21lIHRpbWUuDQo+ID4N
Cj4gPiBJZiB5b3UgdXNlIGI0IFsxXSBmb3Igc2VuZGluZyBwYXRjaGVzLCB5b3UgbWFrZSB0aGlu
Z3MgYSBsb3QgZWFzaWVyIGZvciB0aGUgcmV2aWV3ZXJzIChhbmQgeW91cnNlbGYpLg0KPiANCj4g
VGhhbmtzIGZvciB0aGUgcG9pbnRlci4gU28gZmFyLCBJIHVzZSAiZ2l0IHNlbmQtZW1haWwgLS1h
bm5vdGF0ZSAqLnBhdGNoIiB0byBzZW5kIHRoZSBwYXRjaGVzLiBJIG5lZWQgdG8NCj4gZXhwbG9y
ZSBob3cgdG8gc2VuZCB0aGUgcGF0Y2hlcyB1c2luZyBiNC4NCg0KSSBoYXZlIGV4cGxvcmVkIGI0
LiBNYXliZSBJIGNhbiByZXNlbmQgdGhlIHNlcmllcyB3aXRoIGI0LiBCdXQgdW5mb3J0dW5hdGVs
eSwgc2luY2UgaXQgaXMgZm9yY2VkIHZlcnNpb24gdjUsDQpiNCBkaWZmIDxtc2cgaWQgdjU+IHdv
bid0IHdvcmsgbGlrZSB3aGF0ZXZlciBLcnp5c3p0b2YgdHJpZWQuDQoNClBsZWFzZSBsZXQgbWUg
a25vdy4NCg0KVjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTAxOTEyMDIyMC4x
NjYxNjMtMS1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbS8NCg0KVjQ6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI2MTAwMTA3NTc0Mi4yMTk2MS0xLWJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tL1QvI3QNCg0KQ2hlZXJzLA0KQmlqdQ0K
