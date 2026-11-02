Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660631;
	b=mfyke5tdO0wlh433XVmum+SpER6M441wDSk4D55YJPsXUwPAWqK2LGoxa5ErqXMbBHHd
	 AY8dxR6/5vSJwgK5qkONNqA/b+MP6COr7Ec/gHn2jxEQrZM1COJbpH5zxjjaZjlihbxf7
	 M64kYyyI+wXGf3eXDqYjuI5VW5cF2paBpThSTLb+7LU/MzhbGeWErPBBu7VTtHK3w+ap5
	 nPwcQ0kFAZIOcDD5r5yEALhLqTdys4iPQny/uXZ7n76vWrPP7/1Y4XlR7bBr1PMGPFiAy
	 fPlwAwnmoYseNeTik+2qfqYU4MFbUw0SQTXJiakPecYlwXebWOFHeBlkzCm/Yq+c4+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660631;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2JYma61MnefvLheSRZgzZx+jUgDQmYKCmmC56mkbM74=;
	b=yUberKcND8jKadPGG6GcU9vZAAz0c/gUy5cipWhWMSfDi3OhbHBiqm7mtcjzzrKomlf6
	 8b4+KG/TVnNUvIgSErJXEfhKrk58ifo44zJeXFYaYTieP284MFiVgJb5RQYJRXRiv92nF
	 Z3iQjeZSMjIDMnodxYezQkMSFuCPnJPPsJP0VzCS0nQ20Tm3HKv2Xp03cSCDNT9VAnaCW
	 GZVIKQ5fTeoPottrb6Y2vZHGxV+0Mlcuq/4VMDVYsAyaCOMoI8OYxCvTdX1x90BZStEpf
	 e/GxaEKpD3xxW+HZxHKOHhKQxOFDyHaHOdU2GiXfE+oU450k19ARpyVkswWdL88R+Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=bZ3PE852;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05767606A336;
	Mon,  2 Nov 2026 23:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05767606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=bZ3PE852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793660631; x=1825196631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2JYma61MnefvLheSRZgzZx+jUgDQmYKCmmC56mkbM74=;
  b=bZ3PE85295p52qBAU1VE7JRD/iuZ4uShrJ0y1zKEH6JxrDOdkGH75itm
   4hvGdBwdsjLAILPngN2MQYKvk6QFL5eBWjlkDZ5oM6b4BXgjmdQQ6TLFe
   FHDTGGR9i72yU3n6Qtg/EZxDt/MaKqIZUwrRl7hcUsKLf3kDaxlPYhdQJ
   Xkh9tcbaL1aDo7rCfKt36120/3BPoJLovlwflM+lxzDpuwiRXH9ufpKKC
   cB4Lw/AtZUtCS+Un/8H5HpT5Q905zoNChqZkDsE02pZ9buo9MI8P9XheE
   v9p5cg64V0h6hhDUKeCigidztQ4B332rhu99hNeJ0bpKeHJnfMAaFnAjU
   Q==;
X-CSE-ConnectionGUID: /2mUoODFSVKnxiTmT/xhZg==
X-CSE-MsgGUID: y7rrrhvATMe1NO+TUp06aQ==
X-IronPort-AV: E=Sophos;i="6.27,192,1787011200"; 
   d="scan'208";a="32825452"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 23:03:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:24940]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.155:2525] with esmtp (Farcaster)
 id ddd4eade-2b2f-4177-9d8f-53607ac5a503; Mon, 2 Nov 2026 23:03:50 +0000 (UTC)
X-Farcaster-Flow-ID: ddd4eade-2b2f-4177-9d8f-53607ac5a503
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 2 Nov 2026 23:03:50 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 2 Nov 2026
 23:03:49 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] can: enable NAPI before starting the controller in two drivers
Date: Mon, 2 Nov 2026 23:03:37 +0000
Message-ID: <20261102230339.1260288-1-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi,

ctucanfd and xilinx_can open the device in the order "start the
controller and unmask its RX interrupt, then napi_enable()". Each of
them has an ISR that masks the RX interrupt before calling
napi_schedule(), and a poll that is the only place the RX interrupt is
unmasked again. A frame that arrives between the controller start and
napi_enable() is handled by the ISR, which masks RX and calls
napi_schedule() on a NAPI instance that is still disabled.
napi_schedule_prep() sees NAPI_STATE_SCHED set and drops the schedule.
napi_enable() clears SCHED without scheduling. Nothing ever polls, so
RX stays masked and the interface receives no data frames until the
next close. Transmit keeps working. ctucanfd counts no errors, so the
failure is silent there. xilinx_can counts RX FIFO overflows once the
FIFO fills.

The fix is the same in both: call napi_enable() before the controller
start, so that an early RX interrupt can schedule the poll, and call
napi_disable() on the error path if the start fails.

Patch 1 (ctucanfd) was tested on QEMU with the ctucan_pci device.
Patch 2 (xilinx_can) was tested on a Versal board.

The bug has been present since each driver was added, so each patch
has a Fixes: tag pointing at the commit that added the driver, and both
are marked for stable backport. The patches are independent and can be
applied separately.

I looked at the other NAPI users under drivers/net/can. at91_can had
the same persistent-mask pattern in 6.6 but no longer masks RX in its
ISR since the conversion to rx-offload, so I left it alone; ti_hecc and
virtio_can start the device before napi_enable() but do not leave RX
masked, so a dropped first schedule only delays the first frame.
ifi_canfd has the same race; see the changes in v3. All the others
enable NAPI before the device can interrupt.

Changes in v3:
- Drop the ifi_canfd patch. The netdev AI review of v2 showed that a
  safe fix has to reorder the reset, error counter and interrupt mask
  writes in ifi_canfd_start(), on the open and the bus-off restart
  paths. That change is no longer obviously correct by inspection, and
  I cannot test it without IFI CAN FD hardware. The race in
  ifi_canfd_open() remains.
- Patch 1: no changes
- Patch 2: add Reviewed-by from Harini
- v2: https://lore.kernel.org/r/20261030233330.3483988-1-patrzhan@amazon.com

Changes in v2:
- Patch 1: add Acked-by and Tested-by from Pavel
- Patch 2: correct the commit message, which said no error counter
  moves during the stall; the RX overflow interrupt stays enabled and
  counts rx_over_errors
- Patch 3: split the reset out of ifi_canfd_start() and enable NAPI
  after it, with synchronize_irq() in between, so the poll cannot race
  with the reset (reported by the netdev AI review). This replaces the
  ifi_canfd_stop() call proposed in my reply to that review; see the
  patch notes
- Patches 2 and 3: name the related fixes by subject
- Rebased on current linux-can main
- v1: https://lore.kernel.org/r/20261021205924.2538511-1-patrzhan@amazon.com

Patrick Zhang (2):
  can: ctucanfd: enable NAPI before starting the controller
  can: xilinx_can: enable NAPI before starting the controller

 drivers/net/can/ctucanfd/ctucanfd_base.c | 6 +++++-
 drivers/net/can/xilinx_can.c             | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)


base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
-- 
2.50.1
