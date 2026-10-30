Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403372;
	b=Ic1ujSzoLOhfHWWKDRelWvwd3Z8t46ENEG4p2k9QoL3A05xb+uh87pcjfEoh9jB3whtR
	 0dQhMqG99OQc2ZO8X/PQJl53/U4WMgQluHkOFkGONrzXFLdpRX877NKEQlZoYA1y2Zg6U
	 m88bxEu9990U6TL/D9n6HS5/i2F51D8YpEaLqx4DPTC9j9OdoYLj4eiQyO5xVBHqsDP7X
	 ZWCl3SOj/oPUEQLOVTS+Cx6cAO/nJZv0ZkUQq2d4XZwBx+TRhfcjhlFxohB9SRaRzBpYg
	 +cZwi5m3bRHBVzeH3+j43hi3NS3Vra7Fvf2Y6eaLy5TnZ4RQiBo4ax6LpBo+zz+g08g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403372;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NBv0HOgJZibkv//LT99ipQy0RsGlURxEEWeod0u4kVU=;
	b=pF2Corik5VGy6QhkAo4u8hwToPH8kcsuZdK+COe8gfOojOP2Ak172JDuqA8VM0GnSDhC
	 E6OkeJ47+d0QckNpMi6Y0I3CRYREoKjzENXrQo9aVFf/2N/bVbID85ORLaqdHlHoW1LeK
	 2OFaq/ZIu0OalhqJ9Q11J+8Nry03AEh1qeGsTtNJbEWDdo7UZHaxTfgQAjXTgGf6/tPol
	 zTCe75NPeVUJzFedseUJui9b3xwQMMLN6p+jEFEL32UcUMUP4UMld5uQhTz9uu0GvDR6W
	 adKfmU3JtCLolq1QoyTPzQGpFNENGFKoYWK54QQoTvMXyIuRbxf1ffthsVG4vIQrdag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=aeTfKSQC;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA142606A31A;
	Fri, 30 Oct 2026 23:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA142606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=aeTfKSQC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793403371; x=1824939371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBv0HOgJZibkv//LT99ipQy0RsGlURxEEWeod0u4kVU=;
  b=aeTfKSQCWdmHsJebP3xmfdoSzW0TGZ5lvLcugKDF2AspqdcVeOIvgfey
   M3Op+9BvICpuL9CG3OjQKWGsCzcBztXjqKm/xS97Hz9nAC+veoTDKJ443
   3GW+I8aI/pFO8cCdAOArG1ATx+VK0PnW09oCpolrP4E1Qk7ZUZzNl3GMT
   v34z2e2On+pXENm9/4iGLsJhd0v9Skm0mvPk6LFth4/O/XbV2qMYwWML/
   Ro82qfvttCngklyk9+wCX9U5HFodgCi8En+KSXlLCW+ozSUsnq6dnNY01
   4yGtJmHVy5Q23a/p8BzRPbLmC9waU77vmgOLkC5AZE5FQ0EM8Lh9FpVsz
   Q==;
X-CSE-ConnectionGUID: A856wVPWS6W2dwswXKgxYg==
X-CSE-MsgGUID: l/CCTQEoTnuwJXeOq+karw==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32490535"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 23:36:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:14081]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.155:2525] with esmtp (Farcaster)
 id 166e25ea-92ed-4526-8b4a-e4b57d1b931a; Fri, 30 Oct 2026 23:36:11 +0000 (UTC)
X-Farcaster-Flow-ID: 166e25ea-92ed-4526-8b4a-e4b57d1b931a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 23:36:10 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 30 Oct 2026
 23:36:10 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] can: ifi_canfd: enable NAPI before starting the controller
Date: Fri, 30 Oct 2026 23:33:30 +0000
Message-ID: <20261030233330.3483988-4-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030233330.3483988-1-patrzhan@amazon.com>
References: <20261030233330.3483988-1-patrzhan@amazon.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

ifi_canfd_open() calls ifi_canfd_start(), which unmasks the interrupts
in IFI_CANFD_IRQMASK and then enables the controller through
IFI_CANFD_STCMD, and only then calls napi_enable(). A frame that
arrives in that window raises RXFIFO_NEMPTY. ifi_canfd_isr() masks all
interrupts with ifi_canfd_irq_enable(ndev, 0) and calls
napi_schedule(). NAPI is still disabled, so napi_schedule_prep() finds
NAPI_STATE_SCHED set and the schedule is dropped. Only ifi_canfd_poll()
unmasks the interrupts again, and it never runs. From then on the
interface receives nothing. ifi_canfd_start_xmit() stops the queue
after every frame and relies on the TX FIFO interrupt to wake it, and
that interrupt is masked too, so transmit stops after the next frame.
The stall lasts until the next close. Every re-open runs the same race
again.

