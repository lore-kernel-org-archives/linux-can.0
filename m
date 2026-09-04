Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F244C518
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526225; cv=none; b=GOF7NTWns9rHhZmDWfvZ2ZPwxVkmoj9W7wNph2yC2i60geYEhWbl6SBlHQdxUmXmA7gl3ijbJcKuACfNYCJ2/UULec/OWU06S24qHPfmWWoLD/wIvuiI9tmVPwJL/xt/wfsoDm/LGjUmZaHKQCQhdUHO2iEv/QFgAtHpeU91wNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526225; c=relaxed/simple;
	bh=kzV1iXtP7UtDveZ7IyU8zo7xuEhV1c18VrOxUsnFAWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULStNqdPpgWKKtJHI5gD9UtxwRTMdx6xKdVarw8Efy0MBq1RV5oJqpCQRZEQOzSQYCE4DxHBqPhrVSCGmpde1vrqjf5IIBng36FMt4BF18AJSkykuzmjzxOTnVKoN51L2r7AfoEToLzfAHGa4+rhV/fbETq+H7hvYobuLT4l2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKrbULKa; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKrbULKa"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc439aa0078so896175a12.0
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788526223; x=1789131023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcqQGyS46qOTlJfKUrPrj7k8qBeNjnYiNFT7DXi3c0s=;
        b=MKrbULKamkYC8Z53AcT3WYfld54RcUiGvdrOFMMV/jOXCpEj+V4RK0s6wUlf5+c+7G
         E2MU0DxfNX63dj0Gw65iPNZ4bg+sjgSCVFvrZ6JZ08Ij6G9M5CRR+kf/8ZtVAryIFtmq
         fLtyiCaCYA9Dz4pJnz2d8lkiSszjh4jfoaqTEWzOVtC1sPdghD29HUbx2MOEUcRdbLo2
         jssXi0ANo/jU3berYS/H4E/+8feUCxZE9kOlkvfdZqSbPRWbs/rltJuswL09+pyhRWzK
         jIC/RLm+fXrTpFgc7dKj82z1Bo64ZP7iROsVMOvZ0rZLkIjW5ZquxWAD02RtpQKTx1ij
         D93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788526223; x=1789131023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcqQGyS46qOTlJfKUrPrj7k8qBeNjnYiNFT7DXi3c0s=;
        b=hG+d4rhsNZfh2X9h73ZbF4Y8Hi7NGGWfTtqxzrKq9uv9sQ5oP1l95YhAz7qDmQbRDQ
         Dqq04DDE/tl58td9OzpY438NqzKS0X3MlgZYIzAHVIPo58RYmUqjeCzaAOHHdj8ZcEJ2
         8g8ECXtQsy0h9/yHtYlRp8ht1bolxylafkuAcMHphZlUJYFexcop/akE8ItICqR7Gzgm
         Om9IiZpjtqnCB3vHTsGdD7HwQkxfRBIWXKl0REkFimivzD71luIQZ+JMunTb4KuPqqZj
         I2npVX4kSc66PRiEk+1cugXuWExbcBi0NFvKqWGORtDr+8ol8hKinAmC+SYxeN0RWV8J
         zK7w==
X-Forwarded-Encrypted: i=1; AKwUvBzg1xasusvI0ZPsp/z7cccl8/oT2zUH3vtRynWixkltuJVh7J6ZEbwlRiCuqU3huZny5LRbyLSF4AU=@vger.kernel.org
X-Gm-Message-State: AFuF++lnxEv0mgKE12h1YfAePr14OijBSEeP99NH1GYnfBGZGk3LZGUp
	z1jT45p+BvQeHtxEwAUhhNmcM0vb23Y7YpwLHyA4sdzq304OjJiJ9QahHpVm3LHKZSQ=
X-Gm-Gg: AYBFou0XucFlt2SG5Wcz/C8x5DUZhSZ/6RPEcUEAkhfNQUqTvK8v5iaI032/pHuANg5
	T42vyppsLinKbGy5Hc7vZP+9cti4mm4XC97d+uWbmMM8KAlC6TmWmwGd0TTHQRNGTqC8X0JfmP7
	rQI+qmUBSh/OpkVHukir/sR0qo98JN2HlpPPeqRvSw7FNLnACR7myoF2OUc7tYsBNnBIZuKjPP/
	Xjl0F9wy22XV/uBEgXt/hl9NaUqcevq/OttiqV79yWRTrhMbP6TpYInTJsqIjV7wezC8FAatYfX
	xc0GBe93is2GFMLvzz1/trnyufg7pzNTfklKGQG8A79xxDAykGwIcV/OnZbZLvSQzIvjiU/OrIL
	/VUUWFiR/M9M38olGTBzPb2lnJglrh8+FdYpDQI4Rmvte8VUbYZcRkPnId43UlP4mCjo68Vscb7
	EXKHZ8ySoFl3lYOd12ja/3aLh+u+E7TmYnR+Zin+ZkJMHlARjG/SQl5xdBxjN9BRwaLaJcR2gNL
	p/cG2GXDKC+iUk=
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39b26273a40mr9704191a91.21.1788526223268;
        Fri, 04 Sep 2026 05:50:23 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm6705116eec.13.2026.09.04.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:50:22 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org
Subject: [PATCH] net: can: fix repeated word 'is' in comment
Date: Fri,  4 Sep 2026 18:20:17 +0530
Message-ID: <20260904125018.10923-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'is', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index f72e0644c5fd..6b088a05a901 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -61,7 +61,7 @@
  *    the following way:
  *
  *	m[n].len <=> the length if message n(including the header in bytes)
- *	m[n] is is aligned to a 4 byte boundary, hence
+ *	m[n] is aligned to a 4 byte boundary, hence
  *	  offset(m[0])	 := 0;
  *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
  *
-- 
2.48.1

