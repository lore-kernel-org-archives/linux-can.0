Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881734DF4D4;
	Mon,  7 Sep 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788605; cv=none; b=kDDblHXYfzvtpJPfCmYupTp+DyxKExUddaLRcWYlfgqOuP8gP5vxcmlSZZYVKq3xXbrhqU0qcX0/fNt+h0ngLqHwhw0+g30fICm+m19tC308lxk4eFddcvs4SsIi+fW6OXuL4PSn7qXGUKKiCyA1FznCDxHGl7iR5h6HbvDM8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788605; c=relaxed/simple;
	bh=JY8MJCrOdneS4zpYEd/8pbmHtAUq8HO3yw5auw8bhCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgXtgf5DlWcM7TuFOApPhZZPFWsuetok9QrmzciKREdCoz3jX7dIhHdsc0Yf826FPjkqfiN8ZWYnS3t/OBe+uZxYBoxTSwoMDwSifSC2BwdYrcK5eT9gTqphp4sSfAMLLorZ1skV6g46DwR4MCRLQ9+zxuHp+neL0YumvmVeCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786EA1F00A3A;
	Mon,  7 Sep 2026 13:43:10 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	wei.fang@nxp.com,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	Greg Ungerer <gerg@linux-m68k.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCHv3 2/3] net: smc91x: do not use readw()/writew() on ColdFire platforms
Date: Mon,  7 Sep 2026 23:37:10 +1000
Message-ID: <20260907134037.1855408-3-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907134037.1855408-1-gerg@linux-m68k.org>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the access macros and functions used to access the smsc hardware
registers when used on ColdFire SoC platforms so they do not use readw()
or writew(), or derived functions like ioread16be() and iowrite16be().

The current set of readX()/writeX() access methods for ColdFire have
historically been non-standard, in that they mostly access memory
big-endian instead of the expected little-endian. Before fixing the
ColdFire readX() and writeX() supporting code to properly work with
little-endian data existing driver uses need to be fixed. Convert the
smsc driver ColdFire uses of these to use the raw access macros - which
are well defined to be (native) big-endian on ColdFire. This change
requires some byte swapping at time of access to retain existing correct
behavior.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
v2: changed from RFC to PATCH
v3: no change

Resending with expanded CC list as per get_maintainers.pl, hoping to get
this picked up.

 drivers/net/ethernet/smsc/smc91x.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 38aa4374e813..1290335629c1 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -142,22 +142,26 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
 #define SMC_CAN_USE_32BIT	0
 #define SMC_NOWAIT		1
 
+/*
+ * Access SMSC device registers using raw IO access primitives. Byte
+ * swap as required for device registers, but not data.
+ */
 static inline void mcf_insw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
-		*wp++ = readw(a);
+		*wp++ = __raw_readw(a);
 }
 
 static inline void mcf_outsw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
-		writew(*wp++, a);
+		__raw_writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		ioread16be((a) + (r))
-#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
+#define SMC_inw(a, r)		swab16(__raw_readw((a) + (r)))
+#define SMC_outw(lp, v, a, r)	__raw_writew(swab16(v), (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
-- 
2.55.0

