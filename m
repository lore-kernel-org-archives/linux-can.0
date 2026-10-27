Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793111495;
	b=fU/KVYxEtkjoDVLwR5ox7cFGtInVYGnLiaTyZeHDWVd9MOmBPCduwatLp8mPnmozXeIg
	 H8dk9UWwyOm0lc1j8TKiKXjWrJQvQIdHxzKxm8NMgqT4C4Z3nKxue/Hgq1QU2thhbzwjQ
	 yhDqQDd5H70MlqJsRt8lC2cCAvDpCnU+nhmpFocfVkac8Y+dsnzqLv5ehnYKHGcEk1B1F
	 dhmZWttuIYIG8IU7WUISgHNVXab0b+6LR4IkdORJ7tyKXuPwy/QmXdeVHA7YiZK+LRqXw
	 /bS6zsppxZ/Rf5NS3xzixZgdPx9OEjjqfR5E6pLocSt6IxuQBwhgKGLf6XNhP5v1LMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111495;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=7ZMVfzggqNu+t7BBDvU9UfD3T9xayXff8lApCosc9zU=;
	b=bAtbgoyW8U/sx8FYfIxSVBzbxCFLpmcVMMHedtYRHyLt7/Ba2uucMH3LKaNag/x8VWen
	 w7+nNdsIYQqOvQXDbTCBuCgofg00lVQn49uimEMOA/cuZtkzS3SHqGtfUgDT/iNTF9XNv
	 R4StwTITEaaZQjFdf6g3l/DRZeMVDpX8n1THIdF41k5z7Gm2rt4bcw3dlhD/cP6QsO6sJ
	 nD3mSSBLQ3aZpk0sWPZzyksAn3axmHlcEQHyQewvdLUNC180Yt9yD/xXA5wGPGuxVYLQ/
	 JV8ZuWqTL+7EUY4sfglBsfAEtv0gydHJgaUaSFRnT0LN1Nx2FuDLBJ7d2hr2Phz56Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=soYJNmSE;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9Y1uLjrv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EB606A31B
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749EB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=soYJNmSE;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9Y1uLjrv
ARC-Seal: i=1; a=rsa-sha256; t=1793111473; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qtbUw149lXg0uXdIh0IjhfMsZUC+ht8z0cD0lsSOLKcumPS+ZquIN/onEamdFD7716
    IB0cr83IgivqqXnMgxeGkzT/kW3qAvZYJyLIvvpr1UnCaF93FMVY9jxEx+VXZYghKvL3
    vAoff1h+gralx8Of5wTfkC8B5lfRSr63zxlKcYA3synuwnVexZHnqug5Q5f2iYn/rJYM
    lsxoQHx8WD53fzY8f87mNQtlYdqOk+sA4ByETTTjjZQPi9swCdEje3+mnKgNg9fY90Yl
    LthATAXc1oteebrpD5aXQnPrM8xIwwMons8m7Y1L7+bX6hft6FBKg1LbcMc/Y3Kfw3OF
    7QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111473;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=7ZMVfzggqNu+t7BBDvU9UfD3T9xayXff8lApCosc9zU=;
    b=WykWxt4d9dcxkGAljIcHuA0Lnc7cPIvwI/E/M/n3hegt8i3NejoZonKZlus5vW/caz
    OtPvwfeFyUb1YLaGr2OmdITfJJd7ip586DC2oTbbCB0rUlq3OKotxBSC/CfKKW0ScvK8
    wGlL3Fn90R7Nbd7E29pXgU7RW0e0zERM/Fq0YJTF1osup83ZeLZrlky1xfdBiwCx/yiH
    ZMml9fo/aa6EgSdi8DgfisR8O8eROe5tiQD2+bW4F8zCmpYr1zdshhy1RjOTGG0Ur2pp
    FFpaAc/rTw4wXs6yFRGZ4hEsrSGsOQiW4l3ZznKZ5BG7Gt5/eWDJkLamSK2tnPPglTAJ
    0elg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111473;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=7ZMVfzggqNu+t7BBDvU9UfD3T9xayXff8lApCosc9zU=;
    b=soYJNmSE95n8hduhGfbj7JuhdYeGwZJ7nrGod4zwwJLmq5kUHJYMmPDaRy/uSIOjBd
    xmwh85ZrCbRDSBLW6KrtvhbwkCc/ZzOT4vC8HbqzKZVjYqV/Dfk11l2eDqdandIlOQ2d
    ugqhxOPEi/+98QNWRNmRuLfHnU38F1b4HtNv9TBOr5cpPPgH5PEQyVlxLdCo2ZDiRRmj
    i0XKVnxezxAYGCFraUDG9ihmxT1bWYORJfq5LKHrlASHbSgjJI1Xz9g7x38UEwr43iHq
    oHvvl3XOaiRHhzh0TzkQp/YtuNGeMFuM/F7MssLD9pjaEcdt3Szd6dQVb1EhaVhP+2Bi
    IC8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793111473;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=7ZMVfzggqNu+t7BBDvU9UfD3T9xayXff8lApCosc9zU=;
    b=9Y1uLjrvTqzE0Wb2SLDm23pAvhtSJU32ur32AYsD2KbvbsBlrI5vC7U4t5GEfpJE6b
    Z4UOG1YrpNezwKP3UIAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29REVCAL1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 15:31:12 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
