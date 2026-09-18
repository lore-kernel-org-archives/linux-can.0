Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B863B9950;
	Fri, 18 Sep 2026 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700227; cv=none; b=U5KLdWFQZmlzEHzcxSJ0z0/GcbClIkv9cuhE5+WUg+LDX6Z/99gM87v2J+0+vnHT2+g173kacUAXUQEx8mmGwuVr+i5aNedPIvzPdfJkMOwx3Zr0vaCiwTGmWGTTR82tvIPKMcl4jzcQpzqRGwZu2OlbkGzZLYg3JgrNuBKKvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700227; c=relaxed/simple;
	bh=y2TbDAwAo1IIVfjJZoeR79zdccQQhRlCpZnExy6D19U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKdd6VIwgFtf8qEErIKeRd/vHZG04J+u7HA9nNPQqQuTeovt3zLWqgVM8PWjaCLbb5Yni1VKwEYXcPTv2C07rBTwZxffoNu3fN6IneSGh8oUpSZnKcrEi9bUfPmmFdGRIO60CocQOg4ERzj4ntK6juMklso1/xdWj2kR5QqlVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Go1Xr0W9; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Go1Xr0W9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=MM
	2CSkE8/sEUvzaJ70Ejc/9BpWXF0sFAer+E0T0z+Ms=; b=Go1Xr0W9Dge9YOdBu0
	Jm78s/VUjSOXa2aSkGbe2QnIkXH+L5bCBVCVxeYw443hJIVzICnW/X9b8cbXOR+f
	JLKhrT+/jFqExKJ/jAOUWrtpWJEpf2M2xdnpn9GU7VOFD/nO4f6JAsh3n31Ze8wH
	5ctpB6MCX+oee+LkxThPjEwpg=
Received: from vd-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3X+FaqKxqMQl+BQ--.61271S2;
	Fri, 18 Sep 2026 10:56:28 +0800 (CST)
From: Xue Boyang <m18335910246@163.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	kernel@pengutronix.de
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m18335910246@163.com
Subject: [PATCH net 0/2] can: j1939: fix NULL deref on ETP completion with out-of-range DPO
Date: Thu, 17 Sep 2026 21:56:13 -0500
Message-ID: <20260918025622.192582-1-m18335910246@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+FaqKxqMQl+BQ--.61271S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw13Ary8Aw1UKr4xZFW3GFg_yoW5Ar47pF
	W3KryFkr1vkrn2yr48tw15tryfuanaqr17GasYq3sFyw4rXFsYyr18tr1F9FWUCan5C34Y
	vwnFqw1DCryYga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRDl1gUUUUU=
X-CM-SenderInfo: zpryjjavzrijiuw6il2tof0z/xtbC8hwHtWqsqFwfswAA3C

Hello,

while auditing the J1939 transport layer of v7.3-rc3 we found a NULL
pointer dereference in j1939_session_completed() that is reachable by
an unprivileged user through a virtual CAN interface (all required
capabilities are obtainable inside a user namespace, no hardware
needed).

Root cause: ETP.CM_DPO is accepted without validation, and the final
message distribution looks up the receive queue at pkt.dpo * 7.  With
pkt.dpo moved past the end of the reassembled buffer the lookup
returns NULL, which is passed to j1939_sk_recv() and dereferenced.
The interesting part is that the transfer still *completes normally*
beforehand: TP.DT placement uses "dat[0] - 1 + pkt.dpo" arithmetic,
so with pkt.dpo == pkt.total a final DT frame with dat[0] == 0 is
accepted as the last in-order packet.  The trigger is therefore fully
deterministic - no race, no memory pressure:

    ETP.CM_RTS (size 1786)  -> total = 256 packets
    ETP.CM_DPO (packet 0)
    ETP.DT x255             -> packets 0..254, rx = 255
    ETP.CM_DPO (packet 256) -> dpo = 256, unvalidated
    ETP.DT (dat[0] = 0)     -> packet 255 == rx, completes transfer

    KASAN: null-ptr-deref in range [0x18-0x1f]
    RIP: 0010:j1939_sk_recv+0xd8/0x4b0
    Call Trace:
     j1939_xtp_rx_eoma+0x43d/0x500
     j1939_tp_recv+0x930/0xca0
     j1939_can_recv+0x696/0x900

Both patches verified on v7.3.0-rc3-00313-gdaf677c2c644 + KASAN under
QEMU: the oops reproduces on vanilla, disappears with the series
applied, and the reproducer then completes normally (session
completes, message delivered once with correct dpo).  Self-contained
C reproducer available on request.

Patch 1 fixes the oops by checking the return value of
j1939_session_skb_get() like the only other caller
(j1939_simple_txnext()) already does, while still running
j1939_session_deactivate_activate_next() so the session is not left
stuck.

Patch 2 is a small hardening on top: reject DPO packet numbers that
point past the end of the transfer (pkt.dpo > pkt.total) with an
abort, mirroring the error handling of j1939_xtp_rx_dat_one().  Note
that pkt.dpo == pkt.total combined with dat[0] == 0 still encodes the
final packet and is intentionally kept working - patch 1 is what
actually covers that case.  Happy to drop or rework patch 2 if you
prefer a different boundary.

One design question for the maintainers: the DT placement offset
(dat[0] - 1 + pkt.dpo) and the completion lookup offset (pkt.dpo * 7)
use different semantics for the same field.  It works because window
rebases advance pkt.dpo in lockstep with the packet counter, but it
is the source of this bug class.  A future cleanup could store the
byte offset once, or clamp at DPO-receive time.

Xue Boyang (2):
  can: j1939: fix null-ptr-deref in j1939_session_completed()
  can: j1939: validate the DPO packet number

 net/can/j1939/transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.53.0

