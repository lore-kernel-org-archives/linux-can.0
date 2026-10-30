Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357107;
	b=14RC2oLScqgER3khQVk3ni3qLxk11tTF4N2oWACadQs2JPZZg4k+NDTX1B41k7O0Fle5
	 PwNjjuN/uWZ0m6Rb6UmzOeq9HpCgN55gWLIiSbALnikb8W+9kldPAF+8mcIk6vu0ww2xy
	 B49tf5Fjs0FABAm+Dgw0qTqE+7LhbSck+tFYcPehyPYmtRQ7qow91vNwqQsuYNcCfCfjs
	 6/EsT3oDwlSL929ORb60jtDdl8IR3ktLh700Pvl6zfshTxwXcg8sf+wLZVyRFeMmxWTqH
	 H/aSXjbP5ELCS8xh2FlytpsANTowLUqtsEM/QCVtygEI9G9e7dDyANxvtBhmZmvqzJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=L4/OFlegMTeGdNcdxZg3vNoZv0nRjBvo5FF8xQPjWTYCqaiddO50TmEq+YltrYUlwIAG
	 EL89uJbJTr7HL/KiJ7DDmUFPS9BBqvWIA58u2K5e0Pixu8wJQ6IxruQ+GzRDamrkcKsCk
	 gzowfVAdy3OrhscW3j17EJovAwlDpU/ssFBiNuxfUZrTAYhYUZJNw55DbQEM7l47ycLlN
	 hIB8H3y5VeNFGMwgxiVxBYLNIn6t6JsgrMU6/Tc4U1L7MGq7KuLsNRV6XKR/7kxYsn1ka
	 nVH4gDK7spldKAdpoOuiizfhWkAQCNtkRa+/a8uZ5N1dyy76m4EPcrjB+H1sR9sCTjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acXfftAC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D22606A327;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acXfftAC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357105;
	b=gaOzyuow/2GiL6kmeUnvxIwKLRgTK6GqMmdTG/+HSemZFrz0ZK/Mhwid+pq5m2RszIWo
	 UCgZLSk+8GFA3K3DvIpBTxOxztNAmObp8y1YwAyoTZvV1RrhoRi24wkqFKiVu6qtqOxgJ
	 uCvFIDzpHsl0mycP9XkwifPZDFLOhF4OjCynqL4FS6Zdzmij8eqVSFXfs7TPqCrRgddlk
	 xphSCsvAvjD829fNnSiYiKWIwg2FkhHiQjZCSUJvotrov79kOUZNMGa1snjqD0FAYQM7W
	 IALeNnyrVOM1pN/dDeKo6apiwW0I8seeEK3HwQw/Sio4hcd1Q17i/wM8BXL5P6Fq4Hw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357105;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=AXPvehwescgXjKcWwZ7uz6vjRioXNnYnuNb+6iQY1Q7fR11nclm3m21dOhcDeg5imStR
	 tRmsnnKZiVr+kl2ED6fUP/AtlrRb/v235pTB/oBNjIExwKRJl2AxXcGbqb64z8rgfRAbv
	 koG4xUigDV9gsdEMwpMrfOGmR/Txr7c/1NZIxqFOfDtHW5hc3MwFcf07CZ+J7hTADhL6v
	 3yPF5lSmx4T+Mfz/EpA9KP++P2GgToazCk9WrrtaOclEcRphZOaMZgwuZLpWLqaWacCRv
	 hHUevKuHhFjl7DdHFlYNRLEX6zevsZ14Of8aSenOACcP1TxEYVq6K45j99lYzHLmxAQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EB4F61F000C1;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357105;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=acXfftACAN4OtihlnJRQbr3lBvaOYRre+3rsH91w3V5jXvrkvHD8SCxDOfpU2vwGp
	 2sm4JXee6xWeLRrFIknTFJy4I0oGxyfZEl6fcOsSWGf6kIMWx7A26kSwxVhZ34pTOG
	 0ti6QihDX0H2WmitR/8vySeACSDvv2jnAa3BskKkREOiXpnCBRDe6fLXcuMMtHgqPV
	 o2lMOSiavKMuIqvlgSUtswIXoptUgUpGbmciEzgpW7PEcUtDosj3VuDKBEgQ1j9Xf2
	 Eemm37bXQOqLp3RUBDJnmYcvZ5jPmVDkLi4wDg/mWvzzdvx3XBSL7hHkWL4eTajubn
	 flECXA533iitQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 656054373A;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:51 +0100
Subject: [PATCH v7 02/13] can: peak_usb: add missing includes
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
Message-Id: <20261030-canfd_check_channel_idx-v7-2-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=863;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=Iz99UViJQSrGP2aeivtBdGWkvK2nib2vAqmyDAve4Wg=;
 b=eHLmPgH4EP+4XRUVxsMfdEwp5fScdo+rvunMyOVUnzn3EbPSJS93QlIOekfzJXnr6zU00X4mu
 Yi2JV7dAww2Dvi28o2+znimM4AUX5g2XCSnkrVejlAnq3DRvQBN+mix
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr

From: Marc Kleine-Budde <mkl@pengutronix.de>

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


