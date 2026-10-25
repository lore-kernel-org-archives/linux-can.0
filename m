Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792963989;
	b=ioJ+BBbZtuI+r9Gci6KrALJCnxjryl60Vd7aOvdwbfasLekEbwigwBDEW7T7353h+IU/
	 fy5WwQwvdjtqBdt+8tc0tIZh/JUgGSndWOMLU10DBocA3f1gWpPiAWATcAV4vPLFAvLN3
	 per0EKALUbLRpKu5v0FE93hWvZ55PicPetc+LjClRgkQEan6QuF5lGdH99NTLNRLCEi8d
	 QCh4nfIDTgY/6DFfMtjeRoCVFf+CMgtzNyuHURMmVct2ICHQ59GkUhps0yflsPeS5wGNV
	 eSlb1NELd2guDOoy0IQbKb7wx+O8guPlL0kha3vyOjqQXO4LhtW8ml1WfNvEMtveVNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963989;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qyfwNHAq36PbOat/9mIbgJ7COEA63Hbf5aDPS60mdDQ=;
	b=dYDRslYyDK9A/iAb0B8aWb0KKw+F/j/Pc794nsIlg0zBEDd5dW/AtMNor+VskKIEbqYk
	 Ot6eLpVWm+b+Du8I3YkJXNoUHuq1+12QEPHFDr83zQ2A2pz5RO7veVxN4dksy8BT+pvq5
	 tMQQTq4TAF0Jjam2adU4eXbcDaInbf11FkA188pSyox3/Td2HN7Srgtq9ASFBvEeZvenT
	 7khtS0yGOPLBNe3Oegfm4oPIugjMPYc5Or+5smdnxSiaGv912F/U6gdPkP/GO7QAmAGfC
	 LXf/FlfIhyMKQQ40hxpMaL4zKN/encwkYC/UP2xKT5XqOTEqrVy9w2tsP0vSsiI7FCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ogDL6k2g;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=NKJARyeD;
	arc=fail smtp.remote-ip=85.215.255.25
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E6606A323
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 21:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E57E6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ogDL6k2g;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=NKJARyeD
ARC-Seal: i=1; a=rsa-sha256; t=1792963980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QyGwXCmgwTTaZkT6DCMhkk9OScIZSt7q37qR6S9MrtEhuojAWRvcxKzui3UnPv+zwq
    HxewuOpApLy6EtjfhRv0Bu8MdzefPGLT3qShzkfCj+pIVaZqDv9cgTtFcbYssamyd8OC
    +LNepHaC6TMUXMHTYsi9aSJ/uQAo5b42pwIF6drdP8RIVequBPughSTkyt/oDK9Sk2bu
    fbWpclYo6wkXKJJxvMriGT/+l3JJpSafErwGZw5a3eu+mPCXV2HTMXg5dU9M/XZjrIXe
    Fp7WNH7xl6ZNnDgy6HZdLsmhfYs/qVv8kFqJbF9z1QOPuaJW1ZyGNOl3ANB/QZ2/+MNI
    JZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=qyfwNHAq36PbOat/9mIbgJ7COEA63Hbf5aDPS60mdDQ=;
    b=c4Eu+HtUXdCgqIhifdJEKTHAPYLLrQh9HReR57fhQTA1aupfjmk9HpQ24DjiGFORYC
    xqTIVOaAGDb4GBoLLWWVs12fVqKwvk/mUXSEtWygLaFD7f+RxfAsQTgSRUxAfyvDyNge
    1w/X710mAHZ4mcIvZR87DoBjCvOJF9wFiKPlF/53OMul3Gp5fndqH8VZFi+NOj86B8sY
    DyM51j0rwy3X6gvp7Wk8ZTzeVLsDIT8eb0bnSRGvc94zaGuS02w8atPNiod5U9ptSIjP
    sI29Rjl5FpFMEZfkjipLTWaNtIrhtsXkbyxWbKQWftXKK11SnZmts+7U5hHDkeQYJcJA
    Lh2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=qyfwNHAq36PbOat/9mIbgJ7COEA63Hbf5aDPS60mdDQ=;
    b=ogDL6k2g+dBo0c++I8LZfnKMnTAdr/rBn2FyzvUYAlEWMjnx//0B1ssRFg6nQTJyzv
    r+gYLhRnOAT6Mnt3HhRUsd/PqhHlMUVq54Hnbk9U6OyX3JOyfwtiUyC9s0Pa+vsgZXkh
    TU9VeouJXgg0cEroigPq6h7Drr5kgB0YnQp/CrC7xY1i4Hx+CiwOY+J7hzK+kU4mybFf
    Y2qYANi26of0rcsyWya93lx+O2g8IaZSurBraQR7EY5V+cgVB/WSu3dtv4qtrU+HiYhE
    jqzRJ/77JTH8mfo9Bmw9GMsxj2SINqVh3JhkWwMn9LO9/f+XDDC9/E6QKrpkbbPAdRm9
    JKLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=qyfwNHAq36PbOat/9mIbgJ7COEA63Hbf5aDPS60mdDQ=;
    b=NKJARyeDlCeDSPTpHH23p2q/+FTjG0nnaiaL4F+5ZGs1VnPVRkaMrgg04trMtYEHty
    K86SWenG7nrH5iKxKxCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PLWxz7w
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 22:32:59 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v9 0/7] can: protect the receive lists with a per-device
 lock
