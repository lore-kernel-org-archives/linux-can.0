Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410779;
	b=I6MSuewKOm9wZrf4jFwULcm0I5yxwy12cf4NBlJuDA59Q/eJGI/vC2UgIVyQ9LbBW1He
	 1DLxmobmHn/hldG03kPIquqoposhSijLl/MbqGnC5ednnhmzejIXigDbHFHDBrdUcr/zr
	 8i46RxLNI+ySAPORoE/odQcVgeyZnrYZ4PkOVvUe9xSwBqj0IOX8qIuh5kJufx/NbAy5M
	 AQEHok+N1abDfzr4sLh6l6cZYGY5VKpmzgp+jqDveR4XC676ZVA0Tg8gxXMCpVNtKvJ8Y
	 97pPmGcx/aieVihHyzG5qk38tyB27rrGEEfsYDkao9FPM903kCWBzvWZzJwYozMwNQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410779;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=FgqKrUQegjyMdS6hczol3PkFr3FN1vQ0ioUtLWKimwk=;
	b=AfeG9C/fKUbR9YoU8gT29TD9XuEvzvxxd9LZDJIAoDsZVx87LfrzylsgDqfa4qeOmwn5
	 BynSOdLiEfuz424v3q1kLSuHggpiUnFOfqQR33uDtbCTXm8xNQDeaaYbcVBi7OqT26fxY
	 RObhSrxYbAcudX8ns2UfNPoCbZE1jba0tTMu67YvxygMsB0ZWG1vjdVAl8I5VhwbmVFRV
	 8VNGpmxi2I/0tDXUFr+OKt4uuHzBYMGN0NmeLuzbLMi1FiuMmuMwQUrY6eeSLEBNjB8kG
	 k9y6iYXxbYNjQf+ZalejU181GO9OeoDMVaVEfGf+Csph5PArd6a5CkJS5rjTmGj/wdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aJUlSBIX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DED606A333;
	Wed, 11 Nov 2026 15:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3DED606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aJUlSBIX
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B726A2000EB;
	Wed, 11 Nov 2026 16:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FgqKrUQegjyMdS6hczol3PkFr3FN1vQ0ioUtLWKimwk=;
	b=aJUlSBIXxj/r5ZbpUuSVVwXUhF5NGn3XghOMov7uyTtrlgRGnhLr1fIJbNqsSEmt7Rd5pe
	2iIb/h5mc6mnEb7EA7stJh6ivy4nAWZdub1FIm1XXE2g5l3Ouuen9GfcZXr46fgN0r+avT
	OAq9tLXPbaa4DkOEYxycWIe0UgHlHx7L/z8T1KUk0rGqFw3PMjtTKRyqvrxr+cxRDf20bx
	VNG08YZK4aDku3kQXlOe1MuNDVK1WazhARhVd1Ym0/wo1ZUFUG8271aC2rtTxmQxUT1Q33
	VdXtvomfUvil/1/N5wpkvUpfoVYOYjNSNJKZQ8ycYaZ13U/6GHIddvZiwz/nFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FgqKrUQegjyMdS6hczol3PkFr3FN1vQ0ioUtLWKimwk=;
	b=M/cNSnraf5vgYLiI1VKcfLSxa1QeDIN7wcqHcfDlM2gcZ48SOApYkIpaBRLe9GGlHcaAlm
	lQsuzPV5eFQYgJmoVrK/i8AGhYzoRaCL6I476DdBPKjmv1kRe9U9ouNQ/LeSiQ0xUU7ePD
	ibY8wi8Fj9tpbItIJ2SFj9+pjEXEJTgv5ktsWly2H/WYcv6c1OHjZMujSUpf9m6+zJhfbj
	XrmAY53xeNqjpaArhCwaZEry7kHVM/Prpr1rJPJZArVfdkPvHLNE+CoQKh3kxLtDIEFTRw
	n5nlyUFqTPZ0gpu7dMQ7fPpbY/vcxtkoP2fDoXKJsUhpwSy3RobqrxkNu48nQQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794410771; a=rsa-sha256;
	cv=none;
	b=DfUsSI/BnYxBnLBnwDppYzy83MtB86ZkVO88H2af7NeJhm/xULA++5MNzhzrNIZuolLuU6
	jZTJ1ZAhMCVbM4znddGXznhNsxC44MJR0BwXW6zTWjBi1dojnReag1/9vxskYbrP7RaiQI
	XOA8rLTxbhXt3AY3aQ/Jci85vdgepkUwLlzV3bCBWT+uvig7fcf6X/5EoTPWi9euhEIM7R
	Nm9AydU8MpIZEtFGBMXLKYpH7QehCGo7IfFqH30KiPu8ELbMW2TsaPERlIbHAxpqa6GfSN
	dOxNY7ovoyiA9TQQiupVURWD23+7NmT6fByiiZefPsQhSEoY3jwkiL48tgBZ5A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id AAF71380329; Wed, 11 Nov 2026 16:26:11 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH can-next v3 0/9] selftests: can: add J1939 socket and
 transport tests
