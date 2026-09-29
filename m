Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED83D9042;
	Tue, 29 Sep 2026 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716035; cv=pass; b=Pn/IKvvAxjNwy7wmx2umM8FA+RGacACRGonPfCB6jhdtsfHgMD8sF9HLucmk6Y/cVD1Zrl44M7jtjPxqQMV87pYl+5Kk3D+BdnpPjfgsFB7VU28DmyndHKnNqdB+Y6Z9pNqjoXZXz/O8C42rhgteVML1rBgGqH+7BE8oiJULx9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716035; c=relaxed/simple;
	bh=OvW3mqq/VgbS6/PZZQQXlIG7Vqn9RVGV62AVOnQWjdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PKVnEw2OYJ6jaW1SPCd1BZsljnLxaZG900VPSd6iistunx/PlZcD/MOJyXsp7JQYL3WI5js8VqQl1KJJevaceRdMl2qtsEl1pPD4FpheuyoGZSpodVt/KP+QzLdHzVwQeYk/IpxDGIsMl7Rd9bFEdSj3Od/gg0bOkMGx8CSfyE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VhLYtui7; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VhLYtui7"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3CE2020033C;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wvqZLcmTiHOy/skKrBqtmwU2/fOcUxHEm5Ze2FhBGHo=;
	b=VhLYtui7CwDM7hV1pUudFvbPFJ+3cgJKiBNYryfsP6c+sBTpuao1xY0QuCWnym04xeIY1/
	exD6ULIMhjF8IqTa30O6vNnwkvyGqBvhwacxk7wMNCI4DUUd7huTuEkxVlIGkypitBPpD9
	B3viJV4KtvmrKRimeySdginCPGZp27hOyhqbA543PtEv7Md9H/0BmQd7ZIAKPOqwt378EX
	Ii2/RyJ36yzhFQymzlteT2zNAoJpiNCdPZ4YcVnj55VB2+581Q2UvJsJo1jD8sPuGOF8ur
	xZZ6WIdzTFxCrBpHc8OEyFCqsVDHaPYWaYRCHVUumyErzVT6xlo2BkQ3JfOaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wvqZLcmTiHOy/skKrBqtmwU2/fOcUxHEm5Ze2FhBGHo=;
	b=QGncEyiIWD6knxputZh43kJ1fF4nS5j2O20w+twnLQehxamOxpKHawLF+oWpjsyuDONzqD
	4gVkdhSRi9kmTclCYrRXASTyQ1pNdyD6SwVLJ1j7LmSAPMS0LDyIhx9HxqGXHsMGbRVLMp
	n4nt/9A1FJH6EbEUjgAeNzJdGm4VSnEYTmHmEzYCX8QPZrioxFmb3J+W5PbYMduOeg+xex
	dHnMiUw9NaT6i/yioRlhnAhoJiI2yWLoSKoppx/DltKn5rK0vceWQKyOyPk2e+1CziyoY4
	kBNd6vkIvgyPf+dPFS+pT4SkJvDn4ZLzIgKMOphM5xwGS0PQKaepqCDabgsPYw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=d2zl3tkDiw1y+Vg0Z0oAINRFVBQfmnKpbFOXOy2mySvjajYtez6Tpgq8jNOKR6CRNmtv5x
	N1OMouAl6SdQ6/HvnsEYEypCSMhLiHXAxpsZh7Vd+t9urZC2WoLUSc6PoWfK3JCwPGNfQ+
	rVG8eLwfRR/3LUwJimvK3hUaof4IqU8dCICFM7+uu3s9Re6zypVOHnRmAihB3FSnSA7mpM
	ZWn7meH4yeeXVUZ6FHVuOH6AgCD0noCdENIS0momh93rfLDsdJB62BtgoFusNf/M6O9ZWL
	KqlPN0rAttZihr9sOt+Zk6CAfD+puySRQeb1luaP6CEw8YbtcXycfhSyCsEBeg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3Y-0N;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D38DD5B4CD0;
	Tue, 29 Sep 2026 21:07:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/16] pull-request: can 2026-09-29
Date: Tue, 29 Sep 2026 22:43:50 +0200
Message-ID: <20260929210700.1183036-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 16 patches for net/main.

