Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=pRTagndFnsOyQjsCvJoqNaVTYFjM1gY1eKyn/YRC1aMs0P+gO6Ltr+SM/76bkfGB4juD
	 DdCLER0lC3ckI5u/Dae/iRwzbHLgDqypo9GrAnxdha5g4exNiRV53bOxiAT1XrxcJDw/h
	 8wG2MVsjygrb74fG+bpqxiwuCqReoPIvtwTcmD4LFRdEP1Nfu7xtZV2WS69q9zgrKuxap
	 WrcShgnWPS4QHlC0xEgEAMqCnq6Jl/HbOQQnSMhpEALsJHMADXeuyT9Q6qS9CJdcvzkMM
	 +5Maf/76NPYLVvJ+B0LkMknV+/s0N3P7jynkY9og+HInwY7bpk71BMci5ENndf+Tnxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9USKEOY9tJDiuVsW8Tjzev/vSzBdN1rqNGfazAcbly8=;
	b=AWjpGZQrLz1FHhLCgy9AcOH4VEtOCB0o0fvu+SNzD8WVbqtjsLZCh8QCHe8q5Op93Rcv
	 Db9OsoA1AfFu6JKwKXdxGp0N+8OSuyKjZQtMNehhA+DCzGIMe7m16IxCsbR4qEqOa+RCd
	 7E4yLZ3JQ6Y4FygE8diIGoDwW6VGMeAb0xdpjNM+vsZ5g7agz2M0Ffyq38L+a9Xa23dCU
	 sTSG9W1dl3SnDDx0alA5OReqsYixlQwEETRxAZL9ZuNv7hLMj+UNVXu5d+vDkrmTL2yZP
	 /APgE5KP6tjedEjpd9DSHlit+G78oKcYdBkB3Dnf/cmGCdAAoabHYDz9QjPuQt2jrjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aGHl8oc0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7610606A688
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7610606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aGHl8oc0
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BE635205B41;
	Sun, 22 Nov 2026 19:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9USKEOY9tJDiuVsW8Tjzev/vSzBdN1rqNGfazAcbly8=;
	b=aGHl8oc0x32m1U5inyrjxhcvmn+B5BkzgaDGWRZNtCQrfxhKxrUFzeTmv5ySJ2y6R51HXc
	DryeplnSkEJjwGphR11W5LfJ3ppTpdHkoYxHpZHNzCt/0W1oSTaa8DfPjVipmBN9ShuJD8
	7PnWYCFlJ0FJ0gzye6T4C3xW75xH/vyXrJfxl0E11Dke2346/N53EPrVY0Ppt+H4COLbFW
	MeibtYpleLkD0u+ZnVwAPFttFIlOdKtah9D5yHOhNNHuLptX6QT+lxfCuA9b+e8NAF7Xo8
	RM48Vn+oC/h8UUr+6lgsFVFCWs3JCb2fVW1dN6VhuLiBdLxMQcT65jX+AWGCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9USKEOY9tJDiuVsW8Tjzev/vSzBdN1rqNGfazAcbly8=;
	b=ePyiaoKls2vHWlhMRpNYUYgPPDrcpC5w+Jrpg2Cb7+2+Opd+FPtK6H2f5pswTZ2j+zICXT
	wbQHWrmRHDJP6pKJuY1Mo9Ihe55BDErgWUvMMremA+DlN74zVRqox/+vMA9hkloR2ImnY+
	xF1qtYhESXvuh++JYsCvauDmVt0r0hePaftPFFxfo55Ta+X/L11rWQpAo+x3dFu0sKJhy0
	wyTpDreyq8v9dWDb7kKqWhzjyU58XNUgGoIcR+hQMPuqhOvybf8tQOh2KGt0o9Z59JUVOu
	zEEbo6PAsPXnDjxi6mXcP+U+rhxLbrNbmMYjEz1oQMGoPt6oB+FSglTpmib2Cg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373330; a=rsa-sha256;
	cv=none;
	b=fS7WRE8KRVQ9yoUJqboPxmQDG8eeR4KUehmwAs1khPEIBMmSJW04JM28ZbeqFyiZzVY7Nv
	ath3Sfn+mcT7XvXpwVbK5NHmAcl/X3QRBz3FbGPQU4dcW/rhOS1Ia5xT/7gm8M2ta1Itiu
	kIV9PjZYGr7BO26+TFvjQwpVRrMf7fWjGx4UX8k+oYjrJiKT6p4Z0eHW3SEQ95xRtZ0bL6
	5BJHwoTl2yr/JVBg64hYHGeiScIFdnbQhOO4YYVz31Moi3OrAGRWnZOO+kEAatBza7KA21
	Qmy41+8cifP6uzzgXazjumYS2xBV9q8Hvd7gHnOB+8+ShXAJFWNCgBkkDR5nQg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:34 +0100
Subject: [PATCH can-next v10 10/14] can: gs_usb: gs_usb_get_gs_can():
 report channel number out of range error
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
Message-Id: <20261122-gs_usb-fixes-v10-10-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HY7ElH6JGdgEjaQdeaap0H20FZdHO25e1LmUFQERd2g=;
 b=kA0DAAoWzDpk+q6ZrdIByyZiAGsDOQqierzt+OPeUEL0nlz85pzdFORjHosYAiB4eXSbPOfAC
 Ih1BAAWCgAdFiEEpfjIIRBRQHWN6WCSzDpk+q6ZrdIFAmsDOQoACgkQzDpk+q6ZrdIeVAD+JvR0
 457WHMrXYs6qoqNWqQT66LtfxAtJ718c39ysm48A/2YAm3n0Me6B22bkL2t9pFFOC7f3jZNxOxB
 tGnATjMUH
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the USB device sends an invalid channel, the device should not be
silently detached; instead, the display an error message before detaching.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 9078460aebca..df5ea6cb0cf2 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -668,6 +668,9 @@ gs_usb_get_gs_can(const struct gs_usb *parent,
 
 	/* device reports out of range channel id */
 	if (header->channel >= parent->channel_cnt) {
+		dev_err_ratelimited(&parent->udev->dev,
+				    "channel number out of range (channel=%u, channel_cnt=%u)\n",
+				    header->channel, parent->channel_cnt);
 		*fatal = true;
 
 		return NULL;

-- 
2.53.0

