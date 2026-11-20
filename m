Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.163
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174149;
	b=X8R5HH0x/LWtq9uhrhb0JFPUPmYk2el89qGFez8emd1UzM3Tk4rjykvYqcWrC/t4sPTo
	 oUkSn1auuZcyuPZtSA0JqdU6lRLQepIHk9c5D3Hz7TXgrrvl87TfU8rp6cYKeU9IxlbIJ
	 NvfPzOFCrs9pekwjmC+tEGrwuAvzLGwRoEJi5fAm9c9BWlLJhqnozoTHDfM2zbdjAj/2z
	 DP3TAwim8tDNjxpy2AxeFKLpaoEG5IjMDfl/cMpBU6tiN/pX2wT81ddByjIFP/07wai5u
	 Zmn3ur87bYfJxuGF+ILHsidxvdO5kxvjD2YD4yi/Vmu6GFAaz/GKs0+vMmzLyM5uLpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174149;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pHIc1xiEhnAOPq+iGNrgxrA3oWCI38Y73uVtLvhVhew=;
	b=PYDdB5ISuoHdWdwRoyedf3uWnhARiGy70qyy+z+5I9SA+T1bdeRk2wP+msrcPILIvKVH
	 2m1Z2SryCXeSzYkBdxqheZyXAGwwKoBTJER3TBvw4eh94LzNWkFvXpgvOriExY/a0/IzM
	 5K/2Enk6qzEIK6LvCxevy4rqEeJy8YdXeTeypbRQVtZFm/kkK1VSu1UYXSivVZoBzG2I9
	 3rfXO1rtbaym46VClsZImU/zKKyONdjsyjidaH+rtkNKhjFBiYM2Y0JBUypYcRpLOpwJb
	 RoAQc+a34HcVRPfG3UX9EmWrXbZK492KPJ4dvKwIiFvXwD+tEUjuHn08MAvsdvUCH+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=heWr6Mw4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=v7ttwgyn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.163
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D046606A337
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D046606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=heWr6Mw4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=v7ttwgyn
ARC-Seal: i=1; a=rsa-sha256; t=1795174141; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G1w8yTgVI37H/CavL32Yl+tKVPf92VJmkkx3Et/Xdc9aBlOh7UM+O0YZDp1WSb4YML
    Kwz9fc/WF4UHilcupAWgIEzxrjVwuw4xULNau2NvRhrJqzg4O1fCGjIK8z+cM30hfVPm
    giPbEOOe0kebri+vU1kNQs7ozFKGj0BtSa9LKz5pj2WnjQz1xAl2EQPzU7CsSO2QOHAv
    zg0vPfmSM2XFF0st9FoE6kAiI+nOyqZV4hMUkbRKewHnLppqgoz8i/d7ewIal3I8nR8I
    5DLto6YezvX1WuvU3ItFM1y8SoNWlMYQ4vnVttF5yRib4UNrFQcOLeNCUH2qf9QrXEyQ
    2qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174141;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=pHIc1xiEhnAOPq+iGNrgxrA3oWCI38Y73uVtLvhVhew=;
    b=OKZlSG9qlDaIgZASMAO1YI510epLcqCCkoH3otKQK7mgdmuad7Pb1KWL2qrlFxrk87
    nUHzivk9QWYtf4HSrihamMrUGVYPsjUQ2pdHzSppmMjAV9nNHau+tc68a8Gqr1TxtmFF
    VTx5zpCEpjICB2HT0Q+ZFRXhiwqZRfLVtNwmJNyueDvsgb2pi3g3oDxr89VfXkNBIjdY
    aeb3fadllQKrKkUMOmzrIGyZUxlGiJrcmDafw8bHr8d/rNyzp3Q6rSOIxM92cVCS6mrs
    mlLnzNz/lHVnkwIRT2XCR5ongTl1HtWXdrKq/S1ryF/YFzh8rV7wd01CdAZCtSY1kQGU
    Lilw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174141;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=pHIc1xiEhnAOPq+iGNrgxrA3oWCI38Y73uVtLvhVhew=;
    b=heWr6Mw4rzk2+7WxtmuA2Qd8f8ocdyndPkl1mVE6XEtngReWlJbTuVY+RF1mq+ZfBn
    RV1/MWmeoyNCQ3Xxh6S6QUn5+kEdji/NeYX3l5bj5RCFUi3cCtU2nwWSszPs3hWivgUY
    sRcu3wcS8StZkaDm9kW6+BEo22v9t5Be09DYLwNUWgtMX75HbDwOqXH2Tjae2rtY89Uv
    QlIj1cEdVliGUtBNjupZ22VXmexBHQgIuZEGLJUEemyRw3UNk68FHmQzNsIeJ/3KRYli
    VO3X5Bx6zgTCCNQPJNh6l3voYvOknFMUpmp0y3Oce1jb27ioLvxHuEi7GWe7/8fnYyiy
    FaZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795174141;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=pHIc1xiEhnAOPq+iGNrgxrA3oWCI38Y73uVtLvhVhew=;
    b=v7ttwgyntjH3l4j3kObD8AE64iM79iLvteHY0oDqwPLESGl41Pk0gVmGCz8x1/rgSG
    +SMjvcxYrr30JYssHbCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AKBT1QM5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Nov 2026 12:29:01 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v7 0/8] can: avoid RTNL stalls and fix CAN_ISOTP and
 netlink issues
