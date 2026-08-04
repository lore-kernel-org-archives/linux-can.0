Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4D4A3411;
	Tue,  4 Aug 2026 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873378; cv=none; b=s6RV8dB3eR/tuCfBdTn2hszjpEDDgc5onbZFklDhDUthPNUpJONJLUvQA121uMtLdXmpq8Tk25q8RWCRimRtuqI9xzktzR+uB8+CfmIG4beXG8TucJxLB5GIr7uByZdab/HYlH4PYb0ohHT0Psnxm3SlBJHom4q+SjWtGha1eUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873378; c=relaxed/simple;
	bh=zBxMM+76iFZ3fU07pe5uoUvZ3c1Tn5Lufpt8BkEg0mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCQoIxtbdOdsWEGdL/FGVY0UNK850HHF6oDbJyO0hrqh/IvKvDirA167IG7BcZO3WlhOaLWiV082bYEbVA3O7OkAFnCMUsfPLmioQQMJL8vJIFMQjiFJ77GTgI0hUupekcKuWDYJvC8W/VHVUQnU/Q5hXMVvsT69VbDOZs6DrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjD8Tzp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjD8Tzp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A557D1F00A3A;
	Tue,  4 Aug 2026 19:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873377;
	bh=3yZYJRCfMDpe4JZ4kK/3Y1LRKbNI2W4nldNBENcT8No=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cjD8Tzp0YeuXOaYgSMEswXBdgub5QkM6bMQqpDydXcp9eRQ76HtopfOIbz0YftmIe
	 /Ho+AYKrXDixW3XLOFwuuWypKFHG1vXrG94tN1WezjPLDLyk9GZAk/Od4euEVbpfbX
	 Ft5zcDlbWJTX1yg+8XwXE7TOoHa+gFZlrGnqmHJnSu1asRTqpTT7cNs7j/XqHZdsv8
	 pGk/dl9ZFY03DagPp3CZp6eIBN7QecJ6ZuDTrs1zQK3bbYy7CCw1ky+Fg/Xr9VCyKw
	 une/1BEmYG0OGeHuRHLA9jWNHJCEr0l4nN3hGDNhGgmHUq9pZSBXPXp5+L9BSnpO3e
	 pSC9SKo0tq0fA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 04 Aug 2026 21:55:26 +0200
Subject: [PATCH 3/4] can: dev: set IFF_ECHO when allocating echo skbs
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-automate_iff_echo_flag-v1-3-26f06ff0f8bc@kernel.org>
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
In-Reply-To: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=zBxMM+76iFZ3fU07pe5uoUvZ3c1Tn5Lufpt8BkEg0mA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlFzjekpM1DJ/mcUnw2u3Li7JLn1zXNj7MlT9yvYrxH5
 Ou9mhOfOyayMIhxMViKKbIsK+fkVugo9A479NcSZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqo1aGBkmKhpIHNU4q98elHahqnThNZNc8arv++XLj1r8tpZ6ea2O4b9TxU0fpje
 zm/sS7p7bf7rcx3H271cupS9fx2/tcjLvVWUDAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Drivers which request echo skb slots from alloc_candev() are expected to
use the generic CAN echo skb helpers and handle local echo themselves.
Such drivers also need to set IFF_ECHO to prevent PF_CAN from performing
fallback echo.

Set IFF_ECHO from alloc_candev_mqs() whenever echo_skb_max is non-zero.
This ties the flag to the generic echo skb allocation and avoids
requiring every driver to set it manually.

This also covers ucan as a side effect. That driver already requests
echo skb slots and uses can_put_echo_skb(), can_get_echo_skb(), and
can_free_echo_skb(), but forgot to set IFF_ECHO.

After this change, drivers which use the generic echo skb helpers have
one less thing to remember during netdevice setup. Update the CAN
documentation accordingly.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 Documentation/networking/can.rst | 5 ++++-
 drivers/net/can/dev/dev.c        | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index fbd0d501ea4e..bf3d8dc193a7 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1124,7 +1124,10 @@ As described in :ref:`socketcan-local-loopback1` the CAN network device driver s
 support a local loopback functionality similar to the local echo
 e.g. of tty devices. In this case the driver flag IFF_ECHO has to be
 set to prevent the PF_CAN core from locally echoing sent frames
-(aka loopback) as fallback solution::
+(aka loopback) as fallback solution. For CAN drivers which request
+echo skb slots through ``alloc_candev()`` or ``alloc_candev_mqs()``,
+the framework sets ``IFF_ECHO`` automatically. The other drivers need
+to set it manually::
 
     dev->flags |= IFF_ECHO;
 
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..7089ce871b24 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -338,6 +338,7 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 		priv->echo_skb_max = echo_skb_max;
 		priv->echo_skb = (void *)priv +
 			(size - echo_skb_max * sizeof(struct sk_buff *));
+		dev->flags |= IFF_ECHO;
 	}
 
 	priv->state = CAN_STATE_STOPPED;

-- 
2.54.0

