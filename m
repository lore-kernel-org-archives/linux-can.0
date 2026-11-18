Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991357;
	b=DsOOoEZFcn0gelOCLGXZxuMrlJFr5/CD4sETp/w51dtLzFiy74z3Qa47aILozHLaxtPO
	 W7EPDd1cXlWw000s1Nd2Lyw9OBElxZxOFB4tCmdWHdwT/FFc+WrMf28vtWeRYFpDbRnPw
	 z2zJHmGu7hfg9s+goIENm44ZEOmFWMlu9X3ivoOL8k2aTVsw18r/of/YRWfN5j3KsQDmz
	 9ND2FYqMLLimmU7pd7KiWYuCOsoFAKS3Dr5ACmB/eVrRzN80mOj79HWgtBKGvQqpqeR2A
	 SFqCy3TidpE6w3UdFdoX9EUYdfv+EMTStLuS4/Y7+JVBhPupwz71/gB9nhGRk62ql3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Sh9SR2BxBwSxmOUCrBXmedDcxiL1wmjyl7NSL1nFZYA=;
	b=FrNvicc8U6qWiYl/vs6hvu04RXtuU/i85lprwNiAblZhMqTkbQZPNvFejo+O8kUiDxna
	 UAoJd2kRy7MVWTgKI3bxUPyX8FLoBBstxPSZHcGfFR80Tr9fiJATn8kDQ/O3w4UOPa1fj
	 LlSm/oMjHNQj4s/p1Ec6hbsYbbB2Az7rLaSG0a0TWtsNxURt9ZRyciyg5q6vkj4EYtTBA
	 TC3JF1Fxa9zDKHauOJf681T2Qm9xot5TJvEaYSRdUv8oPK0lvy+R42zxNAQwiFvpo2k2L
	 AV5TMczWLmJFdNO8n/eDwJRf/DlIim1jWXRfhxmr6CZkvtKTPKfWhnxmGR6kgmmHz9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Cj66wSFY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BD606A33D;
	Wed, 18 Nov 2026 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E9BD606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Cj66wSFY
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B8BF52001E8;
	Wed, 18 Nov 2026 09:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794991347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sh9SR2BxBwSxmOUCrBXmedDcxiL1wmjyl7NSL1nFZYA=;
	b=Cj66wSFY8B9/3+Waca4ZIpnRkZJTLsyCN07Umkl4zrZDCVDHIRux4rubRQJD4QUpQr7GhS
	GCbNK4fPOe86Uh0JSItnffO6Bt6Q4Qiq6/lbttC3DNodELf+1GsQYSNnAZp2y9Uhl7AFhk
	g9pf2wxcg05yTk0BLPUmyhTIcKMHQESViRYrKOpaphCUiNW8Ugu2N9ALaNnm9FFRKyZ06X
	9VgL7KLjSKgWfEZvBVRavtIcdOZQW275Woj+cyol1h+kQV2CgzhXn7AIEKc1pKFg+OJlau
	9AjlbOffy+dlJqvS6VRNyKWhvSCllZH6MNCxvISaDl/fSMpBcNGsCwubqScE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794991347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sh9SR2BxBwSxmOUCrBXmedDcxiL1wmjyl7NSL1nFZYA=;
	b=Wg+lASAyXNst22AOqHzKJz/PSH9m9cl5oO7Fjb8woOoCcqwZyXeSJR28NHzcRsGpuhzuHc
	7+FZIT/GY5tO9G7N+KrLyWT/ZUD/2EY5ZxwB9OgvbCuDRT21dpsT4RzX85enI/USFiom/d
	T0aDHKh5d5yQj6hKzJ8F8InTFX3CZAH45eiA19u0cR/V1edy/806xDI+LLAHvFM/G8uGIi
	nVjUDjcUdgd9TkGIVEjr6JjWjHJgRilHFI2XHr95MnjS8aqs//DwnZrzkzbkjaMhNVYwcr
	GMXB4QfGcqVk3XogQ+brrEAhUpn7WhQGU724D5VTFSplx6wn0VfYeBreEgsg0g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794991347; a=rsa-sha256;
	cv=none;
	b=c3pdc5gOWvilJcqt/3sqAOCHY9T96G06Aj3DkYBfkGKsrSGpYY9rHS31sJ1b8d9UJVHHr3
	nVtkhsr8z41Gx+P/KWDk2S7PHgOcvErq6f3y71UiXkl5AG46jVldgQGvEd1vVfULqdsecp
	Dm2iACdxLv9HKWua//ZLvHMr9oGbkDDsOktRWmMs0deui3XbIPiXu7db8OM3XUSX0vujru
	Zu1RBGoeiA+kFQxId/ysdCFcLj6dZHHiukU+jJ/F4C1s0iWTy/6dDMfM7kwJEwqeq55CAq
	L4p/KTlrb/yRHOnlCqKwp3F6ezTZAjrd/E31p1ap3uutTuQXteof2uAXxaK36A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id ACCCC380239; Wed, 18 Nov 2026 09:42:27 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH can-next v4 0/9] selftests: can: add J1939 socket and
 transport tests
Date: Wed, 18 Nov 2026 09:42:15 +0100
Message-Id: <20261118-j1939-selftests-v4-0-756768d32ff2@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAOdk/WoC/x2MQQqDMBBFryKz7tAklaC9SnExxklNqdOSCSKId
 2/q8vH+fzso58QK92aHzGvS9JEK7aWBMJM8GdNUGZxx3lrT4sv2tx6V37GwFkXrYui88X0XDNT
 XN3NM21l8QCBB4a3AUM1IyjhmkjD/ixOtvFRbzsV1oSRwHD9WNArdkQAAAA==
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
cover the main paths of the socket layer, address claiming and the
TP/ETP transport.

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
 tools/testing/selftests/net/can/j1939_helpers.c    | 550 ++++++++++++
 tools/testing/selftests/net/can/j1939_helpers.h    | 391 +++++++++
 tools/testing/selftests/net/can/j1939_lib.sh       | 141 +++
 tools/testing/selftests/net/can/j1939_tests.h      |  99 +++
 tools/testing/selftests/net/can/test_j1939_addr.c  | 737 ++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 239 ++++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   7 +
 tools/testing/selftests/net/can/test_j1939_multi.c | 947 +++++++++++++++++++++
 .../testing/selftests/net/can/test_j1939_multi.sh  |   4 +
 tools/testing/selftests/net/can/test_j1939_opts.c  | 440 ++++++++++
 tools/testing/selftests/net/can/test_j1939_opts.sh |   4 +
 tools/testing/selftests/net/can/test_j1939_wire.c  | 190 +++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 18 files changed, 3912 insertions(+), 2 deletions(-)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20261104-j1939-selftests-12fc860698c0

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

