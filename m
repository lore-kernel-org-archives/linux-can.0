Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105893AF664;
	Tue, 29 Sep 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668769; cv=fail; b=WZRw5edIorfBuiWnP4Upmp/SVqpl3lQ6yU3PCbbGVVi3j0ZDdcFwQbXZRWr5q0iexU5ZCsp3p30qDDmw/SDyiqbWAnsnGBa8ZLTQjz0Iz03U6bhoa2Y50j8hIXBdufUfh/ahxsf1TLM6D324hJKttBB4Z8H2aZ/UJJtZMJh2PrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668769; c=relaxed/simple;
	bh=w2SEC/1MS6TrmKgrOw3b9Zfi7TbSkmpSBO0hUsCFcg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GUYIB+ZfoZKBtpvTJmcQQfe+10HfB+fxZzJvVfs8I8nAT0ttBf8s5u45j7EE18gPMTKCHbmmRmDe9Lb3XFEUCa+8NU/kdWD06F8KPEOlimEjF+7AAXnWCTGasxXYnos2/ZW3r9/b3DMy/K8kdKe08sgG879P3y/KcIOyyhTeL8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SEQjWQkQ; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SEQjWQkQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFCOv99reytQk0X/6cR6G6PnIHiMmybYTm25yX6ykwTsmoIkAIkSH20VF+6d5Su9KeQYnJ1QZE2mY+5gjtM6GnTlQ6MVT8RFXa8E0iXvb1JOoOlh9AdYxYnS1yepzoW9DqfN5Bl/lr7vm5ECI+WxtWtEdvOrZccZ90L8aV8TiJp+jV2z3kiRCZjGCzqKYqryCy2mOb9mUruEYahbdJ2H9nmEST5b/CruPXAwFHcfCsB4Rc6hOQHAEtza+Pf+23CWcGarh3RswSW6GkniTmNaAfDuY9E7BqnI3uVPX01ABInvlIWYRBBx9C9pp0WENBpsyoC47mfheIyWnaJZ/Ody+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkwAQk9YsY56MBm2Z3EOmXm6U7EtZZxRw9p7TJk0ldk=;
 b=dHsHkO391vv8pUOQXepDXG7txFJtAuAwma5edSYkVKiQy5nNCx7hMhcU/fgl89y91bCmzDrjJ5I0nLrAaGaA+xkhzXIcV+EIdIYVxXFPOzQsZiKRI0VYssIzazhBSMC7OoS7Oo6qsHvBJW7dFQHwKDrRyD2w2s+6iiFWiZ7F0pgM32TBpxwOv6/lcu6aYiXIYNN3mx06ogOaCOUZeD3XcqxPIWDlBBBiOH4DIrPKdG7IWTDnm7fAJGBZIAzZ8FJUbiRdBitMy5Z7lMwxUEEgFSHg1RW2OROp+GWBQ7fBSw6sBtPu2k20oSSZJj4qX8SKhGp9vpyTIs1miTj+j4RgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkwAQk9YsY56MBm2Z3EOmXm6U7EtZZxRw9p7TJk0ldk=;
 b=SEQjWQkQnuDJFFpTPeOh64RUOYCfAza4vMoLzrOucb/6fEMBRVoCZsNPh21qn8li7fVRsiEmLjQtouiNW9Q3+LFNLoOUvy0Vm7ZASU52+Aov9soJTb/NEzS+cVbgZB8K5+b92UXZu6DvMhEm0EpuWdLnpu8/n3ufNmtP1PlPUlg8M1Dx571JEfLA5vcNq+dMQhVg4ddLCbOhT+bfkpFffVKJaDriHR+0tz4p5Zro6XdT0bWoMgHnqUykVcpzo8moG7+55PmfG9XyFGcRvG3YDnFmETms2lmqPY2duUne7nXfiCeBLf4xPHHHYZ6U3XO7dmuzdXQI1HanU9RUn3I7mQ==
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13)
 by ZR6PR04MB604709.eurprd04.prod.outlook.com (2603:10a6:910:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:59:22 +0000
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb]) by AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:59:22 +0000
From: "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH net v2] can: flexcan: fix synchronous external abort in
 flexcan_get_berr_counter()
