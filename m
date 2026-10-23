Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.163
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792757904;
	b=QIbJOERx3oLESYmZAPcvIdCjPhyrzmds7+gwjnFZZJErdE92mGfoAqDZt1MSEPWefOoy
	 WzxK7w0jfmwS/x6AXOsctxlYmd6YgfEZWfdEpgcxAC7jqUJyMImM9BtWs/fgIxiy/djUM
	 K6Q9peg/4DjJhiFul6ckViRzbkFj0CjnC7DaLQFFJ+SSVPxiD3OXR5PMvUqA0wGdDG6su
	 QWkAghn1nI3pQVtNaIBWxKYC6g9LEjBJIq9KA6CwvwZdu+YE75q4EvIAz7MkyGd0Tb8qQ
	 DF1EfK/DGUIKzhUy8KsUV2Tp+Frde47lhG+iRWAxi24DtJYR/Io4plDyo5iR3jXGRvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757904;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=ZRiOgbaEDbNa6KSyUMI8hl+Vb3i2yDXq6ANcswElMcA=;
	b=JJQdW+D+W+kmm3+rDSmx/d4QLKZMKZ6HF9mZVMywcZEShTsifTOZg4b728Yih3zqyvQs
	 alcZCLP5+KYQFpEUJg/mxl7f2K44F3qevoqFQPIER0iRsDveZtl+DOfJuyLVMGCeeQh6p
	 3SjN0R0ZGuOPADd5zEkKhTGSJAbS4aK4OYhqU6ftG2/ahpvpMECFGY2gDp2ds2+wE5TCA
	 n356GSBb7iFiDmguJC4LSz3sL8e/e8NvDTcS1K2DrT/+eP8PcTvCpFRQWrXP5R3oD6zsf
	 zAKq1WtN3dcuz+IahSMsoAbhQ6RZVzVE/Bhwr1GHNXdAsuG8/kNz/g6Qck/q+BFw/9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mPWoYtfF;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ag2pMIDT;
	arc=fail smtp.remote-ip=81.169.146.163
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225B606A31D
	for <linux-can@vger.kernel.org>; Fri, 23 Oct 2026 12:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E225B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mPWoYtfF;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ag2pMIDT
ARC-Seal: i=1; a=rsa-sha256; t=1792757895; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QMAfQ4TcJ2CMfxIx/6leh1vr5qXslEfyg3TLmIhL8NcyJDOjdwOOXKir1jkZpPtjOl
    p0/hrEXzjZE36Y54uOX46sN+gaL1opJNSv6IT1C0Pe+EddUzoorWWZ8gYCfOEDFnXtuC
    41mpzTjRf5Rcjfr0y3UnWaNSOAskngz1uyLjAdz8xp6wUuDeJXXdc4S9wZaVDvKLf0br
    YhVTVb66QrSZg/NRghmElH0wWOTs7TWNnKkrcNjXda/aV3ueid5ww6oxWUZcXmOEHy7E
    29Mtx+6IalmrbQm/C6Aqn+XJq4Yxelvu0ejURADXm8cpMfO1zWSuyiCsjqLWD6iJhBpF
    QNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757895;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZRiOgbaEDbNa6KSyUMI8hl+Vb3i2yDXq6ANcswElMcA=;
    b=tbdvWrI+0xDj1VaDaHY49JXbMJ7LzlS3jaU+aDV6hwvRvit+sqlLaZOOae7xsm+NC0
    +rMf2oylMM+0d25zF9u4d0cp+u52GOVuCF9H+tDQfFCWNMAHiljkbCQ8dUcLHiTG+yQJ
    T3rlX5zRqcIn1LNZRlWK0H3DzVRcQidEQgzGBsaZ3xS9QnkAIFL0zRp1RVBQBwMnBNkC
    vYcgVoUAofPRA2u1JIdG/t5iL1kY1XDXJh8fbV6OZhvund+EVno0pPeKjrX6Tem0GSwX
    SBvhGy8CRNNZKOcPNB2JXlQ/jGw2WEiUFKLTrxvW4eFOgWF2cPqbCCno68661pH7ggYA
    ZFww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757895;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZRiOgbaEDbNa6KSyUMI8hl+Vb3i2yDXq6ANcswElMcA=;
    b=mPWoYtfFCE5FdNl6IyDJo3YM+WwO9d7w07jOTku3uDn+nD93TPVdib4hka4CJ5zV8q
    MEWe+bV0iQid8r5JnvI4i2O549gElF9ZKFHDu4w2HLC8ns3Qpek1WHAXRr99oZwPv6Gf
    iyx/YyhT4pz9SAY7hWWdkM7u793dhnIe8EjWDe2io3fw5kAEj2N2ypFOZL5Ymrob8gq9
    jZm+jkN67g5vWk5DEzJCjHudYhtvETMXFPFjWnKnfAMHE6u0UaVIW8tbehqpxGvg7Wts
    bvrG9+7bZrzyI1z97pY3SGUjqd8vjVsve6CQdpvo+ZAY8j+SLBVMwC3SX2T9CGrz4hL1
    k6aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792757895;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZRiOgbaEDbNa6KSyUMI8hl+Vb3i2yDXq6ANcswElMcA=;
    b=ag2pMIDTERNHPGmSNQPuF+dw4rzh7aA1jLjpcvA3G1S5Ti6BRsKne0wfg0OMOnDZDL
    PcSGezdeqX/h459VN7AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29NCIFt5j
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 14:18:15 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v8 0/7] can: protect the receive lists with a per-device lock
Date: Fri, 23 Oct 2026 14:17:54 +0200
Message-ID: <20261023121801.3052075-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain; charset="us-ascii"

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

The series is based on linux-can-next/testing, which also contains
"can: raw: remove redundant NULL check before netdev_hold()" from [2].

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
[2] https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/

Previous versions of patch 6:
v7: https://lore.kernel.org/linux-can/20261022114202.180023-6-socketcan@hartkopp.net/
v6: https://lore.kernel.org/linux-can/20261021231130.2085690-12-mkl@pengutronix.de/
v5: https://lore.kernel.org/linux-can/20261020203257.230955-6-socketcan@hartkopp.net/
v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/
v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/
v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/

Oliver Hartkopp (6):
  can: proc: skip stats calculation after reset in can_stat_update()
  can: proc: remove pointers from CAN specific proc output
  can: replace ARPHRD_CAN type checks with can_get_ml_priv()
  can: isotp: check the return values of can_rx_register() in
    isotp_bind()
  can: protect the receive lists with a per-device lock
  can: raw, isotp: copy socket options outside of lock_sock()

Runyu Xiao (1):
  can: proc: reset pkg_stats atomics individually

 Documentation/networking/can.rst |  16 +-
 include/linux/can/can-ml.h       |   3 +
 include/linux/can/core.h         |   2 +-
 include/net/netns/can.h          |   2 +-
 net/can/af_can.c                 |  60 ++++---
 net/can/af_can.h                 |   2 +-
 net/can/bcm.c                    |  64 +++----
 net/can/gw.c                     |   9 +-
 net/can/isotp.c                  | 206 ++++++++++++++---------
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 ++++++-----
 net/can/raw.c                    | 278 ++++++++++++++++++-------------
 12 files changed, 427 insertions(+), 312 deletions(-)

-- 
2.43.0

