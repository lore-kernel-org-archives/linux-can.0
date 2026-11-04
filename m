Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809071;
	b=NX7+RzvioeHuROl0tsbtFnm0LajBGyFl8YHLV6PbOjKdyzUCgatKjtMtiWKpGYSIshSI
	 9kxarXBhgxc4/sKAr9a30gd3JctjKfZ/ROYeeKelHTd1lnDUk660BKgPadf4gJJRgnFQR
	 8PPKhkJl7QMyHmfxGqlUk6Q0ixpaHx6Ycsl1AgKlCMGqWuiPcz8UcBvE4tQ0VfChJApit
	 ct/vJ5cbeP/sQQqj3c+LFePY/A/QxLIatOnPsrFDGeS9JWBRbRD9SX/+PA4j//Bw+Ah0r
	 zKQYyO2Wo/ap/n1FDyzFWVbTGn0ZDWqNeASxQV/ixbCe8bY9OhLHz+sH2Y3D+DMDGTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=2+e6jmBb3TVAtQIbMVPpJ4SCqoWrTTlHVV0w8149whQ=;
	b=P6q+HXrMjpyVS2wmiU+N7kzSqF/T4UMuBRbM4SchfhDAWUKkW+boFFXGlp7Pxm3Nfq2Z
	 Ggt6dZwaIi3zYoqXFrvvTia9dzRXMCdshiP2WjSLW8vSPkMRuabQ0H7BXlgNgZ7lzxjn8
	 Oxuj9LROxB/ylmcFHoNU/azG2grx+MEX8+xuSx8oXJZ0+4QCZ+zDmGsZIyGL1fSyLJwxl
	 crntyLKl3DZonDFEoZF/KrjgWNW7qpPGQfKu13qOq46mm5QmxHtlO/ZAPuLaPvVQCGU9M
	 MqNHFbQwRLniy2xnZghsoW2qtlZWeevTwyXzvse4jbbTgeQyaGyKEo4LWWACIkEwG/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ea5ZAnKu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCA606A33D;
	Wed,  4 Nov 2026 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70FCA606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ea5ZAnKu
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5DFC4202BA2;
	Wed, 04 Nov 2026 17:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2+e6jmBb3TVAtQIbMVPpJ4SCqoWrTTlHVV0w8149whQ=;
	b=Ea5ZAnKupVbAKq9YSh4Vc3zojGCRB4gIlkZwaHBeF7xqrIm3e83yGelAAd+aq7Msnqox9m
	U6rTH4UZrToCeJ1NDpL7wj0/W44QUM4GFBeRoD3CHG2TjCiZ9GyKgIjOTLsu1auK8BQkUD
	ykwZ5ytoO1GezZvISliylsKd2QkFazB21qKQcNT3QhUyBFrs0k+ecNNFntokK4Za6bSytV
	Y0e/fKdOoDhJFPCQSPxQGfz5fjlV0L5wWwPdww6NQWRoZCeFjU9Jnf31yqXddj9gypX0Ko
	oXenHV7CEEI5zXj7lKX1OTB0X8xJUG9yMyvZJ9H4hs1jgI78x3I2oUlpKhFxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2+e6jmBb3TVAtQIbMVPpJ4SCqoWrTTlHVV0w8149whQ=;
	b=S8m7YD1OnjY0TQzHn5x5rcvSBcBatsvWoia3uYTO9SKANZGY/GY+81lIUSNtc9J1TSGYvA
	jItB1N2MQRV08ejxfcO47cunUWsejpwlwsnNF19yADmhHe6H8691LqakvRNGAi+2As1hPY
	7n4R2L4bqESfP1Zx8v6kEdeOgnGVRYrObn7Ybrdq5xJrQb4CIchnr5JoRRN5AKx+iQZdIo
	3uQg0WjDvsNqg8pDAvTnXK6enBwLRpww+PjTcIkpwFWCz5xMXRgmNJc0ICractcRIwKipq
	V0Nvbj3dycRMEJSA+Thg8IM446o13ytNmkZirUX8EHLW9t9HatZ7n1r/dcIzNg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809063; a=rsa-sha256;
	cv=none;
	b=QIOTFnMSibkQ59jeQVOw/I+lDinSMgahICUJmla7KOMm2ChPfURPqEtnO9PvYm9S4UG6fF
	hwQvB/vv0NulUxAJJfRjBfOUwISA9Y60h7ryts5Cv1KX8vvsd/m9PRNpI5lrv2PKvuCypL
	ylDxkXZuw82TW1jMQ8rucaAuCVDq9KhK/L517t4F9VcazYQZhq3iyvp0zbNXjlH/IvufwE
	6xewzK4Hx3yiLSAOV0yIwWOI3IYf+FrQbltK5MiICusPZHEuLGhEZnVW7E2NglpkbENLLQ
	9lxfE0vypkIjffEap6uthmDD/3ecESwwbhgnHRtOh/+V1O2c0OFnggdvjR4HJA==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 49B813805CB; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH can-next v2 0/9] selftests: can: add J1939 socket and
 transport tests
