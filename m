Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4767E3C1D7A;
	Fri, 31 Jul 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486247; cv=none; b=PuRjDMm2usoFSJkMa/h5dD9SaoJU/nCJWTvnNJiysrJDo3DzWCLu61GWfcgOllJxNh3t2yTK48nQe/DqZ62x7k6bod0M2HrJtlbqrEGQy2CBPgtRv4fWHM38Ga3l2yA+Zpsrw1Rn1kl3i4AEsSDlngrxPfWqF3Bj6q7yp18Xgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486247; c=relaxed/simple;
	bh=QxtGHWSEdJJDp7ceoeQsFQx2T78CjRoqywbydWaZEeQ=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=qzLGaK6olboGuvkPVE4HOEXqLta82TIwvo16asZYi+TpEw9WU7qtJZox1f6COugdHClS+ItLYMhxI23ZjwME9O0JiCj/J1U0HTFn2wnOr7pNm3xeMb3qPP3KPxXhl+fd5aARP9TJhUd3u/lTVvjXBwTc2m/wxLBhAqgTAPZEuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xDZ+1Rv9; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xDZ+1Rv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785486240; bh=N+AG2d2FifpI6lXWGWfSS0SbgO+ZXq4Z8yrjrEOPY/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=xDZ+1Rv9MeXhS2U6IGs/KzY6kcSNHPK3Yrzc0Z9wwGIXqQns79PWK4UO8OEYhst8L
	 ZgNDc/+HQLB+vwAaNdSH8m8vZsT7mdvwpNIqwT1uEjbX7MX9clGZ3fHid+ZCahROEh
	 eA1yLCF0N83y5ymF03JrJrzcTGX9vfMRRRez/fpI=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 5F91AC69; Fri, 31 Jul 2026 16:23:57 +0800
X-QQ-mid: xmsmtpt1785486238tecl4dbm1
Message-ID: <tencent_3315CDBC0C4402D18844C03C62B01F7ED306@qq.com>
X-QQ-XMAILINFO: NX3IH4pixvQAJ/a0T/cz+LQ/ir5QtNhszblYtiny4qe98c6V6BLJGmT3Vrnl6/
	 ZqVX95FKjjIy5WAu+jiby9fhIela+bXc8EhC87BMADfDAE14YIKqcX5o3pwcsVfJf5CND/qxx/rR
	 GKdsRTfpt0DgebzNfHCHm4P+Mrjbz27JF3h/6HiMO6+EU9KbbV+F19mZvL+hfty1OBsAn4pkWjNs
	 O7LcfFw6KxEA8sLR+MvwtWWXxNNGsvK2LJ2T7YGS3Fg0kyIf5ABCGqvJCGrfmQNzZSgG43qCyNOJ
	 o6a0gIOUqN2l2kSXEcEb7Tw/0eZSLL+ygHbaBQ6PftJpqSrEx6Gf1cmy+MBLGrbo/s4t5lDHBCR+
	 SlGaWwY2ToDdc5rGsBzlowuUJrdYXP9+NRn30KWVHOMi2kiKYeESPrmdxClb4yYsX0so1QuwSfJU
	 6XAbc8G+irpuoEWR5KTKDR9vqIlslMX1KoKNw4TSlliJcFrK60bRIW1/bHw0gQ7L4aplmdJfjCL7
	 Yq5aLglVqmr44LB/9vwUXYrdCbWVcQeHAmCFuI1jA9UHtGLNt2EN/8xvaUhgH8Mu1vH6xPKDU2hl
	 jZrCTGPIvSWGC3hhqCjS/hBAdRWJ6oqRtl3TBIVIO9XCoiaSeYwtvV84IltNI0QVbCzkUBdwv6Iz
	 MC6KxgMkGzIS3h4fwAaTgKNmGThnd7XqwJ2Bo3zTJUMay+Byaqi9Vd5SjxrKTUwsXTbHzXF4mVb+
	 OHC6mz7xysVEkqrejMvLuKDOsv/i+U7HzdYpmenQzV0j6gvHcI8ZoCQgvgS4k+KsQrnaCdEEOtRh
	 fvUXCWxMMuMrg3Q8UyiKSnertE4P9G6MbrI8na/2Wx9lkfRMdorMw1QCZDbulnXhDXrNHgTfvT5v
	 h28hVWolIv2bg7VHV/eaOivoBxY9guMCOU+cHxVBsuZZatT8tnuigEwFYwTu9Zxrfv3FIBIkkL1I
	 wEEIQO9KQHCf+XBBEnbFbKP0vlnq3VQiHInRhsuuobyAeyhWh1Op5YTH4wTUJKe5oMnGhf0Qg/aP
	 o5a3gd7ilTFGhWI+y1uSzWYjGNm9quxVNflYmAWjwr1UQPPiMQHgnJ2ycfDPQelyhh631mKwKPMC
	 y+wqYfmdpKOZ+sMec=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 16:23:53 +0800
Subject: [PATCH v2 1/2] can: dev: can_put_echo_skb(): use
 dev_kfree_skb_any()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v2-1-204d772f2e36@qq.com>
References: <20260731-master-v2-0-204d772f2e36@qq.com>
In-Reply-To: <20260731-master-v2-0-204d772f2e36@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

can_put_echo_skb() is a public helper used by CAN drivers, so its callers
do not have a guaranteed IRQ context.  kfree_skb() cannot be called from
hardware interrupt context or with hardware interrupts disabled.

Use dev_kfree_skb_any() for the existing skb drop paths so that they are
safe regardless of the caller's IRQ context.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/dev/skb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 95fcdc1026f8..d7b5a5d17ff2 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -62,7 +62,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	    (skb->protocol != htons(ETH_P_CAN) &&
 	     skb->protocol != htons(ETH_P_CANFD) &&
 	     skb->protocol != htons(ETH_P_CANXL))) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return 0;
 	}
 
@@ -90,7 +90,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		/* locking problem with netif_stop_queue() ?? */
 		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return -EBUSY;
 	}
 

-- 
2.34.1

