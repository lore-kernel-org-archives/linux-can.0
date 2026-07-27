Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03C3DDB1E
	for <linux-can@vger.kernel.org>; Mon, 27 Jul 2026 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141529; cv=none; b=Wdh/MQru2/HSVi/fpwuIvNZOzxNsB3j8pYejOX0tTAGGtuA9fwLJeLpaLVF6E1Y2rrUwHd0Lfpna9NCrBdM16HQdcn67NoRo6rx2Am1gQecK5HYAoLjaDxwYUTehAZhd8F+Liuta9uiMamftQzO9JcSHrmbHAXoUgYrsyADz7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141529; c=relaxed/simple;
	bh=W6FrXsh9s/8l/JhhIJScPW4N6ImngJ8og0oYLvuLR1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMP0ywBm/PFtWi4u82UevEHzFlGdxRHHOVz2dz1MJUpeVb3E94XpueFCakJp2HFOMtDpo1KV6BuagjlGEadkTSnH1NJMmaldFUxXryGYlrDfVlKPj2Res3j15OpnmmZ9hQzjZGZbNPfIcmwpXAbxexXET4v8XZQYfWiZYjdvYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eID9RiKR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eID9RiKR"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e0688b859so1372029b3a.0
        for <linux-can@vger.kernel.org>; Mon, 27 Jul 2026 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785141527; x=1785746327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rq//a2+g1++ptwBRb4eMsVp2qBHE3j2AbugIHLKYR+E=;
        b=eID9RiKRds5VwGhrv+rygZITRjEjlcYp9JCKm6U/MS6aKREsB8/JqGVngCLBsHgO3a
         3IjWN2J+aOhMetuxHYQx4Cl3adqw4Q086tSGKQBzIgfwloh1bFP3Vdw8JAg3z66/zBHZ
         VmfwNVeOtBmnwwB1Q3ww3DkWQX74eUZ0l3BFcDkEjjM11KhnV9DPnh1BGk2OxyRTpbKu
         dctvcb2UW/71W6CzvKsNGI1vzXDuAy7Vup4SPY1ng9KjMa85+HuPLeRhYGoulaOEQoeZ
         HNPFdMwZyJd1ohr71sH0EmP+pS75TbU6hRPWy88VU12SaStNEVvd20SU72bUKWJ4g83o
         tZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785141527; x=1785746327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rq//a2+g1++ptwBRb4eMsVp2qBHE3j2AbugIHLKYR+E=;
        b=JeOcubNnGBVgG54MBlJtfzYFjy6mVSIRaE4LelBbF5n7HBzBbPNiGpjUS7T+2u8rgI
         dQn0QojIdhTL60EE2g9QJ/iV0Uri3/fCOXOION8uaH7M0RJub1siyayDP02GE/vS027+
         60jzZ/0g5LuCfl5subeUJnLiUEJ25FUEilsvwx+4YsoPiZtdwpIra1TBvEuF5ByNaH8y
         BP33dT/Da3jpZMG56U0s6fmc8FWMpb0y6r8MwgY1wdVdk9h650VwexochV/hdnwSO6gI
         cMSdl2Ebe1AdSBesPA/aStvY6KYQQDEAlXFCPMCp2ZvdmyXrEKQ7CVd+wgHUw+9o37cU
         5ouQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro00m/jSxcTexamvOmULyEx8nzGlnmABiss7jSk6tvZNUnWWBYrba9/+Vlv8g2IDWlqtBK5ClJJb24=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjSNtDOp1nsWtXsyKvnFidVUtUprbxG6km6NNbo0M+wbRnm3C
	/aKOsNCXk+cSS6HRZ04htQf5JyXB3jxk5/faJK34ywc7cN/7ydNII4qv