Date: Fri, 20 Nov 2026 12:28:54 +0100
Message-Id: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Qy27DIBAF0F+JWJcKhqez6n9UWWAYYpr6IduxW
 kX+90K6sSrU5ZVmztXMgyw4J1zI+fQgM25pSeOQg3k5Ed+54Yo0hZwJMNCcM0O9G2jr+8/R32i
 Pvb9SCNahEZpbYUnem2aM6etpvl9+83JvP9CvBSoTXVrWcf5+lm68zP3nb5wyKi2EJqoWeQxvn
 ZvX2zhNrwOupFRscERsDYGM8Ca6GKJvAocKIo5IU0NERiCYxnonmDK2gsgDwnkNkRlREqxmxml
 mYwVRR0TUEJURLaRnyGTrTe0cfUSqj9UFsaCdBjBB6D/Ivu8/Y8mFjiACAAA=
X-Change-ID: 20261107-can-bcmlock-memcg-2d8ae7361838
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174141; l=5964;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=JhOZBthRlpoHxjXgsEe+Zs0ylKEAoOjc50kuQ9/CI5E=;
 b=qI9iWTAav1VQVbg9OCtHpbC3OKaxi/w128m5Ti7FIK5CbV5Mp0jenlZscA6wq8X7mN78lcVzA
 RoD0IXROjvXCaIHp5VTjGsIGD53BfeVdpzQT50+V/03HTVhyii5yMf0
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Hi Marc,

this series replaces the eight patches of v6 in your pull request
"pull-request: can 2026-11-17", which has not been merged into net yet.
Patches 1 to 5 are unchanged, patches 6 to 8 have been updated after
the Sashiko review of this pull request.

