Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616448;
	b=kgwmRjKXE0qprB9wHJkHEFceXyX3qhTDhQlfOkPFJchfjnoYYGuCgdd28YZq/4EyFNSy
	 +gJLh39puRqhZ5nE1Xij1jgbbH9AqB8QkK7s/DP55FGd63Qr4oCFfQrOxiDEFXwCtTtZF
	 gzJ6WqoLbXWAibU5tUgPIwCyzzTDX33CiTGxWNjQpcECw/lY4YERiRcXNvzMiJqPKTVMW
	 jP2+bl9TCKUG13lq9bdSCE0bnq1yO0CP7mHjWCvfM8zJEQFNgc1YiV/JHAENOwqnbuB2U
	 HC4NZ4VBnj/ZvBJV+EfDIUKWdMwKC3HyFUUcjq+5BZxshm7LaPvFoZPF52PhRFV1wxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616448;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=5SoBYLzK+ZdLfi5BCMX08p53Wh7vlbOFUlLFSPM85IU=;
	b=3jf0RRxYklf2UgYjynZnvr6gthnmTdrFqLAWvENNrHoUEpjQNXtoTIIG0enXFcf5l1qE
	 B4Z78zPBNNcKS2vQHckfsUeF9ebhqvysxyhDPfxkAgp/OU+6PabDxloJAZ9Lkgf0qlgAk
	 GOeg3cojzWG/WEdD4whkXXpK1QJsBxzYJGusDhHuAL4nid+jOXNCwv/8TJlY5KuyTGb+P
	 a8b/zx+Kbczdf5cOQZ7IhDya6g5m+Tstbr4QI+ryu85wjVR6qEascZvRoS+VMFC5v0hNv
	 9Ppv71pva4aBwT+aclQvr9QPx9v3iH395lm079VMkxPGGSH9s/NYlGBqtwU6DFjnIRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=UGJmQZnB;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0119606A31B;
	Wed, 21 Oct 2026 21:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0119606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=UGJmQZnB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792616447; x=1824152447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5SoBYLzK+ZdLfi5BCMX08p53Wh7vlbOFUlLFSPM85IU=;
  b=UGJmQZnBXJB6i3PE42zHeplNup0FOWr0FTLyuMS6U0LuUIg/ydSYzvYk
   G1B0GDcEhM1ZxICri9k4ZVATmyf5aiP569iPVjLUioqLSyZO1JxgLEpJj
   RyM6rswdy0TaekTz0R8ds+/gW+LrF9z/3EbsBDZSy81AWtbcpOGH5jUIw
   W9r53/31lfsfvNUWK4WAbK7x8ozCVuQr3pbjTJjl5Mi5r+gR6IKEnaHGC
   sKpf0tuG8oxLqSowmhEf053FXxr+8sJUdNcu8DGpQ4tcqCNOtlOxo4eUc
   JH0opWP0MMxjGhibuU5CqkIRod6xYS0dP+HUTYb4QhE+FAF3QcVzgw1FK
   g==;
X-CSE-ConnectionGUID: 4/rpq61JRLqO9NOaBAgw+Q==
X-CSE-MsgGUID: sYrwamOUTHyVUZD/vCqM3w==
X-IronPort-AV: E=Sophos;i="6.27,170,1787011200"; 
   d="scan'208";a="31778176"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 21:00:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:13056]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.190:2525] with esmtp (Farcaster)
 id d86c36b0-f405-4590-bf50-a87d9474e8c4; Wed, 21 Oct 2026 21:00:47 +0000 (UTC)
X-Farcaster-Flow-ID: d86c36b0-f405-4590-bf50-a87d9474e8c4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 21 Oct 2026 21:00:46 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Wed, 21 Oct 2026
 21:00:46 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] can: ifi_canfd: enable NAPI before starting the controller
Date: Wed, 21 Oct 2026 20:59:24 +0000
Message-ID: <20261021205924.2538511-4-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261021205924.2538511-1-patrzhan@amazon.com>
References: <20261021205924.2538511-1-patrzhan@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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
can schedule the poll. NAPI can be enabled while the controller is in
reset, because nothing schedules it until an interrupt arrives.
ifi_canfd_start() cannot fail, so no error path changes.

This is the same race as in ctucanfd and xilinx_can, fixed by the
previous patches. I do not have IFI CAN FD hardware, so this change is
compile tested only and the failure sequence is taken from the code.

Fixes: 0c4d9c94a130 ("can: ifi: Add IFI CANFD IP support")
Assisted-by: LLM
Signed-off-by: Patrick Zhang <patrzhan@amazon.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 0f83335e4..feb738eb0 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -846,9 +846,12 @@ static int ifi_canfd_open(struct net_device *ndev)
 		goto err_irq;
 	}
 
+	/* Keep before ifi_canfd_start(): the ISR masks the interrupts and only
+	 * the poll unmasks them.
+	 */
+	napi_enable(&priv->napi);
 	ifi_canfd_start(ndev);
 
-	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
 
 	return 0;
-- 
2.50.1

