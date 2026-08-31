Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C164503E5;
	Mon, 31 Aug 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186900; cv=fail; b=k6iPiS2OzIw7AsjRAwU73mICm0f5VwO85msgt7Qlt3xSFJZQXnahmd+mCCC8Drp59tQXE3qhHUJrHFDpbIKUhjif5q87+jhzmw2xTLB6ZX8m4xBPe+9an7bv+nBYVskJy0kq1U6k/9FMALNWNAXRLwWNwtJfHnClMGynh/HALkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186900; c=relaxed/simple;
	bh=rHRezTHm2UZodq6PYW7C6ifWQPx3NxIWjtW6eJ1hJC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9+5aEuvupZppunQtpj0EfgRYHjN8mGAwK7/voo8fLpYrOjvNNxDUw8GECZQjsdNMaMYuEX827zXoL9wyWQOSRud0r8AiU8tqTQla06hgHBvzX9Xp5SW3am/Cg5zJSfECZ92Y6Rm5upxajIi5LU9ea922G7d72VpRTfp4oqvcCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wBjoW4NE; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wBjoW4NE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBwgXWef5ZrWTP2utH0eIXHBrRLV5eis+gqezXBlQmdWEq5wfaxGeOOkyJTqMyC7xONmdKmcxjiwcnuAmIqXfc31WeA8jByPsR4CDUyTh+fRlrUnKvi0/AVMY4gdRdtMZRIDiargtZvxP7K72hMb0bsXuTd6IwJGRYXlHy/Jxee1SmMtHwzM8SW+u48pePHMkRf0YBCDFSHgp3NxpEC2rfZF8mIOMPiOw6f7giii2tII3gnk08X3fvIJ/83wxJTYib9JVDO3RdFZIvLF8L10GuYL9bO9VVbX27i3fCO/tP68GVKecOkD7AgboTyYcSHbmektSn9STPrI5/vV8Sw8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHd0sJflTjO2g7ntzVccQmbe9yEwwr93ab+U+CcSUO4=;
 b=AjEDBT65AclI3cpvZso8280/5GiZIJtfFArhj6qqr8JUgxyHOYjEczsJKLk2FM5pQZMndS/NczedmClAUaZDOpv22JCMVY47rbQ5izVjbOMkXOk4jZDTWvpgVC6T6P4eAAyBlRL+OZpZxsSogPNPow/ZOiHMvzWRFCyt7ZfbmwvHozrIPeYj0CkM4SIA7fH5Dss9kaeGFF7F1AndvlurUhj0H+DQgOWvSppYY03wtgiQ7x+kZADqVF4AYVA+w4R1jnRsxioJ2O43cb6wSeIaUozuFk23AQDvGPJlur+N6sbR4arRyLpfinnizpPO2s6/0DEx9cPqCUVrqDbzMPDBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHd0sJflTjO2g7ntzVccQmbe9yEwwr93ab+U+CcSUO4=;
 b=wBjoW4NEfqfAwSK835WCzOo+/HarJMrmIzLKymifkgVWaiYFeycVGVbS8XCLjXPYd+8sL2+6PMfqHxBWLAYXLsQ9AMurWUfKad6jJ6ove6V5GpYbT2TxwgEvjlJLxlj2bYwcB7vL6K224NBTOvK/MrFDrqM5+p92sDjUHjv8yVvlDdNz8XBtnucaFnBJ/8kkNWseeRw6aEERzAvK/fWB9w2kKK15D+GEt65WjzNvmYMHoZYohs4lvoKnwVycgS9STMX+MzOnYdc8XQyZxlPJ9K+thEUesJRpVd8pYy/4tD18QFT9PCX/kU66yADMbuCws8ahYyuDH+pT9PkVRxCGMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DUZPR04MB9795.eurprd04.prod.outlook.com (2603:10a6:10:4e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:34:52 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:34:52 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v7 1/6] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Mon, 31 Aug 2026 16:34:44 +0200
