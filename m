Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624301;
	b=QcMXk2zihh3VmdKaHg7ZrxMSgdsBUKCi0ykEXmxTVM2f8r2rJnnAGXB3qD+win02Kf7y
	 Q50/hiLlHk7q9YWcSzT6jcwGb1t67S4umpTzaY++42AgVfNvmTjPWe0LELNPyATt3xU8N
	 1CxdEFd7ekSDMPbCeSQNvlGK++Vui3Pvvjq/4qIvgXECP2B07Am1gjHTJL/IO/TKapJNR
	 zOjrb/3Py1n1L5XJA0uHJgllmS8Yy4ux7v+0ScSdbukQN5DOP9CUtITejOyh6U8HKHeY3
	 mqswHFfyZy3ds5xHMBUXquc+WXRgRGXfosXrXttIxBJjHiQtkCgyptO+UGsjTAGds4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UOLd5u+mTeUZU74qOwLNqkVdCULazO++sp3bYRqN8rE=;
	b=SwE/eb+c2QGC+XS5kdOnST/+K0K4dM6X8exy8QAyt5hW2bFtE4N9x6ivndLgzXVBkNv1
	 rkoJJqMxAdlvEohL8hLb6JEYKkxfDJlt5NSDwNGexf+MP7vaFRD/BbMU9Use00gl1P99L
	 BpKofrV7lDVoO7Y2/cJCoXAnZblp/wDr+8kCiUQortLuwGydvXezVySMmLmesiivZ8Nyp
	 VLwASaIOZKXZWGy5BjRRti+3NdXgc16AP3obF3yOuhcOEC2aFDf6NjeQ+iabBEYXhCVYE
	 lUpf1ke0UQ5/Ut+O/CQA2gkLLmHZxozqITBHcKdQa0ods/7q3loc3qECjOOTuJiIdgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U5tsV6wa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E53606A31A;
	Wed, 21 Oct 2026 23:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U5tsV6wa
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 33C79200F60;
	Thu, 22 Oct 2026 01:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UOLd5u+mTeUZU74qOwLNqkVdCULazO++sp3bYRqN8rE=;
	b=U5tsV6wa5092ifeoA9UxivYtULYFLf53+Srfym9SKpf0kptROfjlFOAJdOJf0nhjcQ7vyg
	J3cZ34oxSwPHvdEjS1ki06ZpjK9V584XXLi0+lCxhI+97tJ4tfY9HEJgA+MUo3diJ7qEnp
	iWQtN+ME6dt4zvVAgUHOaW9n0MLwiPrro8NdrHw1PNc5L1v6gt8slnXfNxtk8xOKBQgep3
	/LaTipqzx8us6wpxSxwVrgA1SJCZRnoUDgneJsbo285s31aKDHtwHFecmhkR769B8FysLS
	FtqrmNVwX9qmyYLz23vwuHTSJ5w6xM5mafzmRmai8p6pjFokTZb16Wow6mHYnA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624293; a=rsa-sha256;
	cv=none;
	b=MhmtsvAsKFqzvhN8Ua8HR4JCnSR2OT+93+K+cxXa3y4jeGwgM7p/okLOfDj+CbigS6bysw
	lZWbDxpdq3cDXMBzMF5qBdfh7b9ezXj5XjfjOAJ1b2+Bd7m37DVVOfJkvBN36sN635flIM
	zf1obVgrgsGFKNVZ/rC/efdq3waE3n1zxCq/cFT0gziS7+CdtE9KVJxxbhlTY+xvpspUZP
	xd/zpfseyXBkfkNl2s3//gLSa2KAGFKeCR6QvcS7XWCkBbf/TB5jdToQodvcmAfBF2BEDM
	kKbM9J1ZEjmPUXH3OBZdzW8eJ12UfiyBHG3XhT93LQPkcb540dTxY3zX5XKWdg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UOLd5u+mTeUZU74qOwLNqkVdCULazO++sp3bYRqN8rE=;
	b=PQsqWKQhOGB4kqWHgwufEGsLMZjfLSn3V5qXddU40XedjcRCzb60D/zsVXxguNU+7rVCTA
	tM68r6GoHEUTXT9roD/oKcGJoYzZ3zG44tChZ4KknBDmJWpz2byzTg7o7R//9W4tUK71bc
	eDVOGCil+DwQcjzK2osVsnG/9ejK2j5nBl+/z5kLmMrUt9/AoZwSySlCA1KUYe1V2QF2G5
	0EKlCheOeIJY5LiG39fpA0Zd/HdAyXrDB+6PYuy0D+S7MkuisNXSCTY9jxf++BntyPGCMg
	AOj6Y1yiTatnRvrKpRXz615LqzJsSRbuiy6w245Ihz6vGE74w4nWpmhsOX/dow==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT3-000cW5-0N;
	Thu, 22 Oct 2026 01:11:33 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9272A5D06D5;
	Wed, 21 Oct 2026 23:11:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
Date: Thu, 22 Oct 2026 01:07:47 +0200
Message-ID: <20261021231130.2085690-1-mkl@pengutronix.de>
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
pull-request: linux-can-next-for-7.4-20261021.

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

The last 2 patches are by Oliver Hartkopp as well, they convert the
unreliable ARPHRD_CAN type check to the robust can_get_ml_priv() and
protect the CAN receive lists with a per-device lock.

regards,
Marc

---

The following changes since commit 7dca8514c51ea5219daf7f28bc1a0536b907e611:

  Merge branch 'vsock-so_inq-for-stream-sockets' (2026-10-21 11:58:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.4-20261022

for you to fetch changes up to 80cea9d8546f7533e9161c7f5b156ecd066647be:

  Merge patch series "can: protect the receive lists with a per-device lock" (2026-10-22 01:04:07 +0200)

----------------------------------------------------------------
linux-can-next-for-7.4-20261022

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
 net/can/af_can.c                 |  62 ++++++++-------
 net/can/af_can.h                 |   2 +-
 net/can/bcm.c                    |  64 ++++++---------
 net/can/gw.c                     |   9 ++-
 net/can/isotp.c                  |  73 +++++++++++------
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 +++++++++++++---------
 net/can/raw.c                    | 166 +++++++++++++++++++++++++--------------
 15 files changed, 305 insertions(+), 213 deletions(-)
