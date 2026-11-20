Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167970;
	b=boSTvaBgiY9kr5VCZ/lgE8v7fsNP8rNupndmUABH6MV4rkXvBzdGtb8YPcbGQmMNVRdh
	 k/aSDSBEslfM+6E2+eQG4Z5qHcV2S22rQn5boW1dlbkjwJ+4a+VmEKfG/n2TieuwgdCwO
	 rKGJxPI7RWLYWwr0ny7t6oI3YhCxLwJk69iwKjWg4NXLNC6Gu5JQl8mzJOQvRlJEbX6VL
	 usZtFlow+yIK/p/bLFVg2HLUjs/NR7APOpeH0sISJEtYi1Xn6ZSjvwqzM4Bb0hqKUDfy0
	 V2p6gLjbD0BOU1a7RW4E6FbcB0aMvU9VNc7QKTVobHNzXk4zfPCPGvTe/waJEP69J6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167970;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=LyMGAaInYYZKD2EbDC92SHBmRPfFEzQvFWfFO59Ilto=;
	b=pdqt+WF99b9Zl77hAtR+akWtjePgYd2qxgnmaVZE3IICgsWk5uvd6LAlO4xtS/MI68o9
	 wsAGKb8sJD36Vmk6rnpdJIoDeugu3F+lz7VU3NKcavpqDgPRZKUaIJrRPnLKzvhoupt32
	 PlYyzEFEW7KXv/ZlLCBGNI0P+bzdL8tQpyS6Uuts2j47nNOgt5CujCQmWiIzi1pXlTzV8
	 PNOVmDNkSdJzQn+FwgxrfPOsQ2/2O/XCY0TvvsEgYwM6JDvNDmlI6HgchM4jRYl2BHQxt
	 Pup3FYEDGkAD6mTyWLwyZG/B5d5E0SCpIVC4XO8JgnbKrpKRg4SO/C7yWcsPtx1lUVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DPbguDKv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453A606A330;
	Fri, 20 Nov 2026 09:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5453A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DPbguDKv
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 61101202284;
	Fri, 20 Nov 2026 10:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyMGAaInYYZKD2EbDC92SHBmRPfFEzQvFWfFO59Ilto=;
	b=DPbguDKvunMEOfZLgYieA/RNCoNt15TZ6y9DxFv9Lxa9RaXor9ZMLHgXAKJfy+PV+Sg4XT
	m6zsYDsa1WWYMxOqUVHOkD07fkEpr4KoqfsjAhkQPCEzR20G1YMwhNtR8/dMFtlV5Gfrr7
	+HIDO2yTxS1OFLbi7ixCBAKdNKewaUIgHbNNbVLOigjzE7bVsDJilo4uUkb9f0ykHSYJx+
	PHyUExqB5JwUM88HS5WV7P3cXzCtiE33JuRCfhnG/JGMWZdfvNacZmB7XlJ5o5G4Ww4IXf
	wfXvW1mf8ezE38rGAmekBMfcqOy2p4XPQvLhPsj0aTFKN3FzaHtq25HW9Eur6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyMGAaInYYZKD2EbDC92SHBmRPfFEzQvFWfFO59Ilto=;
	b=ScOOTdKlO/bWMfUaFIv6rfmPPwMuGuDoCQ3sXxyhhLjqSohAJNpbJQKxL7l6Bcc1Ai3Uax
	YoiZo1F6gqQaw5kuQGyq/VMGBScb9HTAWwzvBbtu8JN8xUEQz7USi03lrY94c9p+A88Frp
	FrIbgA4o1t5QCj8Df6DJOf6VZw7L9jwfBrLp52XqRPbQt97ZRkmqbTZht5/V1jk6gi1lBn
	Q8ppfNF81nzdtNuAjN5t3UhNJXeyIU+ukQ9BO0CaUhBxGSZURqis3ueAlWbM/elYbFz8eH
	ERh9EctbYvB4yp2MujvDgfIUU+43Ps8E3AjQcBHL2vcNibXqou1ToCNWo5Ohyg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795167962; a=rsa-sha256;
	cv=none;
	b=U3uOlUuz3ZVQ0Ivbut6n8G2vt72m++XIGBY4D+kspf3aD0HXiENHTIWzJD6+M+XhLunlT+
	lySMhRQSH0agOdRE1Gi5yPeKQzdFqSTNJz7rasGBRFXWRy883M7N4oO7fnXNqERADArsnv
	DOxmLcGBJBlxJg0EdoaG9UTQm4L1fp/3Jbc89RgMuFAy/8Qu0JVw7KboEDJz4ZyvMgR88Y
	AImpa9/dnedeuba3T5Ex62yWL1nlSfoSY48wKAXpV93nGYF5cJFYT4WI7ufeTypiSq9bLC
	abaEm95EzibTxTQrBfQ+9ff3rp0XBxrEgaCVN5MF79iTp3/q7ZnEjwKCZSiqAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 4692E380A04; Fri, 20 Nov 2026 10:46:02 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Fri, 20 Nov 2026 10:45:56 +0100
Subject: [PATCH can-next v5 1/9] selftests: can: install net/lib.sh with
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
Message-Id: <20261120-j1939-selftests-v5-1-fdf4c242a37e@pengutronix.de>
References: <20261120-j1939-selftests-v5-0-fdf4c242a37e@pengutronix.de>
In-Reply-To: <20261120-j1939-selftests-v5-0-fdf4c242a37e@pengutronix.de>
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