Enable NAPI before the controller starts, so that an early RX interrupt
can schedule the poll. ifi_canfd_start() cannot fail, so no error path
changes.

NAPI must not be enabled before the IP has been reset, though. The
handler is registered with IRQF_SHARED and acts on the raw
IFI_CANFD_INTERRUPT status, and nothing resets the IP before the first
open, so stale status could schedule a poll that runs while
ifi_canfd_start() resets and programs the IP. Split the reset,
configuration and status clear out of ifi_canfd_start() into
ifi_canfd_reset_config(), and enable NAPI between the two. Before
enabling NAPI, wait with synchronize_irq() for any handler that read
the stale status before the reset, so that its schedule is still
dropped, as before. The controller stays disabled until
ifi_canfd_start() unmasks the interrupts and enables it. The bus-off
restart path calls both halves in sequence, so its register writes do
not change.

This is the same race as in "can: ctucanfd: enable NAPI before starting
the controller" and "can: xilinx_can: enable NAPI before starting the
controller". I do not have IFI CAN FD hardware, so this change is
compile tested only and the failure sequence is taken from the code.

Fixes: 0c4d9c94a130 ("can: ifi: Add IFI CANFD IP support")
Assisted-by: LLM
Signed-off-by: Patrick Zhang <patrzhan@amazon.com>
---

Notes:
    v2:
    - Split the reset, configuration and status clear out of
      ifi_canfd_start() into ifi_canfd_reset_config(), and enable NAPI
      between the two, so the poll cannot race with the reset when the
      shared handler sees stale status (reported by the netdev AI review)
    - This replaces the ifi_canfd_stop() call I proposed in reply to the
      review: ifi_canfd_stop() writes ~0 to IFI_CANFD_IRQMASK, and I cannot
      confirm from the driver alone that this masks the interrupts, while
      the split does not depend on it
    - Call synchronize_irq() before napi_enable(), so a handler that read
      stale status before the reset cannot schedule the poll afterwards
    - Explain the ordering in the commit message, and name the ctucanfd
      and xilinx_can fixes by subject instead of "the previous patches"
    - A poll can still overlap the interrupt unmask and error-counter writes
      at the end of ifi_canfd_start(), the same as on the existing bus-off
      restart path. I have not reordered those writes, because I cannot
      test the effect on hardware.
    - v1: https://lore.kernel.org/r/20261021205924.2538511-4-patrzhan@amazon.com

 drivers/net/can/ifi_canfd/ifi_canfd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 0f83335e4..0ff766c7e 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -734,10 +734,9 @@ static void ifi_canfd_set_filters(struct net_device *ndev)
 			     IFI_CANFD_FILTER_IDENT_IDE);
 }
 
-static void ifi_canfd_start(struct net_device *ndev)
+static void ifi_canfd_reset_config(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
-	u32 stcmd;
 
 	/* Reset the IP */
 	writel(IFI_CANFD_STCMD_HARDRESET, priv->base + IFI_CANFD_STCMD);
@@ -760,6 +759,12 @@ static void ifi_canfd_start(struct net_device *ndev)
 	/* Clear all pending interrupts */
 	writel((u32)(~IFI_CANFD_INTERRUPT_SET_IRQ),
 	       priv->base + IFI_CANFD_INTERRUPT);
+}
+
+static void ifi_canfd_start(struct net_device *ndev)
+{
+	struct ifi_canfd_priv *priv = netdev_priv(ndev);
+	u32 stcmd;
 
 	stcmd = IFI_CANFD_STCMD_ENABLE | IFI_CANFD_STCMD_NORMAL_MODE |
 		IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING;
@@ -817,6 +822,7 @@ static int ifi_canfd_set_mode(struct net_device *ndev, enum can_mode mode)
 {
 	switch (mode) {
 	case CAN_MODE_START:
+		ifi_canfd_reset_config(ndev);
 		ifi_canfd_start(ndev);
 		netif_wake_queue(ndev);
 		break;
@@ -846,9 +852,14 @@ static int ifi_canfd_open(struct net_device *ndev)
 		goto err_irq;
 	}
 
+	ifi_canfd_reset_config(ndev);
+	synchronize_irq(ndev->irq);
+	/* Keep between the reset and ifi_canfd_start(): the ISR masks the
+	 * interrupts and only the poll unmasks them.
+	 */
+	napi_enable(&priv->napi);
 	ifi_canfd_start(ndev);
 
-	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
 
 	return 0;
-- 
2.50.1

