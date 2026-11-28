Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795869655;
	b=X9NYV2aVBFVJ+96H4pwLjPc8sAtCzTGd1gNxwZ7Q4OhCvWkMWlEkmVx/imhiDLBB6lLP
	 eUcKf+XVrlCouEYcicNFlkj7I9oWrek4R1OWxgPdjHqz9665Z3WkOBScM3rNZqRFwcD8S
	 obAL5Wg42MzGZxEpU9oX1Q55C3dmJJZqFbYDM6jhv14jLVX20XPc2K3pff8qPtBIBkZoS
	 +pcvDl0fEZSsqZAo/lYYBN0kYo8Atk1xLfvWiCE/sxntOzVVNJygmZ4LLVZDKCh6bGJ5P
	 rg2AOL2kJ9+VEZ/agI19TDcKJzdVZvAeDr54BK3uliPoSFSJuxk/IbZ5cHgbLYx9F+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=j5VaDh9P9n7hzWitCUUpDLd90k1uRt9AaZrvm3y6m3o=;
	b=Dg8LxxWnNTr3jPXY6VI1k65HFiKHf8LAzQfDB4fTureGA73Ub7K9moRfb+0nJJ4Noagc
	 zfljVlhZWSjt6UrcJc1xMHs3L3dz8J7zq2F3gYBFogjW9N0Rt+GeMDxErVSnWgsmUF0NT
	 BwzodCrM1DGJQKPyJ4NbaGpGtjGgG3aFM+RzQCo5P+be1UXIKNL6akfrEWmVgcvbpvE7D
	 pLP4uSyYIpLp2l6IjZan7vu5Z4+Gv4jjb8aDI83FhnCr6wqIGpXItD6ORu0TXOqcQbv2K
	 wOMRDNknEz4TJBRZoqhqUeSi2ZrNgcxsIrwHZz1Z0xf5z7jk0ot2l7n0KIWQpmAbMWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="ZPj5/QFM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81A606A324;
	Sat, 28 Nov 2026 12:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE81A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZPj5/QFM
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9A01E205888;
	Sat, 28 Nov 2026 13:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j5VaDh9P9n7hzWitCUUpDLd90k1uRt9AaZrvm3y6m3o=;
	b=ZPj5/QFMOCWsxgtRCgK+7bUFVWtXTlUkbpsY1jbEIWJZrkH9LuM9MW/hJGOwwJB09ZIWcE
	15ESxOX1X9N0BFtRKpVJ0PDJ155VSuVzR84OJKqC0IDk7vbvqxdXX78C+Pybh+JqBBeRLi
	8TgzEkiDLMzVQH4g8zjKR1AeZOPvJhR3LMnU2twjnx/tLU28DvCmsQMScJ6fn2K63ZIuJe
	Ez+Kw/jaCGGv6JSNmvyVBVAsa4irHU3QfyAlapnhhay1VugHLBvvZjlyufeflOmKCDCF1P
	sZ+qUgsiXCJo7dJoEOkZWH5tHRFP+Ra0cSdQ5uuV1uhd1/yofvS2cRyC0eGc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j5VaDh9P9n7hzWitCUUpDLd90k1uRt9AaZrvm3y6m3o=;
	b=GyXLNpsvz5nQnH/PgZkp+0WR05gpW0JFljl9mlX+nI6Ff5GU02k3v+yUHnM/qhv0t/vCPA
	/HwPcrMHCruizSSUE1xGx9bTuXhIkRNxpvHc+RU5EOhtlkxk69FsTLHLQr6wnDTF/b4ukf
	UnrsR6sT1gSWDgOwWPP11Xi+dRiZJJbFp2Q+LzjNaBX+VVXCkcrVMrlXbZ8CUAk9A015px
	2AC/DNm+WSw2yfJnJyTneafKewk5pg2G2zG31WAOuObEWZrpDPZojsgZMOYvNRv1+rbJWS
	32sropzhNfcDko5fzgiBzQuwBwLEJbMDP9jettF3LmzqnR/KggIl2mog7wKIAA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795869644; a=rsa-sha256;
	cv=none;
	b=NzCM0AqBLr2HFdX4YbEi078qejDqZJokcqbZI1F1Quw31sIGSKW/R4vFahei8WxP/uYwek
	TBiWXATBGxgE46pPExIWSlomlZdioAlLLq60W+lonhyiRqjHUUcFs0h22wW/0I1fSpYva9
	HkIaSqe0X2Q7/d/jzyyxzx7o6nwV2XvI9z636buZ12zsMsrV8066KlJ4tFdn/jE7IByPFM
	zo8BATR8Ys2tQunr6/NEk3pE7k7IKTzH8JTeTAkb6A+WN3iZ0mvHkEvnx9JBFpZQu8wtIU
	XwXCVhDXZUkEeJQ5dumttoE3Jswwk/7h5FPjDbASTtsLjZI6dEfJ2h2FJxeJVQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 8D9F43802F3; Sat, 28 Nov 2026 13:40:44 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH can-next v6 0/9] selftests: can: add J1939 socket and
 transport tests