Date: Sun, 25 Oct 2026 22:32:42 +0100
Message-Id: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OzW7DIBAGX8Xi3HX5kVvbiqq8R5UDJktMHcAFX
 FmK8u5dkh56HOnbmb2xjMlhZmNzYwl/XHYxEAwvDTOzDhcEdyZmkss3wWUHRgdIO1yjWcCg0ZP
 U515Jy+hiTWjd/rB9np6ct+kLTamKurApeihzQv3fqoQUPRet4p3k7x0IyKTHQq3jrFNZ4rq2A
 ctfI+H3Ro+WZ4h5zFk/Hh2bQzXyXolqUqIdCIeBhLhYu0nO+dAfL167a2ui/6jCSWcEAu/K2FA
 EAu7llSaBne73X36I6johAQAA
X-Change-ID: 20261025-can-rx-lock-cecab2ad832f
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Runyu Xiao <runyu.xiao@seu.edu.cn>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Norbert Szetei <norbert@doyensec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792963979; l=7107;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=f84QvV8YRpLGJlYn8lj1nwAyDnK+1zSbWZOEnHntU/k=;
 b=YTBrosGtpB5uksxyxP2aSZOcq0C0UvTCrUzqd0sx0Q3UQWuVKIQaBBp2x677D8AH37TtZqM4D
 nSNAf4nedB9DbPlGYR69RDcWmn1GWMiFLkjxsyVVVA1IsDh8MZm19OQ
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
triggered when a CAN device is moved to another network namespace while
a socket bound to this device is released [1].

Patch 5 makes isotp_bind() check the return values of can_rx_register(),
so that bind() does not succeed with missing receivers.

Patch 7 copies the CAN_RAW and CAN_ISOTP specific socket options from
and to user space outside of lock_sock(), so that a stalled copy can not
block raw_notify() waiting for lock_sock() under RTNL.

The code of patches 1-4 is unchanged. Only the commit message of patch 4
has been updated after the Sashiko review of v4 to describe the actual
NULL pointer dereference in can_rx_unregister() and the CAN_ISOTP path
that reaches it.

The series is based on net-next/main and depends on "can: raw: remove
redundant NULL check before netdev_hold()" [2].

The idea behind patch 6:

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

Instead, patch 6 protects the receive lists where they are located: A
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

Previous version:
v8: https://lore.kernel.org/linux-can/20261023121801.3052075-1-socketcan@hartkopp.net/

Previous versions of patch 6:
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
      can: proc: skip stats calculation after reset in can_stat_update()
      can: proc: remove pointers from CAN specific proc output
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()

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
 net/can/isotp.c                  | 206 ++++++++++++++++++-----------
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 +++++++------
 net/can/raw.c                    | 278 +++++++++++++++++++++++----------------
 12 files changed, 427 insertions(+), 312 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261025-can-rx-lock-cecab2ad832f
prerequisite-message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
prerequisite-patch-id: 20f07b0b0e4dbbdb1263e9bae3b652ec5709d87c

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

