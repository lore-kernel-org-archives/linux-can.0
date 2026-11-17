Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911726;
	b=aqd+DBXxdZ3qeM4m3AZqbIApSjHAr/NgrAA7lo1mqfqJ4bmkTbHftPn+wD2WQZyDzCqt
	 A8oNBtVbzX90y0FP8mew0JWbljEmPMNH3Csl7NjRaYi1GyQ0Ij475LtZ2v/RKp+vhaxoD
	 2kc5bSAtqZsh77wmpHhqMm9LGasZcbGWt3b/swLHVcYi+JLJgSYbOq5g/Nvc6f4bBVAzr
	 hYL0G4ph7KuQA/pGObet57qBig/u7zsl458Id02rmk4dNxnVIYi1UpuIrnzgOYdfmLHWZ
	 ZMYWTkGJICGyGfCBEv8JNZHI9zeURi/pQgCd/J8JWX6g69iiNVFH1ynrJ41iiToYSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RuyZ4/NgPAofSNXbBjGZkZZB9QA0/aMDca1cWrs9WFg=;
	b=FupvOz8rcR0w86oKpdVuBlMjkKFzr5bRd7jGsK/z0qf1ZbGEY0m5N3K0jKS7FHVQsFy2
	 SYSTizJgdgfmb/xQjzT8UCLo+E1EtFXKlkmt5R4fMREukSp7N6AiHqGAV17Ut0YVtcg4H
	 pYfP4DwlS/3LCeiZoDOnn6XeWI3GPHbgdUs+h7tcoYzGz/dMYZVKjCE5dNaW7QJGGyo8P
	 me6aaBy+5oVpxshldMtDcRpFrNAqrbZ2/ZnVvBqjx6PcSzsZr4srWFtUdMHk4Z18aWPx4
	 h9WuySZF//a97Nv8LzwflKJSHiROAdgpVGzYZXT4xZdmaRvJnvjzWOZsjjQIjWUABeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RvFXG8Wj;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9646D606A899
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 10:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9646D606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RvFXG8Wj
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb2893531bso3207870a12.1
        for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 02:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794911725; x=1795516525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RuyZ4/NgPAofSNXbBjGZkZZB9QA0/aMDca1cWrs9WFg=;
        b=RvFXG8WjjKnTMy0oENVxlESIdVeF6WKEdiNDXunqUUCkkvQvKrb1EXZV9xmGB08fS3
         GKBazE4QO+VsYoH2bZHPTRAvxGv4vB31iiEM/JNLZ+0ti7GUimE9nOHnUyWU5J+oxavn
         Usr7arx6vVCNPU0a0O/knm5dDC0CPAlKkRY+lI4/OwzgM+9n7B61/hvjrn9xMv/3vf41
         MaBmT7CMkPOuR1+8iWIJEUqhi1dzJ4sKDGGwtXG7WmbGSjsvwMs5u+yaDQ6lUdy31rP6
         SPBda7tpj6zYniwGPOHetVokVPwpScwCsEiYqFE0y6oRJCAuK3KxHcP9sXQUmXeWuTBZ
         3neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911725; x=1795516525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuyZ4/NgPAofSNXbBjGZkZZB9QA0/aMDca1cWrs9WFg=;
        b=lpv35l4He37KoU9ksM+aKEGbXRzfzkYx0NOfTo4UqMnVDRqCmvNyKGeB1yNWkuq6Bh
         ER5zANubkT6VsIKHUTZWyTzLJd2KFBMRyxxVcWzdYgSh1a1HzVOD8cXsb+2/z16995WX
         wMp6FGoQffKpgYiqoLMDQujb/OYhUoDOSR3OVlZRLHchFxFnof3M5VsWgn1/TKIN+Azg
         /zZgN5amFKIE77ZnCxZ3AgIv9pZiMaYI1dU0r5aUqS7cwW9HZq/o0iTkIsvaP2KI5mid
         BTey5WULa9UaDUyXRT5HcKQB3KVmDmFJBzV/Et00NcMuWbFrBjpoJuw7/YMhmCG4E0iE
         WGBw==
X-Forwarded-Encrypted: i=1; AL+hErFue2cH1RbYvcbpTOypeYdQmq2w0ywoATzECZQmt5Du7SwpoDcc6SoWBYVmPSt6z2NNNgzYvmVbrRU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LasIlxoK78VTWUTvb1H4GAO0JshnVqEnebVegbK9sODBkUuBZ
	KS/o4uW1emh0LLzcHVNtC/qtAk0zbPSIpfKpYga8a3ZkeMxhI36BKDci