Thread-Topic: [PATCH net v2] can: flexcan: fix synchronous external abort in
 flexcan_get_berr_counter()
Thread-Index: AQHdT+JbdK7V1PJOpU6KxdtPS7C817blMRgQ
Date: Tue, 29 Sep 2026 07:59:22 +0000
Message-ID:
 <AS8PR04MB88204F464FE0C190C8CD763C908C2@AS8PR04MB8820.eurprd04.prod.outlook.com>
References: <20260929071236.185683-1-chunyuzhiqiang@yinhe.ht>
In-Reply-To: <20260929071236.185683-1-chunyuzhiqiang@yinhe.ht>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8820:EE_|ZR6PR04MB604709:EE_
x-ms-office365-filtering-correlation-id: b817648d-cecf-4bb9-8f0b-08df1dff92b8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 7kEMctvG8Q+7fyJaLhx4NYeCgvLIZW9B9mJ11xKaJNWMva0v3Rx/oO2KuOhkTBZDy1kUyUEeO2+iywPARYfwGJD/ezH51wN4Qxeozb4wL5oMQCZOInwdy0QV89P0Bp2flVixJrYlTYc6Zfx3mjvl9z4SLe15Qs84sCAxiO0jrlgTpLLprnBHdrvzkw9TACaGtNk7gyzJMYFKjaKsSxpiyNNd4LgI8dhUMCaBZc5JhJ3E83skijD00UKXDU19T4wblhZh1odJCkR/rP82Yrvjn/dvK1tKLsqoxzrMrfqkqkB5YXoHpAtX7Mwx06Dh1AQR0lU/QZjhK3I/0XkX4DE202Cz9L0KS8r1TLFGk3WCg7cesvHatHt2hvNhAPjGwPGOiMhl6YNu12XJNOMm8UAy55baN5s9GWd9zgVU+594xPomSoEEp2eHNX090HYGAYvTYhD6sslFOax5aSAEzlU2uFhWOh51Pb1brYecHGmYq/YDReKsLEgc2/p9y8mp/+0Sp3zBMPrVtj6LOFcUNxaywjCvdL8WbzKbPPX6E1kteRuLHdecykl+1EATWIDz7FDnEfBu3uZLyCwXvLX8MHVSKZy1btycgzXx8R+pdutJRgRL/rnnlKiFdFIrzSRPRIsbuKGlivS7uQD0Qr4kooGd2OYkDLdJsv64+Wj6FTKSFE0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8820.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OOgAzKBduSFE9Tuq2LmGYgu3meGrOQYwNmgBN7K1tcUiY/yXUW9bG2p1M1B7?=
 =?us-ascii?Q?YXIlJcW/HHdbWJvGYj1aTdftAjRRBjzDRv+7vbFiJ2f1pGg/tJs/OI1DDLCO?=
 =?us-ascii?Q?0WlyRSSxIudBaAPrEcYSsy6Ermj98BFWtAvYVkr3sqsFLjavAS2tQGf/cS9J?=
 =?us-ascii?Q?FTJ4PCJ3WKSAouNMOzcsJZTftce+rHbUdN+xIKnOP/MYFy+DOVzJjkoYYaSw?=
 =?us-ascii?Q?xvNweVJOPit8kS3kUxJbqJYeKbNxbCs0GdO6xEIEyH1y0gtY3iwQOUphPQOV?=
 =?us-ascii?Q?qHwIpcpMjDOPQHOAsdg3c3Uy9jpy/vm2pHmtAFIEQBJcX08T/Wk92Imu6Ymw?=
 =?us-ascii?Q?xJ+DYPjsjm2UnmlbU/eyD11yBGl2cNAY1jT51I1pMCZcUI+U1u9DxPl+FALg?=
 =?us-ascii?Q?QbfGwiSs3MiFIVBfqqmfk+PdMNvbOz8JxbUkDvzxHBCatVoT+/rW0PGlBaCy?=
 =?us-ascii?Q?CRPAZ7cvqwo5wUHC5dmN+jjjRSZFcvCp24iqMmMIh5aohy9yE584gUWgaaW+?=
 =?us-ascii?Q?CNMf3YcYTAlmdCCNoVsz5BBJSFYzucqRHppXbyzwf0Nbanabq6bcFiPgIbGz?=
 =?us-ascii?Q?X8zBG1gB3X5o5sv4jpF9C7xo3alsTxtQIldDS9glY25V8N10YeXD9EEj6KcS?=
 =?us-ascii?Q?/49tw+RWbpMSaAaC72n989m1wTaRhFwm+aXlFQKkVKs8vaqnYLzxTevEnxVL?=
 =?us-ascii?Q?nuclGI1b0Us/LlL3iQiEHu99vWJDPKo8cNLx+Hc59rBzD53wPeB4zlNLxW83?=
 =?us-ascii?Q?tQpiB4BBusmhLWldRe1CYvaU9yIfByWengvwM5SEM5EBMtSYu3nF/7s587PW?=
 =?us-ascii?Q?MAY7wbTw4a1y4ik5Q6+kiwwdfXJ6A8UxZ0GpOfNFIu83cF8jKRQqbGVZ7kZF?=
 =?us-ascii?Q?IjFY1oqpShlUMqTOS6O0TdfjMeX7ut0/9JdklI7IXDyGq/4D2j/wFzJ8oOqr?=
 =?us-ascii?Q?nNxx2qt1sN+mZiXB6innxyY8DPdolUZENqYTwoxxzVsCu7JwUbzOWU5KgeJj?=
 =?us-ascii?Q?vsqbbBwryieOyFqbi6QwrDbBWLfM1rpQasbPkoz3SKBVhQXdxVLZL5LKAS66?=
 =?us-ascii?Q?t2AFjkK9WyDVw9zrNVl+7K8F+nrXo6F5vYJnLCOAy1PVXuc2lUTo/NIl7XJg?=
 =?us-ascii?Q?eCw4ehKJaKQAowmW+y+udi7IYDET8sMGsgo02jlfTIPfWgmkTpAJHXSCLEgj?=
 =?us-ascii?Q?PLovTD5xPOrGYwtzNq43a/5XUa5Dr19nw3++Etv+Opk7fWkvAHBsRh12gn8l?=
 =?us-ascii?Q?cdlsr9vX/YlTtHuq4g2H9jHp3pYZ+i9tDBER1uPi1Wa0EA0YHNRQnOwHTpeF?=
 =?us-ascii?Q?aoIThjIsgg77gaafZChqKw7R0yr1UJWL+BZHpmD7WAcp8hJe9P73s7WmtIRK?=
 =?us-ascii?Q?mDsZTMwMqZOjiJq6barP7kjCQk8gvDBQ42ZL+MyRjxK/y+OdbE1cqntmagSG?=
 =?us-ascii?Q?maBw3SU7IbhHYChixO0di3kK3A4Fd11FuG68SooN2L0ZqZ3Hwzhhmfb9cGMy?=
 =?us-ascii?Q?NnJ4kbSchHyRn7PUYei5h/P/V2whNcGBN374JDDJcbzjl+AqoEl5vrdiBw4u?=
 =?us-ascii?Q?vNg1HT0zIISYnmaYlGALhBZulrCS9b/WAnozhVv9tX5po7so5kYU0nNmhHJ/?=
 =?us-ascii?Q?KU6zQ1ABlNc2iu1Y8llmHhl/FsCKx4TXbM3Y7pfh3mix3NIy+NBOj10l3uSc?=
 =?us-ascii?Q?+qIWbFwzkITZQafL0pFVCshzvscmwTH/gQX7waUqu3VoIwf3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8820.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b817648d-cecf-4bb9-8f0b-08df1dff92b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:59:22.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sncTDIVTW7sdo8agdw5McrbWbaSx6x5t3WrMKJnFfCoCWeTqdulWwSMdJOVBxmQLS/h/ACjXt9bI20dMJcOmqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB604709

