Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169D39CD17;
	Thu, 30 Jul 2026 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385836; cv=fail; b=gqbUp6qaI6r4hlSvoD0srSgm2qdccGow5BH0mc4uYxYYICzyHNsRkiKjuw6RCjr3n0zsvvsrOFuG3VHJ0jN+nbQh52DK3slEBs4JHV0GBfVVzI2bBl6y6s3qRefkol3XSW18rjtpT3yLIz6ibduNwIpGDgBxq71vC0o3kkNBvpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385836; c=relaxed/simple;
	bh=3YrYQWUt5uN05xUGKkNiFGHJLE6GodB3q6yMHOSOGnQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=IRBJJF7lwnkorq97RfH91TH+tGsfTtPkFtf+x6pBp5eeyrIjewgcRxBSyW/GZ8NYepdyVJv4gqCPz+VqNjIoCXMXIYOyN9lmSldFpozvF1J7pwOTlvT7wWGDkVmtq5dqzmYTNt9zIqhmJtdWh5iLixnQLqu7rs6FSl7nbUCpkqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wg6VvwID; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wg6VvwID"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeZdKb+Q8+OJH9ZScjgrTF9HuRa/LAPolDmOcSvGRfcYjcwH4Fz3lF/ATYLjNYJMnyFjbxeuOu+npK2nZ67XwErwvoNI2Yts7fqJMffgmagwdD+SfGsaHlcwj+bre8G4Udn/dsrnzMQ/tpOXvD2G+wttF6LZcfnT/a+nZibk4IVTIHN8vpjyvIu/svPVb/KiBOXqcCseCFwcFh+Th6ewk2+LSx9svXIW/wOBJJ1PXT4fVpPULw8XYdgk3pewXv912m+GfOk3pFWPHbWxjMNZjuXN0J50hfUDGyEUgkQ5zI05xQgncuQBps5mJwngfHcLYHhUplyrTlp3bL4PyUZzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHxK52yAsiBc0Y2s5RYti93+juZcr3ETsD4L/3+9/cE=;
 b=GrIwy9v5i8bX9wmT5sxOsQ6iWVt5cBh2qxLE+XX5sxmyFNhSCMhy4XC3T0Mndph83TRp6lTmcEYh4cZ0yHwbXR49aslEfUfrppSsO5ZE/finoptdI8HvPGdxq41dl40DciWWd7VOxFqB83e9oI3d/4bHFWA9CdP1jp15mEkyxMCyja8b4xC5L5E9QGOP0bAq3mMuk+YeFDZTOgeOm5MJl3kMx2TmSx2EFg+olPPGzVYVfRt6H4u/C629TgKM0SE5idPmtJfkuVbwPcsaU9RFOPJSKQkqfOV3qs/+kr3afbMWDhBj0AF3P3Be2s2iwxFtVO0PLaOUjn7E58CM92AVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHxK52yAsiBc0Y2s5RYti93+juZcr3ETsD4L/3+9/cE=;
 b=Wg6VvwIDVLpQORSLaYmwGJQjUhCDmAxYpqtqTvUvcT8eGfN4NJYBFMpzy3dDAsk648F/8Zzni/8exPO07PYXX+F6kcq06pyF2qxPoOExGyZMKd9ti2vKAdtx/BXwZN6iOaNq9O7O/XlGcdNOMi1yfGXYgGH14qI2pqc0sfA8io7weHyJm/HY5qz5AGRo2qJraLJ2O6cCZxkDSuVEEL5GQjGrFw1IxKw8xfSUozcxyYeKGbhe8AS+I0hBJ7oGmUQOYUK1a89ugPLAkU52fGKDzpJD42f1KAISfCL+gkancKXtPa0OA2wrOIYS9q6FjIsal9Re0ucSRP6WDvdup/lcJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PAXPR04MB8239.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:30:30 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:30:30 +0000
From: haibo.chen@oss.nxp.com
Subject: [PATCH 0/3] arm64: dts: imx95-15x15-frdm: support CAN transceivers
 sharing a silent GPIO
