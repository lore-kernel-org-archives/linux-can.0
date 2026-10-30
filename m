Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403223;
	b=UA/nRprpr0obd2rFbG2a1TLCSISoQyRJE0zLLgCcdwwpyYLAxgxRAuK/5SpPynv33sUf
	 /F7fUgJBKQR79fi7uPJ5qecwAcludi9hZsQUaWJGmmYoUVvXNHhAkKTYm8muLCBrzJWz4
	 xWTLuywNWN3rIOcYIK3xUQlVbT52D4whg0CsuF/JsoEwbb48TX53cTMgdalsofozpZktw
	 XZBS6KUD58Wrua3kDtkNWxvboyXjLHwdrFX+kzU86BT4LLcc69+u2L6BbYaloVYu4jG0y
	 aXPVyXSYlcVFpPfICB4xcUU6xqzfkGyxKBBa8uQYrlUxpRnxbyUVp8MNcGNz8yQSc5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403223;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=4+rS0wK0oVNjux8X4W6P7uAb/RVdgsNqhchwPp6akbA=;
	b=Tq4Xr0h5GC6foCAWtw5Gb7cKQ1MfbpINMbbgPTme1dG3y63hW+8lzW+q+AwFi2XUDkKN
	 d3XkUWyBJHYVDP168ZHZurokKIqeyRikPzWWRxZckfrfFY4FOGjP9+QYOJMPO6C4x5tqk
	 0pDFzVS+cm2YHBasE/X4JSiTN+GH/4SUeE0kQburjcmcGR9wkQNlepyaED7iwBTv6dFSP
	 rWR3B1uGod+doBaBAhR5Vt7N25qIObnFpKK4NRkVWLY7I2UMDJxobdd/90URK0dvmEIS0
	 SXxnv8ruJj9bkmc87Qp/ehdhXSggHZSs4BcUJ998NXCobGZsx8gENDiA9rXy2ydEzQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fkrVTGIP;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8C606A31E;
	Fri, 30 Oct 2026 23:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A8C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fkrVTGIP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793403222; x=1824939222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4+rS0wK0oVNjux8X4W6P7uAb/RVdgsNqhchwPp6akbA=;
  b=fkrVTGIPLwVfVW5HfKS2Jfj6YzbhYtsnUkk1t/NkJzwz0rCx+UuMveZb
   +x3skp3TcD2IpTgrGo0p2Uqe/28O2PTUlO4M6BXrJEnZARsf/A/d/8+s8
   B4jqIGUmuOkj/90m+MB5JET24GaEKp4gKFkqX6X80ajvheDyAXnjr8ekU
   UN7tg9TiuDf9TGlx5/20ntCH0TEm4jaoBVY2zwo/2mAthmdzHFtHSU5f/
   PTrmNWlebD+1IOMq/hZgWGWWCNQwNEGXozkyWR71V3Jaj9324BUgi83K1
   wWT2sK0m2qNcK6LYOV6e3GS7+/gxReJUkmpkNWLykei4fk47z2xuQTRah
   g==;
X-CSE-ConnectionGUID: 4UoJthxyQJyZqYOlQWKSMQ==
X-CSE-MsgGUID: SdOzf7QYSdaHTdIx/n2sVw==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32707811"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 23:33:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:16913]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id fbf9af3f-28d4-4345-b824-9a52f8440b54; Fri, 30 Oct 2026 23:33:42 +0000 (UTC)
X-Farcaster-Flow-ID: fbf9af3f-28d4-4345-b824-9a52f8440b54
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 23:33:41 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 30 Oct 2026
 23:33:41 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] can: enable NAPI before starting the controller in three drivers
Date: Fri, 30 Oct 2026 23:33:27 +0000
Message-ID: <20261030233330.3483988-1-patrzhan@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi,

Three CAN drivers open the device in the order "start the controller
and unmask its RX interrupt, then napi_enable()". Each of them has an
ISR that masks the RX interrupt before calling napi_schedule(), and a
poll that is the only place the RX interrupt is unmasked again. A frame
that arrives between the controller start and napi_enable() is handled
by the ISR, which masks RX and calls napi_schedule() on a NAPI instance
that is still disabled. napi_schedule_prep() sees NAPI_STATE_SCHED set
and drops the schedule. napi_enable() clears SCHED without scheduling.
Nothing ever polls, so RX stays masked and the interface receives no
data frames until the next close. In ctucanfd and xilinx_can, transmit
keeps working. ctucanfd counts no errors, so the failure is silent
there. xilinx_can counts RX FIFO overflows once the FIFO fills. In
ifi_canfd the TX wake-up interrupt is masked too, so transmit also
stops.

The affected drivers are ctucanfd, xilinx_can and ifi_canfd. The fix is
the same in each: call napi_enable() before the controller start, so
that an early RX interrupt can schedule the poll, and call
napi_disable() on the error path if the start can fail. ifi_canfd has
no reset in open() outside its start function, so that patch also
splits the reset out of ifi_canfd_start() and enables NAPI between the
reset and the start.

Patch 1 (ctucanfd) was tested on QEMU with the ctucan_pci device.
Patch 2 (xilinx_can) was tested on a Versal board. Patch 3 (ifi_canfd)
is from code inspection only. I do not have the hardware, so it is
compile tested only. The sequence is the same as in the other two
drivers, and I would appreciate a test from someone who has an IFI CAN
FD core.

The bug has been present since each driver was added, so each patch
has a Fixes: tag pointing at the commit that added the driver.
Patches 1 and 2 are marked for stable backport. Patch 3 is not,
because it is untested. The patches are independent and can be
applied separately.

I looked at the other NAPI users under drivers/net/can. at91_can had
the same persistent-mask pattern in 6.6 but no longer masks RX in its
ISR since the conversion to rx-offload, so I left it alone; ti_hecc and
virtio_can start the device before napi_enable() but do not leave RX
masked, so a dropped first schedule only delays the first frame. All
the others enable NAPI before the device can interrupt.

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

Patrick Zhang (3):
  can: ctucanfd: enable NAPI before starting the controller
  can: xilinx_can: enable NAPI before starting the controller
  can: ifi_canfd: enable NAPI before starting the controller

 drivers/net/can/ctucanfd/ctucanfd_base.c |  6 +++++-
 drivers/net/can/ifi_canfd/ifi_canfd.c    | 17 ++++++++++++++---
 drivers/net/can/xilinx_can.c             |  6 +++++-
 3 files changed, 24 insertions(+), 5 deletions(-)


base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
-- 
2.50.1