> -----Original Message-----
> From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> Sent: Tuesday, September 29, 2026 3:13 PM
> To: netdev@vger.kernel.org
> Cc: linux-can@vger.kernel.org; mkl@pengutronix.de; kernel@pengutronix.de;
> Bough Chen (OSS) <haibo.chen@oss.nxp.com>; shawnguo@kernel.org;
> imx@lists.linux.dev; ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> Subject: [PATCH net v2] can: flexcan: fix synchronous external abort in
> flexcan_get_berr_counter()

Bad title.

>=20
> When the interface is down, can_fill_info() still calls
> flexcan_get_berr_counter() to fill the error counters for a netlink dump.=
 On
> some SoCs (e.g. i.MX8QXP) this can trigger a synchronous external abort.
>=20
> The root cause is platform-specific clocking. On i.MX8QXP the CAN clocks =
are
> gated through the SCU LPCG and the whole subsystem shares the
> IMX_SC_R_CAN_0 power domain. flexcan_runtime_resume() only calls
> flexcan_clks_enable(); combined with the LPCG e10858 synchronization
> erratum, there is a window where pm_runtime_resume_and_get() has
> returned but the clock has not actually reached the module yet. The
> immediate readl(&regs->ecr) in that window hits an un-clocked target and
> faults with the external abort:
>=20
>     Internal error: synchronous external abort: 0000000096000210 [#1]
> PREEMPT SMP
>     pc : flexcan_read_le+0x0/0x18
>     lr : flexcan_get_berr_counter+0x4c/0x8c
>     Call trace:
>      flexcan_read_le+0x0/0x18
>      can_fill_info+0x1f8/0x434
>      rtnl_fill_ifinfo+0x8fc/0xbb4
>      rtnl_dump_ifinfo+0x364/0x448
>      ...
>=20
> This is the same class of problem that was already fixed for m_can:
>=20
>   commit 91a55c72a821d ("can: m_can: m_can_get_berr_counter(): don't
>   wake up controller if interface is down")

Remove this in commit log.

>=20
> Fix this by returning early if the interface is not running.
>=20
> Tested on i.MX8QXP: after the patch, `ip link show` no longer triggers th=
e
> abort.
>=20
> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch o=
n
> clocks before accessing ecr register")
> Link: https://lore.kernel.org/netdev/20260915063511.3010642-1-
> chunyuzhiqiang@yinhe.ht/

Please drop this link. It will be added by the maintainer when the patch is=
 merged.

For the commit, I suggest you change like this:

can: flexcan: flexcan_get_berr_counter: don't wakeup controller if interfac=
e is down

If the interface is down, the CAN controller might be powered down, the
 clock disabled, and/or it's external reset asserted.

Don't wake up the controller to read the CAN bus error counters, if the
interface is down.


I don't think we need to mention the 8QXP dump in the commit log.=20
The 8QXP-specific erratum only served as a trigger for uncovering this issu=
e.
The patch itself fixes a generic logic problem that exists independently of=
 the
 erratum. For example, even on i.MX95, which is not affected by the 8QXP=20
erratum, the same logical fix is still needed.

Regards
Haibo Chen




> Cc: stable@vger.kernel.org
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> ---
> v1 -> v2:
>   - Reword the commit message to drop the MDIS reasoning and describe
>     the actual i.MX8QXP SCU/LPCG clocking window as the root cause.
>   - Reference the m_can precedent (91a55c72a821d).
>   - Add Fixes: tag pointing to ec56acfef2af1.
>   - Add Link: to v1.
>=20
>  drivers/net/can/flexcan/flexcan-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c
> b/drivers/net/can/flexcan/flexcan-core.c
> index 06d5d35fc1b5..b08779ee2a0a 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -765,6 +765,9 @@ static int flexcan_get_berr_counter(const struct
> net_device *dev,
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
>  	int err;
>=20
> +	if (!netif_running(dev))
> +		return 0;
> +
>  	err =3D pm_runtime_resume_and_get(priv->dev);
>  	if (err < 0)
>  		return err;
> --
> 2.47.3

