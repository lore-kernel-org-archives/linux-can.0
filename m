Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809071;
	b=Z8e6leCRaRS+OdNeNd8mV0cHjAXvsL/UebnseOVEUNAqpzbC2rTMxw0irLIWny35H7b7
	 wIelJChxmgfbGODL82zVnDKnFiPkNIEwhlK9Sv2IhBQaues8yqp1lHKHyP38tflab+lmb
	 LQA27YCLedMiJNhee1YIelYLoKgmew+WPdG60rFPzsCq+7kQAH1uO+PSStnL03KosO0zK
	 NAkI+fm0uvNHgt0CBYwRrjybMwxla/L2mHc2Gg4GWeSRMzlCZvY8/Z+JwM+rx3CL0ehYk
	 uEpQI18AWSitRD9cjGTIYEu5LdBvCKJW9ygD9n23XD0Fjo4dpshQ8RzsHID92L2KlgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=4Dnk/mKLvmwjsm22r8MYC0OWvKrZqndMT9TsFKxMuLk=;
	b=J/+MCRtdQcJpiPYbVWUI6PsbEYvPIbOh2UgFuvqaK1hTxK3tS4JNF/kAe37PX3yxgY9e
	 Ond+yvDfMfkOEMT0cIoNuJYit75TLWbcf+sBERzMBheOudOCA7KqWCVpOMkBwC0IUFq6y
	 9GC9b0g5cAzBScZk9RUlVPLI1gO6dqj4/kbbvsCA/YiKKkutA6R6eEErYUVsJyVKEaWXS
	 HJ3n07DbW4RBaYwyXXqgZNyCuoDZ7tSKoj9R0v2zepnQ3mPoKZyEy0Fm98iJmlHwt++uF
	 yt7rBHWqAdvH9XaaF/RzhlDipx99g9ALw7CbS4biUhi5noY/zuTCjOeY4pRFqxCdWGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=D2xdbCBa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2D606A336;
	Wed,  4 Nov 2026 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D2D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=D2xdbCBa
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 79979202BB8;
	Wed, 04 Nov 2026 17:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Dnk/mKLvmwjsm22r8MYC0OWvKrZqndMT9TsFKxMuLk=;
	b=D2xdbCBaqDcoA+LN+yg+TK5eJXcB+fne/x9QbF8HxHOAqDfDwnOBSZsJHlYv6OiumNKKSK
	smV41liSL1Ay+N0I5X2TNLgQr7AZ+YtPIiRI8FC7NVzbrkUvCahVsg2yaDZ5cXUlBUI1AY
	kLJydR30HVN5r8wHv0dQgLSanUITzHETALDjpsu+wA2F6PXx3fP/HUyapcJ52XkwKUWxtC
	/T4VeYOy4LvNSEKe3jRQYNjKK9+TSV3EdrcBtP9jidqdUH5xi3k38MnxcXU/FcoD4CpjoJ
	eWqISeStBHm+uLL3sGMeRwjrCMFFLhNRu9pXRBo41uyV19jDgSgPReuLOHt9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Dnk/mKLvmwjsm22r8MYC0OWvKrZqndMT9TsFKxMuLk=;
	b=biHI3oladoQqDdbEtv99+fOFErq1q85bbspWWQ3Sy6QEJaN1LC+sqKWTSA4lBt9WcDp5ex
	TmJziX99/TVK+guteA/Nz5u1sb1u0b5qrHlUsxu4VHJVR9Hu0OGB/SQJJojBbJpztWEWIy
	aHz7MXnH/Zj6mDC1iwVBYiku4YhMOlAxFp9zJin1U/KujDKI0/03ctainNrSyf2olJ/+LZ
	tqT2c+DpKzpAG2imMtPcO4qtH67dnfHRIIiLkfniG24QanwpUpLbECSLaW+QDC1o3CRiVU
	zZ6xdm1FAig2gvT3z//gndHr0oz+QW0GWjSG+Y05vtpKAfhQlG2D3iHoM64uoA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809063; a=rsa-sha256;
	cv=none;
	b=ANuaVU+0Q+K88aA/Y64r0rJwi4PuwxC7YZdMdWAdoFQwNZmk3gmgOPQqRauF1Tw1BSxbbV
	TOPVb4PEctMtT06pJx2T0dv+ojRTCF/J+F3H0Gg9dTHqePyyMt2DJ/Nam4bnAE6Zo1rbTv
	U6mZgvuNsyeVq8e6wdIXvcbQTD+o0kFZ1SqRvtp7Lzb+ZxZhhQvcKf7ureK2j1v2cQuQNY
	+9NxbJ2d210uUO1y1+QbR95ZODqiHAciIU+jYvu3ijkoAY2Qqgqa9htvSJ2NMuy3x7OtTD
	CnmQi6Fx9lPfnYY4MFofc+jIC1v+F8VUo5mELuEGAnOaAsek8r/UK0RWlD4+Mw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 4B46F380196; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:16 +0100
Subject: [PATCH can-next v2 1/9] selftests: can: install net/lib.sh with
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
Message-Id: <20261104-j1939-selftests-v2-1-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
In-Reply-To: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
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

Add ../lib.sh and ../lib/sh/*.sh to TEST_INCLUDES, so that they are
installed with the CAN tests. net/lib.sh sources lib/sh/defer.sh.

test_raw_filter.sh sources ../lib.sh, but the Makefile does not list it.
A full selftest install ships it with the net tests, but a selective one,
such as "make TARGETS=net/can install", leaves it out, and the installed
test_raw_filter.sh then fails to source it.

Found by installing the tests with "make TARGETS=net/can install". With
this change the installed test_raw_filter.sh runs.

Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
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

