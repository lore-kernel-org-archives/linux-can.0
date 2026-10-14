Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BF55C332;
	Wed, 14 Oct 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992682; cv=pass; b=tUaMKGsc/CI2Xk1P5iLyc5XU77gazWjmod1bOOtqMGUZldc1dsoc6wvZBuhkuEAIF3S8zNJGBN05Nm9LZ96iZKb2LA1MxrddbDg8cItic1EjBBpaqC5O4mUSZguiBRwaib7RzHZTwXm5+ory+tARwtIjDHAbW4C4zNPCqU7/dQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992682; c=relaxed/simple;
	bh=//6/Yppifp2lpbUNKplhyz67WHLAKWi+fnh2ND58wJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2My9cfCvKGObsuOuMYaDA83VEzL3jx1gqetCre4G6d0qZ1BQTuklsodcEL5lwwI1eFSlwleFnxLWW7Sa06YnGYLQAN3h65/sdjwfthJ8Z7R2LiDvNod//fbzv2H20e+TEjCRtqzv3EdFoizITkjuJFqwBWvJP0LGkbUHvAGCQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DUqOZ+Ma; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DUqOZ+Ma"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0CA1A2004FC;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ykxcgn7EkB9Mckt1qKuKY8PIkRTTdUuMMlIkNr4F5A=;
	b=DUqOZ+Ma/SCj1XB1Vbl6CJKnkZ1JaQ1BwgSGNjgVoiMgQlzDhZQ2yXqc3Nv/jCy9DcpMp1
	hQe/buikxlCwIPu/ucusaj4FsX894N/hxc2s9KOdiQ7ejXCf+EjKQROc6FGh7QqkYImWgo
	0SVxrLJ3zf0xX8gVTarCtzwT5GeV7FcqSH6dTMY/c67HojHSRUvzetk7ngDd2yZOJ+x5vQ
	lcMykTkggQ3QVwInQKzXvHHT2wsVPTESA7FdhTWKNBsIMmqhvHxKI+nTBG9KBemDOOMHRq
	Re0n3MooR7z9gDlVO4izbqUsqnN0HWLFlnT+hsF8FvhSi3FJyaUuKhfnwzvpuQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=Xe/ecYgeZJUlRjt1z42Vzmtfw42QcIb+vgoxx4oh/sVJKi9eG0idi/UJjTWO1VOn/s7IdY
	zMZCuzQXcJ2ujtPKV5NvjIBp0U+LRRfgiWFU+rJ9E+8xFwN98+fjCznMo3T2nN4nAjPI44
	gpM9qHMMT0Mcflj10u8OQlVQUCg9i20uwoBHDqTg8vIrcw/PiiRyFRPKWk3Lyo+Ivj9Vn2
	c0NTP/YD0aIlREqJiEPQ+c+NyWUxWqftJ0pv+GjgnKAvF0f2UGBkOcLn06Soxlda1mW/wj
	aFZOdVAU/2fCJ3ytXaTX+r8pSUabWUBm6sM0wU16DuBXCj75ILI1RCPPRAxdIw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ykxcgn7EkB9Mckt1qKuKY8PIkRTTdUuMMlIkNr4F5A=;
	b=RAixPj5scwEfR2Dq/Z0ZCaEDqJkPgcz2n34m/fgWlBxncbhKnlCBogDwhHih5kSeDcGAka
	XN2yH/5tPy2RoouQbdjJu17XWWN0iidVyHQuXaw6yoMXd8xeksIBQrWfRSAsNYwQ9g73y1
	AT5xh7V40Yjd+pZAXWjZ0RRUycOkq8UzJOwNgkbU3VV3C87WuAME4j6eKNJ56/HaGhDR6c
	GQvU4YAyuzdghNcue+MOpfZCqUeICEaCC9zlXTorbUZH2ciwH87zY0NpE0pCv4dWdlE3fF
	t8g/24LlaIcSx7Pog99gzmZ9uctztDY+ry3DfKoPcNTFqZ9MjhwSGxRxC5wStQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id F4186380BA7; Wed, 14 Oct 2026 17:44:36 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Quchaosheng <quchaosheng000406@163.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH can-next v1 0/8] selftests: can: add J1939 socket and transport tests
Date: Wed, 14 Oct 2026 17:44:26 +0200
Message-ID: <20261014154435.3577983-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net/can/j1939 has had no in-tree selftests. This series adds a kselftest
suite for the J1939 socket layer and the TP/ETP transport, run on vcan with
a CAN_RAW socket as an independent on-the-wire peer.

The whole suite runs on vcan under QEMU and passes. Two limits span the
series and are left for follow-up: the transport timers are checked only
with wide windows, not tight bounds, and the ETP abort/timeout edge cases
are not covered yet (the abort/timeout tests are TP only).

Oleksij Rempel (8):
  selftests: can: add J1939 test helper header and library
  selftests: can: add J1939 base functional tests
  selftests: can: add J1939 socket option and metadata tests
  selftests: can: add J1939 addressing and concurrency tests
  selftests: can: add J1939 wire-format tests against CAN_RAW
  selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW
  selftests: can: cover J1939 transport abort and timeout paths
  selftests: can: check SO_J1939_PROMISC receive effect

 tools/testing/selftests/net/can/.gitignore    |   5 +
 tools/testing/selftests/net/can/Makefile      |  20 +-
 tools/testing/selftests/net/can/config        |   2 +
 tools/testing/selftests/net/can/j1939_lib.sh  |  74 ++
 tools/testing/selftests/net/can/j1939_tests.h | 460 +++++++++++++
 .../selftests/net/can/test_j1939_addr.c       | 336 +++++++++
 .../selftests/net/can/test_j1939_addr.sh      |   5 +
 .../selftests/net/can/test_j1939_base.c       | 160 +++++
 .../selftests/net/can/test_j1939_base.sh      |   5 +
 .../selftests/net/can/test_j1939_multi.c      | 638 ++++++++++++++++++
 .../selftests/net/can/test_j1939_multi.sh     |   5 +
 .../selftests/net/can/test_j1939_opts.c       | 347 ++++++++++
 .../selftests/net/can/test_j1939_opts.sh      |   5 +
 .../selftests/net/can/test_j1939_wire.c       | 170 +++++
 .../selftests/net/can/test_j1939_wire.sh      |   5 +
 15 files changed, 2235 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/j1939_lib.sh
 create mode 100644 tools/testing/selftests/net/can/j1939_tests.h
 create mode 100644 tools/testing/selftests/net/can/test_j1939_addr.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_addr.sh
 create mode 100644 tools/testing/selftests/net/can/test_j1939_base.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_base.sh
 create mode 100644 tools/testing/selftests/net/can/test_j1939_multi.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_multi.sh
 create mode 100644 tools/testing/selftests/net/can/test_j1939_opts.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_opts.sh
 create mode 100644 tools/testing/selftests/net/can/test_j1939_wire.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_wire.sh

--
2.47.3

