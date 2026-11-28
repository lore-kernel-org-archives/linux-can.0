Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795869655;
	b=DfbVd9i5uA/LKolRkr0rUmMYOCroIS5WZRyMci62NBqZgYtdIN5o5SheYD+uZf8gM3Yn
	 97fWqDR0rE7fiY7qQUBzWF6lKv0sTTBZ9UnXp4J06FagFmDp1/fZaOhZijG/6HEXiqEl/
	 lhfnLWnuVj1Zt0oQ/KYLf6XY1P7bIAGlD2uFn2JvMtw/saLku96oOnOVMAWC3si8IjBiE
	 oX1WzoVl2cMJar47yNl2RADscBOKPzI0e6vyoI5ap/bn8DBQYmlN4Jdmk7iqTixOCtMkD
	 C/bFeoe7eQxi4rGW1i6FwPbAKfe+gqrVDIPvDakbDIp7QqDwFWoJIabZnRynGzojJBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=XY+wzVvH7Fne4jmypgPl0pE3UzUCqx1l2JqkP8JXvAs=;
	b=o6P/vTYUQrVVD1I6pZgHZmMoiG7amB1NT/hbvKTtFmTuTwqcF5Z5PwtT+/13LTDnHEE1
	 mTb8dRLmevvF8pXzUx6hNe2PQsdCID/HUPAXZN9ym5Tb1qZYkLsrMmNujh9yopzsWVKK6
	 4E/QHIqUVhpM6lftYOI27cMoxHM4n86CF02Zs0Vi9JxtsaOK9PTs3wg11+74mTKUYyjZG
	 ZMSz5kyheFn5g31zWOPg/NiotiG+0VdRrS7kETWVFnAicqv/tjSM7wqMLbie+qOUvosHI
	 Gu0m21hc5JS6MY+LZUm6N3YROtyYTrvT/onf6IpU4ulctnfItPQLlQa/a6lMLrBu8SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WnpRY+3m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65A606A31F;
	Sat, 28 Nov 2026 12:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE65A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WnpRY+3m
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9ED15205A26;
	Sat, 28 Nov 2026 13:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XY+wzVvH7Fne4jmypgPl0pE3UzUCqx1l2JqkP8JXvAs=;
	b=WnpRY+3mfJNbuJm/4AWw3gH0YY9ieKBqVy+Rq0c/0RsOtDldPaD/f89CBWjEjJBWlfO8mZ
	tHVHxjweaZm1WHSHTYFMc/g9gWsyJpHxrxAj4ghODuVG0WHmBQc9kKE8LllcGE9xeUUNRZ
	jblIgxULUnoTRHJU8+3iegn3sVZL8tMh8EufVVFwn/TDJmVPKotvcPuHe1If9OlB3HEpbl
	aP3M0RL893UcstTPjNSOzDBMr4QzgTOsmWJzgNROZUBo0o5TpCzG2GtqTNsltVEgD+fpAJ
	QLYlzulmSg9QTELVxTGz9mKXUYziC5LhXOqK4fYOSoEv+wLWhb1zDFEq8xk+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XY+wzVvH7Fne4jmypgPl0pE3UzUCqx1l2JqkP8JXvAs=;
	b=BjDTM/sOJILZzG2LzeJU9tgxICj69vV5m9dLXciRuq5Rpp5MKcn3snJEBxXLEUHgsozbAA
	eyvTEbK6Y71g5fMWycwd4BYlrYKDvql8rRmcL/O8D6dVVs+tz0OIOBvtmSo2Vz2mGxgBhk
	Iu2i0MpnYjfY0zVy4xkHRx7bYZBcesCLH0jeJxupl/bzgH1m2U27perHGHr8puDtNUGf1H
	cJ1toVg6oYL3FpTTzqCnUpE7rFzti+meqsHAK0YKtiJdQZTnKRIpSGD2HYFiWGcFWkhWzz
	k7o+/L/5fC03VsnYT2amXUs2J97AvW3f6SGX1pJBfO0cEK+CqjFAOLJssuULug==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795869644; a=rsa-sha256;
	cv=none;
	b=NtOviaOgymgcO2eKOHgR1H7Bw3ZfFevyh8huuE3uUrd1cBkptDTovsqgyBxo4TCAGktWp3
	XMT41Yfqxm8Epti2+wgHAxGeca/l+pP+E6e1zE9PsexcdTys8aOCfYgdQGxHl7D9ttG/z3
	+QVCrULrom4KUk+mAaBAc0PaHOEvJT+eZwxlm7r9A+K4yN0YQGLCUK5x4W9IN8J2mw22as
	A8CWMmdNt3CAVuu6Sy+M68E5eS8/qJgpGg1f23EAiDRV2B8LMIovQFHLK6gOR9uKV38cZG
	64oW5K1R9LlK9jZnX+e5n+wRy/q3SudyUvQQfurWGqt/tSVUTqoBkO4zRNYUZw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 8FA133801B2; Sat, 28 Nov 2026 13:40:44 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Sat, 28 Nov 2026 13:40:42 +0100
Subject: [PATCH can-next v6 1/9] selftests: can: install net/lib.sh with
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
Message-Id: <20261128-j1939-selftests-v6-1-a9dc9140dee6@pengutronix.de>
References: <20261128-j1939-selftests-v6-0-a9dc9140dee6@pengutronix.de>
In-Reply-To: <20261128-j1939-selftests-v6-0-a9dc9140dee6@pengutronix.de>
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
Q: why is this fix part of a can-next series?
A: j1939_lib.sh, added later in this series, sources ../lib.sh as
well, so the J1939 tests need this install too.

Changes in v6:
- No changes.

Changes in v5:
- No changes.

Changes in v4:
- No changes.

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

