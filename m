Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738599;
	b=yaj5ADW+1XWfaZ3ZhSe0MQFM3embyH7WaRzesaMJGyYNvi+FhgTAqTMV+LmHihHQplCL
	 JasKGijaqaEO8XTeB5HhcVOOeZvNxq1YiVnzhvh+FuXBGW7jnSlvCvgEGMYW7IMJWKWSg
	 7qOvJlVYyRlcU6SLCZcpcsq9lbOXysf1h6GkXB03dvVo2+U83dqKBrVVErLogPV78tqr1
	 yxa5yNJ+/s7uABhe8/2x8yGY2hg/dkzd96rtRLarUGgxGYUYtNbB+f3lEQUQaqyAhrpVp
	 hRe1GitmCvtoQPnshVMK6+rbtzEnuRPWr8iDpJHmAgeywU4zay0F/ybP4JUwOaa5uRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738599;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+J+J90AyqEyqknH8YtnvsaeCK8eG/0wfrDCDr/mTMZ8=;
	b=cZm90BBXw+zYApGrp4+BLeFlz8JEnqugQ5F+WHo+C6OrkzRtPbgheJrctbobqW7qCTu5
	 e6UY9K8xB+9KOGeQK3VquLUkwmyGerD52hi6ciPofDbri59zwH9trGHUHHXddbIUoJORx
	 IIvFqmAwNfhtIz2IQeQPxaDRWiuNAvZP3IhrWJ0sF6CS6aK41YDYaWa4LqaA0zmHVPqlp
	 W5xTQwBl8Hi5mPMKmpgP5eomvip1Zdrkjuqcv2kQVKTW6gBy/N9kF9Qxz02gliVyPGspZ
	 bmBBShGgp7U8CshC8Ikwtcjvgx7fPByXMSF5sgDY1wZ83/edfnKoT2qtIi/LlDcHTxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EIaux4U5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE443606A329;
	Tue,  3 Nov 2026 20:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE443606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EIaux4U5
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 81EF5200AD1;
	Tue, 03 Nov 2026 21:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+J+J90AyqEyqknH8YtnvsaeCK8eG/0wfrDCDr/mTMZ8=;
	b=EIaux4U5rwEhu1dm4Q8vq0X1FOsPJtOP1S/Dwl2ayiHDXgIRdFszighjotfM44f4sBrLpb
	1Z4+nnTrZXcM4dY735slVIMSSpyer1hRDy8KgGjfHSjVl/iXhgC4Q5kEnAqokwQSPhgtTC
	dyJurmM/REF10EPwtsT/GXT5ZFsEVxsNeE+v7gL8ZbV4jw0Bxv+q3ZOMwRV5FSlRuwvPQh
	6Z/W0uCvJnnx3aCmMztHHxTJfcOVPt0MEkDfdXzPl+61HuHj0TEKB2uPiJl061NSHIRPfY
	fjCTJW203z1ZCbbT+7MHGhFjKAqduo3RQdb9cHrkMowhobfI57j88ZBlKARMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+J+J90AyqEyqknH8YtnvsaeCK8eG/0wfrDCDr/mTMZ8=;
	b=gosv8x6v6kmBRPBthouujj9iVwdZb4Cxk+PZ8wR04V2VuXVxol/ToIngNwtb+vGvcH0su1
	9uJDUNMfb2+xYYFPnqjE8Ya1dy2kawkEEDXYdBvHpBKadA6OkmeTCdwE8971YRsJAPX3SE
	vSw7hpHX64IiL5/zeDX8ahq9Q3ExzQ4goZDsmTA8Qw38XrIj5lWcyIpbo7bTApOH9naEaf
	soGw3MbV03Vrki8SS9KXJ9+f0vkASdxWaT7uGVH/HhBU22V9/6jYhK4SfILzTwPUU5PauZ
	9rAykE54qJrNrOolhFCSxMJW30MREVBmEDB+ymWgqt3M6meKeTUXhkdLZtxJqg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738590; a=rsa-sha256;
	cv=none;
	b=OuL4hW8NPVkoUEG6aKKZJRv68MwRu9uyomo10Y97Ww1tyXTCF81FQn3vcRUMJOF2IngbAn
	GoBuKQWoe0qFqV19yVWEOYj0DfvQB/3awB96aosnIPw/oiGJ5T7zo3unDTAN0fnHDcZ+Zp
	t2d1Od008OH5Ta6lrZH70sqqNK3Ka0UhkfYWnekKbn9AkzKbBh4L9KirUjgD5zntWHYMOd
	VZEcOcy9hdAc01WhBh+vK7bk2PBir/m6vcg7V9UcNX99Ue3xg5ouiVd7Y6Tq3c2uoAH+0y
	9Jo6R4kj4DthV6sG4zEQ1TT5zjR6v5/tBGYbdONOT0sQIKeW9VS9kuSbvgexRQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLa-002V8D-1K;
	Tue, 03 Nov 2026 21:43:10 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 66F765DDEB7;
	Tue, 03 Nov 2026 20:43:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/15] pull-request: can 2026-11-03