Date: Wed, 11 Nov 2026 16:25:49 +0100
Message-Id: <20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAP2I9GoC/x2MQQqDMBBFryKz7tAklqC9SnExxklNqdOSCSKId
 2/q8vH+fzso58QK92aHzGvS9JEK7aWBMJM8GdNUGZxx3lpzw5ft2x6V37GwFkXrYui88X0XDNT
 XN3NM21l8QCBB4a3AUM1IyjhmkjD/ixOtvFRbzsV1oSRwHD/tyEU2kQAAAA==
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
and timeout paths.

This series changes no kernel code. Known bugs in the stack affect these
tests or limit what they can cover. The fixes belong in the stack and are
not part of this series:
- The stack updates a session from the loopback echo of its own CTS, RTS
  and DT frames, and a CAN_RAW peer can see that echo before the stack
  does. A peer frame that follows quickly can then cancel the session and
  fail a TP or ETP test (patches 7 and 8). I have not seen this in QEMU
  runs.
- If the last J1939 socket closes while an address-claim timer is still
  pending, the kernel keeps a reference to the interface, and deleting it
  hangs (patch 5). The tests keep a socket open until the timer has run.
- On success, setsockopt() for SO_J1939_PROMISC and SO_J1939_ERRQUEUE
  returns the value passed in instead of 0. The tests accept any value
  >= 0 (patches 4 and 9).
- The stack ignores a Connection Abort received on a kernel TX session,
  so no test covers it.
- An ETP CTS can ask for more packets than remain in the message. The
  stack lowers the count to what remains. It does not abort with reason
  15 (ECTS requested packets exceeds message size), so no test can reach
  that abort.

I used Claude Code (mainly Claude Opus 5.5) to write most of the test
code, the commit messages, the Q&As and the changelogs, and to review
them. I have read, edited and run all of it myself, on vcan under QEMU.

v1: https://lore.kernel.org/all/20261014154435.3577983-1-o.rempel@pengutronix.de/
v2: https://lore.kernel.org/all/20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de/

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
 tools/testing/selftests/net/can/Makefile           |  21 +-
 tools/testing/selftests/net/can/config             |   2 +
 tools/testing/selftests/net/can/j1939_helpers.c    | 524 ++++++++++++
 tools/testing/selftests/net/can/j1939_helpers.h    | 374 ++++++++
 tools/testing/selftests/net/can/j1939_lib.sh       |  92 ++
 tools/testing/selftests/net/can/j1939_tests.h      |  71 ++
 tools/testing/selftests/net/can/test_j1939_addr.c  | 736 ++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 236 +++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_multi.c | 950 +++++++++++++++++++++
 .../testing/selftests/net/can/test_j1939_multi.sh  |   4 +
 tools/testing/selftests/net/can/test_j1939_opts.c  | 434 ++++++++++
 tools/testing/selftests/net/can/test_j1939_opts.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_wire.c  | 196 +++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 17 files changed, 3659 insertions(+), 2 deletions(-)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20261104-j1939-selftests-12fc860698c0

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