Date: Tue, 27 Oct 2026 15:31:04 +0100
Message-Id: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PwW7CMAwG4FdBOc8odklpd9p7TByc1F0zRtslo
 QKhvvtSNmkwoR1t5f/856KiBC9RPa8uKsjkox/6PCA9rZTruH8T8E1eKNJUoiYDjnsIJ/gY3B6
 cOLbETVVQq3JiDNL605V73X3P8WjfxaWFWF60YThA6oLwrVogYaVxXWhDemsAIWZeUr710nFI+
 2Ec172knxtBPo+5afo91PmYhnC+fmOql+3jwlMNGrbSEpM1juzmnl+oCfVtvrzPo84AVeg21pi
 SkR8B+B+AGShsnQtUVDds/wDzPH8Bi/cvMZUBAAA=
X-Change-ID: 20261025-can-rx-lock-cecab2ad832f
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Norbert Szetei <norbert@doyensec.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793111472; l=8858;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=tTanSz32RAGsQmkd4I8Z1jEZ+NTvrov1k2IrhYMtyZw=;
 b=INeuIJqgrBglll78p2JNo8GWQchIdgWg1uGm0r0sgm3ZoBG2pdrUjzJQjs5t32DTRmRZJrQdx
 qNUNFQqRRofC8wGfOQeBAcyv2u+s1c+EiOOi8xErlHhpcgpacx+39TE
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
triggered when a CAN device is moved to another network namespace while
a socket bound to this device is released [1].

Patch 2 makes isotp_bind() check the return values of can_rx_register(),
so that bind() does not succeed with missing receivers.

Patch 4 copies the CAN_RAW and CAN_ISOTP specific socket options from
and to user space outside of lock_sock(), so that a stalled copy can not
block raw_notify() waiting for lock_sock() under RTNL.

Patches 5 and 6 fix the reset and the calculation of the CAN statistics.

Patch 7 removes the pointers from the CAN specific proc output. As it
changes the proc output ABI it is not intended for stable and has been
moved to the end of the series, so that patches 1-6 can be backported
without it.

The code of patches 1 and 5-7 is unchanged since v4, apart from the
rebase of patch 7 in v12. Only the commit message of patch 1 has been
updated after the Sashiko review of v4 to describe the actual NULL
pointer dereference in can_rx_unregister() and the CAN_ISOTP path that
reaches it.

The series is based on net/main.

The idea behind patch 3:

The receive lists of a CAN device are located in the device's
can_ml_priv and travel with the device when it is moved to another
network namespace. But they are protected by the per-netns
rcvlists_lock, so the lock that protects a device's lists depends on
the namespace the caller passes to can_rx_register() and
can_rx_unregister(). can_rx_unregister() silently returns when this
namespace does not match dev_net(dev) anymore.

isotp_release() and bcm_release() leave the netdev notifier list before
they can serialize against the notifier. When the device changes its
namespace in this window, their filters are not removed and the
remaining receivers point to the freed socket or bcm op.

Taking RTNL in these release paths is no option, as CAN_RAW already
holds RTNL while adding and removing up to CAN_RAW_FILTER_MAX filters
per socket, which unprivileged users can trigger repeatedly.

Instead, patch 3 protects the receive lists where they are located: A
spinlock in struct can_dev_rcv_lists protects the lists of a CAN device
(initialized in can_set_ml_priv()) or the 'any' CAN device lists of a
namespace (initialized in can_pernet_init()). can_rx_unregister() then
finds the subscription independently of the current namespace of the
device, which is kept accessible by the tracked device references the
protocols already hold. The per-netns rcvlists_lock only protects the
receive list statistics, for which CAN_RAW, CAN_BCM and CAN_ISOTP pass
the namespace that has been used for can_rx_register().

As a consequence, CAN_RAW and CAN_ISOTP do not need RTNL in bind(),
setsockopt() and release() anymore. bind() is serialized against
NETDEV_UNREGISTER by publishing the device inside the RCU section of
its lookup, as unlist_netdevice() and synchronize_net() precede
NETDEV_UNREGISTER both on unregistration and on a namespace change.
The notifiers recheck the binding under lock_sock(). As RTNL does not
keep NETDEV_DOWN out of bind() anymore, bind() checks IFF_UP after
publishing the bound device, with an smp_mb() pair against the
notifiers, so a down transition during bind() is still reported with
ENETDOWN.

