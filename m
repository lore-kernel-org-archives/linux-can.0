Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868E3D9DAC;
	Mon, 28 Sep 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600415; cv=none; b=E+ppWebzkiqvzJttTz86KFiV05e5imhqdYwRtubUd3d6jy7u+EAsqMl7TPGOqA43CnJzcuyeXI0Ubec3tPRwzxjdW/j9+b2gGe5LOH9UG0yg5kwgEVc7+VJyi8jVdfvWJMPP1fuQ+/i9xmUXRypdrDHUrpyafbA/f/Sq7RoYedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600415; c=relaxed/simple;
	bh=l/HPGKTm7HZ1KJE7OckzDeL7ku9p0tV9zaTdTNuKpKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQ/6METmKz9bS/n9LyYxfTpaY7JXqEa3zNZhzv46Tk64Moajmyc5sXgrd5iGpmZYewtLvt87CAk9LRZ5sboF3JiTYUUVMH04O25scuZPsyO3wJmfEXz+Romi7rBJq4Koa4/An8xDflpSED8k2xHvzObDTOqwXhnSYEATkuAb82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224A01F00893;
	Mon, 28 Sep 2026 13:00:09 +0000 (UTC)
Message-ID: <b9a686cf-0d28-4feb-b971-f1bf2264964f@linux-m68k.org>
Date: Mon, 28 Sep 2026 22:59:52 +1000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org>
 <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
 <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org>
 <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 24/9/26 00:15, Andrew Lunn wrote:
>> The driver will always need to support big and little endian hardware, so I
>> am not sure how to avoid some abstraction like this.
> 
> I was wondering if there is a linux standard set of macros which is
> supposed to handle this big/little difference, the macro knows the
> architecture and does the correct thing?

There is regmap, but that is way more than just access macros.
At least one driver shared across big and little endian architectures
does use that - the freescale dspi driver (drivers/spi/spi-fsl-dspi.c).
There is probably others.

If the issue is more to do with code churn then a simpler approach here
might be to just essentially keep the same work around but move it locally
into fec.h. Something like the patch below.

This could be cleaned up to use ioread32be()/iowrite32be() after the final
readl()/writel() changes have been applied.

Regards
Greg



diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7176803146f3..317e4e44d313 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -701,5 +701,16 @@ int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
 		struct netlink_ext_ack *extack);
 void fec_ptp_get(struct net_device *ndev, struct kernel_hwtstamp_config *config);
 
+/*
+ * ColdFire SoC peripheral blocks are big-endian, so use the raw IO access
+ * functions for them to access in correct byte order.
+ */
+#ifdef CONFIG_COLDFIRE
+#undef readl
+#define readl __raw_readl
+#undef writel
+#define writel __raw_writel
+#endif
+
 /****************************************************************************/
 #endif /* FEC_H */
