Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1E37AA6D
	for <linux-can@vger.kernel.org>; Sat, 19 Sep 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853800; cv=none; b=vEL6FWQ0UNKnhCARn4Z+7LaBUlDDBSSMrBn8o7hnw2UXa5zrz1f2aXaqT9TFfOOz7ndmfOBy0RgFR+BOHSr0faLhn0o4DJnAFjOhoqAynWhUPUAk4w16IPEt/bC2o7pHsouTQRJLQNK0fI9OZYVyuC2DoUAYxOqWqu4T75QFhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853800; c=relaxed/simple;
	bh=6bizVIdgIj1fNJLVf+eOfVtpiCc+m0cvPAZP03MoOZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGVgcorhrep3EM6rPBB2Z5XCdIJcBOU3NEhrAtwETwqPSauUcMWvY9zmHK5vvPUzWJyLL47hC6HXuCjkcPaJ98TCQbrKv96EzOfI9cj+4NY/VtAg220Bzf4FSiz2XgT3u6StP7Wru2ZKXkDl8wyA0USEKv7sTYXWvD9pPKSKrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqm5eufv; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqm5eufv"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1454013a91.3
        for <linux-can@vger.kernel.org>; Sat, 19 Sep 2026 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853794; x=1790458594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YDLB5spO9G86KxxkAWQZpWYmhLuhLdNenkp/2zmUocU=;
        b=Fqm5eufviFjPOlyEF+t4FkaNGnoLfTtaMaEuK1miUGPdubQElGchhbM1f/ux4FtXnc
         UH7Uh8Ea8pue9b6AhYMuHQni3rpcKoS9bwD4stA6WlTYZveD7oMQaZnK24FpcJIvlPdw
         rUtXnKLm5WgtxFGxCn4aXPPq20djI2dzjp9som1j8qD0NmzW8K7PUfnxlXpC19DtfWf4
         2vDcloNjWUnmJ4oVKatKPFBrjT7y3x6VbHCE+rWN/TONPgh0B1a3SiNwpWFTVvojJ2cf
         KdsdJwwUP6zG1RMQ9n7nBqpvjmPE15PJa4nuDuCpHkgmBt1sQ93rsw0R9N5Kqgtekj3O
         4gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853794; x=1790458594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDLB5spO9G86KxxkAWQZpWYmhLuhLdNenkp/2zmUocU=;
        b=yfNvItaUghu7Sage9gXfwYweSeFZ2eCQlC/P6VZx8sqLdvXK2ivcQB0MV/2OnYycO4
         qbptxkHBbIJyYv//uaJEjN+sPd+vkCONg9owwj9n0knc3Ag1g56DZvBw0UzMyeWkMpKc
         3IdUTcmI9RzEX+aimXwc0t+aOpgyyHXF+bsrEwQaMixB5AdfIJniuPzeIwLBRUKPJWwi
         xUICjyOO86brUgRqPn6onPplPyArvhLP51QDnVb3iLBUug/z9AAqYvPJf/jhuSf7Dj2/
         ZDbbeGKAD9Y/9hVbCA5vE3NZ/7uYYxZNQ+h/6Pp2FQkchj7MVOplEhEg3I6dHbaKY0LS
         zRSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRU8XqT0JLB7hFUG5xIcNYF72H7N/ZAKZYDNNJj03O5kn1HY/J2HbJy3sb/Yw8L1CivBzR1ZVA3zk=@vger.kernel.org
X-Gm-Message-State: AFuF++mC3w+lVmoBi7ARjive2DUUut9zvtpFdvlZpqJ0uM8fIJ532uSt
	BxtjZkS8FcEU4e3GKeHbmfXCSwU/3/H5Jyv4D1kn6K2fEIMlOF+WZDR/
X-Gm-Gg: AYBFou3+ebRSDsdraK/VauNU7QjwrU+YcD3BkTH5aVIQaZT6Xjs/amHflAhQVj+DSNr
	pgH0Cl7VNJoyZM00tcrsDFtYEEdVgO8OkRfuv8JjUr/DKh0tEC3ApcL9iO3P7zSEyTlsLiHDVWt
	9qhIz/cO934WpKJYK4xECFHcHYtbxg3dv/3ZaBaEIi15oLjOMW0lDYL78Bl24djbfFGhseRG32O
	5BRnpggTboMc4qGpG6Gd3uWKB72DHwHAbbwfEBBGmrAujJGnJ09MJE+OQJInvgVN6rhYzv1BFlI
	3ss9UqiLJ3LGeQlMUPYhJ/r0zPdJHUTB1ZlBbFDwgvftcpU8vQmbFTKUY7hXYDFMcRZSguGNvX3
	1h2M1ChpiiiHuvCYs8v1g0Eqcb4YTvYWBKu6Qt0NcczosFzBpHkldBvmIKOf7dZx4bNJQ69TNby
	tNiRnl5s7ni7qcvqLLoeOSi8AOr4Gezmpk59W9VS80wFVzjenYDCbrwBrBOw3p0IBsfg/RSRYdu
	MrOMjeVC16EYmCwzGCXHT7V0UWGAilh1oUvPuO/qbkpQGP/UlnnJ5vYxzrYdjjETMIiyimK/PxO
	lMlcm39yrQ==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b6d with SMTP id 98e67ed59e1d1-39e6c6a550dmr4317444a91.55.1789853793981;
        Sat, 19 Sep 2026 14:36:33 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ed362c71csm2147955a91.2.2026.09.19.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:33 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kernel@pengutronix.de,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: j1939: return 0 instead of user value in j1939_sk_setsockopt_flag()
Date: Sat, 19 Sep 2026 21:36:32 +0000
Message-ID: <20260919213632.3313825-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `j1939_sk_setsockopt_flag()`, after copying the integer option value
`tmp` from userspace and updating `jsk->state`, the function returns
`tmp` instead of `0`.

If a caller passes a negative integer (e.g., `-1`) to enable
`SO_J1939_BROADCAST` or `SO_J1939_PROMISC`, `if (tmp)` sets `jsk->state
|= flag` and then returns the negative value as an error code from
`setsockopt()`. If a caller passes a positive non-zero integer (e.g.,
`1`), `setsockopt()` violates POSIX by returning `1` instead of `0`.

Return `0` on success in `j1939_sk_setsockopt_flag()`.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/can/j1939/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..1d4af472de4a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -688,7 +688,7 @@ static int j1939_sk_setsockopt_flag(struct j1939_sock *jsk, sockptr_t optval,
 	else
 		jsk->state &= ~flag;
 	release_sock(&jsk->sk);
-	return tmp;
+	return 0;
 }
 
 static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
-- 
2.55.0.1082.g2b9226bbc0-goog

