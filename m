Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1596429CD5
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800782; cv=none; b=XON/EaOCGz/eWfMXWS37CgPX5wZ5osyE8qseHcGtLyslEBBmtofx06mZm4K2AuG6rthT+qHz3tYQaiU8SPNuN2VTw87FaGl6rfqeNEkfM/S++3fba0kLS6Ul+r0hJ/F76CFEyFmT9sPxR954oPpwPQ7nFtevVL++HXjf3ShR6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800782; c=relaxed/simple;
	bh=GRrfxLRgNpKm6lsvifAkdPINzwR4tjY/umqSXWMqGeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvNb7Nf7viB62q6kPEQc5vv0DgZX4IMamUASfctOAuV+Fp0Ivi87bnr8T5hj/GdwtM4qG8ehFKN6t/MP98szPSkhgIJnrFEhw9j+16oYfj5CdoG5r99EhWldaJo/0gM0nLwjPyHda4+0vS5U/Mfo6SnavM/AFdK3RxavIq8EXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/iFvvXu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/iFvvXu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954afac04bso5133745e9.0
        for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784800779; x=1785405579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BrBCr7AbLc/6xolx1/6dBK5OEwK/e0MsPXsWHktbVcI=;
        b=n/iFvvXu9EBu14/PZpplrQX27zsaJuu2RfWmiJt5LiSvxKg7n92krtIY/pdE8FLxl1
         ELjF/JjHRw0NBh/HfDAWmt1Yy+rl1YrCiH+hVXgLTAMbGCEdrR8sqE+I+RuBDkQX4SaD
         rdEm02VpZEYlxTQ/T5mu7IrmmW+9A6InNvzUtwSdZxe+XWp3F2+Hf54pqtHUePQ1cbHr
         HfjK/b8X9djInZk3ITxDS4S8sziZ9LJ6POEfA8rhRt68obO37jGZjVmoa+BEfZOA+Tw8
         pBZNX+DBiYBSXeha9E/NQ8Z9rMczsms5gs1n/jZ7FPyd4km2LgVMos94qST5JtbsbI1a
         9lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800779; x=1785405579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrBCr7AbLc/6xolx1/6dBK5OEwK/e0MsPXsWHktbVcI=;
        b=TB5CQMguN9GDPw6RxQTWEqjJoovVZHXh6bTG36zf3EgYdW1oIyz2zcQp1SaTyM8Wkk
         OKFA2miPPcTYbyATJyhrPqZh+Mqw7iuy7nwV4+7fC8n6RfjKRiU2Hmf/NXd26x04AFfR
         PLKSALlye9WZNdf6HC62wJaxsObq/9dHZLID/SYR+7OuBTByqwvNa0609yeu8vobkTbA
         +J+RaGMqafk244t3Hu/VTKpK5r+xpC6tQ1o/nyflUZW4iz1XZojzSRry1rSpHup2VDAd
         +5yiBipMclipH06CWjcKcpXiIp+vhZg7MKOM1WDoczSHvKN813fWKo28msV7W82baNKG
         BEZQ==
X-Gm-Message-State: AOJu0YzTl5ho/5gNc75fVYvmM45trALugTes2cozG45wi0CWHOldZ4j0
	ZKJP0oJxBp0Cc0xMJNOK9hGUWI6f9J0qcEH9QEiosvKUmFQl1JxxGN31mzmchCZ3JhGKzw==
X-Gm-Gg: AR+sD12eiTHeuMG8KBxKiQr2qNpTwJsZMVCN7d1Du03g+PjPW2NYvqoQYBVzkIk2n/O
	qq+93388V+dC6YR1pUbafu7OfDGtUIuvKSzbL2mPSX1rDjNyksP4PBhAgMxHyRkX9CXuys3EA9M
	o+QeS6loJ2P2r8AwvcKSPYo75mzPBjZAnF40zIZwd5skzGMkKI6DlC88ZiIffo1xJGtfEfg1lOY
	WM1HbFf3f6eCnl9Th/xXrJvX2xa5LE71Eg8T4lSq+pn8teDfymCS2SWV64S/9ywN9OajuPdX7Ap
	j2ebsofaQsvMq5Fr3pqnGbJe0Eo1kANg4ghrEjUX1uymbWL0AHpx6o6AwIyGIY1uPJK2yBh4PTi
	MgjcB/R5oVF13a8enzMcwmoWh4MNhaZmnEvhhqhEj2hfeIL6Tfgr3lUhf3YVVVhXpyjFb523pha
	Aq8QS29MnDjMaO3wkJoWMSeVKDHM0=
X-Received: by 2002:a7b:cbda:0:b0:493:cd3f:d051 with SMTP id 5b1f17b1804b1-49573cffa67mr15330745e9.25.1784800778721;
        Thu, 23 Jul 2026 02:59:38 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:a638:2cd9:2446:f69e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm212315585e9.12.2026.07.23.02.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:59:38 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: linux-can@vger.kernel.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Martin Jerabek <martin.jerabek01@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] can: ctucanfd: unmap BAR0 using base address
Date: Thu, 23 Jul 2026 12:59:34 +0300
Message-ID: <20260723095934.181042-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BAR0 is mapped into bar0_base, while cra_addr points to an offset
within that mapping and is used for other purposes.

Pass bar0_base to pci_iounmap(), instead of cra_addr, on the probe error
path so the address returned by pci_iomap() is used for unmapping.

Fixes: 792a5b678e81 ("can: ctucanfd: CTU CAN FD open-source IP core - PCI bus support.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ctucanfd/ctucanfd_pci.c
index 625788fa8976..f845951c5d51 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
@@ -194,7 +194,7 @@ static int ctucan_pci_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, NULL);
 	kfree(bdata);
 err_pci_iounmap_bar0:
-	pci_iounmap(pdev, cra_addr);
+	pci_iounmap(pdev, bar0_base);
 err_pci_iounmap_bar1:
 	pci_iounmap(pdev, addr);
 err_release_regions:
-- 
2.43.0

