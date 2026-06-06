Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A13C3440;
	Sat,  6 Jun 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777649; cv=none; b=fPODYk6zBsVuQ31eF8pEv/jgYjiwQxfEqakGDUaav5qUNth1S1+vB0XU3NVorLcuDuRvAQDXFt43LS0nnBKHLyxw9d9iL1h0RwZh9cqoJcmf3QU6g6agoPx5DXhrjq7oMwn7MPTbOIdmH6bdn3PuXGvE+7DE+Snd9vN48g5d8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777649; c=relaxed/simple;
	bh=q+CPTHnNRluM6JmL18/hFwBIHgbfmG6AK4nOvyo4Ako=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4Sa8SjjZOULGHktraJ4OqOH0rvrMpc21eLHpfGNJsRxbqej3Ame/6puZwn5pGmy2y9N7vAYXcM4r3Y4viqN2nHUSJI9f6j7tzLnSyXwZeBLHJq5rBTwjUfOclbmAqsgD8VbETWxUkq9NkK+jrvzVPWC3aghHeoF4LpqhOGcD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=wGa7iYpd; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="wGa7iYpd"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-007NRc-FN; Sat, 06 Jun 2026 22:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=xz6dZeUw+W1CFcduZ9YDgcFJQaxSfhJatXsg8jKwQvI=; b=wGa7iY
	pdiX6O5Nee/DvGLC+FrGQOqxoUgQEk692R4JEzF8iumIhDFrF8XYm1oDXQ4OrgoxRQeXqCCRW6VbN
	aTtD1ppSjhws/5isFCCqgPpbtFo3UxA/j9kXfZPGzfxnIfwx5sTYhJf9N+xu8HVLY59ys+FgOiU+g
	XvOKIrTQCOCk+H9ZghUPYNlngj9EkKswLaKS/5aVu2QWs3oo/8ZK5QGugfaTqN2h0Icw4ctf7m3H1
	tnacCjVRQjR1duSIDotzOkH6n/gBNBeOX6KQfR4lrA0g6jrzmJRrgM+LjISBt+X9qvus6yLthEhZR
	qIbVbXsMKtB2sToY4bfBaeqM40Kg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-0000u4-1D; Sat, 06 Jun 2026 22:27:15 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbf-006V18-08;
	Sat, 06 Jun 2026 22:26:59 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/can/usb/kvaser_usb: User strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:09 +0100
Message-Id: <20260606202633.5018-15-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index e09d663e362f..2cd58e825e0e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -746,7 +746,7 @@ static int kvaser_usb_hydra_map_channel(struct kvaser_usb *dev, u16 transid,
 	if (!cmd)
 		return -ENOMEM;
 
-	strcpy(cmd->map_ch_req.name, name);
+	strscpy(cmd->map_ch_req.name, name);
 	cmd->header.cmd_no = CMD_MAP_CHANNEL_REQ;
 	kvaser_usb_hydra_set_cmd_dest_he
 				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ROUTER);
-- 
2.39.5