Date: Thu, 30 Jul 2026 12:33:25 +0800
Message-Id: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXUamoC/x3MQQqAIBBA0avErBsww7KuEi1EpxoICyciCO+et
 HyL/18QSkwCY/VCopuFj1jQ1BX4zcWVkEMxaKU71bcKvYsom0uEwjvFC423gzNhCa2yULIz0cL
 Pv5zmnD8HNgcPYgAAAA==
X-Change-ID: 20260730-can-share-silent-5c89a5dfd308
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Haibo Chen <haibo.chen@nxp.com>, qijian.guo@nxp.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785386048; l=1939;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=3YrYQWUt5uN05xUGKkNiFGHJLE6GodB3q6yMHOSOGnQ=;
 b=B4GtVblCqYARVVdgMDG0Pc0ByravfE68txWp34dT+5H0PP0q57q0chgI6ih4lT8OtNyD70qHs
 +RTdtza5aCdA/WOAcj2vrE4Zx/0AOQoRMGglCgdjYv/JiqygnJ6mSjR
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::7) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PAXPR04MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 2323edfc-c6ec-4787-acf0-08deedf34987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|376014|366016|23010399003|921020|11063799006|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	T4TDWfiAj5pq1l0uMEefaP0mkerjECsN6dCB2SgXs1OQbGcAqZ8sKNi6s/heZBEtISBGUDgBEceulf7YYHpWWZgjOX5h/rYkBIi0M4Baf1O0+AFHKwt2fuFbFc5cAXsUVhdG5qFP3GRSnZplYF7j/CURkzwN+KXLnAzjDd/yLddy9HNkTor29G8kw/2QjjYAh5oxa8LikH5RUkE+AMZnd9/IdCYbH2QPfJ9m/IxXgkU4SqFz8gw2Jaa8JFDFlf1SCHwW5Z7S/bLoQZS9dBdZFxxc7U1oKzumH33LJZnoTM1TFFMsWGfyhXBhiGushIVJxEauDtTAvzDqxPtvfu5SRsqWJ1iIP6dYY+k9SdpNbD2NIK7hZMLgJ0gST0nFoYdeOjXfSRKzIMPRCFF+H1w/PvcPyzyrj5Y4ArfKf+oAxqthVs3GyeiGVARHgvTXBNfP0F76UHKasrahA12VaroFzVxysAKhU4M26YiE2MPCpZnEx/990+L6g4hBs9oerrQUf6P/DOeEnTeef/ycJs4zLo60iqRaLlkGrf6KVQwIVAuenSpawpsDaCQYnzUtCf5CHpAhLaWzp/z5TqcxFK7ZUB40C+EkbsGQMo056HQpY8VYG/cbeDeAi6aw3XRVEYAHBZmQoqhCJJuL4jqLvENz7pTpqqdeRt3GuRo5HDGy6jBn9bUpLERMlGwL4uRaHA8abhUNqalqVs4fD2jZualT4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(376014)(366016)(23010399003)(921020)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGh6ZUlwbk1mZWI2ZWczaFZaT0t4Wk1yUUpmeDhyMkpwbWI1YmR5UG9lV0o2?=
 =?utf-8?B?bEs4c0ZMU1hEQS9ZQ2pSRFJmUHNvdWZhRUVHMjhvS2lXVGlHeFF6dDFCYmI5?=
 =?utf-8?B?Qk1mdDVheHBlVDR4dTNuRGU2dy94c3lUdy9BWG5kSE1sQ1BtVFNCUTRESXY4?=
 =?utf-8?B?bUNNY3RiNWZFaGpRUVVvcWk5c2RvTmtWMU5JNXBwWTlSWHp0Qy9jR3VpM3Yw?=
 =?utf-8?B?bWc1QS9lR2EvcHphVlZSb01MV0NhWWhsQ3RiZWw3NTNGMWtwTWlYdjQxY3VX?=
 =?utf-8?B?aE9oZUVlR3ZnaU05RjY0N0RkNUViYnYrUHVqY2ZicVlqbUVzeGgwOXM3M1JT?=
 =?utf-8?B?N2lBdjBQRUVVSnZ6SjZJWitNV2taZ0tnZHdlUW9HTGhwSURDVUF4ekNZSk1n?=
 =?utf-8?B?OUZlVk01aTV5YTBpOGRscWhNWTNJbVIrS0NqbjAyK2U4SDJHcVk3aHFVWnJ2?=
 =?utf-8?B?ZFpHdjNjZTdWZVdCM0N5OGs0V1RReWZicjZDa3lDcXBacWRiQXo5OFFVbVFC?=
 =?utf-8?B?RSsvYUZmUVdmdUtZUUVvT0pnS2tvWExEUXd5Ky9HTWRtK3lBdDdvZVBPT2VE?=
 =?utf-8?B?L3dFUTNSK3BtYVhONVpTVWdtYVREUHpoQk9xNEtxV2ZnbEwzUnVyck5iOUds?=
 =?utf-8?B?aVFraHhaMjgvV0RvQitueHRyVDJRMmtmRVJlVnZIQ1ovZW1rRFpsWVFHRWhR?=
 =?utf-8?B?RWhaS3VrTlY2bnY0KyswdTRMRC9pSDhBWndEajNNNitTNzZ6OW5xeVBsYTlU?=
 =?utf-8?B?cEtSR3FXZS8wQzhDZDArTnNJRklWYUgzdzlWbzZ6cmxwTmFPMUJCWGlpTFVv?=
 =?utf-8?B?eE15cXRiS0krVnJvazlodmFoa25JK1p3eDhuSFgvUUdQbE5Fcko0U3ZoTE5l?=
 =?utf-8?B?ZVRsa09VNXhjUW5NTmRqcERsK1drUzAvMDZUVUJlVUl1Sk51YmNoTWIwQ1Zj?=
 =?utf-8?B?QXVRSjdlRGY4bVByNzdFblZLdVpaNS9RNHRUaCsxbUc2M1NrcG9QYkx3OVRu?=
 =?utf-8?B?RkJrcWhFbmhNWWJ3bFRoMlNkZ3c4dGZDbnI1cEdBSG5uOEtGRlNtZVB5RDFZ?=
 =?utf-8?B?eUlZVm9ENnFSTXJvdkdXQ2J4dmNGdysyZTEzUnYrL0VuSWxOU01lNVY1N2Vp?=
 =?utf-8?B?anAzaHZ4bHBBVmZTenJwdWR1VXhreGxmSUt1Q2NXMzM2Q2xSOFdaWlZKU0x0?=
 =?utf-8?B?Yi9FUGxUVURPdlE1U0VLOE5MR2hNaXd4T1gwdURYeGJ4WjIwSW1ZRkFGK1Ri?=
 =?utf-8?B?bGJYU0pEV0t1c0dwVzRWblNLRWpaR2JlZUZHcjV1aml5YldGc0FQcHFuRndT?=
 =?utf-8?B?NEtiRkdYYXdscEFrSXd6dklUS0ZXYzIzdy83T016Q1F3RmtvaFNmdUcrR0Jq?=
 =?utf-8?B?RUtYSXhJN2JjMnlYYStkcGJMNlZVN0ZBVkpEZkxLU1YvM2dqWHpZS3hPMDJh?=
 =?utf-8?B?empTVVRvNHBxN2ZGWUkvOURxSTFRVnROdE5jbk9GdzdNb052Q3BhQTJLYVFJ?=
 =?utf-8?B?ejNSbWFIWldaN2wyK0NYY2g0MDF0RGRqZGFHTGhROXdXNnlBYkVtdW1PNmZW?=
 =?utf-8?B?RC9UT0psbmZubm1uS3dybVJNWm1uRHcra2s1SGFaRkVLZHhRdXlHeU1pa0hK?=
 =?utf-8?B?ZmgxMjNuNlJweWwvdm9BUVFIQ2xUUTFqc01ZdVZGSE1aWDZONDl6RkxlRjRy?=
 =?utf-8?B?NitxS3pFcHFBTXNlTUtzYjlsMTg3d1ZrSEp6MXpoTmNuTnlvdXdoVkJOKy9m?=
 =?utf-8?B?SW1rbElBdUV2ZC80Rk02eUpYV3FlQU1QL0xhQmpxb08rRkRic29NcE9vaGd3?=
 =?utf-8?B?QlVMb3c5eVBnbXdMYStGbkkwY3dSK0hLL0ZmUGZCcHE3TDJzSVBUc1VEM2Rl?=
 =?utf-8?B?Q1djSXBMQ0VaR01hTTl6VGtRSXFpdkVHaFhtMlY0VnRwUlRmTFlJTlpmcXhV?=
 =?utf-8?B?K1I1L0RwWDdZTzA1SjgybDBaMC9MUWE0VXJaTGtCNGVBUnNabnJNMityNDdT?=
 =?utf-8?B?d29rQjRiSWJxSFFWOFR2V0hvREN3MXh3OVcrOE5POW5ReU9IL05yTkFDd0Zt?=
 =?utf-8?B?Y2VOTU5wVzVYb0E0MDlvQ1ZRaVZySVZWdndaU0xXb3d6cFBsZHZsNEZUZFl0?=
 =?utf-8?B?dWxFTXlaWWJKU25EeW9IcS9IUjQrdjUrRStIcTRadjMzVlNuRmhFWld3M3Bq?=
 =?utf-8?B?RDcxMm5NTWRnWXRIKzBFZjF3QUlORjNlRlg3TlVIY2xjY1NQRkVBQktvUTRH?=
 =?utf-8?B?UVRDOVAzeFlDN0ZXVndMOGNIMkdnNm5uUGpmbURTSjZSTDM0SDFUS0JBZHFp?=
 =?utf-8?B?RXFzUzZtV0VvdnBnUEdwRGxjZSt0VGRZczBsN0kyZnFJci9vTGdHVDc2QVBC?=
 =?utf-8?Q?tCUtypNwabXuX1oskZIyZ6QmkTrykhPyC2yf6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2323edfc-c6ec-4787-acf0-08deedf34987
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:30:30.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/pJ20dZxgcVnUQt1VDz/1Z3j+cZpUZ1tb+OlZdB+wChIo992yPxmrQaasoelF7Kb+HofK6zZ6ZJc0+p6ADk+g536GYR8SZaSy8mVX64EqbaTLEA1gN6mUJggsxW72gM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8239

