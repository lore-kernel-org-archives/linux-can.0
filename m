Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41653BBA0A;
	Fri,  2 Oct 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928915; cv=pass; b=Tx+sPlMKuuz8BNreGh7rtg6Lb5R5VnfdNCNvXDGuP6vHN2MGt4J/aNvstotSXIOUD9ksySpxzNQSXGhep7EMbWuKzAh9xq0GOPRlVvT2Qg+jQuRcuh3Gl6nLv9tmVpjb2q40fYAfTBrAZXaF1qymap/6fbCJmuuXzTO7JoHe8HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928915; c=relaxed/simple;
	bh=Iz99UViJQSrGP2aeivtBdGWkvK2nib2vAqmyDAve4Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCTSL0WvTnVtYS+bkTDA1l0hbmY3M5/sGX8fxk8NvmHXqNvrbezdXrMBWZMJA9kBOvM2AoZHgo7rrijxPna3hS4OJ94AeU697s39Ckp0pgx+epDkIPIUsQ7eV0Y4IukeFWny8WMHJMMLirBgzv9krBmtJRwrXftg93nngmjlGRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=R0FMV6K9; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="R0FMV6K9"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C04E1200926;
	Fri, 02 Oct 2026 10:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaTkREhEsFIVCQV5dDGiVS6nnSJlCz6PXInHeKAUe9k=;
	b=R0FMV6K9wo0f9ln6i5k8qaFaY0HatHAeoHjept3S9YTt/fUqY+ljuPRekdF7FUiVuGRATW
	gBBuBPmqRsY6cq91/vYdXwdaJyEVPisYbmsS1Jwwxu48beLKqqACWgjRup8R7aJFAfN9X1
	K6PCVe0VTswQFQbz4Wx6TLG7ZQO7Kv8dmsi5L/wEf19LOxSr0dqHb048XYU11z4Vf3FrxW
	2EPnjKhXTW5EYEKaB2FS1/gAPm16w6//LwgKMZ+kWuWRHOSdNRkcD5Bw1FkU5rgQ+iibxX
	FFjDjg6zvpNLF88e0cCNBe+KtKbXlA48y+wQ8/ty8G09Kfnv7YHriZA5PLIbsw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928910; a=rsa-sha256;
	cv=none;
	b=KLfZOE8mr4YnRIX0tihjvZpb8N1W55PxvmmUN8impkCB4zPt/QscMnuH6GQh5s6FLZXXYR
	1zx84a+Z8LC58Shlu2/5QxetDqnLuAykqMNZ74jD0oIYRwTIlWfiukVvl3i6sipIBaxhgM
	hn0k9SmMUgAngsHZnl/29ThL31r5MrVsnwgrLxCLIAPqiRTMh5EQCglcTiKjRylyMn3GSm
	a9FLW59mggEq/CGSgVrxEp1kSpbqHbCRNu0781tBjx4Z9wXscyDyUQyqbxtzS02uuRDFMq
	dh/DeukNakRqRARrYMZI6sEzJikZnURZmXV6oX8xD6MyPPyGc3VTXylRtI0MzA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaTkREhEsFIVCQV5dDGiVS6nnSJlCz6PXInHeKAUe9k=;
	b=OByR0mcgpeWfBA8q0z4YSKrztmLhKwEUiEgBV/ULPj6hnSV3FoJ1O3m4d/rJt2D+Fj9+HJ
	tSGSI0mx7uu3jNxrB4Uh/d2yLatp930hW9SxMGKRNnQzfncct51zk7da/ieBQjdrA/7SVG
	V2AgiUOx0k7zYZpt3bUPMPSGNEnZxZXuqyiBSuUNVO4FfanNp+F0k/b1FCAQzDjGnLvfKI
	29NlNYg4LUL9l/6eUrqE96zRNFlgX/NsxWewsLk7bZQQFAlstFWhO7p74pvuAdgf8RQZjM
	BkCs5lZASGLUpKxSn1ThHZU4d56v2YAai7ffhYmD4PnTB5Trwk552jdDRMJs6Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVI-29;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 50C7A5B8286;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 09:55:09 +0200
Subject: [PATCH can-next 2/7] can: peak_usb: add missing includes
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-peak_usb_enhancements-v1-2-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
In-Reply-To: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Iz99UViJQSrGP2aeivtBdGWkvK2nib2vAqmyDAve4Wg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan5xnJWmps6U8sYGZV9tsJsu+XS2pNt/evF/hkb3RZ
 6pfWZRLRykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACZy4izDP2XviMdhDWXxZ1b3
 qv0/sadK72aKCI9Bl2oG/2uz28lzCxkZrm1Ndo08lt/0rP3nyZ+2htlaZwx212jLt3f+Xv9z2no
 7XgA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To make the header self contained, so that LSP servers don't throw errors,
make the header file self contained and include all needed header files.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 65999f04f4b7..9ad7d31d2720 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -11,6 +11,12 @@
 #ifndef PCAN_USB_CORE_H
 #define PCAN_USB_CORE_H
 
+#include <linux/can/dev.h>
+#include <linux/can/netlink.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+
 /* PEAK-System vendor id. */
 #define PCAN_USB_VENDOR_ID		0x0c72
 

-- 
2.53.0

