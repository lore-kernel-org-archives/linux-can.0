From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] flex_can: Fix checking can_dlc
Date: Mon, 25 Dec 2017 12:58:56 +0100
Message-ID: <24ad57a6-bee8-1dad-8e74-7f68918aa81e@hartkopp.net>
References: <1513672833-28402-1-git-send-email-phu.luuan@nxp.com>
 <486344fc-f4cf-6311-ab83-ecf9958d16e9@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.179]:31245 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdLYL67 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Dec 2017 06:58:59 -0500
In-Reply-To: <486344fc-f4cf-6311-ab83-ecf9958d16e9@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luu An Phu <phu.luuan@nxp.com>, wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, stefan-gabriel.mirea@nxp.com

Answering myself after reading my own comment once more:

In fact the code fix seems to be correct but the commit comment was 
completely wrong which lead to my answer ...

can_dlc can hold values from 0 .. 8.

The first 4 bytes are placed in data[0..3]. When we have more(!) than 4 
bytes in can_dlc, the bytes 5..8 are placed in data[4..7].

The good thing was, that the current check was more conservative than 
your suggestion so that we did not detect any data loss.

Please send a V2 patch with corrected commit message.

Thanks,
Oliver

ps.

>> From: "phu.luuan" <phu.luuan@nxp.com>
>> + * Copyright 2017 NXP

A one-liner contribution like this tiny fix usually does not lead to an 
attribution in the copyrights. Your contribution is already perfectly 
recorded by the Signed-off-by tag.