X-Gm-Gg: AR+sD13nIJktho6Wlzf7hCkUp0pRvRCn7L8VhROrdsZTQJTuAnOdV+MTXg0hdspF0el
	0i8wVMixfQYSZrK36F724mFSZZSjatKDupwfP+vkCRx426GAuX1+/KAX0bKdVDbV8ea8+9hhIQ4
	idJ1PxYiCi8f5rlHtdYlr+hlwjzgYMllr98w3EARlicE1U8BfzcDVs3VolibuYmNAGk6jSaAWNu
	i9Nld3Vs9Zyhgvk6f8SxvUKM1brg7C5rTFbDkudwYeXeALyeRNeBAraSZLXZ7EMTh3Ryanx/Dsp
	xFzi/tVy4gSOs692mCi9Rp6HgI+64buQ/RNZ/HmgH6U4Rd2ZPFY9xnBUz8vrCrL5DOYSuoKuANT
	aN8RDyLd2w5SyXx4bJLJJqr1g5Yj6Tn9h/H2CTqP7XknvRs2yQz6g85U20x2MwCyo/qOmAa6HoP
	7YiyKD
X-Received: by 2002:a05:6a00:981:b0:847:5ec4:9a1d with SMTP id d2e1a72fcca58-84e5958371cmr5655774b3a.62.1785141527264;
        Mon, 27 Jul 2026 01:38:47 -0700 (PDT)
Received: from kali ([42.112.41.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f54esm2644997b3a.20.2026.07.27.01.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:38:46 -0700 (PDT)
From: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
Subject: [PATCH net] can: bcm: add missing synchronize_rcu() in bcm_delete_rx_op()
Date: Mon, 27 Jul 2026 04:37:50 -0400
Message-ID: <20260727083750.2057304-1-nguyenlethanhtung555@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm_delete_rx_op(), reachable from an unprivileged user via an RX_DELETE
bcm_msg_head, unregisters the CAN rx handler and then immediately calls
bcm_remove_op(), which cancels op->timer and frees the op via call_rcu():

	can_rx_unregister(..., bcm_rx_handler, op);
	list_del_rcu(&op->list);
	bcm_remove_op(op);		/* hrtimer_cancel() + call_rcu() */

bcm_rx_handler() runs in an RCU read-side critical section and re-arms
op->timer on frame reception via bcm_rx_starttimer(). A handler that is
already in flight on another CPU when RX_DELETE is processed can be past
its RX_NO_AUTOTIMER check -- a plain, unordered u32 store set a few lines
earlier in bcm_delete_rx_op() -- and re-arm the timer after bcm_remove_op()
has cancelled it. The op is then freed after the grace period with its
hrtimer still enqueued, so the timer fires on freed memory in the timer
softirq: an out-of-bounds access that can crash the machine or disclose
adjacent kernel memory. AF_CAN BCM sockets are reachable in a user +
network namespace (e.g. over a vcan interface), so this is triggerable
by an unprivileged local user.

commit d5f9023fa61e ("can: bcm: delay release of struct bcm_op after
synchronize_rcu()") fixed exactly this race for the socket teardown path
in bcm_release(), by draining in-flight handlers with synchronize_rcu()
between can_rx_unregister() and bcm_remove_op(), but the RX_DELETE path in
bcm_delete_rx_op() was left unchanged and still has the race.

Add the same synchronize_rcu() to bcm_delete_rx_op() so that no
bcm_rx_handler() can be running -- and thus re-arm the timer -- once
bcm_remove_op() cancels it and frees the op. bcm_delete_rx_op() is only
called from bcm_sendmsg() under lock_sock() in process context, so
sleeping in synchronize_rcu() is safe here, exactly as it already is in
bcm_release().

Fixes: d5f9023fa61e ("can: bcm: delay release of struct bcm_op after synchronize_rcu()")
Signed-off-by: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
---
 net/can/bcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 75653584f..25f868530 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -822,6 +822,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 						  bcm_rx_handler, op);
 
 			list_del_rcu(&op->list);
+
+			/* wait for any in-flight bcm_rx_handler() to finish so a
+			 * concurrent frame reception cannot re-arm op->timer after
+			 * bcm_remove_op() has cancelled it and the op is freed
+			 * (same drain as the bcm_release() teardown path).
+			 */
+			synchronize_rcu();
+
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
-- 
2.34.1