Date: Wed, 04 Nov 2026 17:17:15 +0100
Message-Id: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAIta62oC/x2MQQrCMBBFr1Jm7WASJTReRVxM04mN2FEyoRRK7
 27s8vH+fxsol8wKt26DwkvW/JEG7tRBnEiejHlsDM44b6254suGS0Dld6qsVdG6FHtvfOijgfb
 6Fk55PYp3iCQovFZ4NDOQMg6FJE7/4kgLz83WY3GeKQvs+w8lNLfakQAAAA==
X-Change-ID: 20261104-j1939-selftests-12fc860698c0
To: Robin van der Gracht <robin@protonic.nl>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Felix Maurer <fmaurer@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>, 
 Quchaosheng <quchaosheng000406@163.com>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2

net/can/j1939 has had no in-tree selftests. This series adds a kselftest
suite for the J1939 socket layer and the TP/ETP transport, run on vcan with
a CAN_RAW socket as an independent on-the-wire peer.

The timer checks are relaxed by default, for slow CI machines;
J1939_STRICT_TIMING selects tight bounds. Not covered yet: the ETP abort
and timeout paths, and a received Connection Abort on a kernel TX
session, which the stack currently ignores.

Known issue: the stack updates a session from the loopback echo of its
own CTS, RTS and DT frames, and a CAN_RAW peer can see that echo before
the stack does. A peer frame that follows quickly can then cancel the
session and fail a multi test. I have not seen this in QEMU runs. The fix
belongs in the stack, not in these tests.

I used an LLM coding assistant to write most of the test code and to
review it. I have read, edited and run all of it myself, on vcan under
QEMU.

v1: https://lore.kernel.org/all/20261014154435.3577983-1-o.rempel@pengutronix.de/

---
Oleksij Rempel (9):
      selftests: can: install net/lib.sh with the CAN tests
      selftests: can: add J1939 test helper header and library
      selftests: can: add J1939 base functional tests
      selftests: can: add J1939 socket option and metadata tests
      selftests: can: add J1939 addressing and concurrency tests
      selftests: can: add J1939 wire-format tests against CAN_RAW
      selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW
      selftests: can: cover J1939 transport abort and timeout paths
      selftests: can: check SO_J1939_PROMISC receive effect

 tools/testing/selftests/net/can/.gitignore         |   5 +
 tools/testing/selftests/net/can/Makefile           |  18 +-
 tools/testing/selftests/net/can/config             |   2 +
 tools/testing/selftests/net/can/j1939_lib.sh       |  86 ++
 tools/testing/selftests/net/can/j1939_tests.h      | 804 +++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_addr.c  | 679 ++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 180 +++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_multi.c | 869 +++++++++++++++++++++
 .../testing/selftests/net/can/test_j1939_multi.sh  |   4 +
 tools/testing/selftests/net/can/test_j1939_opts.c  | 326 ++++++++
 tools/testing/selftests/net/can/test_j1939_opts.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_wire.c  | 186 +++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 15 files changed, 3173 insertions(+), 2 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261104-j1939-selftests-12fc860698c0

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

