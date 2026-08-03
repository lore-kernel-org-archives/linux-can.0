Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE53D47A7
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748501; cv=none; b=KctoOmJXNpez+bD0XP4QfkxOky4uuFA8NE8ExEMKP8+q8nR3gmV4RIAWEDxoIapUI1rvD0pWPKgHWMsH5UZDpZjGYIG1LoXEhOsPNa4Yd2TCbCq+LqCk+CAW2X0LLnsLQd3nA1X0kHsXtrIZTurpDAJKue5h532E4tOEzGv0dGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748501; c=relaxed/simple;
	bh=zcETIkLM8Cmdv8MV4Tk1OnRX5GmudwzCo/xVqqn0IWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3ukT+Ed+5UBNsDJGcEqKY4SxzdaWRKp8GhKlVs4xczlgQSdSDc0sORum4NSZn2WU6MMgdw0y4S5pucUp+U17FdV4UVECaWy8LWAGrAWQo35CUnG8xS8fak/zZt+V+HWYq+/A+A2JOtdzysgofC3pywJeI+5vIdWMyAr2xWUEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exFtZPS1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exFtZPS1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cedda2ce6fso25617685ad.1
        for <linux-can@vger.kernel.org>; Mon, 03 Aug 2026 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785748500; x=1786353300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvun/rb+CpTslltyPoabb5PRPEjc9oqIPsRzwfjh80Q=;
        b=exFtZPS1A8VyfqtbwdRaWaKJyRK35e3j6u/JuekVuVRgdPziOngRl91E0ivfkOBZ6p
         yjcNcmvHByaRpYZDdMN5m8yZ3klf5u+y27xg7elSAxZKFujEbn8PAl0Q2MK1O3E9zDLg
         fcYhqylaK+fQdmQPzuQeRsN97yTPWeUnNrJuzvhvAJ3M0VV7ila9D+JoTj/ShSj8GSTD
         eCpdmAozPP3XtTcPOFF9q0Z8Jagb038wshU2Kkvj4NRGuZLejmOAJ8Dz6X+o0e10D0cX
         jtL5km7H1HEEFQUGCiZVBHhAisrgzfBZsBxDgxhH7/KO3FUbaj25LOpsqseh+XD2oRz2
         d8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785748500; x=1786353300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvun/rb+CpTslltyPoabb5PRPEjc9oqIPsRzwfjh80Q=;
        b=gnXO8U83er6hU1fyIymG77KVuvITU+2HqT9ptX7kGiGGTPEEPK1zWUFfYh3+WhmfG8
         8O6MigBmUB60e2UbmIX+Kz0Am7ssJFrXIfWX+M9eDUYPhdrgxEOGmDhAOlmPP9Z3R89n
         A6tnav+++5uTmTen55CnB7PY23XEBnTW0c+W7Q4RDa7ITLvJoLNi+wQSdUGBTKQA0bHP
         QmKRyJNPumDTCkqdArWdUkZ9eRUnKWXPxUqEMRxB3KXHdpsH7oN4BPHAkVTzJ2qSIrWx
         vudOrbstf4u3NKc7GcvhdKZARe0DYAj7IVSlq4iH/TnDA1zdcsr+QxSFiZDYeATA8hu8
         gdAA==
X-Forwarded-Encrypted: i=1; AHgh+RoMC5dkFWMAK9eSTDPvz6H1gV/1zvMaIhQQnpTKrhZk596dCvw0Xf/dO59ylzgyx+G4gCwSzvzi3iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2jB58PvLDouZ+PkIHhLSKUCVG/2zUAS8ek6zO+rb4/6bLClg
	1/Ew5LwAfuIkvj4HLX4cnFFhmLNRlvpFhxKLtA+6vLSLsga2Q2bAj185
X-Gm-Gg: AR+sD13wT+6ZFF66ORbcd991QIEtSI+ihFEM/tzbMUAs/5/CHc0II1guWYwNFvqj7RP
	8JkHD8VHwRMAbmcqx9agcHzi5CnwTCYw9Beu76nnmB7ebywR7UsGtnLArQptWXdgdBL4beSNAIO
	MAZlIDCZZmouSJSqpOxqhnj4BWGYxw/8anzpZsgXm35Oq+z2HspAWpLgJimCoyiEuSjcs1cU/yL
	riaIoTmP80pVrRcZ1+4+uFGZeNyl9MovN1aJbA1t0SUIToAeOPtdPHgGd/Ei34s7VcWFRw5lGT6
	WAEQnuxPYMbh5O7OfpybGVpTmr41EjlMNLHv2rziU5+LzM02iitBelqYO43FYENfCzJRPAAHa6e
	04SFbxx162fAxeYqBr8HMEbvcH9LVJ+g5T2ldtjbm8erFH1gSO1YpngKfQlSl6xTP8bC1vtaTdJ
	DdGXmyxLjfKL62STkI9Cgpenev7AVkl1k/HIRzB8tNlNw6mKG1lNFiL0wduo8pf0Pt4awHahdn2
	hFtJu7nvRaQgnaLwq/5nqC+vlVQAptBY9ZbIerWydecIoB30yFzxA==
X-Received: by 2002:a17:902:da90:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2d0521e8b31mr82117175ad.5.1785748499595;
        Mon, 03 Aug 2026 02:14:59 -0700 (PDT)
Received: from C-PF5A3Z8J.nsn-intra.net ([167.103.78.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb7b7sm34546515ad.39.2026.08.03.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:14:59 -0700 (PDT)
From: Sureshkumar S <ssureshmsd7@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sureshkumar S <ssureshmsd7@gmail.com>
Subject: [PATCH net 2/2] can: bittiming: fix bitrate error calculation on unsigned operands
Date: Mon,  3 Aug 2026 09:14:26 +0000
Message-ID: <20260803091426.29050-3-ssureshmsd7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803091426.29050-1-ssureshmsd7@gmail.com>
References: <20260803091426.29050-1-ssureshmsd7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_calc_bittiming() rates each candidate against the requested bitrate
with:

	bitrate_error = abs(bt->bitrate - bitrate);

Both operands are unsigned int, so the subtraction wraps instead of
becoming negative, and abs() resolves an unsigned int argument to its
int branch. A wrapped difference is therefore reinterpreted as a small
positive value instead of the large error it actually represents.

A requested bitrate far above anything the controller can reach then
passes the CAN_CALC_MAX_ERROR gate. On a dummy_can device with a 160 MHz
clock, requesting 4294967294 bps reports an error of 0.01%, configures
415584 bps and returns success to userspace, where -EINVAL is expected.

Use abs_diff(), which subtracts the smaller operand from the larger one
and keeps the whole comparison unsigned.

Fixes: 7da29f97d6c8 ("can: dev: can-calc-bit-timing(): better sample point calculation")
Signed-off-by: Sureshkumar S <ssureshmsd7@gmail.com>
---
 drivers/net/can/dev/calc_bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 4809f5e0c96e..2789b99ab6a8 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -132,7 +132,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 			continue;
 
 		bitrate = priv->clock.freq / (brp * tsegall);
-		bitrate_error = abs(bt->bitrate - bitrate);
+		bitrate_error = abs_diff(bt->bitrate, bitrate);
 
 		/* tseg brp biterror */
 		if (bitrate_error > best_bitrate_error)
-- 
2.43.0

