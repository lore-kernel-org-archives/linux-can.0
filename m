Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429730;
	b=wjoU6ZT1vjqgdYejbWKjozckltUDQEeUc1KQA8jq+WF3py9nbNIjldR5K3XFyydYVWs5
	 vMYEuOL8oByPvgqzqOlSqbn1nb3JlsDnrtRR2BBsQuBRP87jCpbpOGWkgK5JCkbnbEm3N
	 7+e+5UAqSrUpQGV/V7oXmNiLpm4FjxLKHB1XXl72CmNI7g4h+sVDUe458iuOlPNxt68Lk
	 uV3ewYHZQ7ihnVKzW/9Pgdl8ho5NUWCDM1UNJN2N+Qgq4C9hIj9uGA+DKalp6jx54F0ZB
	 E4b2toyh53e5AXksxXYBAmmOlsVyH+PadT2ZjL0Y1hSc9ER37qAQWMOFdn15CV9Y2Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yLirZqB6CYhD/Z79OKPRPPcYk4WKwFA+Fgl+s2Ogd8I=;
	b=NOaNW/2FEcDW4TBdwVp/f8cIttp9uhyYiF4eestW2s0IoEqvCNp76fRAsx86ny3tcc+m
	 u57ak3EP6xvxKXfG7b2uTeQpRk1UeZE+qCMjb6UFHtV8JsmCdPf/jNmOKfdWMJk6vj/VX
	 ru6i3GALwBZqeiAqs99FNA7rn7RSnCmR6d0rlI0qfb8YmgRfocEP9EGBED1uvWMTFlvqx
	 KWqr2qw0QJerkGuoo/nliFnnunk1q12YxPE3iTkB6uXrQreS/SOm+nklGGXuPpWvS64Gm
	 YXiLFSLdIPXt79y8lrMAGHooVedkjCdR3Obn0oQOPi+b6Iu4PUYgqca8y989VicebZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O84lvzkv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B55606A31F;
	Mon, 19 Oct 2026 17:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B55606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O84lvzkv
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B04372018E7;
	Mon, 19 Oct 2026 19:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yLirZqB6CYhD/Z79OKPRPPcYk4WKwFA+Fgl+s2Ogd8I=;
	b=O84lvzkvhHhjpjaL4+hC59mHOqC8giCyxOXckr6lubf4hYsJ4DLeLOl44lmXDiMqPvxbFw
	WEI2FoXoZFfA6Ogoxb1L0A8jtuVgAm5FTHq/30Iq9h2Gp7wuKIXyzxxgIfE69dL3w5ym1Z
	pVxMyDJxVLmEWqgaJJ6PVuyl68tmak/0Wwp0jpW8YvQ/yco5ue10Nen3T2LlcVRwbx39I2
	mQNGk1PAHDqIIrpfdbM58IOEEb51vpY5/DzI6Bb4x3NdvYbXr/DZo0OGbejsTlFOijx72a
	7kzfzc7FXUoISwCGtAcSri/6cjywGDUVNJ6NZfvjc5I6m1anRgESjjoIT0eU5w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429716; a=rsa-sha256;
	cv=none;
	b=Ems0u8a1dJzrK/3NAw+uFwye/0YNv+9fN0mLpwtP7IIBeiw7T/zAmJDu4vUUNN08gVIRIm
	du+3MgiGFRd7Y0rAeakvHTqYWUd2xViLZVn4DFEu2vqAUFN8wDkIQHj3oTm6K22agn4znA
	P01hlC1/ZptYQoqNyMGg0GP6d6OJpyfIdo2MNhR0mlNkLWAvCuvvJTpW11a7AhEAX9BbBE
	rij+xjkPMzh0rONysMz0m3Xbdrkael6Ji4Q+TwrBUYzF/xe2sjLADpxFN7Ng8Qf1BndnF/
	9OKZUaf6TJRCV6I8AXdb8DvaGukNOBagZt8iw89tHWzOqhzRpW1PBz/N14tUJQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yLirZqB6CYhD/Z79OKPRPPcYk4WKwFA+Fgl+s2Ogd8I=;
	b=PQCko3uml0S9ppWgRG+O+vz3agEgeLRyt4wn6cuYrdRkhs0eYPfP4D9yKpM9fbRLSIGUJr
	GC4BiMLpb+ajT3r7c6znGC+rXRfvHe+XwzzX0iAOaH01a2zXt7nu0HlC5vnVElip+fHx5I
	5nQCuXyc/rtpAGakuC3acUmSocK8eD0Pp4sit7VBF/fwvMy0hL0V5zICGCQFe04EPUkcZJ
	Y35DdhJZiDj7r8E4+VCKKCVSDUbXjv9aG8NnWLD0ZSqJtbYuluMrDlDeQJGGggRyys/LIF
	2Fx8vP4r3bDnSMZUJlmfq+OCOEi7dO3zKcVSuY8qTmrL57nviDuLsqB5xTxITw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqi-000Fg8-1y;
	Mon, 19 Oct 2026 19:08:36 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 56D8A5C948A;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/11] pull-request: can-next 2026-10-19
