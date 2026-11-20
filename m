Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167970;
	b=reVaeYRgeWLKE9u4jnU7036ZWmUBxreEXmt0tOJKGLFZRoF7bI2px8RhEAkq7C30yLZt
	 GyLCExE/io8kLGt58jSILO7OAG9lJAwnYswaoDDzex/u0s9WPgq45YLdRbr4gNNgrdXm3
	 Bqbt0TafkQraYdcM3fzlgvAib7esY+4EdKKORQH5bW6izaltFLndcJBcoGLX2BZy3eXpZ
	 ByhYvKVjhnaDEN6LuyI9qJEY474n23fSRQH8PNSW+UiJiNN7ZdX8IuJ6Z/IBCCfhIATAZ
	 mKpBTDoPA+6ZAgKzceL8q+zFoZBOfPM1PrHO/PjcAu2Swnve3ZAynd5ZjpSezwT5LZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167970;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=n8cYlIoPdgk7lSFrikMoQgIQNAw38iBL5/lgCIRYjyY=;
	b=fn7n7TIrPVfOzOsssjM6Qk6Ed6eWLYH0H4cYEBtwQSUjU90QfJ7lLFnyw+OCxspWT/PW
	 6YYTjVoffUmi4SmYat/HyvIoPsZYqmc4jvA/j+FmBpDtcdk1vGX20D8be8fBMSv3btoLQ
	 KpAwBByVAOT1r4jn4EZllVgpq0+nTzqctluBIhNZVa/AdouCKe6HA5qf/9H4MyrOJA2Vh
	 x2dQoOEUunqLCzyx1pp1pgSUchIZJ0UJW1LO/U2FKe/F4/GioS1b8jIdzGVtJ480hXVqa
	 M2KrWnmuONDexzMkNPvyVMPCGt85gfNpw/AsDFhaf1utUM6tXe5sKjOjCOiSO9DntYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Q52hMkPH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C82606A320;
	Fri, 20 Nov 2026 09:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C82606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Q52hMkPH
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 50295202052;
	Fri, 20 Nov 2026 10:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n8cYlIoPdgk7lSFrikMoQgIQNAw38iBL5/lgCIRYjyY=;
	b=Q52hMkPHUktwll5g02ruU/JVANQnFoamefc2mpU2Ot/iDGsuY/2p1rJ2VtxcdWtNFenNQ6
	iB2OdMkzlqcaoi9PEdKsMZ/BEYqdHDySA8ZP7PPtT86/jhullPaynzvhLwsQtj0dLaeZ3y
	/ULhmj1ZhRmoNEH37oGmeevD4VBFIeNeQqJ9HfrSWK0CdPGanRzU00g/N0g5bK3tc9frvt
	afwww9YzbrUbiIjtUsstb99R3r4Xm812gE9ZAW7zDTa9dv668E5NQNDY04X1lQqkhQjdoQ
	UMkCFtes5c71ahPunQ67rQD3LOIxlTpiFn3nvYIIgrtLOSIfvlj5z3ADEDIGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n8cYlIoPdgk7lSFrikMoQgIQNAw38iBL5/lgCIRYjyY=;
	b=UN4h6JRrpZ0DLRp09ofqmsD4V+5R/aIBgqtHLqQj5qpJ4BFL6+W7a0yB9FvbyKqEASrfUX
	NcY2jmGz+osKsL1MORUt7APOwwWVW4t0H0Fnkm1C3PH856T1cSeZLfYPztrqHNkqErprJN
	pky57HrjCpLUiqr0NARuj6UmfHkyKc9FuuqmUp8fOlKzib2zNuw4izcMbGs4H7b6toTRH3
	huQUg6bH/jlpG325wrGhBpMJ0SrS6UWc95S8LXXAI+Vr0vAipeJtfU9djQkQey6q/LJidL
	lM5+3IDUrtJLAoAafbhYI8GvAyXPuVyFbEofKphLp6tZN51WPORgaxvJmqaYEA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795167962; a=rsa-sha256;
	cv=none;
	b=hC9mFwS6mDXnXQrjnPw8N/S0+Oo3B2f/atx8nBzlXDSOCtsrW3Cng5w5mGZHH3RRW9NvnT
	WU8fH4Lia84bhskQ5nn5BcB2IfCWxnvhznCiJuSY1OkyoxkR6Z9wXd6jGwtRFDMIbYEc1J
	R5i01usL9Mb8cw1xUU0pn7V7RQ3VBNjG7xWqjpRMA8sAT3uWylF4/XG20wk2/XuY1jK2gP
	7q7ikfTJ996Ov5a51du7xx55taYwqwnLgYfF88S4cHzAaRxBqRwLPT5UTa7GKWlCHgyKWw
	FSMfC57rEeqBt59lr8JOw8FBJ8435JXnCOrVZbanC6CC/ezuGI4ESF0+HYubbw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 44B0C380C84; Fri, 20 Nov 2026 10:46:02 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH can-next v5 0/9] selftests: can: add J1939 socket and
 transport tests
Date: Fri, 20 Nov 2026 10:45:55 +0100
Message-Id: <20261120-j1939-selftests-v5-0-fdf4c242a37e@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIANMWAGsC/x2MQQ6CMBBFr0Jm7cS2agNexbgYylRqZCSdhpAQ7
 m5l+fL+fxso58QK92aDzEvS9JUKt1MDYSR5MaahMjjjvLXmim/bXTpU/sTCWhSti6H1xndtMFB
 fc+aY1qP4gECCwmuBZzU9KWOfScL4Lw608FRtORbniZLAvv8Ansj4MZEAAAA=
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
Where the tests work around such a bug, the patches say so. Tests for
these bugs belong with their fixes.

I used Claude Code (mainly Claude Opus 5.5) to write most of the test
code, the commit messages, the Q&As and the changelogs, and to review
them. I have read, edited and run all of it myself, on vcan under QEMU.

v1: https://lore.kernel.org/all/20261014154435.3577983-1-o.rempel@pengutronix.de/
v2: https://lore.kernel.org/all/20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de/
v3: https://lore.kernel.org/all/20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de/
v4: https://lore.kernel.org/all/20261118-j1939-selftests-v4-0-756768d32ff2@pengutronix.de/

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
 tools/testing/selftests/net/can/Makefile           |  23 +-
 tools/testing/selftests/net/can/config             |   3 +
 tools/testing/selftests/net/can/j1939_gw.c         | 125 +++
 tools/testing/selftests/net/can/j1939_helpers.c    | 542 ++++++++++++
 tools/testing/selftests/net/can/j1939_helpers.h    | 388 +++++++++
 tools/testing/selftests/net/can/j1939_lib.sh       | 152 ++++
 tools/testing/selftests/net/can/j1939_tests.h      |  99 +++
 tools/testing/selftests/net/can/test_j1939_addr.c  | 222 +++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 239 ++++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   7 +
 tools/testing/selftests/net/can/test_j1939_multi.c | 947 +++++++++++++++++++++
 .../testing/selftests/net/can/test_j1939_multi.sh  |   4 +
 tools/testing/selftests/net/can/test_j1939_opts.c  | 440 ++++++++++
 tools/testing/selftests/net/can/test_j1939_opts.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_wire.c  | 190 +++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 18 files changed, 3397 insertions(+), 2 deletions(-)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20261104-j1939-selftests-12fc860698c0

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

