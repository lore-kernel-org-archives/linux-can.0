Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=0lvrf6mWXGES+4mZJKsuT0dGEdSFaLpfCrsx1w4wbhv33q0Yygnx4/KD4KXcUclwzR/S
	 TqI76HAkEDgT/sQ3xppu6M7lFbT6cEnUZBp6036+jmnO0DeIpQwip/9oBeYuy6HdBOOrY
	 BpsJyz+3K2xtD4dYqB4+PK2kv7GuHp8N017GFmQ7PoYu+yR6H5KJ/Jel/OqYR5sVXypzV
	 heiMfxgPjPg1Pj0BY/ORdLUvofQ61aYTlVj23cFMMqOC1a/G+8nrzN5kcJx03iPuxRIxu
	 gPlAtLEC9Q9UIq+p/8Rf6n2xwOikzDpC17q4rELH5AvQ61wuZQejdiTkLjtbZGBDR9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4unrm/Me6Sg+z0cNCryN+M0dekPe5EQ7kCaCl9mZDMI=;
	b=zAIRHmx37LX/lkhekUCBOlEMI2XiQIi76QaDXmLVqNeW/fCajMGiaYjJ0vOHJwEy2P1g
	 UR0i+u6TPwkjcy49BpkGrh0j8CwVquJpEar9Dhg+BgXIX6rupyy7JvMJzfzjhSHCrIN1C
	 YmzF47JqUQjEom/OrnaRbDb2vIysJjojreAwfBqUj4fLQmwPYrjrSfedrmaoLaaPkleEY
	 WXGcQjgaPVYfkwEZ6rLiHLVtJZUFRch0ganGjTWO624RS/De2RaeknYASniMPjcX9zj19
	 W3Cwpt5tVb0YDMdrOr2aIFXnHrbT98PGWKr6liUPYdLgTM+aB+rzgy8xjflOlV5M2KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Casrfs6c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFB606A68B
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCFB606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Casrfs6c
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 51838205B4C;
	Sun, 22 Nov 2026 19:48:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4unrm/Me6Sg+z0cNCryN+M0dekPe5EQ7kCaCl9mZDMI=;
	b=Casrfs6cWRoA8JEOg5BmxnOyKehsZTo/4KgoS3L/FQLCsR2DFp9ueSS90CraSfmV6abI76
	B41K4tqzpRSfviqZDpGQf7hcpZbIWX/d/+lwegDYFpWSLEcGolM9XJbDR+++EQb9b+uJDY
	FGgRDf78HMo8CNTl+OJoAL0nZvCDIexDZi8rpm6xpLqD4jYL51pNF0nchTyh9Jo5UbGN6Y
	yBPWNdpfY/eIs2fmkPnpxMBTbbVJ0L6RaW+j9YGd2JYsXfmf2Ny6zbNky3niDqwaIgiZR3
	vqMAMusSuCELYur5v8X9t69vdClIXX3SEQxK0IGnN3Wrd+6jeSbSVXhT6EoqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4unrm/Me6Sg+z0cNCryN+M0dekPe5EQ7kCaCl9mZDMI=;
	b=BpbGNgFWgZtsNgtiFzTGkMQpPORP8WIxRy0LgXEvOero1ofIruoaa1DCdRTwfXlNOdYdi6
	mkwR7Vk4aj87+qOmZAZz+iF8UWnoI9NA6QVJqP+wZSxUlCOlAAUliqkZcC2PZEnkdidPxq
	4cQtR53DCTNneZfL2O/H1ejTQQ49cNGU0QiG4qc70KIHNJOnvCpSeZhpTRLUHzh3FB9t7Z
	fEivk17tVmzi8Au30jZc3S3vopCZzkz0IupgeapZ/7aZLkfnLpTHNoiFTCYzjem6M+cu6z
	IOZIcbk5e38xqG5p5xvSvNJ96OU+02cPMDLzUUPmkpZc3252tfaWIQkAjQhSzA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373331; a=rsa-sha256;
	cv=none;
	b=bzlLqAkBzp2NFN1OxE+XSLiTu2fRgPdhVUL8Iwk6CN2TAFvQ7X9+7RkT5vkAPGnm1agDDy
	LGgu5f8is08baoBHwE5sZxV7peiUgUM9NNSQQh+LSVFUEQjj5cqjdeudArLIDHapmZ6uFY
	Em/QBG+RMGtNHLZ1K26u2FSOYoM3qK1wTBSK93f9qaEXOGApowWiCj7ApsC1c1JgNAAzCz
	AuuHdVZXQrQyd4qi2kBpbrap0f7G/eUsFwpD8s+OoZZtsEBGUG273xC3EMFJ8mUN8/5r9O
	AEw6KPJ1LSbSbF3Xkp/CogDDQfwWzcdNgCqiUMFssPw0Pfe9kJF6v7l1b+9Y+g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:37 +0100
Subject: [PATCH can-next v10 13/14] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
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
Message-Id: <20261122-gs_usb-fixes-v10-13-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=cSvsi4SVOI38PZsAST68UzBCSc5tgKE5sWBpm8KfOFo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtuRNlQg99nGq22MmQemv5tGf5P8qZl+XaW8QzXvwY
 WH19/VuHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZiIvBrD//qJmzdPU1lsvlbi
 o4nV7/SQVsuzAdcl1WfF/vRx4XhwL5mRoSfA90Kn+YVFn6rusbudipj2td1xP49MxEKFs1tvTWn
 I4AEA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

By definition, CAN error frames have a length of CAN_ERR_DLC (= 8) bytes
and the RTR flag is not set. The user space expects the frames to have this
length, and the function gs_update_state() accesses the data from the CAN
error frames.

In gs_usb_host_frame_header_valid(), ensure that CAN error frames have a
length of CAN_ERR_DLC bytes and ensure that the RTR flag is not sent. If
this is not the case, output an error message and resubmit the URB.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b345ab34a200..7229d002b938 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -639,6 +639,35 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
 		valid = false;
 	}
 
+	if (!(header->echo_id == GS_HOST_FRAME_ECHO_ID_RX))
+		return valid;
+
+	/* checks for RX'ed (non-echo) CAN frames */
+
+	if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
+		if (header->can_dlc != CAN_ERR_DLC) {
+			stats->rx_errors++;
+			stats->rx_length_errors++;
+
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "invalid DLC in CAN error frame (can_dlc=%u, exptect_can_dlc=%u)\n",
+					   header->can_dlc, CAN_ERR_DLC);
+
+			valid = false;
+		}
+
+		if (header->can_id & cpu_to_le32(CAN_RTR_FLAG)) {
+			stats->rx_errors++;
+
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "invalid RTR flag in CAN error frame\n");
+
+			valid = false;
+		}
+	}
+
 	return valid;
 }
 

-- 
2.53.0

