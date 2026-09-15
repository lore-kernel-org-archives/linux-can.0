Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA923F4DD0
	for <linux-can@vger.kernel.org>; Tue, 15 Sep 2026 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479966; cv=none; b=TtwYkM2XQTWwblhUI1KSYilIjUwUiYenR6/+Rdl9J1uqroLD0F1mLmIeaAwDS9CEsiGN7+601NQS0W6w90URCGMk0iG3Uls8Fmx6i+eAYAgfpvE3QD57/dd5vUjP17vmqo7Lepof5+ttO8eRsy/o2uZdDFBGFfRMogOHlB3vASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479966; c=relaxed/simple;
	bh=QO90EkEZRvnBz7dVuzqcKDDMvyzKnWUr+tcb19kHKyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sYckYV9DnM1buUdJzd/SHi2CYp33QFra5gejy5l0TBPgyMYdVAqF7fnAFrBFxd+wzARgyA1Pa8nnwlHWvUT9wofaZTWz+atfKI7RwktDsQvXtvvwhJmFXs0iLXRTMokCGXZDCJli6Q4a+PIF3UWmWxlh0iUxSIRQLMHnccjdwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BjXW3qpB; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BjXW3qpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1789479961; x=1789739161;
	bh=QO90EkEZRvnBz7dVuzqcKDDMvyzKnWUr+tcb19kHKyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BjXW3qpBCnXLqdcFkMGXOiWuKZiOIyZ/MyOqaf/4xyMtztY5BbwPRdwb3JD/JIcYT
	 0JBQuWadPxpNtVgKbnd5BItL9ylO2WwShWi/7yJ+C4mJk5t9SEjOcMjGImslF73Fd9
	 dVkCK8/tHBqWoJGCB9Ofq8vwooKVOZOAS1CKDuHvWfkoEFa6vhm3UHD+2+ejWRrEuf
	 kmPEnDjTqnsWpDu03SzlvrN8nt5sVO89LrWXmf8bLvW61d4EXtuKa2Njm2R8LS/BsT
	 /lC446ofc1Y1Vhb+apKDIt4Z1sm9Gk7aJvMyqVhSR8+8IH+WJ3u5Eel/rOQJULMSrp
	 GkRqqBC9+ux+w==
Date: Tue, 15 Sep 2026 13:45:56 +0000
To: mkl@pengutronix.de, mailhol@kernel.org
From: =?utf-8?Q?Stefan_G=C3=BCnther?= <stefangun@pm.me>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Stefan_G=C3=BCnther?= <stefangun@pm.me>
Subject: [PATCH] can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters
Message-ID: <20260915134551.54038-1-stefangun@pm.me>
Feedback-ID: 137007910:user:proton
X-Pm-Message-ID: 692de8251a8c8e06c8f98b81a18b8fa2c1b5fa30
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When the device reports error counters, the driver incorrectly uses an
assignment (=3D) instead of a bitwise OR (|=3D) for CAN_ERR_CNT. This wipes
out the CAN_ERR_FLAG and CAN_ERR_CRTL flags, causing the error frame to
be sent to userspace as a regular CAN frame with ID 0x200.

Fix this by using a bitwise OR to preserve the flags.

Signed-off-by: Stefan G=C3=BCnther <stefangun@pm.me>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/=
peak_usb/pcan_usb.c
index 9278a1522..235cf34d4 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,7 +526,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_co=
ntext *mc, u8 n,
 =09=09=09/* Supply TX/RX error counters in case of
 =09=09=09 * controller error.
 =09=09=09 */
-=09=09=09cf->can_id =3D CAN_ERR_CNT;
+=09=09=09cf->can_id |=3D CAN_ERR_CNT;
 =09=09=09cf->data[6] =3D mc->pdev->bec.txerr;
 =09=09=09cf->data[7] =3D mc->pdev->bec.rxerr;
 =09=09}
--=20
2.43.0