X-Gm-Gg: AZFdTZdxTEfnOL6HTSTSSnbU8/l4mmqsocSyxOI7fKPDPeiMkjq0X+QGD/PL84Kvt37
	XeCZznsXUc3dyByCWOeH0b/6wKOzAKWd+Zgq008WvkjGAG6Gny9nScqEWMYljwF5ozkMMvgVr/x
	DMzrKat2Yzhe6gZU81X0fURU4tAOUFuCjkHHZdLZj8tZDNKXkEDkt3UrHhu993iUIfbroDP9+15
	EkOBRzecAVR8XviUkQ5L1e/FzlXAaoqlv1nVmXkB82oUbpH6ee/3UNyq/1BxCfOu/7Umkpy/m43
	yvzuw/9kMNd6pQk/JNjJLNiyFZBVATTFSSyqSVu7s3DmbeMY/qHFwy0seT5QQK3r4hIW2dpzyQB
	JLu7eoXnQ6GnaLrxOKnY5xcFKZRGDeNvE3rpczMDesmEYdekmsAo8lx1k2oDTHD5iXnXG6uCQlH
	2OD4+Uw/8BLLk/fRV2kgMElQDOD39B3VJqIBJyO6n5CkUt70xeki0zqfVtwf12xLtvx3jSzhtW3
	hleT/stRF8CPCGvnBUBQ8+wjSKsvvfigXOlN+rrsOge054SO69pvplDvFoW/hl8e/9iKRXj/FgU
	QcTii+YzVnjWAau6v0NF/+n3sKzDVI9QwbzM4f7JmVBy
X-Received: by 2002:a17:90b:1f86:b0:3ac:7556:8ee0 with SMTP id 98e67ed59e1d1-3b1b0b666c5mr13803607a91.19.1794911724811;
        Tue, 17 Nov 2026 02:35:24 -0800 (PST)
Received: from gmail.com ([116.162.234.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abeaf532sm3518806a91.14.2026.11.17.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:35:24 -0800 (PST)
From: Xue Boyang <fuchen.dust@gmail.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] can: j1939: fix null-ptr-deref in j1939_session_completed()
Date: Tue, 17 Nov 2026 04:35:15 -0600
Message-ID: <20261117103516.535910-1-fuchen.dust@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_session_completed() looks up the receive skb using the session's
current data packet offset and passes the result to j1939_sk_recv()
without checking it. If no queued skb covers that offset, the lookup
returns NULL and receive-side processing can dereference it.

An inconsistent ETP session offset can leave the receive buffer lookup
unsatisfied when the session completes. The DPO receive path does not
validate the offset against the receive buffer, so completion cannot
assume that the lookup always succeeds.

Check the returned skb before distributing the message and releasing
the lookup reference. Keep session deactivation and activation of the
next queued session unconditional, so a missing receive buffer does
not leave the completed session active. This also matches the NULL
handling already used by j1939_simple_txnext().

AI assistance was used to analyze the bug and prepare this patch.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Xue Boyang <fuchen.dust@gmail.com>
---

Notes (j1939-null-submit):
    Based on mainline commit 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4.
    The affected transport.c and socket.c are unchanged from the original
    local report baseline daf677c2c6449011ee695d55b48b5b2977a36f88.
    
    Validation:
    - Built net/can/j1939/ with W=1 on x86_64, CONFIG_CAN_J1939=m,
      CONFIG_KASAN=y and CONFIG_WERROR=y; no build warnings or errors.
    - A temporary userspace harness executed the extracted completion
      function with stubbed dependencies. It checked missing-buffer receive,
      normal receive reference balancing, and transmit completion. The old
      function passed NULL to the delivery stub; the patched function did
      not, while retaining the completion-helper call.
    - This revision has not been boot-tested or run against a CAN interface.
      The harness is not an end-to-end kernel regression test.
    
    AI assistance (OpenAI coding assistant) was used for source analysis,
    commit-message preparation, and build and isolated-function checks.
    No packet-level reproducer or triggering sequence is included.

 net/can/j1939/transport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f8..ecf7f245f8378 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1244,8 +1244,10 @@ static void j1939_session_completed(struct j1939_session *session)
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
 		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