Date: Sat, 28 Nov 2026 13:40:41 +0100
Message-Id: <20261128-j1939-selftests-v6-0-a9dc9140dee6@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAMnLCmsC/x2MQQrCMBBFr1Jm7WASJTReRVxM04mN2FEyoRRK7
 27s8vH+fxsol8wKt26DwkvW/JEG/tRBnEiejHlsDM44b6254suGS0Dld6qsVdG6FHtvfOijgfb
 6Fk55PYp3iCQovFZ4NDOQMg6FJE7/4kgLz83WY3GeKQvs+w+Hy57fkQAAAA==
X-Change-ID: 20261104-j1939-selftests-12fc860698c0
To: Robin van der Gracht <robin@protonic.nl>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Felix Maurer <fmaurer@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>, 
 Chaosheng Qu <quchaosheng000406@163.com>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2

net/can/j1939 has had no in-tree selftests. This series adds a kselftest
suite for the J1939 socket layer and the TP/ETP transport, run on vcan.
All test programs except test_j1939_base use a CAN_RAW socket as an
independent on-the-wire peer. By default the wrapper scripts put the peer
on a second vcan, and the CAN gateway routes frames between the two.

The timer checks are relaxed by default, for slow CI machines;
J1939_STRICT_TIMING selects tight bounds.

The tests in this series do not cover every path of the stack. They
cover the main paths of the socket layer and the TP/ETP transport.

This series changes no kernel code. To keep it at a manageable size, it
deliberately leaves out tests that would run into known bugs in the stack.
Where the tests work around such a bug, the patches say so.

I used Claude Code (mainly Claude Opus 5.5) to write most of the test
code, the commit messages, the Q&As and the changelogs, and to review
them. I have read, edited and run all of it myself, on vcan under QEMU.

v1: https://lore.kernel.org/all/20261014154435.3577983-1-o.rempel@pengutronix.de/
v2: https://lore.kernel.org/all/20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de/
v3: https://lore.kernel.org/all/20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de/
v4: https://lore.kernel.org/all/20261118-j1939-selftests-v4-0-756768d32ff2@pengutronix.de/
v5: https://lore.kernel.org/all/20261120-j1939-selftests-v5-0-fdf4c242a37e@pengutronix.de/

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

 tools/testing/selftests/net/can/.gitignore         |   6 +
 tools/testing/selftests/net/can/Makefile           |  24 +-
 tools/testing/selftests/net/can/config             |   3 +
 tools/testing/selftests/net/can/j1939_gw.c         | 128 +++
 tools/testing/selftests/net/can/j1939_helpers.c    | 593 +++++++++++++
 tools/testing/selftests/net/can/j1939_helpers.h    | 329 +++++++
 tools/testing/selftests/net/can/j1939_lib.sh       | 171 ++++
 tools/testing/selftests/net/can/j1939_tests.h      |  99 +++
 tools/testing/selftests/net/can/test_j1939_addr.c  | 233 +++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 241 ++++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   7 +
 tools/testing/selftests/net/can/test_j1939_multi.c | 964 +++++++++++++++++++++
 .../testing/selftests/net/can/test_j1939_multi.sh  |   4 +
 tools/testing/selftests/net/can/test_j1939_opts.c  | 442 ++++++++++
 tools/testing/selftests/net/can/test_j1939_opts.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_wire.c  | 202 +++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 18 files changed, 3456 insertions(+), 2 deletions(-)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20261104-j1939-selftests-12fc860698c0

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

