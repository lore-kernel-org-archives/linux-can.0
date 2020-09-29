Return-Path: <SRS0=rWFP=DG=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F2C4727F
	for <linux-can@archiver.kernel.org>; Tue, 29 Sep 2020 12:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170AA2076A
	for <linux-can@archiver.kernel.org>; Tue, 29 Sep 2020 12:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=csselectronics.com header.i=@csselectronics.com header.b="YH2H+d+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgI2MY1 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:24:27 -0400
Received: from mailrelay2-2.pub.mailoutpod1-cph3.one.com ([46.30.212.1]:34227
        "EHLO mailrelay2-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732631AbgI2MYL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2020 08:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:to:
         subject:from:from;
        bh=rXnn6NQmcOZrsmVWClVmC+GgrQk/YCET9FP/ajCz558=;
        b=YH2H+d+o9L450aD5NMpeAYGSV/MxP1sPiIP0O5/Zo3S+twynUujeQ2pzHK9U1u3I4nIvt4naWxr2X
         hq5O461nWjFqfSNsSUrzShSgHhYKBGyECMMwPvdk8Naki1DfY5jFCGS44fwbzm1bCyDZX3260kpxrZ
         nr0krQPYs9dGl7ilWDcDgOpf+StsFTZp83NmL73qitZJCLM4ItA8Cr5FN4U5ADqpkr8/2rrSxaEB3v
         8I/XQWyU9MugYS/Lbxk40aozU/gZ4QaqEQjn+/U6nOB9AiAjyqLumUAVkgD1K4PmcOpvLWYVMK5/yi
         40XENHNgKgoK8ct4viVfl9n5VrjEQTA==
X-HalOne-Cookie: 71ba302a6b4e5c894ed70784b544aa818a768646
X-HalOne-ID: e825ee8d-0243-11eb-84a6-d0431ea8a290
Received: from [192.168.0.157] (unknown [5.103.118.41])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id e825ee8d-0243-11eb-84a6-d0431ea8a290;
        Tue, 29 Sep 2020 11:07:04 +0000 (UTC)
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Subject: mcp25xxfd driver questions
To:     linux-can@vger.kernel.org
Message-ID: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
Date:   Tue, 29 Sep 2020 13:07:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is my first post to the list, so please inform me of any errors in 
etiquette.

I'm evaluating the MCP2518FD, and have two questions to the driver.

1. I could not find any references to the GPIOs of the chip. Is it 
correct that these are not exposed to the host system?

2. When setting the oscillator frequency outside the 
MCP25XXFD_SYSCLOCK_HZ_MIN and MCP25XXFD_SYSCLOCK_HZ_MAX range, the 
frequency is compared to the max value scaled by the max PLL value. Is 
the intention to compare with the min value? Currently, an external 
oscillator of 4 MHz and a PLL value of 10, resulting in 40 MHz, is 
treated as being too low.

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c 
b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index bd2ba981ae36..9e0246c4e49f 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -2770,7 +2770,7 @@ static int mcp25xxfd_probe(struct spi_device *spi)
          return -ERANGE;
      }

-    if (freq <= MCP25XXFD_SYSCLOCK_HZ_MAX / MCP25XXFD_OSC_PLL_MULTIPLIER) {
+    if (freq <= MCP25XXFD_SYSCLOCK_HZ_MIN / MCP25XXFD_OSC_PLL_MULTIPLIER) {
          dev_err(&spi->dev,
              "Oscillator frequency (%u Hz) is too low and PLL is not 
supported.\n",
              freq);

Regards, Magnus.



