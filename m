Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991357;
	b=5OQy6cxhsl4l1SD1bRE6iKB/z2hE8q4KWeVNG0Z2lrB6O/yQnkAPwCHRy2m/1i2ijHiU
	 SlD7Y9q/0ZK9UiS5oh/HD0g6u9uywebm/X47bmnWahPDIrx/dp6SmnoFsN5hThBrsBh+3
	 E1sXHkBlyMw6n22rE2jnhFrZeNxRaa8uVBfBG6Rf123lTal67sC+ABItAFX/JjiQGfsQ3
	 WlbUsYNPH+YYChsbc+xNGr9NenBv75dnmyhFtZ8ybVoKqtn0HUmqcoA50fLvcH8MUythf
	 nBDRODfxZW8vhdod9nOwmmC28Eac0HrFsE7CccVunNxd66FzVMg5NqxSjr7vXXSCu4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=wCbSVM8dk8fFRHd4u9nBYxMXlp6WZAZUJxS1Ikju0D8=;
	b=XfzfEyfSSjEXjbAM5CXVk6jo4c0SUl7RmKD7qWtg0M5cj/bPU1ABLa6z4xS5/UWOJfBo
	 yhff2HEOYtG8pSTaVva2TtWfnaqWP6B+kcCbVsgMDA4u5mO4fM7KWSL/abREwW9HUSxh7
	 lq6SChE41PWN8kfn8qBEWqeJQhi+udVy+MkdhDgeaGy6m7Dm6McOLnLMEVr5mWS4+fyGf
	 gGguMMzw8PSfkNUNW5ECaLf7nejwEaYJbQqv70PneanF3mBkKelAkB7G1tffsvQervtts
	 U1Rto/cQu1nAVnG8kdJllgPrgU1YxR49Ub3VEKIKnTLtfyXqXaG8/9n8NfUljjh+tig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PR0sd6JV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA11606A88C;
	Wed, 18 Nov 2026 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA11606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PR0sd6JV
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C25C4205A6A;
	Wed, 18 Nov 2026 09:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794991347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCbSVM8dk8fFRHd4u9nBYxMXlp6WZAZUJxS1Ikju0D8=;
	b=PR0sd6JVarw1ZDf5kdnAiw73+FZorf46buL0qdRo+ikHE4ptAwoeDHea2IBf/Crpn5OKhA
	YO0FqRLVYOYpwlkus4t1hSwXgm1DS1IY6EyBoSSc0U4qibnaEU2xfbyxY99OJmo2rqiyUd
	Q68cg2SrpNiZH5LUSYtoLxFWpS7l1w4DDB38vYkrqbvTSg7jMCHtvna4ws+4zA1buQ81dW
	yq22XA1dG3+xwr/uwuZQPhq9mhKvCqtAr6rVQ94bIq4REtxt3G6G+Ipq/3lBKr0uSf4fQD
	M+cv7aqEOV4K5Dja4X25tMlGCb7gA+XUBcJi0xbbeb5C7X2OBSux9PZmeadWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794991347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCbSVM8dk8fFRHd4u9nBYxMXlp6WZAZUJxS1Ikju0D8=;
	b=b4jC3HMH0hAMr3Mwpldz5RzF5QGD2bvsXBRUDH6of6WXUYuxEcNwXWaxvT/J//CaAKViZs
	O1bn0ifRWPMkLVTrQ+aXeVEn1c4NKj/M5jmTRueuPQA6gIg1EppXHpPQt7qDtxDCj/uQ0Z
	87UAq3EwFFLeHhMFUX8Tk/pnfaIxCZhr1COoWR10zFrnxqrzP3h/jg79fPg+2on+V4S97J
	7wYoh8Eh3fWB+pgn580p7KOs2p796M0MrTU1ThKzIPWh3nC9X7monoK3vODxu4NTnGvJ3S
	gYecMSGnEghwut0es0PwaGMBjovCNGqMque/VwjhVepaG3vRL3ZOvDPC0GNSjg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794991347; a=rsa-sha256;
	cv=none;
	b=WkIqN4GdKCR17wEzJLFp53js/cnmdJoh1NASPamLffwQYMQCulAsePoRTNtnan3TOooJl/
	fr9Ujy6RiHTYcILpPSRvm8Jl7jvCuzz+W1aFmavZCaYAH8mitmvqZzX8gZ5IEAHoXfGtYh
	8jrWxgjNYiJidLD6TM82vU34NCud5f50AHWntoS183qTIh+QCSofYc7J1eKbmpKTt5PyqG
	Jg31etuSyg4Djdn4X2TFkg3q8YphThAXGBYTETdOnSWdz8/qLmuTVaeUUg8iSGbfYcefAe
	AnlHz/dFmLpMDjKgMl6z2pHgghaAnXZEniKo48gzy2kwP0mS94iUzinoEKLskg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id AE5DE3801F1; Wed, 18 Nov 2026 09:42:27 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 18 Nov 2026 09:42:16 +0100
Subject: [PATCH can-next v4 1/9] selftests: can: install net/lib.sh with
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
Message-Id: <20261118-j1939-selftests-v4-1-756768d32ff2@pengutronix.de>
References: <20261118-j1939-selftests-v4-0-756768d32ff2@pengutronix.de>
In-Reply-To: <20261118-j1939-selftests-v4-0-756768d32ff2@pengutronix.de>
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

