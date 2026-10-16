Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016102BEFF6
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141913; cv=pass; b=ZSZseJcQUmZDxNCMpprXFDR/GuWcNzONxM02I/ECngT0qQA8whG0szWcdwiAnp6O/ern1ShBRt2/zj5Q5FYOtCm0q6EPRnTZY6cM0pE8MnR0Zpny02gEnTIfbBP7sXEHcx2bywnMMcYwUgPw0rDWtPxlvZuw9TUjjips9eK0MuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141913; c=relaxed/simple;
	bh=xDndF3ON4lbLq1NTP7TzT5RVKrk/ghpnQ0S6yyUA/Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PuNP114tnRq+YmJxhX2U/xt9Kco1HWFNSjPt2wFLy7lgHTcA1xGgn1gADCHqyceCcLS+FZeWpPLRmBLzuDUNflM/VQ2TBCwBXNjIrVc1yRgTPrj0HJmx0Gdj42aYTMb45xhcVAU7AP72IFMsoaZ+wwDV6fruFduYaidku2lwxbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VngxWZt6; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=V4CpC3hS; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VngxWZt6";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="V4CpC3hS"
ARC-Seal: i=1; a=rsa-sha256; t=1792141903; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Idk9aiAyTt5x1v5WAau4IkUb2aJT+vXcbpf5XjQTwPFONskaBIDWod/rBt4ddC8NbY
    YxfMRJSmjm6RtG8CBCEkOuvvEflbMbd0f6TLD/Fi8j3A3owlNvB6Rd/vo8RzzROxK82h
    919oWiIlpiOnfx4h9qEzaapy8IYo4pgMljch0m+3vR3mTKtdErUyTbGTcS2QIrxnGTgY
    3i2LKftoGE4omaO7iFx6QH+cijlI8Vig1oyaZAvZRak7QKzRw8KkQeAV/xjT3qyw16lU
    O22MYBPy8YMh82rkGxwZl/VWge3Ki/XvgA8ocbE8CknZVwWkYqXHGlF2pzimLbhZ/oIl
    3hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141903;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=IrLxgwxw0Eltr6bKgv6T6mFean5fA5eVO4Nrc5fzj0M=;
    b=hRRqFDUtxATh5ixWSvHsEpbpcaP5ioPBJw1vzDfUYwm1MxdMsWMSg8zQHkt6A+VvtL
    ybJy9v0nYq0i/ycCoP3fmTt4P6uCct8lcgEUzV/AKN2947NpKCNbsi46kBKHvC5LybWQ
    r7TkQo5SY+jLgq3qq6u21GxRDd5Gi8/XnvBFagatrR06o3f+zTHgNHATPYV+udf/X8Ct
    U8VwEWBhthXkoTcpAKmXNyyqiOROhnuPeXT61xNu1fVkHkZM0FZlBisL5+yc0ue+M8QU
    Fi0SVXrYF7eOTaQjffd1r1BNm/ezg2Tjob9BZZHmxnHhFhehnYOYS5svqQFraxuYzp5A
    uU7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141903;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=IrLxgwxw0Eltr6bKgv6T6mFean5fA5eVO4Nrc5fzj0M=;
    b=VngxWZt6wyUegWIrGMLvZ7WGJR89nc/X2CqG8bMK5TmgkTSp7vMMLbgeaL9BycbQxT
    s4XGSyKMLwa7b7WG9zx6MC1kRnoQ1FmUWzSg2AmxIzT3kxUMFHHVt34AZ7wyz0xS3ilC
    c+b9sYunmGGcgueFPU+1QpiTMuIOjQHYO25/xsXuu0U01M3XFOy22/4/xV3e/ZwN0LDZ
    zUba+24uGLvqMSXpaqyCV7XLAxRKTje/aBsmNNch3BvcmbJ2N2XwtpTXhOLtKDcctsMo
    V6/pn3MtWZxG2RMBIB+VbhEbvsI4eq7+nk8bDPV8zY7HTkgSZbQADXPJ45RIzaojD8fJ
    eqiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792141903;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=IrLxgwxw0Eltr6bKgv6T6mFean5fA5eVO4Nrc5fzj0M=;
    b=V4CpC3hSHvQnjJWR8WvoXIiu9QIkOKGOuXMpEysMpEBsorkYENuCUz4EtNyJCkQPCi
    6XMO+dVTPXawjNoblNAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29G9BhLK4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 11:11:43 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v3 0/3] can: take rtnl_lock() before leaving the notifier list
Date: Fri, 16 Oct 2026 11:11:25 +0200
Message-ID: <20261016091128.325332-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Norbert Szetei reported a use-after-free in isotp: isotp_release()
removes the socket from the netdev notifier list before it takes
rtnl_lock(). A socket that leaves the list in this window is skipped by
the notifier and has to remove its CAN filters itself. If the bound
device is moved to another network namespace in this window,
can_rx_unregister() silently skips the removal due to the namespace
mismatch and the remaining receivers point to the freed socket.

bcm has the same window and is affected in the same way. raw has the
window too, but removes its filters with dev_net(ro->dev) under RTNL
and is therefore not affected.

This series takes rtnl_lock() before the socket leaves the notifier
list in all three protocols. As the notifier chain is always invoked
under RTNL, the busy-wait loops on the *_busy_notifier variables are
dead code and are replaced with WARN_ON_ONCE().

For bcm, RTNL is only held for the notifier list removal and the
removal of the device specific filters. The procfs entry, the tx_ops
and the 'any' CAN device filters are removed after RTNL is released,
when bcm_notify() can not access the socket anymore.

Tested with PROVE_LOCKING, KASAN and DEBUG_ATOMIC_SLEEP while creating,
binding and releasing raw/bcm/isotp sockets on a vcan device that is
continuously moved between two network namespaces, set down and
re-created, with concurrent CAN traffic and bcm procfs readers.
A bcm procfs reader stalled via userfaultfd does not block RTNL while
bcm_release() waits for it in remove_proc_entry(), also not with a
concurrent removal of a CAN netdev in the socket's namespace.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/

Changes in v3:
- bcm: remove the socket from the notifier list and the device specific
  filters under RTNL first. Then remove the procfs entry, the tx_ops and
  the 'any' CAN device filters without RTNL. In v2 a stalled procfs
  reader could still block bcm_notify() (under RTNL) on lock_sock()
  while bcm_release() waited in remove_proc_entry(), and the 'any' CAN
  device filters were removed under RTNL.
  Clearing bo->bcm_proc_read in bcm_release() is not needed anymore.
- bcm: replace the stale comment about a concurrent NETDEV_UNREGISTER
  in the rx_ops loop of bcm_release()

Changes in v2:
- bcm: remove the procfs entry and the tx_ops before taking RTNL so
  that remove_proc_entry() can not stall RTNL waiting for readers of
  the world-readable procfs entry
- bcm, raw: reword the commit messages so that they do not refer to
  patches outside of this series
- send all three patches as one series for can-next

Oliver Hartkopp (3):
  can: isotp: fix filter removal race between release and netns change
  can: bcm: fix filter removal race between release and netns change
  can: raw: take rtnl_lock() before leaving the notifier list

 net/can/bcm.c   | 47 +++++++++++++++++++++--------------------------
 net/can/isotp.c | 17 +++++++++--------
 net/can/raw.c   | 13 +++++++------
 3 files changed, 37 insertions(+), 40 deletions(-)

-- 
2.43.0