---
Changes in v12:
- reordered the patches: the former patches 4-7 are now patches 1-4 and
  the former patches 1-3 are now patches 5-7, so that "can: proc: remove
  pointers from CAN specific proc output" (ABI change, not for stable)
  is the last patch
- patch 2: check IFF_UP after the successful registrations, so that a
  bind() that fails on a down device does not report ENETDOWN (review of
  v11)
- patch 4: Fixes: tags point to the commits that put the user space
  copies under lock_sock() (review of v11)
- patch 5: note on the x86_64 test results and the architectures
  affected by the memset() (review of v11)
- patch 6: added Cc: stable, as patch 5 is Cc: stable (review of v11)
- Link to v11: https://patch.msgid.link/20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net

The patch numbers in the following changelogs refer to the patch order
up to v11.

Changes in v11:
- rebased to net/main without "can: raw: remove redundant NULL check
  before netdev_hold()" [2]
- patch 6: keep the NULL check of ro->dev before netdev_hold() in
  raw_bind() as found in net/main
- Link to v10: https://patch.msgid.link/20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net

Changes in v10:
- patch 5: register the echo receiver first and the RX receiver as the
  last step, set so->ifindex before the registrations (Sashiko review)
- patch 6: rebased on patch 5

Changes in v9:
- rebased to net-next/main on top of "can: raw: remove redundant NULL
  check before netdev_hold()" [2] (no code changes)

Changes in v8:
- new patch 5: check the return values of can_rx_register() in
  isotp_bind() (Sashiko review)
- patch 6 rebased on patch 5: isotp_bind() resets the published so->dev
  again when the registration of a receiver fails and checks IFF_UP at
  the end of a successful bind(), as raw_bind() does
- patch 6: isotp_notify() reports NETDEV_DOWN only for a bound socket, so
  a failing isotp_bind() can not get a needless ENETDOWN
- patch 6: isotp_sendmsg() and isotp_recvmsg() read so->bound with
  READ_ONCE()
- patch 6: moved copying the user space data outside of lock_sock() in
  raw_setsockopt() to patch 7 to keep patch 6 focused on the locking
  changes and to ease review
- new patch 7: copy the CAN_RAW and CAN_ISOTP socket options outside of
  lock_sock() (Sashiko review)

Changes in v7 (details in patch 6):
- report ENETDOWN in bind() and ENODEV for NETDEV_UNREGISTER under
  lock_sock(), so ENODEV can not be overwritten by ENETDOWN (Sashiko
  review)

Changes in v6:
- isotp_bind() checks the device before publishing so->dev, so a
  failing bind() can not get a needless ENETDOWN (Sashiko review)

Changes in v5:
- report ENETDOWN for a down transition during bind() again (Sashiko
  review)
- comment and kernel-doc updates (Sashiko review)
- patch 4: commit message describes the actual crash path (Sashiko
  review)

[1] https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
[2] https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gmail.com/

Previous versions:
v11: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net/
v10: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net/
v9: https://lore.kernel.org/linux-can/20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net/

Previous versions of patch 3 (patch 6 up to v11):
v8: https://lore.kernel.org/linux-can/20261023121801.3052075-7-socketcan@hartkopp.net/
v7: https://lore.kernel.org/linux-can/20261022114202.180023-6-socketcan@hartkopp.net/
v6: https://lore.kernel.org/linux-can/20261021231130.2085690-12-mkl@pengutronix.de/
v5: https://lore.kernel.org/linux-can/20261020203257.230955-6-socketcan@hartkopp.net/
v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/
v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/
v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/

---
Oliver Hartkopp (6):
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()
      can: proc: skip stats calculation after reset in can_stat_update()
      can: proc: remove pointers from CAN specific proc output

Runyu Xiao (1):
      can: proc: reset pkg_stats atomics individually

 Documentation/networking/can.rst |  16 ++-
 include/linux/can/can-ml.h       |   3 +
 include/linux/can/core.h         |   2 +-
 include/net/netns/can.h          |   2 +-
 net/can/af_can.c                 |  60 +++++----
 net/can/af_can.h                 |   2 +-
 net/can/bcm.c                    |  64 ++++-----
 net/can/gw.c                     |   9 +-
 net/can/isotp.c                  | 222 ++++++++++++++++++-------------
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 +++++++------
 net/can/raw.c                    | 278 +++++++++++++++++++++++----------------
 12 files changed, 435 insertions(+), 320 deletions(-)
---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261025-can-rx-lock-cecab2ad832f

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