The first patch is by Vincent Mailhol and drops CAN-XL frames on non
CAN-XL devices.

A patch by zjamg restores the skb header initialization lost during
the v7.0 release cycle.

Oliver Hartkopp contributes 3 patches for the CAN net layer, the first
one fixes the net namespace integration for BCM, ISOTP and the CAN RAW
protocols. The second one converts the unreliable ARPHRD_CAN type
check to the robust can_get_ml_priv(). The third one fixes the unique
skb identifier regression under RPS, introduced in the v7.0 release
cycle, which causes lost packets.

A patch by Joshua Crofts adds a missing
pm_runtime_dont_use_autosuspend() to the m_can_pci driver.

Maximilian Zimmermann's patch for the xilinx CAN driver adds the
setting the ESI and BSR flags in the receive path if they are active.

Jiale Yao's patch for the mcp251xfd driver rejects devices without
match data.

Ji-Ze Hong fixes a struct size mismatch in the f81604 CAN driver.

The next patch is by me, targets the gs_usb driver and adds
workarounds for the HScanT USB to CAN adapter.

Cen Zhang fixes a slab-out-of-bounds read access in the kvaser_usb
driver.

A patch by Stefan Günther targets the peak_usb driver and fixes the
CAN-ID when reporting CAN errors.

Chris Strong contributes 2 patches, to fix an out of memory and packet
loss problem in the mcp251xfd CAN driver under sustained receive
traffic.

regards,
Marc

---

The following changes since commit a7bfaba4823e3c165bb2004c74eff7c096672bc7:

  ipv6: fix prefix route expiry in modify_prefix_route() (2026-09-25 17:34:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.3-20260929

for you to fetch changes up to 085eb39e46ae1b6f3934eb3785be2077aae73ac7:

  Merge patch series "can: mcp251xfd: bound RX offload batches during long IRQs" (2026-09-29 22:38:08 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.3-20260929

----------------------------------------------------------------
Cen Zhang (Microsoft Security FORGE Labs) (1):
      can: kvaser_usb: validate command format before parsing in hydra receive path

Chris Strong (2):
      can: rx-offload: add IRQ queue flush predicate
      can: mcp251xfd: flush RX offload queue during long IRQs

Fan Wu (1):
      can: gs_usb: kill RX URBs before destroying the netdevs

Ji-Ze Hong (Peter Hong) (1):
      usb: f81604: fix struct f81604_int_data size mismatch

Jiale Yao (1):
      can: mcp251xfd: mcp251xfd_probe(): reject devices without match data

Joshua Crofts (1):
      can: m_can: pci: add missing pm_runtime_dont_use_autosuspend() call

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Marc Kleine-Budde (3):
      Merge patch series "CAN netlayer fixes for stable"
      can: gs_usb: add workarounds for HScanT USB to CAN adapter
      Merge patch series "can: mcp251xfd: bound RX offload batches during long IRQs"

Maximilian Zimmermann (1):
      can: xilinx_can: set CAN FD flags on received frames

Oliver Hartkopp (3):
      can: remove CAN filters independent from namespace
      can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
      can: fix unique skb identifier regression under RPS

Stefan Günther (1):
      can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

zjamg (1):
      can: dev: init_can_skb(): restore skb header initialization

 drivers/net/can/dev/skb.c                         |   7 +-
 drivers/net/can/m_can/m_can_pci.c                 |   1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c    |  21 +++-
 drivers/net/can/usb/f81604.c                      |   2 +-
 drivers/net/can/usb/gs_usb.c                      | 129 ++++++++++++++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 135 ++++++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb.c           |   2 +-
 drivers/net/can/vxcan.c                           |   3 +
 drivers/net/can/xilinx_can.c                      |   6 +
 include/linux/can/core.h                          |   3 +-
 include/linux/can/rx-offload.h                    |   7 ++
 include/linux/can/skb.h                           |   4 +-
 include/net/can.h                                 |   2 +
 net/can/af_can.c                                  |  56 ++++++---
 net/can/bcm.c                                     | 107 ++++++++++++-----
 net/can/gw.c                                      |  10 +-
 net/can/isotp.c                                   |  36 +++---
 net/can/raw.c                                     |  17 +--
 18 files changed, 461 insertions(+), 87 deletions(-)
