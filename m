Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578483;
	b=s2xI6tnbZCiB/UEexpQ3WsWeKtNDhQeLdPiaKdcRZcE7GZSLSApM0HMPJWi5ApoMxyGZ
	 Ebb6L8VbEJBaUb64uGaOceeqSza2fKMo5wloDlUwpJBoIa8jO1OAi1p7+9bhd/NygMd3s
	 LJyBmhrOsJKNVuyKK8nsZN6b6Ld7Z/2wTR1LNFYOvH4fNv/K4iaNxlP8HH5P9RfUsp0Ie
	 QPJ/cTtO+n7IFd4LVy5DnrjQQWWBcASymgk6877thUx32MWplel4r9GalGxKWFsEXLM2I
	 ZS/zjxVK2cxvB5cx+AIuIQ82DDZBTN3+EkssvBhJZ/a/0U+iJ1fxozq7vYLJ7U1IzIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578483;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TZ158wQm3wOuJb2oNH0Zr1g4HfzCnRbrSovvwzVv//0=;
	b=QMdpO+/3x7bzcOyrVmOHu5m1fATqii8vClSKEP+TgRzBMXwQYeJWWMkW5hFloOspk2rR
	 UvP8oBb1kard+pNVbran1NtRrydIEteTpq0pmynDz7YTNmCK/JjVfuaShFsjg/7cnkFdJ
	 +d2hkzohwO+faQqalM3iLjpnDEihEQuE32LQJMl1ZYXw+B+8hNTbC0MxZbjU5k3++kLrs
	 VPI9D5GEk5qnK/aQdPBiiDowlS85YRYrbWjdPbUpZ09gRXbUTzxM4HisOXSb1l1CDDdJ3
	 okYKFFQ+1X6WZNRMVKWsTQ7Rh9cD2j9hDLQe64OJxnLNpSQcx0ekYI18kYyRm77yz5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UG+6Tnl0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B596606A321;
	Wed, 21 Oct 2026 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B596606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UG+6Tnl0
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 36356201709;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TZ158wQm3wOuJb2oNH0Zr1g4HfzCnRbrSovvwzVv//0=;
	b=UG+6Tnl0Z4/mIOYurPq9teZq2ZmDii1ZPTAFrW4uaANFC3vSgf7kEdwWbYLXsn1wm5fy59
	TjioN8HMGmjlDAxlAopHxRkBDwQGy3uOsrq5j+a3Fxw/XkEeKpMYbg7Y/yQhuO0HmekAKE
	eEroC9o1FwVC4yTFpFHVxV2iqxqHNnKRwAHmMuU9fmOnLQIa9FwfG6VOKVv8urHHIEjCmX
	1zB+sHv2qJkIdOJHR/RkV6t0GfoBBbM+9AH/ZwHKB7sThqKVbz6Yt+HPK9lWsuq7Bt7lFy
	ZDVe7zWxGOEq2xKiggdi6UvVZ7Dwj7IIXlLCHD8CKIlap+DseKTaluHfMxe1Tw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=DFyg221OVzauGuCide3HufdrCNd1ZB60Xh0/s+27lrkjVnYShC6+WIfR64EvPE16/oOKx/
	aVM9bKNCtcRTuuBFXx3LekpyPHOxm/I6t8uPZUbLrmUptgS+a2fjBfsCdCO4VmDV8ZFV3T
	Dj9ZK3ENFGCVui6xBVOszSjCviIeYLMWgLvY5NkPyGEM+qxQjQFD6vdpnBaq/bHVEv+t3l
	7+f++HK/5bEvFYcSUxUwv8+11V2cVcBQuaBSnI4NUzHRox5oT56SMSPUqVxjHzzyLHc88v
	HtylwhtFqSM91CUIKcbobUIFjpva0Ile8Fb0TFZYlNP5sM03ZzZjTp9IyG9FSQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TZ158wQm3wOuJb2oNH0Zr1g4HfzCnRbrSovvwzVv//0=;
	b=a/Yf5IsV1mwPjeS7voCm6VLZhTt4mEa/NYJ7uEv5F0GOElSQ+CHsNirc3VGWShq6jM13ez
	gsQop2ubsYw/+GuWCStqJaXRMnZiScS9hB9UuLLNZGySubwGnYHRwDTSDPlEsnIcdMKS3m
	DG3SBdaLi5dfUpYY/3+f51tSqyN95K9X7S0bfTxExUdAgsloVzoJwNDb47HZt0NuAzvYaK
	fBricqiTc8H7XnYVztzcoZz05GqYpRKzpK8Fy2C/v6dhh0+W+SAn2Vb7VrxIIUvmQzuYRo
	CSq0TTnahjS/kPnUixSryqA3hvPe2SHB6BZNivFOvX32zbRPSKpu00kN+jezMw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xje-0O;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D59DA5CAFD7;
	Wed, 21 Oct 2026 10:27:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/11] pull-request: can-next 2026-10-21
Date: Wed, 21 Oct 2026 12:24:31 +0200
Message-ID: <20261021102756.1900679-1-mkl@pengutronix.de>
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
pull-request: can-next 2026-10-19.

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

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.4-20261021

for you to fetch changes up to 26e74534310157d284fe9f2518c1503e055b6210:

  Merge patch series "can: protect the receive lists with a per-device lock" (2026-10-21 12:19:14 +0200)

----------------------------------------------------------------
linux-can-next-for-7.4-20261021

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
 net/can/isotp.c                  |  65 +++++++++++----
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 +++++++++++++---------
 net/can/raw.c                    | 166 +++++++++++++++++++++++++--------------
 15 files changed, 306 insertions(+), 204 deletions(-)
