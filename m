Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793020140;
	b=kDSpLNjlFCVqymrhc1yCaQ2YB+vLi83kUaXIup0Xos3bN8IEY+lSvrC59w7aZgOZ/VXc
	 peAA987bT/ZIKYUlWCnl7oCs7vToWKQhRg7VeNa1nkcaER2Iecrie92b1Rfnax5MJbji0
	 +ql3R4uc/ZcjC8fGDE6xcZ9RMVvLcojX3L8qCrW+q2/g1beGf37RGyo6LIF5hrlLmaQgx
	 od9UmZnBQh3lM+58ePlcELuvY6I1KVv3KwG4wBz2/YiTXGeVNypDWsihqg/vl9CdGgBUD
	 SVaLIhf0VP/MTtJLb2idKkSoRvP/NtJKTRSZcrJnDTO/cx3B9u7oA2D3CtDNgz6AvPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020140;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Cb9sl+cTGLdUqjFTz8tf6uN1Myy2+q9OFHtQjRJbzC0=;
	b=XF8QDkvF7swGLKL0pn/2BetF4IGJU5NNvEBBhAXz3p6mwlu0Hn2dBzyKsAQcP4/l29FU
	 fCgW1SJdQeAOGM7+C82aYS3drXwKXu+IXApoQxKjZBf+sBuDpS9ciyyVphV8OzqSCuePY
	 HNQnZc+UsdEPGVbco+pMzhj/N/ghea3H6MV5SjhwlEqYkD82mkiJ1fQunHdOsC1J3DbiA
	 QwB3gUTVyp9E10AVVnaalGRVf1nxkvTLJwhlrwzEDUxbWqbOgbQ1wSDsnETlxwV63djNf
	 uoWUdcXyth1r/U9vUDTSb4Ymuk+IejHE6XYCBWhyvTjRsYoWQp7wOn3rmfDC9c8wY8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="mwk/ZiZZ";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=R2VqfIvR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB44606A31A
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 13:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mwk/ZiZZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=R2VqfIvR
ARC-Seal: i=1; a=rsa-sha256; t=1793020118; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MJDdY9vFkrpe9MJJ8A6HRcnwNBfw5C1B24kH7EXupufzjfTFLkTuASEsz77HQ2G2St
    jRRi7xNxi3PIAafGBgUavyLdWQM6EKM5zSC4dhefK9MKVJNbqPPyccvCuSQC9r71yS2K
    vn/m58h6zCl8v5luir7YDx4w6aUQ6iVqOUnsOX1XFSycSItBk8CZLuimZk8GiHT6tWzs
    jgYYB3HRFTHE2xvYhF8OtmKZvWnjZ7N1F20HaAYm3Ewo0gnhQE5uiO1h9b7Sa2HSvogC
    IDAlNHQEy89m/i+CORC9KENVvPSTqLlfhe9UAqAvzVEgXXm2qIUe7uCf120lwkvLI+aW
    8hQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=Cb9sl+cTGLdUqjFTz8tf6uN1Myy2+q9OFHtQjRJbzC0=;
    b=hf9PRMpSPVEp5JuA2XWm3iIXc4HDFt7zhXdD1ee6ppVSKKmfWhgh+7R1Gtzg0wJM4K
    NJ+Qu3JpMt7Xe+U66djV9QWjmGxJRatKljdK+p2VlQm8Ax9+G7vYdU2r2tHLADsJ8jdf
    DeV3xibq6KOpMQ7rxznKfQhAtrfmd7YnuNr9Fckvald3Re15e9BQ9eBeCQDdXNbvJphq
    QLJnXH0x6gEc5w5Rh+q6mx6IGziPxX+n7ufxwJ3jM0fQ0vIW8qsnmg9MiM5unKE2RZiH
    2HYvPhRtqP6GboLVI1krDe3yLXQ5JxOhXu3z43pBOzg497CmN17ueW52ALLjDF8Hc+bf
    m3bg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=Cb9sl+cTGLdUqjFTz8tf6uN1Myy2+q9OFHtQjRJbzC0=;
    b=mwk/ZiZZHU9RpmtERaxVcAidIUticxgo5Rhf6YjaPn2FWt9eZ71hsBK3IfjQr/4RTc
    5WAXBvseJj498khIRrWREQjT4llvH73UDDbe9oPf3AWXoZvHLzlCHXVkS9zmopZSd1l9
    AoWyKYU9oWVereP3VEXN7LUUBtNH/xQ+9UKitSh9Z9l+k2T9RtYAXUi2xyWL/OJdTx3I
    2WIlzQPkFfof/OaYd1sLsDWQtQVUacbUCZKtrD7otYsLpnDE+qt5ZHT+qEUTYqRUPcVZ
    mXs8AyIdGvVFZhv5S3HVO10gK8a3HsM7X4KuSBBLg7s21kPsnRVE15VoEaz2CA7qivH4
    Gz2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=Cb9sl+cTGLdUqjFTz8tf6uN1Myy2+q9OFHtQjRJbzC0=;
    b=R2VqfIvRwicYCJCqYEeVa1WvnI/5ZVMxcLi9NAvuzg5N2mCxrk0GZi34P9YdAAN3lg
    Y0wpTq7TB4mmQrjaH2AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QD8a2Wt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 14:08:36 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v11 0/7] can: protect the receive lists with a per-device
 lock
Date: Mon, 26 Oct 2026 14:08:28 +0100
Message-Id: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PwW7CMBBEfwX53EXeDQ6hp/5H1YNtNsRQ4nRtI
 iqUf69DKxUQxxntvJm9qMQSOKnXxUUJjyGF2BeB+LJQvrP9jiFsi6FIU42aDHjbg5zhM/oDePb
 Wkd02FbWqJAbhNpyvuPePX51Obs8+z4j5opV4hNwJ21tqhYSNxmWlDem1AYRU8JxL11tnJR/iM
 Cx7zn8dwl+nsjT/F3Uh5Sjf1zfGzew+HzxuQMOaW7LkjCe3usfPqBH1bb6+z6MuAGrQr5wxtUX
 7AJim6QeSu1UHVAEAAA==
X-Change-ID: 20261025-can-rx-lock-cecab2ad832f
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Runyu Xiao <runyu.xiao@seu.edu.cn>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Norbert Szetei <norbert@doyensec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793020116; l=7496;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=LJJubdePhaN612455xfn843LQD2bZ4Ca7JmpxxE6E/Y=;
 b=/UHd++EWd4FEFiDkv30DdqCEDX2xQKGLa4iuK1gqfwo6HWyf8XjKvBXdrlB0dOVl45rHQjVgf
 Y63QIwBRSijC8qJ6PArQqrfImrrCpCR+ihuiGdxW8DX+cjZwFR6Ljp6
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

The series is based on net/main.

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

---
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
v10: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net/
v9: https://lore.kernel.org/linux-can/20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net/

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

