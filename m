Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247253DDDD2;
	Sun, 18 Oct 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342225; cv=pass; b=VAM4blDCeuLN/Lj5dqOkrnJPQRGdqTczsLlJ56+qGvuWaAiP90LKQuF1rIK3EicYQ6pKmlzWCuMEN6sBTYkfcAlJkyn63Cy5Q0aTWmZSOmzU14M5z63aqOwRadaG/dqmZ42Iep1HJuPYjSIpe/a1I7snknXT63VWoz5CdIq8gz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342225; c=relaxed/simple;
	bh=LdPcX3fOiXBQME3/gLMnHppHpedHnkGK+VTig36pVi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxD0YQarybswclbI4lkk8JZjcyEsFXf6QAJPwq713xxbBYljpJkA/bmFvjXFesUbx3ahOMVRDG0A9ttwvHlCb72+ZJt8zvdajQBuu03D3e/zGgSZ1sA02C6ULtmo+oqyNXsBZC9IXKGC3RLJighpVK7UKM80hllfFnUMPHoEbSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GPlEPqxs; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GPlEPqxs"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B19662017C1;
	Sun, 18 Oct 2026 18:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R7rfcXulNfnAJJyA19Rxfya0XlPsNYDE/+0uKATa2kY=;
	b=GPlEPqxsxKKW9IhoBdoPldQ9doqmMCoU1DcDrNiRvw5ZY5palacoauWLzDudTV+yEPeJx8
	DN0Rya1yJAh2G8r/c2MiswsmrdnQUFq5RhonGm8dtBNCpgMwoeyWjOjEFYdK7GzVuVTIRq
	E1Bnri+RDL3XodKunQYHzNSjiXHJtsxac32JqTGWYDjaq5DTOYCb3fztUNeZ3fzG/VDIbd
	beeBZ0FXmf1uO9KIew4CxucohEsRCrU0McIVGjbjUwUwwZ1sxMje256uruuaGzZqH+49zo
	MPjtvXzz198rQC80msWQnCy1D4wbccS6dQk5QTYfoqn+AczbTvIx366JDq4hvw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341859; a=rsa-sha256;
	cv=none;
	b=Mfjnq522TtOWO3OvKJ36AoWkDephHMts3QXm8fRtbOPOCV/Ugk4foOpVkM81sGbqu5Bk2f
	IC195ofjPhfiJDfnHsI3Gekr+xKzSfnUQCid0Hjo3F+OvSlWjRtyyLW+hTPkFCnDb9saMi
	l51L6N43ADSBnqJXPXMxfvnTfHw82oOdwhMLlaGHP4dTmZluA8CWIg5d1ez6qC9vTb+b0B
	qMbxvwULJiHQb3Jo2mZpPNdFwuP+CsTFQlx2pbxzoK/rAlWgRDFzgM1ioWLK4hBrKrgfIs
	aGiT/j/w8YIVPcofXuxPW93jGAfC9y9SJM9DAUkl4co1fAvCF0KmeI20Z6G6/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R7rfcXulNfnAJJyA19Rxfya0XlPsNYDE/+0uKATa2kY=;
	b=PUUQSWlEg8sHABkP9ZN0AnMyhBPn6COLWru6ufgbU3oYtFyAWehbXEqGIUZ0Fbzng8ghwX
	QuuQGjeKBLCTCXjx0XfA/ugiFp+bpNDTc1y6HsdsQQYUdkxdymvVL1oqbJZCVNKN9cjg41
	jnsh17ZdeHUgxXaaqy/sUGdNrvpOJhyzVnHMR4iLFTDsB0jIiJBS0PTUnpqOYSHAIkpRrL
	HMGl72HkoH8prjgHZxjn2DzAdDwsQ8s0J6vqoqX7adaGnkLsiHAIpyeg94eaCD7veZjh+8
	xftky7Y33okfmJGE1neS6CmNC3haVaDPUJVLQUEpUJN+JVpP3WBc8R6w0sE63w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzf-0006SC-1u;
	Sun, 18 Oct 2026 18:44:19 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 43B215C7D90;
	Sun, 18 Oct 2026 16:44:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/12] pull-request: can-next 2026-10-18
Date: Sun, 18 Oct 2026 18:41:36 +0200
Message-ID: <20261018164417.1540449-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 12 patches for net-next/main.

The first patch is by Vincent Mailhol and drops CAN-XL frames on non
CAN-XL devices.

A patch by Sang-Heon Jeon removes a redundant NULL check before
netdev_hold() in the CAN RAW protocol.

Oliver Hartkopp's patch converts the unreliable ARPHRD_CAN type check
to the robust can_get_ml_priv().

A patch by Runyu Xiao for CAN proc resets the pkg_stats using atomics
individually. Oliver Hartkopp also contributes a patch for the CAN
proc to remove kernel pointers from the output.

A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
for the correct CAN CC/FD frames.

Oliver Hartkopp series targets the CAN isotp, bcm and raw protocols
and fixes a use-after-free in the in isotp and bcm and converts the
raw protocol to the same locking scheme.

The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
any context in several CAN helper functions.

regards,
Marc

---

The following changes since commit 98c2ad4f5d805dbc1ea436a334ee59311806a48c:

  Merge branch 'ipv4-remove-netns-argument-from-fib_table_lookup' (2026-10-16 18:52:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.4-20261018

for you to fetch changes up to e9244db8f2baa66da454037e093524324ad174ee:

  Merge patch series "can: skb: make echo skb freeing safe in any IRQ context" (2026-10-18 18:32:55 +0200)

----------------------------------------------------------------
linux-can-next-for-7.4-20261018

----------------------------------------------------------------
Cunhao Lu (3):
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Marc Kleine-Budde (2):
      Merge patch series "can: take rtnl_lock() before leaving the notifier list"
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"

Oliver Hartkopp (5):
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: isotp: fix filter removal race between release and netns change
      can: bcm: fix filter removal race between release and netns change
      can: proc: remove pointers from CAN specific proc output
      can: raw: take rtnl_lock() before leaving the notifier list

Runyu Xiao (1):
      can: proc: reset pkg_stats atomics individually

Sang-Heon Jeon (1):
      can: raw: remove redundant NULL check before netdev_hold()

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

 Documentation/networking/can.rst | 16 ++++++----
 drivers/net/can/dev/skb.c        | 16 +++++-----
 include/linux/can/core.h         |  2 +-
 include/linux/can/dev.h          |  2 +-
 include/linux/can/skb.h          |  4 +--
 net/can/af_can.c                 | 21 ++++++-------
 net/can/af_can.h                 |  2 +-
 net/can/bcm.c                    | 68 +++++++++++++++++++---------------------
 net/can/gw.c                     |  9 +++---
 net/can/isotp.c                  | 34 +++++++++++++-------
 net/can/j1939/main.c             |  2 +-
 net/can/proc.c                   | 65 ++++++++++++++++++++++++++------------
 net/can/raw.c                    | 24 +++++++-------
 13 files changed, 150 insertions(+), 115 deletions(-)