Message-ID: <20260831143449.12828-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0169.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::6) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DUZPR04MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 894740d5-2eb7-4bd5-e36a-08df076d04c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 HGzj/Vdyko2E8enq83J4e9yqTSxTwa+dndVtvjF2OxaLS9LgX76SkJVpSiUPwpKHf7Sot/c+TOM0ipFIIdZ7zYrVnKlIUE022yzpmSxNjg38VmQC0+XVmx44DSbYJqKcgSMpBinf7Yz5CieFqkFpFhTI6ZBZpL+oW5tmJjLcVBslheeEKGJdJbvAJzdKqmBB0cxuf5FVuEvum21if+rXjplibbi0L1/L8WJ6hVoRpIsj6kpbWGkp8XYoK3O6pUVwmh27fzyiZ5s1GP85RviRO7d/GbeHdWq/djxv0IT6mxazo7gnoUQEcYnXRSDu/rdf44tD4vkkBYQrmIQwURaKQr1nQ+A0ItaZRTuBksHOTjOGtxupDT1OzAXbHiQwea9+R1dj2BrPTBek1YtSer0ju18ocutktfwEPHdMuM3vN0CxWNVp3OOrIobHI1iWMXsbFWUlA9IhqsMURBgZCWB9ONhj8UmmTHsR4i92aoMEEw4t/JTPfvjdFVAJ7+rOT99O/z/mEeXgjMsaHYg4LhqWii3oL6gRZNIaNLOE0ieiJMBwKLtoPX0OMJFHF8HcIzTIe5GqIGRPeUvlIB1JU48pWcZ1OWeHAGwzcmw1tcZe9Z4A3PeWAPvhvFnWNYTURDdC/CdjMbHHOGcBQevaXjZ69yBOCYazcqzBmmgOrIi27AA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OWhLbm8weWxkSjRqOTJnR1lWWWxXMmJNNjM1R0ZKaHNDcCtJNktpbWx3bzJa?=
 =?utf-8?B?b295aUphRUZvdnZDZiszZFRjK01yQ1RWQU8zNklmRGp1WFBsMDVseDJ0L0tp?=
 =?utf-8?B?UGs4RlBsOU5CK0JPQ1lKeE40bURycHNpYWFIY1JCdmtzN3ZmaXVpdDk0OUlm?=
 =?utf-8?B?MldQbGZIZEhTci9LSXh0MkM2QU8wWk8xUDJMTlBYcnNEc2g2QUJwQzF4NmMz?=
 =?utf-8?B?WUJEYmdWTmlRSTYzMndlcGdRTkRETXNWMjAzNm05bnVqZUtqRWpLUzRhZjNK?=
 =?utf-8?B?NVBnR0Exbk5tdG5tWnBzdG8ydFRLUEFxZGplclp1NTdNZ2E5UWtpeTBYQmZw?=
 =?utf-8?B?MVg4VWRYOGdyTmdWKzA0MWZkcGYrSXhWRGZKa0JsMXRQRkhhb2tDRnZSM1ZG?=
 =?utf-8?B?cHMrRmFxYld3ZEh6YVlpOStkZy9CMzk2dE5RZGdpQlFyQmp2Vkg4cTVyQ1l1?=
 =?utf-8?B?QXZPeGZPSlNXakl0UCtxZlRrU3Z5WHdKbDFDK2N1d3M0OEZrSnY0UHJBMUxQ?=
 =?utf-8?B?eGtIREsyb2o5STNaOG5mY25MYU1jbmhsMXdhTVEwblcvRmNPcVJ5blJEVWVO?=
 =?utf-8?B?eUswcGFvUVFMam9sWUloVnArY0JUbjZRMTVYajNQbFhvWXE3OW1HbFdFQ1lW?=
 =?utf-8?B?bXM5Vmw0WFdkWlVkcVdVaGdvK3pEdFY3dStwa3doR0dZZFZxVVhwd2YvM29X?=
 =?utf-8?B?QkpLaFVSWGRUcncwdTJlMTZYTmd3K2doTDNTeUNkcVZiQ3VGMDI4LzNDVlpF?=
 =?utf-8?B?ZFNHZ2tJbktEQ2dSWDkrNCtGa1hHcE1UKzYraUg2ekRjeWtTejd1aVovRjNM?=
 =?utf-8?B?NzAzV0hNSCtyYmNRckhsOHU4b0ZDNVRacW02ZnRKdDJPbHNMM0UwVlpheG5L?=
 =?utf-8?B?T2x0YXFNamFLVWRzd2kyTGYzUjA0ekRRZ0Y3UXUxL240eUFxQ1J0QndSZGFm?=
 =?utf-8?B?QWhqWkN6cDRWSDdnY2FFWUpVU3lHZWpaU2Y3OThTSmQrMHI5Qk92eUhjWTRw?=
 =?utf-8?B?aFhtVGhsN3luM1oxRmh0ODhyNVJmQ0xoZittdnoxR3JIa2VteGRWd0dLeGlS?=
 =?utf-8?B?Q2lHdjBXSnZ0MXcwM2V2REo1ZGVaSEZIOVBIa2xwWGt4cEpsTUdvUjZ0SFpN?=
 =?utf-8?B?ZE9ONW5IaWZNRlIrMGp5YTRPNWRHNnNhQ2lRdjJqUVcvc0twaE5zMDB2M2VP?=
 =?utf-8?B?RWxTcGlVZU5wL3c4QmtTeFEyT0V4V09GWm5KUGNManBVVlpBNXdLMXA1a3ox?=
 =?utf-8?B?bENrOTNqMEU2RGN3dUI0WmdBOW9pNXR0QysyTlg3eXQxZEx0N3J0SFRBc1Fp?=
 =?utf-8?B?MkRMeHZ1aE5wajh2ci82TEhEK3NFczg2dWlMUEN3aUpSZEdobThNQ2NZYWJq?=
 =?utf-8?B?ZmFmL3ZWSTRwelFQMFl5VU42NTVCb0o5Z2xwUHB5YVdjL0Z1OWk3bFRmUlNQ?=
 =?utf-8?B?RElnU2l4RVB5TS9aUlFBZzFac1BnSkJqS2dUaTgvT1JsZFNMTG1VTEZHYjVo?=
 =?utf-8?B?TTQzdjRIUnNCRWVXVzNtLzZaeU5TNjRRY3ZiWE1LaEtRVll5VmZmRXE3ZzMz?=
 =?utf-8?B?aHdhOWFDbWtJdkdvcDJZUkl1SkhMNE5jcHF1K291VHorUHAzRE5pMmFVTVNC?=
 =?utf-8?B?cG5hdllzVVR2c1RvL2tGV3FZUkZZMTlLUW9tMTVXa3VVbTJyQ0hzUkN1cVdk?=
 =?utf-8?B?cVBKWDZheUpPRTBMTzFGRjU0WUYyQlV3Qm40djgxZVZkOUh5eklWbHZhWTBT?=
 =?utf-8?B?djZYZFpFWHM0YnN6dFhwV1BEQWNXZU43N1hiaTd4ZS9rYnkrOVRWZzh2aGp0?=
 =?utf-8?B?bnhsWHdvRU9nVmV0czBiaWRsYnEwckRwUVhOamhTaFd1Vi9VMFJhdGx5cFE3?=
 =?utf-8?B?SDYzQW9rRVg1c1FNYkQxVVhqNm9JTUlEaVJzNWdCYUxsWFV5dC9RdWdrSmRZ?=
 =?utf-8?B?N0t0TTJGUWhHa3JZUkNtUXVJa2ZBem5zWnhGdnVMWStJS2U0OUlDR0ZPVmVi?=
 =?utf-8?B?czRPTzM0ZitHQ0UrTXdlenZBMWxsT1MycjhpVmlBeXhBUVRXWWczZUU2akUv?=
 =?utf-8?B?aWVGY1psc1F2RmRsTXFTUVIzK01tUE45SW1OVlZIWW9QNWJwZUM0T1BKL0RQ?=
 =?utf-8?B?TWNKd1crUGN0MVhwWmVVMWNUWlI3cHNTcU5aT1JUNGJmRFhLQWJEQ3FWS1Q4?=
 =?utf-8?B?MXZEdUw0OGtMUEQrUzF3YkJxUVREK0pzT1M5N1NtTWxldTRFWktGU09VS3Qy?=
 =?utf-8?B?a3BKRFVXUjJmZGZFZVRvR2szelVqdXRseTcvbU5VUDdFT05IVlBiQVlDREo0?=
 =?utf-8?B?b0JmdWxob3BrSHdTWTQ5NTFmYVJRN0hNckg1V1Y5d0J4WHltMjM3RUNVTUdy?=
 =?utf-8?Q?Oe+c1CtrwmmbjoEg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894740d5-2eb7-4bd5-e36a-08df076d04c5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:34:52.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msQkf9KUgnsHwzi9ty6xYUath8iD51Sfsa1bErfz1A0a7Ie88Oasn7eMaDGA8v5vVYE3wjk6+eaum73TchZdSvlBy5ICkq0BmDbP1Sf6w6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9795

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events

Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line

The FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround re-enables the error
interrupt (FLEXCAN_CTRL_ERR_MSK) while the controller is in the
error-warning window so that state transitions keep being reported.

The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 131 +++++++++++++++++++++----
 1 file changed, 114 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..2e9df2d14b34 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+/* Process mailbox (RX + TX) events */
+static irqreturn_t flexcan_do_mb(struct net_device *dev)
 {
-	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
-	u32 reg_esr;
-	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
@@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	return handled;
+}
+
+/* Process bus error events */
+static irqreturn_t flexcan_do_berr(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error, state change and wake IRQ sources */
-	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
+	/* ACK bus error interrupt source */
+	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
+		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
 	}
 
-	/* state change interrupt or broken error state quirk fix is enabled */
-	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
-
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		flexcan_irq_bus_err(dev, reg_esr);
 
+	return handled;
+}
+
+/* Process device state change events */
+static irqreturn_t flexcan_do_state(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+	enum can_state last_state = priv->can.state;
+
+	reg_esr = priv->read(&regs->esr);
+
+	/* ACK state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT),
+				&regs->esr);
+	}
+
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data.quirks &
+	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
+		flexcan_irq_state(dev, reg_esr);
+
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
 	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
@@ -1188,6 +1218,68 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	return handled;
+}
+
+/* Combined IRQ handler for single-IRQ platforms */
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+	handled |= flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Mailbox IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Bus error IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_berr(dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE)
+		handled |= flexcan_do_state(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Device state change IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
 
@@ -1761,25 +1853,30 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		err = request_irq(dev->irq, flexcan_irq_mb,
+				  IRQF_SHARED, dev->name, dev);
+	else
+		err = request_irq(dev->irq, flexcan_irq,
+				  IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_can_rx_offload_disable;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		err = request_irq(priv->irq_boff,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_boff, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
 
 		err = request_irq(priv->irq_err,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_berr, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_boff;
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_err;
 	}
-- 
2.43.0

