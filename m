Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616379;
	b=d7yZKGszF/c5fKJedMR75MJIbhpEi51G5YwOyAIRmOcCdMLonwFH0pfO7sAtwgKKBxrW
	 EWw5bJgKQlwFBYDX36+Gtqj/PgyankAzEfKztOohwAKLmQ3kFMhfirMhbbQ21x1ioAVwu
	 SnV4Mi3Ak3WQ8RXPv8w3mV4sQlGEu4eLMsGECIbvq93Ch0R3wTu3fAOd7+atMxzLpHjUV
	 QNG0WyxRaW9TE6BAajD1v3lRupWyDyZxdICQFGUNw6FZQHBg3He9nyIxmJQ0Jc4uKfjtt
	 TAn3O/SYXiEWlt82sWfaRoCwED3VkgXhambY4wGYfH1e2RH+BPnBF8dY62rpPbUDekA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616379;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=MB1VWokoTNzjBoK6XypOYuBfmm/Gm+5i6Hamx66M7Xk=;
	b=KmvYnVy3DhA8dBtaXaWgh957l/VkqQnqpIFyHR2JabHfYwlRl8YbenfNOzrP4OFheFKG
	 O1T6aLDIWDqmixD2zXQ9BUt66IVy8/x6e9dsxmbomSA4CRlRwP/JXcXIgxZfqcth3YGVH
	 hxSALx4/lZY1wOkCZRmDndnob7lagnz3NVV6s6WhfNjbazcHgnDz2Xij4zqb2GoiRBsv3
	 fgYgmvj23l70n+FuXD+gVpukKGEoAlTvg3W//8GBFa2/Dml8tIpUW51hvW38jqViIiUX8
	 Zgcrac1qcoXpUXeWsgo1jvhbDHYwoZ6rJQ/MHvsaAQicX3Ksr2H/3dYz5UNGIY+EW6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=KsArCnRI;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A08606A31D;
	Wed, 21 Oct 2026 20:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A08606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=KsArCnRI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792616379; x=1824152379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MB1VWokoTNzjBoK6XypOYuBfmm/Gm+5i6Hamx66M7Xk=;
  b=KsArCnRInEnPRSdlXhbTSvNgjCsLWAE43TBIw0DdG4I+YV6Lf301gKeA
   xzEnXTXxqFlqhVjE6ELYVu8F5Xdr8hHJGHAH0ptFu/Yh1k24XZWuCoui6
   p87W3PdyzZNs4FJAKyEcHety38/+P0QSUqpjTyMazHkVowLPzGIqciQnk
   r7wEeXelbRKrVMF2FcU9Y65TvZxM5oUDl9POWqg33G5RcmSCTHf3dA0m1
   HUcu1XVpbbfs+aFlwGs5Aub9cZpz6m8jgvzCmgDXOg5uxUv7f3kSuQsFq
   dzq7OsYKXxWqWG32sp/KLrTP43QOK2/KYv10OsyiWNPfPc0m7qL4cMPof
   A==;
X-CSE-ConnectionGUID: Rkmt/MsITkyPWq0IYQKaUQ==
X-CSE-MsgGUID: QqDTH57+TNeT69MrtTe1mQ==
X-IronPort-AV: E=Sophos;i="6.27,170,1787011200"; 
   d="scan'208";a="31914408"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 20:59:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:11671]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id 3c360efc-706c-4df0-9397-675341b7d311; Wed, 21 Oct 2026 20:59:38 +0000 (UTC)
X-Farcaster-Flow-ID: 3c360efc-706c-4df0-9397-675341b7d311
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 21 Oct 2026 20:59:38 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Wed, 21 Oct 2026
 20:59:37 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] can: enable NAPI before starting the controller in three drivers
Date: Wed, 21 Oct 2026 20:59:21 +0000
Message-ID: <20261021205924.2538511-1-patrzhan@amazon.com>
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

Three CAN drivers open the device in the order "start the controller
and unmask its RX interrupt, then napi_enable()". Each of them has an
ISR that masks the RX interrupt before calling napi_schedule(), and a
poll that is the only place the RX interrupt is unmasked again. A frame
that arrives between the controller start and napi_enable() is handled
by the ISR, which masks RX and calls napi_schedule() on a NAPI instance
that is still disabled. napi_schedule_prep() sees NAPI_STATE_SCHED set
and drops the schedule. napi_enable() clears SCHED without scheduling.
Nothing ever polls, so RX stays masked and the interface receives
nothing until the next close. Transmit keeps working and no error
counter moves, so the failure is silent.

The affected drivers are ctucanfd, xilinx_can and ifi_canfd. The fix is
the same in each: call napi_enable() before the controller start, so
that an early RX interrupt can schedule the poll, and call
napi_disable() on the error path if the start can fail.

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

Patrick Zhang (3):
  can: ctucanfd: enable NAPI before starting the controller
  can: xilinx_can: enable NAPI before starting the controller
  can: ifi_canfd: enable NAPI before starting the controller

 drivers/net/can/ctucanfd/ctucanfd_base.c | 6 +++++-
 drivers/net/can/ifi_canfd/ifi_canfd.c    | 5 ++++-
 drivers/net/can/xilinx_can.c             | 6 +++++-
 3 files changed, 14 insertions(+), 3 deletions(-)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.50.1