Date: Tue,  3 Nov 2026 21:30:21 +0100
Message-ID: <20261103204305.3211144-1-mkl@pengutronix.de>
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

this is a pull request of 15 patches for net/main.

The first patch is by Vincent Mailhol and drops CAN-XL frames on non
CAN-XL devices.

A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
for the correct CAN CC/FD frames.

The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
any context in several CAN helper functions.

A series by Oliver Hartkopp et al fixes several problems in the CAN
net-layer:

Oliver Hartkopp contributes a patch to convert the unreliable
ARPHRD_CAN type check to the robust can_get_ml_priv(). Further a patch
that adds missing error checking to the bind callback of the CAN
ISO-TP protocol. Followed by converting the CAN RAW, BCM and ISO-TP
protocol to protect the receive lists with a per-device lock. Then the
RAW and ISO-TP protocols are converted to copy the socket options
outside of lock_sock().

3 patches target the CAN procfs: A patch by Runyu Xiao resets the CAN
pkg_stats using atomics, a patch by Oliver Hartkopp fixes the stats
calculation after a statistics reset. Followed by a patch to remove
kernel pointers from the output.

ChunYuZhiQiang contributes 2 patches for the CAN netlink interfaces,
to prevent waking up the CAN device, if the interface is down.

The last patch is by Liu Changjie and fixes the decoding of bulk USB
URBs in the Peak USB CAN driver.

regards,
Marc

---

The following changes since commit 647b81ddefc6364290e67bf33c89d54971f8995e:

  tcp: wait for TIME_WAIT teardown before freeing per-netns ehash (2026-11-03 15:43:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.4-20261103

for you to fetch changes up to 2d4c272e816a5b784f1fc7899256f8826df34edb:

  can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records (2026-11-03 19:54:30 +0100)

----------------------------------------------------------------
linux-can-fixes-for-7.4-20261103

----------------------------------------------------------------
ChunYuZhiQiang (2):
      can: dev: can_fill_info(): don't wake up controller if interface is down
      can: dev: can_tdc_fill_info(): don't read automatic TDCV if interface is down

Cunhao Lu (3):
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Liu Changjie (1):
      can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records

Marc Kleine-Budde (3):
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"
      Merge patch series "can: protect the receive lists with a per-device lock"
      Merge patch series "can: dev: can_fill_info(): don't wake up controller if interface is down"

Oliver Hartkopp (6):
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()
      can: proc: skip stats calculation after reset in can_stat_update()
      can: proc: remove pointers from CAN specific proc output

Runyu Xiao (1):
      can: proc: reset pkg_stats atomics individually

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

 Documentation/networking/can.rst           |  16 +-
 drivers/net/can/dev/netlink.c              |  21 ++-
 drivers/net/can/dev/skb.c                  |  16 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c |   7 +-
 include/linux/can/can-ml.h                 |   3 +
 include/linux/can/core.h                   |   2 +-
 include/linux/can/dev.h                    |   2 +-
 include/linux/can/skb.h                    |   4 +-
 include/net/netns/can.h                    |   2 +-
 net/can/af_can.c                           |  62 ++++---
 net/can/af_can.h                           |   2 +-
 net/can/bcm.c                              |  64 +++----
 net/can/gw.c                               |   9 +-
 net/can/isotp.c                            | 236 ++++++++++++++----------
 net/can/j1939/main.c                       |   2 +-
 net/can/proc.c                             |  95 ++++++----
 net/can/raw.c                              | 278 +++++++++++++++++------------
 17 files changed, 477 insertions(+), 344 deletions(-)
