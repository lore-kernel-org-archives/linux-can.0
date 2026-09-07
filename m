Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26023C4F3;
	Mon,  7 Sep 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788521; cv=none; b=FE6k0jPHO/kV6g358wsSUGddFbuYFFyc+DwODCk2OWV8oUkCHUCGDn1eUYh27pcfp3wV/LXaXBrEGo12Eb3Aet5Pt6KHrFbEsui2k1wcXug5g9e2bWk6GNYTMAPTl3CQJ84NvZZZ1e1DqrrNY+8fw/g5U8r+p9Geo1L48wBtt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788521; c=relaxed/simple;
	bh=k2rKP7HwoQdmY5JKGHPxTdOnhTrrrC8ZlJgg1gEffT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAxg7ak20BAqYFor9k1E4sh2Y7P62UTBmXeSU6Xc0evhEgxaeWoIRVj1I6m7A1P9+l/GqooxriN/SPK3t83/6TrLqzAL7QHa/7/igNsNknBZZ24y1D9Gc+dd3R4iZKEXpP0KorfyQtVl09IE6YIqpyp4o6uGGTkQ6a1182CrhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC031F00A3A;
	Mon,  7 Sep 2026 13:41:57 +0000 (UTC)
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
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCHv3 0/3] m68k: coldfire: fix non-standard readX()/writeX() functions
Date: Mon,  7 Sep 2026 23:37:08 +1000
Message-ID: <20260907134037.1855408-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This collection of patches is aimed at fixing the non-standard ColdFire
set of readX()/writeX() IO access functions. Instead switching to using the
asm-generic definitions in include/asm-generic/io.h. The difficulty comes
in trying not to break any drivers with this change.

The implementation of the readX()/writeX() family of IO access functions
is non-standard on ColdFire platforms. They either return big-endian (that
is native endian) data, or on platforms with PCI bus support check the
supplied address and return either big or little endian data based on that
check. This is non-standard, they are expected to always return
little-endian byte ordered data. Unfortunately this behavior also means
that ioreadX()/iowroteX() and their big-endian counter parts
ioreadXbe()/iowriteXbe() are currently broken because they are implemented
using the readX()/writeX() functions.

Patches 1 and 2 in this series are specific net driver changes that can be
applied independently of the final ColdFire readX()/writeX() change.

Patch 3 is the actual switch to ColdFire building using asm-generic
readX()/writeX(), but also contains three driver fixes that are not easily
handled independently.

Note that I don't have access to all supported hardware needed to fully
test all these changes. I have tested what I have, a bunch of the standard
Freescale ColdFire eval boards, and inspected generated code for differences.

Note that the v1 and v2 versions of this series carried a change to the
sdhci-esdhc-mcf.c driver that is now in mainline - so dropped from this
current v3 series.

The v2 series moved from an RFC to a patch series. There was only minor
changes overall to address comments. Changes include formatting, separating
out the mcf5441x regmap in spi-fsl-dspi.c (patch 3) and reordering the
quirks in flexcan-core.c (patch 3).

This v3 series has no new code changes. It is sent with an expanded CC
list in the hope of getting the net driver changes (patches 1 and 2)
picked up so the final readl/writel fix (patch 3) that depends on them
can be applied.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/io_no.h             |   68 -------
 drivers/dma/mcf-edma-main.c               |   14 -
 drivers/net/can/flexcan/flexcan-core.c    |    1 
 drivers/net/ethernet/freescale/fec.h      |   15 +
 drivers/net/ethernet/freescale/fec_main.c |  257 +++++++++++++++---------------
 drivers/net/ethernet/freescale/fec_ptp.c  |   78 ++++-----
 drivers/net/ethernet/smsc/smc91x.h        |   12 -
 drivers/spi/spi-fsl-dspi.c                |   14 +
 8 files changed, 218 insertions(+), 241 deletions(-)


