Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410779;
	b=YBGnHErCqDo5gPb10y+dmrz/4zEpUl4Qy3EMR8VZElHHSj+DdEgmLrmyVeVbaJP4mTLi
	 35Et4WI5o6dinzO6l8/AxlsoI2cgSzXOPwSDfpv3iyjdHfHTu6Jr8lkglDyVV9O4Vkqd7
	 em3kVpzVb3QcEg4Kpv5Zpg0Hfbt2+OT+OcPS1cMii1gQokLTfSkAXN+y8vrufA+4AQX6L
	 pyWpJnMKYZR8R6H3xHWglRZ9qryEAclNfyrwGIkEqGU39/JGgv2VZ3QQBmXfj9ZPrXnjt
	 8eqW/y+kl2qFc+2GpcMYgRWgs+KiITTQy7o2sVazTIZ3geQJCIUOuQtO1ej6GBAbfFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410779;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=SnJpdhRB9zwE6vJL5W5xknUaiZpDav8g7lJnOsI8TKE=;
	b=zcdzpX9qW4b59B0RDG9ZXCKmBkr8geLM2MC/HCTMvB5r82PHjAw0qYSpUJc0JBlpDb7k
	 oMpyHGgWKQM7m40uCM45wzJelX+v9bb5wZGp3waD7RcVdw5fWAjBCkUJwiqsYZ22ZZuGT
	 WOtaQMNL+XcwRBZOO1AOHi+fLHcq3Xqd4dV6LGO6f4IdrsQ3o+gCD34sZEO/Z7oXu0tjr
	 KUe0a67tymGMTWjwsBBe1gAUHQD+sWSvjWzc9x5KuzJEZ9tlPHhTNmq2t8FiGGUAHN8Wv
	 BW9gF5fQJBgNEp5Nd5WHPSlaoVRbGAFU2PQxw29Ae7H3mlo1LUQsFixTqaRuA/HLsTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EAgsxtqP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E08606A336;
	Wed, 11 Nov 2026 15:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E08606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EAgsxtqP
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C48142006B6;
	Wed, 11 Nov 2026 16:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnJpdhRB9zwE6vJL5W5xknUaiZpDav8g7lJnOsI8TKE=;
	b=EAgsxtqPS525sZusjV3Cd8Frqr9EjSFRwKk7PWjOpX8KOdcJU4e6jXWpClbg3Sk4zdEgZw
	Lq2Bhc0ikErDROwQhoY2Y7pt3E2Mh/GgwBNjftY9JruqPO31LmfmlqFX+C4Jo1UISV5Tsr
	caosq4FJpgEREtnVF2+Q5QH1TcUYmSy+RTjem41q++fRCqUo5DlpuVnMDfEsIyT2f1RBDM
	mUwYC3uLCCUeaoMoelW7r+bR6xin5oeuUtg8SYffmySRaOB2J6/KjSqRUbTmHqh2M4dWxb
	aVXmbBSkb/ryNsCMSrYbAKAfwvNQmXvbkmYq/ZXNXfBzPg0T0AIr40gw+6B9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnJpdhRB9zwE6vJL5W5xknUaiZpDav8g7lJnOsI8TKE=;
	b=BK3EH3/AiA1d/SeoaVsIFN0W4cDdiehUy+dF8OxyJNU2SOdco7um+/x2lZfWnqPbDdZQ2p
	Akx4SWr8H/7DdoflNQAJj7h3YdsEOji0GNvit8EM7gLyrt4beLDIWmYFyvz/1bMLmBGz0a
	V7H3oRVMft7b9UayU4mwi2dXx2PpIcvAAbgvagTQw3giuxx/cmtkR6N4gweZouH7atdHXG
	qXR2tIgs9X6pe5XBMXGI9rKPQmDeqHjY4byNkTu143Ew8WNCTtIXXNQD/1J8fyiNp4y3gJ
	RwoYE+YaOSrn62as8cNoK09Ce5RtFURw8d3oIBixjQ4in+OTnzWnoT/hz6rlVA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794410771; a=rsa-sha256;
	cv=none;
	b=YQeMxkpyU1TyoJupNTftR5r148TIWI5SAu/xY5gs5v8iwFOHJu81LRpiyWkQZSMbXjULWr
	BslLwe+yM0REcWD19AvUQFQhyCm5j0JQotOmdzIMkXOQIR7KjjXOFm6zSK8h3hvbNmbwaJ
	xgMaQ0hhQ4D11qfO5KTYtl0UMnH9ZayoSQ5SomJimjXREx8Fsfki/YxU908Vz8QxCtV4G9
	EMrO3Moo5Nz1hcYTsb6Ik5DIpLYni+T0DM19PSL9b79nRqVt7Z0AVNFqStkLeyxbKrLeoV
	zjg/zBIA4kXMqjpLpzd29LJ/XqsCwYE3evC4ZrqWip2DrSoIzhJA4LwG/p/ZUA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id ACFB4380133; Wed, 11 Nov 2026 16:26:11 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 11 Nov 2026 16:25:50 +0100
Subject: [PATCH can-next v3 1/9] selftests: can: install net/lib.sh with
 the CAN tests
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
Message-Id: <20261111-j1939-selftests-v3-1-5a80277ab363@pengutronix.de>
References: <20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de>
In-Reply-To: <20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de>
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

Add ../lib.sh and ../lib/sh/*.sh to TEST_INCLUDES. net/lib.sh sources
lib/sh/defer.sh. The install needs lib.sh and the lib/sh scripts.

test_raw_filter.sh sources ../lib.sh, but the Makefile does not install
lib.sh. A full selftest install works, because the net tests install
lib.sh. An install of only net/can does not work. The installed
test_raw_filter.sh cannot find lib.sh.

Found by installing the tests with "make TARGETS=net/can install". With
this change the installed test_raw_filter.sh runs.

Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v3:
- No changes.

Changes in v2:
- New in v2. An install of net/can on its own left out net/lib.sh
  (sashiko).
---
 tools/testing/selftests/net/can/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 5b82e60a03e75ace2cae949ceeab09a497c96074..3adaa13dcbfa303c4be2bb6a9b5dbdac76d68260 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -6,6 +6,8 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 
 TEST_PROGS := test_raw_filter.sh
 
+TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
+
 TEST_GEN_FILES := test_raw_filter
 
 include ../../lib.mk

-- 
2.47.3

