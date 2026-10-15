Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D463921E7;
	Thu, 15 Oct 2026 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029234; cv=pass; b=k+wecndzRriCIU9pMi+PeeKKUitYihchiLqNEbkJg7ROSk3/N6NZWJrYPOHsoJ3FTR1Iz4Qq/aeMfoxokKWuffEXYILJAcF1s5DEejwz4uYU6nz1ON4+Btu2lKGzLbjo21TJn5uO00Q0Cp3E9vJGTydPJlZlnd/N0DL7pQGDpcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029234; c=relaxed/simple;
	bh=g8+WDc1j3VKc4pDoCI3Pqboo/nhAaEk3+5NfE0HS/sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHGyY+tXWOJcgvHITXcB3GNxOh2C0yIZKBoWEJz0eTyBHhoCvEHNuuZJfR1eIa+kut/DaNxnryXrQprESSg2NrLoyct3pX8wU0byQX3WpssHJsEOMF7RaOZDuGHIMsJyYQ5CivmtJhpjOO5Ge6c0HU+FqNg7Cwf1/vFh0Md2YeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VwyzADYu; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VwyzADYu"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D3BD02027EE;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwvRK61mF5DUwcVL8ArP+tIdn1DI+dPmobo+ldK9ti0=;
	b=VwyzADYuqVVR3KwojwS4Ccsqa0JohK9nbe0a11lgqzNrke98TtmaYrmJZHfkWlOXxuAzgX
	yCdqgFvXYcdETvywVsg7VDGs2/KQsMpbK63Z5gjjR8qY17k/amMz+83zca1n+b9epEh3xB
	UolFfVwzDjAWRtMmDY6H39yKlbBx6CtfEFNZ546bVzK2W6D3vnTSrcrwbG6ivcLLzhHoR5
	/+W/h8L8vv8DstKyClW1o9ZEXLJxRqSsGO4Dl0ALV1SUJQssuREToUqyvmW0VW55YPlVza
	8tJDLowLOxZQzTCIC0pQjtReLO34Yf+VhAwY/lBQ3tjql0cRsH4w/A4UdKFSGA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=byndwOxvaUBYTGRi7nh7ALNbBNRyTvIfOaKRNNExTAnPifIy4BVmctqfD8aVsaZSv6zsyd
	TNTd6pMeMeuStFYFq/xnMBpGeL+QhdmacxJ16yP125GdlqxJLtJDEaJaFebBrcJptWh+Ue
	1jRG4F2y81M2H/CmDeNEcqjhJypzRwq08A1xOLIkJNTPby5S9wjIezOdVmmjulaCL0b3NO
	gi5w6Yc/B6jlC4oSXaG/dCWTZ/IZoyw7UrpnznVPGwWwLcP6vUCOHQ/FsBdjEhJX7VpxR3
	MtCa54Hahq/x4gZoxvYQ+R6BKBR5OBUR9E5fFKsJVlIBIu+V/LfyRqk7OjWZGw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwvRK61mF5DUwcVL8ArP+tIdn1DI+dPmobo+ldK9ti0=;
	b=NM6TH2O3ENg7yxA0oG7QfPeB3MhVI6yjezCt8vau3hhkEDiGXhs5Qd7pwiYY+oH707Kj1v
	5SJOQbrqMNgMrnSg2w/u1QrfFGDDKSqHGditkplkbPeyxHsY7w+mdkYwYuofSQojphGyat
	GlERxzwQ3vZZqiBO2OTgVNU6tRMFvgDcQAkx3C6+ErlSKv4aa/6GUoA4fbIgusErkHPq6N
	BOQKT/h0/ZoKafJy3OlPxfp34rFFdvsW5i8/kDUuhPdOgMh0DxMP3Yf0lLw15G8iJZi1EB
	UCOILSjdWDF99Ot4clu6P6D+SmoyzgJr6a7Ck7ivZsmo8TAMCj6TdQFFAEHH0Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wrt-2V;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 87FD55C47C2;
	Thu, 15 Oct 2026 01:53:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 36/37] can: ucan: fix repeated word 'is' in comment
Date: Thu, 15 Oct 2026 03:40:34 +0200
Message-ID: <20261015015336.816543-37-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hemanth Selam <hemanth.selam@gmail.com>

Drop the second 'is', reported by checkpatch.pl as a possible repeated
word. Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Link: https://patch.msgid.link/20260904125018.10923-1-hemanth.selam@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index f72e0644c5fd..6b088a05a901 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -61,7 +61,7 @@
  *    the following way:
  *
  *	m[n].len <=> the length if message n(including the header in bytes)
- *	m[n] is is aligned to a 4 byte boundary, hence
+ *	m[n] is aligned to a 4 byte boundary, hence
  *	  offset(m[0])	 := 0;
  *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
  *
-- 
2.53.0