The other netlink patches by Zhu Ling ("fix IFLA_CAN_BITRATE_MAX
attribute sizing" and "fix CAN XL PWM attribute sizing") and your gs_usb
patch are not touched. Both netlink patches apply unchanged on top of
patch 8. Could you please update your pull request accordingly?

Patches 1 and 2 avoid RTNL stalls in CAN_BCM: the CAN frames are copied
outside of lock_sock() and the procfs entry of a socket is only removed
in bcm_release().

Patches 3 to 5 replace lock_sock() with a private mutex in CAN_RAW,
CAN_ISOTP and CAN_BCM, so that the generic SOL_SOCKET options, which
access user space under the socket lock, can not block the netdev
notifiers under RTNL anymore.

Patches 6 and 7 fix pre-existing CAN_ISOTP issues that came up in the
Sashiko review of patch 4. Patch 6 makes sure that the rx timeout is
always running in ISOTP_WAIT_DATA state, also when an invalid
consecutive frame is dropped, so the rx state can not get stuck after
the CAN device has been removed. Patch 7 rejects socket options while a
transfer is still active, like isotp_bind() already does. Patch 6 is
needed before patch 7, as otherwise a stuck rx state would also block
setsockopt().

Patch 8 is Zhu Ling's fix for the static FD-NON-ISO mode validation,
updated after the Sashiko review of "pull-request: can 2026-11-15":
instead of restoring the static control modes after the update, a
request that switches off a static control mode is rejected with a
dedicated error message, and the commit message describes the full
impact.

The series has been tested on a kernel with PROVE_LOCKING and KASAN with
the CAN locking test suite, including new tests for patches 6 and 7,
which fail without these patches and pass with them. Two further tests
for invalid consecutive frames fail with v6 and pass with v7.

The memcg accounting patch and the follow-up patches for
raw_getsockopt() and isotp_getsockopt() will be sent for can-next.
CAN_J1939 still takes lock_sock() under RTNL in its netdev notifier and
will be addressed separately.

---
Changes in v7:
- rebased on net/main
- patch 6: move the two length checks for consecutive frames in front of
  hrtimer_cancel() in isotp_rcv_cf() (Sashiko review)
- patch 7: read the CAN_ISOTP_EXTEND_ADDR and CAN_ISOTP_WAIT_TX_DONE
  flags in isotp_sendmsg() after the claim of the transfer (Sashiko
  review)
- patch 8: explain why kernels without commit 6742ca18cb41 do not need
  this fix (Sashiko review)
- Link to v6: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net

Changes in v6:
- new patches 6 and 7: CAN_ISOTP rx timeout and socket option fixes for
  pre-existing issues found in the Sashiko review of patch 4
- new patch 8: updated version of Zhu Ling's "can: netlink: fix static
  FD-NON-ISO mode validation" from the pull request, after the Sashiko
  review of that patch
- Link to v5: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net

Changes in v5:
- removed patch 6 "can: enable memcg accounting for user triggered
  allocations" from this series, it will be sent for can-next
- patches 3 and 4: the comment for conf_lock names setsockopt, as most
  options are read without the mutex in getsockopt() like before. The
  commit messages point to the follow-up patches (Sashiko review)
- Link to v4: https://patch.msgid.link/20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net

Changes in v4:
- new patches 3 to 5: replace lock_sock() with a private mutex in
  CAN_RAW, CAN_ISOTP and CAN_BCM, so that the generic SOL_SOCKET options
  can not block the netdev notifiers under RTNL anymore
- patch 6 (was patch 3): charge the isotp RX buffer to the memory
  cgroup of the socket with set_active_memcg() (Sashiko review)
- Link to v3: https://patch.msgid.link/20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net

Changes in v3:
- patch 2: read bo->bound and bo->ifindex with READ_ONCE() for NETDEV_DOWN
  and shortened the bcm_notify() comment (Sashiko review)
- Link to v2: https://patch.msgid.link/20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net

Changes in v2:
- patch 1: fixed the description of the stack buffer and described the
  remaining generic SOL_SOCKET paths (Sashiko review)
- patch 2: read and write bo->ifindex with READ_ONCE()/WRITE_ONCE() for
  the lockless access in bcm_proc_show() (Sashiko review)
- patch 3: keep the GFP_USER | __GFP_NOWARN flags of memdup_sockptr()
  for the filters and describe the local j1939 ECUs (Sashiko review)
- Link to v1: https://patch.msgid.link/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net

---
Oliver Hartkopp (7):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: raw: use a private mutex instead of lock_sock()
      can: isotp: use a private mutex instead of lock_sock()
      can: bcm: use a private mutex instead of lock_sock()
      can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
      can: isotp: reject socket options while a transfer is active

Zhu Ling (1):
      can: netlink: fix static FD-NON-ISO mode validation

 drivers/net/can/dev/netlink.c |  10 +++-
 net/can/bcm.c                 | 114 ++++++++++++++++++++++++++++++------------
 net/can/isotp.c               |  81 +++++++++++++++++++-----------
 net/can/raw.c                 |  41 ++++++++-------
 4 files changed, 163 insertions(+), 83 deletions(-)
---
base-commit: 4d67cf2fd2352f130c42494a933ba9158b925c65
change-id: 20261107-can-bcmlock-memcg-2d8ae7361838

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