On the i.MX95 15x15 FRDM board the two CAN transceivers (attached to
flexcan2 and flexcan5) share a single "silent" control pin, which is
routed through the on-board PCAL6524 GPIO expander. Both transceiver PHY
nodes therefore reference the same GPIO line for their silent-gpios
property.

This series makes that sharing work correctly and puts the transceivers
into the proper default state:

- The silent pin is active high: asserting it places the transceiver in
  silent (listen-only) mode with the transmitter disabled. At probe time
  and before the PHY is powered on, the transceiver should default to
  silent mode. This is both the functionally correct and the lower-power
  state, so the silent GPIO is now requested as GPIOD_OUT_HIGH instead of
  GPIOD_OUT_LOW.

- Because the same physical GPIO is shared by two independent PHY
  devices, it is requested through the GPIO shared proxy. ARCH_MXC now
  selects HAVE_SHARED_GPIOS so that this mechanism is available on i.MX
  platforms.

- The two CAN transceiver PHY device tree nodes previously used the same
  node name "can-phy", causing a node name collision. They are renamed to
  "can-phy0" and "can-phy1" to make them unique; both continue to point
  at the shared silent GPIO.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (3):
      phy: phy-can-transceiver: default silent GPIO to high during probe
      arm64: select HAVE_SHARED_GPIOS for ARCH_MXC
      arm64: dts: imx95-15x15-frdm: fix duplicated can-phy node names

 arch/arm64/Kconfig.platforms                       | 1 +
 arch/arm64/boot/dts/freescale/imx95-15x15-frdm.dts | 4 ++--
 drivers/phy/phy-can-transceiver.c                  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260730-can-share-silent-5c89a5dfd308

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