Date: Mon, 19 Oct 2026 19:01:05 +0200
Message-ID: <20261019170834.1727150-1-mkl@pengutronix.de>
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

Hello netdev-team,

this is a pull request of 11 patches for net-next/main and obsoletes
pull-request: can-next 2026-10-18.

The first patch is by Vincent Mailhol and drops CAN-XL frames on non
CAN-XL devices.

A patch by Sang-Heon Jeon removes a redundant NULL check before
netdev_hold() in the CAN RAW protocol.

A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
for the correct CAN CC/FD frames.

The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
any context in several CAN helper functions.

A series by Oliver Hartkopp et al fixes several problems in the CAN
net-layer:

3 patches target the CAN procfs: A patch by Runyu Xiao resets the CAN
pkg_stats using atomics, a patch by Oliver Hartkopp fixes the stats
calculation after a statistics reset. Followed by a patch to remove
kernel pointers from the output.

The last s patches are by Oliver Hartkopp as well, they convert the
unreliable ARPHRD_CAN type check to the robust can_get_ml_priv() and
protect the CAN receive lists with a per-device lock.

regards,
Marc

---

The following changes since commit 98c2ad4f5d805dbc1ea436a334ee59311806a48c:

  Merge branch 'ipv4-remove-netns-argument-from-fib_table_lookup' (2026-10-16 18:52:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.4-20261019

for you to fetch changes up to 94f33aab0beb5c7eba56be9fab2032b82fa78b86:

  Merge patch series "can: protect the receive lists with a per-device lock" (2026-10-19 18:46:56 +0200)

----------------------------------------------------------------
linux-can-next-for-7.4-20261019

----------------------------------------------------------------
Cunhao Lu (3):
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Marc Kleine-Budde (2):
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"
      Merge patch series "can: protect the receive lists with a per-device lock"

Oliver Hartkopp (4):
      can: proc: skip stats calculation after reset in can_stat_update()
      can: proc: remove pointers from CAN specific proc output
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: protect the receive lists with a per-device lock

Runyu Xiao (1):
      can: proc: reset pkg_stats atomics individually

Sang-Heon Jeon (1):
      can: raw: remove redundant NULL check before netdev_hold()

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

 Documentation/networking/can.rst |  16 ++--
 drivers/net/can/dev/skb.c        |  16 ++--
 include/linux/can/can-ml.h       |   3 +
 include/linux/can/core.h         |   2 +-
 include/linux/can/dev.h          |   2 +-
 include/linux/can/skb.h          |   4 +-
 include/net/netns/can.h          |   2 +-
 net/can/af_can.c                 |  61 +++++++++-------
 net/can/af_can.h                 |   2 +-
 net/can/bcm.c                    |  64 ++++++----------
 net/can/gw.c                     |   9 ++-
 net/can/isotp.c                  |  57 +++++++++++----
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 ++++++++++++++----------
 net/can/raw.c                    | 153 +++++++++++++++++++++++++--------------
 15 files changed, 286 insertions(+), 202 deletions(-)
